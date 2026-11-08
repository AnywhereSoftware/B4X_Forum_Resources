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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=IndexOfObject_Example.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Type tPoint(X As Int, Y As Int)
	Private mlstPoints As List
	Private mmapPoints As Map
	Private Label1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	Dim Point1 As tPoint = CreatetPoint(1, 1)
	Dim Point2 As tPoint = CreatetPoint(2, 2)
	Dim Point3 As tPoint = CreatetPoint(3, 3)
	
	'***  List test  ***
	mlstPoints.Initialize
	mlstPoints.AddAll(Array(Point1, Point2, Point3))
	'*******************
	
	'***  Map test  ***
	mmapPoints.Initialize
	mmapPoints.Put("A", Point1)
	mmapPoints.Put("B", Point2)
	mmapPoints.Put("C", Point3)
	'*******************

End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Dim NewPoint As tPoint
	NewPoint = CreatetPoint(2, 2)
	
	'***  List test  ***
	Dim intResult As Int
	intResult = IndexOfObject.Find(mlstPoints, NewPoint)
	If intResult <> - 1 Then
		Log("LIST - Found at index: " & intResult)
	Else
		Log("LIST - NOT found")
	End If
	'******************


	'***  Map test  ***
	Dim objResult As Object
	objResult = IndexOfObject.Find(mmapPoints, NewPoint)
	If objResult <> Null Then
		Log("MAP - Found. Key: " & objResult)
	Else
		Log("MAP - NOT found")
	End If
	'******************
	
	Label1.Text = "See the log."
End Sub

Public Sub CreatetPoint (X As Int, Y As Int) As tPoint
	Dim t1 As tPoint
	t1.Initialize
	t1.X = X
	t1.Y = Y
	Return t1
End Sub