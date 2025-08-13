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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private CbbTime As ComboBox
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	' Copy db file if not exist
	If File.Exists(Main.DATA_FOLDER, Main.DATA_FILE) = False Then
		File.Copy(File.DirAssets, Main.DATA_FILE, Main.DATA_FOLDER, Main.DATA_FILE)
	End If
	
	Main.DATA_FOLDER = File.DirApp
	Main.DB.InitializeSQLite(Main.DATA_FOLDER, Main.DATA_FILE, False)
	' Load value from DB
	Dim strSQL As String = "SELECT * FROM settings WHERE name = ?"
	Dim setting As String = "Fajr"
	Dim value As String
	Dim RS As ResultSet = Main.DB.ExecQuery2(strSQL, Array As String(setting))
	Do While RS.NextRow
		value = RS.GetString("value")
	Loop
	RS.Close
	Main.DB.Close
	
	' Populate Combobox
	Dim list1 As List
	list1.Initialize
	For i = 1 To 60
		list1.Add(i)
	Next
	CbbTime.Items.AddAll(list1)
	
	' Set value to Combobox
	CbbTime.Value = value
End Sub

Private Sub BtnSave_Click
	' Open DB
	Main.DB.InitializeSQLite(Main.DATA_FOLDER, Main.DATA_FILE, False)
	
	' Save value to DB
	Dim strSQL As String = "UPDATE settings SET value = ? WHERE name = ?"
	Dim setting As String = "Fajr"
	Dim value As String = CbbTime.Value
	Main.DB.ExecNonQuery2(strSQL, Array As String(value, setting))
	Main.DB.Close
	xui.MsgboxAsync("Settings saved", "Success")
End Sub