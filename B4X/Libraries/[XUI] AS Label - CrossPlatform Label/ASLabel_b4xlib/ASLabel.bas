B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.2
@EndOfDesignText@
#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-BugFix - ClickEvent is now working on B4A and B4J
V1.02
	-Add set and get Enabled - Disabled or Enabled the label click events
V1.03
	-Add Icon support
V1.04
	-Add get and set Left
	-Add get and set Top
	-Add get and set Widt
	-Add get and set Height
	-Add get and set Text
	-Add get and set TextColor
	-Add SetColorAndBorder
	-Add SetTextAlignment
	-Add get and set Visible
	-Add get and set Font
	-Add get and set TextSize
#End If

#Event: Click
#If B4A Or B4I
#Event: LongClick
#End If

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xpnlBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private mEnabled As Boolean = True
	Private xlbl_main As B4XView
	
	Private xiv_Icon As B4XView
	Private m_Icon As B4XBitmap
	Private m_IconHeight As Double = 30dip
	Private m_IconGap As Double = 16dip
	Private m_IconPosition As String = "Left Text"
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	#If B4I
	Lbl.UserInteractionEnabled = False
	#End If
	xpnlBase = xui.CreatePanel("base")
	xpnlBase.Color = xui.Color_Transparent
	xlbl_main = Lbl
	mBase.AddView(xpnlBase,0,0,0,0)
	mBase.AddView(xlbl_main,0,0,0,0)
    Tag = mBase.Tag
    mBase.Tag = Me 

	xiv_Icon = CreateImageView("")
	mBase.AddView(xiv_Icon,0,0,0,0)

	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
End Sub

Public Sub Base_Resize (Width As Double, Height As Double) 
	xpnlBase.SetLayoutAnimated(0,0,0,Width,Height)
	xlbl_main.SetLayoutAnimated(0,0,0,Width,Height)
	setIconPosition(m_IconPosition)
End Sub
'gets the native label
Public Sub getLabel As Label
	Return xlbl_main
End Sub
'gets the native label as B4XView
Public Sub getxLabel As B4XView
	Return xlbl_main
End Sub

Public Sub getWidth As Float
	Return mBase.Width
End Sub

Public Sub setWidth(Width As Float)
	mBase.Width = Width
	Base_Resize(Width,mBase.Height)
End Sub

Public Sub getHeight As Float
	Return mBase.Height
End Sub

Public Sub setHeight(Height As Float)
	mBase.Height = Height
	Base_Resize(mBase.Width,Height)
End Sub

Public Sub getTop As Float
	Return mBase.Top
End Sub

Public Sub setTop(Top As Float)
	mBase.Top = Top
End Sub

Public Sub getLeft As Float
	Return mBase.Left
End Sub

Public Sub setLeft(Left As Float)
	mBase.Left = Left
End Sub

Public Sub getColor As Int
	Return mBase.Color
End Sub

Public Sub setColor(Color As Int)
	mBase.Color = Color
End Sub

Public Sub SetColorAndBorder(BackgroundColor As Int,BorderWidth As Float,BorderColor As Int,BorderCornerRadius As Float)
	mBase.SetColorAndBorder(BackgroundColor,BorderWidth,BorderColor,BorderCornerRadius)
End Sub

Public Sub SetTextAlignment(Vertikal As String,Horizontal As String)
	xlbl_main.SetTextAlignment(Vertikal,Horizontal)
End Sub

Public Sub getVisible As Boolean
	Return mBase.Visible
End Sub

Public Sub setVisible(Visible As Boolean)
	mBase.Visible = Visible
End Sub

Public Sub getFont As B4XFont
	Return xlbl_main.Font
End Sub

Public Sub setFont(xFont As B4XFont)
	xlbl_main.Font = xFont
End Sub

Public Sub getText As String
	Return xlbl_main.Text
End Sub

Public Sub setText(Text As String)
	xlbl_main.Text = Text
End Sub

Public Sub getTextColor As Int
	Return xlbl_main.TextColor
End Sub

Public Sub setTextColor(Color As Int)
	xlbl_main.TextColor = Color
End Sub

Public Sub getTextSize As Float
	Return xlbl_main.TextSize
End Sub

Public Sub setTextSize(Size As Float)
	xlbl_main.TextSize = Size
End Sub

#If B4J
Private Sub base_MouseClicked (EventData As MouseEvent)
	Click
End Sub
#Else
Private Sub base_Click
	Click
End Sub

Private Sub base_LongClick
	LongClick
End Sub
#End If

'Disabled or Enabled the label click events
Public Sub setEnabled(Enabled As Boolean)
	mEnabled = Enabled
End Sub

Public Sub getEnabled As Boolean
	Return mEnabled
End Sub

