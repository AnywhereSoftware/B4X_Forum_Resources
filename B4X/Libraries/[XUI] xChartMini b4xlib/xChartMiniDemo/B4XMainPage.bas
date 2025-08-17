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

	Private LineChart1 As xChartMini
	Private BarChart1, BarChart2 As xChartMini
	Private StackedBarChart1 As xChartMini
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Main")
	
	B4XPages.SetTitle(Me, "xChartMiniDemo")

#If B4i
	Sleep(1000)		'needed in B4i, I do not know why.
#End If
	btnLineChart_Click	
End Sub

Private Sub CreateLineChartData
	' clear previous data
	LineChart1.ClearData
	
	' initialize the line data
	LineChart1.AddLine("Random", xui.Color_Blue)
	LineChart1.AddLine("Cos", xui.Color_Red)
	LineChart1.AddLine("Sin", xui.Color_Magenta)
	
	' set the max and min scale values
	LineChart1.YScaleMaxValue = 10
	LineChart1.YScaleMinValue = 0
	' Add the line points.
	
	Dim Val1, Val2, Val3 As Double
	For i = 0 To 720 Step 15
		' In the case of 2 lines or more we are adding an array of values.
		' One for each line.
		' Make sure to create an array for each point.
		' You cannot reuse a single array for all points.
		Val1 = Rnd(-100, 101) / 50 + 5
		Val2 = 3 * CosD(i) + 5
		Val3 = 4 * SinD(i) + 5
		LineChart1.AddLineMultiplePoints(i, Array As Double(Val1, Val2, Val3), i Mod 90 = 0)
	Next

	' draw the chart
	LineChart1.DrawChart
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

	' set the max and min scale values
'	BarChart1.YScaleMaxValue = 800
'	BarChart1.YScaleMinValue = -1200

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
	
	' set the max and min scale values
'	StackedBarChart1.YScaleMaxValue = 5000
'	StackedBarChart1.YScaleMinValue = 0

	' add the items
	For i = 0 To 50
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
	
	' set the max and min scale values
'	BarChart2.YScaleMaxValue = 1250
'	BarChart2.YScaleMinValue = -1250
	
	' add the items.
	For i = 0 To 8
		BarChart2.AddBarPointData(2005 + i, Rnd(-1200, 1200))
	Next
	
	' draw the chart
	BarChart2.DrawChart
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
	CreateLineChartData
	LineChart1.Visible = True
End Sub

' hide all chart objects
Private Sub HideCharts
	BarChart1.Visible = False
	BarChart2.Visible = False
	StackedBarChart1.Visible = False
	LineChart1.Visible = False
End Sub

Private Sub LineChart1_CursorTouch (Action As Int, CursorPointIndex As Int)
	Private Points As PointDataM
	
	Points = LineChart1.Points.Get(CursorPointIndex)
	Log("X = " & Points.X)
	For i = 0 To Points.YArray.Length - 1
		Log("Y" & i & " = " & Points.YArray(i))
	Next
	Log(" ")
End Sub
