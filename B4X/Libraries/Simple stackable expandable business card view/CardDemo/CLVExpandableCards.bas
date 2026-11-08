B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'version 1.00
Sub Class_Globals
	Type ExpandableCardsItemData (CollapsedHeight As Int, ExpandedHeight As Int, Value As Object, Expanded As Boolean)
	Private mCLV As CustomListView
	Private xui As XUI
End Sub

Public Sub Initialize (CLV As CustomListView)
	mCLV = CLV
End Sub

Public Sub CreateValue(pnl As B4XView, Value As Object) As ExpandableCardsItemData
	Dim e As ExpandableCardsItemData
	e.Initialize
	e.CollapsedHeight = pnl.GetView(1).Height
	e.ExpandedHeight = pnl.GetView(1).Height + pnl.GetView(2).Height
	e.Value = Value
	Return e
End Sub

Public Sub GetValue (Index As Int) As Object
	If mCLV.GetValue(Index) Is ExpandableCardsItemData Then
		Dim e As ExpandableCardsItemData = mCLV.GetValue(Index)
		Return e.Value
	End If
	Return mCLV.GetValue(Index)
End Sub

Public Sub ExpandItem (index As Int, pclr As Int)
	ResizeItem(index, False, pclr)
	Dim item As CLVItem = mCLV.GetRawListItem(index)
	Dim delta As Int = item.Offset + item.Size - mCLV.sv.ScrollViewOffsetY - mCLV.AsView.Height
	If delta > 0 Then
		Sleep(5)
		Dim offset As Int = mCLV.sv.ScrollViewOffsetY + delta
        #if B4i
        Dim nsv As ScrollView = mCLV.sv
        nsv.ScrollTo(0, offset, True)
        #else if B4J 
		mCLV.sv.ScrollViewOffsetY = offset
        #Else If B4A
		Dim nsv As ScrollView = mCLV.sv
		nsv.ScrollPosition = offset
    #End If
	End If
End Sub

Sub CollapseItem(index As Int, pclr As Int)
	ResizeItem(index, True, pclr)
End Sub

private Sub ResizeItem (Index As Int, Collapse As Boolean, pclr As Int)
	Dim item As CLVItem = mCLV.GetRawListItem(Index)
	
	Dim p As B4XView = item.Panel.GetView(0)
	If p.NumberOfViews = 0 Or (item.Value Is ExpandableCardsItemData) = False Then Return
	Dim NewPanel As B4XView = xui.CreatePanel("")
	MoveItemBetweenPanels(p, NewPanel)
	'NewPanel.Color = pclr
	Dim id As ExpandableCardsItemData = item.Value
	id.Expanded = Not(Collapse)
	mCLV.sv.ScrollViewInnerPanel.AddView(NewPanel, 0, item.Offset, p.Width, id.ExpandedHeight)

	If Collapse Then
		AnimatedArrow(180, 0, NewPanel)
		Dim p2 As B4XView = NewPanel.GetView(1)
		SetPanelCornerRadius (p2, 20dip, True, True, False, False)
		Dim CornerPanel As B4XView = NewPanel.Getview (0)
		CornerPanel.Color = pclr
		NewPanel.Color = p2.Color
	Else
		AnimatedArrow(0, 180, NewPanel)
		Dim p2 As B4XView = NewPanel.GetView(1)
		SetPanelCornerRadius (p2, 20dip, True, True, False, False)
		Dim p3 As B4XView = NewPanel.GetView(2)
		SetPanelCornerRadius (p3, 20dip, False, False, False, False)

	End If
	
	Dim NewSize As Int
	If Collapse Then NewSize = id.CollapsedHeight Else NewSize = id.ExpandedHeight
	mCLV.ResizeItem(Index, NewSize)
	NewPanel.SendToBack
	Sleep(mCLV.AnimationDuration)
	
	If p.Parent.IsInitialized Then
		MoveItemBetweenPanels(NewPanel, p)
	End If
	NewPanel.RemoveViewFromParent

End Sub

Private Sub MoveItemBetweenPanels (Src As B4XView, Target As B4XView)
	Do While Src.NumberOfViews > 0
		Dim v As B4XView = Src.GetView(0)
		v.RemoveViewFromParent
		Target.AddView(v, v.Left, v.Top, v.Width, v.Height)
	Loop
End Sub

Private Sub AnimatedArrow(From As Int, ToDegree As Int, Pnl As B4XView)
	Dim title As B4XView = Pnl.GetView(1) 'pnlTitle is the first item
	Dim iv As B4XView = title.GetView(1) 'ImageView1 is the second item
	iv.SetRotationAnimated(0, From)
	iv.SetRotationAnimated(mCLV.AnimationDuration, ToDegree)
End Sub

Public Sub ToggleItem (Index As Int, pclr As Int)
	Dim i As ExpandableCardsItemData = mCLV.GetValue(Index)
	If i.Expanded = True Then
		CollapseItem(Index, pclr)
	Else
		ExpandItem(Index, pclr)
	End If
End Sub

public Sub SetPanelCornerRadius(View As B4XView, CornerRadius As Float,TopLeft As Boolean,TopRight As Boolean,BottomLeft As Boolean,BottomRight As Boolean)
	#If B4I
	'https://www.b4x.com/android/forum/threads/individually-change-corner-radius-of-a-view.127751/post-800352
    View.SetColorAndBorder(View.Color,0,0,CornerRadius)
    Dim CornerSum As Int = IIf(TopLeft,1,0) + IIf(TopRight,2,0) + IIf(BottomLeft,4,0) + IIf(BottomRight,8,0)
    View.As(NativeObject).GetField ("layer").SetField ("maskedCorners", CornerSum)
    #Else If B4A
	'https://www.b4x.com/android/forum/threads/gradientdrawable-with-different-corner-radius.51475/post-322392
	Dim cdw As ColorDrawable
	cdw.Initialize(View.Color, 0)
	View.As(View).Background = cdw
	Dim jo As JavaObject = View.As(View).Background
	If View.As(View).Background Is ColorDrawable Or View.As(View).Background Is GradientDrawable Then
		jo.RunMethod("setCornerRadii", Array As Object(Array As Float(IIf(TopLeft,CornerRadius,0), IIf(TopLeft,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomLeft,CornerRadius,0), IIf(BottomLeft,CornerRadius,0))))
	End If
    #Else If B4J
	'https://www.b4x.com/android/forum/threads/b4x-setpanelcornerradius-only-for-certain-corners.164567/post-1008965
	Dim Corners As String = ""
	Corners = Corners & IIf(TopLeft, CornerRadius, 0) & " "
	Corners = Corners & IIf(TopRight, CornerRadius, 0) & " "
	Corners = Corners & IIf(BottomLeft, CornerRadius, 0) & " "
	Corners = Corners & IIf(BottomRight, CornerRadius, 0)
	CSSUtils.SetStyleProperty(View, "-fx-background-radius", Corners)
    #End If
End Sub
