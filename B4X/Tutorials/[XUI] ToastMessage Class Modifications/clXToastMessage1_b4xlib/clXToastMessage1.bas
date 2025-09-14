B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6
@EndOfDesignText@
'Class clXToastMessage1
'Description : shows a Toast Message similar to ToastMessageShow in B4A
'Author: UDG
'Revision: 0.3
'Last revision date: 2018-04-30
'Modifications by Greg CHao to mimic B4a, B4i default toastmessageshow
' Length of toastmessage panel will vary with text width
' fixed bugged for B4i version
' made permanent Center, Center alignment of text
' Changed font size - 14 (B4A), 16(B4I), 14(B4J)
' Change panel radius - radius 24(B4A), 10(B4I, B4J)
' Default panel location - Center
' Allows for moving panel location using verticaloffset
' Sets a min. horizontal panel margin from 5-49%

Sub Class_Globals
#if B4J
	Private fx As JFX
#else if B4A
	Private su As StringUtils
#end if
	Private xui As XUI
	Private mBase As B4XView				'base panel from calling Activity(B4A), Form (B4J), Page (B4i)
	Private mPanel As B4XView				'panel holding the message label
	Private mLbl As B4XView					'message label
	Private mPanelPos As Int				'message position relative to mBase
	Private TMList As List					'list of toast messages to display
	Private tempSettings As Map				'temporary settings for internal TM components
	Private displaying As Boolean			'True = a TM is currently displaying
	Private fading As Boolean				'True = fade effect
	Private timer1 As Timer
	Public CONST TMPOS_TOP As Int = 0		'constant to set toast message position relative to mBase
	Public CONST TMPOS_CENTER As Int = 1	'			"			"		"		"
	Public CONST TMPOS_BOTTOM As Int = 2	'			"			"		"		"
	Public CONST VPOS_TOP As Int = 0		'constant to vertically set message label in its panel
	Public CONST VPOS_CENTER As Int = 1		'			"			"		"		"
	Public CONST VPOS_BOTTOM As Int = 2		'			"			"		"		"
	Public CONST HPOS_LEFT As Int = 0		'constant to horizontally set message label in its panel
	Public CONST HPOS_CENTER As Int = 1		'			"			"		"		"
	Public CONST HPOS_RIGHT As Int = 2		'			"			"		"		"

End Sub

'Initializes the object. 
'Base could be an Activity (B4A), MainForm.RootPane (B4J), Page1.RootPanel (B4i) or any other panel.
Public Sub Initialize(Base As B4XView)
	mBase = Base
	mBase.Tag = Me
	Dim l1 As Label
	l1.Initialize("")
#if B4A
	l1.SingleLine = False
#else if B4J
	l1.WrapText = True
#else If B4i
	l1.Multiline = True
#end if
	mLbl = l1
	mPanel = xui.CreatePanel("")
	mPanel.Visible = True
	mPanel.bringtofront
	tempSettings = DuplicateMap(MakeDefaults)				'create and save default settings for TM internal components
	'mPanel.AddView(mLbl, 10dip, 0dip, mBase.Width-twomargin-20dip, 50dip)
	TMList.initialize
	TMList.Add(DuplicateMap(tempSettings))					'save defaults to TMlist
	displaying = False
	fading = False
	timer1.Initialize("timer1", 2000)						'timer default setting on short duration
End Sub

'Returns a Map sporting default values for TM internal components
Private Sub MakeDefaults As Map
	Dim m1 As Map
	m1.Initialize
	'panel default options
	If xui.IsB4A Then
		m1.Put("pColor", xui.Color_ARGB(200,112,112,112))
		m1.Put("pBColor",xui.Color_ARGB(200,112,112,112))
	else if xui.IsB4i Then
		m1.Put("pColor",xui.Color_ARGB(200,0,0,0))					    'Background panel color
		m1.Put("pBColor",xui.Color_ARGB(200,0,0,0))					'Background border color
	else if xui.IsB4j Then
		m1.Put("pColor",xui.Color_ARGB(200,112,112,112))					    'Background panel color
		m1.Put("pBColor",xui.Color_ARGB(200,112,112,112))					'Background border color
	End If
	m1.Put("backgroundPadding", 35dip)
	m1.Put("pBWidth", 0dip)									'Background border width
	If xui.isB4a Then
		m1.Put("pBRadius", 24dip)  'Background border radius
	else if xui.IsB4i Then
		m1.Put("pBRadius", 10dip)  'Background border radius
	else if xui.IsB4j Then
		m1.Put("pBRadius", 10dip)  'Background border radius
	End If
								
	m1.Put("pPos", TMPOS_CENTER)
	'label default options
	If xui.IsB4A Then
		m1.Put("lTSize", 14) 'Message label text size
	Else if xui.IsB4i Then
		m1.Put("lTSize", 16) 'Message label text size
	else if xui.IsB4J Then
		m1.Put("lTSize", 14) 'Message label text size
	End If
	m1.Put("labelPadding", 5dip)				'
	m1.Put("lTColor", (xui.Color_White))					'Message label text color
	m1.Put("lHAlign", (HPOS_CENTER))						'Message label horizontal position
	m1.Put("lVAlign", (VPOS_CENTER))						'Message label vertical position
	'display duration options
	m1.Put("dShort", 2000)									'Message  display time, short duration
	m1.Put("dLong", 3000)									'Message  display time, long duration
	
	Dim dipint As Int = mBase.Width / 9
	m1.Put("horizMinMargin", dipint)						'horizontal margin
	Dim dipint As Int = 60 * (100dip/100)
	m1.Put("bottomMargin", dipint)                			'bottom margin
	m1.Put("verticalOffset", 0)								'vertical offset
	Return m1
