# Activated Windows and Office as a Precious Gift

## Install Windows

See my guide at TODO link

Immediately after installation I recommend you to go back to this guide and activate Windows and Office, to enjoy fully functional operating system and software.

## [OPTIONAL] Create VirtualBox virtual machine with Alpine Linux and KMS server as a Docker container within Alpine Linux (Win 7, 8, 8.1 only)

### VirtualBox

1. Go to https://www.virtualbox.org/wiki/Downloads
1. Download
  - VirtualBox for `Windows hosts` under section `VirtualBox <version> platform packages`  
  [at the time of writing the link for VirtualBox installer for Windows iwas https://download.virtualbox.org/virtualbox/6.1.30/VirtualBox-6.1.30-148432-Win.exe]
  - [OPTIONAL BUT RECOMMENDED] Extension pack to extend virtual machine functionalities under section `VirtualBox <version> Oracle VM VirtualBox Extension Pack`  
  [at the time of writing the link for VirtualBox Extension Pack was https://download.virtualbox.org/virtualbox/6.1.30/Oracle_VM_VirtualBox_Extension_Pack-6.1.30.vbox-extpack]
1. Install VirtualBox
1. Install Extension Pack

### Create virtual machine in VirtualBox

The virtual machine will serve as a KMS server.

I decided to go with Alpine Linux for its low RAM usage, CPU usage and disk space requirements, as in my view is very lightweight: ~50MB RAM usage, ~600MB (maybe less) occupied disk space.

1. Go to https://www.alpinelinux.org/downloads/
1. Download the ISO file of Alpine Linux `VIRTUAL` version for `x86_64` architecture (assuming you have 64 bit operating system.  
[at the time of writing, the link to 64 bit VIRTUAL version of Alpine Linux was https://dl-cdn.alpinelinux.org/alpine/v3.15/releases/x86_64/alpine-virt-3.15.0-x86_64.iso]
If you're not sure, right click on `This PC` on desktop, select `Properties`. Next to `System type` make sure it states `64-bit Operating System, x64-based processor`)
1. Open VirtualBox (if it's not already)
1. To create a new virtual machine, click on `New` button. Enter these parameters (with the help of https://wiki.alpinelinux.org/wiki/Install_Alpine_on_VirtualBox#Setting_up_virtual_PC):
  - Name: `KMS server`
  - Type: `Linux`
  - Version: Other Linux (64-bit)
  - Memory size: 256MB
  - In the `Hard disk` section select `Create a virtual hard disk now`.  
    A dialog window `Create Virtual Hard Disk` pops up.
    - In the section `File size` enter `1,00 GB`
    - In the section `Hard disk file type` select `QCOW (QEMU Copy-On-Write)`
1. Click on `Create` button. A new entry will appear in the column on the right hand side with the list of virtual machines. Left-click on it.
1. In the top part of the righ-hand side click on `Settings` button. Change these settings:
  - Storage
    1. In section `Storage Devices` left-click on the icon of `CD`
    1. On the right-hand side click on the icon of `CD with triangle poiting downwards`. From the dropdown menu select `Choose a disk file...`  
    A dialog window with file explorer pops up.
    1. Browse for the ISO file where you downloaded/moved it. Then double-click on the ISO file.
  - Network
    1. click on tab `Adapter 1`, if it's not open already
    1. Select these parameters for the network adapter `Adapter 1`
      - Attached to: `NAT`
        - at first I want the virtual machine to be connected to the internet in order to download updates and `docker`, which NAT attached network adapter does excellently
      - Adapter Type: `Intel PRO/1000 MT Desktop (82540EM)`
      - Check `Cable Connected`
1. Confirm changes by clicking on `OK` button.
1. Start the virtual machine by clicking on the `Start` button with a green arrow pointing to the right.
  1. Wait for the operating system to boot.
  1. At the login screen type `root` as Username and press `Enter` at Password prompt, as the `root` user as empty password by default.
  1. Install Alpine Linux to the virtual drive executing command
  
          setup-alpine
  
  1. Then follow the instructions on the screen. When you're not sure or want explenations of the options, press `?` and then `Enter` which shows you help for current question. I selected these settings:
    1. TODO my setup settings and choices
    1. System disk mode
    1. Europe
    1. Bratislava
    1. empty password for the root user
  1. After the installation is done, shutdown the virtual machine by executing the `poweroff` command.
1. Click on the `Settings` button for the `KVM server` virtual machine again.
1. Go to `Storage`, left-click on the icon of the `CD`, then on the right-hand side click on the icon of CD with a triangle pointing downwards, and choose `Remove Disk from Virtual Drive`
1. Start the virtual machine again.
1. Log in with the Username `root` and an empty password.

## Install Docker

### Alpine Linux

according to https://wiki.alpinelinux.org/wiki/Docker

1. Enable `community` repository. Uncomment `community` repo in `repositories`

        

1. Refresh package list from all repositories and install latest updates.

        apk update
        apk upgrade
        
1. Install docker

        apk add docker
  
1. Add current user to the `docker` group. Although it's probably intended for the regular users to launch containers, not for the root user, who can start any container.

        addgroup $USER docker
        
1. Start docker service at boot

        rc-update add docker boot
        
1. Start docker service now

        service docker start

1. Shutdown the virtual machine

        poweroff
        
1. TODO change the Adapter 1 from NAT to Host-only. [TODO or maybe use Port-Forwarding on the NAT adapter]

### Windows 10 and newer

1. Go to https://www.docker.com/products/docker-desktop
1. Download `Docker Desktop` by clicking on the button `Download for Windows`
1. Install `Docker Desktop` from downloaded file.

## Configure the Docker container with KMS server
  
1. Within the environment pull the KMS server Docker container with command

        docker pull mikolatero/vlmcsd
        
    according to https://hub.docker.com/r/mikolatero/vlmcsd/
        
1. Start the KMS server Docker container

        docker run -d -p 1688:1688 --restart=always --name vlmcsd mikolatero/vlmcsd
        
    TCP port 1688 is the port of KMS communication
        
1. Check the logs with

        docker logs vlmcsd
        
    or maybe more convenient with scrollable output with newest entries on top
    
        docker logs vlmcsd | tac | less
        
        # https://www.baeldung.com/linux/reverse-order-of-file-lines
        
    whether the container started the server
    
1. Check open ports with

        netstat -plantu
        
    whether the TCP port `1688` is in `LISTEN` state for IPv4 addresses - and thus the KMS server in Docker container listens for incoming requests.

## Configure Windows Firewall

1. Open `Windows Firewall` either with pressing `Win+R` and typing

        firewall.cpl
        
    [Enter] :P  
    or via searching for `firewall` and clicking on `Windows Firewall` app  
    or via `control panel -> Windows Firewall`
1. In the panel on the left-hand side click on `Advanced settings`. Enter administrator's password when prompted.
1. In the left panel click on `Inbound Rules`
  1. For convenience sort the rules by name by clicking at the `Name` column.
  1. Search for rules named `Key Management Service (TCP-In)`. In my case I have one rule for `Private, Public` networks and one for `Domain` network.
  1. Make sure that all of `Key Management Service (TCP-In)` rules are enabled [marked with a white checkmark in a green circle]
1. [OPTIONAL? TODO Test the activation without this rule] In the left panel click on `Outbound Rules`
  1. For convenience sort the rules by name by clicking at the `Name` column.
  1. Search for rules named `Key Management Service (TCP-In)`. In my case I didn't have any rule with this name or any outbound rule associated with a remote TCP port 1688, so we create one, in order to send activation requests to our local KMS server in a Docker container (maybe in a virtualized Alpine Linux system in VirtualBox :P )
  1. In the panel on the right-hand side, click at the `New rule` entry (at the top). A dialog `New Outbound Rule Wizard` pops up.
    1. Select `Port`. Click on `Next`
    1. Select `TCP`  
      In the text field next to `Specific remote ports` enter number `1688` which is the port of KMS communication.
    1. Select `Allow the connection`
    1. Check all three ranges `Domain`, `Private` and `Public`.
    1. Enter name: `Key Management Service (TCP-out)`  
      Enter decription: `Key Management Service`
    1. Click on `Finish` button. The rule is now active and added to the list of rules.

1. While the KMS server in a Docker container is running, test that KMS communication passes through. Open PowerShell and test that TCP port 1688 is open
    
        Test-NetConnection -ComputerName 192.168.56.101 -Port 1688
        
    (according to https://sid-500.com/2018/02/02/powershell-test-open-tcp-ports-with-test-openport-multiple-hosts-multiple-port-numbers/)
    
    When the KMS port 1688 is open and the communication passes through, you might see similar output like this

        ComputerName           : 192.168.56.101
        RemoteAddress          : 192.168.56.101
        RemotePort             : 1688
        InterfaceAlias         : VirtualBox Host-Only Network
        SourceAddress          : 192.168.56.1
        PingSucceeded          : True
        PingReplyDetails (RTT) : 0 ms
        TcpTestSucceeded       : True
        
    The entry `TcpTestSucceeded       : True` indicates that the local KMS port for incoming and outgoing KMS communication are open and the remote port on the KMS server in the Docker container is also open in both directions and available to receive activation requests.
    
Let's go activate things...

## Install Microsof Office

Make sure the Microsoft Office suite is in `Volume License` (`VL`) version, otherwise the KMS activation might not work. [TODO test whether it's really true for retail versions of MS Office]

- The latest version of MS Office for Windows 8 and 8.1 is `MS Office 2016 VL` - TODO iso name and links

- For Windows 10 and newer: Office 2019/LTSC 2021 - Office Deployment Tool
  - Install Office 2019 through Office Deployment Kit
  - https://www.microsoft.com/en-us/download/details.aspx?id=49117
  - TODO add reference to or mention all contents of xml file
  - .\setup.exe /download configuration-Office2019Enterprise-slovak.xml

1. After installing the Microsoft Office, open PowerShell or Command Prompt [TODO as Administrator?] and enter following commands (below is an example for Office 2016 Professional ProPlus)

        cd '\Program Files\Microsoft Office\Office16'
        cscript ospp.vbs /inpkey:XQNVK-8JYDB-WJ9W3-YJ8YR-WFG99
        cscript ospp.vbs /sethst:192.168.56.101
        
        # Optionally set KMS Server Port when using different than the default TCP 1688
        cscript ospp.vbs /setprt:1688
        
        cscript ospp.vbs /act
        cscript ospp.vbs /dstatus
        
        # TODO add more commands from https://gist.github.com/jerodg/502bd80a715347662e79af526c98f187#office-kms-setup
        
    In the example is used a GVLK key for Office Professional Plus 2016  
    For more GVLK keys for Office suites see
      - https://docs.microsoft.com/en-us/DeployOffice/vlactivation/gvlks?redirectedfrom=MSDN
      - https://github.com/alvolalex/ms_office_gvlk
        - or better readable raw version: https://raw.githubusercontent.com/alvolalex/ms_office_gvlk/main/README.md

## Activate Windows

Open Command Prompt or PowerShell as Administrator and execute these commands:

        slmgr.vbs -upk
        slmgr.vbs -ipk HMCNV-VVBFX-7HMBH-CTY9B-B4FXY
        slmgr.vbs -skms 192.168.56.101
        slmgr.vbs -ato
        slmgr.vbs -dlv
        
        # TODO add more commands from https://adsecurity.org/?p=301 - KMS Part 2
        # TODO add more commands from https://gist.github.com/jerodg/502bd80a715347662e79af526c98f187#configure-kms-client - the port is optional
  
In the example is used a GVLK key for `Windows 8.1 Pro N`  
For more GVLK keys for Office suites see
  - https://docs.microsoft.com/en-us/windows-server/get-started/kms-client-activation-keys
  
# Start VBox virtual machine at startup

- make vbox virtual machine "alpine linux docker/kms server " launch at system startup
  - change the ip address acquisition of the eth0 interface from dhcp to static
  