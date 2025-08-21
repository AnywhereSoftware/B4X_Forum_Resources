B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.3
@EndOfDesignText@
'CABLES

Sub Process_Globals
End Sub

'Headers for the Cable database and the b4xTable column headers
Sub CableHeaders
'Log("Cable Headers")
	Common.DBName = "CABLES"
	Common.TotColNumber=53               '53 in final count
	Common.FrozenCols=0
	Common.ColNames(0) = "No_CORES"
	Common.ColNames(1) = "AREA_MM2"
	Common.ColNames(2) = "TYPE"
	
	Common.ColDataTypes(0) = "INT"
	Common.ColDataTypes(1) = "TEXT"
	Common.ColDataTypes(2) = "TEXT"
	
	For i = 0 To 49
		Common.ColNames(3+i) = "Core_" & (i+1)
		Common.ColDataTypes(3+i) = "TEXT"
	Next

End Sub

'Adds some cables
Sub PopulateCableTable
'Insert some start values
	For i = 1 To 40
		Dim StartList As List
		StartList. Initialize
		StartList.Add(i )					'Cores
		StartList.Add(1.5)					'Area.
		StartList.Add("PVC")                'Type
		For j = 1 To i
			StartList.Add(j)
		Next
		For j = i+1 To 50
			StartList.Add("")
		Next
		SQLUtil.AddRowValues(Common.SQL,Common.DBName,Common.TotColNumber,StartList)
	Next
End Sub





