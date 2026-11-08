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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=AppendToTextFile.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private TextField1 As B4XView
	Private btnAdd As B4XView
	
	Private mOutDir As String
	Private mFileName As String
	Private TextArea1 As B4XView
	Private Label1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	#If B4J
		xui.SetDataFolder("Test")
	#End If
	mOutDir = xui.DefaultFolder
	mFileName = "Test.txt"
	File.Copy(File.DirAssets, mFileName, mOutDir, mFileName)
	LoadTextFile
	Label1.Text = "File: " & mFileName
End Sub

#Region VIEWS' EVENTS 

Private Sub TextField1_TextChanged (Old As String, New As String)
	btnAdd.Enabled = New.Length > 0
End Sub

Private Sub btnAdd_Click
	AppendToTextFile(mOutDir, mFileName, TextField1.Text, True)
	LoadTextFile
End Sub

#End Region

#Region PRIVATE METHODS 

Private Sub LoadTextFile
	TextArea1.Text = File.ReadString(mOutDir, mFileName)
End Sub

Private Sub AppendToTextFile(Dir As String, FileName As String, Text As String, NewLine As Boolean)
	If NewLine Then
		Text = CRLF & Text
	End If
	Dim out As OutputStream = File.OpenOutput(Dir, FileName, True)
	Dim b() As Byte = Text.GetBytes("utf8")
	out.WriteBytes(b, 0, b.Length)
	out.Close
End Sub

#End Region
