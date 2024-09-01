1. Download Windows ISO
1. Extract the ISO to NTFS formatted USB drive with GPT partition table
1. Make the USB bootable with `ms-sys`

    pikaur -Sy ms-sys
    sudo ms-sys -7 /dev/sdX
    sudo ms-sys -n /dev/sdX1

1. Boot from the USB

- https://www.microsoft.com/software-download/windows11
- https://www.microsoft.com/en-us/software-download/windows10ISO?ranMID=24542&ranEAID=2QzUaswX1as&ranSiteID=2QzUaswX1as-_o1Ud9PeugoOv5O.P61qkw&epi=2QzUaswX1as-_o1Ud9PeugoOv5O.P61qkw&irgwc=1
- https://duckduckgo.com/?q=create+windows+10+bootable+usb+linux+mbr&ia=web
- https://www.cyberciti.biz/faq/create-a-bootable-windows-10-usb-in-linux/
- https://superuser.com/questions/1099026/how-to-create-mbr-bootable-windows-usb-installer-from-linux
- https://thornelabs.net/posts/create-a-bootable-windows-7-or-10-usb-drive-in-linux/
- aur.archlinux.org/packages/ms-sys
- https://aur.archlinux.org/packages/windows2usb
- rufus.ie/en/
- duckduckgo.com/?q=fdisk+ID+column&ia=web
- duckduckgo.com/?q=fdisk+ef+id&ia=web
- askubuntu.com/questions/175739/how-do-i-remount-a-filesystem-as-read-write/175742#175742

