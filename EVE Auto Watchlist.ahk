#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SetTitleMatchMode 2
DetectHiddenWindows On
SetControlDelay 1
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
#UseHook
#Persistent
#SingleInstance force

F7::
	if Counter != 0
	{
		;WinGet, EVEWindow, List, ahk_class triuiScreen
		;get a list of all windows with title "EVE - *" and save to %EVEWindow%
		WinGet, EVEWindow, List, EVE - \w+
		Counter = 0
	}

	;if EVEWindow is not empty
	if EVEWindow != 0
	{
		;if EVEWindow has more than 1 eve client
		if EVEWindow != 1
		{
			Loop, %EVEWindow%
			{
				;MsgBox, %A_index%
				;Sleep, 100
				this_id := EVEWindow%A_Index%
				WinActivate, ahk_id %this_id%
				WinGetClass, this_class, ahk_id %this_id%
				WinGetTitle, this_title, ahk_id %this_id%
				WinGetPos, , , Width, Height, ahk_id %this_id%
				MsgBox, %this_title%
				;Main(Width, Height)
			}
		}else ;if only 1 eve client
		{
			this_id := EVEWindow%A_Index%
			WinActivate, ahk_id %this_id%
			WinGetClass, this_class, ahk_id %this_id%
			WinGetTitle, this_title, ahk_id %this_id%
			WinGetPos, , , Width, Height, ahk_id %this_id%
			MsgBox, %this_title%
			;Main(Width, Height)
		}
	}else ;test return 0 if no EVE windows with characters
	{
		MsgBox, %EVEWindow%
	}
return

F8::
ROX:
IfWinExist, EVE - ROX ahk_class triuiScreen
{
	WinActivate, EVE - ROX ahk_class triuiScreen
	WinGetPos, , , Width, Height, EVE - ROX
	Main(Width, Height)
}
Return

Main(Width, Height){
	InitialMove()

	CoordMode, Pixel, Relative
	ImageSearch, FoundX, FoundY, 0, 0, Width, Height, *90 Resources\CH.png
	;added image search to get the bottom left of the brodcast window
	ImageSearch, FoundX2, FoundY2, 0, 0, Width, Height, *90 Resources\BC.png
	Sleep, 10
	If ErrorLevel = 0
	{
		;MsgBox, %FoundX%x%FoundY% 2
		TargetRed(FoundX2, FoundY2, FoundX, FoundY)
		Sleep, 50
	}

	;CheckAfterburner()
	
	;CheckResistance()
}

;method for targeting red
TargetRed(X1, Y1, X2, Y2){
	CoordMode, Pixel, Relative
	ImageSearch, FoundX, FoundY, X1, Y1, X2, Y2, *50 Resources\TG.png
	if ErrorLevel = 0
	{
		Loop 
		{
			
		}
	}
}

CheckAfterburner(){
	;check for afterburner
	CoordMode, Pixel, Relative
	ImageSearch, FoundX, FoundY, 0, 0, Width, Height, *99 *Trans0xFFFFFF Resources\AB.png
	Sleep, 50
	If ErrorLevel = 0
	{
		Sleep, 50
		CoordMode, Pixel, Relative
		ImageSearch, FoundX, FoundY, 0, 0, Width, Height, *99 *Trans0xFFFFFF Resources\AB.png
		Sleep, 50
		If ErrorLevel = 0
		{
			Sleep, 50
			CoordMode, Pixel, Relative
			ImageSearch, FoundX, FoundY, 0, 0, Width, Height, *99 *Trans0xFFFFFF Resources\AB.png
			Sleep, 50
			If ErrorLevel = 0
			{
				Afterburner(FoundX, FoundY)
				InitialMove()
			}
		}
	}
}

CheckResistance(){
	;check for invulnerability field
	CoordMode, Pixel, Relative
	ImageSearch, FoundX, FoundY, 0, 0, Width, Height, *95 *Trans0xFFFFFF Resources\IF.png
	Sleep, 50
	If ErrorLevel = 0
	{
		Sleep, 50
		CoordMode, Pixel, Relative
		ImageSearch, FoundX, FoundY, 0, 0, Width, Height, *95 *Trans0xFFFFFF Resources\IF.png
		Sleep, 50
		If ErrorLevel = 0
		{
			Sleep, 50
			CoordMode, Pixel, Relative
			ImageSearch, FoundX, FoundY, 0, 0, Width, Height, *95 *Trans0xFFFFFF Resources\IF.png
			Sleep, 50
			If ErrorLevel = 0
			{
				Field(FoundX, FoundY)
				InitialMove()
			}
		}
	}
}

Afterburner(FoundX, FoundY){
	FoundX += 15
	FoundY += 15
	Sleep, 50
	Click, %FoundX%, %FoundY%, 0
	Sleep, 100
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Up
}

Field(FoundX, FoundY){
	FoundX += 18
	FoundY += 22
	Sleep, 50
	Click, %FoundX%, %FoundY%, 0
	Sleep, 100
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Up
}

InitialMove(){
	MoveX = 80
	MoveY = 40
	Click, %MoveX%, %MoveY%, 0
	Sleep, 10
	MoveX += 10
	Click, %MoveX%, %MoveY%, 0
	Sleep, 10
	MoveX += 10
	Click, %MoveX%, %MoveY%, 0
	Sleep, 10
	MoveX += 10
	Click, %MoveX%, %MoveY%, 0
	Sleep, 10
	MoveX += 10
	Click, %MoveX%, %MoveY%, 0
	Sleep, 10
	MoveX += 10
	MoveY += 10
	Click, %MoveX%, %MoveY%, 0
}

Orbit(FoundX, FoundY){
	FoundX += 39
	FoundY += 53
	Sleep, 50
	Click, %FoundX%, %FoundY%, 0
	Sleep, 100
	Click, %FoundX%, %FoundY% Right, Down
	Sleep, 50
	Click, %FoundX%, %FoundY% Right, Up
	
	FoundX += 40
	FoundY += 20
	Sleep, 100
	Click, %FoundX%, %FoundY%, 0

	FoundX += 140
	FoundY += 80
	Sleep, 100
	Click, %FoundX%, %FoundY%, 0
	Sleep, 100
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Up
}

ClickLock(FoundX, FoundY){
	FoundX += 39
	FoundY += 33
	Sleep, 50
	Send, {LControl Down}
	;00----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;01----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;02----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;03----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;04----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;05----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;06----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;07----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;08----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;09----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;10----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;11----------------------------------------------
	Sleep, 30
	Click, %FoundX%, %FoundY%, 0
	Sleep, 50
	Click, %FoundX%, %FoundY% Left, Down
	Sleep, 30
	Click, %FoundX%, %FoundY% Left, Up
	FoundY += 20
	;12----------------------------------------------
	Sleep, 30
	Send, {LControl Up}
	Click, 444, 222, 0
	Return
}

F9::
Reload
Sleep 1000
Reload
Sleep 2000
Reload
Sleep 3000
MsgBox, The script could not be reloaded.
return