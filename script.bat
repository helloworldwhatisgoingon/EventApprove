@echo off
REM Extract the Ethernet IPv4 address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /C:"IPv4 Address"') do (
    if not defined ip set ip=%%a
)
set ip=%ip:~1%

REM Copy the IP address to clipboard
echo %ip% | clip

REM Launch the Flutter app (hod_app.exe)
start "" "C:\Program Files (x86)\Your Company\Your Application\Release\hod_app.exe"

REM Run the Python server with the extracted IP as an argument
python "C:\Users\DSUCSCL9-32\Downloads\EventApprove-main\EventApprove-main\server\run.py"

REM Run the Python script to paste the IP address
python "C:\Users\DSUCSCL9-32\Desktop\paste_ip.py" %ip%

REM Notify the user
echo The IPv4 address %ip% has been copied to the clipboard and pasted automatically into the "Server IP Address" field.
pause

