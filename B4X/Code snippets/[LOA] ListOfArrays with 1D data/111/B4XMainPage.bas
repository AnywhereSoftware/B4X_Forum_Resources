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
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Dim Names() As String = Array As String( _
    "John", _
    "Emma", _
    "Michael", _
    "Olivia", _
    "Daniel", _
    "Sophia", _
    "James", _
    "Ava", _
    "William", _
    "Mia", _
    "Benjamin", _
    "Charlotte", _
    "Lucas", _
    "Amelia", _
    "Henry", _
    "Isabella", _
    "Alexander", _
    "Evelyn", _
    "Ethan", _
    "Grace" _
)
	Dim AllNames As ListOfArrays = LOAUtils.CreateFrom1DList("Name", Names)
	'collect the indices of all rows where the name length is shorter or equals to 4:
	Dim ls As LOASet = AllNames.CreateLOASet
	Do While ls.NextRow
		If ls.GetValue(0).As(String).Length <= 4 Then ls.CollectIndex
	Loop
	'create two collections. One with the collected indices and the second with the non-collected indices
	Dim ShortNames As ListOfArrays = AllNames.GetRows(ls.CollectedValues)
	Dim LongNames As ListOfArrays = AllNames.GetRows(AllNames.NegateRowsSelection(ls.CollectedValues))
	Log(ShortNames.ToString(5))
	Log(LongNames.ToString(5))
	'add a new column that will store the length
	AllNames.AddColumnWithValue("Length", 0)
	Dim ls As LOASet = AllNames.CreateLOASet
	Do While ls.NextRow
		Dim Name As String = ls.GetValue("Name")
		'set the length value for each row
		ls.SetValue("Length", Name.Length)
	Loop
	'sort by length
	AllNames.Sort("Length", True)
	Log(AllNames.ToString(5))
	'create a 1d list with the "name" column.
	Dim SortedNames As List = AllNames.GetColumn("Name")
	Log(SortedNames)
End Sub

