B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.31
@EndOfDesignText@
'v1.00
#Event: RemoveItem (Index As Int)
Sub Class_Globals
	Private xui As XUI
	Private clv2 As CustomListView
	Private PressedColor As Int
	Private Top As Int
	Private pnl As B4XView
	Private ListStartY As Int
	Private dWidth, dBackground, dTextColor As Int
	Private downX, downY As Int
	Private verticalMove, horizontalMove, leftMove As Boolean
	Private lvInitialSize As Int
	Private mCallback As Object
	Private mEventName As String
End Sub

'Recibimos la vista y la lista de textos a mostrar en cada ítem:
Public Sub Initialize (clv As CustomListView, Callback As Object, EventName As String)
	clv2 = clv
	PressedColor = clv2.PressedColor
	dTextColor = clv2.DefaultTextColor
	dBackground = xui.Color_Transparent
	dWidth = 30dip
	mCallback = Callback
	mEventName = EventName
End Sub

'Set values for dragger width, background color and text color
'or defaults will be used - width=30dip, background color=transparetn, text color=clv default color
Public Sub SetDefaults (width As Int, backColor As Int, txtColor As Int)
	dWidth = width
	dBackground = backColor
	dTextColor = txtColor
End Sub

Public Sub RemoveDragButtons
	For i = 0 To clv2.Size - 1
		Dim p As B4XView = clv2.GetPanel(i)
		Dim b As Boolean = IsLastViewADragLabel(p)
		If b Then	'IsLastViewADragLabel(p) Then
			p.GetView(p.NumberOfViews - 1).RemoveViewFromParent
		End If
	Next
	clv2.PressedColor = PressedColor
End Sub

Private Sub IsLastViewADragLabel (p As B4XView) As Boolean
	If p.NumberOfViews > 0 Then
		Dim v As B4XView = p.GetView(p.NumberOfViews - 1)
		If v Is Label And v.Tag = Null Then
			Return False
		End If
		Return v Is Label And v.Tag = clv2
	End If
	Return False
End Sub

Public Sub AddDragButtons
	clv2.PressedColor = xui.Color_Transparent
	Dim fnt As B4XFont = xui.CreateMaterialIcons(30)	'Get the font provided by the XUI Views library
	For i = 0 To clv2.Size - 1
		Dim p As B4XView = clv2.GetPanel(i)
		If IsLastViewADragLabel(p) = False Then
			Dim lbl As Label
			lbl.Initialize("")	'Drag")
			Dim xlbl As B4XView = lbl
			xlbl.Font = fnt
			xlbl.Text = Chr(0xE25D)
			xlbl.TextColor = dTextColor
			xlbl.Color = dBackground
			xlbl.SetTextAlignment("CENTER", "CENTER")
			
			'We put the CustomListView in the Label tag
			xlbl.Tag = clv2
			
			p.AddView(xlbl, p.Width - dWidth -10dip, p.Height / 2 - 15dip, dWidth, 30dip)
			
			'Activamos un Listener para cada Label
			Dim r As Reflector
			r.Target = lbl	
			r.SetOnTouchListener("lbl_Touch")
		End If
	Next
End Sub

Private Sub lbl_Touch(ViewTag As Object, Action As Int, X As Float, Y As Float, EventData As Object) As Boolean
	Dim lbl As B4XView = Sender
	Dim clv2 As CustomListView = lbl.Tag	'(¿Es necesario así?)

	If Action = 0 Then				'ACTION_DOWN
		
		'We disable ScrollView when touch starts with:
		Dim r As Reflector
		r.Target = clv2.sv		
		r.RunMethod2("requestDisallowInterceptTouchEvent", True, "java.lang.boolean")
		
		'We access the item panel and paint a lilac border
		pnl = clv2.GetPanel(clv2.GetItemFromView(lbl)).Parent
		pnl.GetView(0).SetColorAndBorder(xui.Color_Transparent, 3dip, 0xFF503ACD, 0)	'= #503ACD
		ListStartY = Y + lbl.Top + pnl.Top
		pnl.BringToFront
		Top = pnl.Top
		
		downX = X
		downY = Y
		
		verticalMove = False
		horizontalMove = False
		leftMove = False
		
