B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
    Private mNativeView As B4XView
    Private mParent As B4XView
    Private mMountedParent As B4XView
    Private mNaturalWidth As Int
    Private mNaturalHeight As Int
    Private mLeft, mTop, mWidth, mHeight As Int
    Private mMounted As Boolean
End Sub

' Wraps an already initialized native B4A view for use in declarative containers.
' The native view remains owned by the caller; this adapter only mounts,
' lays out and unmounts it.
Public Sub Initialize(NativeView As B4XView, NaturalWidth As Int, NaturalHeight As Int) As UINative
    If mMounted Then Unmount
    mNativeView = NativeView
    mNaturalWidth = Max(0, NaturalWidth)
    mNaturalHeight = Max(0, NaturalHeight)
    mParent = Null
    mMountedParent = Null
    mLeft = 0
    mTop = 0
    mWidth = 0
    mHeight = 0
    mMounted = False
    Return Me
End Sub

' Returns the wrapped native view for direct B4A configuration.
Public Sub GetView As B4XView
    Return mNativeView
End Sub

' Native views keep their own event handlers and styling. This no-op makes the
' adapter compatible with theme propagation through declarative containers.
Public Sub ApplyTheme(Theme As UITheme) As UINative
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

' Native views always participate in layout unless removed by their owner.
Public Sub ParticipatesInLayout As Boolean
    Return True
End Sub

Public Sub Render
    If mNativeView = Null Then Return
    If mNativeView.IsInitialized = False Then Return
    If mParent = Null Then Return
    If mParent.IsInitialized = False Then Return

    Dim targetWidth As Int = mWidth
    Dim targetHeight As Int = mHeight
    If targetWidth < 0 Then targetWidth = 0
    If targetHeight < 0 Then targetHeight = 0

    ' Detect an external detach or reparent so a later declarative render can
    ' recover instead of relying on stale adapter bookkeeping.
    If mMounted Then
		Dim currentParent As B4XView = mNativeView.Parent
		Dim parentChanged As Boolean = False
		If currentParent = Null Then
			parentChanged = True
		Else If mMountedParent = Null Then
			parentChanged = True
		Else If currentParent <> mMountedParent Then
			parentChanged = True
		End If
		If parentChanged Then
			mMounted = False
			mMountedParent = Null
		End If
	End If

    ' A native view can only have one parent. Remove an existing parent before
    ' the first declarative mount as well; this makes wrapping a view that was
    ' previously placed in a traditional panel safe instead of crashing with
    ' Android's "The specified child already has a parent" exception.
    If mMounted = False Then
        If mNativeView.Parent <> Null Then
            If mNativeView.Parent.IsInitialized Then mNativeView.RemoveViewFromParent
        End If
        mParent.AddView(mNativeView, mLeft, mTop, targetWidth, targetHeight)
        mMountedParent = mParent
        mMounted = True
    Else If mMountedParent <> mParent Then
        mNativeView.RemoveViewFromParent
        mParent.AddView(mNativeView, mLeft, mTop, targetWidth, targetHeight)
        mMountedParent = mParent
    Else
        mNativeView.SetLayoutAnimated(0, mLeft, mTop, targetWidth, targetHeight)
    End If
End Sub

' Detaches the native view without destroying or reinitializing it. The caller
' remains responsible for any native event subscriptions and final disposal.
Public Sub Unmount
    If mNativeView <> Null Then
        If mNativeView.IsInitialized Then
            If mMounted Then
                If mNativeView.Parent <> Null Then
                    If mNativeView.Parent.IsInitialized Then mNativeView.RemoveViewFromParent
                End If
            End If
        End If
    End If
    mMounted = False
    mMountedParent = Null
    mParent = Null
End Sub

' Explicit natural dimensions make arbitrary native controls measurable. If
' either dimension is zero, the adapter behaves like a flexible child.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
    Dim result As List
    result.Initialize
    If mNaturalWidth <= 0 Or mNaturalHeight <= 0 Then Return result

    Dim safeMaxWidth As Int = MaxWidth
    Dim safeMaxHeight As Int = MaxHeight
    If safeMaxWidth <= 0 Then safeMaxWidth = 10000
    If safeMaxHeight <= 0 Then safeMaxHeight = 10000
    result.Add(Min(mNaturalWidth, safeMaxWidth))
    result.Add(Min(mNaturalHeight, safeMaxHeight))
    Return result
End Sub