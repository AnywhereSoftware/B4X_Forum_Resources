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
	Private mPadding As Int
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize(child As Object, padding As Int) As UIBox
	mBridge.Initialize
	If IsWidgetProtocol(child) Then mChild = child
	mPadding = Max(0, padding)
	Return Me
End Sub

' Propagates the active theme to the wrapped child.
Public Sub ApplyTheme(Theme As UITheme) As UIBox
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
	mTop = Top
End Sub

Public Sub SetSize(Width As Int, Height As Int)
	mWidth = Width
	mHeight = Height
End Sub

Public Sub Render
	If mParent = Null Then Return
	If mParent.IsInitialized = False Then Return

	If mChild <> Null Then
		mBridge.SetParent(mChild, mParent)
		mBridge.SetPosition(mChild, mLeft + mPadding, mTop + mPadding)
		mBridge.SetSize(mChild, mWidth - (2 * mPadding), mHeight - (2 * mPadding))
		mBridge.Render(mChild)
	End If
End Sub

Public Sub Detach
	If mChild <> Null Then mBridge.Detach(mChild)
	mParent = Null
End Sub

Public Sub Unmount
	If mChild <> Null Then
		mBridge.Unmount(mChild)
	End If
	mParent = Null
End Sub

' Natural measurement used by parent layout containers.
' UIBox measures its child and adds the configured padding.
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
		Dim childMaxW As Int = Max(0, safeMaxWidth - 2 * mPadding)
		Dim childMaxH As Int = Max(0, safeMaxHeight - 2 * mPadding)
		
		Dim childSize As List = mBridge.GetContentSize(mChild, childMaxW, childMaxH)
		' Preserve UIBox's historical fallback when child measurement fails.
		If mBridge.LastCallSucceeded = False Then
			result.Add(safeMaxWidth)
			result.Add(safeMaxHeight)
			Return result
		End If
		If childSize <> Null Then
			If childSize.IsInitialized Then
				If childSize.Size >= 2 Then
					result.Add(Min(childSize.Get(0) + 2 * mPadding, safeMaxWidth))
					result.Add(Min(childSize.Get(1) + 2 * mPadding, safeMaxHeight))
					Return result
				End If
			End If
		End If
	End If
	
	result.Add(safeMaxWidth)
	result.Add(safeMaxHeight)
	Return result
End Sub