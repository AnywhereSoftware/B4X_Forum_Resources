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
	Private ASViewPager1 As ASViewPager
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	ASViewPager1.LazyLoading = True
	ASViewPager1.LazyLoadingExtraSize = 4
	
	For i = 0 To 20
		Dim tmp_xpnl As B4XView = xui.CreatePanel("tmp_xpnl")
		tmp_xpnl.Color = xui.Color_ARGB(255,Rnd(1,255),Rnd(1,255),Rnd(1,255))
		tmp_xpnl.SetLayoutAnimated(0,0,0,ASViewPager1.Base.Width,ASViewPager1.Base.Height)
		
		ASViewPager1.AddPage(tmp_xpnl,"Test" & i)
	Next
	#IF B4A
	Sleep(250)
	#Else
	Sleep(0)
	#End If
	ASViewPager1.CurrentIndex = 10
	ASViewPager1.Commit
	B4XPages.SetTitle(Me,"Page " & (ASViewPager1.CurrentIndex +1) & "/" & ASViewPager1.Size)
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	ASViewPager1.Base_Resize(Width,Height)
End Sub

Private Sub ASViewPager1_PageChanged2(NewIndex As Int, OldIndex As Int)
	If NewIndex <= OldIndex Then
		If NewIndex <= 2 Then
			Dim tmp_xpnl As B4XView = xui.CreatePanel("tmp_xpnl")
			tmp_xpnl.Color = xui.Color_ARGB(255,Rnd(1,255),Rnd(1,255),Rnd(1,255))
			tmp_xpnl.SetLayoutAnimated(0,0,0,ASViewPager1.Base.Width,ASViewPager1.Base.Height)
		
			ASViewPager1.AddPageAt(0,tmp_xpnl,"")
		End If
	Else
		If NewIndex = ASViewPager1.Size -2 Then
			Dim tmp_xpnl As B4XView = xui.CreatePanel("tmp_xpnl")
			tmp_xpnl.Color = xui.Color_ARGB(255,Rnd(1,255),Rnd(1,255),Rnd(1,255))
			tmp_xpnl.SetLayoutAnimated(0,0,0,ASViewPager1.Base.Width,ASViewPager1.Base.Height)
		
			ASViewPager1.AddPage(tmp_xpnl,"")
		End If
	End If
	Sleep(0)
	B4XPages.SetTitle(Me,"Page " & (NewIndex +1) & "/" & ASViewPager1.Size)
End Sub

Private Sub ASViewPager1_LazyLoadingAddContent(Parent As B4XView, Value As Object)
	
	Dim xlbl As B4XView = CreateLabel
	xlbl.Text = "Lazyloading Label"
	xlbl.TextColor = xui.Color_White
	xlbl.Font = xui.CreateDefaultBoldFont(20)
	xlbl.SetTextAlignment("CENTER","CENTER")
	Parent.AddView(xlbl,0,Parent.Height/2 - 50dip/2,Parent.Width,50dip)
	
End Sub

Private Sub CreateLabel As B4XView
	Dim lbl As Label
	lbl.Initialize("")
	Return lbl
End Sub