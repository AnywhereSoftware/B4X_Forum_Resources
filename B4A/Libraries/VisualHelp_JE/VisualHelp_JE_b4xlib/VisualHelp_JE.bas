B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
'Author Jerryk
'Version 1.13

Sub Class_Globals
	Private root1 As B4XView
	Private xui As XUI
	Private su As StringUtils
	Private nativeMe As JavaObject
	Private lHelps As List
	Type tProperties (Black As Boolean, TextColor As Int, TextSize As Float, Textcd As ColorDrawable, frameColor As Int, frameWidth As Int) 
	Type tHelp (Kind As Byte, Target As B4XView, Help As String, Icon As Byte, Properties As tProperties)
	Type tInfo (Kind As Byte, Info As String, yPos As Int, Properties As tProperties)
	Type tAbsPos (Top As Float, Left As Float)
	Private xClick As Boolean = False
	Private tmr As Timer
	Private timeDisplay As Long
	
	Private kINFO As Byte = 0
	Private kHELP As Byte = 1

	Public Const ICON_NONE As Byte = 0
	Public Const ICON_ARROW_UP As Byte = 1
	Public Const ICON_ARROW_DOWN As Byte = 2
	Public Const ICON_ARROW_RIGHT As Byte = 3
	Public Const ICON_ARROW_LEFT As Byte = 4
	
	Public Const GIF_TAP As Byte = 100
	Public Const GIF_SWIPE_UP As Byte = 101
	Public Const GIF_SWIPE_DOWN As Byte = 102
	Public Const GIF_SWIPE_RIGHT As Byte = 103
	Public Const GIF_SWIPE_LEFT As Byte = 104
	Public Const GIF_SCROLL_HORIZONTAL As Byte = 105
	Public Const GIF_SCROLL_VERTICAL As Byte = 106
	
	Private cvs As B4XCanvas
	Private mainRect, viewRect, frameRect, prevRect As B4XRect
'	Private prevRect As tPrevRect
	Private pnlHelp As Panel
	Private pnlIcon As Panel
	Private ivIcon As B4XImageView
	Private gvGif As B4XGifView
	Private HelpText As Label
	
'	properties
	Private pBackgroundColor As Int = 0x80808080
	Private pSwitchIconColor As Boolean = True
	Private pBlack As Boolean = False
	Private pTextColor As Int = 0xFFF5F5F5
	Private pTextSize As Float = 20
	Private pcdText As ColorDrawable
	pcdText.Initialize2(xui.Color_Black, 10dip, 2dip, xui.Color_RGB(245, 245, 245)) 'ignore
	Private frameColor As Int = xui.Color_Yellow
	Private frameWidth As Int = 3dip
End Sub

'Parent - parent object, timeDisplay - time to display next help, 0 = disabled.
Public Sub Initialize(Parent As B4XView, ptimeDisplay As Long)
	root1 = Parent
	nativeMe = Me

	Dim pnlHelp As Panel
	pnlHelp.Initialize("pnlHelp")
	root1.AddView(pnlHelp, 0, 0, root1.Width, root1.Height)
	pnlHelp.LoadLayout("lHelp")
	mainRect.Initialize(0, 0, pnlHelp.Width, pnlHelp.Height)
	prevRect.initialize(0, 0, 0, 0)
	frameRect.Initialize(0, 0, 0, 0)
	cvs.Initialize(pnlHelp)
	cvs.DrawRect(mainRect, pBackgroundColor, True, 1dip)
	cvs.Invalidate
	timeDisplay = ptimeDisplay
	tmr.Initialize("tmrDisplay", ptimeDisplay)
	lHelps.Initialize
End Sub

'adds info panel
Public Sub AddInfo(pInfo As String, pY As Int)
	Dim xInfo As tInfo
	xInfo.Kind = kINFO
	xInfo.Info = pInfo
	xInfo.yPos = pY
	xInfo.Properties = SetProperties(pBlack, pTextColor, pTextSize, pcdText, frameColor, frameWidth)
	lHelps.Add(xInfo)
End Sub

