@ECHO OFF
echo.
echo.
echo ==========================================
echo Simple Script to Restart Windows Explorer
echo.
echo Created by "Vishal Gupta" for AskVG.com
echo ==========================================
echo.
echo.
echo STEP 1: Closing Explorer . . .
echo.
TASKKILL /F /IM explorer.exe
echo.
echo.
echo STEP 2: Starting Explorer . . .
start "explorer" "C:\Windows\explorer.exe"
echo.
echo SUCCESS: Explorer is running.
echo.
echo.
PAUSE