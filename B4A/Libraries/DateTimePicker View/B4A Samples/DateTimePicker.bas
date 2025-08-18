B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Custom View class
'version: 1.4
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI
	Private mBase As B4XView
	Private minDate,maxDate As Long
	Private clv1,clv2,clv3 As CustomListView
	Private Label1,Label2,Label3 As B4XView
	Private initValue As Long = DateTime.Now
	Private layoutLoaded As Boolean = False
	Private ScrollChangedIndex1,ScrollChangedIndex2,ScrollChangedIndex3 As Int
	Private xui As XUI 'ignore
	Public InactiveDuration As Int = 200
	Public lineColor As Int = xui.Color_Gray
	Public backgroundColor As Int = xui.Color_Transparent
	Public focusedTextColor As Int = xui.Color_Black
	Public notFocusedTextColor As Int = xui.Color_Gray
	Public fadeAwayEffect As Boolean = True
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	mBase.Tag = Me	
End Sub


Private Sub load
	mBase.LoadLayout("datetimelayout")
	layoutLoaded = True
	Base_Resize(mBase.Width, mBase.Height)
	clv1.AsView.Color = backgroundColor
	clv2.AsView.Color = backgroundColor
	clv3.AsView.Color = backgroundColor
	clv1.sv.Color = backgroundColor
	clv2.sv.Color = backgroundColor
	clv3.sv.Color = backgroundColor
	mBase.Color = backgroundColor
	If mBase.Height < 150dip Then
		Log("DateTimePicker suggested view height is 150dip")
	End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	#if B4J
	If layoutLoaded = False Then load
	#End If
	clv1.AsView.SetLayoutAnimated(0,0,0,Width*0.4,Height)
	Dim centerIndex As Int = Floor((Height/30dip)/2)
	centerIndex = centerIndex*30dip + 3dip
	Label1.SetLayoutAnimated(0,0,centerIndex,clv1.AsView.Width,24dip)
		
	clv2.AsView.SetLayoutAnimated(0,clv1.AsView.Left+clv1.AsView.Width,0,Width*0.25,Height)
	Label2.SetLayoutAnimated(0,clv2.AsView.Left,centerIndex,clv2.AsView.Width,24dip)
	
	clv3.AsView.SetLayoutAnimated(0,clv2.AsView.Left+clv2.AsView.Width,0,Width*0.35,Height)
	Label3.SetLayoutAnimated(0,clv3.AsView.Left,centerIndex,clv3.AsView.Width,24dip)

	#if b4i or b4a
	applyLineColor
	#End If
	
	mBase.Color = backgroundColor
End Sub

Private Sub applyLineColor
	Dim cvs As B4XCanvas
	cvs.Initialize(Label1)
	cvs.ClearRect(cvs.TargetRect)
	Dim path As B4XPath
	path.Initialize(0,0)
	path.LineTo(cvs.TargetRect.Width,0)
	#if b4j
	path.LineTo(cvs.TargetRect.Width,1dip)
	path.LineTo(0,1dip)
	#end if
	cvs.DrawPath(path,lineColor,False,1dip)
	path.Initialize(0,cvs.TargetRect.Height)
	path.LineTo(cvs.TargetRect.Width,cvs.TargetRect.Height)
	#if b4j
	path.LineTo(cvs.TargetRect.Width,cvs.TargetRect.Height-2dip)
	path.LineTo(0,cvs.TargetRect.Height-2dip)
	#end if
	cvs.DrawPath(path,lineColor,False,1dip)
	cvs.Invalidate
	
	Dim cvs As B4XCanvas
	cvs.Initialize(Label2)
	cvs.ClearRect(cvs.TargetRect)
	Dim path As B4XPath
	path.Initialize(0,0)
	path.LineTo(cvs.TargetRect.Width,0)
	#if b4j
	path.LineTo(cvs.TargetRect.Width,1dip)
	path.LineTo(0,1dip)
	#end if
	cvs.DrawPath(path,lineColor,False,1dip)
	path.Initialize(0,cvs.TargetRect.Height)
	path.LineTo(cvs.TargetRect.Width,cvs.TargetRect.Height)
	#if b4j
	path.LineTo(cvs.TargetRect.Width,cvs.TargetRect.Height-2dip)
	path.LineTo(0,cvs.TargetRect.Height-2dip)
	#end if
	cvs.DrawPath(path,lineColor,False,1dip)
	cvs.Invalidate

	
	Dim cvs As B4XCanvas
	cvs.Initialize(Label3)
	cvs.ClearRect(cvs.TargetRect)
	Dim path As B4XPath
	path.Initialize(0,0)
	path.LineTo(cvs.TargetRect.Width,0)
	#if b4j
	path.LineTo(cvs.TargetRect.Width,1dip)
	path.LineTo(0,1dip)
	#end if
	cvs.DrawPath(path,lineColor,False,1dip)
	path.Initialize(0,cvs.TargetRect.Height)
	path.LineTo(cvs.TargetRect.Width,cvs.TargetRect.Height)
	#if b4j
	path.LineTo(cvs.TargetRect.Width,cvs.TargetRect.Height-2dip)
	path.LineTo(0,cvs.TargetRect.Height-2dip)
	#end if
	cvs.DrawPath(path,lineColor,False,1dip)
	cvs.Invalidate
