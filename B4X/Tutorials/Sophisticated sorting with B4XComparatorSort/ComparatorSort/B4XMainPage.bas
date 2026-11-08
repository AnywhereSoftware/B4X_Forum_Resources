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
	Type Person (Name As String, Age As Int, Status As String)
	Private ComparatorSort As B4XComparatorSort
	Private PersonComparator1 As PersonComparator
	Private Persons As List
	Private CustomListView1 As CustomListView
End Sub

Public Sub Initialize
	ComparatorSort.Initialize
	PersonComparator1.Initialize
	Persons.Initialize
	Persons.Add(CreatePerson("James", 64, "Employee"))
	Persons.Add(CreatePerson("Robert", 55, "Contractor"))
	Persons.Add(CreatePerson("Susan", 36, "Employee"))
	Persons.Add(CreatePerson("James", 33, "Contractor"))
	Persons.Add(CreatePerson("Susan", 36, "Contractor"))
	Persons.Add(CreatePerson("Susan", 38, "Contractor"))
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	ComparatorSort.Sort(Persons, PersonComparator1)
	For Each p As Person In Persons
		CustomListView1.AddTextItem($"${p.Name}, ${p.Age}, ${p.Status}"$, p)
	Next
End Sub

Public Sub CreatePerson (Name As String, Age As Int, Status As String) As Person
	Dim t1 As Person
	t1.Initialize
	t1.Name = Name
	t1.Age = Age
	t1.Status = Status
	Return t1
End Sub