B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' TitleBar - thin form shell for a cross-platform custom title bar window.
' Creates an undecorated Form and hands it to TitleBarHelper, which does all the work
' (header + buttons, move, edge-resize, Aero-snap, theming). This class only owns the Form,
' so it forwards the form-level events (Resize, FocusChanged) to the helper.
'
' Usage:
'   Dim tb As TitleBar
'   tb.Initialize("My Window", 480, 320)
'   tb.RoundedShadow = True            'optional
'   tb.ContentPane.AddView(someView, 20dip, 20dip, 200dip, 30dip)
'   tb.Show
Sub Class_Globals
	Private frm As Form
	Private bar As TitleBarHelper
End Sub

'Creates an undecorated form of the given size with a custom title bar.
Public Sub Initialize (Title As String, Width As Double, Height As Double)
	frm.Initialize("frmTB", Width, Height)	'this class owns the form's events
	frm.Title = Title
	bar.Initialize(frm, Title)
End Sub

Public Sub Show
	bar.Show
End Sub

#region titlebar_delegates
'--- form events -> forwarded to the helper (the form belongs to this module) ---
Private Sub frmTB_Resize (Width As Double, Height As Double)
	bar.OnResize
End Sub

Private Sub frmTB_FocusChanged (HasFocus As Boolean)
	bar.OnFocusChanged(HasFocus)
End Sub

'--- pass-through API (delegates to TitleBarHelper) ---
Public Sub getContentPane As B4XView
	Return bar.ContentPane
End Sub

Public Sub getForm As Form
	Return frm
End Sub

Public Sub getHelper As TitleBarHelper		'escape hatch for less-common helper members
	Return bar
End Sub

Public Sub setTitle (Title As String)
	bar.Title = Title
End Sub

Public Sub setAccentBorder (Enabled As Boolean)
	bar.AccentBorder = Enabled
End Sub

Public Sub getAccentBorder As Boolean
	Return bar.AccentBorder
End Sub

Public Sub setFocusBorder (Enabled As Boolean)
	bar.FocusBorder = Enabled
End Sub

Public Sub getFocusBorder As Boolean
	Return bar.FocusBorder
End Sub

Public Sub setRoundedShadow (Enabled As Boolean)
	bar.RoundedShadow = Enabled
End Sub

Public Sub getRoundedShadow As Boolean
	Return bar.RoundedShadow
End Sub

Public Sub setShowMinimize (ShowMe As Boolean)
	bar.ShowMinimize = ShowMe
End Sub

Public Sub getShowMinimize As Boolean
	Return bar.ShowMinimize
End Sub

Public Sub setShowMaximize (ShowMe As Boolean)
	bar.ShowMaximize = ShowMe
End Sub

Public Sub getShowMaximize As Boolean
	Return bar.ShowMaximize
End Sub
#end region