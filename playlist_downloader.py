from pytubefix import Playlist, YouTube
from pytubefix.cli import on_progress
from math import ceil
import sys
import threading
import logging
import os
import imageio
import subprocess

log = logging.getLogger("__name__")
current_dir = os.path.dirname(__file__)

# Use the imageio package to get the path to the installed ffmpeg
ffmpeg_path = imageio.plugins.ffmpeg.get_exe()

size = 0


def process_playlist(playlist_url):
    try:
        p = Playlist(playlist_url)
        print(f"\nPlaylist Name: {p.title}\nChannel Name: {p.owner}\nTotal Videos: {p.length}")
        
        # Create directory for downloaded files, sanitizing title for paths
        dir_name = p.title.replace(" ", "_")
        directory = os.path.join(current_dir, dir_name)
        os.makedirs(directory, exist_ok=True)

        # Get a set of existing video IDs in the directory
        files = set(os.listdir(directory))
        yt_prefixes = {url.split('=')[-1] for url in p.video_urls}
        
        # Delete local videos not present in the current playlist
        for file in files:
            file_id = file.split(' ')[0]
            if file_id not in yt_prefixes:
                os.remove(os.path.join(directory, file))
                print(f"Deleted local video: {file}")

        # Get links for new videos
        links = [url for url in p.video_urls if url.split("=")[-1] not in {file.split(" ")[0] for file in files}]

        if links:
            size = ceil(len(links) / 4)

            def downloader(links):
                for url in links:
                    try:
                        video_id = url.split('=')[-1]
                        
                        # Download video
                        yt = YouTube(url)
                        ys = yt.streams.filter(adaptive=True, mime_type='video/webm').order_by('resolution').desc().first()

                        if ys is None:
                            ys = yt.streams.filter(progressive=False, mime_type='video/mp4').order_by('resolution').desc().first()
                            video_filename = video_id + "_video" + ".mp4"
                        else:
                            video_filename = video_id + "_video" + ".webm"
                        
                        video_filepath = ys.download(directory, filename=video_filename)
                        cleared_video_name = os.path.splitext(video_filename)[0]
                        
                        # Download audio stream
                        audio_ys = yt.streams.filter(only_audio=True).order_by('abr').desc().first()
                        audio_filename = video_id + "_audio" + ".webm"
                        audio_filepath = audio_ys.download(directory, filename=audio_filename)
                        cleared_audio_name = os.path.splitext(audio_filename)[0]
                        
                        # Merge video and audio using ffmpeg
                        output_filename = video_id + "_output.mp4"
                        output_path = os.path.join(directory, output_filename)

                        # Use subprocess to handle ffmpeg command safely
                        ffmpeg_command = [
                            ffmpeg_path,
                            '-i', video_filepath,
                            '-i', audio_filepath,
                            '-c', 'copy',
                            '-strict', '-2',
                            output_path
                        ]

                        # Running ffmpeg command
                        subprocess.run(ffmpeg_command, check=True)

                        formated_path = os.path.join(directory, f"{video_id} output.mp4")
                        os.rename(output_path, formated_path)

                        # Clean up temporary video and audio files
                        os.remove(audio_filepath)
                        os.remove(video_filepath)

                        print(f"Video downloaded and merged with audio: {output_filename}")
                    
                    except Exception as e:
                        print(f"Failed to download or merge video {url}: {e}")

            # Split the links into chunks for threading
            splitter = [links[i:i + size] for i in range(0, len(links), size)]
            print(f"Processing video in chunks: {splitter}")

            threads = []
            for chunk in splitter:
                t = threading.Thread(target=downloader, args=(chunk,))
                threads.append(t)
                
            # Start threads
            for t in threads:
                t.start()

        else:
            print("No new videos found in playlist.")

    except Exception as e:
        print(f'Failed to process playlist {playlist_url}: {e}')


if __name__ == "__main__": 
    playlists = [
        "https://youtube.com/playlist?list=PLFdHTR758BvdEXF1tZ_3g8glRuev6EC6U",
        "https://youtube.com/playlist?list=PLFdHTR758Bvd9c7dKV-ZZFQ1jg30ahHFq"
    ]

    for playlist_url in playlists:
        process_playlist(playlist_url)

