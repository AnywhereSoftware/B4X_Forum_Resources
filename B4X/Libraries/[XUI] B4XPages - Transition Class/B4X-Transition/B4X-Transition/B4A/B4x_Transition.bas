B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=11
@EndOfDesignText@
'Code module
Sub Process_Globals
End Sub

Public Sub PrepareTransition_RadiusOut (Xui As XUI, RootWidth As Float, RootHeight As Float, CurrentPageRoot As B4XView, NewPageRoot As B4XView) As ResumableSub
	Dim pnl As B4XView = Xui.CreatePanel("")
	NewPageRoot.AddView(pnl, 0, 0, RootWidth, RootHeight)
	pnl.As(Panel).Elevation = 10dip
	Dim cnv As B4XCanvas
	cnv.Initialize(pnl)
	Dim frontBmp As B4XBitmap = CurrentPageRoot.Snapshot 
	Dim backBmp As B4XBitmap = NewPageRoot.Snapshot
	cnv.ClearRect(cnv.TargetRect)
	Dim frames As Int = 20
	Dim stepWidth As Float = RootWidth/frames
	For i = 0 To frames-1
		cnv.DrawBitmap(frontBmp,getRect(0,0,RootWidth,RootHeight))
		Dim path As B4XPath
		path.InitializeOval(getRect((RootWidth/2)-(stepWidth*i),(RootHeight/2)-(stepWidth*i),(stepWidth*2)*i,(stepWidth*2)*i))
		cnv.ClipPath(path)
		cnv.DrawBitmap(backBmp,getRect(0,0,RootWidth,RootHeight))
		cnv.RemoveClip
		cnv.Invalidate
		Sleep(16)
	Next
	pnl.RemoveViewFromParent
	Return True
End Sub

Public Sub PrepareTransition_RadiusIn (Xui As XUI, RootWidth As Float, RootHeight As Float, CurrentPageRoot As B4XView, NewPageRoot As B4XView) As ResumableSub
	Dim pnl As B4XView = Xui.CreatePanel("")
	NewPageRoot.AddView(pnl, 0, 0, RootWidth, RootHeight)
	pnl.As(Panel).Elevation = 10dip
	Dim cnv As B4XCanvas
	cnv.Initialize(pnl)
	Dim frontBmp As B4XBitmap = CurrentPageRoot.Snapshot 
	Dim backBmp As B4XBitmap = NewPageRoot.Snapshot
	Dim startingSize As Float = IIf(RootHeight>RootWidth,RootHeight,RootWidth)
	cnv.ClearRect(cnv.TargetRect)
	Dim frames As Int = 22
	Dim stepSize As Float = startingSize/frames
	For i = 0 To frames-1
		cnv.DrawBitmap(backBmp,getRect(0,0,RootWidth,RootHeight))
		Dim path As B4XPath
		path.InitializeOval(getRect((RootWidth/2)-(startingSize)+(stepSize*i),(RootHeight/2)-(startingSize)+(stepSize*i),(startingSize*2)-((stepSize*2)*i) , (startingSize*2)-((stepSize*2)*i)))
		cnv.ClipPath(path)
		cnv.DrawBitmap(frontBmp,getRect(0,0,RootWidth,RootHeight))
		cnv.RemoveClip
		cnv.Invalidate
		Sleep(16)
	Next
	pnl.RemoveViewFromParent
	Return True
End Sub

Public Sub PrepareTransition_OpenDoor (Xui As XUI, RootWidth As Float, RootHeight As Float, CurrentPageRoot As B4XView, NewPageRoot As B4XView) As ResumableSub
	Dim pnl As B4XView = Xui.CreatePanel("")
	NewPageRoot.AddView(pnl, 0, 0, RootWidth, RootHeight)
	pnl.As(Panel).Elevation = 10dip
	Dim cnv As B4XCanvas
	cnv.Initialize(pnl)
	Dim leftDoor As B4XBitmap = CurrentPageRoot.Snapshot.Crop(0,0,RootWidth/2, RootHeight)
	Dim rightDoor As B4XBitmap = CurrentPageRoot.Snapshot.Crop(RootWidth/2,0,RootWidth/2, RootHeight)
	Dim backBmp As B4XBitmap = NewPageRoot.Snapshot
	cnv.ClearRect(cnv.TargetRect)
	Dim frames As Int = 14
	Dim stepWidth As Float = (RootWidth/2)/frames
	For i = 0 To frames-1
		cnv.DrawBitmap(backBmp,getRect(0,0,RootWidth,RootHeight))
		cnv.DrawBitmap(leftDoor,getRect(-(i*stepWidth),0,RootWidth/2,RootHeight))
		cnv.DrawBitmap(rightDoor,getRect((RootWidth/2)+(i*stepWidth),0,RootWidth/2,RootHeight))
		cnv.Invalidate
		Sleep(16)
	Next
	pnl.RemoveViewFromParent
	Return True
