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
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UIExpanded
	mBridge.Initialize
	mChild = Null
	Return Me
End Sub

Public Sub Child(c As Object) As UIExpanded
	If IsWidgetProtocol(c) Then mChild = c
	Return Me
End Sub

Public Sub GetChild As Object
	Return mChild
End Sub

' Propagates the active theme to the expanded child.
Public Sub ApplyTheme(Theme As UITheme) As UIExpanded
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
		mBridge.SetPosition(mChild, mLeft, mTop)
		mBridge.SetSize(mChild, mWidth, mHeight)
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
' UIExpanded returns an empty list because it wants all remaining space.
' Column and Row use this marker to distribute the remaining space.
Private Sub IsWidgetProtocol(Widget As Object) As Boolean
	Return mBridge.IsWidgetProtocol(Widget)
End Sub

Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	' An empty list represents a flexible size.
	Dim flexibleSize As List
	flexibleSize.Initialize
	Return flexibleSize
End Sub