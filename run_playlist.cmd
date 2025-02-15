@echo off

REM Step 1: Get the user's Desktop directory using %USERPROFILE%
SET "desktop_path=%USERPROFILE%\Desktop"

REM Step 2: Navigate to the YT-playlist-dwnloader folder
CD /D "%desktop_path%\YT-playlist-dwnloader"

REM Step 3: Activate the virtual environment (assumes it's in the same folder)
CALL venv\Scripts\activate.bat

REM Step 4: Run the playlist_downloader.py script
python playlist_downloader.py

REM Step 5: Pause the script to keep the window open (optional)