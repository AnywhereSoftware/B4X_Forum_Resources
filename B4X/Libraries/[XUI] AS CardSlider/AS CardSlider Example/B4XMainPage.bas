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
	Private AS_CardSlider1 As AS_CardSlider
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS CardSlider")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	B4XPage_Resize(Width,Height)
	#End If

	'AS_CardSlider1.ItemWidth = 100dip
	AS_CardSlider1.LazyLoading = False

	For i = 0 To 5 -1
	
		Dim xpnl As B4XView = xui.CreatePanel("")
		xpnl.SetLayoutAnimated(0,0,0,AS_CardSlider1.ItemWidth,AS_CardSlider1.mBase.Height)
		'xpnl.Color = xui.Color_ARGB(255,Rnd(0,256),Rnd(0,256),Rnd(0,256))
		xpnl.LoadLayout("frm_Item1")
		
		Dim xlbl_Text As B4XView = xpnl.GetView(0)
		xlbl_Text.Text = "Item #" & (i+1)
		
		AS_CardSlider1.AddPage(xpnl,i)
	
	Next


End Sub

Private Sub AS_CardSlider1_LazyLoadingAddContent(Parent As B4XView, Value As Object)
	
	Parent.LoadLayout("frm_Item1")
		
	Dim xlbl_Text As B4XView = Parent.GetView(0)
	xlbl_Text.Text = "Item #" & (Value+1)
	
End Sub

Private Sub AS_CardSlider1_PageChanged(OldIndex As Int, NewIndex As Int)
	Log("Page " & (NewIndex+1) & "/" & AS_CardSlider1.size)
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
End Sub

#If B4J
Private Sub Label1_MouseClicked (EventData As MouseEvent)
	AS_CardSlider1.NextPage
End Sub

Private Sub Label2_MouseClicked (EventData As MouseEvent)
	AS_CardSlider1.PreviousPage
End Sub
#Else
Private Sub Label1_Click
	AS_CardSlider1.NextPage
End Sub

Private Sub Label2_Click
	AS_CardSlider1.PreviousPage
End Sub
#End If
