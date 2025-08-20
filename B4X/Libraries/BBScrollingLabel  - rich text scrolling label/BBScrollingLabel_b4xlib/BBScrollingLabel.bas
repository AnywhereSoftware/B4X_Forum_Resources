B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#DesignerProperty: Key: MaxWidth, DisplayName: Max Width, FieldType: Int, DefaultValue: 2000
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private BBLabel1 As BBLabel
	Private engine As BCTextEngine
	Private mText As String
	Private MaxWidth As Int
	Private ImageView1 As B4XView
	Private ImageView2 As B4XView
	Private LoopIndex As Int
	Public WidthPerSecond As Int = 100dip
	Public StartPositionDelay As Int = 1000
	Public Gap As Int = 5dip
	Private bc As BitmapCreator
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	bc.Initialize(1, 1)
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Dim p As B4XView = xui.CreatePanel("")
	mBase.AddView(p, 0, 0, mBase.Width, mBase.Height)
	MaxWidth = Props.GetDefault("MaxWidth", 2000)
	Sleep(0)
	p.LoadLayout("BBScrollingLabel")
	BBLabel1.mBase.Visible = False
	BBLabel1.mBase.Width = MaxWidth
	BBLabel1.DisableResizeEvent = True
	SetShared
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	mBase.GetView(0).SetLayoutAnimated(0, 0, 0, Width, Height)
	If engine.IsInitialized And BBLabel1.IsInitialized Then
		AfterTextOrSizeChanged
	End If
End Sub

Public Sub setTextEngine (t As BCTextEngine)
	engine = t
	SetShared
End Sub

Public Sub setText (s As String)
	mText = s
	SetShared
End Sub

Public Sub getText As String
	Return mText
End Sub

Private Sub SetShared
	If BBLabel1.IsInitialized Then
		If BBLabel1.TextEngine.IsInitialized = False Then
			BBLabel1.TextEngine = engine
		End If
		BBLabel1.Text = mText
		AfterTextOrSizeChanged
	End If
End Sub

Private Sub AfterTextOrSizeChanged
	LoopIndex = LoopIndex + 1
	
	ImageView1.Visible = True
	Dim iv1 As B4XView = BBLabel1.ForegroundImageView
	Dim ivwidth As Int = iv1.Width
	Dim ivheight As Int = iv1.Height
	Dim bmp As B4XBitmap = BBLabel1.ForegroundImageView.GetBitmap
	If bmp.IsInitialized = False Or BBLabel1.Paragraph.Height = 0 Then
		ImageView1.Visible = False
		ImageView2.Visible = False
		Return
	End If
	bc.SetBitmapToImageView(bmp, ImageView1)
	bc.SetBitmapToImageView(bmp, ImageView2)
	Dim h As Int = mBase.Height / 2 - ivheight / 2
	ImageView1.SetLayoutAnimated(0, 0, h, ivwidth, ivheight)
	ImageView2.SetLayoutAnimated(0, ivwidth + Gap, h, ivwidth, ivheight)
	If ivwidth <= mBase.Width Then
		ImageView2.Visible = False
	Else
		ImageView2.Visible = True
		Dim MyIndex As Int = LoopIndex
		Dim duration As Int = ivwidth / WidthPerSecond * 1000
		Sleep(StartPositionDelay)
		If MyIndex <> LoopIndex Then Return
		Do While True
			ImageView1.SetLayoutAnimated(duration, -ivwidth - Gap, ImageView1.Top, ImageView1.Width, ImageView1.Height)
			ImageView2.SetLayoutAnimated(duration, 0, ImageView1.Top, ImageView1.Width, ImageView1.Height)
			Sleep(duration)
			If MyIndex <> LoopIndex Then Return
			Sleep(StartPositionDelay)
			If MyIndex <> LoopIndex Then Return
			ImageView1.SetLayoutAnimated(0, 0, h, ivwidth, ivheight)
			ImageView2.SetLayoutAnimated(0, ivwidth + Gap, h, ivwidth, ivheight)
		Loop
	End If
End Sub