End Sub

'Sets default values for the Toast Message internal components
'Background panel is darkgrey, no border, radius 24(B4A), 10(B4I, B4J)
'Its position relative to its parent is CENTER, Vertical Offset = 0dip
'Message label has size 14 (B4A), 16(B4I), 14(B4J), color white;
'Display duration: short = 2s; long = 3s, Horizontal min. Margin = 11% margin
Public Sub SetTMDefaults
	Dim m As Map = TMList.Get(0)
	tempSettings = DuplicateMap(m)
End Sub

'Sets short and long durations (in milliseconds) for message showing
Public Sub SetTMDuration(ShortDuration As Int, LongDuration As Int)
	tempSettings.Put("dShort", ShortDuration)
	tempSettings.Put("dLong", LongDuration)
End Sub

'Sets Vertical offset in dips (default is 0, neg=up, pos=down)
Public Sub SetVerticalOffset(off As Int)
	Dim setting As Int = off * 100dip/100
	tempSettings.Put("verticalOffset", setting)
End Sub

'Sets horizontal min margin as percent of screen width (5-49)%, default=10
Public Sub SetHorizontalMinMargin(horpercent As Int)
	If horpercent >= 5 And horpercent < 50 Then
		Dim setting As Int = mBase.Width * (horpercent/100)
		tempSettings.Put("horizMinMargin", setting)
	End If
End Sub

'Sets Backgroud color, Border width, color and radius for panel holding the Toast Message
Public Sub SetTMBackground(BackgroundColor As Object, BorderWidth As Double, BorderColor As Object, BorderCornerRadius As Double)
	tempSettings.Put("pColor",xui.PaintOrColorToColor(BackgroundColor))
	tempSettings.Put("pBColor",xui.PaintOrColorToColor(BorderColor))
	tempSettings.Put("pBWidth", BorderWidth)
	tempSettings.Put("pBRadius", BorderCornerRadius)
End Sub

'Sets Text message properties: text size, text color
Public Sub SetTMTextProp(aSize As Double, aColor As Object)
	tempSettings.Put("lTSize", aSize)
	tempSettings.Put("lTColor", (xui.PaintOrColorToColor(aColor)))
End Sub

'Sets the position (TOP=0, CENTER=1 or BOTTOM=2) where the Toast Message should be displayed relative to its parent
Public Sub SetTMPosition(aPos As Int)
	If aPos >=0 And aPos <= 2 Then tempSettings.Put("pPos", aPos)
End Sub

'Shows toast message or queues it for later showing
'LongDuration: True = use long duration setting (default 3s); False = use short duration setting (2s)
'FadeEffect: True = use fade in/ fade ou effect; False = use immediate showing/clearing
Public Sub Show (Message As String, LongDuration As Boolean)
	'push parameters to FIFO list
	mPanel.RemoveAllViews
	
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, mBase.width, 40dip)
	Private canvas As B4XCanvas
	canvas.Initialize(p)
	Dim fsize As Float = tempSettings.get("lTSize")
	Dim fnt As B4XFont = xui.CreateDefaultFont(fsize)
	'lpadding for su.MeasureMultilineTextHeight so that it will not calculate 2 lines prematurely
	Dim lpadding As Int = tempSettings.Get("labelPadding")
	Dim sizeoflabel As B4XRect = canvas.MeasureText(Message, fnt)
	sizeoflabel.Width = sizeoflabel.Width + lpadding
	Dim bpadding As Int = tempSettings.Get("backgroundPadding")
	
	'compare left margin
	If tempSettings.Get("horizMinMargin") > (mBase.Width - (sizeoflabel.Width + bpadding))/2 Then
		'use the Horizontal minimum margin to define label width
		sizeoflabel.Width = mBase.Width - tempSettings.Get("horizMinMargin") * 2 - bpadding
	End If
	
	Dim pd As Int = tempSettings.Get("backgroundPadding")
	mPanel.AddView(mLbl, pd/2, 0dip, sizeoflabel.width, 40dip)

	tempSettings.Put("lText", Message)
	tempSettings.Put("tmfade", True)
	tempSettings.Put("tmdur", LongDuration)
	TMList.Add(DuplicateMap(tempSettings))
	If displaying Then Return
	ShowMessage
