B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private FirstTime As Boolean = True
	Private LastOrientationPortrait As Boolean
	
	Private B4XFloatTextField1 As B4XFloatTextField
	
	Private ToSave_Text As String
End Sub

#Region PageEvents
'-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
'It is recommended that you not modify the code
'below under most circumstances.
'-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
Public Sub Initialize
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
#if not(b4j)	
	LogColor($"B4XPage_Created"$, Colors.Green)
#end if
	FirstTime=True
	Root = Root1
#if b4a
	LastOrientationPortrait=(Main.ActivityHeight > Main.ActivityWidth)
	B4XPage_Resize(Main.ActivityWidth, Main.ActivityHeight)
#end if
End Sub


Private Sub B4XPage_Resize(Width As Int, Height As Int)
#if not(b4j)
	LogColor($"B4XPage_Resize(Width=${Width}, Height=${Height})"$, Colors.Green)
#end if
	Dim AlreadyRestored As Boolean
	If LastOrientationPortrait=(Width>Height) Or Root.Width<>Width Or Root.Height<>Height Or FirstTime Then
		If Not(FirstTime) Then UI_Save_State
		UI_Create(Width, Height)
		If Not(FirstTime) Then
			UI_Restore_State
			AlreadyRestored=True
		End If
	End If
	If Not(FirstTime) And Not(AlreadyRestored) Then
		'save state
		UI_Save_State
		'restore state
		UI_Restore_State
	End If
	LastOrientationPortrait=(Height>Width)
	FirstTime = False
End Sub

Sub B4XPage_Disappear
#if not(b4j)
	LogColor($"B4XPage_Disappear"$, Colors.Green)
#end if
	'save state
	UI_Save_State
End Sub

#if b4a
Sub B4XPage_Appear
	LogColor($"B4XPage_Appear"$, Colors.Yellow)
	If LastOrientationPortrait=(Main.ActivityWidth > Main.ActivityHeight) Then B4XPage_Resize(Main.ActivityWidth, Main.ActivityHeight)
End Sub
#end if

'-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
'Feel free to edit the code below.
'-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
#End Region


Sub UI_Create(Width As Int, Height As Int)
#if not(b4j)
	LogColor($"UI_Create Width=${Width}, Height=${Height}"$, Colors.Magenta)
#end if
	Root.Width=Width
	Root.Height=Height
	Root.RemoveAllViews
	Root.LoadLayout("Page2")
End Sub

Sub UI_Save_State
#if not(b4j)	
	LogColor($"Saving State"$, Colors.Magenta)
#end if
	ToSave_Text=B4XFloatTextField1.Text
End Sub

Sub UI_Restore_State
#if not(b4j)
	LogColor($"Restoring State"$, Colors.Magenta)
#end if
	B4XFloatTextField1.Text=ToSave_Text
End Sub


Sub Button1_Click
'	xui.MsgboxAsync("Hello world!", "B4X")
	B4XPages.ClosePage(Me)
End Sub
