#Persistent
#SingleInstance, Force

;;;;;;;;;;;;;;;;;;;;;;;EXTERNAL LIBRARIES START;;;;;;;;;;;;;;;;;;;;;;;
#Include graphicsearch.ahk\export.ahk
;;;;;;;;;;;;;;;;;;;;;;;EXTERNAL LIBRARIES END;;;;;;;;;;;;;;;;;;;;;;;;;

SendMode, InputThenPlay
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
; SetBatchLines, 1000ms
SetWorkingDir %A_ScriptDir%

;;;;;;;;;;;;;;;;;;;;;;;;GUI START;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, Add, Text, , Введите общее количество помещений в сценарии:
Gui, Add, Edit, vUserInput
Gui, Add, Button, Default gSubmitButton, Submit
Gui, Add, Text, vResultLabel

Gui, Show, w300 h100, Pomenat+ 3

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

GuiClose:
	ExitApp

GuiEscape:
	Hotkey, Esc, TerminateApp
;;;;;;;;;;;;;;;;;;;;;;;;GUI END;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MsgBox, 4096, Инструкция, Перед началом использования убедитесь, что в пожарной модели расставлены только помещения, без людей и горючей нагрузки. `nВ противном случае утилита может подлагивать в процессе переименования. `n`n1. Откройте окно Fenix+ 3 `n2. Раскройте перечень всех помещений во вкладке "Компонентное" `n3. Поместите курсор мыши в окно вьюпорта `n4. Нажмите "Z" на клавиатуре `n5. Дождитесь окончания процесса `n`nВо время работы утилиты, не трогайте мышь и не нажимайте кнопки на клавиатуре. `n`nНажмите "Esc" на клавиатуре в любой момент, чтобы принудительно завершить работу утилиты. `n`nРекомендации перед запуском: `n1. Раскрыть сценарий, чтобы были видны все этажи и их содержимое `n2. Перейти во вкладку "Компонентное" и раскрыть список помещений `n3. Закрыть вкладку со сценарием в окне вьюпорта. `n`nЕсли у вас два монитора, то Fenix+ 3 должен быть открыт во весь экран на основном мониторе.

Loop
{
	FenixExist := WinExist("ahk_exe Fenix.exe")
	if FenixExist
	{
		Loop
		{
			ToolTip, Ожидание нажатия клавиши Z...
			ZIsDown := GetKeyState("Z")
		} Until (ZIsDown = 1)
		WinActivate, ahk_exe Fenix.exe
		FenixActive := WinActive("ahk_exe Fenix.exe")
		if !FenixActive
		{
			ToolTip, Ожидание открытия окна Fenix+ 3...
		}
	}
	else
	{
		ToolTip, Ожидание запуска Fenix+ 3...
		Continue
	}
} Until (FenixExist)

;;;;;;;;;;;;;;;;;;;;;;;;VARIABLE DECLARATION START;;;;;;;;;;;;;;;;;;;;
t1 := A_TickCount
X := ""
Y := ""

;;;;QUERIES START;;;;
Query .= "|<>*161$65.zU0000000013000000000260000000004AwEXYGC9cncPAn8cYWnH8ko9aTN9xybTVcHIUmG3BKV3NZd14Y6PBW6S/FvzbgqFs000001000000000020000E"
Query .= "|<>**50$66.zU000000000VU000000000VU000000000VbbCQqFnBaSVgrAWqG/BimVcHAyqHvxyzVcHwUqG3BKUVgqokqH3BqklbaqyztvBaS0000008000000000080000U"
Query .= "|<>#492@0.66$65.zU00000000110000000002200000000044wEXYGC8cXc/4n8cYWFH8kI9aTF9wyYTUcH4UWG15EV1MZd14Y2/1W2S/FvzbYK1s000001000000000020000E"
;;;;;QUERIES END;;;;;

ZeroX := ZeroY := 0

PomIndex := A_Index
;;;;;;;;;;;;;;;;;;;;;;;;VARIABLE DECLARATION END;;;;;;;;;;;;;;;;;;;;;;

Loop, % Pom_OAN
{
	resultObj := graphicsearch.search(Query, {x1: 0, y1: 0, x2: 424, y2: 1078})
	if (Round(resultObj.MaxIndex()) < 1)
	{
		SendMouse_AbsoluteMove(X, Y)
			Sleep, 250
		SendInput {LButton}
			Sleep, 250
		SendInput % "{Down " 20 - Sqrt(Ln(PomIndex)) "}"
			Sleep, 500
	}
	for i,v in resultObj
	{
		if (resultObj) && (i <= Round(resultObj.MaxIndex()))
		{
			X := resultObj[i].x
			Y := resultObj[i].y
			; Comment := resultObj[i].id ; На случай, если в дальнейшем будем привязываться к окну программы через WinGet
			graphicsearch.mouseTip(resultObj[i].x, resultObj[i].y)
			SendMouse_AbsoluteMove(X, Y) ; DllCall("mouse_event", uint, 1, int, X*1.334, int, Y*1.335, uint, 0, int, 0), Sleep, 1000
				ToolTip, % "Found :`t" Round(resultObj.MaxIndex())
				. "`n`nTime  :`t" (A_TickCount-t1) " ms"
				. "`n`nPos   :`t" X ", " Y
				. "`n`nResult:`t" (resultObj ? "Success !" : "Failed !")
				; . "`n`nComment:`t" Comment
				Sleep, 150
			SendInput {LButton}
				ToolTip, LButton sent once
				Sleep, 100
			SendInput {F2}
				ToolTip, F2 sent
				Sleep, 100
			SendInput {Left}
				ToolTip, Left sent
				Sleep, 100
			SendInput +^{Right}
				ToolTip, Right sent
				Sleep, 100
			SendInput {BackSpace}
				ToolTip, BackSpace sent
				Sleep, 100
			SendInput {Enter}
				ToolTip, Enter sent
				Sleep, 50
				ToolTip
			PomIndex++
			resultObj--
			SendMouse_AbsoluteMove(ZeroX, ZeroY)
				Sleep, 150
		}
		else
		{
			Break
			MsgBox, % "Round(resultObj.MaxIndex()) is " Round(resultObj.MaxIndex())
		}
	}
} Until (PomIndex >= Pom_OAN)

MsgBox, 4096, Tip, % "Программа завершила работу. `n`nПереименовано помещений:`t" Pom_OAN

SendMouse_AbsoluteMove(x, y)
{
	static SysX, SysY
	If (SysX = "")
		SysX := 65535//A_ScreenWidth, SysY := 65535//A_ScreenHeight
	DllCall("mouse_event", "UInt", 0x8001, "UInt", x*SysX, "UInt", y*SysY)
}

TerminateApp:
	ExitApp
Return

Esc::
	ExitApp
Return
