; Press and hold 'Page Down ' key in a e.g. web browser - help for scrolling and searching in SoundCloud channels

; Switch to previous window - more generic
;Send, !{ESC}

; Google Chrome specific
WinActivate, ahk_exe chrome.exe
WinWaitActive, ahk_exe chrome.exe

Send, {Ctrl down}{Numpad2 down}
Send, {Numpad2 up}{Ctrl up}

Loop {
    Send, {PgDn down}
}

; Sources:
; https://www.autohotkey.com/docs/Tutorial.htm
; https://www.autohotkey.com/docs/KeyList.htm
; https://stackoverflow.com/questions/35971452/what-is-the-right-way-to-send-alt-tab-in-ahk/35976457#35976457
; https://www.autohotkey.com/docs/commands/Loop.htm
; https://autohotkey.com/board/topic/97911-winactivate-doest-work-fully-with-chrome/?p=616756
