B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.3
@EndOfDesignText@
'EQUIPMENT

Sub Process_Globals
End Sub

'Headers for the Equipment database and for the Saved Equipment Database
Sub EquipmentHeaders
	'Log("Equipment Headers")
	Common.DBName = "EQUIPMENT"
	Common.TotColNumber=5
	Common.FrozenCols=0
	Common.ColNames(0) = "EQUIP"
	Common.ColNames(1) = "DESCR"
	Common.ColNames(2) = "COMMENT1"
	Common.ColNames(3) = "COMMENT2"
	Common.ColNames(4) = "COMMENT3"
		
	Common.ColDataTypes(0) = "TEXT"
	Common.ColDataTypes(1) = "TEXT"
	Common.ColDataTypes(2) = "TEXT"
	Common.ColDataTypes(3) = "TEXT"
	Common.ColDataTypes(4) = "TEXT"
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
		SQLUtil.AddRowValues(Common.SQL,Common.DBName,Common.TotColNumber,StartList)
	Next
End Sub




