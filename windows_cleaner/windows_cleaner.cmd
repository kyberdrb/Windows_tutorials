REM Try 'nircmd', 'psexec' or 'gsudo' to elevate priviledges 
REM  for cleaning up the system files, instead of 'runas' or 
REM  'powershell' - for compatibility with Windows 
REM  systems without PowerShell
REM  - https://www.nirsoft.net/utils/nircmd.html
REM  - https://docs.microsoft.com/en-us/sysinternals/downloads/psexec
REM  - https://github.com/gerardog/gsudo

cleanmgr /SAGESET:0
REM runas /noprofile /user:ClickMe "cleanmgr /SAGESET:0"
powershell -Command "Start-Process cleanmgr /SAGESET:0 -Verb RunAs"

cleanmgr /SAGERUN:0
REM runas /noprofile /user:ClickMe "cleanmgr /SAGERUN:0"
powershell -Command "Start-Process cleanmgr /SAGERUN:0 -Verb RunAs"
