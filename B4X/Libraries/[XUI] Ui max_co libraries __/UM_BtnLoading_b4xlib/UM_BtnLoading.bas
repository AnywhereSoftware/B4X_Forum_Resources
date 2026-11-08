B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Version: 1.20
'Ui max_co


#Event: ShowPage
#Event: ClickedButton

#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description:Background Color
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF12153D, Description:Text Color
#DesignerProperty: Key: Text, DisplayName: Text, FieldType: String, DefaultValue: Ui max_co
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 10, MinRange: 0, MaxRange: 100, Description: Corner Radius
#DesignerProperty: Key: TextSize, DisplayName: Text Size, FieldType: Int, DefaultValue: 17, MinRange: 0, MaxRange: 100, Description: Text Size
#DesignerProperty: Key: RotationalSpeed, DisplayName: Rotational speed, FieldType: String, DefaultValue: Normal, List: Fast|Normal|Slow

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Type UMBtnLoadingViewes(btn As B4XView,Lbl As B4XView)
	Type UMBtnLoadingVar(BackgroundColor As Int,TextColor As Int,Text As String,CornerRadius As Int,TextSize As Int,Fonts As B4XFont,index As Int)
	
	Private xviewes As UMBtnLoadingViewes
	Private Var As UMBtnLoadingVar
	Private styleee As Int = 800
	Private Rotationss As Int = 180
	Private leftMbase As Int
	Private topMbase As Int 
	Private widthMbase As Int
	Private HeightMbase As Int
	
	Private leftBtn,TopBtn,WidthBtn,HeightBtn As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	
	FillVar(Props)
	Design
	
End Sub

Private Sub Base_Resize (width As Double, Height As Double)
	
	If xviewes.Lbl.Visible Then
		xviewes.btn.SetLayoutAnimated(0,leftBtn,TopBtn,width,HeightBtn)
		xviewes.Lbl.SetLayoutAnimated(0,0,0,xviewes.btn.Width,xviewes.btn.Height)
		Return
	End If
	
	Private center As Double = width/2
	
	If xviewes.btn.Visible Then
		xviewes.btn.Left = center-(xviewes.btn.Width/2)
		Return
	End If
  
End Sub

Private Sub FillVar(props As Map)
	
	Var.BackgroundColor = xui.PaintOrColorToColor(props.Get("BackgroundColor"))
	Var.TextColor = xui.PaintOrColorToColor(props.Get("TextColor"))
	Var.Text = props.Get("Text")
	Var.CornerRadius = props.Get("CornerRadius")
	Var.TextSize = props.Get("TextSize")
	Var.Fonts = xui.CreateDefaultBoldFont(Var.TextSize)
	Select props.Get("RotationalSpeed")
		Case "Fast"
			styleee = 800
		Case "Normal"
			styleee = 1000
		Case "Slow"
			styleee = 1200
	End Select
	
End Sub

Private Sub Design
	Private top As Double = mBase.Top
	Private hi As Double = mBase.Height
	
''''mBase
	mBase.SetColorAndBorder(xui.Color_Transparent,0,xui.Color_Transparent,0)
	mBase.SetLayoutAnimated(0,mBase.Left,top-10dip,mBase.Width,hi+20dip)
	
''''Button
	xviewes.btn = xui.CreatePanel("btn")
	xviewes.btn.SetColorAndBorder(Var.BackgroundColor,0,0,Var.CornerRadius)
	mBase.AddView(xviewes.btn,0,10dip,mBase.Width,mBase.Height-20dip)
	
	leftBtn = xviewes.btn.Left
	TopBtn = xviewes.btn.Top
	WidthBtn = xviewes.btn.Width
	HeightBtn = xviewes.btn.Height
	
