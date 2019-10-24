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
;TODO:
;assign delete (x?)
;set better command for mod+tab (currently mod+h and mod+space)
;finish help
;-------------------------------
;modes:
;0 = insert,
;1 = command mode(vim),
;2 = numpad,
;3 = mouse,
;4 = disabled(not yet implemented)

mode := 0

;command (vim) mode
#if (mode = 1)
	{
		;show help!
		+/::
		Run, cmd /c vim "C:\Users\Delta_6\Desktop\Literal Garbage\ahkscripts\autohotkey-scripts\commands"
		return
		
		;set mouse mode
		s:: mode:=3
		;set insert mode
		i:: mode := 0
		+i:: 
			send, {home}
			mode := 0
			return
		Space::PgDn
		b::PgUp
		u::^z
		;+u up::^y
		a:: mode := 0
		+a::
			send, {end}
			mode := 0
			return
		d::
			send, {home}
			send, +{end}
			send, {delete}
			return
		^s::^s
		#j::!Tab
		#k::+!Tab
		#h::#Tab
		#l::Enter
		#Space::#Tab
		^j::^Tab
		^k::+^Tab
		j:: send, {Down}
		k:: send, {Up}
		l:: send, {Right}
		h:: send, {Left}
		+j:: send, +{Down}
		+k:: send, +{Up}
		+l:: send, +{Right}
		+h:: send, +{Left}
		g:: send, ^{Home}
		+g:: send, ^{End}
		/:: ^f
		r:: send, {F5}
		+r::
			return
		n:: send, {^g}
		+n:: send, {^!g}
		^n:: mode := 2
		t::^t
		+t::
			return
		;set x to delete?
		x::send, ^w
		+x:: ^+t
		
		m:: mode := 2
		+m::
		q::
		w::
		e::
			return
		+e::send, F10
		y::send, ^c
		+y::send, ^x
		p::send, ^v
		+p::
		o::
		+o::
		f::
		+f::
		z::
		+z::
		c::
		+c::
		v::
		+v::
		+b::
		,::
		.::
		+,::
		+.::
		1::
		2::
		3::
		4::
		5::
		6::
		7::
		8::
		9::
		0::
		-::
		=::
		[::
		]::
		\::
		`;::
		'::
			return
	}
#if

;mouse mode
#if (mode = 3)
	{
		;mouse movement
		a::MouseMove, -MouseSpeed, 0, 0, R
		^a::MouseMove, -MouseSpeed * ModSpeed, 0, 0, R
		+a::MouseMove, -MouseSpeed / ModSpeed, 0, 0, R
		s::MouseMove, 0, MouseSpeed, 0, R
		^s::MouseMove, 0, MouseSpeed * ModSpeed, 0, R
		+s::MouseMove, 0, MouseSpeed / ModSpeed, 0, R
		d::MouseMove, MouseSpeed, 0, 0, R
		^d::MouseMove, MouseSpeed * ModSpeed, 0, 0, R
		+d::MouseMove, MouseSpeed / ModSpeed, 0, 0, R

		q::MouseClick, left
		+q::
		!q::MouseClick, left
		w::MouseMove, 0, -MouseSpeed, 0, R
		^w::MouseMove, 0, -MouseSpeed * ModSpeed, 0, R
		+w::MouseMove, 0, -MouseSpeed / ModSpeed, 0, R
		e::MouseClick, right
		!e::MouseClick, right
		;+e::MouseClick, right

		;diagonal mouse movement
		~w & a::MouseMove, -MouseSpeed, -MouseSpeed, 0, R
		~a & w::MouseMove, -MouseSpeed, -MouseSpeed, 0, R
		~w & d::MouseMove, MouseSpeed, -MouseSpeed, 0, R
		~d & w::MouseMove, MouseSpeed, -MouseSpeed, 0, R
		~a & s::MouseMove, -MouseSpeed, MouseSpeed, 0, R
		~s & a::MouseMove, -MouseSpeed, MouseSpeed, 0, R
		~s & d::MouseMove, MouseSpeed, MouseSpeed, 0, R
		~d & s::MouseMove, MouseSpeed, MouseSpeed, 0, R
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
		send, {Esc}
		mode := 1
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