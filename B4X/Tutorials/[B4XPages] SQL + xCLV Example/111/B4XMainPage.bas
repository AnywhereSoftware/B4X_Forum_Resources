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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip&VMArgs=-DZeroSharedFiles%3DTrue

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private CustomListView1 As CustomListView
	Private sql As SQL
	Private lblAlbum As B4XView
	Private lblArtist As B4XView
	Type RecordData (ArtistName As String, AlbumName As String)
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "SQL + xCLV Example")
	xui.SetDataFolder("sql example") 'required in B4J
	Dim dbname As String = "chinook_v1.db"
	If File.Exists(xui.DefaultFolder, dbname) = False Then File.Copy(File.DirAssets, "chinook.db", xui.DefaultFolder, dbname)
	#if B4J
	'B4J SQL object can access many types of databases (same as B4A JdbcSQL).
	sql.InitializeSQLite(xui.DefaultFolder, dbname, False)
	#else
	sql.Initialize(xui.DefaultFolder, dbname, False)
	#End If
	Dim rs As ResultSet = sql.ExecQuery2($"SELECT artists.name AS ArtistName, albums.title AS AlbumTitle FROM albums, artists 
		WHERE albums.artistid = artists.artistid"$, Null)
	Do While rs.NextRow
		Dim rd As RecordData = CreateRecordData(rs.GetString("ArtistName"), rs.GetString("AlbumTitle"))
		CustomListView1.Add(CreateItem(rd), rd)
	Loop
	rs.Close
End Sub

Private Sub CreateItem(rd As RecordData) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, Root.Width, 60dip)
	p.LoadLayout("Item")
	'labels will point to the last loaded views with the set name.
	lblAlbum.Text = rd.AlbumName
	lblArtist.Text = rd.ArtistName
	Return p
End Sub

Public Sub CreateRecordData (ArtistName As String, AlbumName As String) As RecordData
	Dim t1 As RecordData
	t1.Initialize
	t1.ArtistName = ArtistName
	t1.AlbumName = AlbumName
	Return t1
End Sub

Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	Dim rd As RecordData = Value
	Log(rd) 'ignore
End Sub