End Sub

'Set the min date
Public Sub SetMinDate(md As Long)
	minDate = md
End Sub

'Set the max date
Public Sub SetMaxDate(md As Long)
	maxDate = md
End Sub

'Add the items to the lists based on the min and max date
Public Sub Show
	If layoutLoaded = False Then load
	clv1.Clear
	clv2.Clear
	clv3.Clear
	For i = 1 To 5
		Dim p As B4XView = xui.CreatePanel("")
		p.Color = backgroundColor
		p.SetLayoutAnimated(0, 0, 0, clv1.AsView.Width, 30dip)
		clv1.Add(p, -1)
	Next
	Dim temMax As Long = maxDate-DateTime.GetHour(maxDate)*DateTime.TicksPerHour-DateTime.GetMinute(maxDate)*DateTime.TicksPerMinute +1
	Dim temMin As Long = minDate-DateTime.GetHour(minDate)*DateTime.TicksPerHour-DateTime.GetMinute(minDate)*DateTime.TicksPerMinute +1	
	Dim numOfDays As Int = Floor((temMax-temMin)/DateTime.TicksPerDay)
	For i = 0 To numOfDays
		Dim p As B4XView = xui.CreatePanel("")
		p.Color = backgroundColor
		p.SetLayoutAnimated(0, 0, 0, clv1.AsView.Width-2dip, 30dip)
		Dim tmp As Label
		tmp.Initialize("")
		Dim lbl As B4XView = tmp
		p.AddView(lbl,0,0,clv1.AsView.Width-2dip, 30dip)
		DateTime.DateFormat=("MMM dd")
		lbl.Text = $"$Date{temMax-DateTime.TicksPerDay*(numOfDays-i)}"$
		lbl.TextColor = notFocusedTextColor
		lbl.TextSize = 12
		lbl.SetTextAlignment("CENTER","RIGHT")
