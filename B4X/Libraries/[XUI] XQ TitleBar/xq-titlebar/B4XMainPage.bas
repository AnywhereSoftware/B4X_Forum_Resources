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
	Private xq As xq_titlebar
	Private xq2 As xq_titlebar
	Private Panel1 As Panel
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Dim cs As CSBuilder
	
	xq.BurgerIcon.Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF039)).PopAll
	xq.icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf014)).PopAll
	xq.icons(1).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF040)).PopAll
	xq.icons(2).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF1E0)).PopAll
	
	xq2.BurgerIcon.Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF039)).PopAll
	xq2.icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF105)).PopAll
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	xq.setText("Button Pressed")
	xq.Clear
	xq.IconCount=1
	xq.redraw
	xq.Refresh
	Dim cs As CSBuilder
	xq.BurgerIcon.Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf014)).PopAll
	xq.icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf014)).PopAll
'	xq.icons(1).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf014)).PopAll
'	xq.icons(2).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf014)).PopAll
	
End Sub

Private Sub xq_BurgerClick
	xui.MsgboxAsync("Lets disappear this icon", "B4X")
	Dim cs As CSBuilder
	xq.ShowBurgerIcon = False
	xq.redraw
	Select xq.IconCount
		Case 1
			xq.icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf014)).PopAll
		Case 2
			xq.icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf014)).PopAll
			xq.icons(1).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF040)).PopAll
		Case 3
			xq.icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf014)).PopAll
			xq.icons(1).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF040)).PopAll
			xq.icons(2).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF1E0)).PopAll
	End Select
	
End Sub

Private Sub xq_TitleClick
	xui.MsgboxAsync("title click", "B4X")
	
End Sub

Private Sub xq_IconClick(index As Int)
	
	Select index
		Case 2
			xq.TextColor = xui.Color_Yellow
			xq.Background =  xui.Color_Blue
			xq.ShowBurgerIcon = False
			xq.Refresh
		Case 1
			xq.setText("One icon")
			
			xq.IconCount=1
			xq.redraw
			Dim cs As CSBuilder
			xq.BurgerIcon.Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf014)).PopAll
			xq.icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF1E0)).PopAll
		Case 0
			xq.setText("Three icons in a row")
			xq.TextColor = xui.Color_White
			xq.Background =  xui.Color_red
			xq.IconCount=3
			xq.ShowBurgerIcon = True
			xq.redraw
			Dim cs As CSBuilder
			xq.BurgerIcon.Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf014)).PopAll
			xq.icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf014)).PopAll
			xq.icons(1).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF040)).PopAll
			xq.icons(2).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF1E0)).PopAll
	End Select
	
End Sub


Private Sub xq2_IconClick(index As Int)
	Dim cs As CSBuilder
	If Panel1.Visible Then
		xq2.icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xf105)).PopAll
		Panel1.SetVisibleAnimated(400,False)
		Panel1.SetLayoutAnimated(0,Panel1.Left,Panel1.Top,Panel1.Width,5dip)
		Panel1.Visible = False
	Else 
		xq2.icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF107)).PopAll
		Panel1.Visible = True
		Panel1.SetLayoutAnimated(400,Panel1.Left,Panel1.Top,Panel1.Width,100dip)
	End If
	
End Sub