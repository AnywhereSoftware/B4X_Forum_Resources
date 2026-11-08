B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private ASViewPager1 As ASViewPager
	
	Private tmr_AutoPlay As Timer
	
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	B4XPage_Resize(Width,Height)
	#End If

	For i = 0 To 5
		Dim tmp_xpnl As B4XView = xui.CreatePanel("")
		tmp_xpnl.Color = xui.Color_ARGB(255,Rnd(1,255),Rnd(1,255),Rnd(1,255))
		tmp_xpnl.SetLayoutAnimated(0,0,0,ASViewPager1.Base.Width,ASViewPager1.Base.Height)
		
		ASViewPager1.AddPage(tmp_xpnl,"Test" & i)
	Next
	B4XPages.SetTitle(Me,"ASViewPager Example | Page " & 1 & "/" & ASViewPager1.Size)

	tmr_AutoPlay.Initialize("tmr_AutoPlay",2000)'2 seconds
	tmr_AutoPlay.Enabled = True
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	ASViewPager1.Base_Resize(Width,Height)
	For i = 0 To ASViewPager1.Size -1
	
		ASViewPager1.CustomListView.GetPanel(i).SetLayoutAnimated(0,0,0,Width,Height)
	
	Next
End Sub

Sub ASViewPager1_PageChanged (index As Int)
	'Log("PageChanged: " & index)
	B4XPages.SetTitle(Me,"ASViewPager Example | Page " & (index +1) & "/" & ASViewPager1.Size)
End Sub

Private Sub tmr_AutoPlay_Tick
	If ASViewPager1.CurrentIndex = ASViewPager1.Size -1 Then
		ASViewPager1.CurrentIndex2 = 0
	Else
		ASViewPager1.NextPage
	End If
End Sub
