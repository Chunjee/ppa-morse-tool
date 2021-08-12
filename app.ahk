SetBatchLines, -1
#SingleInstance, Force
#NoTrayIcon

#Include %A_ScriptDir%\node_modules
#Include morse.ahk\export.ahk


morse := new morse()
morse.dict["/"] := " " ; define "/" as a space or new word
inputString := ""

; middle click
~MButton::
	; detect double middle-click
    if (A_TimeSincePriorHotkey < 400) && (A_TimeSincePriorHotkey <> -1) {
        SoundBeep, 1000, 200
		; decode user input and msgbox if detection is already triggered
		if (captureInput) {
			result := morse.decode(inputString)
			msgbox, % result
			; reset input string and detection
			inputString := ""
			captureInput := false
			return
		}
		captureInput := true
    }
	; handle middle-click as space between characters
	if (captureInput) {
		inputString .= " "
	}
return

; left click
~LButton::
	if (captureInput) {
		inputString .= "."
	}
return

; right click
~RButton::
	if (captureInput) {
		inputString .= "/"
	}
return
