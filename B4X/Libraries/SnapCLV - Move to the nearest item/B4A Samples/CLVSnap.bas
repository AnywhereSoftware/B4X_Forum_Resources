B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
Sub Class_Globals
	Private ScrollChangedIndex As Int
	Private mCLV As CustomListView
	Private xui As XUI 'ignore
	Public InactiveDuration As Int = 500
End Sub

Public Sub Initialize (CLV As CustomListView)
	mCLV = CLV
End Sub

Public Sub ScrollChanged (Offset As Int)
	ScrollChangedIndex = ScrollChangedIndex + 1
	Dim MyIndex As Int = ScrollChangedIndex
	Sleep(InactiveDuration)
	If ScrollChangedIndex = MyIndex Then
		SnapCLV(Offset)
	End If
End Sub

Private Sub SnapCLV (Offset As Int)
	Dim i As Int = mCLV.FirstVisibleIndex
	If i < 0 Then Return
	If Offset + mCLV.sv.Height >= mCLV.sv.ScrollViewContentHeight Then Return
	Dim item As CLVItem	 = mCLV.GetRawListItem(i)
	Dim visiblepart As Int = item.Offset + item.Size - Offset
	If visiblepart / item.Size > 0.5 Then
		mCLV.ScrollToItem(i)
	Else
		mCLV.ScrollToItem(i + 1)
	End If
End Sub