#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;TODO
;ctrl+a+s and ctrl+d+s (both fast lower diagonals) are not working
;add "tap ctrl for esc"
;refine key choices
;decide whether to use mod keys or toggle layers? (or do both!)
;add home, end, pgup, pgdown, volume, brightness, terminal key, key for triggering launchy / dmenu
;consider adding: 
	;f+1 chord = F1 key, (or f+q chord = F1 key for 40% style chording)
	;compose vim style statements (example: 100j moves cursor down 100 lines)
	;shortcut for reloading this script?


;---------------------------------------------------------------
;ahk layer manager:
;Alt+Space: switch layer

;layer 0: normal operation

;layer 1: wasd moves mouse, q left click, e right click
;CTRL: faster, ctrl+q: double-click
;Shift: slower, Shift+q: toggle left click for dragging
;j and k: mousescroll, h and l: mousewheel left/right

;LAYER 2: numpad
; m,. = 123, jkl = 456, uio = 789, Space = 0

Layer := 0 ;current layer
MaxLayer := 2 ;max layer: change if adding new layers
MouseSpeed := 25 ;pixels mouse moves; modified by ModSpeed
ModSpeed := 3 ;multiplies or divides mousespeed
LBdown := 0 ;state of toggling left mouse button (dragging)

;reload this script
^Enter:: Run, "C:\Users\Delta 6\Desktop\Literal Garbage\ahkscripts\mouse.ahk"
	return

;function for cycling through layers
SwitchLayer(Layer, MaxLayer)
{
	if (Layer < MaxLayer)
	{
		Layer := ++Layer
	}
	else
	{
		Layer := 0
		return 0
	}
	return Layer
}

;remove tooltip
RemoveToolTip:
	ToolTip
	return

;switch layer hotkey (default !Space)
!Space::
	{
	Layer := SwitchLayer(Layer, MaxLayer)
	ToolTip, Layer: %Layer%, 10, 10
	SetTimer, RemoveToolTip, 1000
	return
	}

;mouse mode
mousemode:
  Layer := 1
	ToolTip, Layer: %Layer%, 10, 10
	SetTimer, RemoveToolTip, 1000
	return
;normal mode
normalmode:
  Layer := 0
	ToolTip, Layer: %Layer%, 10, 10
	SetTimer, RemoveToolTip, 1000
	return

#w::gosub, mousemode
#a::gosub, mousemode
#s::gosub, mousemode
#d::gosub, mousemode
#j::gosub, mousemode
#l::
  Layer := 2
  ToolTip, Layer: %Layer%, 10, 10
  SetTimer, RemoveToolTip, 1000
  return
#Space::gosub, normalmode
~escape::gosub, normalmode

;layer 2
;numpad
#if (layer = 2)
{
	m::1
	,::2
	.::3
	j::4
	k::5
	l::6
	u::7
	i::8
	o::9
	Space::0
}

