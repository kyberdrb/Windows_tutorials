1. Powershell in user mode: check MTU sizes

        netsh interface ipv4 show subinterfaces

1. Change the `MTU_SIZE` until you get a non-fragmented ping.

    Start with the value `1500` then decrease or increase the value by the bisection algorithm.

        ping /f <DESTINATION_IP_THROUGH_VPN> /l <MTU_SIZE> /n 1
    
    e.g.

        ping /f 192.168.100.1 /l 1500 /n 1
        
    You may check the error code of the `ping` utility with command `echo $?`
	
    - https://www.thegeekpub.com/271035/openvpn-mtu-finding-the-correct-settings/
    - https://duckduckgo.com/?q=ping+windows+help&ia=web
    - https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/ping
    
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
    
    The value `1460` byte is the maximum nonfragmented single-pass MTU size, and resulted as a sum of `1432` bytes base MTU size + `28` bytes ICMP header

1. Powershell in admin mode: change MTU sizes on all network adapters, including the OpenVPN interface:

        netsh interface ipv4 set subinterface "OpenVPN Wintun" mtu=1460 store=persistent

    - https://becomethesolution.com/how-to-change-and-check-windows-mtu-size

1. OpenVPN config - append these lines

    to adjust MTU size
    
        tun-mtu 1460

    If the connection issues still persist, adjust MSS size = `ADJUSTED_MTU_SIZE - OPENVPN_HEADER_SIZE = 1460 - 40 = 1420` bytes

        mssfix 1420

    - https://duckduckgo.com/?q=openvpn+AEAD+Decrypt+error%3A+bad+packet+ID+(may+be+a+replay)&t=h_&ia=web
    - https://www.adamintech.com/how-to-fix-aead-decrypt-error-bad-packet-id-on-openvpn/

1. Fix warning message "WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this". Append to the config
    
        auth-nocache

    - https://duckduckgo.com/?q=auth-nocache+openvpn&t=h_&ia=web
