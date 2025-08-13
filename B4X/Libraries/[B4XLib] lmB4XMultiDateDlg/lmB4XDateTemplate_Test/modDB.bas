B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.1
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private xui As XUI
	Private mDB As SQL

	Private mQuery As String
End Sub

Public Sub InitDB(DBFileName As String, AppName As String, ReplaceDB As Boolean) As Boolean
	Dim Result As Boolean = True
	
	Dim DBDir As String
	
	#IF B4J
		xui.SetDataFolder(AppName)
	#End If
	DBDir = xui.DefaultFolder
	
	If Not(File.Exists(DBDir, DBFileName)) Or ReplaceDB Then
		File.Copy(File.DirAssets, DBFileName, DBDir, DBFileName)
	End If
	
	#IF B4J
		mDB.InitializeSQLite(DBDir, DBFileName, False)
	#ELSE
		mDB.Initialize(DBDir,DBFileName, False)
	#End If
	
	Return Result
End Sub

Public Sub GetNoteDays(Year As Int, Month As Int) As List
	Dim lstDays As List
	lstDays.Initialize
	
	Dim lngDateStart, lngDateEnd As Long
	lngDateStart = DateUtils.SetDate(Year, Month, 1)
	lngDateEnd = DateUtils.SetDate(Year, Month, DateUtils.NumberOfDaysInMonth(Month, Year))
	
	Dim Date As Long
	Dim Day As Int
	mQuery = $"SELECT Date FROM Note WHERE Date BETWEEN ${lngDateStart} AND ${lngDateEnd}"$
	Dim RS As ResultSet
	RS = mDB.ExecQuery(mQuery)
	Do While RS.NextRow
		Date = RS.GetLong("Date")
		Day = DateTime.GetDayOfMonth(Date)
		lstDays.Add(Day)
	Loop

	Return lstDays
End Sub

Public Sub GetNote(Date As Long) As String
	Dim Note As String
	mQuery = $"SELECT Note FROM Note WHERE Date = ${Date}"$
	Note = mDB.ExecQuerySingleResult(mQuery)
	Return Note
End Sub