;layer 1
#if (Layer = 1)
{
  ;vim goodies
	h::MouseClick, WheelLeft
	l::MouseClick, WheelRight
	j::MouseClick, WheelDown
	k::MouseClick, WheelUp
;mouse movement with wasd
	w::MouseMove, 0, -MouseSpeed, 0, R
	a::MouseMove, -MouseSpeed, 0, 0, R
	s::MouseMove, 0, MouseSpeed, 0, R
	d::MouseMove, MouseSpeed, 0, 0, R
;click
	q::MouseClick, left
	e::MouseClick, right
  ~q & e::Click, middle
  ;toggle middle
  middle := 0
  z::
    if(middle = 0){
      Click, middle, down
      middle := 1
    }else{
      Click, middle, up
      middle := 0
    }
    return

;toggle left-click
	+q::
	{
		if (LBdown = 0){
			LBdown := 1
			Click, left, down
      ;SendInput, {LButton Down}
		}else{
      Click, left, up
			;SendInput, {LButton Up}
		}
	}
;Shift(slower)
	#if (GetKeyState("Shift") && Layer = 1)
	{
		+w::MouseMove, 0, -MouseSpeed / ModSpeed, 0, R
		+a::MouseMove, -MouseSpeed / ModSpeed, 0, 0, R
		+s::MouseMove, 0, MouseSpeed / ModSpeed, 0, R
		+d::MouseMove, MouseSpeed / ModSpeed, 0, 0, R
	}
;Ctrl(Faster)
	#if (GetKeyState("LCtrl") && Layer = 1)
	{
		^w::MouseMove, 0, -MouseSpeed * ModSpeed, 0, R
		^a::MouseMove, -MouseSpeed * ModSpeed, 0, 0, R
		^s::MouseMove, 0, MouseSpeed * ModSpeed, 0, R
		^d::MouseMove, MouseSpeed * ModSpeed, 0, 0, R
	}
;diagonals
	;slower diagonal movement
	#if (GetKeyState("Shift") && Layer = 1)
	{
		~w & a::MouseMove, -MouseSpeed / ModSpeed, -MouseSpeed / ModSpeed, 0, R
		~a & w::MouseMove, -MouseSpeed / ModSpeed, -MouseSpeed / ModSpeed, 0, R
		~w & d::MouseMove, MouseSpeed / ModSpeed, -MouseSpeed / ModSpeed, 0, R
		~d & w::MouseMove, MouseSpeed / ModSpeed, -MouseSpeed / ModSpeed, 0, R
		~a & s::MouseMove, -MouseSpeed / ModSpeed, MouseSpeed / ModSpeed, 0, R
		~s & a::MouseMove, -MouseSpeed / ModSpeed, MouseSpeed / ModSpeed, 0, R
		~s & d::MouseMove, MouseSpeed / ModSpeed, MouseSpeed / ModSpeed, 0, R
		~d & s::MouseMove, MouseSpeed / ModSpeed, MouseSpeed / ModSpeed, 0, R
	}
	;faster diagonal movement
	#if (GetKeyState("LCtrl") && Layer = 1)
	{
		~w & a::MouseMove, -MouseSpeed * ModSpeed, -MouseSpeed * ModSpeed, 0, R
		~a & w::MouseMove, -MouseSpeed * ModSpeed, -MouseSpeed * ModSpeed, 0, R
		~w & d::MouseMove, MouseSpeed * ModSpeed, -MouseSpeed * ModSpeed, 0, R
		~d & w::MouseMove, MouseSpeed * ModSpeed, -MouseSpeed * ModSpeed, 0, R
		~a & s::MouseMove, -MouseSpeed * ModSpeed, MouseSpeed * ModSpeed, 0, R
		~s & a::MouseMove, -MouseSpeed * ModSpeed, MouseSpeed * ModSpeed, 0, R
		~s & d::MouseMove, MouseSpeed * ModSpeed, MouseSpeed * ModSpeed, 0, R
		~d & s::MouseMove, MouseSpeed * ModSpeed, MouseSpeed * ModSpeed, 0, R
	}
	;standard diagonal movement
	#if (!GetKeyState("LCtrl") && Layer = 1)
	{
		~w & a::MouseMove, -MouseSpeed, -MouseSpeed, 0, R
		~a & w::MouseMove, -MouseSpeed, -MouseSpeed, 0, R
		~w & d::MouseMove, MouseSpeed, -MouseSpeed, 0, R
		~d & w::MouseMove, MouseSpeed, -MouseSpeed, 0, R
		~a & s::MouseMove, -MouseSpeed, MouseSpeed, 0, R
		~s & a::MouseMove, -MouseSpeed, MouseSpeed, 0, R
		~s & d::MouseMove, MouseSpeed, MouseSpeed, 0, R
		~d & s::MouseMove, MouseSpeed, MouseSpeed, 0, R
	}
}
