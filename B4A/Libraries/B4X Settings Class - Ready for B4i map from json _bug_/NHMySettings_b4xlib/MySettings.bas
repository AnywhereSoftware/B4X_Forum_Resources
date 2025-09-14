B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Private sField As String
	Private sTable As String
	Private mSets As Map
	Private connSettings As SQL
	Private saveSet As String = "The settings were saved."
	Private loadSet As String = "The settings were loaded."
	#IF B4i
		Dim hd As HUD
	#End If
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(FieldInDBToLoadAndSaveTheSettings As String, TableInDBToLoadAndSaveTheSettings As String, FolderOfDB As String, DBFileName As String)
	sField = FieldInDBToLoadAndSaveTheSettings
	sTable = TableInDBToLoadAndSaveTheSettings
	mSets.Initialize
	connSettings.Initialize(FolderOfDB, DBFileName, False)
End Sub

Public Sub Initialize2(FieldInDBToLoadAndSaveTheSettings As String, TableInDBToLoadAndSaveTheSettings As String, conn As SQL)
	sField = FieldInDBToLoadAndSaveTheSettings
	sTable = TableInDBToLoadAndSaveTheSettings
	mSets.Initialize
	connSettings = conn
End Sub

Public Sub LoadSettings
	Dim cur As ResultSet
	Dim sSettings As String
	
	Try
		cur = connSettings.ExecQuery("SELECT " & EscapeSQLEntity(sField) & " FROM " & EscapeSQLEntity(sTable))
		Do While cur.NextRow
			sSettings = cur.GetString(sField)
			
			Dim jp As JSONParser
			jp.Initialize(sSettings)
			Dim m As Map
			m = jp.NextObject
			'To avoid the bug of iOS - Maps derived from JSON cannot change
			For Each k As String In m.Keys
				mSets.Put(k, m.Get(k))
			Next
			
			'take only the first row
			Exit
		Loop
		#IF B4A
		ToastMessageShow(loadSet, True)
		#Else If B4i
			hd.ToastMessageShow(loadSet, True)
		#End If
		
	Catch
		Log(LastException)
		#IF B4A
		ToastMessageShow(LastException, True)
		#Else If B4i
			hd.ToastMessageShow(LastException, True)
		#End If
	End Try
	

End Sub


Public Sub ContainsSetting(SettingName As String) As Boolean
	Return mSets.ContainsKey(SettingName)
End Sub

Public Sub Set(SettingName As String, SettingValue As Object)
	mSets.Put(SettingName, SettingValue)
End Sub

Public Sub Get(SettingName As String) As Object
	Return mSets.Get(SettingName)
End Sub


Public Sub SaveSettings
	Dim sSettings As String
	Dim jg As JSONGenerator
	jg.Initialize(mSets)
	sSettings = jg.ToString
	connSettings.ExecNonQuery2("UPDATE " & EscapeSQLEntity(sTable) & " SET " & EscapeSQLEntity(sField) & "=?", Array As String(sSettings))
	
	#IF B4A
	ToastMessageShow(saveSet, True)
	#Else If B4i
		hd.ToastMessageShow(saveSet, True)
	#End If
	
End Sub


Private Sub EscapeSQLEntity(sEntityName) As String
	Dim sb As StringBuilder
	sb.Initialize
	
	If sEntityName.StartsWith("[") = False Then
		sb.Append("[")
	End If
	sb.Append(sEntityName.Trim)
	If sEntityName.EndsWith("]") = False Then
		sb.Append("]")
	End If
	Return sb.ToString
End Sub

Public Sub setSettingsSavedMessage(sMes As String)
	saveSet = sMes
End Sub

Public Sub setSettingsLoadedMessage(sMes As String)
	loadSet = sMes
End Sub