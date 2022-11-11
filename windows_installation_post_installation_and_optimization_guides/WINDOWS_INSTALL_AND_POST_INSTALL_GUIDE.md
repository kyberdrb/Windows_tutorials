# Windows 10 version 22H2 & Windows 11 2022 Optimization Guide

Ak bol pocitac pouzivany, najprv vykonat v metro nastaveniach:
  Windows Update -> Recovery -> Reset this PC -> Keep my files.
Potom pokracovat vecami uvedenymi nizsie.

Pri UEFI instalacii Windowsu do VirtualBox-u vid:
* https://www.easytutorial.com/install-windows-10-uefi-virtualbox.html

## Nastavenie predvoleneho administratorskeho uctu

### Uvodne nastavenia

- Vypnut "Windows Defender"
    1. Start -> Settings -> System -> Recovery -> Advanced Startup -> Restart Now
    1. Troubleshoot -> Advanced Options -> Startup Settings -> Restart
    1. At the "Startup Settings" press "4" to "Enable Safe Mode"
    1. Open "Task Manager": `Ctrl + Shift + R` or right click on Windows logo button and select "Task Manager"
    1. Go to the "Details" tab
    1. Find process "MsMpEng.exe", right click on it and from the context menu select "Open file location". An Explorer window with the highlighted file will open.
    
        Note: You can verify that this executable belongs to the process in the "Processes" tab for entry "Antimalware Service Executable" - when you right click on the entry and select "Go to details", the "MsMpEng.exe" will be highlighted on the "Details" tab.
    1. Rename the highlighted file: either with right click -> rename, or with `F2` key.
    
        Rename the file from  
        `MsMpEng.exe`  
        to  
        `MsMpEng.exe.bak`
        
    1. Reboot
    1. The "Antimalware Service Executable" is now shut down not consuming any CPU or disk resources for more responsive, faster and more comfortable experience from the using of the computer.