'		lbl.Gravity = Gravity.CENTER_VERTICAL+Gravity.RIGHT
		clv1.Add(p, temMax-DateTime.TicksPerDay*(numOfDays-i))
	Next
	DateTime.DateFormat = DateTime.DeviceDefaultDateFormat
	For i = 1 To 5
		Dim p As B4XView = xui.CreatePanel("")
		p.Color = backgroundColor
		p.SetLayoutAnimated(0, 0, 0, clv1.AsView.Width, 30dip)
		clv1.Add(p, -1)
	Next
	For i = 1 To 5
		Dim p As B4XView = xui.CreatePanel("")
		p.Color = backgroundColor
		p.SetLayoutAnimated(0, 0, 0, clv2.AsView.Width, 30dip)
		clv2.Add(p, -1)
	Next
	For i = 0 To 23
		Dim p As B4XView = xui.CreatePanel("")
		p.Color = backgroundColor
		p.SetLayoutAnimated(0, 0, 0, clv2.AsView.Width, 30dip)
		Dim tmp As Label
		tmp.Initialize("")
		Dim lbl As B4XView = tmp
		p.AddView(lbl,0,0,clv2.AsView.Width,30dip)
		lbl.Text = $"$2.0{i}"$
		lbl.TextColor = notFocusedTextColor
		lbl.TextSize = 12
		lbl.SetTextAlignment("CENTER","CENTER")
		clv2.Add(p, i)
	Next
	For i = 1 To 5
		Dim p As B4XView = xui.CreatePanel("")
		p.Color = backgroundColor
		p.SetLayoutAnimated(0, 0, 0, clv2.AsView.Width, 30dip)
		clv2.Add(p, -1)
	Next
	
	For i = 1 To 5
		Dim p As B4XView = xui.CreatePanel("")
		p.Color = backgroundColor
		p.SetLayoutAnimated(0, 0, 0, clv3.AsView.Width, 30dip)
		clv3.Add(p, -1)
	Next
	For i = 0 To 59
		Dim p As B4XView = xui.CreatePanel("")
		p.Color = backgroundColor
		p.SetLayoutAnimated(0, 0, 0, clv3.AsView.Width, 30dip)
		Dim tmp As Label
		tmp.Initialize("")
		Dim lbl As B4XView = tmp
		p.AddView(lbl,0,0,clv3.AsView.Width,30dip)
		lbl.Text = $"$2.0{i}"$
		lbl.TextColor = notFocusedTextColor
		lbl.TextSize = 12
		lbl.SetTextAlignment("CENTER","LEFT")
		clv3.Add(p, i)
	Next
	For i = 1 To 5
		Dim p As B4XView = xui.CreatePanel("")
		p.Color = backgroundColor
		p.SetLayoutAnimated(0, 0, 0, clv3.AsView.Width, 30dip)
		clv3.Add(p, -1)
	Next
	
	MoveToInitValues
	
	applyLineColor
End Sub

'Value that will be selected by default
Public Sub SetSelectedValue(init As Long)
	initValue = init
End Sub
Private Sub MoveToInitValues
	Sleep(0)
	For i=0 To clv1.Size-1
		If i+halfIndex1 > clv1.Size-1 Then 
			ScrollChanged1(0)
			Exit
		End If
		If clv1.GetValue(i+halfIndex1) > -1 Then
			If Abs(clv1.GetValue(i+halfIndex1) - initValue) < DateTime.TicksPerDay Then
				If i = clv1.FirstVisibleIndex Then
					clv1_ScrollChanged(clv1.sv.ScrollViewOffsetY)
				End If
				clv1.ScrollToItem(i)
				Exit
			End If
		End If
	Next
	For i=0 To clv2.Size-1
		If i+halfIndex2 > clv2.Size-1 Then 
			ScrollChanged2(0)
			Exit
		End If
		If clv2.GetValue(i+halfIndex2) > -1 Then
			If DateTime.GetHour(initValue) = clv2.GetValue(i+halfIndex2) Then
				If i = clv2.FirstVisibleIndex Then
					clv2_ScrollChanged(clv2.sv.ScrollViewOffsetY)
				End If
				clv2.ScrollToItem(i)
				Exit
			End If
		End If
	Next
	For i=0 To clv3.Size-1
		If i+halfIndex3 > clv3.Size-1 Then 
			ScrollChanged3(0)
			Exit
		End If
		If clv3.GetValue(i+halfIndex3) > -1 Then
			If DateTime.GetMinute(initValue) = clv3.GetValue(i+halfIndex3) Then
				If i = clv3.FirstVisibleIndex Then
					clv3_ScrollChanged(clv3.sv.ScrollViewOffsetY)
				End If
				clv3.ScrollToItem(i)
				Exit
			End If
		End If
	Next
End Sub

'Returns selected value
Public Sub getSelected As Long
	If layoutLoaded = False Then Return -1