'		LogColor(clv2.GetItemFromView(lbl), Colors.Magenta)
		
		lvInitialSize = clv2.Size
		
	Else If Action = 1 Then				'ACTION_UP
		
		Dim index As Int = clv2.GetItemFromView(lbl)
		
		If horizontalMove = True And leftMove = True Then
'		If downX - X > 50 Then

			'We pass the removing to the event with animation
			CallSub2(mCallback, mEventName & "_RemoveItem", index)
		End If
		
'		Log(clv2.Size)
		
		
		'If we have not removed the item. VerticalMove if we want to leave the item in that position until we decide (in the event)
		If lvInitialSize = clv2.Size And verticalMove = True Then
			
			Dim index As Int = clv2.GetItemFromView(lbl)
			pnl = clv2.GetPanel(index).Parent
			
			'Find the index of the next item:
			Dim Offset As Int = pnl.Top + pnl.Height / 2					'(a + b) / 2
			Dim NewIndex As Int = clv2.FindIndexFromOffset(Offset)
		
			Log("Step 1, index = " & index & ", Offset = " & Offset & ", NewIndex = " & NewIndex)
		
		

			
			Dim UnderlyingItem As CLVItem = clv2.GetRawListItem(NewIndex)		'The next CLVItem
			If Offset - UnderlyingItem.Offset > UnderlyingItem.Size / 2 Then	'If half of the CLVItem that we move minus half of the Offset (midpoint) of the next CLVItem is greater than half of the next CLVItem
				NewIndex = NewIndex + 1
				Log("NewIndex after UnderlyingItem = " & NewIndex)
			End If
			
			Log("Offset: " & Offset & " UnderlyingItem.Offset " & UnderlyingItem.Offset & " Size / 2: " & (UnderlyingItem.Size / 2))
			
			Dim ActualItem As B4XView  = pnl.GetView(0)
			ActualItem.RemoveViewFromParent
			ActualItem.SetColorAndBorder(pnl.Color, 0dip, xui.Color_Black, 0)
			
			Dim RawItem As CLVItem = clv2.GetRawListItem(index)
			clv2.RemoveAt(index)
			If NewIndex > index Then
				NewIndex = NewIndex - 1
'			Log("NewIndex after RawItem = " & NewIndex)
			End If
			NewIndex = Max(0, Min(clv2.Size, NewIndex))
'			Log("NewIndex after Max = " & NewIndex)
		
			clv2.InsertAt(NewIndex, ActualItem, RawItem.Value)
			clv2.GetRawListItem(NewIndex).TextItem = RawItem.TextItem
				
'			Log(NewIndex & ", " & RawItem.Value)
'			Log(index & ", " & clv2.GetValue(index))
'			Log(clv2.GetItemFromView(ActualItem) & ", x")
	
		End If
			


	Else If Action = 2 Then 			'ACTION_MOVE
		
		'We only allow one type of movement:
		If verticalMove = False And Abs(X - downX) > Abs(Y - downY) Then
			horizontalMove = True
		Else If horizontalMove = False And Abs(X - downX) < Abs(Y - downY) Then
			verticalMove = True
		End If
		
		If horizontalMove = True Then
			
			'We allow horizontal panel movement to the left only
			If X < downX Then
				pnl.Left = pnl.Left + X - downX

				
				'In case you end up moving your finger to the right. For the record you first moved it to the left. Do not allow movement to the right
				leftMove = True
			End If
			
		Else If verticalMove = True Then		'We control the vertical movement
			
			If clv2.Size < 2 Then Return True
			
			'To auto scroll:
			If pnl.Top < clv2.sv.ScrollViewOffsetY Then
				clv2.sv.ScrollViewOffsetY = Max(0, clv2.sv.ScrollViewOffsetY - 10dip)
			Else If clv2.sv.ScrollViewOffsetY + clv2.sv.Height < pnl.Top + pnl.Height Then
				clv2.sv.ScrollViewOffsetY = clv2.sv.ScrollViewOffsetY + 10dip
			End If
			
			'We allow movement:
			Dim ListY As Int = Y + lbl.Top 	+ pnl.Top
			Dim delta As Int = ListY - ListStartY
			pnl.Top = Top + delta
		End If
		
	Else 
		
		Log("action " & Action)
	End If
	
	Return True
End Sub