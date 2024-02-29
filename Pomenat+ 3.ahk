#Persistent
#NoEnv
#SingleInstance, Force
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SendMode, Input
SetWorkingDir %A_ScriptDir%

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GUI START;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, Add, Text, , Введите общее количество помещений в сценарии:
Gui, Add, Edit, vUserInput
Gui, Add, Button, Default gSubmitButton, Submit
Gui, Add, Text, vResultLabel

Gui, Show, w300 h100, Input GUI

Return	; Чтобы скрипт не терминировался раньше времени

SubmitButton:
	Gui, Submit, NoHide
	Pom_OAN := UserInput
	if Pom_OAN = ""	; Проверка пустоты
	{
		MsgBox, Поле не должно быть пустым!
		Return
	}
	if not RegExMatch(Pom_OAN, "^\d+$")	; Проверка на целое положительное
	{
		MsgBox, Введите целое положительное число!
		Return
	}
	if Pom_OAN <= 0	; Проверка на ноль
	{
		MsgBox, Число не должно равняться нулю!
		Return
	}
	GuiControl,, ResultLabel, Количество помещений: %Pom_OAN%
	Gui, Destroy
	Goto GuiEscape
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GUI END;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GuiClose:
	ExitApp

GuiEscape:

Hotkey, Esc, TerminateApp

MsgBox % "Ожидание нажатия клавиши Z, чтобы начать..."

KeyWait, Z, D
KeyWait, Z

While (A_Index <= Pom_OAN) {
	#Include Pom_Hierarchy_B.ahk	; Ищем помещение в иерархии
		MouseMove, X, Y
		Send, {LButton 1}

	#Include Pom_prop.ahk	; Ищем помещение в свойствах
		MouseMove, X, Y
		Send, {LButton 2}
	
	#Include Pom_Hierarchy_C.ahk	; Возвращаемся к исходной позиции
		MouseMove, X, Y
		Send, {LButton 1}
}
Return

TerminateApp:
	ExitApp
