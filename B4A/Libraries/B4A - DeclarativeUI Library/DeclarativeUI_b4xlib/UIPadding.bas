B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mBridge As UIWidgetBridge
	Private mChild As Object
	Private mBaseView As B4XView
	Private mTop, mBottom, mLeftPad, mRightPad As Int
	Private mParent As B4XView
	Private mLeft, mTopCoord, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UIPadding
	mBridge.Initialize
	mTop = 0 : mBottom = 0 : mLeftPad = 0 : mRightPad = 0
	mChild = Null
	Return Me
End Sub

Public Sub All(Value As Int) As UIPadding
	mTop = Value : mBottom = Value : mLeftPad = Value : mRightPad = Value
	Return Me
End Sub

' Sets equal horizontal insets, similar to Flutter EdgeInsets.symmetric.
Public Sub Horizontal(Value As Int) As UIPadding
	mLeftPad = Value
	mRightPad = Value
	Return Me
End Sub

' Sets equal vertical insets, similar to Flutter EdgeInsets.symmetric.
Public Sub Vertical(Value As Int) As UIPadding
	mTop = Value
	mBottom = Value
	Return Me
End Sub

' Sets each inset independently, similar to Flutter EdgeInsets.only.
Public Sub Only(Left As Int, Top As Int, Right As Int, Bottom As Int) As UIPadding
	mLeftPad = Left
	mTop = Top
	mRightPad = Right
	mBottom = Bottom
	Return Me
End Sub

Public Sub Child(c As Object) As UIPadding
	If IsWidgetProtocol(c) Then mChild = c
	Return Me
End Sub

' Propagates the active theme to the wrapped child.
Public Sub ApplyTheme(Theme As UITheme) As UIPadding
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	If mChild <> Null Then
		If SubExists(mChild, "ApplyTheme") Then CallSub2(mChild, "ApplyTheme", Theme)
	End If
	Return Me
End Sub

Public Sub SetParent(Parent As B4XView)
	mParent = Parent
End Sub

Public Sub SetPosition(Left As Int, Top As Int)
	mLeft = Left
	mTopCoord = Top
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
		mParent.AddView(mBaseView, mLeft, mTopCoord, mWidth, mHeight)
	End If
	If mBaseView.Parent <> mParent Then
		If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		mParent.AddView(mBaseView, mLeft, mTopCoord, mWidth, mHeight)
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTopCoord, mWidth, mHeight)
    
	If mChild <> Null Then
		Dim childLeft As Int = mLeftPad
		Dim childTop As Int = mTop
		Dim childWidth As Int = mWidth - mLeftPad - mRightPad
		Dim childHeight As Int = mHeight - mTop - mBottom
        
		Dim safeChildLeft As Int = Max(0, childLeft)
		Dim safeChildTop As Int = Max(0, childTop)
		Dim safeChildWidth As Int = Max(0, childWidth)
		Dim safeChildHeight As Int = Max(0, childHeight)
		mBridge.SetParent(mChild, mBaseView)
		mBridge.SetPosition(mChild, safeChildLeft, safeChildTop)
		mBridge.SetSize(mChild, safeChildWidth, safeChildHeight)
		mBridge.Render(mChild)
	End If
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
	If mChild <> Null Then
		mBridge.Unmount(mChild)
	End If
	mBaseView = Null
	mParent = Null
End Sub

' Natural measurement used by parent layout containers.
' Measure the child and add padding to obtain the total size.
Private Sub IsWidgetProtocol(Widget As Object) As Boolean
	Return mBridge.IsWidgetProtocol(Widget)
End Sub

Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	
	If mChild <> Null Then
		Dim childMaxW As Int = Max(0, safeMaxWidth - mLeftPad - mRightPad)
		Dim childMaxH As Int = Max(0, safeMaxHeight - mTop - mBottom)
		
		Dim childSize As List = mBridge.GetContentSize(mChild, childMaxW, childMaxH)
		If mBridge.LastCallSucceeded = False Then
			' Preserve the minimum size defined by the configured insets.
			result.Add(Min(mLeftPad + mRightPad, safeMaxWidth))
			result.Add(Min(mTop + mBottom, safeMaxHeight))
			Return result
		End If
		If childSize <> Null Then
			If childSize.IsInitialized Then
				If childSize.Size >= 2 Then
					result.Add(Min(childSize.Get(0) + mLeftPad + mRightPad, safeMaxWidth))
					result.Add(Min(childSize.Get(1) + mTop + mBottom, safeMaxHeight))
					Return result
				End If
			End If
		End If
	End If
	
	' Without a child, padding defines the minimum size.
	result.Add(Min(mLeftPad + mRightPad, safeMaxWidth))
	result.Add(Min(mTop + mBottom, safeMaxHeight))
	Return result
End Sub