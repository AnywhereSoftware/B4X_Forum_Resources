B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private mBaseView As B4XView
	Private mColor As Int
	Private mColorOverridden As Boolean
	Private mTheme As UITheme
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UIDivider
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mColor = mTheme.Divider
	mColorOverridden = False
	Return Me
End Sub

Public Sub Color(c As Int) As UIDivider
	mColor = c
	mColorOverridden = True
	Return Me
End Sub

Public Sub ApplyTheme(Theme As UITheme) As UIDivider
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mColorOverridden = False Then mColor = mTheme.Divider
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
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
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTop + 8dip, mWidth, 1dip)
	mBaseView.Color = mColor
End Sub

Public Sub Unmount
	mBaseView = Null
	mParent = Null
End Sub

' Natural measurement used by parent layout containers.
' UIDivider uses the full available width and a one-dip line.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	
	Dim dividerHeight As Int = 1dip
	
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	
	result.Add(safeMaxWidth) ' Use the full available width.
	result.Add(Min(dividerHeight + 16dip, safeMaxHeight)) ' Include vertical breathing room around the line.
	Return result
End Sub