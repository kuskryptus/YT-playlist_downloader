@echo off
SET "current_dir=%~dp0"

echo SET "script_dir=%current_dir%" > "%current_dir%run_playlist.cmd"
echo @echo off >> "%current_dir%run_playlist.cmd"
echo REM Activate the virtual environment >> "%current_dir%run_playlist.cmd"
echo CALL "%script_dir%venv\Scripts\activate.bat" >> "%current_dir%run_playlist.cmd"
echo REM Run the Python playlist downloader script >> "%current_dir%run_playlist.cmd"
echo python "%script_dir%playlist_downloader.py" >> "%current_dir%run_playlist.cmd"
echo REM Optional pause for troubleshooting >> "%current_dir%run_playlist.cmd"
echo PAUSE >> "%current_dir%run_playlist.cmd"

REM Step 3: Define the path to the Windows Startup folder
SET "startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

REM Step 4: Copy run_playlist.cmd to the Startup folder
IF EXIST "%current_dir%run_playlist.cmd" (
    COPY "%current_dir%run_playlist.cmd" "%startup_folder%"
    ECHO Copied run_playlist.cmd to startup folder.
) ELSE (
    ECHO run_playlist.cmd not found in %current_dir%
)

REM Step 5: Create a virtual environment if it doesn't exist
IF NOT EXIST "%current_dir%venv" (
    ECHO Creating virtual environment...
    python -m venv "%current_dir%venv"
) ELSE (
    ECHO Virtual environment already exists.
)

REM Step 6: Activate the virtual environment
CALL "%current_dir%venv\Scripts\activate.bat"

REM Step 7: Install required packages inside the virtual environment
ECHO Installing dependencies...
pip install pytubefix
pip install imageio[ffmpeg]

