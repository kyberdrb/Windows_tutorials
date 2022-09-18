run android apps on windows 11

1. Enable `Virtual Machine Platform` in `Windows Features`, i.e. `Turn Windows features on or off`

1. Install Amazon AppStore

        winget install 9p3395vx91nr -s msstore

1. Launch `Windows Subsystem for Android`

    Did, but it errored out on message
    
        WsaClient.exe - System Error

        The system detected an overrun of a stack-based buffer in this application. This overrun potentially allow a malicious user to gain control of this application.

    So I uninstalled it. Following steps are irrelevant, because the system didn't even started. Abandoning... with disappointment... again.

1. Log in to Amazon AppStore. When you don't have an account, create an an Amazon account by registering.

1. Install Android Debugging Bridge - ADB

    https://developer.android.com/studio/releases/platform-tools#downloads

1. Connect to the Windows Subsystem for Android - WSA - via ADB

1. Install an `apk` file into the WSA device

Sources:

- https://duckduckgo.com/?q=run+android+apps+on+windows+11&ia=web
- https://www.androidauthority.com/android-apps-on-windows-11-3048569/
- https://www.msn.com/en-us/news/technology/running-any-android-apps-on-windows-11/ar-AAPQ0Ei
- https://www.guidingtech.com/how-run-android-apps-windows-11/
- https://duckduckgo.com/?q=windows+subsystem+for+android+wsaclient.exe+the+system+detected+an+overrun+of+a+stack-based+buffer&ia=web
- https://answers.microsoft.com/en-us/windows/forum/all/the-system-detected-an-overrun-of-a-stack-based/82e9f8c3-ea8e-43c8-920d-d49befe7e5df
- https://www.reddit.com/r/WindowsHelp/comments/vlf02p/comment/ig89d7p/
- https://www.teamos.xyz/threads/windows-subsystem-for-android-wsa-with-google-apps-play-store-%E2%9A%A1-v2204-40000-19-0.181030/