Public Sub setIcon(Icon As B4XBitmap)
	m_Icon = Icon
	Dim scale As Float = 1
    #If B4I
    scale = GetDeviceLayoutValues.NonnormalizedScale
    #End If
	xiv_Icon.SetBitmap(m_Icon.Resize((m_IconHeight*scale),(m_IconHeight*scale),True))
End Sub

Public Sub getIcon As B4XBitmap
	Return m_Icon
End Sub

Public Sub setIconHeight(Height1 As Double)
	m_IconHeight = Height1
	setIconPosition(m_IconPosition)
End Sub
'Default:30dip
Public Sub getIconHeight As Double
	Return m_IconHeight
End Sub

Public Sub setIconGap(Gap1 As Double)
	m_IconGap = Gap1
	setIconPosition(m_IconPosition)
End Sub

Public Sub getIconGap As Double
	Return m_IconGap
End Sub

'Position (Left, Left Text, Center, Right Text, Right)
Public Sub setIconPosition(Position1 As String)
	m_IconPosition = Position1
  
	Dim Width As Double = xpnlBase.Width
	Dim Height As Double = xpnlBase.Height
  
	Dim Top As Double = ((Height/2)-(m_IconHeight/2))
	Dim Left As Double = 0
  
	If m_IconPosition.ToLowerCase = "center" Then
		Left = (Width/2) - (m_IconHeight/2)
  
	Else If m_IconPosition.ToLowerCase = "lefttext" Then
		Dim widthText As Double = MeasureTextWidth(xlbl_main.Text, xlbl_main.Font)
		Left = (Width/2) - (widthText/2) - m_IconGap - m_IconHeight
  
	Else If m_IconPosition.ToLowerCase = "righttext" Then
		Dim widthText As Double = MeasureTextWidth(xlbl_main.Text, xlbl_main.Font)
		Left = (Width/2) + (widthText/2) + m_IconGap
      
	Else If m_IconPosition.ToLowerCase = "left" Then
		Left = m_IconGap
      
	Else If m_IconPosition.ToLowerCase = "right" Then
		Left = Width - m_IconGap - m_IconHeight
      
	Else If m_IconPosition.ToLowerCase = "none" Then
		xiv_Icon.Visible = False
      
	End If
  
	If Not(xiv_Icon.Visible) Then
		xiv_Icon.Visible = True
	End If
  
	xiv_Icon.SetLayoutAnimated(0, Left, Top, m_IconHeight, m_IconHeight)
End Sub

Public Sub getIconPosition As String
	Return m_IconPosition
End Sub

'Private Sub base_Touch(Action As Int, X As Float, Y As Float)
'	
'End Sub

#Region Events

Private Sub Click
	If mEnabled = False Then Return
	If xui.SubExists(mCallBack, mEventName & "_Click", 0) Then
		CallSub(mCallBack, mEventName & "_Click")
	End If
End Sub

Private Sub LongClick 'ignore
	If mEnabled = False Then Return
	If xui.SubExists(mCallBack, mEventName & "_LongClick", 0) Then
		CallSub(mCallBack, mEventName & "_LongClick")
	End If
End Sub

#End Region

#Region Enums

Public Sub IconPosition_Center As String
	Return "Center"
End Sub

Public Sub IconPosition_LeftText As String
	Return "LeftText"
End Sub

Public Sub IconPosition_RightText As String
	Return "RightText"
End Sub
Public Sub IconPosition_Left As String
	Return "Left"
End Sub

Public Sub IconPosition_Right As String
	Return "Right"
End Sub

Public Sub IconPosition_None As String
	Return "None"
End Sub


#End Region

#Region Functions

'https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250
Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
	Dim xui As XUI
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim fnt As B4XFont
	If IsMaterialIcons Then fnt = xui.CreateMaterialIcons(FontSize) Else fnt = xui.CreateFontAwesome(FontSize)
	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub

Private Sub CreateImageView(EventName As String) As B4XView 'Ignore
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
#If B4A
    Private bmp As Bitmap
    bmp.InitializeMutable(2dip, 2dip)
    Private cvs As Canvas
    cvs.Initialize2(bmp)
    Return cvs.MeasureStringWidth(Text, Font1.ToNativeFont, Font1.Size) + 4dip
#Else If B4i
    Return Text.MeasureWidth(Font1.ToNativeFont) + 4dip
#Else If B4J
	Dim jo As JavaObject
	jo.InitializeNewInstance("javafx.scene.text.Text", Array(Text))
	jo.RunMethod("setFont",Array(Font1.ToNativeFont))
	jo.RunMethod("setLineSpacing",Array(0.0))
	jo.RunMethod("setWrappingWidth",Array(0.0))
	Dim Bounds As JavaObject = jo.RunMethod("getLayoutBounds",Null)
	Return Bounds.RunMethod("getWidth",Null) + 4dip
#End If
End Sub

#End Region