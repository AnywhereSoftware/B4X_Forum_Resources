Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=1.95
@EndOfDesignText@
#Region Module Attributes
	#StartAtBoot: False
#End Region

'Service module
Sub Process_Globals
	Dim lwm As LWManager
	Dim x, y, vx, vy As Int
	Dim initialized As Boolean: initialized = False
	Dim boxSize As Int
	Dim smileyBitmap As Bitmap
	Dim backgroundColor As Int
	backgroundColor = 0xff79CDCD
	Dim Degrees As Int
End Sub
Sub Service_Create
	lwm.Initialize("lwm", True)
	lwm.StartTicking(30) 'Start the wallpaper timer (30 milliseconds).
	vx = 5dip 'smiley speed
	vy = 5dip
	boxSize = 40dip
	smileyBitmap.Initialize(File.DirAssets, "smiley.gif")
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Sub Service_Destroy

End Sub

Sub lwm_SizeChanged (Engine As LWEngine)
	'Wallpaper size changed.
	If initialized = False Then
		initialized = True
		x = Engine.ScreenWidth / 2
		y = Engine.ScreenHeight / 2
	End If
	DrawBackground (Engine)
End Sub

Sub DrawBackground (Engine As LWEngine)
	Engine.Canvas.DrawColor(backgroundColor)
	Engine.RefreshAll
End Sub

Sub lwm_VisibilityChanged (Engine As LWEngine, Visible As Boolean)
	If Visible Then
		DrawBackground (Engine)
	End If
End Sub
Sub lwm_Tick (Engine As LWEngine)
	If x > Engine.ScreenWidth Then
		vx = -1 * Abs(vx)
	Else If x < boxSize Then
		vx = Abs(vx)
	End If
	If y  + boxSize > Engine.ScreenHeight Then
		vy = -1 * Abs(vy)
	Else If y < boxSize Then
		vy = Abs(vy)
	End If
	Dim r As Rect
	r.Initialize(x - 2dip, y - 2dip, x + boxSize + 4dip, y + boxSize + 4dip)
	Engine.Canvas.DrawRect(r, backgroundColor, True, 1) 'Erase the previous smiley
	x = x + vx
	y = y + vy
	Engine.Rect.Top = y
	Engine.Rect.Left = x
	Engine.Rect.Bottom = y + boxSize
	Engine.Rect.Right = x + boxSize
	Degrees = (Degrees + 10) Mod 360
	Engine.Canvas.DrawBitmapRotated(smileyBitmap, Null, Engine.Rect, Degrees) 'Draw the new smiley
	Engine.RefreshAll
End Sub

Sub lwm_Touch (Engine As LWEngine, Action As Int, tx As Float, ty As Float)
	If Action <> 0 Then Return '0 is the value of Activity.ACTION_DOWN
	If tx > x - boxSize And tx < x + boxSize And _
		ty > y - boxSize And ty < y + boxSize Then
		vx = -vx 'change the smiley direction if the user pressed on it
		vy = -vy
	End If
	'Draw the red circle
	Engine.Canvas.DrawCircle(tx, ty, 5dip, Colors.Red, False, 2dip)
	Engine.Rect.Left = tx - 7dip
	Engine.Rect.Top = ty - 7dip
	Engine.Rect.Right = tx + 7dip
	Engine.Rect.Bottom = ty + 7dip
	Engine.Refresh(Engine.Rect)
End Sub