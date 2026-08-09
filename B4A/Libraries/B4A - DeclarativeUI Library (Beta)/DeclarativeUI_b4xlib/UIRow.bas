B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mChildren As List
	Private mSpacing As Int
	Private mMainAxisSize As String
	Private mMainAxisAlignment As String
	Private mCrossAxisAlignment As String
	Private mBaseView As B4XView
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UIRow
	mChildren.Initialize
	mSpacing = 0
	mMainAxisSize = "max"
	mMainAxisAlignment = "start"
	mCrossAxisAlignment = "stretch"
	Return Me
End Sub

' Propagates the active theme to every child that supports it.
Public Sub ApplyTheme(Theme As UITheme) As UIRow
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	For Each child As Object In mChildren
		If child <> Null Then
			If SubExists(child, "ApplyTheme") Then CallSub2(child, "ApplyTheme", Theme)
		End If
	Next
	Return Me
End Sub

Public Sub AddChild(Component As Object) As UIRow
	If IsWidgetProtocol(Component) Then mChildren.Add(Component)
	Return Me
End Sub

Public Sub Spacing(Value As Int) As UIRow
	mSpacing = Max(0, Value)
	Return Me
End Sub

' Controls whether the row uses its natural width or all assigned width.
' Accepted values: min, max. The default is max.
Public Sub MainAxisSize(Value As String) As UIRow
	Dim normalized As String = Value.Trim.ToLowerCase
	If normalized = "min" Or normalized = "max" Then
		mMainAxisSize = normalized
	Else
		mMainAxisSize = "max"
	End If
	Return Me
End Sub

' Controls how children are distributed along the horizontal axis.
' Accepted values: start, center, end, spaceBetween, spaceAround, spaceEvenly.
Public Sub MainAxisAlignment(Value As String) As UIRow
	Dim normalized As String = Value.Trim.ToLowerCase
	If normalized = "center" Or normalized = "end" Or normalized = "spacebetween" Or normalized = "spacearound" Or normalized = "spaceevenly" Then
		mMainAxisAlignment = normalized
	Else
		mMainAxisAlignment = "start"
	End If
	Return Me
End Sub

' Controls how children are aligned across the vertical axis.
' Accepted values: stretch, start, center, end.
Public Sub CrossAxisAlignment(Value As String) As UIRow
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
		mBaseView.Color = Colors.Transparent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	If mChildren.Size = 0 Then
		Dim emptyWidth As Int = mWidth
		If mMainAxisSize = "min" Then emptyWidth = 0
		mBaseView.SetLayoutAnimated(0, mLeft, mTop, emptyWidth, mHeight)
		Return
	End If
    
	' First pass: measure children and classify flexible items.
	' Measure every child and classify flexible items.
	Dim expandedCount As Int = 0
	Dim totalNaturalWidth As Int = 0
	Dim participantCount As Int = 0
	
	For Each child As Object In mChildren
		Dim participates As Boolean = IsLayoutParticipant(child)
		If participates Then participantCount = participantCount + 1
		Dim size As List = CallSub3(child, "GetContentSize", mWidth, mHeight)
		Dim hasNaturalSize As Boolean = False
		If size <> Null Then
			If size.IsInitialized Then
				If size.Size >= 2 Then hasNaturalSize = True
			End If
		End If
		If participates = False Then Continue
		If hasNaturalSize Then
			totalNaturalWidth = totalNaturalWidth + size.Get(0)
		Else
			' An empty list represents flexible space.
			expandedCount = expandedCount + 1
		End If
	Next
	totalNaturalWidth = totalNaturalWidth + mSpacing * Max(0, participantCount - 1)

	' MainAxisSize(min) keeps the container at its natural width.
	' A UIExpanded child needs the assigned width, so max behavior is retained.
	Dim layoutWidth As Int = mWidth
	If mMainAxisSize = "min" And expandedCount = 0 Then
		layoutWidth = Min(mWidth, totalNaturalWidth)
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, layoutWidth, mHeight)
    
	' Fixed children keep their natural size; overflow is clipped by the parent.
	Dim remainingWidth As Int = Max(0, layoutWidth - totalNaturalWidth)
	Dim expandedWidth As Int = 0
	Dim expandedRemainder As Int = 0
	If expandedCount > 0 Then
		expandedWidth = remainingWidth / expandedCount
		expandedRemainder = remainingWidth Mod expandedCount
	End If
	
	' Second pass: position and render each child.
	Dim initialOffset As Int = 0
	Dim layoutSpacing As Int = mSpacing
	If expandedCount = 0 Then
		Dim freeSpace As Int = Max(0, layoutWidth - totalNaturalWidth)
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
	Dim currentLeft As Int = initialOffset
	Dim participantIndex As Int = 0
    
	For Each child As Object In mChildren
		Dim participates As Boolean = IsLayoutParticipant(child)
		Dim currentWidth As Int = 0
		Dim childHeight As Int
		Dim childTop As Int

		Dim size As List = CallSub3(child, "GetContentSize", mWidth, mHeight)
		Dim hasNaturalSize As Boolean = False
		If size <> Null Then
			If size.IsInitialized Then
				If size.Size >= 2 Then hasNaturalSize = True
			End If
		End If
		If participates = False Then
			currentWidth = 0
		Else If hasNaturalSize Then
			currentWidth = size.Get(0) ' Natural width
		Else
			currentWidth = expandedWidth ' Expanded children share the remaining width
			If expandedRemainder > 0 Then
				currentWidth = currentWidth + 1
				expandedRemainder = expandedRemainder - 1
			End If
		End If
        
		If currentWidth < 0 Then currentWidth = 0
		childHeight = mHeight
		childTop = 0
		If participates = False Then childHeight = 0
		If mCrossAxisAlignment <> "stretch" And hasNaturalSize And participates Then
			childHeight = Min(size.Get(1), mHeight)
			If mCrossAxisAlignment = "center" Then
				childTop = (mHeight - childHeight) / 2
			Else If mCrossAxisAlignment = "end" Then
				childTop = mHeight - childHeight
			End If
		End If
        
		If child <> Null Then
			CallSub2(child, "SetParent", mBaseView)
			CallSub3(child, "SetPosition", currentLeft, childTop)
			CallSub3(child, "SetSize", currentWidth, childHeight)
			CallSub(child, "Render")
		End If
        
		currentLeft = currentLeft + currentWidth
		If participates Then
			participantIndex = participantIndex + 1
			If participantIndex < participantCount Then currentLeft = currentLeft + layoutSpacing
		End If
	Next
