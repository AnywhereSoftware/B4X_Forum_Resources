B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private XUI As XUI
	Private mSQL As SQL
	Public Const Addresses_TBL As String = "addr"
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

	If File.Exists(XUI.DefaultFolder,"addr.db") = False Then
		File.Copy(File.DirAssets,"addr.db",XUI.DefaultFolder,"addr.db")
	End If
	

	mSQL.InitializeSQLite(XUI.DefaultFolder,"addr.db",True)

End Sub

Private Sub CheckSQLTable(Name As String) As Int	'ignore
	Dim Count As Int
	Try
		Count = mSQL.ExecQuerySingleResult($"SELECT COUNT(name) FROM sqlite_master WHERE type='table' AND name= '${Name}'"$)
	Catch
		Log(LastException)
		Return -1
	End Try
	Return Count
End Sub



'Return the current SQLite Database
Public Sub SQL As SQL
	Return mSQL
End Sub