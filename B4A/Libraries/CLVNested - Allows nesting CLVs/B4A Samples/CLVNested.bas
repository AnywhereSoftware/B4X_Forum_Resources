B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
'Version: 1.10
Sub Class_Globals
	Private xui As XUI 'ignore
	Private ScrollingCLV As CustomListView
	Private ScrollingCLVHorizontal As Boolean
	Private StartOffset As Float
	Private ScrollPosition As Float
	Public base As B4XView
	Public CLV As CustomListView 
	Private Scrolled As Boolean
End Sub

Public Sub Initialize (Parent As B4XView)
	Dim tpc As TouchPanelCreator
	base = tpc.CreateTouchPanel("tpc")
	Parent.AddView (base, 0, 0, Parent.Width, Parent.Height)
End Sub

Private Sub tpc_OnTouchEvent (Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	Select Action
		Case base.TOUCH_ACTION_MOVE
			Dim deltaOffset As Float = (GetOffset(X, Y) - StartOffset) * 1.5
			If Scrolled = False Then
				If Abs(deltaOffset) > 10dip Then Scrolled = True
			End If
			If Scrolled Then
				
				If ScrollingCLVHorizontal Then
					ScrollingCLV.sv.ScrollViewOffsetX = ScrollPosition - deltaOffset
				Else
					ScrollingCLV.sv.ScrollViewOffsetY = ScrollPosition - deltaOffset
				End If
			End If
		Case base.TOUCH_ACTION_UP
			If Scrolled = False Then
				If ScrollingCLVHorizontal Then
					Dim innerIndex As Int = ScrollingCLV.FindIndexFromOffset(X + ScrollingCLV.sv.ScrollViewOffsetX)
				Else
					Dim index As Int = CLV.FindIndexFromOffset(StartOffset + CLV.sv.ScrollViewOffsetY)
					Dim item As CLVItem = CLV.GetRawListItem(index)
					Dim innerIndex As Int = ScrollingCLV.FindIndexFromOffset(StartOffset + CLV.sv.ScrollViewOffsetY - item.Offset + ScrollingCLV.sv.ScrollViewOffsetY)
				End If
				CallSub2(ScrollingCLV, "Panel" & "ClickHandler", ScrollingCLV.GetRawListItem(innerIndex).Panel) 'ignore
			End If
			ScrollingCLV = Null
	End Select
	Return ScrollingCLV <> Null
End Sub

Private Sub tpc_OnInterceptTouchEvent (Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	If Action = base.TOUCH_ACTION_DOWN Then
		Dim inner As CustomListView = GetInnerCLVFromTouch(X, Y)
		If inner <> Null Then
			ScrollingCLV = inner
			ScrollingCLVHorizontal = IsHorizontalCLV
			StartOffset = GetOffset(X, Y)
			Scrolled = False
			ScrollPosition =  GetOffset(ScrollingCLV.sv.ScrollViewOffsetX, ScrollingCLV.sv.ScrollViewOffsetY)
			Return True
		End If
	End If
	Return False
End Sub

Private Sub GetOffset (x As Float, y As Float) As Float
	If ScrollingCLVHorizontal Then
		Return x
	Else
		Return y
	End If
End Sub

Private Sub IsHorizontalCLV As Boolean
	Return ScrollingCLV.sv Is HorizontalScrollView
End Sub

Private Sub GetInnerCLVFromTouch (x As Float, Y As Float) As CustomListView
	Dim index As Int = CLV.FindIndexFromOffset(Y + CLV.sv.ScrollViewOffsetY)
	Dim item As CLVItem = CLV.GetRawListItem(index)
	If item.Panel.GetView(0).Tag Is CustomListView Then
		Dim inner As CustomListView = item.Panel.GetView(0).Tag
			
		If inner.AsView.Left <= x And inner.AsView.Left + inner.AsView.Width >= x Then Return inner
	End If
	Return Null
End Sub