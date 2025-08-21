﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.98
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public mBase As B4XView
	Public CustomListView1 As CustomListView
	Public Text As Object
End Sub

Public Sub Initialize
	mBase = xui.CreatePanel("mBase")
	mBase.SetLayoutAnimated(0, 0, 0, 300dip, 300dip)
	mBase.LoadLayout("LongTextTemplate")
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	CustomListView1.sv.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	CustomListView1.DefaultTextBackgroundColor = 0xFF555555
	CustomListView1.DefaultTextColor = xui.Color_White
	CustomListView1.sv.Color = 0xFF464646
	#if B4J
	Dim sv As Node = CustomListView1.sv
	sv.StyleClasses.Add("b4xdialog")
	#end if
End Sub

Public Sub Resize(Width As Int, Height As Int)
	mBase.SetLayoutAnimated(0, 0, 0, Width, Height)
	CustomListView1.AsView.SetLayoutAnimated(0, 0, 0, Width, Height)
	CustomListView1.Base_Resize(Width, Height)
End Sub


Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	Return mBase
End Sub

Private Sub Show (Dialog As B4XDialog) 'ignore
	CustomListView1.Clear
	CustomListView1.AddTextItem(Text, "")
	CustomListView1.GetPanel(0).GetView(0).SetTextAlignment("TOP", "LEFT")
	XUIViewsUtils.AddStubToCLVIfNeeded(CustomListView1, CustomListView1.DefaultTextBackgroundColor)
End Sub

Private Sub DialogClosed(Result As Int) 'ignore

End Sub