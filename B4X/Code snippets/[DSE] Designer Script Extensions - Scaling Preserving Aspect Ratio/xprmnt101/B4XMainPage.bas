B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=DSExampleNumpad.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private PresetValues As Map
	Private dd As DDD
	
	Private fillProp As Float
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	xui.RegisterDesignerClass(Me)
	dd.Initialize
	xui.RegisterDesignerClass(dd)

	fillProp = .5
	PresetValues.Initialize
	Root.LoadLayout("Numpad")
End Sub

Private Sub ScaleNumpad(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		For Each view As B4XView In DesignerArgs.Views
			PresetValues.Put(view, Array As Int(view.Left, view.Top, view.Width, view.Height, IIf(view Is Button, view.TextSize, 0)))
		Next
	End If
	Dim MainParent As B4XView = dd.GetViewByName(DesignerArgs.Parent, "Pane1")
	Dim MainPreset() As Int = PresetValues.Get(MainParent)
	If DesignerArgs.ParentWidth < 5 Or DesignerArgs.ParentHeight < 5 Then Return
	Dim ScaleX As Float = DesignerArgs.ParentWidth / MainPreset(2)
	Dim ScaleY As Float = DesignerArgs.ParentHeight / MainPreset(3)
	Dim Scale As Float = Min(ScaleX, ScaleY) * fillProp
	Dim w As Float = MainPreset(2) * Scale
	Dim h As Float = MainPreset(3) * Scale
	
	MainParent.SetLayoutAnimated(0, Root.Width / 2 - w /2, Root.Height / 2 - h / 2, w, h)
	For i = 0 To MainParent.NumberOfViews - 1
		Dim btn As B4XView = MainParent.GetView(i)
		Dim preset() As Int = PresetValues.Get(btn)
		btn.SetLayoutAnimated(0, preset(0) * Scale, preset(1) * Scale, preset(2) * Scale, preset(3) * Scale)
		btn.TextSize = Max(12, Min(30, preset(4) * Scale))		'prevent text from getting too small or too big
	Next

End Sub

Private Sub button_Click
	Dim btn As B4XView = Sender
	Log(btn.Text)
End Sub