'	If snapEnded1 And snapEnded2 And snapEnded3 Then
	Dim date As Long = clv1.GetValue(clv1.FirstVisibleIndex+halfIndex1)
	If date < 0 Then
		If clv1.FirstVisibleIndex+halfIndex2 > 5 Then
			date = clv1.GetValue(clv1.Size-6)
		Else
			date = clv1.GetValue(5)
		End If
	End If
	Dim hour As Int = clv2.GetValue(clv2.FirstVisibleIndex+halfIndex2)
	If hour < 0 Then
		If clv2.FirstVisibleIndex+halfIndex2 > 5 Then
			hour = clv2.GetValue(clv2.Size-6)
		Else
			hour = clv2.GetValue(5)
		End If
	End If
	Dim minute As Int = clv3.GetValue(clv3.FirstVisibleIndex+halfIndex3)
	If minute < 0 Then
		If clv3.FirstVisibleIndex+halfIndex2 > 5 Then
			minute = clv3.GetValue(clv3.Size-6)
		Else
			minute = clv3.GetValue(5)
		End If
	End If
	DateTime.DateFormat = "MM/dd/yyyy HH:mm"
	Dim parsed As Long = DateTime.DateParse($"${DateTime.GetMonth(date)}/${DateTime.GetDayOfMonth(date)}/${DateTime.GetYear(date)} ${hour}:${minute}"$)
	DateTime.DateFormat = DateTime.DeviceDefaultDateFormat
	Return parsed
'	Else
'		Return -1
'	End If
End Sub

'Returns a list of the selected values, each as a string
Public Sub getSelectedRawValues As List
	Dim response As List
	response.Initialize
	If layoutLoaded = False Then Return response

	Dim valueClv1 As String = clv1.GetPanel(clv1.FirstVisibleIndex+halfIndex1).GetView(0).Text
	Dim valueClv2 As String = clv2.GetPanel(clv2.FirstVisibleIndex+halfIndex2).GetView(0).Text
	Dim valueClv3 As String = clv3.GetPanel(clv3.FirstVisibleIndex+halfIndex3).GetView(0).Text
		
	response.Add(valueClv1)
	response.Add(valueClv2)
	response.Add(valueClv3)
	
	Return response
End Sub

Private Sub clv1_ScrollChanged (Offset As Int)
	'Snap into place
	ScrollChanged1(Offset)
	'Change text color and size
	Dim i As Int = clv1.FirstVisibleIndex
	Dim item As CLVItem	 = clv1.GetRawListItem(i)
	Dim centerIndex As Int = Floor((clv1.sv.Height/item.Size)/2)
	Dim visiblepart As Int =  item.Offset + item.Size - Offset
	If visiblepart / item.Size < 0.5 Then
		i = i+1
	End If
	
	Dim m As Float = (255-80)/(item.Size*1.5-0)
	Dim clr() As Int = GetARGB(notFocusedTextColor)
	For x=Max(0,i-1) To Min(i+(clv1.sv.Height/item.Size),clv1.Size-1)
		If clv1.GetValue(x)>-1 Then
			If x=i+centerIndex Then
				Dim lbl As B4XView = clv1.GetPanel(x).GetView(0)
				lbl.TextColor = focusedTextColor
				lbl.TextSize = 18
			Else
				Dim lbl As B4XView = clv1.GetPanel(x).GetView(0)
				If fadeAwayEffect Then
					Dim item2 As CLVItem	 = clv1.GetRawListItem(x)
					Dim visiblepart2 As Int =  item2.Offset  - Offset
					Dim visibleItems As Int = Floor(clv1.sv.Height/item.Size)
					
					If x > i+centerIndex Then
						visiblepart2 = visibleItems*item2.Size - visiblepart2 - item2.Size
					End If
					visiblepart2 = Min(Max(visiblepart2,0),visibleItems*item2.Size+1)
					
					
					Dim alpha As Int = m*visiblepart2 + 80
					
					lbl.TextColor = xui.Color_ARGB(alpha,clr(0),clr(1),clr(2))
				Else
					lbl.TextColor = notFocusedTextColor
				End If
				lbl.TextSize = 12
			End If
		End If
	Next
End Sub