'adds help panel
Public Sub AddHelp(pTarget As B4XView, pHelp As String, pIcon As Byte)
	Do While Not(pTarget.IsInitialized)
		Sleep(50)
	Loop

	Dim xhelp As tHelp
	xhelp.Kind = kHELP
	xhelp.Target = pTarget
	xhelp.Help = pHelp
	xhelp.Icon = pIcon
	xhelp.Properties = SetProperties(pBlack, pTextColor, pTextSize, pcdText, frameColor, frameWidth)

	lHelps.Add(xhelp)
End Sub

Private Sub SetProperties(xBlack As Boolean, xTextColor As Int, xTextSize As Float, xTextcd As ColorDrawable, xframeColor As Int, xframeWidth As Int) As tProperties
	Dim tp As tProperties
	tp.Black = xBlack
	tp.TextColor = xTextColor
	tp.TextSize = xTextSize
	tp.Textcd = xTextcd
	tp.frameColor = xframeColor
	tp.frameWidth = xframeWidth
	Return tp
End Sub

'show all info and help panels
Public Sub ShowHelp As ResumableSub
	If timeDisplay > 0 Then
		tmr.Enabled = True
	End If

	pnlHelp.Visible = True
	HelpText.Visible = True
	Dim xhelp As tHelp
	Dim xinfo As tInfo
	For i = 0 To lHelps.Size - 1
		Dim t As String
		t = lHelps.Get(i)
		If t.Contains("Kind=0") Then
			xinfo = lHelps.Get(i)
			DisplayInfo(xinfo)
		End If
		If t.Contains("Kind=1") Then
			xhelp = lHelps.Get(i)
			DisplayHelp(xhelp)
		End If

		Do While Not(xClick)
			Sleep(50)
		Loop
		xClick = False
	Next
	tmr.Enabled = False
	pnlHelp.SetVisibleAnimated(500, False)
	pnlHelp.RemoveView
	Return True
End Sub

Private Sub pnlHelp_Click
	xClick = True
	Sleep(10)
End Sub

Private Sub DisplayInfo(pInfo As tInfo)
	HelpText.TextColor = pInfo.Properties.TextColor
	HelpText.Background = pInfo.Properties.Textcd
	HelpText.TextSize = pInfo.Properties.TextSize
	HelpText.Text = pInfo.Info
	HelpText.Height = su.MeasureMultilineTextHeight(HelpText, HelpText.Text) + 15dip
	HelpText.Top = pInfo.yPos - HelpText.Height/2
End Sub

Private Sub DisplayHelp(pHelp As tHelp)
	Dim xTarget As B4XView = pHelp.Target

'	get absolupe position
	Dim leftTop(2) As Int = GetAbsolutePosition(xTarget)
	Dim AbsPos As tAbsPos
	AbsPos.Top = leftTop(1)
	AbsPos.Left = leftTop(0)
	Log(AbsPos.Top)
	Log(AbsPos.Left)

'	define center of view
	Dim xCenter As Float = AbsPos.Left + xTarget.Width/2
	Dim yCenter As Float = AbsPos.Top + xTarget.Height/2	
	
	frameRect.Initialize(AbsPos.Left - frameWidth, AbsPos.Top - frameWidth, AbsPos.Left + xTarget.Width + frameWidth, AbsPos.Top + xTarget.Height + frameWidth)
	viewRect.Initialize(AbsPos.Left, AbsPos.Top, AbsPos.Left + xTarget.Width, AbsPos.Top + xTarget.Height)

	Dim radius As Int = getCornerRadius(xTarget)
	If radius > 0 Then
		Dim xPath, xPath2 As B4XPath
'		draw frame
		xPath.InitializeRoundedRect(frameRect, DipToCurrent(radius))
		cvs.DrawPath(xPath, pHelp.Properties.frameColor, True, 1dip)
'		draw transparent view rectangle
		xPath2.InitializeRoundedRect(viewRect, DipToCurrent(radius))
		cvs.DrawPath(xPath2, xui.Color_Transparent, True, 1dip)
	Else
