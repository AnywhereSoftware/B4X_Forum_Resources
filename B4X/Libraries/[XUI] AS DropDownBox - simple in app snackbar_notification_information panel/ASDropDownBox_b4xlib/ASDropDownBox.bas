B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
#If Documentation
Updates
V1.01
	-Add isVisible
V1.02
	-Add AutoHideMs
#End If

#Event: Click

Sub Class_Globals
	Private xui As XUI
	Private mBase As B4XView
	Private xlbl_text As B4XView
	Public Tag As Object
	Private mEventName As String
	Private mCallBack As Object
	Private g_y As Float
	
	Private g_padding As Float = 0
	Private g_show_animation As String
	Private g_show_alignment As String
	Private g_show_animation_duration As Int = 500
	Public isVisible As Boolean = False
	Public AutoHideMs As Int
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallBack As Object,EventName As String)
	mEventName = EventName
	mCallBack = CallBack
	
	mBase = xui.CreatePanel("mBase")
	xlbl_text = CreateLabel("")
	mBase.Tag = Me
	
	
	g_show_animation = ShowAnimation_NORMAL
	g_show_alignment = ShowAlignment_TOP
	
	mBase.AddView(xlbl_text,0,0,0,0)
	
	mBase.Color = xui.Color_ARGB(255,60, 64, 67)
	
	xlbl_text.TextColor = xui.Color_White
	xlbl_text.Font = xui.CreateDefaultFont(15)
	xlbl_text.SetTextAlignment("CENTER","CENTER")
	
End Sub

Public Sub Show(parent As B4XView,text As String)
	isVisible = True
	#If B4A
	Dim su As StringUtils
	xlbl_text.Width = parent.Width
	Dim tmp_height As Float = su.MeasureMultilineTextHeight(xlbl_text,text) + g_padding
	#Else
	Dim tmp_height As Float = MeasureTextHeight(text,xlbl_text.Font) +10dip + g_padding	
	#End If


	parent.AddView(mBase,0,0 - tmp_height,parent.Width,tmp_height)
	xlbl_text.SetLayoutAnimated(0,0,0,parent.Width,mBase.Height)
	xlbl_text.Text = text
	
	If g_show_alignment = ShowAlignment_TOP Then
		mBase.SetLayoutAnimated(0,0,0 - tmp_height,parent.Width,tmp_height)
		If g_show_animation = ShowAnimation_NORMAL Then
			mBase.SetLayoutAnimated(g_show_animation_duration,0,0,parent.Width,tmp_height)
		End If
		
	Else If g_show_alignment = ShowAlignment_BOTTOM Then
		mBase.SetLayoutAnimated(0,0,parent.Height + tmp_height,parent.Width,tmp_height)
		If g_show_animation = ShowAnimation_NORMAL Then
			mBase.SetLayoutAnimated(g_show_animation_duration,0,parent.Height - tmp_height,parent.Width,tmp_height)
		End If
		
	End If
	
	If AutoHideMs > 0 Then
		Sleep(AutoHideMs)
		Hide
	End If
	
End Sub

#If B4J
Private Sub mBase_MouseClicked (EventData As MouseEvent)
	Click
End Sub
#Else
Private Sub mBase_Click
	Click
End Sub
#End If

'#If B4A or B4I

Private Sub mBase_Touch (Action As Int, X As Float, Y As Float)
	If Action = mBase.TOUCH_ACTION_DOWN Then
		g_y = y
	Else If Action = mBase.TOUCH_ACTION_UP Then
		If g_show_alignment = ShowAlignment_TOP Then
		If y < g_y Then
			Hide
		End If
		Else
			If y > g_y Then
				Hide
			End If
		End If
	End If
End Sub

'#End if

Public Sub Hide
	If g_show_alignment = ShowAlignment_TOP Then
		mBase.SetLayoutAnimated(g_show_animation_duration,0,0 - mBase.Height,mBase.Width,mBase.Height)
	Else If g_show_alignment = ShowAlignment_BOTTOM Then
		mBase.SetLayoutAnimated(g_show_animation_duration,0,mBase.top + mBase.Height,mBase.Width,mBase.Height)
	End If
	Sleep(g_show_animation_duration)
	
	mBase.RemoveViewFromParent
	isVisible = False
End Sub

Public Sub setPadding(view_padding As Float)
	g_padding = view_padding
End Sub

Public Sub setShowAnimationDuration(duration As Int)
	g_show_animation_duration = duration
End Sub

Public Sub setShowAnimation(animation As String)
	If animation = ShowAnimation_NORMAL Then
		g_show_animation = ShowAnimation_NORMAL
	Else
		g_show_animation = ShowAnimation_NORMAL
	End If
End Sub

Public Sub setShowAlignment(alignment As String)
	If alignment = ShowAlignment_TOP Then
		g_show_alignment = ShowAlignment_TOP
	Else If alignment = ShowAlignment_BOTTOM Then
		g_show_alignment = ShowAlignment_BOTTOM
'	Else If alignment = ShowAlignment_LEFT Then
'		g_show_alignment = ShowAlignment_LEFT
'	Else If alignment = ShowAlignment_RIGHT Then
'		g_show_alignment = ShowAlignment_RIGHT
	Else
		g_show_alignment = ShowAlignment_TOP
	End If
End Sub

Public Sub getBase As B4XView
	Return mBase
End Sub

Public Sub getLabel As B4XView
	Return xlbl_text
End Sub

#Region Enums

Public Sub ShowAnimation_NORMAL As String
	Return "NORMAL"
End Sub



Public Sub ShowAlignment_TOP As String
	Return "TOP"
End Sub

Public Sub ShowAlignment_BOTTOM As String
	Return "BOTTOM"
End Sub

'Public Sub ShowAlignment_LEFT As String
'	Return "LEFT"
'End Sub
'
'Public Sub ShowAlignment_RIGHT As String
'	Return "RIGHT"
'End Sub

#End Region


Private Sub CreateLabel(EventName As String) As B4XView
	Dim tmp_lbl As Label
	tmp_lbl.Initialize(EventName)
	#If B4J
	tmp_lbl.WrapText = True
	#Else If B4I
	tmp_lbl.Multiline = True
	#End If
	Return tmp_lbl
End Sub

'https://www.b4x.com/android/forum/threads/b4x-xui-add-measuretextwidth-and-measuretextheight-to-b4xcanvas.91865/#content
Private Sub MeasureTextHeight(Text As String, Font1 As B4XFont) As Int'Ignore
#If B4A     
	Private bmp As Bitmap
	bmp.InitializeMutable(1, 1)'ignore
	Private cvs As Canvas
	cvs.Initialize2(bmp)
	Return cvs.MeasureStringHeight(Text, Font1.ToNativeFont, Font1.Size)
	
#Else If B4i
    Return Text.MeasureHeight(Font1.ToNativeFont)
#Else If B4J
	Dim jo As JavaObject
	jo.InitializeNewInstance("javafx.scene.text.Text", Array(Text))
	jo.RunMethod("setFont",Array(Font1.ToNativeFont))
	jo.RunMethod("setLineSpacing",Array(0.0))
	jo.RunMethod("setWrappingWidth",Array(0.0))
	Dim Bounds As JavaObject = jo.RunMethod("getLayoutBounds",Null)
	Return Bounds.RunMethod("getHeight",Null)
#End If
End Sub

#Region Events
Private Sub Click
	If xui.SubExists(mCallBack, mEventName & "_Click",0) Then
		CallSub(mCallBack, mEventName & "_Click")
	End If
End Sub
#End Region