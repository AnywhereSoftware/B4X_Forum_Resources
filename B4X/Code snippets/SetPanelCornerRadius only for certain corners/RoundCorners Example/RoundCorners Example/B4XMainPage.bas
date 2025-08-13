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
	Private xpnl_MyPanel As B4XView

End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	xpnl_MyPanel = xui.CreatePanel("")
	xpnl_MyPanel.Color = xui.Color_Red
	Root.AddView(xpnl_MyPanel,100dip,100dip,100dip,100dip)
	
	Sleep(4000)
	Log("Now")
	SetPanelCornerRadius(xpnl_MyPanel,20dip,True,True,False,False)
	
End Sub

Private Sub SetPanelCornerRadius(View As B4XView, CornerRadius As Float,TopLeft As Boolean,TopRight As Boolean,BottomLeft As Boolean,BottomRight As Boolean)
	#If B4I
	'https://www.b4x.com/android/forum/threads/individually-change-corner-radius-of-a-view.127751/post-800352
	View.SetColorAndBorder(View.Color,0,0,CornerRadius)
	Dim CornerSum As Int = IIf(TopLeft,1,0) + IIf(TopRight,2,0) + IIf(BottomLeft,4,0) + IIf(BottomRight,8,0)
	View.As(NativeObject).GetField ("layer").SetField ("maskedCorners", CornerSum)
	#Else If B4A
	'https://www.b4x.com/android/forum/threads/gradientdrawable-with-different-corner-radius.51475/post-322392
	Dim cdw As ColorDrawable
	cdw.Initialize(View.Color, 0)
	View.As(View).Background = cdw
	Dim jo As JavaObject = View.As(View).Background
	If View.As(View).Background Is ColorDrawable Or View.As(View).Background Is GradientDrawable Then
		jo.RunMethod("setCornerRadii", Array As Object(Array As Float(IIf(TopLeft,CornerRadius,0), IIf(TopLeft,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomLeft,CornerRadius,0), IIf(BottomLeft,CornerRadius,0))))
	End If
	#Else If B4J
	'https://www.b4x.com/android/forum/threads/b4x-setpanelcornerradius-only-for-certain-corners.164567/post-1008965
	Dim Corners As String = ""
	Corners = Corners & IIf(TopLeft, CornerRadius, 0) & " "
	Corners = Corners & IIf(TopRight, CornerRadius, 0) & " "
	Corners = Corners & IIf(BottomLeft, CornerRadius, 0) & " "
	Corners = Corners & IIf(BottomRight, CornerRadius, 0)
	CSSUtils.SetStyleProperty(View, "-fx-background-radius", Corners)
	#End If
End Sub
