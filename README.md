
Here’s the documentation rewritten in plain text format, ideal for a GitHub README with straightforward line-by-line steps:

YouTube Playlist Downloader Setup
Clone the Repository
In the directory where you want the downloader to be located, run:

bash
Copy code
git clone https://github.com/kuskryptus/YT-playlist_downloader.git
Run the Setup Script

Open the YT-playlist_downloader folder.
Double-click setup.bat to start the setup.
Setup Actions (automated in setup.bat)

Detects the current folder path.
Copies run_playlist.cmd to the Windows Startup folder (enables auto-run on startup).
Creates a virtual environment (if not already created).
Installs required dependencies:
pytubefix
imageio[ffmpeg]
Automatic Start
After setup, the downloader will automatically run on every PC restart.

Manual Run
To start manually, double-click run_playlist.cmd in the installation folder.
