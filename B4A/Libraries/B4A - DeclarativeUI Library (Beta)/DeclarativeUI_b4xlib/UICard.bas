B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mChild As Object
	Private mBaseView As B4XView
	Private mBgColor As Int
	Private mBorderColor As Int
	Private mBgColorOverridden As Boolean
	Private mBorderColorOverridden As Boolean
	Private mTheme As UITheme
	Private mRadius As Int
	Private mRadiusOverridden As Boolean
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UICard
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mBgColor = mTheme.Surface
	mBorderColor = mTheme.Border
	mBgColorOverridden = False
	mBorderColorOverridden = False
	mRadius = mTheme.CardRadius
	mRadiusOverridden = False
	mChild = Null
	Return Me
End Sub

Public Sub BackgroundColor(c As Int) As UICard
	mBgColor = c
	mBgColorOverridden = True
	Return Me
End Sub

Public Sub BorderColor(c As Int) As UICard
	mBorderColor = c
	mBorderColorOverridden = True
	Return Me
End Sub

' Applies theme defaults without replacing explicit color overrides.
Public Sub ApplyTheme(Theme As UITheme) As UICard
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mBgColorOverridden = False Then mBgColor = mTheme.Surface
	If mBorderColorOverridden = False Then mBorderColor = mTheme.Border
	If mRadiusOverridden = False Then mRadius = mTheme.CardRadius
	' A card is a composition boundary: theme its nested content as well.
	If mChild <> Null Then
		If SubExists(mChild, "ApplyTheme") Then CallSub2(mChild, "ApplyTheme", Theme)
	End If
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
	Return Me
End Sub

Public Sub CornerRadius(r As Int) As UICard
	mRadius = Max(0, r)
	mRadiusOverridden = True
	Return Me
End Sub

Public Sub Child(c As Object) As UICard
	If IsWidgetProtocol(c) Then mChild = c
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
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
    
	Dim NativePanel As Panel = mBaseView
	Dim cd As ColorDrawable
	cd.Initialize2(mBgColor, mRadius, mTheme.BorderWidth, mBorderColor)
	NativePanel.Background = cd
    
	If mChild <> Null Then
		CallSub2(mChild, "SetParent", mBaseView)
		CallSub3(mChild, "SetPosition", 0, 0)
		CallSub3(mChild, "SetSize", mWidth, mHeight)
		CallSub(mChild, "Render")
	End If
End Sub

' Returns the mounted native view for opt-in transitions such as UIAnimation.
' The view is available after the card has been rendered.
Public Sub GetView As B4XView
	If mBaseView = Null Then Return Null
	If mBaseView.IsInitialized = False Then Return Null
	Return mBaseView
End Sub

Public Sub Unmount
	If mChild <> Null Then
		If SubExists(mChild, "Unmount") Then CallSub(mChild, "Unmount")
	End If
	mBaseView = Null
	mParent = Null
End Sub

' Natural measurement used by parent layout containers.
' UICard measures its child and reserves its internal margin.
Private Sub IsWidgetProtocol(Widget As Object) As Boolean
	If Widget = Null Then Return False
	Return SubExists(Widget, "SetParent") And SubExists(Widget, "SetPosition") _
		And SubExists(Widget, "SetSize") And SubExists(Widget, "Render") _
		And SubExists(Widget, "GetContentSize")
End Sub

Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	
	If mChild <> Null Then
		' Measure the child with space reserved for the card margin.
		Dim childMargin As Int = mTheme.CardPadding
		Dim childMaxW As Int = Max(0, safeMaxWidth - 2 * childMargin)
		Dim childMaxH As Int = Max(0, safeMaxHeight - 2 * childMargin)
		
		Dim childSize As List = CallSub3(mChild, "GetContentSize", childMaxW, childMaxH)
		If childSize <> Null Then
			If childSize.IsInitialized Then
				If childSize.Size >= 2 Then
					result.Add(Min(childSize.Get(0) + 2 * childMargin, safeMaxWidth))
					result.Add(Min(childSize.Get(1) + 2 * childMargin, safeMaxHeight))
					Return result
				End If
			End If
		End If
	End If
	
	' A missing child or flexible child uses the available space.
	result.Add(safeMaxWidth)
	result.Add(safeMaxHeight)
	Return result
End Sub