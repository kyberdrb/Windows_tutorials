# Windows Disk Cleaner

An utility for automatic cleaning of safe files.

## Dependencies / Prerequisites

[gsudo]()

Reboot after installation, although it's not requested in the installation wizard.


### `gsudo` configuration

**Enable password cache to prolong duration validity of sudo password.**

For convenience.

Execute these commands in Git Bash, **cmd** or PowerShell

    gsudo config CacheMode auto
    gsudo config CacheDuration "3:00:00"
    gsudo cache off
    gsudo --reset-timestamp
    gsudo cache on
	
From now on you will not be annoyed with UAC password prompt at every `gsudo` invocation.

## Usage

1. Open _Command Prompt_

        cmd
		
1. Change to the directory with this script, e.g.

        cd C:\Users\%USERNAME%\git\Windows_tutorials\windows_cleaner

1. Set cleanup parameters

        windows_cleaner-set_parameters.cmd

    Selected categories that will be cleaned.
	
    Confirm settings by clicking on _OK_
	
	Repeat this step for the cleanup with administrator priviledges - more thorough cleaning
	
1. Start the cleaning

        windows_cleaner-clean.cmd

    The cleaning may take some time.

## Notes

- Verify whether the files were really cleaned

    1. Go to _This computer -> Right click on disk -> Cleanup -> System files cleanup_

    1. If the category is not checked, open _Windows Registry_ `regedit` as administrator

    1. Go to `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches`

    1. Add an entry to the category
      - _New -> DWORD_
      - Name it `StateFlags`
      - Set value to `0`

	Open _Disk Cleanup_ again. Selected categories will now be checked.

And then maybe run [Windows 10 Debloater](https://github.com/Sycnex/Windows10Debloater)

## Sources

- https://ss64.com/nt/cleanmgr.html
- https://ss64.com/nt/cleanmgr-registry.html
- https://answers.microsoft.com/en-us/windows/forum/all/cleanmgr-sageset-and-sagerun/f58f131f-ddd4-4e61-a013-0fe745204234
- https://www.sevenforums.com/tutorials/76383-disk-cleanup-extended.html
- https://zamarax.com/2020/08/26/how-to-run-disk-cleanup-cleanmgr-exe-on-windows-server-2016-2012-r2-2008-r2/
- https://ss64.com/nt/runas.html
- https://superuser.com/questions/42537/is-there-any-sudo-command-for-windows/42540#42540
- https://www.windows-commandline.com/windows-runas-command-prompt/
- https://answers.microsoft.com/en-us/windows/forum/windows_10-windows_install/how-to-elevate-to-administrator-from-cmd-prompt/cefedf35-7409-4f24-b30a-f1ab363fa97e
- https://superuser.com/questions/735457/elevate-cmd-to-admin-with-command-prompt
- https://superuser.com/questions/1381355/sudo-equivalent-on-windows-cmd
- https://github.com/gerardog/gsudo
