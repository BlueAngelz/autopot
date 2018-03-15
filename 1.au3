#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
; Script Start - Add your code below here

 #AutoIt3Wrapper_UseX64=n
#RequireAdmin
#include <GUIConstantsEx.au3>
#include <GuiConstants.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <Memory.au3>
#include <NomadMemory.au3>
#include <EditConstants.au3>
#include <GuiEdit.au3>
#include <WindowsConstants.au3>
#include <ColorConstants.au3>

Global $XS_n
Global $HP = "0x00E28DC4"
Global $MaxHP = "0x00E28DC8"
Global $SP = "0x00E28DCC"
Global $MaxSp = "0x00E28DD0"
Global $Name = "0x00E29A20"
Global $memopen


$memopen = _MemoryOpen(ProcessExists("thaitro_client.exe"))



Opt("GUIOnEventMode", 1)

#Region

$MainGUI = GUICreate("BlueAngelz Pot", 300, 150)
GUISetOnEvent($GUI_EVENT_CLOSE, "gMainClose")
 $Charname_Label = GUICtrlCreateLabel("AUTO POT", 10, 10, 200)
$Charname_String = GUICtrlCreateLabel("", 10, 5)
GUICtrlSetState($Charname_String, $GUI_HIDE)
GUICtrlCreateLabel("HP", 10, 40)
GUICtrlCreateLabel("SP", 10, 80)
$LabelHP = GUICtrlCreateLabel("LabelHP", 40,38)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x0000FF)
$LabelSP = GUICtrlCreateLabel("LabelSP", 40,78)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x0000FF)
$LabelName = GUICtrlCreateLabel("LabelName", 140,14)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x0000FF)
XPStyleToggle(1)
$HP1_Progress = GUICtrlCreateProgress(100, 40, 150, 20,$PBS_SMOOTH)
GUICtrlSetColor($HP1_Progress, 0x74DF00)
$SP1_Progress = GUICtrlCreateProgress(100, 80, 150, 20,$PBS_SMOOTH)
GUICtrlSetColor($SP1_Progress, 0x00BFFF )
XPStyleToggle(0)
GUISetState(@SW_SHOW)
#EndRegion

While 1

HP()

SP()

Name()

Sleep(100)

WEnd

Func  Name()
	$valueName = _MemoryRead($MaxHP, $memopen, "char[64]")
		GUICtrlSetData($LabelName,   $valueName)

		EndFunc
Func HP()

$valueMAXHP = _MemoryRead($MaxHP, $memopen, "dword")
$valueHP = _MemoryRead($HP, $memopen, "dword" )
GUICtrlSetData($LabelHP,   $valueHP)
GUICtrlSetData($HP1_Progress,   (($valueHP * 100) / $valueMAXHP ) )

EndFunc

Func SP()

$valueMAXSP = _MemoryRead($MaxSp, $memopen, "dword" )
$valueSP = _MemoryRead($SP, $memopen, "dword " )
GUICtrlSetData($LabelSP,   $valueSP)
GUICtrlSetData($SP1_Progress, (($valueSP * 100) / $valueMAXSP ) )

EndFunc

Func XPStyleToggle($OnOff = 1)
If Not StringInStr(@OSTYPE, "WIN32_NT") Then Return 0
If $OnOff Then
$XS_n = DllCall("uxtheme.dll", "int", "GetThemeAppProperties")
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
Return 1
ElseIf IsArray($XS_n) Then
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", $XS_n[0])
$XS_n = ""
Return 1
EndIf
Return 0
EndFunc


Func gMainClose()
Exit
EndFunc