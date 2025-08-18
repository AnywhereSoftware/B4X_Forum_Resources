B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private toastorig As BCToast
	Private toastVW As BCToastWV
	Private toastVW2 As BCToastWV
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	toastorig.Initialize(Root)
	toastVW.Initialize(Root)
	toastVW2.Initialize(Root)
	'TE.Initialize(Root)
	toastorig.VerticalCenterPercentage = 5
	toastVW.VerticalCenterPercentage = 25
	toastVW2.VerticalCenterPercentage = 50
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub Button1_Click
	
	Dim btn As Button
	#IF B4i
		btn.Initialize("btn", btn.STYLE_SYSTEM)
	#ELSE
		btn.Initialize("btn")
	#End If
	btn.Text = "View Now!"
	btn.Tag = "btn"
	Dim B As B4XView = btn
	B.SetColorAndBorder(xui.Color_Cyan, 2dip, xui.Color_Black, 20dip)
	b.SetLayoutAnimated(0, 0, 0, 200dip, 50dip)
	'toastorig.BB1.Views.Put("btn",  btn)
	toastorig.BB1.mBase.Color = xui.Color_ARGB(0, 0,0,0)
	toastorig.DefaultTextColor = xui.Color_Red
	toastorig.pnl.Color = xui.Color_Blue
	toastorig.BB1.ForegroundImageView.Color = xui.Color_ARGB(50, 0,0,0)
	'toastorig.VerticalCenterPercentage = 40
	toastorig.MaxHeight = 100
	toastorig.DurationMs = 3000
	toastorig.Show($"[TextSize=20]You have [b]100 unread[/b] messages![/TextSize]${CRLF} This is a regular toast"$)
			'[View=btn Vertical=20/]"$)
'	toastVW.VerticalCenterPercentage = 20
	'toastVW.AddView(B)
	toastVW.MaxHeight = 500
	toastVW.DurationMs = 4000
	toastVW.Show($"[alignment=center]You have [b]100 unread[/b] messages!
Here is some more text. lhfgiu   puihsrg  puihs rg poih erg
poiwer g 9p8 werg p8h wreg p98[/alignment]"$, B)
	
	Dim PP As B4XView = xui.CreatePanel("")
	'PP.Tag = "to remove"
	Dim btn2, btn3 As Button
	#IF B4i
		btn2.Initialize("btn", btn.STYLE_SYSTEM)
		btn3.Initialize("btn", btn.STYLE_SYSTEM)
	#ELSE
		btn2.Initialize("btn")
		btn3.Initialize("btn")
	#End If
	btn2.Text = "View Now!"
	btn2.Tag = "btn2"
	Dim B2 As B4XView = btn2
	B2.SetColorAndBorder(xui.Color_Cyan, 2dip, xui.Color_Black, 20dip)
	B2.SetLayoutAnimated(0, 0, 0, 200dip, 50dip)
	btn3.Text = "Cancel"
	btn3.Tag = "btn3"
	Dim B3 As B4XView = btn3
	B3.SetColorAndBorder(xui.Color_LightGray, 2dip, xui.Color_Black, 20dip)
	B3.SetLayoutAnimated(0, 105dip, 0, 200dip, 50dip)
	PP.AddView(B2, 0, 0, 100dip, 50dip)
	PP.AddView(B3, 105dip, 0, 100dip, 50dip)
	PP.Width = 205dip
	PP.Height = 50dip
	toastVW2.pnl.Color = xui.Color_Yellow
	toastVW2.DurationMs = 5000
'	toastVW2.Show($"[alignment=center]You!
'me 
'the lamppost[/alignment]"$, PP)
	toastVW2.Show($"You!
me 
the lamppost"$, PP)
	Log("Click")
End Sub


Sub btn_Click
	Dim V As B4XView = Sender
	Log("Click - " & V.Tag)
	If V.Tag = "btn" Then 
		toastVW.Hide
	Else
		toastVW2.Hide
	End If
End Sub