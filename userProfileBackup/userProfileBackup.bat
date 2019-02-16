set "SUCCESS=0"

:main
    rem TODO - break down into function calls

:notifyAboutBackupStart
    rem TODO - duplicate code
    rem ... move into another function
    rem ... see :notifyAboutBackupFinish
    echo %time%
    echo Starting backup...

:removeDestinationDir
    echo %time%
    rd "d:\Users\%username%" /s /q
    echo %time%

:backup
    rem TODO - parametrize source and destination
    xcopy "c:\Users\%username%" "d:\Users\%username%" /e /v /c /i /f /g /h /r /y /b /j

    echo %time%

    if not "%ERRORLEVEL%" == "%SUCCESS%" (
        echo Error during backup...: %ERRORLEVEL%

        echo %time%

        rem TODO - magic number
        rem ... make a constant with meaningful name
        exit /b 1
    )

:notifyAboutBackupFinish
    rem TODO - duplicate code
    rem ... move into another function
    rem ... see :notifyAboutBackupStart
    echo %time%
    echo Backup successfully 

exit /b %ERRORLEVEL%
