# Windows Disk Cleaner

1. Open _Command Prompt_ `cmd` as administrator
1. Set a profile for cleaning

        cleanmgr /sageset:0

1. Select categories that will be cleaned
1. Confirm settings by clicking on _OK_
1. In the already opened admin _Command Prompt_ run a command that will clean all categories specified in the profile

        cleanmgr /sagerun:0

1. Verify whether the files were really cleaned

    1. Go to _This computer -> Right click on disk -> Cleanup -> System files cleanup_

    1. If the category is not checked, open _Windows Registry_ `regedit` as administrator

    1. Go to `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches`

    1. Add an entry to the category
      - _New -> DWORD_
      - Name it `StateFlags`
      - Set value to `0`

1. Open _Disk Cleanup_ again. The category will now be checked.

And then maybe [Windows 10 Debloater](https://github.com/Sycnex/Windows10Debloater)

## Sources

- https://ss64.com/nt/cleanmgr.html
- https://ss64.com/nt/cleanmgr-registry.html
- https://answers.microsoft.com/en-us/windows/forum/all/cleanmgr-sageset-and-sagerun/f58f131f-ddd4-4e61-a013-0fe745204234
- https://www.sevenforums.com/tutorials/76383-disk-cleanup-extended.html
- https://zamarax.com/2020/08/26/how-to-run-disk-cleanup-cleanmgr-exe-on-windows-server-2016-2012-r2-2008-r2/
- https://ss64.com/nt/runas.html
- https://superuser.com/questions/42537/is-there-any-sudo-command-for-windows/42540#42540
- https://www.windows-commandline.com/windows-runas-command-prompt/

