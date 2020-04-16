# Reset Forgotten Password For Local Accounts Including Administrator

- To recover an online account you need to recover it from the bound email address.

1. Boot from Windows USB
1. In the installation windows click on _Next_
1. Click on _Repair your computer_
1. Click on _Troubleshoot_
1. Click on _Command Line_
1. List availible drives and partitions

        X:\ diskpart
        DISKPART> list volume

1. Find the partition letter with the Windows operating system in the output
1. Navigate to this partition

        X:\ e:
        E:\

1. Navigate to the _System32_ directory

        E:\ cd Windows\System32
        E:\Windows\System32\

1. Back up original `Utilman.exe` utility (Ease of Access)

        rename Utilman.exe Utilman.exe.bak

1. Copy `cmd.exe` (Command Prompt) into the same directory as a new, masked `Utilman.exe`

        copy cmd.exe Utilman.exe

1. Restart the computer

        shutdown /r /t 0

    Remove the installation media before the boot screen appears

1. On the login screen click on the icon of the _Ease of Access_ in the lower left corner. The _Command Prompt_ masked as a `Utilman.exe` window will appear.

    - If you have been logged in automatically, log out and open the utility on the login screen

1. Show list of accounts

        net user

1. Find the account name you want to change the password for

1. Change the password for the selected user

        net user USERNAME "NEW PASSWORD"

    If the password consists of multiple words, the entire password needs to be wrapped into double quotes, in order to be considered as a single argument

1. _**[OPTIONAL]**_ If we changed the password for the administrator account, we need to refresh the administrator role of the administrator account

        net user administrator /active:yes

1. Test the changed password
    - Log into the account which password we've changed
    - Open any utility that requires administrator privileges

    When the tests ran successfully we can proceed to the final step.

1. Restart the computer.
    
    Before or at the boot screen insert the Windows installation media

1. Boot from the installation media, e.g. by invoking _Boot Menu (F12)_
1. Open the _Command Prompt_ as before
1. Restore the backed up `Utilman.exe`

        X:\ e:
        E:\ cd Windows\System32\
        rename Utilman.exe Utilman.exe.bak
        shutdown /s /t 0

    The computer will shut down.

1. After the computer is shut down, remove the installation media

1. Start the computer.
1. Log in to your account.

## Sources

- [Windows 8 / 8.1 - Reset Forgotten Password Including Administrator [Tutorial]](https://www.youtube.com/watch?v=hXpyJCyeyuo)
- https://docs.microsoft.com/en-us/windows-server/storage/disk-management/assign-a-mount-point-folder-path-to-a-drive