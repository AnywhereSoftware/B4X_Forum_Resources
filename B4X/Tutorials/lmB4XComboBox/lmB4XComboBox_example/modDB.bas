B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.1
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Public DB As SQL
	Private DBDir, DBFileName As String
	Private mQuery As String
End Sub

Public Sub Init
	DBDir = File.DirApp
	DBFileName = "Chinook_Sqlite.sqlite"
	If Not(File.Exists(DBDir, DBFileName)) Then
		File.Copy(File.DirAssets, DBFileName, DBDir, DBFileName)
	End If
	DB.InitializeSQLite(DBDir, DBFileName, False)
End Sub

Public Sub GetAlbumsByArtistId(ArtistId As Int) As List
	Dim lstResult As List
	lstResult.Initialize
	
	mQuery = $"SELECT Title FROM Album WHERE ArtistId = ${ArtistId}"$
	
	Dim Cursor As ResultSet
	Cursor = DB.ExecQuery(mQuery)
	Do While Cursor.NextRow
		lstResult.Add(Array(Cursor.GetString("Title")))
	Loop
	Cursor.Close
	
	Return lstResult
End Sub