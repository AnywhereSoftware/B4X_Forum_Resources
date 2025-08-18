Type=Class
Version=5.2
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
'Class module
Sub Class_Globals
	
	Private gPanel As Panel

	Dim bmFore As Bitmap
	Dim bmBack As Bitmap
	Dim bmGaug As Bitmap
	Dim csvMn  As Canvas
	Dim x, y   As Int
	Dim Dback, Dfore, Dgaug As Rect

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(parent As Panel, gTop As Int, gLeft As Int, gaugewidth As Int, gaugeheight As Int, maxNum As Int, bitMgauge As String, needleType As String, bitBak As String)

	bmGaug.Initialize(File.DirAssets, bitMgauge)	'roundback1
	bmFore.Initialize(File.DirAssets, needleType)	'roundback2
	bmBack.Initialize(File.DirAssets, bitBak)		'roundback3

	gPanel.Initialize("")
	gPanel.Visible = False
	parent.AddView(gPanel, gLeft, gTop, DipToCurrent(gaugewidth), DipToCurrent(gaugeheight))

	x = 0
	y = 0
	Dback.Initialize(x,y,x + gaugewidth, y + gaugeheight)
	Dfore.Initialize(x,y,x + gaugewidth, y + gaugeheight)
	Dgaug.Initialize(x,y,x + gaugewidth, y + gaugeheight)

	csvMn.Initialize(gPanel)

	csvMn.DrawBitmap(bmBack, Null, Dback)
	csvMn.DrawBitmapRotated(bmBack, Null, Dback, 0)	'roundback3
	csvMn.DrawBitmapRotated(bmFore, Null, Dfore, 0) 'roundback2 - needle

	csvMn.DrawBitmap(bmGaug, Null, Dgaug)
End Sub

Public Sub ChangeVal(VAngle As Float, Lt As Double, Lg As Double) As Float
	Dim T As Double = Floor(Round(Lt))
	Dim G As Double = Floor(Round(Lg))
	Dim Declination_1 As Float = -VAngle + ((OverlayMap.MD.MAGNETIC_DECLINATION_local + (Lg - G)) * 0.22 + ((Lt - T) * 0.2))	'(MAGNETIC N)
	Dim Declination_2 As Float =  VAngle + ((OverlayMap.MD.MAGNETIC_DECLINATION_local + (Lg - G)) * 0.22 + ((Lt - T) * 0.2))	'(T R U E  N)

	csvMn.DrawBitmap(bmBack, Null, Dback)
	csvMn.DrawBitmapRotated(bmBack, Null, Dback, Declination_1) 'roundback3				(MAGNETIC N)
	csvMn.DrawBitmapRotated(bmFore, Null, Dfore, Declination_1) 'roundback2 - needle	(MAGNETIC N)
	csvMn.DrawBitmap(bmGaug, Null, Dgaug)
	gPanel.Invalidate
	
	Return Declination_2
End Sub

Sub ChangeVisible(visible As Boolean) As Boolean
	gPanel.Visible = visible
	Return visible
End Sub
