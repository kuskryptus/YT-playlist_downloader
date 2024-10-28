
YouTube Playlist Downloader Setup

1.Clone the Repository
  In the directory where you want the downloader to be located, run:

    git clone https://github.com/kuskryptus/YT-playlist_downloader.git

2.Run the Setup Script

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
