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
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	#If B4I
	Sleep(250)
	#End If
	
	For i = 0 To 2
		Dim tmp_xpnl As B4XView = xui.CreatePanel("")
		tmp_xpnl.Color = xui.Color_ARGB(255,Rnd(1,255),Rnd(1,255),Rnd(1,255))
		tmp_xpnl.SetLayoutAnimated(0,0,0,ASViewPager1.Base.Width,ASViewPager1.Base.Height)
		ASViewPager1.AddPage(tmp_xpnl,"")
	Next
	B4XPages.SetTitle(Me,"ASViewPager Example | Page " & 1 & "/" & ASViewPager1.Size)
End Sub

Sub ASViewPager1_PageChanged (index As Int)
	Log("PageChanged: " & index)
	B4XPages.SetTitle(Me,"ASViewPager Example | Page " & (index +1) & "/" & ASViewPager1.Size)
End Sub

Private Sub ASViewPager1_SwipeOnEndOfPage
	Log("SwipeOnEndOfPage")
End Sub

Private Sub xlbl_next_Click
	ASViewPager1.NextPage
End Sub