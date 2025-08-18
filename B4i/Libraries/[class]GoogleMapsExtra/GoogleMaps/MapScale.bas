B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6
@EndOfDesignText@
'version 1.00
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI
	
	Private cvs As B4XCanvas
	Private TILE_SIZE_METERS_AT_0_ZOOM = 156543.03 As Double
	Private TILE_SIZE_FT_AT_0_ZOOM = 513592.62 As Double
	Private FT_IN_MILE = 5280 As Double
	Private IsMeters As Boolean = True
	Private DeviceDensity As Double
	Private meters() As Int = Array As Int(1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, _
		10000, 20000, 50000, 100000, 200000, 500000, 1000000, 2000000, 5000000)
	Private FT() As Int = Array As Int(1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, _
		FT_IN_MILE, 2 * FT_IN_MILE, 5 * FT_IN_MILE, 10 * FT_IN_MILE, 20 * FT_IN_MILE, 50 * FT_IN_MILE, _
		100 * FT_IN_MILE, 200 * FT_IN_MILE, 500 * FT_IN_MILE, 1000 * FT_IN_MILE, 2000 * FT_IN_MILE, 5000 * FT_IN_MILE)
	Private maxWidth, minWidth As Int
	Private xlbl As B4XView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	#if b4a
	DeviceDensity = Density	
	#else
	DeviceDensity = 1
	#End If
	maxWidth = 90dip
	minWidth = 50dip
	
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
  	cvs.Initialize(mBase)
	xlbl = Lbl
	xlbl.SetTextAlignment("CENTER", "LEFT")
	mBase.AddView(xlbl, 0, mBase.Height / 2 - 5dip, mBase.Width, mBase.Height / 2)
End Sub

Public Sub Update(zoom As Float, Latitude As Double)
	If zoom < 0 Or Abs(Latitude) > 90 Then Return
	Dim t0 As Double
	If IsMeters Then t0 = TILE_SIZE_METERS_AT_0_ZOOM Else t0 = TILE_SIZE_FT_AT_0_ZOOM
	Dim resolution As Double = t0 / DeviceDensity * CosD(Latitude) / Power(2, zoom)
	Dim distances() As Int
	If IsMeters Then distances = meters Else distances = FT
	Dim distanceIndex As Int = FindBestDistance(minWidth, maxWidth, resolution, distances)
	If distanceIndex = -1 Then
		 distanceIndex = FindBestDistance(0, maxWidth, resolution, distances)
		 If distanceIndex = -1 Then distanceIndex = distances.Length - 1
	End If
	Dim screenDistance As Float = Ceil(Abs(distances(distanceIndex) / resolution))
	cvs.ClearRect(cvs.TargetRect)
	xlbl.Text = DistanceToText(distances(distanceIndex))
	Dim strokewidth As Int = 2dip
	cvs.DrawLine(0, cvs.TargetRect.Bottom - 1dip, screenDistance, cvs.TargetRect.Bottom - 1dip, xui.Color_Black, strokewidth)
	If xui.IsB4A Or xui.IsB4i Then screenDistance = screenDistance - strokewidth / 2
	cvs.DrawLine(screenDistance, cvs.TargetRect.Bottom - 1dip, screenDistance, cvs.TargetRect.Bottom - 6dip, xui.Color_Black, strokewidth)
	cvs.Invalidate
End Sub

Private Sub FindBestDistance(Minimum As Float, Maximum As Float, resolution As Double, distances() As Int) As Int
	For index = distances.Length - 1 To 0 Step -1
		Dim screen As Float = Abs(distances(index) / resolution)
		If screen >= Minimum And screen <= Maximum Then Return index
	Next
	Return -1
End Sub

Private Sub DistanceToText(disance As Int) As String
	If IsMeters = False Then
		If disance < FT_IN_MILE Then
			Return disance & " ft"
		Else
			Return (disance / FT_IN_MILE) & " mi"
		End If
	Else
		If disance < 1000 Then
			Return disance & " m"
		Else
			Return (disance / 1000) & " km"
		End If
	End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width, Height)
End Sub

