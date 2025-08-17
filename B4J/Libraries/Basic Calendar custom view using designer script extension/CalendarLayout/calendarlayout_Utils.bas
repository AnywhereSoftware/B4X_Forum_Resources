B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private Xui As XUI
	Dim CanvX As B4XCanvas
	Dim CanvXDays As B4XCanvas
	Private mLineColor As Int
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub setLineColor(Color As Int)
	mLineColor = Color
End Sub


Public Sub LayoutCalendar(DesignerArgs As DesignerArgs)
	
	Dim PnCalendar As B4XView = DesignerArgs.GetViewFromArgs(0)
	Dim PnCalendarLines As B4XView = DesignerArgs.GetViewFromArgs(1)
	Dim PnDays As B4XView = DesignerArgs.GetViewFromArgs(2)
	Dim PnDaysLines As B4XView = DesignerArgs.GetViewFromArgs(3)
	
	Dim Width, Height As Double
	
	Width = (PnCalendar.Width - 20) / 7
	Height = (PnCalendar.Height - 20) / 6
	
	Dim X As Double = 10
	Dim Y As Double = 0

	If DesignerArgs.FirstRun Then
		
		CanvX.Initialize(PnCalendarLines)
		CanvXDays.Initialize(PnDaysLines)
		
		Dim Count As Int = 0
		For i = 0 To 5
			For j = 0 To 6
				
				Dim CP As B4XView = Xui.CreatePanel("")
				CP.SetLayoutAnimated(0,0,0,Width,Height)
				CP.LoadLayout("calendarcontent")
				CP.Tag = Count
				PnCalendar.AddView(CP,X,Y,Width,Height)
				X = X + Width
				Count =  Count + 1
			Next
			X = 10
			Y = Y + Height
		Next
	Else
		For i = 0 To PnCalendar.NumberOfViews - 1
			If  i <> 0  And i Mod 7 = 0 Then
				X = 10
				Y = Y + Height
			End If
			PnCalendar.GetView(i).SetLayoutAnimated(0,X,Y,Width,Height)
			X = X + Width
		Next
		
		X = 10
		For i = 0 To PnDays.NumberOfViews - 1
			PnDays.GetView(i).SetLayoutAnimated(0,X,0,Width,30)
			X = X + Width
		Next
	End If
	
	CanvX.ClearRect(CanvX.TargetRect)
	CanvX.Resize(PnCalendarLines.Width,PnCalendarLines.Height)
	
	Y = 0
	X = 10
	For i = 0 To 6
		CanvX.DrawLine(X,Y,X+PnCalendarLines.Width - 20,Y,mLineColor,0.5)
		y = y + Height
	Next
	
	Y = 0
	X = 10
	For i = 0 To 7
		CanvX.DrawLine(X,Y,X,Y + PnCalendarLines.Height - 20,mLineColor,0.5)
		X = X + Width
	Next
	
	CanvX.Invalidate
	
	CanvXDays.ClearRect(CanvXDays.TargetRect)
	CanvXDays.Resize(PnDays.Width,PnDays.Height)
	
	Y = 0
	X = 10
	
	CanvXDays.DrawLine(X,Y,X+PnCalendarLines.Width - 20,Y,mLineColor,0.5)
	
	Y = 0
	X = 10
	For i = 0 To 7
		CanvXDays.DrawLine(X,Y,X,Y + PnDays.Height,mLineColor,0.5)
		X = X + Width
	Next
	
	CanvXDays.Invalidate
End Sub