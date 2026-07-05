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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Dim s As String = "Hello World! - B4X"
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Dim sourceBytes() As Byte = s.GetBytes("UTF8")
	
	Dim rd As RawDeflate
	rd.Initialize
	Dim compressed() As Byte = rd.Compress(sourceBytes)
	
	Dim ri As RawInflate
	ri.Initialize
	Dim raw () As Byte = ri.Decompress(compressed)
	
	Dim result As String = BytesToString(raw,0,raw.Length,"utf8")
	
	xui.MsgboxAsync(result, "Huffman - RFC 1951 sez. 3.2.6.")
End Sub