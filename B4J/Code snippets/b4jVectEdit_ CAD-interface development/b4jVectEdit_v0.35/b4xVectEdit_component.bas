B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'v.0.30 Circuit component object: a rectangle + pins

#Event: Click
#Event: LongClick
#Event: View_Change(changed as B4XView)


Private Sub Class_Globals	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Public Name As String
	Private mScale As Double = 1.0
	
	
	Private GridSize As Int = 10dip
	Private mTextLinesGap As Int = 15dip
	Private mTextSize As Float = 7
	Public TextLinesGap As Int, TextSize As Float
	
	Public InternalView As Boolean
	Public mRoot As B4XView
	Public mRect As b4xVectEdit_rect
	Public PinIn1, PinIn2, PinIn3, PinOut As b4xVectEdit_pin
	
	Private DownX, DownY As Int, Dragging As Boolean, DraggingStart As Long	'ignore
	Public mName As B4XView
	
	'Public Internals() As b4xVectEdit_component 'todo
End Sub

Public Sub Initialize (Callback As Object, EventName As String) As b4xVectEdit_component
	mEventName = EventName
	mCallBack = Callback
	setScale(mScale)
	Return Me
End Sub

Private Sub Calc(v As Double) As Double
	Return v * mScale
End Sub

Public Sub setScale(newScale As Float)
	mScale = newScale
	TextLinesGap = Max(10dip, Calc(mTextLinesGap))
	TextSize = Max(mTextSize, Calc(mTextSize))
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mBase.SetColorAndBorder(xui.Color_Transparent, 1dip, xui.Color_Transparent, 0)	'transparent container xui.Color_ARGB(50, 0, 0, 0)
    Tag = mBase.Tag
    mBase.Tag = Me
	
	mRoot = xui.CreatePanel("mRoot")
	mBase.AddView(mRoot, 0, 0, mBase.Width, mBase.Height)	'component is on the base
	
	'left input pins of this component
	PinIn1.Initialize(Me, "Pin")
	PinIn1.Name = "PinIn1"
	PinIn1.DesignerCreateView(mRoot, Null, Null)
	PinIn1.mRoot.Top = mRoot.Top + TextLinesGap * 3
	
	PinIn2.Initialize(Me, "Pin")
	PinIn2.Name = "PinIn2"
	PinIn2.DesignerCreateView(mRoot, Null, Null)
	PinIn2.mRoot.Top = PinIn1.mRoot.Top + TextLinesGap * 2
	
	PinIn3.Initialize(Me, "Pin")
	PinIn3.Name = "PinIn3"
	PinIn3.DesignerCreateView(mRoot, Null, Null)
	PinIn3.mRoot.Top = PinIn2.mRoot.Top + TextLinesGap * 2
	
	'right ouput pin of this component
	PinOut.Initialize(Me, "Pin")
	PinOut.Name = "PinOut"
	PinOut.DesignerCreateView(mRoot, Null, Null)
	PinOut.mRoot.Top = mRoot.Top + TextLinesGap * 3
	PinOut.mRoot.Left = mRoot.Width - PinOut.Length
	
	'rectangle of this component
	mRect.Initialize(Me, "mRect")
	mRect.SideGap = PinOut.PointSizePx
	mRect.DesignerCreateView(mRoot, Null, Null)
	
	Dim Lbl As Label
	Lbl.Initialize("mName")
	mName = Lbl
	mName.TextSize = TextSize
	Dim LabelWidth As Int = (MeasureTextWidth(Name, xui.CreateDefaultFont(mName.TextSize + 1.5)))
	mRoot.AddView(mName, mRect.mRect.Left + mRect.BorderThicknessPx, mRect.mBase.Top + TextLinesGap, LabelWidth, TextLinesGap)
	mName.Text = Name
	
	mRoot.Width = PinOut.mRoot.Left + PinOut.mRoot.Width
	
	PinIn1.mRoot.BringToFront
	PinIn2.mRoot.BringToFront
	PinIn3.mRoot.BringToFront
	PinOut.mRoot.BringToFront
	
	Base_Resize(mBase.Width, mBase.Height)
	
	DownX = mRoot.Left
	DownY = mRoot.Top
End Sub

Private Sub mRoot_MousePressed (EventData As MouseEvent)
	If EventData.PrimaryButtonPressed Then
		Dragging = True
		DraggingStart = DateTime.Now
		DownX = EventData.X
		DownY = EventData.Y
	End If
	EventData.Consume
End Sub

