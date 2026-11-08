B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mBridge As UIWidgetBridge
	Private mChildren As List
	Private mSpacing As Int
	Private mMainAxisSize As String
	Private mMainAxisAlignment As String
	Private mCrossAxisAlignment As String
	Private mBaseView As B4XView
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UIColumn
	mBridge.Initialize
	mChildren.Initialize
	mSpacing = 0
	mMainAxisSize = "max"
	mMainAxisAlignment = "start"
	mCrossAxisAlignment = "stretch"
	Return Me
End Sub

' Propagates the active theme to every child that supports it.
Public Sub ApplyTheme(Theme As UITheme) As UIColumn
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	For Each child As Object In mChildren
		If child <> Null Then
			If SubExists(child, "ApplyTheme") Then CallSub2(child, "ApplyTheme", Theme)
		End If
	Next
	Return Me
End Sub

Public Sub AddChild(child As Object) As UIColumn
	If child = Null Then
		mBridge.ReportError("UIColumn.AddChild", child, "child is Null; pass a widget created by UI.*")
		Return Me
	End If
	If IsWidgetProtocol(child) = False Then
		mBridge.ReportError("UIColumn.AddChild", child, "the object does not implement the widget protocol (SetParent/SetPosition/SetSize/Render/GetContentSize); create widgets with UI.*")
		Return Me
	End If
	If UI.RegisterChild(child, Me) = False Then Return Me
	mChildren.Add(child)
	Return Me
End Sub

Public Sub Spacing(Value As Int) As UIColumn
	mSpacing = Max(0, Value)
	Return Me
End Sub

' Controls whether the column uses its natural height or all assigned height.
' Accepted values: min, max. The default is max.
Public Sub MainAxisSize(Value As String) As UIColumn
	Dim normalized As String = Value.Trim.ToLowerCase
	If normalized = "min" Or normalized = "max" Then
		mMainAxisSize = normalized
	Else
		mMainAxisSize = "max"
	End If
	Return Me
End Sub

' Controls how children are distributed along the vertical axis.
' Accepted values: start, center, end, spaceBetween, spaceAround, spaceEvenly.
Public Sub MainAxisAlignment(Value As String) As UIColumn
	Dim normalized As String = Value.Trim.ToLowerCase
	If normalized = "center" Or normalized = "end" Or normalized = "spacebetween" Or normalized = "spacearound" Or normalized = "spaceevenly" Then
		mMainAxisAlignment = normalized
	Else
		mMainAxisAlignment = "start"
	End If
	Return Me
End Sub

' Controls how children are aligned across the horizontal axis.
' Accepted values: stretch, start, center, end.
Public Sub CrossAxisAlignment(Value As String) As UIColumn
	Dim normalized As String = Value.Trim.ToLowerCase
	If normalized = "start" Or normalized = "center" Or normalized = "end" Or normalized = "stretch" Then
		mCrossAxisAlignment = normalized
	Else
		mCrossAxisAlignment = "stretch"
	End If
	Return Me
End Sub

Public Sub SetParent(Parent As B4XView)
	mParent = Parent
End Sub

Public Sub SetPosition(Left As Int, Top As Int)
	mLeft = Left
	mTop = Top
End Sub

Public Sub SetSize(Width As Int, Height As Int)
	mWidth = Width
	mHeight = Height
End Sub

