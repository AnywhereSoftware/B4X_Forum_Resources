### Addition to B4XMap (OSM viewer) by RB Smissaert
### 03/14/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/139149/)

Using this very nice OSM map viewer:  
<https://www.b4x.com/android/forum/threads/b4xmap-open-street-map-viewer.138028/>  
  
I didn't like the blue diagonals that will show for the area outside the map, so added some code that will prevent that  
and also avoids trips to the map DB, looking for tiles that are not there:  
  
In clsMapTileManager:  
  

```B4X
'open db, create it if necessary  
Private Sub dbInit  
      
    Dim strSQL As String  
      
    strSQL = "CREATE TABLE tiles(" & _  
             "zoom_level INTEGER NOT NULL, " & _  
             "tile_column INTEGER Not Null, " & _  
             "tile_row INTEGER Not Null, " & _  
             "tile_data BLOB Not Null, primary key (zoom_level, tile_column, tile_row))"  
  
    fXUI.SetDataFolder("")  
    If Not(File.Exists(fXUI.DefaultFolder,"tiles.db3")) Then  
        #if B4A or B4i  
        fDB.Initialize(fXUI.DefaultFolder,"tiles.db3",True)  
        #else if B4J  
            fDB.InitializeSQLite(fXUI.DefaultFolder,"tiles.db3",True)  
        #end if  
        fDB.ExecNonQuery(strSQL)  
    Else  
          
        Dim strSQL As String  
        Dim RS1 As ResultSet  
  
        #if B4A or B4i  
        fDB.Initialize(fXUI.DefaultFolder, "tiles.db3", False)  
          
        strSQL = "select zoom_level, min(tile_column), max(tile_column), min(tile_row), max(tile_row) from tiles group by zoom_level"  
        RS1 = fDB.ExecQuery(strSQL)  
        MapUtilities.SetupMapDBRowsColumns(RS1)  
          
        #else if B4J  
            fDB.InitializeSQLite(fXUI.DefaultFolder,"tiles.db3",False)  
        #End If  
    End If  
End Sub  
  
In
```

  
  
In code module MapUtilities:  
  

```B4X
Sub Process_Globals  
  
    Private mapDBRowsColumns As Map  
  
  
Sub SetupMapDBRowsColumns(RS1 As ResultSet)  
      
    Dim c As Int  
      
    mapDBRowsColumns.Initialize  
      
    Do While RS1.NextRow  
        Dim arrInt(4) As Int  
        For c = 0 To 3  
            arrInt© = RS1.GetInt2(c + 1)  
        Next  
        mapDBRowsColumns.Put(RS1.GetInt2(0), arrInt)  
    Loop  
      
End Sub  
  
Public Sub TileInDB(iZoom As Int, iColumn As Int, iRow As Int) As Boolean  
      
    Dim arrInt() As Int  
      
    arrInt = mapDBRowsColumns.Get(iZoom)  
    Return iColumn >= arrInt(0) And iColumn <= arrInt(1) And iRow >= arrInt(2) And iRow <= arrInt(3)  
      
End Sub
```

  
  
In cvMap:  
  

```B4X
'add tile to the mapview  
private Sub addTile(aLeft As Int,aTop As Int,aTileX As Long,aTileY As Long,aZ As Int)  
      
    aTileX=checkTile(aTileX,fTilesCount)  
    aTileY=checkTile(aTileY,fTilesCount)  
      
    'view for the tile  
    Dim xpt As B4XView = fxui.CreatePanel("tile")  
    xpt.Tag=MapUtilities.initTileXY(aTileX,aTileY)  
    fViewTiles.AddView(xpt,aLeft,aTop,MapUtilities.cTileSize,MapUtilities.cTileSize)  
      
    'view for the tile's image  
    'only put image on tile panel if that tile is in the DB  
    '——————————————————  
    If MapUtilities.TileInDB(aZ,aTileX,aTileY) Then '<<<< added RBS 14/03/2022  
        Dim iv As ImageView  
        iv.Initialize("itile")  
        xpt.AddView(iv,0,0,MapUtilities.cTileSize,MapUtilities.cTileSize)  
        drawTile(iv,aZ,aTileX,aTileY)  
    End If  
      
    'view for the grid  
    Dim pg As B4XView = fxui.CreatePanel("gtile")  
    xpt.AddView(pg,0,0,MapUtilities.cTileSize,MapUtilities.cTileSize)  
    drawGridOnTile(pg)  
    pg.Visible=fMap.fShowGrid  
      
End Sub
```

  
  
RBS