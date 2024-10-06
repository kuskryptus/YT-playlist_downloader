@echo off
REM Step 1: Detect the current directory
SET "current_dir=%~dp0"

REM Step 2: Define the path to the Windows Startup folder
SET "startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

REM Step 3: Copy run_playlist.cmd to the Startup folder
IF EXIST "%current_dir%run_playlist.cmd" (
    COPY "%current_dir%run_playlist.cmd" "%startup_folder%"
    ECHO Copied run_playlist.cmd to startup folder.
) ELSE (
    ECHO run_playlist.cmd not found in %current_dir%
)

REM Step 4: Create a virtual environment if it doesn't exist
IF NOT EXIST "%current_dir%venv" (
    ECHO Creating virtual environment...
    python -m venv "%current_dir%venv"
) ELSE (
    ECHO Virtual environment already exists.
)

REM Step 5: Activate the virtual environment
CALL "%current_dir%venv\Scripts\activate.bat"

REM Step 6: Install pytubefix inside the virtual environment
ECHO Installing pytubefix...
pip install pytubefix

pip install imageio[ffmpeg]

ECHO Setup is complete!
PAUSE