Public Sub Render
	If mParent = Null Then Return
	If mParent.IsInitialized = False Then Return

	' Create the native container when needed.
	Dim needsCreate As Boolean = False
	If mBaseView = Null Then
		needsCreate = True
	Else If mBaseView.IsInitialized = False Then
		needsCreate = True
	End If
	If needsCreate Then
		Dim pnl As Panel
		pnl.Initialize("")
		mBaseView = pnl
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	If mBaseView.Parent <> mParent Then
		If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	If mChildren.Size = 0 Then
		Dim emptyHeight As Int = mHeight
		If mMainAxisSize = "min" Then emptyHeight = 0
		mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, emptyHeight)
		Return
	End If
	
	' First pass: measure children and classify flexible items.
	' Measure every child through GetContentSize.
	Dim totalNaturalHeight As Int = 0
	Dim expandedCount As Int = 0
	Dim participantCount As Int = 0
	
	For Each child As Object In mChildren
		Dim participates As Boolean = IsLayoutParticipant(child)
		If participates Then participantCount = participantCount + 1
		Dim size As List = mBridge.GetContentSize(child, mWidth, 0)
		If mBridge.LastCallSucceeded = False Then size = ZeroSize
		Dim hasNaturalSize As Boolean = False
		If size <> Null Then
			If size.IsInitialized Then
				If size.Size >= 2 Then hasNaturalSize = True
			End If
		End If
		If participates = False Then Continue
		If hasNaturalSize Then
			totalNaturalHeight = totalNaturalHeight + size.Get(1)
		Else
			' An empty list represents flexible space.
			expandedCount = expandedCount + 1
		End If
	Next
	totalNaturalHeight = totalNaturalHeight + mSpacing * Max(0, participantCount - 1)

	' MainAxisSize(min) keeps the container at its natural height.
	' A UIExpanded child needs the assigned height, so max behavior is retained.
	Dim layoutHeight As Int = mHeight
	If mMainAxisSize = "min" And expandedCount = 0 Then
		layoutHeight = Min(mHeight, totalNaturalHeight)
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, layoutHeight)
	
	' Distribute remaining height among flexible children.
	' Fixed children keep their natural size; overflow is clipped by the parent.
	Dim remainingHeight As Int = Max(0, layoutHeight - totalNaturalHeight)
	Dim expandedHeight As Int = 0
	Dim expandedRemainder As Int = 0
	If expandedCount > 0 Then
		expandedHeight = remainingHeight / expandedCount
		expandedRemainder = remainingHeight Mod expandedCount
	End If
	
	' Second pass: position and render each child.
	Dim initialOffset As Int = 0
	Dim layoutSpacing As Int = mSpacing
	If expandedCount = 0 Then
		Dim freeSpace As Int = Max(0, layoutHeight - totalNaturalHeight)
		Select Case mMainAxisAlignment
			Case "center"
				initialOffset = freeSpace / 2
			Case "end"
				initialOffset = freeSpace
			Case "spacebetween"
				If participantCount > 1 Then layoutSpacing = mSpacing + freeSpace / (participantCount - 1)
			Case "spacearound"
				If participantCount > 0 Then
					layoutSpacing = mSpacing + freeSpace / participantCount
					initialOffset = (layoutSpacing - mSpacing) / 2
				End If
			Case "spaceevenly"
				If participantCount > 0 Then
					layoutSpacing = mSpacing + freeSpace / (participantCount + 1)
					initialOffset = layoutSpacing - mSpacing
				End If
		End Select
	End If
	Dim yOffset As Int = initialOffset
	Dim participantIndex As Int = 0
	For Each child As Object In mChildren
		Dim participates As Boolean = IsLayoutParticipant(child)
		Dim childHeight As Int
		Dim childWidth As Int
		Dim childLeft As Int

		
		Dim size As List = mBridge.GetContentSize(child, mWidth, 0)
		If mBridge.LastCallSucceeded = False Then size = ZeroSize
		Dim hasNaturalSize As Boolean = False
		If size <> Null Then
			If size.IsInitialized Then
				If size.Size >= 2 Then hasNaturalSize = True
			End If
		End If
		If participates = False Then
			childHeight = 0
		Else If hasNaturalSize Then
			childHeight = size.Get(1) ' Altura natural
		Else
			childHeight = expandedHeight ' Espacio flexible
			If expandedRemainder > 0 Then
				childHeight = childHeight + 1
				expandedRemainder = expandedRemainder - 1
			End If
		End If
		
		If childHeight < 0 Then childHeight = 0
		childWidth = mWidth
		childLeft = 0
		If participates = False Then childWidth = 0
		If mCrossAxisAlignment <> "stretch" And hasNaturalSize And participates Then
			childWidth = Min(size.Get(0), mWidth)
			If mCrossAxisAlignment = "center" Then
				childLeft = (mWidth - childWidth) / 2
			Else If mCrossAxisAlignment = "end" Then
				childLeft = mWidth - childWidth
			End If
		End If
		
		mBridge.SetParent(child, mBaseView)
		mBridge.SetPosition(child, childLeft, yOffset)
		mBridge.SetSize(child, childWidth, childHeight)
		mBridge.Render(child)
		yOffset = yOffset + childHeight
		If participates Then
			participantIndex = participantIndex + 1
			If participantIndex < participantCount Then yOffset = yOffset + layoutSpacing
		End If
	Next
End Sub

Public Sub Detach
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then
			If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		End If
	End If
	mParent = Null
End Sub

Public Sub Unmount
	For Each child As Object In mChildren
		If child <> Null Then
			mBridge.Unmount(child)
			UI.UnregisterChild(child)
		End If
	Next
	mBaseView = Null
	mParent = Null
End Sub

' Natural measurement used by parent layout containers.
' Column width is the widest child and height is the sum of child heights.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	
	Dim maxChildWidth As Int = 0
	Dim totalChildHeight As Int = 0
	Dim allExpanded As Boolean = True
	Dim participantCount As Int = 0
	
	For Each child As Object In mChildren
		Dim participates As Boolean = IsLayoutParticipant(child)
		If participates Then participantCount = participantCount + 1
		Dim size As List = mBridge.GetContentSize(child, safeMaxWidth, 0)
		If mBridge.LastCallSucceeded = False Then size = ZeroSize
		Dim hasNaturalSize As Boolean = False
		If size <> Null Then
			If size.IsInitialized Then
				If size.Size >= 2 Then hasNaturalSize = True
			End If
		End If
		If participates = False Then Continue
		If hasNaturalSize Then
			allExpanded = False
			maxChildWidth = Max(maxChildWidth, size.Get(0))
			totalChildHeight = totalChildHeight + size.Get(1)
		End If
	Next
	totalChildHeight = totalChildHeight + mSpacing * Max(0, participantCount - 1)
	
	If participantCount > 0 And allExpanded Then
		Dim flexibleSize As List
		flexibleSize.Initialize
		Return flexibleSize
	End If
	
	result.Add(Min(maxChildWidth, safeMaxWidth))
	result.Add(Min(totalChildHeight, safeMaxHeight))
	Return result
End Sub

Private Sub ZeroSize As List
	Dim result As List
	result.Initialize
	result.Add(0)
	result.Add(0)
	Return result
End Sub

Private Sub IsWidgetProtocol(Widget As Object) As Boolean
	Return mBridge.IsWidgetProtocol(Widget)
End Sub

Private Sub IsLayoutParticipant(Child As Object) As Boolean
	Return mBridge.IsLayoutParticipant(Child)
End Sub