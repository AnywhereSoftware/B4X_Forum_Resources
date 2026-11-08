B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip

'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\%PROJECT_NAME%.b4a 
'B4i ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4i\%PROJECT_NAME%.b4i 
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\%PROJECT_NAME%.b4j

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Private PieChart1 As xChartLite
	Private LineChart1, LineChart2  As xChartLite
	Private BarChart1, BarChart2 As xChartLite
	Private StackedBarChart1 As xChartLite
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Main")
	
	B4XPages.SetTitle(Me, "xChartLiteDemo")

#If B4i
	Sleep(1000)		'needed in B4i, I do not know why.
#End If

	btnLinePieCharts_Click	
End Sub

Sub CreatePieData
	PieChart1.ClearData
	
	Private i, Values(4) As Int
	
	For i = 0 To 3
		Values(i) = Rnd(50, 501)
	Next

	' initialize the pie chart data
	PieChart1.AddPie("Slice #1", Values(0), xui.Color_Blue) '0 = random color
	PieChart1.AddPie("Slice #2", Values(1), xui.Color_Red)
	PieChart1.AddPie("Slice #3", Values(2), xui.Color_Yellow)
	PieChart1.AddPie("Slice #4", Values(3), xui.Color_Cyan)
	PieChart1.GradientColorsAlpha = 48

	PieChart1.DrawChart
End Sub

Private Sub CreateLineChart1Data
	' clear previous data
	LineChart1.ClearData
	LineChart1.DisplayValuesOnHover = True	'displayes the item values when hovering over the chart
	
	' initialize the line data
	LineChart1.AddLine("Random", xui.Color_Blue) '0 = random color
	LineChart1.AddLine("Cos", xui.Color_Red)
	LineChart1.AddLine("Sin", xui.Color_Magenta)
	
	' generate random amplitudes
	Dim Ampl1, Ampl2, Ampl3 As Double
	Ampl1 = Rnd(1, 10001) / 500
	Ampl2 = Rnd(1, 10001) / 500
	Ampl3 = Rnd(1, 10001) / 5002
	' add the line points.
	For i = 0 To 490
		' In the case of 2 lines or more we are adding an array of values.
		' One for each line.
		' Make sure to create an array for each point.
		' You cannot reuse a single array for all points.
		LineChart1.AddLineMultiplePoints(i, Array As Double(Rnd(-100, 101) / 300 * Ampl1 + 5, Ampl2 * CosD(3 * i) + 2, Ampl3 * SinD(i) + 4), i Mod 90 = 0)
	Next

	LineChart1.DrawChart
End Sub

Private Sub CreateLineChart2Data
	' clear previous data
	LineChart2.ClearData
	
	' initialize the line data
	LineChart2.AddLine2("Random", xui.Color_Blue, 2dip, "RHOMBUS", False, xui.Color_Blue)
	LineChart2.AddLine2("Cos", xui.Color_Red, 3dip, "CIRCLE", False, xui.Color_Red)
	LineChart2.AddLine2("Sin", xui.Color_Magenta, 3dip, "SQUARE", False, xui.Color_Magenta)
	
	LineChart2.DifferentScales = True

	' Add the line points.
	Dim Ampl1, Ampl2, Ampl3 As Double
	Ampl1 = Rnd(1, 10001) / 500
	Ampl2 = Rnd(1, 10001) / 500
	Ampl3 = Rnd(1, 10001) / 5002
	For i = 0 To 720 Step 45
		' In the case of 2 lines or more we are adding an array of values.
		' One for each line.
		' Make sure to create an array for each point.
		' You cannot reuse a single array for all points.
		LineChart2.AddLineMultiplePoints(i, Array As Double(Rnd(-100, 101) / 300 * Ampl1 + 5, Ampl2 * CosD(i) + 2, Ampl3 * SinD(i) + 4), i Mod 90 = 0)
	Next

	' draw the chart
	LineChart2.DrawChart
End Sub

Private Sub CreateBarData
	' clear previous data
	BarChart1.ClearData

	' add the bars
	BarChart1.AddBar("Bar 1", xui.Color_Red)
	BarChart1.AddBar("Bar 2", xui.Color_Blue)
	BarChart1.AddBar("Bar 3", xui.Color_Green)
	BarChart1.AddBar("Bar 4", xui.Color_Yellow)
	BarChart1.AddBar("Bar 5", xui.Color_Magenta)

	' add the items
	For i = 0 To 8
		BarChart1.AddBarMultiplePoint(2005 + i, Array As Double(Rnd(-1000, 500), Rnd(-1000, 500), Rnd(-1000, 500), Rnd(-1000, 500), Rnd(-1000, 500)))
	Next
	' draw the chart
	BarChart1.DrawChart
End Sub

Private Sub CreateStackedBarData
	' clear previous data
	StackedBarChart1.ClearData

	' add the bars
	StackedBarChart1.AddBar("Bar 1", xui.Color_Red)
	StackedBarChart1.AddBar("Bar 2", xui.Color_Blue)
	StackedBarChart1.AddBar("Bar 3", xui.Color_Green)
	
	' add the items
	For i = 0 To 100
		StackedBarChart1.AddBarMultiplePoint(2005 + i, Array As Double(Rnd(0, 1000), Rnd(0, 1000), Rnd(0, 1000)))
	Next
	
	' draw the stacked bar chart
	StackedBarChart1.DrawChart
End Sub

Private Sub CreateSingleBarData
	' clear previous data
	BarChart2.ClearData
	
	' initialize the bar color
	BarChart2.AddBar("Bar 1", xui.Color_Red)
	
	' add the items.
	For i = 0 To 8
		BarChart2.AddBarPointData(2005 + i, Rnd(-1000, 1500))
	Next
	
	' draw the chart
	BarChart2.DrawChart
End Sub

Private Sub btnLinePieCharts_Click
	HideCharts
	CreatePieData
	PieChart1.Visible = True

	LineChart1.ClearData
	CreateLineChart1Data
	LineChart1.Visible = True
End Sub

Private Sub btnBarCharts_Click
	HideCharts
	CreateBarData
	BarChart1.Visible = True
	
	CreateStackedBarData
	StackedBarChart1.Visible = True
End Sub

Private Sub btnBarChart_Click
	HideCharts
	CreateSingleBarData
	BarChart2.Visible = True
End Sub

Private Sub btnLineChart_Click
	HideCharts
	CreateLineChart2Data
	LineChart2.Visible = True
End Sub

' hide all chart objects
Private Sub HideCharts
	PieChart1.Visible = False
	BarChart1.Visible = False
	BarChart2.Visible = False
	StackedBarChart1.Visible = False
	LineChart1.Visible = False
	LineChart2.Visible = False
End Sub