End Sub

'Internal sub that manages TM showing based on relative options
Private Sub ShowMessage
	Dim m As Map = TMList.Get(1)										'item #1 = message to show
	'set options based on settings saved along the message
	mPanel.SetColorAndBorder(xui.PaintOrColorToColor(m.Get("pColor")), m.Get("pBWidth"), xui.PaintOrColorToColor(m.Get("pBColor")), m.Get("pBRadius"))
	mLbl.TextSize = m.Get("lTSize")
	mLbl.SetTextAlignment("CENTER", "CENTER")
	mLbl.TextColor = xui.PaintOrColorToColor(m.Get("lTColor"))
	mLbl.Text = m.Get("lText") 'Message
	mPanelPos = m.Get("pPos")
	'mLbl.Color = xui.color_red
	Private LDuration, SDuration As Int
	SDuration = m.get("dShort")
	LDuration = m.get("dLong")
	'determine message height based on context (B4A, B4J, B4i)
#if B4J		
	Dim onerow As Double = MeasureMultilineTextHeight(fx.DefaultFont(mLbl.TextSize), mBase.Width, "a")
	mLbl.Height = MeasureMultilineTextHeight(fx.DefaultFont(mLbl.TextSize), mLbl.Width, mLbl.text) + onerow
#end if
#if B4A
	mLbl.Height = su.MeasureMultilineTextHeight(mLbl, mLbl.text) + 2 * 14dip
#End If
#if B4i
	Dim lbl As Label = mLbl
	lbl.SizeToFit
	mLbl.Height = lbl.Height + 2 * 20dip
#End If
	mPanel.Height = mLbl.Height + 2dip 'accounts for descends and eventual alignment set to BOTTOM
	
	Dim bp As Int = tempSettings.Get("backgroundPadding")
	Dim mPanelLeft As Int = (mBase.Width - mLbl.width - bp)/2
	Dim mPanelWidth As Int = mLbl.width + bp
	Dim voff As Int = tempSettings.Get("verticalOffset")
	
	Select mPanelPos
		Case TMPOS_TOP
			mBase.AddView(mPanel, mPanelLeft, 5dip + voff, mPanelWidth, mLbl.height)
		Case TMPOS_CENTER
			mBase.AddView(mPanel, mPanelLeft, (mBase.Height-mPanel.Height)/2 + voff, mPanelWidth, mLbl.height)
		Case TMPOS_BOTTOM
			mBase.AddView(mPanel, mPanelLeft, mBase.Height-mPanel.Height-m.Get("bottomMargin") + voff, mPanelWidth, mLbl.height)
	End Select
	fading = tempSettings.get("tmfade")
	If fading Then	mPanel.SetVisibleAnimated(400, True) Else mPanel.SetVisibleAnimated(0, True)
	displaying = True
	If tempSettings.get("tmdur") Then timer1.Interval = LDuration Else timer1.Interval = SDuration
	timer1.Enabled = True
End Sub

'Used to stop message showing
Private Sub timer1_tick
	If fading Then
		mPanel.SetVisibleAnimated(400, False)
		Sleep(500)
		fading = False
	End If
	timer1.Enabled = False
	mPanel.RemoveViewFromParent
	mBase.Tag = Null
	TMList.RemoveAt(1)
	If TMList.Size > 1 Then ShowMessage Else displaying = False
End Sub

#if B4J
Private Sub MeasureMultilineTextHeight (Font As Font, Width As Double, Text As String) As Double
	Dim jo As JavaObject = Me
	Return jo.RunMethod("MeasureMultilineTextHeight", Array(Font, Text, Width))
End Sub

#if Java
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import javafx.scene.text.Font;
import javafx.scene.text.TextBoundsType;
public static double MeasureMultilineTextHeight(Font f, String text, double width) throws Exception {
  Method m = Class.forName("com.sun.javafx.scene.control.skin.Utils").getDeclaredMethod("computeTextHeight",
  Font.class, String.class, double.class, TextBoundsType.class);
  m.setAccessible(true);
  return (Double)m.invoke(null, f, text, width, TextBoundsType.LOGICAL_VERTICAL_CENTER);
  }
#End If
#end if

'Returns a new map having the same key/value pairs of the source one
Private Sub DuplicateMap(Source As Map) As Map
	Dim m1 As Map
	m1.Initialize
	For Each key As String In Source.Keys
		m1.Put(key, Source.Get(key))
	Next
	Return m1
End Sub