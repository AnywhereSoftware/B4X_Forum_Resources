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
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UICenter
	mBridge.Initialize
	mChild = Null
	Return Me
End Sub

Public Sub Child(c As Object) As UICenter
	If IsWidgetProtocol(c) Then mChild = c
	Return Me
End Sub

' Propagates the active theme to the centered child.
Public Sub ApplyTheme(Theme As UITheme) As UICenter
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
	If mBaseView.Parent <> mParent Then
		If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
    
	If mChild <> Null Then
		' Measure the child so it can be centered using its natural size.
		' Ask the child for its natural size.
		Dim childSize As List = mBridge.GetContentSize(mChild, mWidth, mHeight)
		If mBridge.LastCallSucceeded = False Then childSize = ZeroSize
		
		Dim childWidth As Int = mWidth
		Dim childHeight As Int = mHeight
		
		Dim hasNaturalSize As Boolean = False
		If childSize <> Null Then
			If childSize.IsInitialized Then
				If childSize.Size >= 2 Then hasNaturalSize = True
			End If
		End If
		If hasNaturalSize Then
			' A measured child can be centered inside the available bounds.
			childWidth = Min(childSize.Get(0), mWidth)
			childHeight = Min(childSize.Get(1), mHeight)
		End If
		
		' Calculate the centered position.
		' Position formula: (container size - child size) / 2.
		Dim childLeft As Int = Max(0, (mWidth - childWidth) / 2)
		Dim childTop As Int = Max(0, (mHeight - childHeight) / 2)
        
		mBridge.SetParent(mChild, mBaseView)
		mBridge.SetPosition(mChild, childLeft, childTop)
		mBridge.SetSize(mChild, childWidth, childHeight)
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
' UICenter delegates natural measurement to its child.
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

Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	If mChild <> Null Then
		Dim result As List = mBridge.GetContentSize(mChild, MaxWidth, MaxHeight)
		If mBridge.LastCallSucceeded = False Then Return ZeroSize
		If result <> Null Then
			If result.IsInitialized Then
				If result.Size >= 2 Then Return result
			End If
		End If
	End If
	Dim flexibleSize As List
	flexibleSize.Initialize
	Return flexibleSize
End Sub