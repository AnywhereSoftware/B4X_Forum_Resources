B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mChildren As List
	Private mAlignment As String
	Private mBaseView As B4XView
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

' Creates an empty stack aligned to the top-left.
Public Sub Initialize As UIStack
	mChildren.Initialize
	mAlignment = "topleft"
	Return Me
End Sub

' Propagates the active theme to every child that supports it.
Public Sub ApplyTheme(Theme As UITheme) As UIStack
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	For Each child As Object In mChildren
		If child <> Null Then
			If SubExists(child, "ApplyTheme") Then CallSub2(child, "ApplyTheme", Theme)
		End If
	Next
	Return Me
End Sub

' Adds one child. Later children are rendered above earlier children.
Public Sub AddChild(Child As Object) As UIStack
	If IsWidgetProtocol(Child) Then mChildren.Add(Child)
	Return Me
End Sub

' Sets the alignment applied to naturally-sized children.
' Accepted values: topLeft, topCenter, topRight, centerLeft, center,
' centerRight, bottomLeft, bottomCenter and bottomRight.
Public Sub Alignment(Value As String) As UIStack
	Dim normalized As String = Value.Trim.ToLowerCase
	If IsValidAlignment(normalized) Then
		mAlignment = normalized
	Else
		mAlignment = "topleft"
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
	mWidth = Max(0, Width)
	mHeight = Max(0, Height)
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
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)

	For Each child As Object In mChildren
		If child = Null Then Continue
		Dim participates As Boolean = IsLayoutParticipant(child)
		Dim size As List = CallSub3(child, "GetContentSize", mWidth, mHeight)
		Dim hasNaturalSize As Boolean = HasMeasuredSize(size)
		Dim childWidth As Int = mWidth
		Dim childHeight As Int = mHeight
		Dim childLeft As Int = 0
		Dim childTop As Int = 0

		If participates = False Then
			CallSub2(child, "SetParent", mBaseView)
			CallSub3(child, "SetPosition", 0, 0)
			CallSub3(child, "SetSize", 0, 0)
			CallSub(child, "Render")
			Continue
		Else If hasNaturalSize Then
			childWidth = Min(Max(0, size.Get(0)), mWidth)
			childHeight = Min(Max(0, size.Get(1)), mHeight)
			GetAlignedPosition(childWidth, childHeight, childLeft, childTop)
		End If

		CallSub2(child, "SetParent", mBaseView)
		CallSub3(child, "SetPosition", childLeft, childTop)
		CallSub3(child, "SetSize", childWidth, childHeight)
		CallSub(child, "Render")
	Next
End Sub

Public Sub Unmount
	For Each child As Object In mChildren
		If child <> Null Then
			If SubExists(child, "Unmount") Then CallSub(child, "Unmount")
		End If
	Next
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then mBaseView.RemoveAllViews
	End If
	mBaseView = Null
	mParent = Null
End Sub

' The stack takes the largest natural child size. If all children are flexible,
' it returns an empty list so its parent can assign the available bounds.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000

	Dim maxChildWidth As Int = 0
	Dim maxChildHeight As Int = 0
	Dim participantCount As Int = 0
	Dim naturalChildCount As Int = 0
	For Each child As Object In mChildren
		If child = Null Then Continue
		Dim participates As Boolean = IsLayoutParticipant(child)
		If participates = False Then Continue
		participantCount = participantCount + 1
		Dim size As List = CallSub3(child, "GetContentSize", safeMaxWidth, safeMaxHeight)
		If HasMeasuredSize(size) Then
			naturalChildCount = naturalChildCount + 1
			maxChildWidth = Max(maxChildWidth, size.Get(0))
			maxChildHeight = Max(maxChildHeight, size.Get(1))
		End If
	Next

	If participantCount > 0 And naturalChildCount = 0 Then
		Dim flexibleSize As List
		flexibleSize.Initialize
		Return flexibleSize
	End If
	result.Add(Min(maxChildWidth, safeMaxWidth))
	result.Add(Min(maxChildHeight, safeMaxHeight))
	Return result
End Sub

Private Sub GetAlignedPosition(ChildWidth As Int, ChildHeight As Int, Left As Int, Top As Int)
	Left = 0
	Top = 0
	Select Case mAlignment
		Case "topcenter"
			Left = (mWidth - ChildWidth) / 2
		Case "topright"
			Left = mWidth - ChildWidth
		Case "centerleft"
			Top = (mHeight - ChildHeight) / 2
		Case "center"
			Left = (mWidth - ChildWidth) / 2
			Top = (mHeight - ChildHeight) / 2
		Case "centerright"
			Left = mWidth - ChildWidth
			Top = (mHeight - ChildHeight) / 2
		Case "bottomcenter"
			Left = (mWidth - ChildWidth) / 2
			Top = mHeight - ChildHeight
		Case "bottomright"
			Left = mWidth - ChildWidth
			Top = mHeight - ChildHeight
		Case "bottomleft"
			Top = mHeight - ChildHeight
		' topleft is the default: Left = 0, Top = 0.
	End Select
	Left = Max(0, Left)
	Top = Max(0, Top)
End Sub

Private Sub IsValidAlignment(Value As String) As Boolean
	Return Value = "topleft" Or Value = "topcenter" Or Value = "topright" _
		Or Value = "centerleft" Or Value = "center" Or Value = "centerright" _
		Or Value = "bottomleft" Or Value = "bottomcenter" Or Value = "bottomright"
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

Private Sub HasMeasuredSize(Size As List) As Boolean
	If Size = Null Then Return False
	If Size.IsInitialized = False Then Return False
	Return Size.Size >= 2
End Sub