'		draw frame
		cvs.DrawRect(frameRect, pHelp.Properties.frameColor, True, 1dip)
'		draw transparent view rectangle
		cvs.DrawRect(viewRect, xui.Color_Transparent, True, 1dip)
	End If
'	clear previous rectangle
	cvs.ClearRect(prevRect)
	cvs.DrawRect(prevRect, pBackgroundColor, True, 1dip)
'	define new previous rectangle
	prevRect.Initialize(AbsPos.Left - frameWidth, AbsPos.Top - frameWidth, AbsPos.Left + xTarget.Width + frameWidth, AbsPos.Top + xTarget.Height + frameWidth)
	cvs.Invalidate

	DisplayIcon (xCenter, yCenter, pHelp.Icon, xTarget, pHelp.Properties.Black)
	
	HelpText.TextColor = pHelp.Properties.TextColor
	HelpText.Background = pHelp.Properties.Textcd
	HelpText.TextSize = pHelp.Properties.TextSize
	HelpText.Text = pHelp.Help
	HelpText.Height = su.MeasureMultilineTextHeight(HelpText, HelpText.Text) + 15dip
	If pnlIcon.Top + pnlIcon.Height + HelpText.Height + 15dip  > 100%y Then
		HelpText.Top = AbsPos.Top - 15dip - HelpText.Height
	Else
		HelpText.Top = pnlIcon.Top + pnlIcon.Height + 7dip
	End If
 End Sub

Private Sub DisplayIcon(px As Float, py As Float, picon As Byte, pTarget As B4XView, xBlack As Boolean)
	Dim leftTop(2) As Int = GetAbsolutePosition(pTarget)
	
	If pSwitchIconColor Then
		HelpText.Visible = False
		Dim xcol As Int
		xcol = GetScreenPixelColor(leftTop(0) + 5dip, leftTop(1) + pTarget.Height/2)
		HelpText.Visible = True
		xBlack = ContrastColor(xcol)
	End If

	ivIcon.Clear
	If picon < 100 Then   	' static icons
		gvGif.mBase.Visible = False
	Else					' gif
		gvGif.mBase.Visible = True
	End If
	Select picon
		Case ICON_NONE
		Case ICON_ARROW_UP
			pnlIcon.Top = py    
			pnlIcon.Left = px - pnlIcon.Width/2   'correction
			ivIcon.Load(File.DirAssets, IIf(xBlack, "Arrow_Up.png", "Arrow_Up_w.png"))
		Case ICON_ARROW_DOWN
			pnlIcon.Top = py      
			pnlIcon.Left = px - pnlIcon.Width/2   'correction
			ivIcon.Load(File.DirAssets, IIf(xBlack, "Arrow_Down.png", "Arrow_Down_w.png"))
		Case ICON_ARROW_RIGHT
			pnlIcon.Top = py - pnlIcon.Height/2   'correction
			pnlIcon.Left = px - pnlIcon.Width - pTarget.Width/4 'correction
			ivIcon.Load(File.DirAssets, IIf(xBlack, "Arrow_Right.png", "Arrow_Right_w.png"))
		Case ICON_ARROW_LEFT
			pnlIcon.Top = py - pnlIcon.Height/2   'correction
			pnlIcon.Left = px + pTarget.Width/4
			ivIcon.Load(File.DirAssets, IIf(xBlack, "Arrow_Left.png", "Arrow_Left_w.png"))

		Case GIF_TAP
			pnlIcon.Top = py - pnlIcon.Height/4   'finger correction
			pnlIcon.Left = px - pnlIcon.Width/3 -  5dip   'finger correction
			gvGif.SetGif(File.DirAssets, IIf(xBlack, "Tap.gif", "Tap_w.gif"))
		Case GIF_SWIPE_UP
			pnlIcon.Top = py - pnlIcon.Height/4   'finger correction
			pnlIcon.Left = px - pnlIcon.Width/3 -  5dip   'finger correction
			gvGif.SetGif(File.DirAssets, IIf(xBlack, "Swipe_Up.gif", "Swipe_Up_w.gif"))
		Case GIF_SWIPE_DOWN
			pnlIcon.Top = py - pnlIcon.Height/4   'finger correction
			pnlIcon.Left = px - pnlIcon.Width/3 -  5dip   'finger correction
			gvGif.SetGif(File.DirAssets, IIf(xBlack, "Swipe_Down.gif", "Swipe_Down_w.gif"))
		Case GIF_SWIPE_RIGHT
			pnlIcon.Top = py - pnlIcon.Height/4   'finger correction
			pnlIcon.Left = px - pnlIcon.Width/3 -  5dip   'finger correction
			gvGif.SetGif(File.DirAssets, IIf(xBlack, "Swipe_right.gif", "Swipe_right_w.gif"))
		Case GIF_SWIPE_LEFT
			pnlIcon.Top = py - pnlIcon.Height/4   'finger correction
			pnlIcon.Left = px - pnlIcon.Width/3 -  5dip   'finger correction
			gvGif.SetGif(File.DirAssets, IIf(xBlack, "Swipe_Left.gif", "Swipe_Left_w.gif"))
		Case GIF_SCROLL_HORIZONTAL
			pnlIcon.Top = py - pnlIcon.Height/4   'finger correction
			pnlIcon.Left = px - pnlIcon.Width/3 -  5dip   'finger correction
			gvGif.SetGif(File.DirAssets, IIf(xBlack, "Scroll_Horizontally.gif", "Scroll_Horizontally_w.gif"))
		Case GIF_SCROLL_VERTICAL
			pnlIcon.Top = py - pnlIcon.Height/4   'finger correction
			pnlIcon.Left = px - pnlIcon.Width/3 -  5dip   'finger correction
			gvGif.SetGif(File.DirAssets, IIf(xBlack, "Scroll_Vertically.gif", "Scroll_Vertically_w.gif"))
		Case Else
	End Select