End Sub

Public Sub PrepareTransition_CloseDoor (Xui As XUI, RootWidth As Float, RootHeight As Float, CurrentPageRoot As B4XView, NewPageRoot As B4XView) As ResumableSub
	Dim pnl As B4XView = Xui.CreatePanel("")
	NewPageRoot.AddView(pnl, 0, 0, RootWidth, RootHeight)
	pnl.As(Panel).Elevation = 10dip
	Dim cnv As B4XCanvas
	cnv.Initialize(pnl)
	Dim leftDoor As B4XBitmap = NewPageRoot.Snapshot.Crop(0,0,RootWidth/2, RootHeight)
	Dim rightDoor As B4XBitmap = NewPageRoot.Snapshot.Crop(RootWidth/2,0,RootWidth/2, RootHeight)
	Dim backBmp As B4XBitmap = CurrentPageRoot.Snapshot
	cnv.ClearRect(cnv.TargetRect)
	Dim frames As Int = 14
	Dim stepWidth As Float = (RootWidth/2)/frames
	For i = 0 To frames-1
		cnv.DrawBitmap(backBmp,getRect(0,0,RootWidth,RootHeight))
		cnv.DrawBitmap(leftDoor,getRect(-(RootWidth/2)+(i*stepWidth),0,RootWidth/2,RootHeight))
		cnv.DrawBitmap(rightDoor,getRect(RootWidth-(i*stepWidth),0,RootWidth/2,RootHeight))
		cnv.Invalidate
		Sleep(16)
	Next
	pnl.RemoveViewFromParent
	Return True
End Sub
 
Public Sub PrepareTransition_FadeOut (Xui As XUI, RootWidth As Float, RootHeight As Float, CurrentPageRoot As B4XView, NewPageRoot As B4XView) As ResumableSub
	Dim pnl As B4XView = Xui.CreatePanel("")
	NewPageRoot.AddView(pnl, 0, 0, RootWidth, RootHeight)
	pnl.As(Panel).Elevation = 10dip
	Dim cnv As B4XCanvas
	cnv.Initialize(pnl)
	Dim backBmp As B4XBitmap = CurrentPageRoot.Snapshot
	cnv.ClearRect(cnv.TargetRect)
	cnv.DrawBitmap(backBmp,getRect(0,0,RootWidth,RootHeight))
	cnv.Invalidate
	pnl.Visible = True
	pnl.SetVisibleAnimated(600,False)
	Sleep(600)
	pnl.RemoveViewFromParent
	Return True
End Sub

'Direction, choose between "LEFT" "TOP" "RIGHT" "BOTTOM"
Public Sub PrepareTransition_SlideOut (Xui As XUI, RootWidth As Float, RootHeight As Float, CurrentPageRoot As B4XView, NewPageRoot As B4XView, Direction As String) As ResumableSub
	Dim pnl As B4XView = Xui.CreatePanel("")
	NewPageRoot.AddView(pnl, 0, 0, RootWidth, RootHeight)
	pnl.As(Panel).Elevation = 10dip
	Dim cnv As B4XCanvas
	cnv.Initialize(pnl)
	Dim backBmp As B4XBitmap = CurrentPageRoot.Snapshot
	cnv.ClearRect(cnv.TargetRect)
	cnv.DrawBitmap(backBmp,getRect(0,0,RootWidth,RootHeight))
	cnv.Invalidate
	Select Direction.ToUpperCase
		Case "LEFT"
			pnl.SetLayoutAnimated(400,-pnl.Width,pnl.Top,pnl.Width,pnl.Height)
		Case "TOP"
			pnl.SetLayoutAnimated(400,pnl.left,-pnl.Height,pnl.Width,pnl.Height)
		Case "BOTTOM"
			pnl.SetLayoutAnimated(400,pnl.left,pnl.Height,pnl.Width,pnl.Height)
		Case "RIGHT"	
			pnl.SetLayoutAnimated(400,pnl.Width,pnl.Top,pnl.Width,pnl.Height)
		Case Else 
			pnl.SetLayoutAnimated(400,-pnl.Width,pnl.Top,pnl.Width,pnl.Height)
	End Select
	Sleep(400)
	pnl.RemoveViewFromParent
	Return True
