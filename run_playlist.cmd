@echo off 
SET "script_dir=C:\Users\Kristian\Documents\yt-playlist\YT-playlist_downloader" 
REM Navigate to the script directory 
cd /d "%script_dir%" 
REM Activate the virtual environment 
CALL "%script_dir%\venv\Scripts\activate.bat" 
REM Run the Python playlist downloader script 
python "%script_dir%\playlist_downloader.py" 
REM Optional pause for troubleshooting 
PAUSE 