End Sub

Public Sub Unmount
	For Each child As Object In mChildren
		If child <> Null Then
			If SubExists(child, "Unmount") Then CallSub(child, "Unmount")
		End If
	Next
	mBaseView = Null
	mParent = Null
End Sub

' Natural measurement used by parent layout containers.
' Row width is the sum of child widths and height is the tallest child.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	
	Dim totalNaturalWidth As Int = 0
	Dim maxChildHeight As Int = 0
	Dim hasExpanded As Boolean = False
	Dim naturalChildCount As Int = 0
	Dim participantCount As Int = 0
	
	For Each child As Object In mChildren
		Dim participates As Boolean = IsLayoutParticipant(child)
		If participates Then participantCount = participantCount + 1
		Dim size As List = CallSub3(child, "GetContentSize", safeMaxWidth, safeMaxHeight)
		Dim hasNaturalSize As Boolean = False
		If size <> Null Then
			If size.IsInitialized Then
				If size.Size >= 2 Then hasNaturalSize = True
			End If
		End If
		If participates = False Then Continue
		If hasNaturalSize Then
			totalNaturalWidth = totalNaturalWidth + size.Get(0)
			maxChildHeight = Max(maxChildHeight, size.Get(1))
			naturalChildCount = naturalChildCount + 1
		Else
			hasExpanded = True
		End If
	Next
	totalNaturalWidth = totalNaturalWidth + mSpacing * Max(0, participantCount - 1)
	
	' If every child is flexible, return the flexible marker.
	If participantCount > 0 And hasExpanded And naturalChildCount = 0 Then
		Dim flexibleSize As List
		flexibleSize.Initialize
		Return flexibleSize
	End If
	
	' With flexible children, the natural width is the minimum required width.
	' Without flexible children, the natural width is the total child width.
	result.Add(Min(totalNaturalWidth, safeMaxWidth))
	result.Add(Min(maxChildHeight, safeMaxHeight))
	Return result
End Sub

Private Sub IsWidgetProtocol(Widget As Object) As Boolean
	If Widget = Null Then Return False
	Return SubExists(Widget, "SetParent") And SubExists(Widget, "SetPosition") _
		And SubExists(Widget, "SetSize") And SubExists(Widget, "Render") _
		And SubExists(Widget, "GetContentSize")
End Sub

Private Sub IsLayoutParticipant(Child As Object) As Boolean
	If Child = Null Then Return False
	If SubExists(Child, "ParticipatesInLayout") Then
		Dim result As Boolean = CallSub(Child, "ParticipatesInLayout")
		Return result
	End If
	Return True
End Sub