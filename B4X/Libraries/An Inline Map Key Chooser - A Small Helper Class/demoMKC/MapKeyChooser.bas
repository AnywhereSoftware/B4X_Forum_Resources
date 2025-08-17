B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI

	Private Dialog As B4XDialog
	Private CustomListView1 As CustomListView 'loaded from ListTemplate
	Private ListOfKeysPanel As B4XView
	Private target As B4XView
End Sub

Public Sub Initialize(target_ As B4XView)
	target = target_
	SetUpDialog
End Sub

Private Sub SetUpDialog
	'simplest layout, white for everything, black for border, no title, no buttons
	Dialog.Initialize(target)
	Dialog.BackgroundColor = xui.Color_White
	Dialog.BorderWidth = 1
	Dialog.BorderColor = xui.Color_Black
	Dialog.BorderCornersRadius = 5dip
	Dialog.Title = ""
	Dialog.OverlayColor = xui.Color_RGB(220, 220, 220)
	ListOfKeysPanel = xui.CreatePanel("")
	ListOfKeysPanel.SetLayoutAnimated(0, 200, 200, target.Width - 400, target.Height - 100)
	ListOfKeysPanel.LoadLayout("ListTemplate") 		'ListTemplate is part of XUI Views library - no need for designer
	CustomListView1.GetBase.Color = xui.Color_White
	CustomListView1.sv.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	CustomListView1.sv.ScrollViewInnerPanel.Color = xui.Color_White
End Sub

Public Sub ChooseKey(mp As Map, mapName As String)
	CustomListView1.Clear
	For Each kw As String In mp.Keys
		Dim item As B4XView = xui.CreatePanel("")
		item.SetColorAndBorder(xui.Color_White, 0, 0, 0)
		item.SetLayoutAnimated(0, 0, 0, ListOfKeysPanel.Width, 40dip)
		Dim lbl As Label: lbl.Initialize("")
		lbl.Text = kw
		item.AddView(lbl, 0, 0, item.Width, item.Height)
		CustomListView1.Add(item, $"${mapName}.Get("${kw}")"$)
	Next
	Dialog.ShowCustom(ListOfKeysPanel, "", "", "")		'no wait for, closed by CustomListView1_ItemClick
End Sub

Sub CustomListView1_ItemClick(Index As Int, Value As Object)
	Dialog.Close(xui.DialogResponse_Positive)
	Log(Value)
End Sub