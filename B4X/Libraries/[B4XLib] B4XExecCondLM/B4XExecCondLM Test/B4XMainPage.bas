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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XExecContLMTest.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

Private Sub Button1_Click
	'ExecIF example.
	Dim A As Int = 10
	Dim B As Int = 2

	Dim Result As Int
	Result = B4XExecCondLM.ExecIF(Array As Boolean(a <= b, a > b), Array As String("Multiply", "Divide"), Array As Object(10, 2), True, Me)
	Log("ExecIf result: " & Result)
	
	'ExecOnIndex example.
	B4XExecCondLM.ExecOnIndex(1, Array As String("Zero", "One", "Two"), Null, False, Me)
End Sub


Public Sub Multiply(Value1 As Int, Value2 As Int) As Int
	Return Value1 * Value2
End Sub

Public Sub Divide(Value1 As Int, Value2 As Int) As Double
	Return Value1 / Value2
End Sub


Public Sub Zero
	Log("Zero")
End Sub

Public Sub One
	Log("One")
End Sub

Public Sub Two
	Log("Two")
End Sub

