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
	
	Private xp As xq_xpandpanel
	Private xp2 As xq_xpandpanel
	Private Label1 As Label
	Private clv As CustomListView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Dim cs As CSBuilder
	xp.icons(1).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF085)).PopAll
	xp2.icons(1).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF085)).PopAll
	fillpanel
End Sub

Private Sub fillpanel
	'xpanel1
	xp.Radius = 10dip
	xp2.Radius = 10dip
	Dim p As Panel
	p = xp.GetPanel
	
	p.RemoveAllViews
	p.LoadLayout("inner")
	For i = 0 To 20
		clv.AddTextItem($"Item ${i}"$,i)
	Next

	clv.DefaultTextBackgroundColor = xui.Color_Transparent
	clv.sv.SetColorAndBorder(xp.Background,0,0x00ffffff,0)
	clv.PressedColor = xp.Background
	clv.DefaultTextColor = xui.Color_White
	clv.sv.ScrollViewInnerPanel.Color = xui.Color_Transparent
			
	Label1.Text = "Total Items: " & clv.Size
	Label1.Color = xui.Color_Transparent
	
	
	'xpanel 2
	Dim line1 As B4XView = xui.CreatePanel("")
	Dim line2 As B4XView = xui.CreatePanel("")
	
	line1.Color = HexToColor("#99aaaaaa")
	line2.Color = HexToColor("#99aaaaaa")
	
	Dim lbl As Label
	lbl = CreateLabel("")
	lbl.Text = "Amount"
	lbl.TextColor = HexToColor("FFffffff")
	lbl.TextSize = 16
	lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
	
	Dim lbl2 As Label
	lbl2 = CreateLabel("")
	lbl2.Text = "3.14$"
	lbl2.TextColor = HexToColor("FFffffff")
	lbl2.TextSize = 16
	lbl2.Typeface = Typeface.DEFAULT_BOLD
	lbl2.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.RIGHT)
	Dim p As Panel
	p = xp2.GetPanel
	p.RemoveAllViews
	p.AddView(lbl,10dip,5dip,p.Width-20dip, p.Height-10dip)
	p.AddView(lbl2,p.Width-90dip,5dip,70dip, p.Height-10dip)
	p.AddView(line1,5dip,0,p.Width-10dip,2dip)
	p.AddView(line2,5dip,p.Height-2dip,p.Width-10dip,2dip)
End Sub

Sub HexToColor(Hex As String) As Int
	Dim bc As ByteConverter
	If Hex.StartsWith("#") Then
		Hex = Hex.SubString(1)
	Else If Hex.StartsWith("0x") Then
		Hex = Hex.SubString(2)
	End If
	Dim ints() As Int = bc.IntsFromBytes(bc.HexToBytes(Hex))
	Return ints(0)
End Sub 

Private Sub CreateLabel(event As String) As B4XView
	Dim LH As Label
	LH.Initialize(event)
	LH.Ellipsize = "END"
	LH.SingleLine=True
	Return LH
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Private Sub xp_Expand
	xp.setText("Expanded")
End Sub

Private Sub xp_Collapse
	xp.setText("Collapsed")
End Sub

Private Sub xp_IconClick(index As Int)
	Select index
		Case 1
			xp.Animated = Not(xp.Animated)
			If xp.Animated Then 
				xui.MsgboxAsync("Animation Enabled", "B4X")
			Else				
				xui.MsgboxAsync("Animation Disabled", "B4X")
			End If
			
	End Select
End Sub

Private Sub xp2_IconClick(index As Int)
	Select index
		Case 1
			xp2.Animated = Not(xp2.Animated)
	End Select
End Sub

Private Sub xp2_PanelClick
	xui.MsgboxAsync("Panel Clicked", "B4X")
End Sub