private Sub clv2_ScrollChanged (Offset As Int)
	ScrollChanged2(Offset)
	Dim i As Int = clv2.FirstVisibleIndex
	Dim item As CLVItem	 = clv2.GetRawListItem(i)
	Dim centerIndex As Int = Floor((clv2.sv.Height/item.Size)/2)
	Dim visiblepart As Int =  item.Offset + item.Size - Offset
	If visiblepart / item.Size < 0.5 Then
		i = i+1
	End If
	
	Dim m As Float = (255-80)/(item.Size*1.5-0)
	Dim clr() As Int = GetARGB(notFocusedTextColor)
	For x=Max(0,i-1) To Min(i+(clv2.sv.Height/item.Size),clv2.Size-1)
		If clv2.GetValue(x)>-1 Then
			If x=i+centerIndex Then
				Dim lbl As B4XView = clv2.GetPanel(x).GetView(0)
				lbl.TextColor = focusedTextColor
				lbl.TextSize = 18
			Else
				Dim lbl As B4XView = clv2.GetPanel(x).GetView(0)
				If fadeAwayEffect Then
					Dim item2 As CLVItem	 = clv2.GetRawListItem(x)
					Dim visiblepart2 As Int =  item2.Offset  - Offset
					Dim visibleItems As Int = Floor(clv2.sv.Height/item.Size)
					
					If x > i+centerIndex Then
						visiblepart2 = visibleItems*item2.Size - visiblepart2 - item2.Size
					End If
					visiblepart2 = Min(Max(visiblepart2,0),visibleItems*item2.Size+1)
					
					Dim alpha As Int = m*visiblepart2 + 80
	
					lbl.TextColor = xui.Color_ARGB(alpha,clr(0),clr(1),clr(2))
				Else
					lbl.TextColor = notFocusedTextColor
				End If
				lbl.TextSize = 12
			End If
		End If
	Next
End Sub

Private Sub clv3_ScrollChanged (Offset As Int)
	ScrollChanged3(Offset)
	Dim i As Int = clv3.FirstVisibleIndex
	Dim item As CLVItem	 = clv3.GetRawListItem(i)
	Dim centerIndex As Int = Floor((clv3.sv.Height/item.Size)/2)
	Dim visiblepart As Int =  item.Offset + item.Size - Offset
	If visiblepart / item.Size < 0.5 Then
		i = i+1
	End If

	Dim m As Float = (255-80)/(item.Size*1.5-0)
	Dim clr() As Int = GetARGB(notFocusedTextColor)
	For x=Max(0,i-1) To Min(i+(clv3.sv.Height/item.Size),clv3.Size-1)
		If clv3.GetValue(x)>-1 Then
			If x=i+centerIndex Then
				Dim lbl As B4XView = clv3.GetPanel(x).GetView(0)
				lbl.TextColor = focusedTextColor
				lbl.TextSize = 18
			Else
				Dim lbl As B4XView = clv3.GetPanel(x).GetView(0)
				If fadeAwayEffect Then
					Dim item2 As CLVItem	 = clv3.GetRawListItem(x)
					Dim visiblepart2 As Int =  item2.Offset  - Offset
					Dim visibleItems As Int = Floor(clv3.sv.Height/item.Size)
					
					If x > i+centerIndex Then
						visiblepart2 = visibleItems*item2.Size - visiblepart2 - item2.Size
					End If
					visiblepart2 = Min(Max(visiblepart2,0),visibleItems*item2.Size+1)
					
					Dim alpha As Int = m*visiblepart2 + 80
					
					lbl.TextColor = xui.Color_ARGB(alpha,clr(0),clr(1),clr(2))
				Else
					lbl.TextColor = notFocusedTextColor
				End If
				lbl.TextSize = 12
			End If
		End If
	Next
End Sub

#Region Code modified from CLVSnap

Private Sub ScrollChanged1 (Offset As Int)
	ScrollChangedIndex1 = ScrollChangedIndex1 + 1
	Dim MyIndex As Int = ScrollChangedIndex1
	Sleep(InactiveDuration)
	If ScrollChangedIndex1 = MyIndex Then
		SnapCLV1(Offset)
	End If
End Sub
Private Sub halfIndex1 As Int
	Dim i As Int = clv1.FirstVisibleIndex
	Dim item As CLVItem	 = clv1.GetRawListItem(i)
	Return Floor((clv1.sv.Height/item.Size)/2)
End Sub
Private Sub SnapCLV1 (Offset As Int)
	Dim i As Int = clv1.FirstVisibleIndex
	Dim item As CLVItem	 = clv1.GetRawListItem(i)
	Dim centerIndex As Int = Floor((clv1.sv.Height/item.Size)/2)
	Dim visiblepart As Int =  item.Offset + item.Size - Offset
	If visiblepart / item.Size < 0.5 Then
		i = i+1
	End If
	Dim diff As Int = 0
	Dim found As Boolean = False
	If i+centerIndex < clv1.Size-1 Then
		If -1 = clv1.Getvalue(i+centerIndex) Then
			For x=(i+centerIndex) To clv1.Size-1
				If clv1.GetValue(x)>-1 Then
					found = True
					diff = x-(i+centerIndex)
					Exit
				End If
			Next
			If found = False Then
				Dim ici As Int = i+centerIndex
				Do While True
					If clv1.GetValue(ici)>-1 Then
						found = True
						diff = ici-(i+centerIndex)
						Exit
					End If
					ici = ici-1
				Loop
			End If
		End If
	End If

	clv1.ScrollToItem(i+diff)

