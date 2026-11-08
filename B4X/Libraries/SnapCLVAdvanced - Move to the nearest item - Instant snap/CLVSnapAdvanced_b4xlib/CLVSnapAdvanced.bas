B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.45
@EndOfDesignText@
Sub Class_Globals
	Private ScrollChangedIndex As Int
	Private xclv_Main As CustomListView
	Private xui As XUI 'ignore
	Public InactiveDuration As Int = 500
	Private m_InstantSnap As Boolean = False
	#If B4A or B4I
	Private m_Y As Float
	#End If
	#If B4A
	Private isfirstmove As Boolean = False
	#Else If B4J
	Private DisableScroll as Boolean = False
	Private OldOffset As Int
	#Else If B4I
	Private tmp As GestureRecognizer
	#End If
	Private m_isVertical As Boolean = True
End Sub

Public Sub Initialize (CLV As CustomListView)
	xclv_Main = CLV
	
	#If B4A
	Private objPages As Reflector
	objPages.Target = xclv_Main.sv
	objPages.SetOnTouchListener("xCLV_Touch")
	#Else IF B4I	
	tmp.Initialize("tmp",Me,xclv_Main.GetBase)
	tmp.AddLongPressGesture(0,1,0)
	tmp.AddPanGesture(1,1)
	#End If
	
End Sub

Public Sub ScrollChanged (Offset As Int)
	ScrollChangedIndex = ScrollChangedIndex + 1
	Dim MyIndex As Int = ScrollChangedIndex
	If m_InstantSnap = False Then
		Sleep(InactiveDuration)
		If ScrollChangedIndex = MyIndex Then
			SnapCLV(Offset)
		End If
	End If
	
	#If B4J
	
	If m_InstantSnap = True or DisableScroll = False Then
	
		If OldOffset  > Offset Then
			xclv_Main.ScrollToItem(xclv_Main.FindIndexFromOffset(Offset))
		Else
			DisableScroll = True
			xclv_Main.ScrollToItem(xclv_Main.FindIndexFromOffset(Offset)+1)
			Sleep(50)
		End If
	End If
	DisableScroll = False
	OldOffset = Offset
	#End If
End Sub

Private Sub SnapCLV (Offset As Int)
	Dim i As Int = xclv_Main.FirstVisibleIndex
	If i < 0 Then Return
	If Offset + xclv_Main.sv.Height >= xclv_Main.sv.ScrollViewContentHeight Then Return
	Dim item As CLVItem	 = xclv_Main.GetRawListItem(i)
	Dim visiblepart As Int = item.Offset + item.Size - Offset
	If visiblepart / item.Size > 0.5 Then
		xclv_Main.ScrollToItem(i)
	Else
		xclv_Main.ScrollToItem(i + 1)
	End If
End Sub

#If B4A
Private Sub xCLV_Touch(ViewTag As Object, Action As Int, X As Float, y As Float, MotionEvent As Object) As Boolean
	If m_InstantSnap = True Then HandleTouch(Action,x,y)
	Return False
End Sub
#End If

#If B4A or B4I
#If B4A
Private Sub HandleTouch(Action As Int,x As Float,y As Float) As ResumableSub'ignore
#Else If B4I
Private Sub HandleTouch(Action As Int,x As Float,y As Float) As ResumableSub 'ignore
	Sleep(0)
#End If
	'Log(Action)
	Select Action
		Case 2
			'Log("First: " & xclv_Main.FirstVisibleIndex)
			#If B4A
			If isfirstmove = False Then
				m_Y = y
				isfirstmove = True
			End If
			#End If
		Case 1
			#If B4A
			isfirstmove = False
			#End If
			Sleep(50)
			If y > m_Y Then
				If (xclv_Main.FirstVisibleIndex+1) >= xclv_Main.Size Then Return False 
				Dim item As CLVItem	 = xclv_Main.GetRawListItem(xclv_Main.FirstVisibleIndex+1)
				#If B4I
				If m_isVertical = True Then
					xclv_Main.sv.As(ScrollView).ScrollTo(xclv_Main.sv.ScrollViewOffsetX,item.Offset - item.Panel.Height,True)
				Else
					xclv_Main.sv.As(ScrollView).ScrollTo(item.Offset,xclv_Main.sv.ScrollViewOffsety,True)
				End If
				#Else
				If m_isVertical = True Then
				xclv_Main.sv.As(ScrollView).ScrollPosition = item.Offset - item.Size
				Else
					xclv_Main.sv.As(HorizontalScrollView).ScrollPosition = item.Offset - item.Size
				End If
				#End If
			Else
				Dim item As CLVItem	 = xclv_Main.GetRawListItem(IIf(xclv_Main.FirstVisibleIndex+1 < xclv_Main.Size -1,xclv_Main.FirstVisibleIndex+1,xclv_Main.FirstVisibleIndex))
				#If B4I
				If m_isVertical = True Then
					xclv_Main.sv.As(ScrollView).ScrollTo(xclv_Main.sv.ScrollViewOffsetX,item.Offset,True)
				Else
					xclv_Main.sv.As(ScrollView).ScrollTo(item.Offset + item.Size,xclv_Main.sv.ScrollViewOffsety,True)
				End If
				#Else
				If m_isVertical = True Then
					xclv_Main.sv.As(ScrollView).ScrollPosition = item.Offset
				Else
				xclv_Main.sv.As(HorizontalScrollView).ScrollPosition = item.Offset
				End If
				#End If
			End If
			Return True
	End Select
	Return False
End Sub

#If B4I
Private Sub tmp_pan(state As Int, att As Pan_Attributes)
	'If g_isScrollEnabled = False Then Return
	'Log("att.X: " & att.X)
	Select state
		Case 2 'STATE_Changed
			If m_InstantSnap = True Then HandleTouch(2,att.X,att.Y)
		Case 3 'STATE_End
			If m_InstantSnap = True Then HandleTouch(1,att.X,att.Y)
	End Select
End Sub
#End If

#End If

Public Sub setInstantSnap(InstantSnap As Boolean)
	m_InstantSnap = InstantSnap
End Sub

Public Sub setisVertical(Vertical As Boolean)
	m_isVertical = Vertical
End Sub