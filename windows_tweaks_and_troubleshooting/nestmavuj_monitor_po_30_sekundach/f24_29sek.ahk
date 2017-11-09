;Neznasam, ked si Windows robi, co sa mu zachce bez toho, aby som mu to prikazal.
;Preto som sa rozhodol napisat tento skript.
;Toto je skript vhodny hlavne pre notebooky, ktorym sa automaticky stmavuje obrazovka a 
;Windows aj po vypnuti casovaca na stmavovanie obrazovky, obrazovku tvrdohlavo stmavuje po 30
;sekundach. Riesenim je tento skript, ktory stlaci klavesu F24 kazdych 29 sekund.

#Persistent
SetTimer, PressTheKey, 29000
Return

PressTheKey:
Send, {F24 down}
Send, {F24 up}
Return