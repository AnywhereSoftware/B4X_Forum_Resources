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
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	xui.RegisterDesignerClass(Me)
	dd.Initialize
	xui.RegisterDesignerClass(dd)
	PresetValues.Initialize
	Root.LoadLayout("MainPage")
	For Each p As B4XView In dd.GetViewsByClass("numpad")
		p.LoadLayout("Numpad")
	Next
End Sub

Private Sub ScaleNumpad(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		'store the preset values
		For Each view As B4XView In DesignerArgs.Views
			PresetValues.Put(view, Array As Int(view.Left, view.Top, view.Width, view.Height, IIf(view Is Button, view.TextSize, 0)))
		Next
	End If
	Dim MainParent As B4XView = dd.GetViewByName(DesignerArgs.Parent, "Pane1")
	Dim MainPreset() As Int = PresetValues.Get(MainParent)
	If DesignerArgs.ParentWidth < 5 Or DesignerArgs.ParentHeight < 5 Then Return
	Dim ScaleX As Float = DesignerArgs.ParentWidth / MainPreset(2)
	Dim ScaleY As Float = DesignerArgs.ParentHeight / MainPreset(3)
	Dim TextScale As Float = Min(ScaleX, ScaleY)
	MainParent.SetLayoutAnimated(0, 0, 0, MainPreset(2) * ScaleX, MainPreset(3) * ScaleY)
	For i = 0 To MainParent.NumberOfViews - 1
		Dim btn As B4XView = MainParent.GetView(i)
		Dim preset() As Int = PresetValues.Get(btn)
		btn.SetLayoutAnimated(0, preset(0) * ScaleX, preset(1) * ScaleY, preset(2) * ScaleX, preset(3) * ScaleY)
		btn.TextSize = preset(4) * TextScale
	Next
End Sub
