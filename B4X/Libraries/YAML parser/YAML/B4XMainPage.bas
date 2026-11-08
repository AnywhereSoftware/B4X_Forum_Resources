B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Dim parser As YAML
	parser.Initialize
	Dim s As String = $"---
name: Nathan Sweet
age: 28
date: 2001-12-14T21:59:43.10-05:00
address: 4011 16th Ave S
number: 123
ff: false
tt: true
phone numbers:
 - name: Home
   number: 206-555-5138
 - name: Work
   number: 425-555-2306
---
aaa"$
	Dim m As Map = parser.Parse(s)
	For Each k As String In m.Keys
		Log(k & ": " & m.Get(k) & " - " & GetType(m.Get(k)))
	Next
	Dim ff As Boolean = m.Get("ff")
	Dim tt As Boolean = m.Get("tt")
	Log(ff)
	Log(tt)
	Log(parser.ParseAllDocuments(s))
	Log(m)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub