B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
#Event:DumpingResult(Success As Boolean)

Sub Class_Globals
	Private mCallBack As Object
	Private mEventName As String
	Private mDBDir As String
End Sub

Public Sub Initialize(Callback As Object, EventName As String, DBDir As String)
	mCallBack = Callback
	mEventName = EventName
	mDBDir = DBDir

	If Not(File.Exists(mDBDir, "sqlite3.exe")) Then
		File.Copy(File.DirAssets, "sqlite3.exe", DBDir, "sqlite3.exe")
	End If

	If Not(File.Exists(mDBDir, "Dump.bat")) Then
		File.WriteString(mDBDir, "Dump.bat", $"sqlite3 %1 ".dump '%2'" > %3"$)
	End If
End Sub

Public Sub BackupTable (DBName As String, TableName As String, BackupFileName As String)
	Dim BackupSh As Shell
	BackupSh.Initialize("BackupTable", mDBDir &  "\dump.bat", Array As String(DBName,TableName,BackupFileName))
	BackupSh.WorkingDirectory = mDBDir
	BackupSh.Run(-1)
End Sub

Private Sub BackupTable_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	Dim SubFullName As String = mEventName & "_DumpingResult"
	Dim Result As Boolean = Success And ExitCode = 0
	
	If SubExists(mCallBack, SubFullName) Then
		CallSubDelayed2(mCallBack, SubFullName, Result)
	End If
End Sub