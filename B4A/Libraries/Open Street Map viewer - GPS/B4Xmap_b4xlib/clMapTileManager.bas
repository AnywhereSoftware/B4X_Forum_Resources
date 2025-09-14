B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.6
@EndOfDesignText@
Sub Class_Globals
	Private fXUI As XUI
	Private fDB As SQL
	Private fOffLine As Boolean=False
	private fTileServer as string="https://a.tile.openstreetmap.org/"
	private fUserAgent as string="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:100.0) Gecko/20100101 Firefox/100.0"
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	dbInit
End Sub

public Sub setOffline(avalue As Boolean)
	fOffLine=avalue
End Sub

Public Sub getOffline As Boolean
	Return fOffLine
End Sub

public Sub setUserAgent(avalue As string)
	fUserAgent=avalue
End Sub

Public Sub getUserAgent As string
	Return fUserAgent
End Sub

public Sub setTileServer(avalue As string)
	fTileServer=avalue
End Sub

Public Sub getTileServer As string
	Return fTileServer
End Sub

'open db, create it if necessary
Private Sub dbInit
	fXUI.SetDataFolder("")
	If Not(File.Exists(fXUI.DefaultFolder,"tiles.db3")) Then
		#if B4A or B4i
			fDB.Initialize(fXUI.DefaultFolder,"tiles.db3",True)
		#else if B4J
			fDB.InitializeSQLite(fXUI.DefaultFolder,"tiles.db3",True)
		#end if
		fDB.ExecNonQuery("CREATE TABLE t_tiles(tiZ INTEGER NOT NULL,tiX INTEGER NOT NULL,tiY INTEGER NOT NULL,tiPNG BLOB NOT NULL, primary key (tiZ,tiX,tiY))")
	Else
		#if B4A or B4i
		fDB.Initialize(fXUI.DefaultFolder,"tiles.db3",False)
		#else if B4J
			fDB.InitializeSQLite(fXUI.DefaultFolder,"tiles.db3",False)
		#End If
	End If
End Sub

'Get Tile from DB ,if not found, from Internet, then store it in DN
public Sub getTile(aZ As Int,aX As Long,aY As Long) As ResumableSub
	Dim bmp As B4XBitmap=getTileFromDB(aZ,aX,aY)
	If Not(bmp.IsInitialized) Then
		If Not(fOffLine) Then
			wait for (getTileFromInternet(aZ,aX,aY)) complete (bmp As B4XBitmap)
			If bmp.IsInitialized Then
				setTileToDB(aZ,aX,aY,bmp)
			End If
		End If
	End If
	If Not(bmp.IsInitialized) Then
		Dim bc As BitmapCreator
		bc.Initialize(coMapUtilities.cTileSize,coMapUtilities.cTileSize)
		Dim s As Int=(coMapUtilities.cTileSize/16)
		For i=1 To s-1
			bc.DrawLine(i*s,0,0,i*s,fXUI.Color_Blue,2dip)
		Next
		bmp=bc.Bitmap
	End If
	Return bmp
End Sub

'Get Tile from internet openstreemap website
public Sub getTileFromInternet(aZ As Int,aX As Int,aY As Int) As ResumableSub
	Dim j As HttpJob
	Dim bmp As B4XBitmap
	Try
		j.Initialize("", Me)
		j.Download($"${fTileServer}${aZ}/${aX}/${aY}.png"$)
		j.GetRequest.SetHeader("User-Agent",fUserAgent)
		Wait For (j) JobDone(j As HttpJob)
		If j.Success Then
			Try
				bmp=j.GetBitmap
			Catch
				Log(LastException.Message & crlf & j.getString)
			End Try
		End If
	Catch
		Log(LastException.Message)
	End Try
	If j.IsInitialized Then
		j.Release
	End If
	Return bmp
End Sub

'Get Tile from DB
public Sub getTileFromDB(aZ As Int,aX As Long,aY As Long) As B4XBitmap
	Dim bmp As B4XBitmap
	Try
		Dim C As ResultSet = fDB.ExecQuery2("SELECT tiPNG FROM t_tiles WHERE tiZ=? and tiX=? and tiY=?",Array As String(aZ,aX,aY))
		If C.NextRow Then
			Dim b() As Byte = C.GetBlob("tiPNG")
			Dim Ist As InputStream
			Ist.InitializeFromBytesArray(b,0,b.Length)
			#if B4A or b4i
			Dim i As Bitmap
			#else if B4J
				Dim i As Image
			#End If
			i.Initialize2(Ist)
			bmp=i
			Ist.Close
		End If
	Catch
		Log(LastException.Message)
	End Try
	If C.IsInitialized Then
		C.Close
	End If
	Return bmp
End Sub

'Set tile to DB
public Sub setTileToDB(aZ As Int,aX As Long,aY As Long,aBmp As B4XBitmap)
	Try
		Dim ost As OutputStream
		ost.InitializeToBytesArray(0)
		aBmp.WriteToStream(ost,70,"PNG")
		ost.close
		Dim b() As Byte=ost.ToBytesArray
		fDB.ExecNonQuery2("insert into t_tiles(tiZ,tiX,tiY,tiPng) values(?,?,?,?)",Array As Object(aZ,aX,aY,b))
	Catch
		Log("X : " & aX & "  Y : " & aY & "  Zoom : " & aZ & "  duplicate!")
	End Try
End Sub

'delete from DB tiles from XY to XY and zoom and return how many records have been deleted
public Sub DeleteTilesFromDB(aFromX As Int,aToX As Int,aFromY As Int,aToY As Int,aZoom As Int) As Long
	Dim r As Long=0
	Try
		fDB.BeginTransaction
		fDB.ExecNonQuery2("delete from t_tiles where tiX between ? and ? and tiY between ? and ? and tiZ=?",Array As String(Min(aFromX,aToY),Min(aFromY,aToY),Max(aFromX,aToX),Max(aFromY,aToY),aZoom))
		r=fDB.ExecQuerySingleResult("select changes()")
		fDB.TransactionSuccessful
		#if B4A
			fDB.EndTransaction
		#end if
		fDB.ExecNonQuery("vacuum")
	Catch
		Log(LastException.Message)
	End Try
	Return r
End Sub

'empty DB
public Sub emptyDB As Long
	Dim r As Long=0
	Try
		fDB.BeginTransaction
		fDB.ExecNonQuery("delete from t_tiles")
		r=fDB.ExecQuerySingleResult("select changes()")
		fDB.TransactionSuccessful
		#if B4A
			fDB.EndTransaction
		#end if
		fDB.ExecNonQuery("vacuum")
	Catch
		Log(LastException.Message)
	End Try
	Return r
End Sub
