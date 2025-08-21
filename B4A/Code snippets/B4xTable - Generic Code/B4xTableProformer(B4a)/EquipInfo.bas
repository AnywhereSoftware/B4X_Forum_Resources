B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.801
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub
'Headers for the Equipment database and for the Saved Equipment Database
Sub EquipmentHeaders
	'Log("Equipment Headers")
	Starter.DBName = "EQUIPMENT"
	Starter.TotColNumber=5
	Starter.FrozenCols=0
	Starter.ColNames(0) = "EQUIP"
	Starter.ColNames(1) = "DESCR"
	Starter.ColNames(2) = "COMMENT1"
	Starter.ColNames(3) = "COMMENT2"
	Starter.ColNames(4) = "COMMENT3"
		
	Starter.ColDataTypes(0) = "TEXT"
	Starter.ColDataTypes(1) = "TEXT"
	Starter.ColDataTypes(2) = "TEXT"
	Starter.ColDataTypes(3) = "TEXT"
	Starter.ColDataTypes(4) = "TEXT"
End Sub

'Adds some equipment
Sub PopulateEquipTable
	'Insert some start values
	For i = 1 To 20
		Dim StartList As List
		StartList. Initialize
		Dim x As String = "RP" & i
		StartList.Add(x )
		StartList.Add("Relay Panel")
		StartList.Add("XYZ")
		StartList.Add("Type")
		StartList.Add("3232")
		SQLUtil.AddRowValues(Starter.SQL,Starter.DBName,Starter.TotColNumber,StartList)
	Next
End Sub

