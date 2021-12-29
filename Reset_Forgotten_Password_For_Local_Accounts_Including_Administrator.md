# Reset Forgotten Password For Local Accounts Including Administrator

This tutorial shows how to reset the password of an *offline* Windows account.

To recover an online account you need to recover it from the bound email address with the help of a phone, another computer or use a PIN.

## (Kali) Linux

1. Create Kali Linux USB (either with `Linux Live Creator - LiLi` - or with `dd` command from Linux, or with `Etcher`)
1. Boot the USB
1. Mount the Windows partition by double-clicking on it on the desktop.
1. In the Kali Linux desktop run the Terminal.
1. Navigate to the Windows partition's directory - copy the path to the drive and paste it to the terminal [Ctrl+Shift+V]

        cd MOUNT_POINT_TO_THE_PARTITION

1. Execute `cd Windows/System32/config`
1. Run `chntpw -l SAM`

    `SAM` is the file containing the info about user accounts and some registry entries.

    Find the name of the account that you want to reset the password of.
1. Execute `chntpw -u USERNAME SAM` where USERNAME is the chosen name of the account we want to reset the password of.

1. Press `1` for clearing the previously set Windows password.
1. Press `q` for exitting the utility. Press `y` to confirm saving changes.
1. Reboot
1. Log in the account you had changed the password of. You'll be logged in without password prompt.
1. Now you can change the password to this account if you want to. 

Sources:
- https://www.top-password.com/knowledge/reset-windows-10-password-with-kali-linux.html

## Windows Installation USB

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

    Now we have (at least) two ways how to change the password of the chosen account: `net user` or `control userpasswords2`.

    **`net user`**:

    1. Show list of accounts

            net user

    1. Find the account name you want to change the password for

    1. Change the password for the selected user

            net user USERNAME "NEW PASSWORD"

        If the password consists of multiple words, the entire password needs to be wrapped into double quotes, in order to be considered as a single argument

    1. _**[OPTIONAL]**_ If we changed the password for the administrator account, we need to refresh the administrator role of the administrator account

            net user administrator /active:yes

    **`control userpasswords2`**:
    
    1. Open the _User Accounts_ window

            control userpasswords2

    1. Click on the account you want to reset the password of.
    1. Click on the button _Reset Password..._
    1. Enter new password for that account.
    1. Close everything with _OK_

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
- https://www.ghacks.net/2019/01/07/how-to-reset-windows-10-account-passwords/
- https://www.hitutorials.com/windows-10-password-reset-method-with-command-prompt/

