; Backup all tabs from a browser

Opt("WinTitleMatchMode", 2)

Const $browser = "Chrome"

WinActivate($browser)
WinWaitActive($browser)

While true
  Sleep(1000)
  
  Send("^l")

  Sleep(500)

  Send("^c")

  WinActivate("Notepad++")
  WinWaitActive("Notepad++")

  Send("^v")
  Send("{ENTER 2}")

  Sleep(1000)

  WinActivate($browser)
  WinWaitActive($browser)

  Send("^{PGDN}")
WEnd

;Sources
;https://alternativeto.net/software/autoit/
;https://www.autoitscript.com/site/autoit/downloads/
;https://www.autoitscript.com/autoit3/docs/
;https://www.autoitscript.com/autoit3/docs/intro/lang_variables.htm
;https://www.autoitscript.com/autoit3/docs/tutorials/regexp/regexp.htm
;https://www.autoitscript.com/autoit3/docs/tutorials/notepad/notepad.htm
;https://www.autoitscript.com/autoit3/docs/functions.htm
;https://www.autoitscript.com/autoit3/docs/functions/Sleep.htm
;https://www.autoitscript.com/autoit3/docs/appendix/SendKeys.htm
;https://www.autoitscript.com/autoit3/docs/functions/Send.htm
;https://www.autoitscript.com/autoit3/docs/tutorials/helloworld/helloworld.htm
;https://www.autoitscript.com/autoit3/docs/keywords.htm
;https://www.autoitscript.com/autoit3/docs/keywords/While.htm
;https://duckduckgo.com/?q=autoit+alt+tab&ia=web
;https://www.eipiplusone.com/computers/code/autoit-alt-tab-switcher
;https://duckduckgo.com/?q=opt+WinTitleMatchMode+autoit&ia=web
;https://www.autoitscript.com/forum/topic/127474-wintitlematchmode/
