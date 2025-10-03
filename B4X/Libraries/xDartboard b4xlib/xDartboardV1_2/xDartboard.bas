B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'xDartboard CustomView
'
'Author Klaus CHRISTL
'
'Version 1.2 Corected red / green and black / white color, the were not on the correct sector
'Version 1.1 Added the check to avoid multiple events with the same parameters

#Event: Changed(Ring As Int,Sector As Int)
#RaisesSynchronousEvents: Changed(Ring As Int, Sector As Int)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private pnlMain As B4XView
	Private cvsMain As B4XCanvas
	Private bmcMain As BitmapCreator
	Private FontNumbers As B4XFont
	
	Private Radius0(8), Radius(8), RadiusNumbers0, RadiusNumbers As Float
	Private CurrentRadius, CurrentAngle As Float
	Private SectorNumber(20) As Int
	Private BoardDiameter, BoardRadius As Int
	Private Ring, Sector, PrevRing, PrevSector As Int
	Public ColBW(2), ColRG(2), ColorFrames, ColorNumbers As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback

	Radius0(1) = 0.028	' 6.35
	Radius0(2) = 0.071	' 16
	Radius0(3) = 0.439	' 99
	Radius0(4) = 0.475	' 107
	Radius0(5) = 0.718	' 162
	Radius0(6) = 0.754	' 170
	Radius0(7) = 1			' 225.5
	RadiusNumbers0 = 0.87
	
	SectorNumber(0) = 20
	SectorNumber(1) = 1
	SectorNumber(2) = 18
	SectorNumber(3) = 4
	SectorNumber(4) = 13
	SectorNumber(5) = 6
	SectorNumber(6) = 10
	SectorNumber(7) = 15
	SectorNumber(8) = 2
	SectorNumber(9) = 17
	SectorNumber(10) = 3
	SectorNumber(11) = 19
	SectorNumber(12) = 7
	SectorNumber(13) = 16
	SectorNumber(14) = 8
	SectorNumber(15) = 11
	SectorNumber(16) = 14
	SectorNumber(17) = 9
	SectorNumber(18) = 12
	SectorNumber(19) = 5
	
	ColBW(0) = xui.Color_Black
	ColBW(1) = xui.Color_White
	ColRG(0) = xui.Color_Red
	ColRG(1) = xui.Color_Green
	ColorFrames = xui.Color_RGB(150, 150, 150)
	ColorNumbers = xui.Color_RGB(220, 220, 220)
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	Sleep(0)
#If B4A
	SetupDartboard
	DrawDartboard
#End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	If pnlMain.IsInitialized = False Then
		SetupDartboard
	End If
	
	DrawDartboard
End Sub

Private Sub SetupDartboard
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, xui.Color_Transparent, 0)
	
	pnlMain = xui.CreatePanel("pnlMain")
	mBase.AddView(pnlMain, 0, 0, mBase.Width, mBase.Height)
	cvsMain.Initialize(pnlMain)
	bmcMain.Initialize(mBase.Width, mBase.Width)
End Sub

Private Sub pnlMain_Touch (Action As Int, X As Float, Y As Float)
	Select Action
		Case pnlMain.TOUCH_ACTION_DOWN, pnlMain.TOUCH_ACTION_MOVE
			CurrentRadius = Sqrt((X - BoardRadius) * (X - BoardRadius) + (Y - BoardRadius) * (Y - BoardRadius))
			CurrentAngle = ATan2D(X - BoardRadius, BoardRadius - Y)
			If CurrentAngle < 0 Then
				CurrentAngle = CurrentAngle + 360
			End If
			Ring = GetRingIndex
			Sector = GetSectorIndex
			If xui.SubExists(mCallBack, mEventName & "_Changed", 2) And Ring <> PrevRing Or Sector <> PrevSector Then
				CallSub3(mCallBack, mEventName & "_Changed", Ring, Sector)
			End If
			PrevRing = Ring
			PrevSector = Sector
		Case pnlMain.TOUCH_ACTION_UP
			CallSub3(mCallBack, mEventName & "_Changed", -1, -1)
	End Select
