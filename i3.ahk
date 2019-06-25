
; //linux i3 shortcuts

#c::
	Run, C:\SoftwareOK\Q-Dir\Q-Dir.exe
Return

#z::
	Run, firefox.exe
Return

#+z::
	Send, ^c
	ClipWait ;waits for the clipboard to have content
	Run, chrome.exe "%clipboard%
Return

#n::
	Run, notepad++.exe
Return

#g::
	Run, C:\Users\chetw\AppData\Local\GitHubDesktop\GitHubDesktop.exe
Return

#x::
	Run, SnippingTool.exe
Return

#+q::
	Send !{F4}
Return

#Enter::
	Run, cmd /K C:\Users\"Delta 6"\Desktop\"Literal Garbage"\aliases.cmd
Return

;tap capslock(left control) for esc, hold for lctrl
~lctrl::
	send {lctrl}
	time:=0
	while (getKeyState(trim(a_thishotkey, "~*<>!#^+"), "P"))
	{
		sleep, 100
		time+=1
		;toolTip, % "you have held down for: " time "/10's of a second"
	}
	toolTip
return

lctrl up::
	if (time<=3)
		send {escape}
	;else
		;send {lctrl}
return
