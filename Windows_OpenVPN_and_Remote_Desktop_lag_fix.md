1. Powershell in user mode: check MTU sizes

        netsh interface ipv4 show subinterfaces

1. Change the `MTU_SIZE` until you get a non-fragmented ping.

    Start with the value `1500` then decrease or increase the value by the bisection algorithm.

        ping /f <DESTINATION_IP_THROUGH_VPN> /l <MTU_SIZE> /n 1
    
    e.g.

        ping /f 192.168.100.1 /l 1500 /n 1
	
    Find the highest MTU value for which the packet passes through in one piece without message `Packet needs to be fragmented but DF set.`
        
    You may check the error code of the `ping` utility with command `echo $?`
	
    - https://www.thegeekpub.com/271035/openvpn-mtu-finding-the-correct-settings/
    - https://duckduckgo.com/?q=ping+windows+help&ia=web
    - https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/ping

    Example from a Windows machine
    
    ```
    PS C:\Users\Cfl> ping /f github.com /l 1500 /n 1

    Pinging github.com [140.82.121.4] with 1500 bytes of data:
    Packet needs to be fragmented but DF set.

    Ping statistics for 140.82.121.4:
        Packets: Sent = 1, Received = 0, Lost = 1 (100% loss),

    PS C:\Users\Cfl> ping /f github.com /l 1400 /n 1

    Pinging github.com [140.82.121.4] with 1400 bytes of data:
    Reply from 140.82.121.4: bytes=1400 time=25ms TTL=245

    Ping statistics for 140.82.121.4:
        Packets: Sent = 1, Received = 1, Lost = 0 (0% loss),
    Approximate round trip times in milli-seconds:
        Minimum = 25ms, Maximum = 25ms, Average = 25ms

    PS C:\Users\Cfl> ping /f github.com /l 1450 /n 1

    Pinging github.com [140.82.121.4] with 1450 bytes of data:
    Reply from 140.82.121.4: bytes=1450 time=35ms TTL=245

    Ping statistics for 140.82.121.4:
        Packets: Sent = 1, Received = 1, Lost = 0 (0% loss),
    Approximate round trip times in milli-seconds:
        Minimum = 35ms, Maximum = 35ms, Average = 35ms

    PS C:\Users\Cfl> ping /f github.com /l 1475 /n 1

    Pinging github.com [140.82.121.4] with 1475 bytes of data:
    Packet needs to be fragmented but DF set.

    Ping statistics for 140.82.121.4:
        Packets: Sent = 1, Received = 0, Lost = 1 (100% loss),

    PS C:\Users\Cfl> ping /f github.com /l 1463 /n 1

    Pinging github.com [140.82.121.4] with 1463 bytes of data:
    Reply from 10.10.10.1: Packet needs to be fragmented but DF set.

    Ping statistics for 140.82.121.4:
        Packets: Sent = 1, Received = 1, Lost = 0 (0% loss),

    PS C:\Users\Cfl> ping /f github.com /l 1451 /n 1

    Pinging github.com [140.82.121.4] with 1465 bytes of data:
    Packet needs to be fragmented but DF set.

    Ping statistics for 140.82.121.4:
        Packets: Sent = 1, Received = 0, Lost = 1 (100% loss),

    PS C:\Users\Cfl> ping /f github.com /l 1457 /n 1

    Pinging github.com [140.82.121.3] with 1457 bytes of data:
    Packet needs to be fragmented but DF set.

    Ping statistics for 140.82.121.3:
        Packets: Sent = 1, Received = 0, Lost = 1 (100% loss),

    PS C:\Users\Cfl> ping /f github.com /l 1453 /n 1

    Pinging github.com [140.82.121.3] with 1453 bytes of data:
    Packet needs to be fragmented but DF set.

    Ping statistics for 140.82.121.3:
        Packets: Sent = 1, Received = 0, Lost = 1 (100% loss),

    PS C:\Users\Cfl> ping /f github.com /l 1452 /n 1

    Pinging github.com [140.82.121.3] with 1452 bytes of data:
    Reply from 140.82.121.3: bytes=1452 time=28ms TTL=245

    Ping statistics for 140.82.121.3:
        Packets: Sent = 1, Received = 1, Lost = 0 (0% loss),
    Approximate round trip times in milli-seconds:
        Minimum = 28ms, Maximum = 28ms, Average = 28ms
    ```
    
    Example from my linux machine
    
    ```
    $ ping -M do -s 1433 -c 1 8.8.8.8
    PING 8.8.8.8 (8.8.8.8) 1433(1461) bytes of data.
    From 192.0.0.2 icmp_seq=1 Frag needed and DF set (mtu = 1474)

    --- 8.8.8.8 ping statistics ---
    1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms

    $ echo $?
    1
    $ ping -M do -s 1432 -c 1 8.8.8.8
    PING 8.8.8.8 (8.8.8.8) 1432(1460) bytes of data.
    76 bytes from 8.8.8.8: icmp_seq=1 ttl=120 (truncated)

    --- 8.8.8.8 ping statistics ---
    1 packets transmitted, 1 received, 0% packet loss, time 0ms
    rtt min/avg/max/mdev = 33.508/33.508/33.508/0.000 ms
    $ echo $?
    0
    $ echo $(( 1461 - 1433 ))
    28
    $ echo $(( 1474 - 1433 ))
    41
    $ echo $(( 1432 + 28 ))
    1460
    $ echo $(( 1432 + 41 ))
    1473
    $
    ```
    
    The value `1480` byte is the maximum nonfragmented single-pass MTU size, and resulted as a sum of `1452` bytes base MTU size + `28` bytes ICMP header