End Sub

Private Sub GetRingIndex As Int
	Private i As Int
	
	For i = 0 To Radius.Length - 2
		If CurrentRadius >= Radius(i) And CurrentRadius < Radius(i + 1) Then
			Return i
		End If
	Next
	Return -1
End Sub

Private Sub GetSectorIndex As Int
	Private Index As Int
	
	Index = Floor(CurrentAngle / 18 + 0.5)
	If Index = 20 Then
		Index = 0
	End If
	Return SectorNumber(Index)
End Sub

Private Sub DrawDartboard
	Private xc, yc As Int
	Private i, j As Int
	Private Angle As Int
	Private x1, x2, y1, y2 As Int
	Private rect As B4XRect
	Private dy As Int
	
	BoardDiameter = Min(mBase.Width, mBase.Height)
	BoardRadius = BoardDiameter / 2
	
	pnlMain.Width = Min(BoardDiameter, BoardDiameter)
	pnlMain.Height = pnlMain.Width
	cvsMain.Resize(BoardDiameter, BoardDiameter)
	bmcMain.Initialize(BoardDiameter, BoardDiameter)

	xc = BoardRadius
	yc = BoardRadius
	
	For i = 0 To Radius0.Length - 1
		Radius(i) = BoardRadius * Radius0(i)
	Next
	RadiusNumbers = BoardRadius * RadiusNumbers0
	
	FontNumbers = xui.CreateDefaultFont(BoardDiameter * 0.07 / xui.Scale)
	cvsMain.ClearRect(cvsMain.TargetRect)
	bmcMain.DrawRect(bmcMain.TargetRect, xui.Color_Transparent, True, 1dip)
	bmcMain.DrawCircle(xc, yc, Radius(7), xui.Color_Black, True, 1dip)
	
	rect = cvsMain.MeasureText("8", FontNumbers)
	dy = rect.CenterY
	For i = 0 To 19
		Angle = i * 18 - 99
		j = i Mod 2
		bmcMain.DrawArc(xc, yc, Radius(6), ColRG(j), True, 1dip, Angle, 18)
		bmcMain.DrawArc(xc, yc, Radius(5), ColBW(j), True, 1dip, Angle, 18)
		bmcMain.DrawArc(xc, yc, Radius(4), ColRG(j), True, 1dip, Angle, 18)
		bmcMain.DrawArc(xc, yc, Radius(3), ColBW(j), True, 1dip, Angle, 18)
		bmcMain.DrawCircle(xc, yc, Radius(2), ColRG(1), True, 1dip)
		bmcMain.DrawCircle(xc, yc, Radius(1), ColRG(0), True, 1dip)
		x1 = xc + Radius(2) * SinD(Angle)
		y1 = yc + Radius(2) * CosD(Angle)
		x2 = xc + Radius(6) * SinD(Angle)
		y2 = yc + Radius(6) * CosD(Angle)
		bmcMain.DrawLine(x1, y1, x2, y2, ColorFrames, 2dip)
	Next
	bmcMain.DrawCircle(xc, yc, Radius(7), ColorFrames, False, 2dip)
	bmcMain.DrawCircle(xc, yc, Radius(6), ColorFrames, False, 2dip)
	bmcMain.DrawCircle(xc, yc, Radius(5), ColorFrames, False, 2dip)
	bmcMain.DrawCircle(xc, yc, Radius(4), ColorFrames, False, 2dip)
	bmcMain.DrawCircle(xc, yc, Radius(3), ColorFrames, False, 2dip)
	bmcMain.DrawCircle(xc, yc, Radius(2), ColorFrames, False, 2dip)
	
	cvsMain.DrawBitmap(bmcMain.Bitmap, cvsMain.TargetRect)
	
	For i = 0 To 19
		Angle = i * 18
		x1 = xc + RadiusNumbers * SinD(Angle)
		y1 = yc - RadiusNumbers * CosD(Angle) - dy
		cvsMain.DrawText(SectorNumber(i), x1, y1, FontNumbers, ColorNumbers, "CENTER")
	Next
	
	cvsMain.Invalidate
End Sub
