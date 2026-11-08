B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'################################################################
'## Custom Toast
'## #############################################################
'## Name:			GBEToast (Bas or b4xlib)
'## Vers.:			3.0 BETA
'## Type:			Class
'## LNG:			B4A, B4J, B4i to be done
'## State:			WIP(x) Release(x)
'## Class/Modul:	-
'## Includes:		-
'## Lib B4A:		XUI,XUIViews, B4XGifView,Audio
'## Lib B4J:		jFX,XUIViews, B4XGifView
'## Lib B4i:		
'## Layout:			GBEToast.bal or .bjl
'## Files:			icons8-attention-94,icons8-confirm-94, icons8-error-94, icons8-info-94
'##					icons8-question-94,icons8-success-94
'## DB:				-
'## Other:			-
'## external (C):	Royalty free icons from, http://ww.icons8.com
'################################################################
'## (C) Günter Becker
'## licenced Member Anywhere Forum, https://www.B4X.com
'## Royalty Free for licensed Anywhere Members.
'################################################################

#region Global, Initialize
'## Function:	Objects & Variable
'## Tested:		2025/07
Sub Class_Globals
	#if B4J
		Private fx As JFX
		Public Panel As Pane
	#else if B4A
		Private xui As XUI
		Public Panel As Panel
		Public Beeper As Beeper
	#else if B4i
	
	#End If
		
	Private xui As XUI
	Private mCallback As Object
	Private mWidth,mHeight,mTop,mleft,mDuration,mRadius As Int
	
	'# Layout EDUToast
	Private EDUToastGifView As B4XGifView
	Private EDUToastImg As B4XImageView
	Private EDUToastLabel As Label
	Private EDUToastProgressbar As Label
End Sub
'## Function:	Initialize Object and Variable
'## Tested:		2025/07
Public Sub Initialize (Callback As Object, _
	Width As Int,height As Int ,Top As Int)
	mCallback = Callback
	
	mWidth = IntToDIP(Width)
	mHeight=IntToDIP(height)
	
	'# Create panel
	Panel.Initialize("")
	#if B4J
		mTop= IntToDIP(Main.MainForm.RootPane.Height) * Top/100
		mleft = IntToDIP(Main.MainForm.RootPane.Width/2) -IntToDIP((mWidth/2))
		Panel.setsize(mWidth,mHeight)
	#else if B4A
		mTop= IntToDIP(Callback.As(Panel).Height) * Top/100
		mleft = IntToDIP(Callback.As(Panel).Width/2) -IntToDIP((mWidth/2))
		Panel.Width=mWidth : Panel.height=mHeight
		Beeper.initialize(300,300)
	#else if B4i
	
	#end if
	Panel.Left = mleft
	Panel.LoadLayout("EDUToast")
	Panel.Visible=False
	#if B4J
		mCallback.As(Pane).AddNode(Panel,mleft,mTop,mWidth,mHeight)
	#else if B4A
		mCallback.As(Panel).Addview(Panel,mleft,mTop,mWidth,mHeight)
	#else if B4i
	
	#End If
	' Loading Indicator
	EDUToastGifView.Base_Resize(mHeight-10dip,mHeight-10dip)
	EDUToastGifView.SetGif(File.DirAssets,"spinner2.gif")
	EDUToastGifView.mBase.Color=xui.Color_Transparent
End Sub
#end region

'################################################################

#region custom properties
'## Function:	Toast GUI
'## Tested:		2025/07
public Sub setGUI(Color As Int, Bordercolor As Int, Borderwidth As Int, Radius As Int, _
		Textcolor As Int, Textsize As Int,Text As String, _
		EDUToastProgressbarBarcolor As Int,EDUToastProgressbarTextcolor As Int, EDUToastProgressbarLblTextsize As Int, _
		EDUToastImgName As String)
	Try
		'# panel
		Dim pdb4x As B4XView = Panel
		pdb4x.SetColorAndBorder(Color,Borderwidth,Bordercolor,Radius)
		Panel = pdb4x
		mRadius=Radius
		'# Icon
		EDUToastImg.CornersRadius = Radius
		EDUToastImg.mBackgroundColor=xui.color_transparent
		EDUToastImg.ResizeMode="FIT"
		EDUToastImg.RoundedImage = True
		EDUToastImg.Load(File.DirAssets,EDUToastImgName)
		'# Label
		Dim l4x As B4XView = EDUToastLabel
		l4x.textcolor = Textcolor
		l4x.Textsize = Textsize
		l4x.Font = xui.CreateDefaultBoldFont(Textsize)
		l4x.Text = Text
		l4x.SetTextAlignment("CENTER","CENTER")
		EDUToastLabel = l4x

		'# progressbar 
		Dim l4x2 As B4XView = EDUToastProgressbar
		l4x2.Color = EDUToastProgressbarBarcolor
		l4x2.textColor =  EDUToastProgressbarTextcolor
		l4x2.TextSize=EDUToastProgressbarLblTextsize
		l4x2.SetTextAlignment("CENTER","CENTER")
		l4x2.font = xui.CreateDefaultBoldFont(EDUToastProgressbarLblTextsize)
		EDUToastProgressbar = l4x2
	Catch
		Log(LastException)
	End Try
