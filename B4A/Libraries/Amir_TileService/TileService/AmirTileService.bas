B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Private Sub Class_Globals
	'AmirHosseinAghajari | Telegram: @LCoders | Instagram: amirhossein_aghajari
End Sub

Public Sub Initialize (TileService As Amir_TileService)
	LogColor("TileService_Initialized",Colors.Red)
End Sub

Private Sub TileService_Clicked (TileService As Amir_TileService)
	Log("TileService_Clicked")
	SetState(Not(PreferenceManager.GetValue(PreferenceManager.TILE_KEY,False)),TileService.QsTile)
End Sub

Private Sub TileService_Added (TileService As Amir_TileService)
	Log("TileService_Added")
	SetState(PreferenceManager.GetValue(PreferenceManager.TILE_KEY,False),TileService.QsTile)
End Sub

Private Sub TileService_Removed (TileService As Amir_TileService)
	Log("TileService_Removed")
End Sub

Private Sub TileService_StartListening (TileService As Amir_TileService)
	Log("TileService_StartListening")
	SetState(PreferenceManager.GetValue(PreferenceManager.TILE_KEY,False),TileService.QsTile)
End Sub

Private Sub TileService_StopListening (TileService As Amir_TileService)
	Log("TileService_StopListening")
End Sub

Private Sub SetState (Connected As Boolean,Tile As Amir_Tile)
	PreferenceManager.SaveValue(PreferenceManager.TILE_KEY,Connected)
	If Connected Then
		Tile.State = Tile.STATE_ACTIVE
		Tile.Icon = Tile.CreateIconWithAndroidResource("ic_media_pause")
		Tile.Label = "Connected"
	Else
		Tile.State = Tile.STATE_INACTIVE	
		Tile.Icon = Tile.CreateIconWithAndroidResource("ic_media_play")
		Tile.Label = "Disconnected"
	End If
	Tile.ContentDescription = "AmirTileService"
	Tile.UpdateTile
	
	If IsPaused(Main)=False Then CallSubDelayed2(Main,"Reload",False) 'Update Activity
End Sub