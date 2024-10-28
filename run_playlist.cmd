SET "script_dir=C:\Users\Kristian\Documents\yt-playlist\YT-playlist_downloader\" 
@echo off 
REM Activate the virtual environment 
CALL "venv\Scripts\activate.bat" 
REM Run the Python playlist downloader script 
python "playlist_downloader.py" 
REM Optional pause for troubleshooting 
PAUSE 
