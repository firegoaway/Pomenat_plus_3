#Persistent
#NoEnv
#SingleInstance, Force
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SendMode, Input
SetWorkingDir %A_ScriptDir%

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;EXTERNAL LIBRARIES START;;;;;;;;;;;;;;;;;;;;;;;
#Include graphicsearch.ahk\export.ahk
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;EXTERNAL LIBRARIES END;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GUI START;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GUI END;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GuiClose:
	ExitApp

GuiEscape:
	Hotkey, Esc, TerminateApp

MsgBox, 4096, Инструкция, 1. Откройте окно Fenix+ `n2. Откройте перечень всех помещений во вкладке "Компонентное" `n3. Поместите курсор мыши в окно вьюпорта `n4. Убедитесь, что все помещения пустые (нет людей и твёрдых тел) `n5. Нажмите "Z" на клавиатуре `n6. Дождитесь окончания процесса. `n`nНажмите "Esc" на клавиатуре, чтобы закрыть программу.
MsgBox, 4096, Начало, Ожидание нажатия клавиши Z...

HotkeyZ:
KeyWait, Z, D
KeyWait, Z

While (A_Index <= Pom_OAN) {
	#Include Pom_Hierarchy_B.ahk	; Ищем помещение в иерархии
	if (resultObj != 0) {
		MouseMove, X, Y
		Send, {LButton 1}
	}
	else {
		MsgBox, На экране не найдено ни одной надписи "Помещение".
		Break
	}
	#Include Pom_prop.ahk	; Ищем помещение в свойствах
	if (resultObj != 0) {
		MouseMove, X, Y
		Send, {LButton 2}
	}
	else {
		MsgBox, На экране не найдено ни одной надписи "Помещение".
		Break
	}
	#Include Pom_Hierarchy_C.ahk	; Возвращаемся к исходной позиции
	if (resultObj != 0) {
		MouseMove, X, Y
		Send, {LButton 1}
	}
	else {
		MsgBox, На экране не найдено ни одной надписи "Помещение".
		Break
	}
}
Goto, HotkeyZ
Return

TerminateApp:
	ExitApp