End Sub

Private Sub tmrDisplay_Tick
	pnlHelp_Click
End Sub

#Region Properties
'background color
Public Sub setBackgroundColor(value As Int)
	pBackgroundColor = value
	cvs.DrawRect(mainRect, pBackgroundColor, True, 1dip)
	cvs.Invalidate
End Sub
Public Sub getBackgroundColor As Int
	Return pBackgroundColor
End Sub

'text color
Public Sub setTextColor(value As Int)
	pTextColor = value
End Sub
Public Sub getTextColor As Int
	Return pTextColor
End Sub

'text size
Public Sub setTextSize(value As Float)
	pTextSize = value
End Sub
Public Sub getTextSize As Float
	Return pTextSize
End Sub

'sets text background 
Public Sub setHelpColor(value As ColorDrawable)
	pcdText = value
End Sub
Public Sub getHelpColor As ColorDrawable
	Return pcdText
End Sub

'switch icon color depended of background color
Public Sub setSwitchIconColor(value As Boolean)
	pSwitchIconColor = value
End Sub
Public Sub getSwitchIconColor As Boolean
	Return pSwitchIconColor
End Sub

'white icons - false, black icons - true
Public Sub setBlackIcons(value As Boolean)
	pBlack = value
End Sub
Public Sub getBlackIcons As Boolean
	Return pBlack
End Sub

'sets icon dimensions
Public Sub SetIconDimensions(width As Int, height As Int)
	pnlIcon.Width = width
	pnlIcon.Height = height
	ivIcon.mbase.Width = width
	ivIcon.mbase.Height = height
	gvGif.mbase.Width = width
	gvGif.mbase.Height = height
End Sub

'sets frame color and width of target object
Public Sub SetFrame(color As Int, width As Int)
	frameColor = color
	frameWidth = width
End Sub
#End Region

#Region tools
Private Sub GetAbsolutePosition (view As B4XView) As Int()
	Dim LeftTop(2) As Int
	Dim JO As JavaObject = view
	JO.RunMethod("getLocationOnScreen", Array As Object(LeftTop))
	LeftTop(1) = LeftTop(1) - GetTitleBarHeight - GetStatusBarHeight

	Return Array As Int(LeftTop(0), LeftTop(1))
