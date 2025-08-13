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
	
	Private xq As xq_breadcrumbs
	Private Button1 As Button
	Private Label1 As Label
	Private Spinner1 As Spinner
	Private CheckBox1 As CheckBox
	Private Button2 As Button
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
		
	xq.padding = 8dip
	xq.Clear
	Spinner1.AddAll(Array As String("Text Only","Files","Cart","System","Fixed Width"))
	
End Sub

Private Sub clv_ItemClick (Index As Int, Value As Object)
	Label1.Text = $"Index: ${Index}, Values: ${Value}"$
End Sub

Private Sub xq_Click(Index As Int, Value As Object)
	Select Value
		Case -2
			Label1.Text = $"Home Index: ${Index}, Values: ${Value} v: ${xq.GetValueAt(Index)}"$
		Case Else
			Label1.Text = $"Index: ${Index}, Values: ${Value} v: ${xq.GetValueAt(Index)}"$
	End Select
	
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


Private Sub Spinner1_ItemClick (Position As Int, Value As Object)
	Dim cs As CSBuilder
	xq.Active = True
	Select Position
		Case 0
			xq.RootChar=Chr(0xF101)
			xq.SeperatorChar=Chr(0xF105)
			xq.Background = HexToColor("#ff60CFF1")
			xq.TextColor = xui.Color_White
			xq.Redraw
			xq.Clear
			For i=0 To 20
				xq.AddTextItem("Item "& i,i)
			Next
			xq.ScrollToEnd
		Case 1
			xq.RootChar=Chr(0xF07C)
			xq.SeperatorChar=Chr(0xF105)
			xq.Background = xui.Color_White
			xq.TextColor = xui.Color_Black
			xq.Pressed = HexToColor("#ffc3c3c3")
			xq.Redraw
			xq.Clear
			xq.AddTextItem("Drive",200)
			For i=0 To 19
				xq.AddTextItem(cs.Initialize.Append("  ").Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF115)).Pop.Append("  Item "& i).PopAll,i)
			Next
		Case 2
			xq.RootChar=Chr(0xF07A)
			xq.SeperatorChar=Chr(0xF061)
			xq.Background = HexToColor("#ffF22940")
			xq.TextColor = xui.Color_yellow
			xq.Pressed = HexToColor("#ffB30000")
			xq.Redraw
			xq.Clear
			'xq.AddItem("Drive",200)
			For i=0 To 19
				xq.AddTextItem("Product " & i, i)
			Next
		Case 3
			xq.RootChar=Chr(0xE8B8)
			xq.SeperatorChar=Chr(0xF142)
			xq.Background = HexToColor("#ff3c3c3c")
			xq.TextColor = xui.Color_White
			xq.Pressed = xui.Color_LightGray
			xq.Redraw
			xq.Clear
			
			xq.AddTextItem("Settings",200)
			xq.AddTextItem(cs.Initialize.Append("  ").Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF287)).Pop.Append("  USB Connections").PopAll,i)
			xq.AddTextItem(cs.Initialize.Append("  ").Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF1f8)).Pop.Append("  Trash").PopAll,i)
			xq.AddTextItem(cs.Initialize.Append("  ").Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF0C0)).Pop.Append("  Users").PopAll,i)
			xq.AddTextItem(cs.Initialize.Append("  ").Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF073)).Pop.Append("  Calendar").PopAll,i)
			xq.AddTextItem(cs.Initialize.Append("  ").Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF09E)).Pop.Append("  Feeds").PopAll,i)
		Case 4
			xq.RootChar=Chr(0xE8B8)
			xq.SeperatorChar=Chr(0xF142)
			xq.Background = HexToColor("#ff3c3c3c")
			xq.TextColor = xui.Color_White
			xq.Pressed = xui.Color_LightGray
			xq.Redraw
			xq.Clear
			
			xq.AddTextItem("Settings",200)
			xq.AddTextItemwidth(cs.Initialize.Append("  ").Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF287)).Pop.Append("  USB Connections").PopAll,i,100dip)
			xq.AddTextItemwidth(cs.Initialize.Append("  ").Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF1f8)).Pop.Append("  Trash").PopAll,i,100dip)
			xq.AddTextItemwidth(cs.Initialize.Append("  ").Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF0C0)).Pop.Append("  Users").PopAll,i,100dip)
			xq.AddTextItemwidth(cs.Initialize.Append("  ").Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF073)).Pop.Append("  Calendar").PopAll,i,100dip)
			xq.AddTextItemwidth(cs.Initialize.Append("  ").Typeface(Typeface.FONTAWESOME).Size(16).Append(Chr(0xF09E)).Pop.Append("  Feeds").PopAll,i,100dip)
			
	End Select
	
End Sub

Private Sub CheckBox1_CheckedChange(Checked As Boolean)
	xq.RemoveItems = Checked
End Sub



Private Sub Button2_Click
	xq.ScrollToEnd
End Sub

Private Sub Button1_Click
  	xq.ScrollToStart	
End Sub