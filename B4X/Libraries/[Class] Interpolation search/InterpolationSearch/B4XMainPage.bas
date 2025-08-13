B4A=true
Group=B4XPAGES
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip

'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\%PROJECT_NAME%.b4a
'B4i ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4i\%PROJECT_NAME%.b4i
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\%PROJECT_NAME%.b4j

'Opens the project folder.
'Project folder: ide://run?file=%WINDIR%\SysWOW64\explorer.exe&Args=%PROJECT%

#Region VERSIONS 
'	1.0.0.	12/04/2024
#End Region

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Private ISearch As InterpolationSearch
End Sub

Public Sub Initialize
	B4XPages.GetManager.TransitionAnimationDuration = 0
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("mainpage")

	ISearch.Initialize
End Sub

Private Sub Button1_Click
	TestInterpolationSearch
End Sub

Private Sub TestInterpolationSearch
	Dim SortedList As List
	SortedList.Initialize
	For i = 1 To 20
		'Ascending values.
'		SortedList.Add(i * 5) ' 5, 10, 15, ..., 100
		'Decending values.
		SortedList.Add(100 - (i-1) * 5)
	Next

	Dim ValueToFind As Double = 42
	Log("Value to find: " & ValueToFind)
	Log(" ")
	
	Dim EqualIndex, EqualOrLessIndex, EqualOrGreaterIndex As Int
	
	EqualIndex = ISearch.Search(SortedList, ValueToFind, ISearch.ISRC_EQUAL)
	EqualOrLessIndex = ISearch.Search(SortedList, ValueToFind, ISearch.ISRC_EQUAL_OR_LESS)
	EqualOrGreaterIndex = ISearch.Search(SortedList, ValueToFind, ISearch.ISRC_EQUAL_OR_GREATER)
	
	Log($"Equal - Index: ${ISearch.Search(SortedList, ValueToFind, ISearch.ISRC_EQUAL)}"$)
	If EqualIndex <> - 1 Then
		Log(TAB & $"Value found: ${SortedList.Get(EqualIndex)}"$)
	Else
		Log(TAB & $"Value not found."$)
	End If
	Log(" ")
	
	Log($"Equal or less - Index: ${ISearch.Search(SortedList, ValueToFind, ISearch.ISRC_EQUAL_OR_LESS)}"$)
	Log(TAB & $"Value: ${SortedList.Get(EqualOrLessIndex)}"$)
	Log(" ")
	
	Log($"Equal or greater - Index: ${ISearch.Search(SortedList, ValueToFind, ISearch.ISRC_EQUAL_OR_GREATER)}"$)
	Log(TAB & $"Value: ${SortedList.Get(EqualOrGreaterIndex)}"$)
End Sub