End Sub

Public Sub PrepareTransition_SpiralOut (Xui As XUI, RootWidth As Float, RootHeight As Float, CurrentPageRoot As B4XView, NewPageRoot As B4XView) As ResumableSub
	Dim pnl As B4XView = Xui.CreatePanel("")
	NewPageRoot.AddView(pnl, 0, 0, RootWidth, RootHeight)
	pnl.As(Panel).Elevation = 10dip
	Dim cnv As B4XCanvas
	cnv.Initialize(pnl)
	Dim frontBmp As B4XBitmap = CurrentPageRoot.Snapshot
	Dim backBmp As B4XBitmap = NewPageRoot.Snapshot
	cnv.ClearRect(cnv.TargetRect)
	Dim frames As Int = 35
	Dim stepSizeY As Float = RootHeight/frames
	Dim stepSizeX As Float = RootWidth/frames
	Dim deg As Int = 0
	For i = 0 To frames-1
		cnv.DrawBitmap(backBmp,getRect(0,0,RootWidth,RootHeight))
		deg = deg + 30
		cnv.DrawBitmapRotated(frontBmp,getRect((RootWidth/2)-(RootWidth/2)+(stepSizeX*i),(RootHeight/2)-(RootHeight/2)+(stepSizeY*i),(RootWidth)-((stepSizeX*2)*i) , (RootHeight)-((stepSizeY*2)*i)),deg)
		cnv.Invalidate
		Sleep(16)
	Next
	pnl.RemoveViewFromParent
	Return True
End Sub

Public Sub PrepareTransition_BurnOut (Xui As XUI, RootWidth As Float, RootHeight As Float, CurrentPageRoot As B4XView, NewPageRoot As B4XView) As ResumableSub
	Dim pnl As B4XView = Xui.CreatePanel("")
	NewPageRoot.AddView(pnl, 0, 0, RootWidth, RootHeight)
	pnl.As(Panel).Elevation = 10dip
	Dim spritelist As List
	spritelist.Initialize
	Dim fireSprite As B4XBitmap = Xui.LoadBitmap(File.DirAssets,"fire2.png")
	Dim spWidth, spHeight As Float
	spWidth = fireSprite.Width/4
	spHeight = fireSprite.Height/4
	For y = 0 To 3
		For x = 0 To 3 
			spritelist.Add(fireSprite.Crop(x*spWidth,y*spHeight,spWidth,spHeight))
		Next
	Next
	Dim cnv As B4XCanvas
	cnv.Initialize(pnl)
	Dim frontBmp As B4XBitmap = CurrentPageRoot.Snapshot
	Dim backBmp As B4XBitmap = NewPageRoot.Snapshot
	cnv.ClearRect(cnv.TargetRect)
	Dim frames As Int = 36
	Dim stepSize As Float = RootHeight/frames
	Dim flameframe As Int = 0 
	For i = 0 To frames-1
		cnv.DrawBitmap(backBmp,getRect(0,0,RootWidth,RootHeight))
		Dim path As B4XPath
		path.InitializeRoundedRect(getRect(0,0,RootWidth,RootHeight-(i*stepSize)),0)
		cnv.ClipPath(path)
		cnv.DrawBitmap(frontBmp,getRect(0,0,RootWidth,RootHeight))
		cnv.RemoveClip
		Dim flame As B4XBitmap = spritelist.Get(flameframe)
		cnv.DrawBitmap(flame,getRect(-(pnl.Width*0.2),RootHeight-(pnl.Height*0.35)-(i*stepSize),pnl.Width*1.4,pnl.Height*0.45))
		cnv.Invalidate
		Sleep(16)
		If i Mod 2 = 0 Then _
		flameframe = (flameframe+1) Mod spritelist.Size
	Next
	pnl.RemoveViewFromParent
	Return True
End Sub

Private Sub getRect(x As Float, y As Float, w As Float, h As Float) As B4XRect
	Dim r As B4XRect
	r.Initialize(x,y,x+w,y+h)
	Return r
End Sub
 