End Sub

Private Sub ScrollChanged2 (Offset As Int)
	ScrollChangedIndex2 = ScrollChangedIndex2 + 1
	Dim MyIndex As Int = ScrollChangedIndex2
	Sleep(InactiveDuration)
	If ScrollChangedIndex2 = MyIndex Then
		SnapCLV2(Offset)
	End If
End Sub
Private Sub halfIndex2 As Int
	Dim i As Int = clv2.FirstVisibleIndex
	Dim item As CLVItem	 = clv2.GetRawListItem(i)
	Return Floor((clv2.sv.Height/item.Size)/2)
End Sub
Private Sub SnapCLV2 (Offset As Int)
	Dim i As Int = clv2.FirstVisibleIndex
	Dim item As CLVItem	 = clv2.GetRawListItem(i)
	Dim centerIndex As Int = Floor((clv2.sv.Height/item.Size)/2)
	Dim visiblepart As Int =  item.Offset + item.Size - Offset
	If visiblepart / item.Size < 0.5 Then
		i = i+1
	End If
	Dim diff As Int = 0
	Dim found As Boolean = False
	If i+centerIndex < clv2.Size-1 Then
		If -1 = clv2.Getvalue(i+centerIndex) Then
			For x=(i+centerIndex) To clv2.Size-1
				If clv2.GetValue(x)>-1 Then
					found = True
					diff = x-(i+centerIndex)
					Exit
				End If
			Next
			If found = False Then
				Dim ici As Int = i+centerIndex
				Do While True
					If clv2.GetValue(ici)>-1 Then
						found = True
						diff = ici-(i+centerIndex)
						Exit
					End If
					ici = ici-1
				Loop
			End If
		End If
	End If

	clv2.ScrollToItem(i+diff)

End Sub

Private Sub ScrollChanged3 (Offset As Int)
	ScrollChangedIndex3 = ScrollChangedIndex3 + 1
	Dim MyIndex As Int = ScrollChangedIndex3
	Sleep(InactiveDuration)
	If ScrollChangedIndex3 = MyIndex Then
		SnapCLV3(Offset)
	End If
End Sub
Private Sub halfIndex3 As Int
	Dim i As Int = clv3.FirstVisibleIndex
	Dim item As CLVItem	 = clv3.GetRawListItem(i)
	Return Floor((clv3.sv.Height/item.Size)/2)
End Sub
Private Sub SnapCLV3 (Offset As Int)
	Dim i As Int = clv3.FirstVisibleIndex
	Dim item As CLVItem	 = clv3.GetRawListItem(i)
	Dim centerIndex As Int = Floor((clv3.sv.Height/item.Size)/2)
	Dim visiblepart As Int =  item.Offset + item.Size - Offset
	If visiblepart / item.Size < 0.5 Then
		i = i+1
	End If
	Dim diff As Int = 0
	Dim found As Boolean = False
	If i+centerIndex < clv3.Size-1 Then
		If -1 = clv3.Getvalue(i+centerIndex) Then
			For x=(i+centerIndex) To clv3.Size-1
				If clv3.GetValue(x)>-1 Then
					found = True
					diff = x-(i+centerIndex)
					Exit
				End If
			Next
			If found = False Then
				Dim ici As Int = i+centerIndex
				Do While True
					If clv3.GetValue(ici)>-1 Then
						found = True
						diff = ici-(i+centerIndex)
						Exit
					End If
					ici = ici-1
				Loop
			End If
		End If
	End If

	clv3.ScrollToItem(i+diff)

End Sub
#End Region

Private Sub GetARGB(Color As Int) As Int()
	Dim res(4) As Int
	res(3) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(0) = Bit.And(Color, 0xff)
	Return res
End Sub