''''Text
	xviewes.Lbl	= Createlabel
	xviewes.Lbl.Font = Var.Fonts
	xviewes.Lbl.Text = Var.Text
	xviewes.Lbl.TextSize = Var.TextSize
	xviewes.Lbl.TextColor = Var.TextColor
	xviewes.Lbl.SetTextAlignment("CENTER","CENTER")
	xviewes.btn.AddView(xviewes.Lbl,0,0,xviewes.btn.Width,xviewes.btn.Height)
	
End Sub

Private Sub Createlabel As B4XView
	
	Private l As Label
	l.Initialize("")
	#if B4A
	l.SingleLine = True
	l.Ellipsize = "END"
	#End If
	
	Return l
	
End Sub

#if B4J
Private Sub btn_MouseClicked (EventData As MouseEvent)
#Else	
Private Sub btn_Click
#End if	

	leftBtn = xviewes.btn.Left
	TopBtn = xviewes.btn.Top
	WidthBtn = xviewes.btn.Width
	HeightBtn = xviewes.btn.Height

	AnimRaft
	
End Sub

Private Sub AnimRaft
	Private Center As Int = mBase.Width/2
	
	xviewes.Lbl.SetVisibleAnimated(200,False)
	xviewes.Lbl.SetTextSizeAnimated(200,Var.TextSize*1.5)
	
	xviewes.btn.SetLayoutAnimated(400,Center-(xviewes.btn.Height/2),xviewes.btn.Top,xviewes.btn.Height,xviewes.btn.Height)
	
	Sleep(450)
	
	If xui.SubExists(mCallBack,mEventName &"_ClickedButton",0) Then
		CallSub(mCallBack,mEventName &"_ClickedButton")
	End If
	
	MainLoop
	

End Sub

Private Sub MainLoop
	
	
	Var.index = Var.index + 1
	Dim MyIndex As Int = Var.index
	Do While MyIndex = Var.index
		xviewes.btn.SetRotationAnimated(styleee,Rotationss)
'		RotateViewShortestArc(xviewes.btn,styleee,Rotationss)
		
'		Dim progress As Float = (DateTime.Now - n) / duration
'		progress = progress - Floor(progress)
'		cvs.ClearRect(cvs.TargetRect)
'		CallSub2(Me, DrawingSubName, progress)
'		cvs.Invalidate
		
		Rotationss = Rotationss+360
		

		Sleep(styleee)
		
'		If styleee = 1000 Then
'			styleee = 850
'		Else
'			styleee = 1000
'		End If
	Loop
	
End Sub

Sub RotateViewShortestArc (v As B4XView, Duration As Int, Target As Int) 'ignore
	Dim Rotation As Int = v.Rotation
	Dim dx As Int = (Target - Rotation) Mod 360
	If dx > 180 Then
		dx = -(360 - dx)
	Else if dx < -180 Then
		dx = 360 + dx
	End If
	v.SetRotationAnimated(Duration, Rotation + dx)
End Sub



 #Region SETTER
 
Public Sub Result(Success As Boolean,RootOrActivity As B4XView)
	
	If xviewes.Lbl.Visible Then
		Log("The library should be in loading mode, then contact this sub")
		Return
	End If
	
	If Success Then True_Animation(RootOrActivity) Else False_Animation

End Sub
 
Public Sub SetColorAndBorders(backgroundColor1 As Int,BoderWidth1 As Int,BorderColor1 As Int,BorderCornerRadius1 As Int)
	Var.BackgroundColor = backgroundColor1
	Var.CornerRadius = BorderCornerRadius1
	
	If xviewes.btn.Visible Then
		xviewes.btn.SetColorAndBorder(backgroundColor1,BoderWidth1,BorderColor1,BorderCornerRadius1)
	Else	
		mBase.SetColorAndBorder(backgroundColor1,BoderWidth1,BorderColor1,BorderCornerRadius1)
	End If
End Sub

Public Sub SetFonts(MyFont As B4XFont)
	Var.Fonts = MyFont
	xviewes.Lbl.Font = Var.Fonts
End Sub

Public Sub SetText(myText As String)
	Var.Text = myText
	xviewes.Lbl.Text = Var.Text
End Sub

Public Sub SetTextColor(MyColor As Int)
	Var.TextColor = MyColor
	xviewes.Lbl.TextColor = Var.TextColor
End Sub

Public Sub SetTextSize(MySize As Int)
	Var.TextSize = MySize
	xviewes.Lbl.TextSize = Var.TextSize
End Sub
 
 #End Region
 
Private Sub True_Animation(root As B4XView) 
	Private Center As Int = mBase.Width/2
	
	leftMbase = mBase.Left
	topMbase = mBase.Top
	widthMbase = mBase.Width
	HeightMbase = mBase.Height
	
	styleee = 900
	Sleep(600)
	Var.index = Var.index+1
	Sleep(339)
	

	
	mBase.BringToFront
	mBase.SetLayoutAnimated(0,mBase.Left+(Center-(xviewes.btn.Height/2)),mBase.Top+10dip,xviewes.btn.Width,xviewes.btn.Height)
	mBase.SetColorAndBorder(Var.BackgroundColor,0,0,Var.CornerRadius)
	
	mBase.Visible = True
	xviewes.btn.Visible = False
	xviewes.btn.Rotation = 0
	

	
	mBase.SetLayoutAnimated(800,-10dip,-10dip,root.Width+20dip,root.Height+20dip)
	
	Sleep(1200)
	
	If xui.SubExists(mCallBack,mEventName &"_ShowPage",0) Then
		CallSub(mCallBack,mEventName &"_ShowPage")
	End If
	
	Sleep(900)
	
	mBase.SetLayoutAnimated(0,leftMbase,topMbase,widthMbase,HeightMbase)
	mBase.SetColorAndBorder(xui.Color_Transparent,0,xui.Color_Transparent,0)
	Sleep(450)
	xviewes.btn.Rotation = 0
	Rotationss = 360
	'xviewes.btn.SetLayoutAnimated(400,0,10dip,mBase.Width,mBase.Height-20dip)
	xviewes.btn.SetLayoutAnimated(400,leftBtn,TopBtn,WidthBtn,HeightBtn)
	xviewes.btn.Visible = True
	
	Sleep(750)
	
	xviewes.Lbl.SetVisibleAnimated(500,True)
	xviewes.Lbl.TextSize = Var.TextSize
	xviewes.Lbl.SetLayoutAnimated(0,0,0,xviewes.btn.Width,xviewes.btn.Height)
End Sub

Private Sub False_Animation
	
	styleee = 900
	Sleep(600)
	Var.index = Var.index+1
	Sleep(739)
	xviewes.btn.Rotation = 0
	Rotationss = 360
	xviewes.btn.SetLayoutAnimated(400,0,xviewes.btn.Top,mBase.Width,xviewes.btn.Height)
	
	Sleep(400)
	
	xviewes.Lbl.SetLayoutAnimated(0,0,0,xviewes.btn.Width,xviewes.btn.Height)
	xviewes.Lbl.SetVisibleAnimated(500,True)
	xviewes.Lbl.TextSize=Var.TextSize
	
End Sub