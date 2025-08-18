### [B4XPages] SQL + xCLV Example by Erel
### 06/23/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/131888/)

A simple, cross platform example that reads data from a database and adds it to a xCLV.  
  
![](https://www.b4x.com/android/forum/attachments/115371)  
  
Database source: <https://www.sqlitetutorial.net/sqlite-sample-database/>  
  
The interesting code:  

```B4X
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
```