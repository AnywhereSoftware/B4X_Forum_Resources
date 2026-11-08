B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.31
@EndOfDesignText@
'v1.00
Sub Class_Globals
	Private xui As XUI
	Private list As CustomListView
	Private PressedColor As Int
	Private Top,blankTop As Int
	Private pnl As B4XView
	Private ListStartY As Int
	Private dWidth, dBackground, dTextColor As Int
	Private curIndex As Int =-1
	Private animationType As Int = 0
End Sub

Public Sub Initialize (clv As CustomListView)
	list = clv
	PressedColor = list.PressedColor
	dTextColor = list.DefaultTextColor
	dBackground = xui.Color_Transparent
	dWidth = 30dip
End Sub

'Set values for dragger width, background color and text color
'or defaults will be used - width=30dip, background color=transparetn, text color=clv default color
Public Sub SetDefaults (width As Int, backColor As Int, txtColor As Int)
	dWidth = width
	dBackground = backColor
	dTextColor = txtColor
End Sub

Public Sub SetAnimationType(v As Int)
	animationType= v
End Sub

Public Sub RemoveDragButtons
	For i = 0 To list.Size - 1
		Dim p As B4XView = list.GetPanel(i)
		Dim b As Boolean = IsLastViewADragLabel(p)
		If b Then	'IsLastViewADragLabel(p) Then
			p.GetView(p.NumberOfViews - 1).RemoveViewFromParent
		End If
	Next
	list.PressedColor = PressedColor
End Sub

Private Sub IsLastViewADragLabel (p As B4XView) As Boolean
	If p.NumberOfViews > 0 Then
		Dim v As B4XView = p.GetView(p.NumberOfViews - 1)
		If v Is Label And v.Tag = Null Then
			Return False
		End If
		Return v Is Label And v.Tag = list
	End If
	Return False
End Sub

Public Sub AddDragButtons
	list.PressedColor = xui.Color_Transparent
	Dim fnt As B4XFont = xui.CreateMaterialIcons(30)
	For i = 0 To list.Size - 1
		Dim p As B4XView = list.GetPanel(i)
		If IsLastViewADragLabel(p) = False Then
			Dim lbl As Label
			lbl.Initialize("")	'Drag")
			Dim xlbl As B4XView = lbl
			xlbl.Font = fnt
			xlbl.Text = Chr(0xE25D)
			xlbl.TextColor = dTextColor
			xlbl.Color = dBackground
			xlbl.SetTextAlignment("CENTER", "CENTER")
			xlbl.Tag = list
			p.AddView(xlbl, p.Width - dWidth -2dip, p.Height / 2 - 15dip, dWidth, 30dip)
			Dim r As Reflector
			r.Target = lbl	
			r.SetOnTouchListener("lbl_Touch")
		End If
	Next
End Sub

Private Sub ShakeView (View As B4XView, Duration As Int)
	Dim Left As Int = 0
	Dim Delta As Int = 5dip
	For i = 1 To 4
		View.SetLayoutAnimated(Duration / 5, Left + Delta, View.Top, View.Width, View.Height)
		Delta = -Delta
		Sleep(Duration / 5)
	Next
	View.SetLayoutAnimated(Duration/5, Left, View.Top, View.Width, View.Height)
End Sub

Private Sub moveView (View As B4XView, moveTop As Int)
	View.SetLayoutAnimated(100, 0, moveTop, View.Width, View.Height)
End Sub

Private Sub lbl_Touch(ViewTag As Object, Action As Int, X As Float, Y As Float, EventData As Object) As Boolean
	Dim lbl As B4XView = Sender
	Dim list As CustomListView = lbl.Tag

	If Action = 0 Then									'ACTION_DOWN
		Dim r As Reflector
		r.Target = list.sv
		r.RunMethod2("requestDisallowInterceptTouchEvent", True, "java.lang.boolean")
		pnl = list.GetPanel(list.GetItemFromView(lbl)).Parent
		pnl.GetView(0).SetColorAndBorder(xui.Color_Transparent, 3dip, 0xFF503ACD, 0)
		ListStartY = Y + lbl.Top + pnl.Top
		pnl.BringToFront
		Top = pnl.Top
		blankTop= Top
	Else If Action = 1 Then								'ACTION_UP
		Dim index As Int = list.GetItemFromView(lbl)
		pnl.Top= blankTop
		If list.GetRawListItem(curIndex).Panel.Top>blankTop Then
			If curIndex>index Then
				curIndex= curIndex-1
			End If
			If curIndex<0 Then curIndex=0
		Else if list.GetRawListItem(curIndex).Panel.Top<blankTop Then
			If curIndex<index Then
				curIndex= curIndex+1
			End If
			If curIndex>=list.Size Then curIndex= list.Size-1
		End If
		If curIndex=index Then
			Log("Don't need move")
			pnl.GetView(0).SetColorAndBorder(pnl.Color, 0dip, xui.Color_Black, 0)
		Else
			Log("need move")
			Dim ActualItem As B4XView  = pnl.GetView(0)
			ActualItem.RemoveViewFromParent
			ActualItem.SetColorAndBorder(pnl.Color, 0dip, xui.Color_Black, 0)
			
			Dim RawItem As CLVItem = list.GetRawListItem(index)
			list.RemoveAt(index)
		
			list.InsertAt(curIndex, ActualItem, RawItem.Value)
			list.GetRawListItem(curIndex).TextItem = RawItem.TextItem
		End If
	Else If Action = 2 Then 							'ACTION_MOVE
		Dim index As Int = list.GetItemFromView(lbl)
		If pnl.Top < list.sv.ScrollViewOffsetY Then
			list.sv.ScrollViewOffsetY = Max(0, list.sv.ScrollViewOffsetY - 10dip)
		Else If list.sv.ScrollViewOffsetY + list.sv.Height < pnl.Top + pnl.Height Then
			list.sv.ScrollViewOffsetY = list.sv.ScrollViewOffsetY + 10dip
		End If
		Dim ListY As Int = Y + lbl.Top 	+ pnl.Top
		Dim delta As Int = ListY - ListStartY
		pnl.Top = Top + delta
		
		''''''
		Dim Offset As Int = pnl.Top + pnl.Height / 2
		
		If Offset<0 Then
			curIndex=0
		Else if Offset>(list.GetRawListItem(list.Size-1).Panel.Top+list.GetRawListItem(list.Size-1).Panel.Height) Then
			curIndex= list.Size-1
		Else
			Dim topT As Int 
			Dim movePnl As B4XView
			For i= 0 To list.Size-1
				If i<>index Then
					If (Offset>=list.GetRawListItem(i).Panel.Top) And (Offset<=(list.GetRawListItem(i).Panel.Top+list.GetRawListItem(i).Panel.Height)) Then
						movePnl= list.GetRawListItem(i).Panel
						topT= movePnl.Top
						If movePnl.Top<>blankTop Then
							If animationType= 2 Then
								'move Animation
								moveView(movePnl,blankTop)
							Else 
								movePnl.Top= blankTop
								If animationType=1 Then
									'shake Animation							
									ShakeView(movePnl,300)
								End If
							End If							
							blankTop= topT
							curIndex= i
						End If
						Exit
					End If
				End If
			Next
		End If
	Else 
		Log("action " & Action)
	End If
	Return True
End Sub