End Sub
'## Function:	show/hide Toast
'## Parameter:	Cat info/attention/error/question/success/li/none
'##				Duration in Seconds or 9999 allways on
'##				Percent 0-100 or 9999 allways off
'## Notice:		hide = call again after 1st call and leafe all Parameters empty or 0
'## Tested:		2025/07
public Sub showToast(Cat As String, Msg As String, Duration As Int,Percent As Int,Beep As Boolean)
	Try
		Panel.Visible=Not(Panel.Visible)
		EDUToastImg.mbase.Visible=True
		EDUToastGifView.mBase.Visible=False
		If Panel.Visible Then
			Select Cat.ToLowerCase
				Case "info"
					setGUI(xui.color_blue,xui.Color_Black,2dip,mHeight/2, _
						xui.color_white,18,Msg, _
						xui.Color_green,xui.Color_black,18, _
						"icons8-info-94.png")
				Case "attention"
					setGUI(xui.Color_yellow,xui.Color_Black,2dip,mHeight/2, _
						xui.color_black,18,Msg, _
						xui.Color_green,xui.Color_black,18, _
						"icons8-attention-94.png")
				Case "error"
					setGUI(xui.Color_red,xui.Color_white,2dip,mHeight/2, _
						xui.color_white,18,Msg, _
						xui.Color_green,xui.Color_black,18, _
						"icons8-error-94.png")
				Case "question"
					setGUI(xui.Color_white,xui.Color_Black,2dip,mHeight/2, _
						xui.color_black,18,Msg, _
					xui.Color_green,xui.Color_black,18, _
						"icons8-question-94.png")
				Case "success"
					setGUI(xui.Color_green,xui.Color_Black,2dip,mHeight/2, _
						xui.color_black,18,Msg, _
						xui.Color_green,xui.Color_black,18, _
						"icons8-success-94.png")
				Case "li"
					setGUI(xui.Color_blue,xui.Color_Black,2dip,mHeight/2, _
						xui.color_white,18,Msg, _
						xui.Color_green,xui.Color_black,18, _
						"icons8-success-94.png")	
					EDUToastImg.mbase.Visible=False
					EDUToastGifView.mBase.Visible=True
				Case Else
					setGUI(xui.Color_white,xui.Color_Black,2dip,mHeight/2, _
						xui.color_black,18,Msg, _
						xui.Color_green,xui.Color_black,18, _
						"icons8-info-94.png")	
					EDUToastImg.mBase.Visible=True
					EDUToastGifView.mBase.Visible=False
			End Select
			'# play beep
			If Beep Then playBeep
			EDUToastProgressbar.Visible=False
			'# manage prgressbar
			If Percent >= 0 And Percent <=100 Then
				setProgress(Percent)
				EDUToastProgressbar.Visible=True
				EDUToastLabel.Visible=False
			Else
				EDUToastProgressbar.Visible=False
				EDUToastLabel.Visible=True
			End If
			'# manage duration
			If Duration <> 9999 Then
				Sleep(Duration*1000)
				Panel.Visible=False
				EDUToastProgressbar.Visible=False
			Else
				Duration=999
			End If
		Else
			Panel.Visible=False
			EDUToastProgressbar.Visible=False
		End If
	Catch
		Log(LastException)
	End Try
End Sub
'## Function:	set Prograssbar progress value in percent
'## Paramter:	Value 0-100
'## Tested:		2025/07
public Sub setProgress(Value As Int)
	If EDUToastProgressbar.IsInitialized And Value >=0 And Value <= 100 Then
		EDUToastProgressbar.Visible=True
		EDUToastLabel.Visible=False
		EDUToastProgressbar.Text= Value  & "%"
		#if B4J
			EDUToastProgressbar.prefWidth = (EDUToastLabel.Width * Value/100) -  mRadius
		#else if B4A
			EDUToastProgressBar.Width = (EDUToastLabel.Width * Value/100) -  mRadius
		#else if B4i
		
		#end if
	End If
End Sub
'## Function:	set Message text
'## Paramter:	Text
'## Tested:		2025/07
public Sub setText(Text As String)
	EDUToastLabel.Text=Text
End Sub
#end region

'################################################################

#region custom Event
'## Function:	Click Event to hide toast by click
'## Tested:		2025/07
#if B4J
	Public Sub Toast_MouseClicked (EventData As MouseEvent)
		Panel.Visible=False
		EDUToastProgressbar.Visible=False
		EDUToastLabel.visible=True
	End Sub
#else if B4A
	Public Sub Toast_Click
		Panel.Visible=False
		EDUToastProgressBar.Visible=False
	End Sub
#end if
#end region

'################################################################

#region helpers
'## Function:	Convert pixel to dip
'## Tested:		2025/07
private Sub IntToDIP(Integer As Int) As Int
	Dim DIP As Int
	DIP = Integer * 1dip
	Return DIP
End Sub
'## Function:	Play Beep
'## Tested:		2025/07
#if B4J
	Sub playBeep
		Dim jo As JavaObject = Me
		jo.RunMethod("beep", Null)
	End Sub 
	#if Java
	public static void beep() {
	    java.awt.Toolkit.getDefaultToolkit().beep();
	}
	#End If
#else if B4A
	Sub PlayBeep
		Beeper.Beep
	End Sub
#else if B4i
	Sub PlayBeep
	    Dim NativeMe As NativeObject = Me
	    NativeMe.RunMethod("beep", Null)
	End Sub

	#If ObjC
		#import <AVFoundation/AVAudioPlayer.h>
		- (void) beep {
		  AudioServicesPlaySystemSound(1302);
		}
	#End If
#End If
#end region

'################################################################
