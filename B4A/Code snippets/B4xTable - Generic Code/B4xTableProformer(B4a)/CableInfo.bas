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

'Headers for the Cable database and the b4xTable column headers
Sub CableHeaders
	'Log("Cable Headers")
	Starter.DBName = "CABLES"
	Starter.TotColNumber=53               '53 in final count
	Starter.FrozenCols=0
	Starter.ColNames(0) = "No_CORES"
	Starter.ColNames(1) = "AREA_MM2"
	Starter.ColNames(2) = "TYPE"
	
	Starter.ColDataTypes(0) = "INT"
	Starter.ColDataTypes(1) = "TEXT"
	Starter.ColDataTypes(2) = "TEXT"
	
	For i = 0 To 49
		Starter.ColNames(3+i) = "Core_" & (i+1)
		Starter.ColDataTypes(3+i) = "TEXT"
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
		SQLUtil.AddRowValues(Starter.SQL,Starter.DBName,Starter.TotColNumber,StartList)
	Next
End Sub