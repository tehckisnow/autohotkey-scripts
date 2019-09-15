#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, Force
CoordMode, ToolTip, Screen

MouseSpeed := 25 ;pixels mouse moves; modified by ModSpeed
ModSpeed := 3 ;multiplies or divides mousespeed
LBdown := 0 ;state of toggling left mouse button (dragging)
middle := 0

;init msg
ToolTip, Script init, 10, 10, 1
SetTimer, RemoveToolTip, 1000

;remove tooltip
RemoveToolTip:
	ToolTip
	return

;reload this script
^Enter:: Run, "C:\Users\Delta_6\Desktop\Literal Garbage\ahkscripts\autohotkey-scripts\simple.ahk"
  return

;-------------------------------
;toggle vim mode experiment
;modes: 0 = insert, 1 = vim, 2 = numpad, 3 = disabled(not yet implemented)
mode := 0

;switch to insert mode
Esc:: mode := 1

;vim mode
#if (mode = 1)
	{
		i:: mode := 0
		j:: send, {Down}
		k:: send, {Up}
		l:: send, {Right}
		h:: send, {Left}
		g:: send, {Home}
		+G:: send, {End}
		/:: send, {^f}
		r:: send, {F5}
		n:: send, {^g}
		+n:: send, {^!g}
		t:: send, {^t}
		x:: send, {^F4}
		+x:: send, {^+n}
		m:: mode := 2
		return
	}
#if

;num mode
#if (mode = 2)
	{
	j::send, 1
	k::send, 2
	l::send, 3
	u::send, 4
	i::send, 5
	o::send, 6
	7::send, 7
	8::send, 8
	9::send, 9
	0::send, 0
	m::send, 0
	return
	}
#if
;--------------------------------

;vim basics
!j::send, {Down}
!k::send, {Up}
!h::send, {Left}
!l::send, {Right}
!g::send, {Home}
!+g::send, {End}
!/::send, {^f}
!BS::send, {Delete}
!r::send, {F5}

!n::send, {^g}
!+n::send, {^!g}
!t::send, {^t}
!x::send, {^F4}
!+x::send, {^+n}

;numpad
+!j::send, 1
+!k::send, 2
+!l::send, 3
+!u::send, 4
+!i::send, 5
+!o::send, 6
+!7::send, 7
+!8::send, 8
+!9::send, 9
+!0::send, 0
+!m::send, 0

;generic key combos
#+q::Send !{F4}
#q::Send !{F4}
#c::Run, C:\SoftwareOK\Q-Dir\Q-Dir.exe
#z::Run, firefox.exe
#n::Run, notepad++.exe
#Enter::Run, cmd /K C:\Users\"Delta_6"\Desktop\"Literal Garbage"\aliases.cmd

#+z::
	Send, ^c
	ClipWait ;waits for the clipboard to have content
	Run, chrome.exe "%clipboard%
  Return

;tap capslock(left control) for esc, hold for lctrl
~lctrl::
	send {lctrl}
	time:=0
	while (getKeyState(trim(a_thishotkey, "~*<>!#^+"), "P"))
	{
		sleep, 100
		time+=1
	}
	toolTip
  return

lctrl up::
	if (time<=3)
		send {escape}
	;else
		;send {lctrl}
  return

;mouse movement
;mouse movement with wasd
	!w::MouseMove, 0, -MouseSpeed, 0, R
	!a::MouseMove, -MouseSpeed, 0, 0, R
	!s::MouseMove, 0, MouseSpeed, 0, R
	!d::MouseMove, MouseSpeed, 0, 0, R
;click
	!q::MouseClick, left
	!e::MouseClick, right

~q & e::Click, middle
  ;toggle middle
  !z::
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
	#if (GetKeyState("Shift"))
	{
		!+w::MouseMove, 0, -MouseSpeed / ModSpeed, 0, R
		!+a::MouseMove, -MouseSpeed / ModSpeed, 0, 0, R
		!+s::MouseMove, 0, MouseSpeed / ModSpeed, 0, R
		!+d::MouseMove, MouseSpeed / ModSpeed, 0, 0, R
	}
;Ctrl(Faster)
	#if (GetKeyState("LCtrl"))
	{
		!^w::MouseMove, 0, -MouseSpeed * ModSpeed, 0, R
		!^a::MouseMove, -MouseSpeed * ModSpeed, 0, 0, R
		!^s::MouseMove, 0, MouseSpeed * ModSpeed, 0, R
		!^d::MouseMove, MouseSpeed * ModSpeed, 0, 0, R
	}

;diagonals
	;slower diagonal movement
	#if (GetKeyState("Shift"))
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
	#if (GetKeyState("LCtrl"))
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
	#if (GetKeyState("LAlt"))
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