- Aktivovat Windows
    `Start -> Settings -> Update & Security -> Activation -> Change product key
      -> zadame licencny kluc -> Next -> Activate`
    - Alternative activation methods:
    - **PREFERRED ALTERNATIVE ACTIVATION METHOD**: docker/WSL kms server - for Windows and Office as a clean gift
          - https://github.com/kyberdrb/Windows_tutorials/blob/master/Windows_and_Office_as_a_Precious_Gift/Universal_clean_offline_Microsoft_Windows_and_Microsoft_Office_activation_procedure_with_KMS_server_in_a_local_Docker_container.md
      - Also interesting are these possibilities. Search for:
          - windows 10 activation script
          - [Emulated-KMS-Servers-on-non-Windows-platforms](https://github.com/kebe7jun/linux-kms-server)
          - I don't prefer to use activators because they're often infected with malware. Above mentioned alternatives function much safer for the long term.
- nechat nainstalovat vsetky dostupne aktualizacie - niektore aktualizacie mozu zmenit 
    nastavenia Windowsu, preto budeme menit nastavenia Windowsu po nainstalovani vsetkych 
    dosial dostupnych aktualizacii. Takisto sa automaticky nainstaluju aj najnovsie 
    ovladace pre potrebne zariadenia z Windows Update (toto coskoro vypneme). 
    Restartujeme pocitac, akonahle si to Windows Update vyzaduje.

- nainstalovat ovladace (ak je vyzadovany restart, urobime tak okamzite):
    - Ako zistit vyrobcu a model zakladnej dosky?
        - pozriem sa na základovku a vidím ;) teda, ak ju je vidno. ak je to notebook, niekde bude mať isto nejaké modelové číslo, buď spredu alebo zospodu. ak nie, idem na iné spôsoby:
        
        - PowerShell
        
                Get-WmiObject win32_baseboard | Format-List Product,Manufacturer,SerialNumber,Version
        
            - https://duckduckgo.com/?q=windows+powershell+motherboard+model&ia=web
            - https://www.minitool.com/news/check-motherboard-model-windows-11.html
            
        - Command Prompt
        
                wmic baseboard get product,manufacturer,version,serialnumber
            
        - Open Hardware Monitor
            - https://openhardwaremonitor.org/downloads/
            - https://github.com/openhardwaremonitor/openhardwaremonitor/tags
            
    - pouzit Driver Updater aplikaciu zo stranky vyrobcu - jednoduchsie, rychlejsie, spolahlivejsie, menej starosti
        - https://www.intel.com/content/www/us/en/support/intel-driver-support-assistant.html
            - Scan system and install available updates
        - https://www.dell.com/support/home/sk-sk/product-support/servicetag/0-c0J1QXlCdkZNS253aUVGTThwUG4yZz090/drivers
        - https://www.msi.com/Motherboard/H81M-P33/support#driver
        - https://www.gigabyte.com/Motherboard/GA-F2A68HM-DS2-rev-11/support#support-dl
        
    - BIOS/UEFI
        - pre MSI zakladne dosky zvolit 'Update BIOS + ME' - aktualizuj BIOS a 'Intel Management Engine' firmware
        
    - ovladac grafickej karty
        - NVIDIA
        - NVCleanstall
        
                winget install TechPowerUp.NVCleanstall
                
          Start NVCleanstall
          
          Configure NVCleanstall according to the pictures:
          
          ![](img/NVCleanstall-Annotation%202022-10-29%20183041.png)

          ![](img/NVCleanstall-Annotation%202022-10-29%20183148.png)

          ![](img/NVCleanstall-Annotation%202022-10-29%20183332.png)

          ![](img/NVCleanstall-Annotation%202022-10-29%20184514.png)

          ![](img/NVCleanstall-Annotation%202022-10-29%20184555.png)

          ![](img/NVCleanstall-Annotation%202022-10-29%20184726.png)
          
          Uninstall NVCleanstall
              
              winget uninstall TechPowerUp.NVCleanstall
            
        - AMD
            - https://www.amd.com/en/support/kb/faq/gpu-131#faq-Download-and-Setup
            - https://www.amd.com/en/support/apu/amd-a-series-processors/amd-a6-series-apu-for-desktops/a6-7480-radeon-r5-series
            - https://www.amd.com/en/support/kb/faq/gpu-131
            - https://www.amd.com/en/support/kb/faq/gpu-driver-autodetect
            - https://www.amd.com/en/support
            - https://duckduckgo.com/?q=amd+radeon+driver+autodetect&ia=web

        - INTEL
            - https://www.intel.com/content/www/us/en/search.html#sort=relevancy&f:@tabfilter=[Downloads]&f:@stm_10385_en=[Graphics]
            - latest driver for iGPU in 4tg generation of Intel CPUs - Haswell - for Intel Pentium G3258 Anniversary Edition: https://www.intel.com/content/www/us/en/download/18369/intel-graphics-driver-for-windows-15-40.html
            - Install Intell Xtreme Tuning Utility (XTU) from MSI mobo website
                - 'Advanced Tuning'
                    - Core
                        - 'Enhanced Intel SpeedStep Technology': Enable
                    - Graphics
                        - Change the multiplier to '12x' from the default '11x' for smooth 1080p playback
            - Increase `Dedicated GPU memory` for Intel integrated GPU
                1. `Win + R` > `regedit` > `Ctrl + Shift + Enter` which executes the command with elevated priviledges
                1. Go to `HKEY_LOCAL_MACHINE\SOFTWARE\Intel`
                1. Right click on `Intel` key > `New` > `Key` and name the key `GMM`
                1. Right click on the `GMM` key > `New` > `DWORD (32-bit) value` and name the variable `DedicatedSegmentSize`
                1. Double click on the `DedicatedSegmentSize` variable and set it to **decimal** value calculated by formula
                
                        ENTERED_VALUE = DESIRED_GPU_MEMORY_IN_MB - 64
                    
                    because something reserves 64MB regardless of the value entered.

                1. Restart the system
                1. When the system starts again, go to the Task Manager > Performance > GPU and check the stats, whether the GPU memory had been increased
                - Sources:
                    - https://duckduckgo.com/?q=windows+11+increase+dedicated+gpu+memory+intel+igpu&atb=v344-5vb&ia=web
                    - https://www.thewindowsclub.com/increase-dedicated-video-ram-windows-10
                    - Test video: Costa Rica 4k: https://www.youtube.com/watch?v=LXb3EKWsInQ
                        - play with settings in extension `enhanced-h264ify` ;)
        
    - ovladace chipsetu pre zakladnu dosku
        - https://www.intel.com/content/www/us/en/support/intel-driver-support-assistant.html
        
    - firmware pre SSD (napr. pre Samsung SSD aktualizujeme SSD firmware z utilitky Samsung Magician)
        - Solidigm - legacy Intel SSDs
      
    - ovladac pre SSD (hlavne pre M.2 SSD napr. Samsung 960)
    - ovladac tlaciarne
        - setting up a Samsung printer (**Samsung Xpress M2070** a.k.a. Samsung Xpress SL-M2070)
            1. Download [**Samsung Printer Software Installer**](https://support.hp.com/us-en/document/c05578283)
                - the page links the installer with link https://printersetup.ext.hp.com/TS/Client/en/Install.html
            1. Download the installer, open it and follow the installation steps. Install everything for full and seamless functionality.
            1. At the end of the installation process of the Samsung Printer Software Installer, turn off the printer and turn it on again to reload devices in Device manager, to fix any _Unknows devices_ related to the printer there. The restart of the printer invokes a reload of the driver for the printer in Windows for each device of the multifunction device.
            1. Go to the concrete page of the printer, e.g.  
            
                https://support.hp.com/us-en/drivers/selfservice/samsung-xpress-sl-m2070-laser-multifunction-printer-series/16450377

                And install critical software updates, firmware upgrades and any other utilities needed for a seamless printer operation and comfortable printer usage.
            1. Test the multifunction printer
                - test the printer with a document with text, e.g. with generated Lorem Ipsum
                    - https://duckduckgo.com/?q=lorem+ipsum+text&ia=web
                    - https://loremipsum.io/
                    - https://duckduckgo.com/?q=lorem+ipsum+generator&ia=web
                    - https://lipsum.com/
                1. test the scanner
                    - e.g. with `Samsung Easy Printer Manager > Scan` option in the right top corner, which opens Samsung Easy Document Creator. Select `Scan` tab for non-OCR plain scanning or `Text Converting Scan` for scanning with OCR, which makes a PDF searchable (but the OCR doesn't work accurately).
                1. test copying
                    - insert a page for copying to the scanner and press the `Start` button on the printer
            - **Troubleshooting**
                - **_The printer doesn't take the paper into the printer_**
                    - use the screw with bolts to put a weight on the feeding roller by inserting the screw on top of the feeding roller on the left side of the roller (closer to the gear mechanism) in order to have an maximum effect. The weight is sufficient for the feeding roller to make a grip onto the paper which the roller pulls into the printer.
                        - https://duckduckgo.com/?q=samsung+xpress+m2070+disassembly&ia=web
                        - Samsung printer Xpress M2070 Disassembly/Reassembly: viandant5 - https://www.youtube.com/watch?v=jAAFbkRNP1Q
                        - https://duckduckgo.com/?q=feeding+roller+doesnt+feed+grip&ia=web
                        - https://duckduckgo.com/?q=paper+feed+rollers+roll+but+dont+feed&ia=web
                        - http://www.edugeek.net/forums/hardware/15292-solved-printer-feed-rollers-dont-want-feed-paper-why.html#post153659
    - Overíme, či pre každé zariadenie existuje ovládač: pravý klik na Štart menu > Správca zariadení (Device Manager)
        - pre stále neznáme zariadenia v `Device Manager` - pravý klik na neznáme zariadenie > Properties > karta `Details` > z rozbaľovacieho zoznamu pod `Property` vyberieme `Hardware Ids`. Pravý klik na zobrazenú hodnotu > Kopírovať. Ak je na výber viacero IDčiek, skopírujeme jedno z nich - najprv to najkratšie, a dáme si ho vyhľadať cez nejaký search engine. Nejaké návrhy na ovládače nám určite vyhodí. Potom sa spoliehame na náš vzdelaný odhad.
            - https://duckduckgo.com/?q=find+driver+for+unknown+device&ia=web
            - https://www.howtogeek.com/193798/how-to-find-drivers-for-unknown-devices-in-the-device-manager/

### Kontrola fyzickej struktury disku

Na zistenie fyzicky poškodených sektorov (badblocks/ bad sectors) na disku - môže značiť opotrebenie

Command Prompt / dôkladná kontrola - trvá pár hodín (na mojom 2.5" 320GB 7200RPM HDD trvala asi tri hodiny)

    chkdsk C: /scan /F /R /B

PowerShell / rýchla kontrola: trvá pár sekúnd

    Repair-Volume -DriveLetter C -Scan
    
        NoErrorsFound
    
    Repair-Volume -DriveLetter C -OfflineScanAndFix
    
        NoErrorsFound
    
    Repair-Volume -DriveLetter C -SpotFix
    
        NoErrorsFound
    
- https://duckduckgo.com/?q=scan+disk+for+bad+sectors+powershell&ia=web
- https://thinkpowershell.com/powershell-replacement-for-chkdsk/
- https://learn.microsoft.com/en-us/powershell/module/storage/repair-volume?view=windowsserver2022-ps
- https://duckduckgo.com/?q=chkdsk&ia=web
- https://duckduckgo.com/?q=windows+run+trim+fstrim+manually&ia=web
- https://kb.plugable.com/data-storage/trim-an-ssd-in-windows-10
- chkdsk /?
- Repair-Volume -?

### Zakladne systemove nastavenia
  
- Zapneme planovanu defragmentaciu a optimalizaciu diskov
    - pri HDD vykonava defragmentaciu
    - Pri SSD vykonava TRIM - označovanie a fyzickú dealokáciu vymazaných blokov
    - ---    
    1. Otvorime ponuku `Start` a napiseme/vyhladame "defragment and optimize drives" (nachadza sa pod "Windows 
    Administrative Tools") -> klikneme na disk C:\ -> Change settings
    1. zaskrtmene "Run on schedule" a presvedčíme sa že sa optimalizácia vykonáva každý týždeň (Weekly)
    1. OK -> Close`
- Vypnutie zvukovych efektov vo Windowse:
    - `pravy klik na ikonku reproduktora (speaker icon) na start liste (taskbar) -> Zvuky (Sounds)
        - "Zvukova schemu" (Sound scheme) zmenime na "Bez zvukov" (No Sounds)`
        - zapneme zvuk spustenia systemu zaskrtnutim "Play Windows Startup sound"
- Otvorime "Kos" na pracovnej ploche -> v navigacnom paneli klikneme pravym na 
    "Tento pocitac" (This PC) -> Vlastnosti (Properties) -> Rozsirene systemove 
    nastavenia (Advanced system settings)
    - Spresnenie (Advanced) karta
      - v casti "Vykon" (Performance) -> kliknut na tlacidlo "Nastavenia" (Settings)
        - Vizualne efekty (Visual effects) karta
          - zvolit "Adjust for best performance"
          - mozeme zapnut tieto nastavenia
            - ukazat nahlady namiesto ikon (Show thumbnails instead of icons)
          - alebo zvolime "Adjust for best appearance" a vypneme iba tiene. Odskrtneme:
            - Show shadows under mouse pointer
            - Show shadows under windows
            - Use drop shadows for icon labels on the desktop
        - Spresnenie (Advanced) karta
          - v casti "Processor scheduling" -> Adjust best performance for = "Programs"
          - ak mame >=16GB RAM -> v casti "Virtual memory" -> Change
            -odskrtnut "Automatically manage paging file size for all drives"
            - V zozname diskov kliknut na kazdy z nich a pre kazdy zvolit "No paging 
              file" a zakazdym kliknut na tlacidlo "Set"
            - ak mame Windows nainstalovany vo virtualke, vypneme strankovaci subor
              zvolenim moznosti "No paging file" -> Set -> OK
            - ak mame menej ako 16GB pamate, nechame Windows, aby spravoval velkost 
              strankovacieho suboru (checkbox "Automatically manage paging file size 
              for all drives" zostane zaskrtnuty a nevykonavame ziadne zmeny 
              ALEBO 
              to nastavime iba na jeden disk, pre vsetky ostatne paging file vypneme 
              a pre ten jediny disk ho nastavime na Custom size: 4096. Ak to nepomoze 
              sekaniu, mozeme presunut paging file na iny disk). 
              ALE POKIAL SYSTEM ZAMRZA, 
              znovu aktivujeme automaticku spravu strankovacieho suboru.
        - "Data Execution Prevention" karta - DEP
          - zapnut pre vsetky programy okrem nizsie uvedenych (Turn on DEP for all programs and services except those I select:)
      - v casti "Startup and Recovery" -> kliknut na tlacidlo "Settings"
        - odskrtnut "Time to display list of operating systems" -> zrychli sa bootovanie
    - "System Protection" karta
      - zapnut iba pre systemovy disk (pre vsetky ostatne disky nechame vypnute) a 
        okamzite vytvorit bod obnovy
      - ak je sluzba vypnuta, klikneme na `Configure -> Turn on system protection -> Create
        -> ako nazov zadame napr. "fresh install" -> Create -> pockame kym sa bod obnovy
        nevytvori`
    - "Remote" karta
      - odskrtnut "Allow Remote Assistance connections to this computer"
      - zvolit "Don't allow remote connections to this computer"
      - v pripade virtualizacie mozme tieto moznosti podla potreby povolit
        (mozno odskrtnut "Only allow connections ...")
    - Pri potvrdeni nastaveni (tlacidlo "OK") pri vyzve na restart zvolime 
      _Restartujeme neskor_ / _Restart later_

### Windows Explorer

- Zmenit "Moznosti priecinka" (Folder options) -> Otvorime napr. Kos (Recycle Bin), 
    v hornej liste klikneme na "Zobrazit" (View) a potom na "Moznosti" (Options):
    - karta "Vseobecne" (General)
      - Open File Explorer to: "This PC"
      - v casti "Privacy":
        - odskrtnut vsetky checkboxy (vypneme Quick access - Rychly pristup)
        - klikneme na tlacidlo "Clear" (Vymazat)
    - karta "Zobrazenie" (View)
        - zaskrtnut "Zobrazenie uplnej cesty v zahlavi okna" 
        (Display the full path in the title bar)
        - odskrtnut "Skryvanie znamych pripon suborov" 
        (Hide extensions for known file types)
        - odskrtnut "Skryvanie konfliktov pri spajani priecinkov" 
        (Hide folder merge conflicts)
        - zaskrtnut "Otvorit kazde okno v samostatnom procese" 
        (Launch folder windows in separate process)
        - odskrtnut "Zobrazit oznamenia poskytovatela synchronizacie" 
        (Show sync provider notifications)
        - pod castou "Navigacna lista" (Navigation pane):
          - zaskrtnut "Zobrazit vsetky priecinky" (Show all folders).
          To zobrazi Ovladaci panel aj Kos v navigacnej liste.
          Niektore polozky a adresare budu zobrazene duplicitne.
          
        Uplne nastavenia
        
        ![](img/Folder_Options-Annotation%202022-10-29%20194029.png)

        ![](img/Folder_Options-Annotation%202022-10-29%20194137.png)

        ![](img/Folder_Options-Annotation%202022-10-29%20194319.png)
            
    - karta "Hladanie" (Search):
        - odskrtnut vsetko okrem _Zahrnut systemove adresare_


### Microsoft Store
  
- Otvorime Microsoft Store -> klikneme na 3 bodky v pravom hornom rohu -> Nastavenia (Settings):
    -vypneme _Dynamicka dlazdica_
    -vypneme Automaticke prehravanie videa (Play videos automatically)

### Windows Update

- V pripade virtualnej instalacie Windows vypneme Windows Update uplne
    Win+R -> services.msc -> pravy klik na Windows Update -> Properties -> 
    Startup type: Disabled -> OK

### METRO CONTROL PANEL / METRO NASTAVENIA

Start -> Settings 'gear' icon on the left bottom corner, or just search for _settings_

- Systém (System)
    - Displej (Display) -> zapnut Nocne osvetlenie (Night light) 
    (nastavit uroven v 'Night light settings')
    - Oznámenia a akcie (Notification & settings)
    -> povypinat vsetko okrem "Get notifications from apps and other senders"
    (malo by to byt prve; ak to bude prilis obtazovat, vypnut aj toto nastavenie)
        - ak budeme chciet prijmat VoIP hovory, necham zapnutu aj moznost
      "Show reminders and incoming VoIP calls on the lock screen"
    - Napájanie a spánok (Power & sleep)
        - Dalsie nastavenia napajania (Additional power settings)
            - Vybrat akcie pre tlacidla napajania (Choose what the power buttons do) -> Zmenit momentalne nedostupne nastavenia 
              (Change settings that are currently unavailible). Zadame administratorske heslo, ak je potrebne.
                - odskrtnut "Zapnut rychle spustenie" (Fast startup)
                - kliknut na Ulozit zmeny (Save changes)
            - ist naspat (go back) -> zvolit "Vyvazeny" (Balanced) plan 
              -> Zmenit nastavenia planu (Change plan settings) ->
              "Change advanced power settings"
                - Hard disk
                  - Turn off hard disk after
                    - On battery: 0
                    - Plugged in: 0
                - Internet Explorer
                  - JavaScript Timer Frequency
                    - On battery: Maximum Power Savings
                    - Plugged in: Maximum Performance
                - Desktop background settings
                  - Slide show
                    - On battery: Paused
                    - Plugged in: Availible
                - Wireless adapter settings
                  - Power Saving Mode
                    - On battery: Medium Power Saving
                    - Plugged in: Maximum Performance
                - Sleep
                  - Allow hybrid sleep
                    - On battery: Disable
                    - Plugged in: Disable
                  - Allow wake timers
                    - On battery: Disable
                    - Plugged in: Important Wake Timers Only
                - USB settings
                  - USB selective suspend setting
                    - On battery: Enabled
                    - Plugged in: Disabled
                - Power buttons and lid
                  - Power button action
                    - On battery: Shut down
                    - Plugged in: Shut down
                  - Sleep button action
                    - On battery: Sleep
                    - Plugged in: Sleep
                - PCI Express
                  - Link State Power Management
                    - On battery: Moderate power savings
                    - Plugged in: Off
                - Processor power management
                  - Maximum processor frequency
                    - On battery: 0
                    - Plugged in: 0
                  - Minimum processor state
                    - On battery: 100
                    - Plugged in: 100
                  - System cooling policy
                    - On battery: Active
                    - Plugged in: Active
                  - Maximum processor state
                    - On battery: 100
                    - Plugged in: 100
                - Display
                  - Turn off display after
                    - On battery: 8
                    - Plugged in: 8
                  - Enable adaptive brightness
                    - On battery: Off
                    - Plugged in: Off
                - Multimedia settings
                  - When sharing media
                    - On battery: Prevent idling to sleep
                    - Plugged in: Prevent idling to sleep
                  - Video playback quality bias
                    - On battery: Video playback power-saving bias
                    - Plugged in: Video playback performance bias
                  - When playing video
                    - On battery: Balanced
                    - Plugged in: Optimize video quality
                - Battery
                  - Critical battery action
                    - On battery: Hibernate
                    - Plugged in: Hibernate
                  - Low  battery level
                    - On battery: 10
                    - Plugged in: 10
                  - Critical  battery level
                    - On battery: 5
                    - Plugged in: 5
                  - Low battery notification
                    - On battery: On
                    - Plugged in: On
                  - Low battery action
                    - On battery: Do nothing
                    - Plugged in: Do nothing
                  - Reserve battery level
                    - On battery: 7
                    - Plugged in: 7
                  - nakoniec kliknut na OK a Ulozit zmeny (Save changes)
                  - vratime sa naspat do okna s Metro nastaveniami
    - Shared experiences -> vypnut -> krok spat (go back)
- Prisposobenie (Personalisation)
    - Start
        - vypnut vsetko okrem 
            - Zobrazit zoznam aplikacii v ponuke Start (Show app list in Start menu)
    - Motivy (Themes)
        - pridat ikonku "Tento pocitac" na pracovnu plochu:
        - klikneme na Nastavenie ikon na pracovnej ploche (Desktop icon settings), scrollovat na spodok obrazovky -> Zaskrtnut Tento pocitac (Computer)
    - Panel uloh (Taskbar)
        - zapnut "Use Peek"
        - vypnut v paneli uloh ikonku "Ludia" (na spodku stranky)
        - "Select which icons appear on the taskbar" -> zapnut "Always show all icons in the notification area"
- Aplikacie (Apps)
    - Apps & features
        - odinstalovat vsetky nepotrebne aplikacie - bloatware
        - po odinstalovani vsetkych aplikacii sa vratime na vrch/spodok stranky a pod Suvisiacimi nastaveniami (Related Settings) klikneme na Programy a sucasti (Programs and Features)
        - klikneme na Zapnut alebo vypnut sucasti systemu Windows 
        (Turn Windows features on or off)
            - zaskrtneme ".NET 3.5" - kvoli niektorym aplikaciam napr. MS Office
            - ak instalacia zlyha, docasne zapneme sluzbu Windows Update v services.msc
            - po instalacii .NET 3.5 znovu vypneme sluzbu Windows Update [IBA PRE POMALSIE POCITACE]
    - Offline mapy (Offline maps)
        - vypnut Automaticky aktualizovat mapy (Automatically update maps)
        - kliknut na Odstranit vsetky mapy (Delete all maps) -> Delete all
    - Apps for websites -> vypnut pre vsetky aplikacie
    - Startup: vypnut vsetky aplikacie okrem nevyhnutnych
- Konta (Accounts)
    - vypnut "Sync settings" pod "Sync your settings"
- Hranie hier (Gaming)
    - Herny panel (Game bar) -> vypnut vsetko
    - Game DVR -> vypnut vsetko
    - Herny rezim (Gaming Mode) -> zapnut
- Zjednodusenie pristupu (Ease of Access)
    - Moderator (Narrator) -> vypnut vsetko
    - Magnifier -> vypnut vsetko
    - Other options
        - mozeme vypnut Prehravat animacie vo Windowse (Play animations in Windows). Ja to nechavam zapnute, lebo sa radsej pozeram na animovane prvky.
        - volitelne mozeme vypnut aj Zobrazit pozadie pracovnej plochy (Show Windows background)
- Ochrana osobnych udajov (Privacy)
    - vypneme vsetko, co nepouzivame, od Vseobecne (General) po Ostatne zariadenia (Other devices)
    - Pripomienky a diagnostika (Feedback & diagnostics)
      - Vybrat mnozstvo udajov, ktore sa budu odosielat Microsoftu 
        (Select how much data you sent to Microsoft) -> Zakladne (Basic)
      - vypnut Povolte Microsoftu pouzivat vase diagnosticke udaje 
        (Let Microsoft provide more tailored experiences ...)
      - Diagnostif & Feedback -> Frekvencia pripomienok (Feedback frequency) -> Nikdy (Never)
      - Activity History
        - odskrtnut Store my activity on this device
        - kliknut na Clear pod castou Clear activity history, aby sa historia aktivit pri zmene pracovnej plochy (Win + Tab) odstranila - lepsi prehlad
    - Aplikacie na pozadi (Background apps) vypnut vsetky okrem Microsoft Edge 
      (aby vedel prehravat napr. Youtube, ked bude minimalizovany)
    - Diagnostika aplikacii (App diagnostics) -> vypnut
- Update & security
    - Windows Update -> Rozsirene moznosti (Advanced options)
        - Update Options
            - zaskrtnut Poskytovat aktualizacie pre dalsie produkty spolocnosti Microsoft pri aktualizacii systemu Windows (Give me updates for other Microsoft products when I update Windows)
        - Update Notifications
            - Show a notification when your PC requires a restart to finish updating
        - zvolit Polrocny kanal (cieleny) resp. Semi-Annual Channel (Targeted)
        - pocet dni, o ktore sa oneskoria aktualizacie nemusime menit
        - vypnut Pozastavit aktualizacie (Pause updates) 
          - budeme mat najnovsie aktualizacie okamzite
        - klikneme na Optimalizacia dorucovania (Delivery Optimisation)
          - vypnut Povolit stahovanie z inych pocitacov
          (Updates from more than one place/Allow downloads from other PCs)
    - "Windows Security" (formerly "Windows Defender")
        - klikneme na Otvorte Centrum zabezpecenia v programe Windows Defender (Open Windows Security)
        - klikneme na Ochrana pred virusmi (Virus and Threat protection)
          - klikneme na Manage settings pod castou Nastavenie ochrany pred virusmi a hrozbami (Virus and threat protection
            settings)
            -vypnut Automaticke odosielanie vzoriek (Automatic sample submission)
            - volitelne aktivovat "Controlled folder access" pre vsetky pouzivatelske adresare (Downloads, Documents atd.)
- Vypnut vsetko v casti "Hladanie" v metro nastaveniach
    - Permissions and history
      - SafeSearch: Off
      - Cloud Search: Off
      - History: Off + kliknut na "Clear my device history"
- Time & Language
  - Ak potrebujeme, mozeme nainstalovat slovensku lokalizaciu. Je potrebne zapnut sluzbu Windows Update.
  - Language -> Add a language - hladat "Slovenčina" -> Next -> Zaskrtnut iba "Install language pack and set as my Windows display language", vsetko ostatne odskrtnut resp. zaskrtnut podla potreby -> klikneme na "Install"
  - ak to nejde cez Metro nastavenia, ist do Control Panel -> Language
    -> Slovencina -> Options -> pod Windows display language by sa mal po chvili
    objavit odkaz na stiahnutie jazykoveho balicka

### ROZSIRENE SYSTEMOVE NASTAVENIA

- Do start menu napisat "msconfig" -> pravy klik -> spustit to ako spravca
    - "Boot" karta -> kliknut na operacny system -> 
        - "Advanced options..." -> zaskrtnut "Number of processors" a vybrat najvyssie 
        cislo, ktore zodpoveda schopnostiam procesoru (obvykle to posledne) -> OK
        - zaskrtnut "No GUI boot"
        - nastavit "Timeout" na 3 sekundy (v pripade, ze je tam vacsie cislo)
    - "Services" karta
        - zaskrtnut "Hide all Microsoft services" 
        - povypinat vsetky nepotrebne sluzby - napr. s aplikaciou (https://www.sordum.org/8637/easy-service-optimizer-v1-2/)[Easy Service Optimizer]
    - Startup -> Open Task Manager -> klikneme na sipku vlavo dole pre zobrazenie vsetkych moznosti -> Start-up -> povypiname nepotrebne aplikacie
    - Po dokonceni nastaveni zatvorime Spravcu uloh (Task Manager) -> klikneme na OK -> v dialogovom okne zvolime "Exit without restart"

- Do start menu napisat "regedit" -> pravy klik -> spustit to ako spravca
    - upravime nastavenia "Multimedia Class Scheduler"
        - pojdeme do `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile`
          - vnutri vytvorime novu DWORD hodnotu (ak este nie je vytvorena) s nazvom 
            "SystemResponsiveness" a priradime jej hexadecimalnu hodnotu 0
        - pojdeme do `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games`
          - vnutri vytvorime novu DWORD hodnotu (ak este nie je vytvorena) s nazvom `GPU Priority` a priradime jej hexadecimalnu hodnotu 8
          - vnutri vytvorime novu DWORD hodnotu (ak este nie je vytvorena) s nazvom `Priority` a priradime jej hexadecimalnu hodnotu 6 (povodne 2)

- vypnut bezpecne vypnutelne sluzby
  - vid subor "safe_to_disable_windows_10_services.txt" or `ESO` - Easy Service Optimizer
- TODO Ako Nastavit Windows Photo Viewer namiesto metro aplikacie Photos (ref na subor)
- odstranit duplicitne odkazy na adresare z Navigacnej listy a nechat iba upravovatelny Rychly pristup
    - sempervideo windows 10 explorer links entfernen
- IPv6 privacy extensions are enabled in Windows by default out-of-the-box

- ak pracujeme s HDD, mozeme si ho nechat skontrolovat a defragmentovat 
  (aj ked defragmentaciu robi Windows v idle na pozadi) v casti "Tento pocitac" -> pravy klik na disk "C:\" (systemovy disk) -> "Tools" karta
    - klikneme na "Check"
        - Zaklikneme vsetky checkboxy (ak su pritomne), klikneme na "Scan" a nechame dobehnut. Ak sa vyskytnu chyby, nechame Windows, aby ich opravil.

- ak nepouzivame hibernaciu, mozeme uvolnit niekolko gigabajtov miesta na disku vypnutim hibernacie, cim sa odstrani subor "hiberfile.sys", ktory toto miesto zabera. Pozor ale, ak je v nastaveniach napajania ako Akcia pre kriticky stav baterie vybrana hibernacia: vtedy ju treba nechat zapnutu.
    - zadame "cmd" do start menu -> pravy klik -> spustit ako spravca/Admin
        - zadame prikaz "powercfg -h off"
        - zmeny sa prejavia az po restarte
    
- Enable ECN - Explicit Congestion Notification
    
    ECN allows end-to-end notification of network congestion **without dropping packets**.
      
    ECN is an optional feature that is only used when both endpoints support it and are willing to use it; it is only effective when supported by the underlying network.

    Open `Command Prompt` as admin and enter following command

            netsh interface tcp set global ecncapability=enabled

    - https://www.bufferbloat.net/projects/cerowrt/wiki/Enable_ECN/
    - https://social.technet.microsoft.com/wiki/contents/articles/20204.how-to-enable-and-disable-explicit-congestion-notification-in-windows.aspx

- odstranit OneDrive instalacku, ak OneDrive Cloud nepouzivame
  - vymazat cely adresar `"%USERPROFILE%"\AppData\Local\Microsoft\OneDrive\StandaloneUpdater`

- [SPOMALUJE VYPINANIE - PRESKOCIT] pri kazdom odhlaseni vymazat skriptom docasne subory a obsah docasnych adresarov 
  (vid "delete_temp_files_and_folders_at_logout_or_shutdown.txt") 
  [**pri HDD trva vypnutie vyrazne dlhsie** - cca 5min => TODO vymysliet alternativny sposob - pravidelne precistovanie system restore pointov (google hned prvy odkaz: powershell script to delete system restore points), docasnych adresarov pouzivatela aj windowsu, prefetch suborov]

- ak je na systemovom disku malo miesta, vieme zmenit umiestnenie preddefinovanych adresarov (Dokumenty, Stiahnute, Hudba, Videa a pod.) - na iny disk (vid computer 07/20017 str. 136 alebo "change_predefined_user_folders_location.txt")

### GPU settings / Nastavenia grafickej karty

  - Nastavenie grafickych kariet Nvidia
      - otvorime "NVIDIA Control Panel": bud pravy klik na plochu -> NVIDIA Control Panel, alebo ho otvorime z taskbaru
          - ist do "Adjust image settings with preview" -> zvolit "Use advanced 3D image settings" a kliknut na "Take me there" (alebo klikneme na "Manage 3D settings" na lavom paneli) -> upravime nastavenia nasledovne:
              - Ambient Occlusion: Off
              - Anisotropic filtering: Off
              - Antialiasing - FXAA: Off
              - Antialiasing - Gamma correction: On
              - Antialiasing - Mode: Off
              - CUDA - GPUs: All
              - DSR - Factors: Off
              - Maximum pre-rendered frames: 2
              - Multi-Frame Sampled AA (MFAA): Off
              - Optimize for Compute Performance: Off
              - Power management mode: Prefer maximum performance - alebo radsej nechat na Default/Balanced
              - Preferred refresh rate: Highest availible
              - Shader cache: On
              - Texture-filtering - Anisotropic sample optimization: On
              - Texture-filtering - Negative LOD bias: Allow
              - Texture-filtering - Quality: High performance
              - Texture-filtering - Trilinear optimization: On
              - Threaded optimization: On
              - Tripple buffering: On
              - Vertical sync: Off
              - Virtual Reality pre-rendered frames: 2

  - Nastavenie grafickych kariet AMD
    - otvorime "AMD Radeon Settings" resp. `Radeon Software`: bud pravy klik na plochu -> AMD Radeon Settings, alebo ho otvorime z taskbaru
      - Preferences (the gear icon) > Graphics > select Gaming profile, then expand 'Advanced' section and enable 'OpenGL Tripple Buffering'
          - na plynulejsie prehravanie YouTube videi

  - Nastavenie grafickych kariet Intel
    - otvorime "Intel Graphics and Media Control Center" resp. "Intel HD Graphics Control Panel" a pohrame sa s nastaveniami podla potreby
      
### Verification / Overenie
  - pozriet Event Viewer na systemove udalosti / chyby
  
      Win + R
  
          eventvwr
  
  - zaheslovat administratorsky ucet
  
  - Opravime instalaciu Windowsu kvoli nekonzistencii (nezname chyby v Event Vieweri, chyby pri spustani a Windowsu)
      - klikneme pravym na ikonku Windowsu v lavom dolnom rohu obrazovky (alebo Win + X) 
          - Windows PowerShell (spravca / Admin) -> zadame prikazy
      
                SFC /SCANNOW
        
                DISM /Online /Cleanup-Image /CheckHealth
                
                DISM /Online /Cleanup-Image /ScanHealth
          
                DISM /Online /Cleanup-Image /Restorehealth
          
          - https://www.minitool.com/news/use-dism-restorehealth-command-windows.html
      
    -po skonceni restartujeme pocitac
  
#### VZHLAD / Appearance

- zapnut prompt pri vymazani suboru (prave tlacidlo na Kos -> Vlastnosti) -> zaskrtnut "Display delete confirmation dialogue"
- prave tlacidlo na panel uloh (Taskbar) -> odskrtnut "Show task bar view button"
- vycistit Start menu od dlazdic (vypnut dlazdicu a odstranit ju) a zmensit ho
- prave tlacidlo na panel uloh (Taskbar)
    - Cortana -> Skryt (Hidden)
    - Search (Vyhladavanie) -> Skryt (Hidden)
- odstranit (odopnut) vsetky ikonky z Rychleho pristupu na paneli uloh (Taskbar), (okrem Edge a File Explorer), pretoze vsetko dolezite je pristupne z kontextovej 
  ponuky Windows tlacitka (prave tlacidlo na Windows logo vlavo dole)
- prave tlacidlo na Windows logo vlavo dole -> Spravca uloh (Task Manager)
    - Vykon (Performance) -> CPU -> pravy klik na graf -> Zmenit graf na (Change graph to) -> Logicke procesory (Logical processors)
-prave tlacidlo na pracovnu plochu -> Usporiadat podla (Sort by)
    - Typ (Item type); tak bude ikonka "This PC" uvedena ako prva

### Benchmark

Windows Benchmark - Full Measurement Suite
- PowerShell/Command Prompt

        winsat formal
        
    - https://duckduckgo.com/?q=run+winsat+windows+10&ia=web
    - https://www.ghacks.net/2017/10/16/the-windows-winsat-command/

### Aplikacie / Apps
  
Najprv nainstalovat `App Installer` z Microsoft Store, a potom nainstalovat aplikacne balicky z PowerShell spusteneho ako standardny pouzivatel:
    
```
winget install wingetcreate; `
winget install TechPowerUp.NVCleanstall; `
winget install 7zip.7zip; `
winget install --id Git.Git -e --source winget; `
winget install eloston.ungoogled-chromium; `
winget install Opera.Opera; `
winget install Dropbox.Dropbox; `
winget install SecombaGmbH.Boxcryptor
```
  
    - Windows Terminal
      - https://duckduckgo.com/?q=(NEW!)+add+a+git+bash+profile+to+windows+terminal&ia=web
      - https://executecommands.com/how-to-install-windows-terminal-in-windows-10/
      - https://executecommands.com/add-git-bash-to-windows-terminal-app-profile/
    - Git
        - install `sudo` into Git Bash with `win-sudo`
            - https://github.com/imachug/win-sudo
    - Ungoogled Chromium
        - remember cookies, i.e. remember active logins and site specific settings, after browser close: Go to `chrome://settings/cookies` or to `three dots > Settings > Privacy and Security > Cookies and other site data` and disable option
        ```
        Clear cookies and site data when you close all windows
        When on, you'll also be signed out of Chromium
        ```
        - https://duckduckgo.com/?q=remember+cookies+ungoogled+chromium&atb=v344-5vb&ia=web
        https://github.com/ungoogled-software/ungoogled-chromium/issues/1352#issuecomment-767179087
    - Bezpecnost
      - antivirus: ClamWin Antivirus -> Naplanovat pravidelne kontroly disku 1x za tyzden
      - antimalware: VirusTotal / herdProtect / Malwarebytes
      - EaseUS Todo Backup Free - zalohovat nim v pravidelnych intervaloch cely system 
        (nastavit ponechanie iba jednej zalohy) + vytvorit zachranne USB EaseUS
      - mat v zalohe USB so samostatne bootovatelnym antivirakom: **Kaspersky Rescue Disk**
    - Kniznice a frameworky
      - Direct X
      - Java (JRE)
      - kodeky (K-lite Mega codec pack lite) - alebo VLC player: ten nepotrebuje ziadne dalsie kodeky - ma ich uz v sebe
    - Udrzba / Maintenance utils:
        - [Windows 10 Debloater](https://github.com/Sycnex/Windows10Debloater).
            - Read the README in the repo how to launch the script. Then follow the instructions on the screen.
        - [Windows 11 debloat](https://github.com/teeotsa/windows-11-debloat)
            - Disable Cortana (Search)
            - Disable Windows Defender
            - Take Ownership
        - Bleach Bit
        - CCLeaner
        - O&O Shut Up
        - Spybot AntiBeacon - vypnut telemetriu
        - Eso - Easy Service Optimizer
        - Open Hardware Monitor
            - https://openhardwaremonitor.org/downloads/
            - PowerShell equivalent commands
                - RAM info: `Get-CimInstance -ClassName Win32_PhysicalMemory`
                    - https://duckduckgo.com/?q=powershell+memory+model&atb=v344-5vb&ia=web
                    - https://www.digitalbrekke.com/detailed-information-about-ram-in-powershell/
                - CPU info: `Get-CimInstance -ClassName CIM_Processor`
                    - https://duckduckgo.com/?q=Get-CimInstance+-ClassName+CPU&atb=v344-5vb&ia=web
                    - https://www.improvescripting.com/get-processor-cpu-information-using-powershell-script/
    -Kancelarske aplikacie
      - VSCodium
          - for unattended install, open PowerShell as a **regular user** and execute commands

                  winget install vscodium
              
              for `UserInstaller` if you have `App Installer` from `Microsoft Store`
              
              or for `SystemInstaller` download the latest release of a installer with name `VSCodiumSetup-x64-A.BB.C.DDDDD.exe` from the [official repo](https://github.com/VSCodium/vscodium/releases)

                  cd Downloads

                  Get-FileHash .\VSCodiumSetup-x64-1.73.1.22314.exe -Algorithm SHA1

                  Algorithm       Hash                                                                   Path
                  ---------       ----                                                                   ----
                  SHA1            33CB028A1A4AC176682E704E4F559199E9B22121                               <ommitted>


                  cat .\VSCodiumSetup-x64-1.73.1.22314.exe.sha1
                  33cb028a1a4ac176682e704e4f559199e9b22121  VSCodiumSetup-x64-1.73.1.22314.exe
                  
                  cat .\VSCodiumSetup-x64-1.73.1.22314.exe.sha256
                  56850d7690bf5aab4fa88a281605edb8e4c462c8c27ae6105bae8e7aa977635f  VSCodiumSetup-x64-1.73.1.22314.exe
                  
                  .\VSCodiumSetup-x64-1.73.1.22314.exe /SP- /DIR="C:\Programme\VSCodium" /NOCANCEL /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS /NORESTART /LOG="$HOME\VSCodiumSetup-x64-1.73.1.22314.log"
                  
          - for disabling the `Untrusted Workspace` prompts and to treat any workspace as untrusted
              1. Go to `File > Preferences > Settings` or by pressing `Ctrl + ,`
                  - `security.workspace.trust.enabled` or `Security > Workspace > Trust: Enabled` - **uncheck**; restart editor if prompted
                  - `security.workspace.trust.startupPrompt` - **never**
              - https://duckduckgo.com/?q=disable+untrusted+workspace+prompt+vscode+trust+by+default&ia=web
              - https://stackoverflow.com/questions/67914899/how-can-i-disable-workspace-trust-in-vs-code-1-57
      - Microsoft Office 2021 (+ KMS activation?)
      - PDF reader (Adobe Reader / Foxit Reader / ...)
    - Utilitky
      - 7z          
      - Monitoring hardveru / teplot / ventilatorov / CPU parametrov / napati
        - Nejaka utilitka ku zakladnej doske:
          - Gigabyte ma vynikajuci nastroj "System Information Viewer" (SIV) - vyzaduje AppCenter
        - OpenHardwareMonitor
            - PowerShell commands for partial hardware info
            
              CPU
              
                  Get-WmiObject Win32_Processor
                  
              - https://duckduckgo.com/?q=powershell+cpu+info&ia=web
              - https://devblogs.microsoft.com/scripting/use-powershell-and-wmi-to-get-processor-information/
              
              RAM
              
                  Get-CimInstance -Class CIM_PhysicalMemory
                  
              - https://duckduckgo.com/?q=powershell+ram+info&ia=web
              - https://www.improvescripting.com/how-to-get-memory-ram-details-using-powershell/
              
        - CPU: RealTemp, CoreTemp
        - GPU: GPU-Z
        - HDD: CrystalDiskInfo
      - TimeResolution.exe -> https://cms.lucashale.com/timer-resolution/ -> zodpovedny za zrychlenie defaultneho casovaca vo Windowse; urychluje beh operacneho systemu ako takeho a jeho komunikaciu so vsetkymi softverovymi a hardverovymi komponentami
          - pouziva sa tak, ze ho spustime ako administrator, klikneme na tlacidlo "Maximum", program minimalizujeme a nechame bezat na pozadi pocas hrania hry alebo inej intenzivnej cinnosti.
      - WireShark - monitorovanie sietovej aktivity
    - system stress testing
      - Prime95 - CPU stress
      - Furmark - GPU stress
    - benchmarking
      - HDD: CrystalDiskMark, ATTO SSD
      - SYSTEM:
        - PCMark 10
          - https://www.techspot.com/downloads/6986-pcmark-10.html
        - PassMark
          - https://www.passmark.com/products/performancetest/download.php
        - UserBenchmark
          - https://cpu.userbenchmark.com/
          - https://www.userbenchmark.com/resources/download/UserBenchmarkSetup.exe
        - **AnTuTu**
    - ext2explore - mounting ext2/3/4 partitions and browsing its content
    - dalsie programy
      - internetove prehliadace: Firefox, Chrome, ...
      - multimedialne prehravace: VLC, ...
      - hry, ...

  - vycistit disk
    1. `df -h` v Git Bash/WSL
        - https://duckduckgo.com/?q=df+utility+powershell+equivalent&ia=web
        - https://rpartlan.tumblr.com/post/97013776609/unix-df-ht-in-powershell
        
    1. Skriptom `../windows_cleaner`
    1. Overit vycistenie nastrojom "Cistenie disku"
        - Otvorime si "Tento pocitac" -> pravy klik na disk "C:\" (systemovy disk)
          - "Vseobecne" (General) karta
            - klikneme na tlacidlo "Disk Clean-up"
            - oznacime vsetko
            - klikneme na "Vymazat systemove subory" (Clean-up system files)
            - oznacime vsetko
          - karta "Dalsie moznosti"(More options)
            - ak chceme, mozeme ist do karty  a povymazavat programy a body obnovy
          - vratime sa spat na kartu "Vseobecne" (General)
          - vymazavanie spustime tlacidlom OK
          - objavi sa dialogove okno, v ktorom potvrdime vymazavanie tlacidlom 
            "Vymazat subory" (Delete Files)
          - trvanie vymazavania dat je zavisle od ich mnozstva a rychlosti disku
        
Konfiguracia trva 3-24 hodin, podla rychlosti pocitaca, mnozstva programov, mnozstva aktualizacii a tempa administratora.

### Zdroje
- https://www.youtube.com/watch?v=--jlkMiRudw
- https://www.youtube.com/watch?v=SaYbFmB2rDw
- https://www.howtogeek.com/howto/windows-vista/display-my-computer-icon-on-the-desktop-in-windows-vista/
- https://www.tenforums.com/tutorials/7808-use-dism-repair-windows-10-image.html