End Sub
	
Private Sub GetStatusBarHeight As Int
	Dim id As Int = nativeMe.RunMethod("StatusBarHeight", Null)
	Return id
End Sub

Private Sub GetTitleBarHeight() As Int
	Dim height As Int = nativeMe.RunMethod("TitleBarHeight", Array(GetBA))
	Return height
End Sub

Private Sub GetBA As Object
	Return nativeMe.RunMethod("getBA", Null)
End Sub

#If JAVA
import android.view.Window;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ActivityObject;

public int StatusBarHeight(){
        int result = 0;
        int resId = BA.applicationContext.getResources().getIdentifier("status_bar_height", "dimen", "android");
        if (resId > 0) {
            result = BA.applicationContext.getResources().getDimensionPixelSize(resId);
        }
        return result;
    }

public int TitleBarHeight(BA ba) {
        int viewTop = ba.activity.getWindow().findViewById(Window.ID_ANDROID_CONTENT).getTop();
        return (viewTop - StatusBarHeight());
    }
#End If

Private Sub getCornerRadius(Target As B4XView) As Int	
	If GetType(Target.As(View).Background) = "anywheresoftware.b4a.objects.drawable.ColorDrawable$GradientDrawableWithCorners" Then
		Private cd2 As ColorDrawable
		cd2 = Target.As(View).Background
		Dim jocd As JavaObject = cd2
		Return jocd.GetField("cornerRadius") / GetDeviceLayoutValues.Scale
	End If
	If GetType(Target.As(View).Background) = "android.graphics.drawable.StateListDrawable" Then
		Dim sld As StateListDrawable
		sld = Target.As(View).Background

		Dim index As Int = GetEnabledDrawableIndex(sld)
'		If index = 0 Then Return 0

		Dim josdl As JavaObject = sld
		Dim drawable As Object = josdl.RunMethod("getStateDrawable", Array(index))
		Dim cd As ColorDrawable = drawable
		Dim jocd As JavaObject = cd
		Return jocd.GetField("cornerRadius") / GetDeviceLayoutValues.Scale
	End If
	Return 0
End Sub

Private Sub GetEnabledDrawableIndex(sld As StateListDrawable) As Int
	Dim jo As JavaObject = sld
	Dim stateCount As Int = jo.RunMethod("getStateCount", Null)
	Dim joArray As JavaObject
	joArray.InitializeStatic("java.lang.reflect.Array")
	For i = 0 To stateCount - 1
		Dim stateSets As Object = jo.RunMethod("getStateSet", Array(i))
		Dim length As Int = joArray.RunMethod("getLength", Array(stateSets))
		For j = 0 To length - 1
			Dim stateValue As Int = joArray.RunMethod("get", Array(stateSets, j))
			If stateValue = 16842910 Then  ' positive state_enabled
				Return i
			End If
		Next
		' Empty state set = default drawable (also represents enabled)
		If length = 0 Then
			Return i
		End If
	Next
	Return 0
End Sub

Private Sub GetScreenPixelColor(x As Int, y As Int) As Int
	Dim RootView As B4XView = root1
	Dim bmp As B4XBitmap = RootView.Snapshot
	Dim bc As BitmapCreator
	bc.Initialize(bmp.Width, bmp.Height)
	bc.CopyPixelsFromBitmap(bmp)
	If x >= 0 And x < bc.mWidth And y >= 0 And y < bc.mHeight Then
		Return bc.GetColor(x, y)
	Else
		Return xui.Color_Transparent
	End If
End Sub

Private Sub ContrastColor(C As Int) As Boolean
	Dim a As Double
	Dim argb() As Int
	argb = GetARGB(C)
 	a = 1 - ( 0.299 * argb(1) + 0.587 * argb(2) + 0.114 * argb(3))/255
	If a < 0.5 Then
		Return True
	Else
		Return False
	End If
End Sub

Private Sub GetARGB(Color As Int) As Int()
	Dim res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub
#End Region