1. Powershell in admin mode: change MTU sizes on all network adapters, including the OpenVPN interface:

    ```
    PS C:\Users\Cfl> 1452 + 28
    1480
    PS C:\Users\Cfl>  netsh interface ipv4 show subinterfaces

       MTU  MediaSenseState   Bytes In  Bytes Out  Interface
    ------  ---------------  ---------  ---------  -------------
    4294967295                1          0      61754  Loopback Pseudo-Interface 1
      1500                1  378930172   17361001  Pripojenie bezdrôtovej siete
      1500                5          0          0  Pripojenie bezdrôtovej siete 2
      1500                5          0          0  Sieťové pripojenie Bluetooth
      1500                5          0          0  Lokálne pripojenie

    PS C:\Users\Cfl> netsh interface ipv4 set subinterface "Pripojenie bezdrôtovej siete" mtu=1480 store=persistent
    Ok.

    PS C:\Users\Cfl>  netsh interface ipv4 show subinterfaces

       MTU  MediaSenseState   Bytes In  Bytes Out  Interface
    ------  ---------------  ---------  ---------  -------------
    4294967295                1          0      85745  Loopback Pseudo-Interface 1
      1480                1  379067967   17600302  Pripojenie bezdrôtovej siete
      1500                5          0          0  Pripojenie bezdrôtovej siete 2
      1500                5          0          0  Sieťové pripojenie Bluetooth
      1500                5          0          0  Lokálne pripojenie

    PS C:\Users\Cfl> netsh interface ipv4 set subinterface "Pripojenie bezdrôtovej siete 2" mtu=1460 store=persistent
    Ok.

    PS C:\Users\Cfl> netsh interface ipv4 set subinterface "Lokálne pripojenie" mtu=1480 store=persistent
    Ok.

    PS C:\Users\Cfl> netsh interface ipv4 set subinterface "Pripojenie bezdrôtovej siete 2" mtu=1480 store=persistent
    Ok.

    PS C:\Users\Cfl> netsh interface ipv4 set subinterface "Sieťové pripojenie Bluetooth" mtu=1480 store=persistent
    Ok.

    PS C:\Users\Cfl>  netsh interface ipv4 show subinterfaces

       MTU  MediaSenseState   Bytes In  Bytes Out  Interface
    ------  ---------------  ---------  ---------  -------------
    4294967295                1          0      85745  Loopback Pseudo-Interface 1
      1480                1  379110998   17619860  Pripojenie bezdrôtovej siete
      1480                5          0          0  Pripojenie bezdrôtovej siete 2
      1480                5          0          0  Sieťové pripojenie Bluetooth
      1480                5          0          0  Lokálne pripojenie
    ```

    - https://becomethesolution.com/how-to-change-and-check-windows-mtu-size

1. OpenVPN config - append these lines

    to adjust MTU size
    
        tun-mtu 1480

    If the connection issues still persist, adjust MSS size = `ADJUSTED_MTU_SIZE - OPENVPN_HEADER_SIZE = 1460 - 40 = 1420` bytes, but I rather let OpenVPN decide by itself, as it performs the size computing for me:

        mssfix max
	fragment
	
    --mssfix and --fragment can be ideally used together, where --mssfix will try to keep TCP from needing packet fragmentation in the first place, and if big packets come through anyhow (from protocols other than TCP), --fragment will internally fragment them.

    - https://duckduckgo.com/?q=openvpn+AEAD+Decrypt+error%3A+bad+packet+ID+(may+be+a+replay)&t=h_&ia=web
    - https://www.adamintech.com/how-to-fix-aead-decrypt-error-bad-packet-id-on-openvpn/
    - Google: openvpn header size
    - https://openvpn.net/community-resources/reference-manual-for-openvpn-2-4/

1. Fix warning message "WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this". Append to the config
    
        auth-nocache

    - https://duckduckgo.com/?q=auth-nocache+openvpn&t=h_&ia=web