Private Sub mRoot_MouseDragged (EventData As MouseEvent)
	If EventData.PrimaryButtonPressed Then
		If InternalView Then Return
		If DateTime.Now - DraggingStart < 100 Then Return
	
		mRoot.Left = ApplyGrid(mRoot.Left + EventData.X - DownX)
		mRoot.Top = ApplyGrid(mRoot.Top + EventData.Y - DownY)
	End If
	EventData.Consume
End Sub

Private Sub mRoot_MouseReleased (EventData As MouseEvent)
	If EventData.PrimaryButtonPressed Then
		Dragging = False
		If xui.SubExists(mCallBack, "View_Changed", 1) Then
			CallSub2(mCallBack, "View_Changed", mRoot)
		End If
	End If
	EventData.Consume
End Sub

Private Sub ApplyGrid (x As Int) As Int
	If GridSize > 0 Then
		Return x - (x Mod GridSize)
	End If
	Return x
End Sub

Sub Base_Resize (Width As Double, Height As Double)
	mRoot.SetLayoutAnimated(0, (mRoot.Left), (mRoot.Top), (Width), (Height))
	PinIn1.Base_Resize((Width), (Height))
	PinIn2.Base_Resize((Width), (Height))
	PinIn3.Base_Resize((Width), (Height))
	PinOut.Base_Resize((Width), (Height))
	PinOut.mRoot.Left = mRoot.Width - PinOut.Length
	mRect.Base_Resize((Width), (Height))
	
	mName.TextSize = TextSize
	Dim LabelWidth As Int = (MeasureTextWidth(Name, xui.CreateDefaultFont(mName.TextSize + 1.5)))
	mName.SetLayoutAnimated(0, mRect.mRect.Left + mRect.BorderThicknessPx, mRect.mBase.Top + TextLinesGap, (LabelWidth), (TextLinesGap))
	mName.Text = Name
	
	mRoot.Width = (PinOut.mRoot.Left + PinOut.mRoot.Width)
	
	Sleep(0)
End Sub

Private Sub mRoot_MouseClicked (EventData As MouseEvent)
	If Dragging Then Return
	If EventData.PrimaryButtonPressed Then
'		Log("mRoot click: " & Name)
'		If xui.SubExists(mCallBack, mEventmEventName & "_Click", 0) Then
'			CallSub(mCallBack, mEventmEventName & "_Click")
'		End If
	Else if EventData.SecondaryButtonPressed Then
		Log("mRoot longclick: " & Name)
		If xui.SubExists(mCallBack, mEventName & "_LongClick", 0) Then
			CallSub(mCallBack, mEventName & "_LongClick")
		End If
	End If
	EventData.Consume
End Sub

'https://www.b4x.com/android/forum/threads/b4x-xui-add-measuretextwidth-and-measuretextheight-to-b4xcanvas.91865/#content
Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
#If B4A
	Private bmp As Bitmap
	bmp.InitializeMutable(1, 1)'ignore
	Private cvs As Canvas
	cvs.Initialize2(bmp)
	Return cvs.MeasureStringWidth(Text, Font1.ToNativeFont, Font1.Size)
#Else If B4i
    Return Text.MeasureWidth(Font1.ToNativeFont)
#Else If B4J
	Dim jo As JavaObject
	jo.InitializeNewInstance("javafx.scene.text.Text", Array(Text))
	jo.RunMethod("setFont",Array(Font1.ToNativeFont))
	jo.RunMethod("setLineSpacing",Array(0.0))
	jo.RunMethod("setWrappingWidth",Array(0.0))
	Dim Bounds As JavaObject = jo.RunMethod("getLayoutBounds",Null)
	Return Bounds.RunMethod("getWidth",Null)
#End If
End Sub

Private Sub Pin_Click
	Dim v As b4xVectEdit_pin = Sender
	Log(v.Name)
	Main.toast.Show(v.Name & ": TODO connecting pin to another...")
End Sub

Private Sub Pin_LongClick
	Dim v As b4xVectEdit_pin = Sender
	Log("Long:" & v.Name)
	Main.toast.Show(v.Name & ": TODO menu for renaming connection...")
End Sub


'Private Sub mRoot_MouseEntered (EventData As MouseEvent)
'	CallSub(mCallBack, "Disable_Scroll")
'	EventData.Consume
'End Sub
'
'Private Sub mRoot_MouseExited (EventData As MouseEvent)
'	CallSub(mCallBack, "Enable_Scroll")
'End Sub