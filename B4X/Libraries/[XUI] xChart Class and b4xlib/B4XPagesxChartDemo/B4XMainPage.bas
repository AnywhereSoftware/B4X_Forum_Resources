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
	
	Private su As StringUtils
	
#If B4J
	Private btnPrint As B4XView
#End If
#If B4A
	Private scvToolBox As HorizontalScrollView
	Private pnlToolBox As Panel
#Else	If B4i
	Private scvToolBox As ScrollView
	Private pnlToolBox As Panel
#End If
	Private PieChart1 As xChart
	Private LineChart1, LineChart2  As xChart
	Private AreaChart1, BarChart1, BarChart2, HBarChart1 As xChart
	Private StackedAreaChart1, StackedBarChart1, HStackedBarChart1 As xChart
	Private DynamicLines1 As xChart
	Private SingleLine1 As xChart
	Private YXChart1 As xChart
	Private RadarChart1 As xChart
	Private HLineChart1, HLineChart2 As xChart
	Private CandleChart1, Waterfall1, Bubble1 As xChart
	Private tmrDynamic As Timer
	Private ReadingsToShow = 10 As Int
	Private RadarIndex = 0 As Int
	Private HBarIndex = 0 As Int
	Private HSBarIndex = 0 As Int
	Private HLineIndex = 0 As Int
	Private AreaIndex = 0 As Int
	Private YXChartIndex = 0 As Int
	Private CandleIndex = 0 As Int
	Private WaterfallIndex = 0 As Int
	Private BubbleIndex = 0 As Int
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Main")
	
#If B4A
	scvToolBox.Panel.LoadLayout("ToolBox")
	scvToolBox.Panel.Width = pnlToolBox.Width
#Else If B4i
	scvToolBox.Panel.LoadLayout("ToolBox")
#End If

	B4XPages.SetTitle(Me, "xChartDemo")
	
	tmrDynamic.Initialize("tmrDynamic", 1000)
#If B4i
	Sleep(1000)		'needed in B4i, I do not know why.
#End If

	btnLinePieCharts_Click
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
#If B4i
	scvToolBox.ContentWidth = pnlToolBox.Width
#End If	
End Sub

Private Sub CreatePieData
	'Initialize the pie chart data
	Private i, Values(4) As Int
	
'	PieChart1.PiePercentageNbFractions = 1
	PieChart1.ClearData
	
	For i = 0 To 3
		Values(i) = Rnd(50, 501)
	Next

	PieChart1.AddPie("Slice #1", Values(0), xui.Color_Blue) '0 = random color
	PieChart1.AddPie("Slice #2", Values(1), xui.Color_Red)
	PieChart1.AddPie("Slice #3", Values(2), xui.Color_Yellow)
	PieChart1.AddPie("Slice #4", Values(3), xui.Color_Cyan)
	PieChart1.GradientColorsAlpha = 48
'	PieChart1.ChartBackgroundColor = xui.Color_Transparent

	PieChart1.DrawChart
End Sub

Private Sub CreateLineChart1Data
	' Initialize the line data
	LineChart1.ClearData
	
	LineChart1.Title = "Three graphs"
	LineChart1.XAxisName = "Degrees"
	LineChart1.YAxisName = "Values"
'	LineChart1.YAxisName = ""
'	LineChart1.IncludeLegend = False
	LineChart1.YScaleMaxValue = 1
	LineChart1.YScaleMinValue = -1
	LineChart1.IncludeLegend = "BOTTOM"
	LineChart1.AutomaticScale = True
'	LineChart1.AutomaticScale = False
'	LineChart1.XScaleTextOrientation = "VERTICAL"
	LineChart1.XScaleTextOrientation = "45 DEGREES"
'	LineChart1.YScaleLogaritmic = True
'	LineChart1.ScaleYValuesLog = "1!1.5!2!3!5!7!10"
	
	LineChart1.AddLine("Random", xui.Color_Blue) '0 = random color
	LineChart1.AddLine("Cos", xui.Color_Red)
	LineChart1.AddLine("Sin", xui.Color_Magenta)
	
	' Add the line points.
	Dim Ampl1, Ampl2, Ampl3 As Double
	Ampl1 = Rnd(1, 10001) / 500
	Ampl2 = Rnd(1, 10001) / 500
	Ampl3 = Rnd(1, 10001) / 500
	For i = 0 To 490
		' In the case of 2 lines or more we are adding an array of values.
		' One for each line.
		' Make sure to create an array for each point.
		' You cannot reuse a single array for all points.
'		LineChart1.AddLineMultiplePoints(i, Array As Double(Rnd(2, 101), Rnd(50, 201), Rnd(20, 301)), i Mod 90 = 0)
		LineChart1.AddLineMultiplePoints(i, Array As Double(Rnd(-100, 101) / 300 * Ampl1 + 5, Ampl2 * CosD(3 * i) + 2, Ampl3 * SinD(i) + 4), i Mod 90 = 0)
'		LineChart1.AddLineMultiplePoints("Long text long text " & i, Array As Double(Rnd(-100, 101) / 300 * Ampl1 + 5, Ampl2 * CosD(3 * i) + 2, Ampl3 * SinD(i) + 4), i Mod 90 = 0)
'		LineChart1.AddLineMultiplePoints(i, Array As Double(Rnd(-100, 101) / 300 * Ampl1 + 5), i Mod 90 = 0)
	Next

	LineChart1.DrawChart
End Sub

Private Sub CreateLineChart2Data
	LineChart2.ClearData
	
	LineChart2.AddLine2("Random", xui.Color_Blue, 2dip, "RHOMBUS", False, xui.Color_Blue)
	LineChart2.AddLine2("Cos", xui.Color_Red, 3dip, "CIRCLE", False, xui.Color_Red)
	LineChart2.AddLine2("Sin", xui.Color_Magenta, 3dip, "SQUARE", False, xui.Color_Magenta)
'	LineChart2.AddLine2("Random", xui.Color_Blue, 2dip, "RHOMBUS", False, xui.Color_Red)
'	LineChart2.AddLine2("Cos", xui.Color_Red, 3dip, "CROSS+", False, xui.Color_Black)
'	LineChart2.AddLine2("Sin", xui.Color_Magenta, 3dip, "CROSSX", False, xui.Color_Black)
	
	' Add the line points.
	Dim Ampl1, Ampl2, Ampl3 As Double
	'random amplidud
'	Ampl1 = Rnd(1, 10001) / 500
'	Ampl2 = Rnd(1, 10001) / 500
'	Ampl3 = Rnd(1, 10001) / 5002
	
	'fixed amplitudes to compare different scales
	Ampl1 = 9.5
	Ampl2 = 78
	Ampl3 = 23

	For i = 0 To 720 Step 45
		' In the case of 2 lines or more we are adding an array of values.
		' One for each line.
		' Make sure to create an array for each point.
		' You cannot reuse a single array for all points.
		LineChart2.AddLineMultiplePoints(i, Array As Double(Rnd(-100, 101) / 300 * Ampl1 + 5, Ampl2 * CosD(i) + 2, Ampl3 * SinD(i) + 4), i Mod 90 = 0)
	Next
	LineChart2.Title = "Three graphs"
	LineChart2.XAxisName = "Degrees"
	LineChart2.YAxisName = "Values"
'	LineChart2.YAxisName = ""
'	LineChart2.IncludeLegend = False

	LineChart2.DrawChart
End Sub

Private Sub CreateBarData
	' set the bar colors
	BarChart1.ClearData
	BarChart1.AddBar("Bar 1", xui.Color_Red)
	BarChart1.AddBar("Bar 2", xui.Color_Blue)
	BarChart1.AddBar("Bar 3", xui.Color_Green)
	BarChart1.AddBar("Bar 4", xui.Color_Yellow)
	BarChart1.AddBar("Bar 5", xui.Color_Magenta)
'	BarChart1.XScaleTextOrientation = "VERTICAL"
	BarChart1.XScaleTextOrientation = "45 DEGREES"
	BarChart1.ScaleValues = "1!1.5!2!2.5!5!7.5!10"
	' Add the items.
	For i = 0 To 8
		BarChart1.AddBarMultiplePoint(2005 + i, Array As Double(Rnd(-1000, 500), Rnd(-1000, 500), Rnd(-1000, 500), Rnd(-1000, 500), Rnd(-1000, 500)))
	Next
	BarChart1.DrawChart
End Sub

Private Sub CreateHBarData
	
	Select HBarIndex
		Case 0
			' set the bar colors
			HBarChart1.ClearData
			HBarChart1.AddBar("Bar 1", xui.Color_Red)
			HBarChart1.IncludeBarMeanLine = True
			HBarChart1.SetBarMeanValueFormat(1, 0, 0, False)
			HBarChart1.KeepDisplayValues = "BOTH"
			For i = 0 To 5
				HBarChart1.AddBarPointData(2005 + i, Rnd(0, 1000))
			Next
		Case 1
			' set the bar colors
			HBarChart1.ClearData
			HBarChart1.AddBar("Bar 1", xui.Color_Red)
			HBarChart1.IncludeBarMeanLine = True
			HBarChart1.SetBarMeanValueFormat(1, 1, 1, False)
			For i = 0 To 9
				HBarChart1.AddBarPointData(2005 + i, Rnd(-1000, -1))
			Next
		Case 2
			' set the bar colors
			HBarChart1.ClearData
			HBarChart1.AddBar("Bar 1", xui.Color_Red)
			HBarChart1.AddBar("Bar 2", xui.Color_Blue)
			HBarChart1.AddBar("Bar 3", xui.Color_Green)
			HBarChart1.AddBar("Bar 4", xui.Color_Yellow)
'			HBarChart1.XScaleTextOrientation = "VERTICAL"
'			HBarChart1.XScaleTextOrientation = "45 DEGREES"
			HBarChart1.ScaleValues = "1!1.5!2!2.5!5!7.5!10"
			' Add the items.
			For i = 0 To 5
				HBarChart1.AddBarMultiplePoint(2005 + i, Array As Double(Rnd(-1000, 1000), Rnd(-1000, 1000), Rnd(-1000, 1000), Rnd(-1000, 1000)))
			Next
	End Select
	
	HBarChart1.DrawChart
End Sub

Private Sub CreateStackedBarData
	' set the bar colors
	StackedBarChart1.ClearData
	StackedBarChart1.AddBar("Bar 1", xui.Color_Red)
	StackedBarChart1.AddBar("Bar 2", xui.Color_Blue)
	StackedBarChart1.AddBar("Bar 3", xui.Color_Green)
	StackedBarChart1.AddBar("Bar 4", xui.Color_Yellow)
'	StackedBarChart1.XScaleTextOrientation = "VERTICAL"
'	StackedBarChart1.LegendTextSize = 20
'	StackedBarChart1.ChartType = "BAR"
	
	' Add the items.
	For i = 0 To 8
		StackedBarChart1.AddBarMultiplePoint(2005 + i, Array As Double(Rnd(0, 1000), Rnd(0, 1000), Rnd(0, 1000), Rnd(0, 1000)))
	Next
	
	StackedBarChart1.DrawChart
End Sub

Private Sub CreateHStackedBarData
	Select HSBarIndex
		Case 0
			' set the bar colors
			HStackedBarChart1.ClearData
			HStackedBarChart1.AddBar("VW", xui.Color_Red)
			HStackedBarChart1.AddBar("Peugeot", xui.Color_Blue)
			HStackedBarChart1.AddBar("Ford", xui.Color_Green)
			HStackedBarChart1.AddBar("Toyota", xui.Color_Yellow)
			HStackedBarChart1.HChartsXScaleOnTop = False
			HStackedBarChart1.HChartsTicksTopDown = False
'			HStackedBarChart1.XScaleTextOrientation = "VERTICAL"
'			HStackedBarChart1.LegendTextSize = 20
'			HStackedBarChart1.ChartType = "BAR"
	
			' Add the items.
			For i = 0 To 5
				HStackedBarChart1.AddBarMultiplePoint(2005 + i, Array As Double(Rnd(0, 1000), Rnd(0, 1000), Rnd(0, 1000), Rnd(0, 1000)))
			Next
		Case 1
			' set the bar colors
			HStackedBarChart1.ClearData
			HStackedBarChart1.AddBar("VW", xui.Color_Red)
			HStackedBarChart1.AddBar("Peugeot", xui.Color_Blue)
			HStackedBarChart1.AddBar("Toyota", xui.Color_Green)
			HStackedBarChart1.HChartsXScaleOnTop = True
			HStackedBarChart1.HChartsTicksTopDown = False
'			HStackedBarChart1.XScaleTextOrientation = "VERTICAL"
'			HStackedBarChart1.LegendTextSize = 20
'			HStackedBarChart1.ChartType = "BAR"
	
			' Add the items.
			For i = 0 To 7
				HStackedBarChart1.AddBarMultiplePoint(2005 + i, Array As Double(Rnd(0, 1000), Rnd(0, 1000), Rnd(0, 1000)))
			Next
		Case 2
			' set the bar colors
			HStackedBarChart1.ClearData
			HStackedBarChart1.AddBar("VW", xui.Color_Red)
			HStackedBarChart1.AddBar("Peugeot", xui.Color_Blue)
			HStackedBarChart1.AddBar("Toyota", xui.Color_Green)
			HStackedBarChart1.HChartsXScaleOnTop = True
			HStackedBarChart1.HChartsTicksTopDown = True
'			HStackedBarChart1.XScaleTextOrientation = "VERTICAL"
'			HStackedBarChart1.LegendTextSize = 20
'			HStackedBarChart1.ChartType = "BAR"
	
			' Add the items.
			For i = 0 To 7
				HStackedBarChart1.AddBarMultiplePoint(2005 + i, Array As Double(Rnd(0, 1000), Rnd(0, 1000), Rnd(0, 1000)))
			Next
	End Select
	
	HStackedBarChart1.DrawChart
End Sub

Private Sub CreateSingleBarData
	' set the bar color
	BarChart2.ClearData
	BarChart2.AddBar("Bar 1", xui.Color_Red)
	BarChart2.XScaleTextOrientation = "VERTICAL"
	BarChart2.BarValueOrientation = "VERTICAL"
	BarChart2.ChartBackgroundColor = xui.Color_Black
	BarChart2.GridFrameColor = xui.Color_Yellow
	BarChart2.GridColor = xui.Color_White
	BarChart2.TitleTextColor = xui.Color_White
	BarChart2.ScaleTextColor = xui.Color_Yellow
	BarChart2.SetBarMeanValueFormat(1, 2, 2, False)
	BarChart2.Subtitle = "in million $"
	BarChart2.SubtitleTextColor = xui.Color_Gray
	BarChart2.AxisTextColor = xui.Color_Cyan
	' Add the items.
	For i = 0 To 8
'		BarChart2.AddBarPointData(2005 + i, 0)
'		BarChart2.AddBarPointData(2005 + i, Rnd(-1000, 1500))
		BarChart2.AddBarPointData(2005 + i, Rnd(0, 1500))
'		BarChart2.AddBarPointData(2005 + i, Rnd(-1500, 1))
	Next
	BarChart2.DrawChart
	Private bmp As B4XBitmap
	Private Out As OutputStream
	xui.SetDataFolder("ChartsDemo")
	Out = File.OpenOutput(xui.DefaultFolder, "BarChart.jpg", False)
'	Log(xui.DefaultFolder)
	bmp = BarChart2.Snapshot
	bmp.WriteToStream(Out, 100, "JPEG")
	Out.Close
End Sub

Private Sub CreateYXChartData
	' set the line properties
	YXChart1.ClearData

	Select YXChartIndex
		Case 0
			YXChart1.Title = "YX Chart  Lissajous curves"
			YXChart1.AddYXLine2("Example1", xui.Color_Red, 2dip, True, "CIRCLE", False, xui.Color_Red)
'			YXChart1.AddYXLine("Example2", xui.Color_Blue, 2dip)
			YXChart1.AddYXLine2("Example2", xui.Color_Blue, 2dip, True, "NONE", False, xui.Color_Blue)
			YXChart1.AddYXLine2("OnlyPoints", xui.Color_Green, 2dip, False, "SQUARE", True, xui.Color_Green)
			YXChart1.XScaleTextOrientation = "VERTICAL"
			YXChart1.ChartBackgroundColor = xui.Color_White
			YXChart1.GridFrameColor = xui.Color_Black
'			YXChart1.ChartBackgroundColor = xui.Color_Black
'			YXChart1.GridFrameColor = xui.Color_White
'			YXChart1.YXChartCrossHairColor = xui.Color_White
			YXChart1.GridColor = xui.Color_Gray
			YXChart1.TitleTextColor = xui.Color_Black
			YXChart1.ScaleTextColor = xui.Color_Black
			YXChart1.DisplayValues = True
			YXChart1.YScaleMaxValue = 75
			YXChart1.YScaleMinValue = -75
			YXChart1.XScaleMaxValue = 75
			YXChart1.XScaleMinValue = -75
'			YXChart1.YXChartDisplayPosition = "CORNERS"
			'add the points
			'these are Lissajou curves
			Private ampl, x1, y1, x2, y2, z1, z2 As Double
			Private n, n1 As Int
			z1 = Rnd(1, 6)
			z2 = Rnd(1, 6)
			
'			ampl = 90
			ampl = 70
			n = 72
			n1 = 360 / n
			For i = 0 To n
				x1 = ampl * CosD(n1 * i)
				y1 = ampl * SinD(z1 * n1 * i)
				YXChart1.AddYXPoint(0, x1, y1)
				x2 = ampl * CosD(z2 * n1 * i)
				y2 = ampl * SinD(n1 * i)
				YXChart1.AddYXPoint(1, x2, y2)
				If i > 10 And i < 20 Then
					YXChart1.AddYXPoint(2, Rnd(-ampl, ampl), Rnd(-ampl, ampl))
				End If
			Next

			YXChart1.DrawOuterFrame = True
'			YXChart1.Rotation = Rnd(-2, 2)
		Case 1
			' test for the question here:
			' https://www.b4x.com/android/forum/threads/b4x-xui-xchart-class.91830/page-9#post-637309
			YXChart1.ClearData
			YXChart1.Title = "Test"
			YXChart1.XAxisName = "Testy"
			YXChart1.YAxisName = "Testx"
'			YXChart1.AutomaticScale = True
			YXChart1.AddYXLine2("Test", xui.Color_Red, 2dip, True, "CIRCLE", False, xui.Color_Red)
			YXChart1.AddYXLine2("Test+", xui.Color_Blue, 2dip, True, "CIRCLE", False, xui.Color_Blue)
			YXChart1.AddYXLine2("Test-", xui.Color_Blue, 2dip, True, "CIRCLE", False, xui.Color_Blue)
			YXChart1.XScaleTextOrientation = "VERTICAL"
			YXChart1.ChartBackgroundColor = xui.Color_White
			YXChart1.GridFrameColor = xui.Color_Black
			YXChart1.GridColor = xui.Color_Gray
			YXChart1.TitleTextColor = xui.Color_Black
			YXChart1.ScaleTextColor = xui.Color_Black
			YXChart1.DisplayValues = True
			YXChart1.YScaleMaxValue = 5
			YXChart1.YScaleMinValue = -5
			YXChart1.XScaleMaxValue = 3000
			YXChart1.XScaleMinValue = 0

			'result
			YXChart1.AddYXPoint(0, 0, 0)
			YXChart1.AddYXPoint(0, 200, 0.4)
			YXChart1.AddYXPoint(0, 400, 0.5)
			YXChart1.AddYXPoint(0, 600, 0.5)
			YXChart1.AddYXPoint(0, 800, 1.0)
			YXChart1.AddYXPoint(0, 1000, 1.4)
			YXChart1.AddYXPoint(0, 1200, 1.6)
			YXChart1.AddYXPoint(0, 1400, -1)
			YXChart1.AddYXPoint(0, 1600, -1.2)
			YXChart1.AddYXPoint(0, 1800, -1.2)
			YXChart1.AddYXPoint(0, 2000, -1.6)
			'rif1
			YXChart1.AddYXPoint(1, 0, 1)
			YXChart1.AddYXPoint(1, 500, 1)
			YXChart1.AddYXPoint(1, 500, 2)
			YXChart1.AddYXPoint(1, 2000, 2)
			YXChart1.AddYXPoint(1, 2000, 3)
			YXChart1.AddYXPoint(1, 3000, 3)
			'rif2
			YXChart1.AddYXPoint(2, 0, -1)
			YXChart1.AddYXPoint(2, 500, -1)
			YXChart1.AddYXPoint(2, 500, -2)
			YXChart1.AddYXPoint(2, 2000, -2)
			YXChart1.AddYXPoint(2, 2000, -3)
			YXChart1.AddYXPoint(2, 3000, -3)
		Case 2
			YXChart1.Title = "Test 4 scales"
			YXChart1.XAxisName = "Test X"
			YXChart1.YAxisName = "Test Y"
			YXChart1.AutomaticScale = True
			YXChart1.DifferentScales = True
			YXChart1.AddYXLine("Test 1", xui.Color_Red, 2dip)
			YXChart1.AddYXLine("Test 2", xui.Color_Blue, 2dip)
			YXChart1.AddYXLine("Test 3", xui.Color_RGB(0, 120, 0), 2dip)
			YXChart1.AddYXLine("Test 4", xui.Color_RGB(120, 0, 0), 2dip)
			
			Private Ampl1, Ampl2, Ampl3, Ampl4 As Double
			Ampl1 = 100
			Ampl2 = 1
			Ampl3 = 10
			Ampl4 = 50
			For i = 0 To 200
				YXChart1.AddYXPoint(0, i, Ampl1 * SinD(i * 4))
				YXChart1.AddYXPoint(1, i, Ampl2 * CosD(i * 3) + Ampl2)
				YXChart1.AddYXPoint(2, i, Ampl3 * CosD(i * 5) + Ampl3)
				YXChart1.AddYXPoint(3, i, Ampl4 * CosD(i * 6) + Ampl4)
			Next
		Case 3
			YXChart1.ClearData
			YXChart1.Title = "Old faithful"
			YXChart1.XAxisName = "Eruption time [min]"
			YXChart1.YAxisName = "Waiting time [min]"
			YXChart1.YAxisName2 = ""
			YXChart1.AddYXLine2("Old faithful", xui.Color_Blue, 1dip, False, "CIRCLE", False, xui.Color_Blue)
			YXChart1.AutomaticScale = True
			YXChart1.YZeroAxis = False
			YXChart1.DisplayValues = True
			YXChart1.DifferentScales = False
			
#If B4J
			xui.SetDataFolder("B4XPagesxChartDemo")
#End If
'			File.Delete(xui.DefaultFolder, "oldFaithful.csv")
			If File.Exists(xui.DefaultFolder, "oldfaithful.csv") = False Then
				File.Copy(File.DirAssets, "oldfaithful.csv", xui.DefaultFolder, "oldfaithful.csv")
			End If
			
			Private lst As List
			lst.Initialize
			lst = su.LoadCSV(xui.DefaultFolder, "oldfaithful.csv", ";")
			For i = 0 To lst.Size - 1
				Private txt() As String
				txt = lst.Get(i)
				YXChart1.AddYXPoint(0, txt(1), txt(2))
			Next
	End Select
	
	YXChart1.DrawChart
	
'	Sleep(5)
	Private bmp As B4XBitmap
	Private Out As OutputStream
	xui.SetDataFolder("ChartsDemo")
	Out = File.OpenOutput(xui.DefaultFolder, "Test.jpg", False)
'	Log(xui.DefaultFolder)
	bmp = YXChart1.Snapshot
	bmp.WriteToStream(Out, 100, "JPEG")
	Out.Close
End Sub

Private Sub CreateDynamicData
	DynamicLines1.ClearData
	DynamicLines1.AddLine2("Speed", xui.Color_Red, 2dip, "CIRCLE", False, xui.Color_Red)
	DynamicLines1.AddLine2("Direction", xui.Color_Blue, 2dip, "SQUARE", True, xui.Color_Blue)
End Sub

Private Sub CreateSingleLineChartData
	' Initialize the single line data
	SingleLine1.ClearData
  
	SingleLine1.Title = "Single line graph"
	SingleLine1.XAxisName = "Year"
	SingleLine1.YAxisName = "Values"
	'    SingleLine1.YAxisName = ""
	'    SingleLine1.IncludeLegend = False
	SingleLine1.IncludeLegend = "BOTTOM"
	SingleLine1.AutomaticScale = True
'	SingleLine1.YZeroAxis = False
	SingleLine1.XScaleTextOrientation = "VERTICAL"
	SingleLine1.AddLine("Test line", xui.Color_Blue)
  
'	Private vl As List = Array As Double(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	Private vl As List = Array As Double(Rnd(0, 60), Rnd(0, 60), Rnd(0, 60), Rnd(0, 60), Rnd(0, 60), Rnd(0, 60), Rnd(0, 60), Rnd(0, 60), Rnd(0, 60), Rnd(0, 60), Rnd(0, 60))
'	Private vl As List = Array As Double(34, 8, 37, 39, 23, 44, 29, 30, 24, 57, 29)	'used for scale testing

	For i = 0 To vl.Size-1
		SingleLine1.AddLineMultiplePoints(2005+i, Array As Double(vl.Get(i)),True)
	Next
	SingleLine1.DrawChart
End Sub

Private Sub CreateRadarChartData
	Private i As Int
	Private Filled As Boolean
	
	Select RadarIndex
		Case 0
			Private Month(12) As String
	
'			Month = Array As String ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
			Month = Array As String ("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
			RadarChart1.ClearData
			
			RadarChart1.RadarScaleType = "SPIDER"
			
			Filled = True
'			RadarChart1.AddRadar("VW", xui.Color_Red, 2dip, Filled)
'			RadarChart1.AddRadar("Volvo", xui.Color_Blue, 2dip, Filled)
'			RadarChart1.AddRadar("Peugeot", xui.Color_Green, 2dip, Filled)
'			RadarChart1.AddRadar("Ford", xui.Color_RGB(165, 42, 42), 2dip, Filled)
'			RadarChart1.AddRadar("Fiat", xui.Color_RGB(34, 139, 34), 2dip, Filled)
			RadarChart1.AddRadar2("VW", xui.Color_Red, 2dip, Filled, "CIRCLE", False, xui.Color_Red)
			RadarChart1.AddRadar2("Volvo", xui.Color_Blue, 2dip, Filled, "TRIANGLE", False, xui.Color_Blue)
			RadarChart1.AddRadar2("Peugeot", xui.Color_Green, 2dip, Filled, "RHOMBUS", False, xui.Color_Green)
			RadarChart1.AddRadar2("Ford", xui.Color_RGB(165, 42, 42), 2dip, Filled, "CROSS+", False, xui.Color_RGB(165, 42, 42))
			RadarChart1.AddRadar2("Fiat", xui.Color_RGB(34, 139, 34), 2dip, Filled, "CROSSX", False, xui.Color_RGB(34, 139, 34))
			RadarChart1.NbYIntervals = 5
			RadarChart1.YScaleMaxValue = 100
			RadarChart1.YScaleMinValue = 50
			For i = 0 To 11
'				RadarChart1.AddRadarMultiplePoint(Month(i), Array As Double(Rnd(50, 100), Rnd(20, 80), Rnd(10, 100), Rnd(10, 80), Rnd(30, 60)))
				RadarChart1.AddRadarMultiplePoint(Month(i), Array As Double(Rnd(50, 100), Rnd(60, 80), Rnd(60, 100), Rnd(50, 80), Rnd(50, 60)))
			Next
		Case 1
			RadarChart1.ClearData
			
			RadarChart1.RadarScaleType = "CIRCLE"
			
			Filled = False
			RadarChart1.AddRadar("VW", xui.Color_Red, 2dip, Filled)
			RadarChart1.AddRadar("Volvo", xui.Color_Blue, 2dip, Filled)
			RadarChart1.AddRadar("Peugeot", xui.Color_Green, 2dip, Filled)
			RadarChart1.AddRadar("Ford", xui.Color_RGB(165, 42, 42), 2dip, Filled)
			RadarChart1.AddRadar("Fiat", xui.Color_RGB(34, 139, 34), 2dip, Filled)
	
			For i = 1 To 37
				RadarChart1.AddRadarMultiplePoint(i, Array As Double(Rnd(50, 100), Rnd(20, 80), Rnd(10, 100), Rnd(10, 80), Rnd(30, 60)))
			Next
	End Select
	
	RadarChart1.DrawChart
	
	RadarIndex = RadarIndex + 1
	If RadarIndex > 1 Then
		RadarIndex = 0
	End If
End Sub

Private Sub CreateHLineChartData
	HLineChart1.ClearData
	
'	HLineChart1.NbYIntervals = 5
	HLineChart1.AddLine2("Random", xui.Color_Blue, 2dip, "RHOMBUS", False, xui.Color_Blue)
	HLineChart1.AddLine2("Cos", xui.Color_Red, 3dip, "CIRCLE", False, xui.Color_Red)
	HLineChart1.AddLine2("Sin", xui.Color_Magenta, 3dip, "SQUARE", False, xui.Color_Magenta)
'			HLineChart1.AddLine2("Random", xui.Color_Blue, 2dip, "RHOMBUS", False, xui.Color_Red)
'			HLineChart1.AddLine2("Cos", xui.Color_Red, 3dip, "CROSS+", False, xui.Color_Black)
'			HLineChart1.AddLine2("Sin", xui.Color_Magenta, 3dip, "CROSSX", False, xui.Color_Black)
	
	' Add the line points.
	Dim Ampl1, Ampl2, Ampl3, Angle As Double
	'random amplidud
'			Ampl1 = Rnd(1, 10001) / 500
'			Ampl2 = Rnd(1, 10001) / 500
'			Ampl3 = Rnd(1, 10001) / 5002
	
	'fixed amplitudes to compare different scales
	Ampl1 = 9.5
	Ampl2 = 78
	Ampl3 = 23
'	For i = 0 To 7200 Step 45
	For i = 0 To 160
		' In the case of 2 lines or more we are adding an array of values.
		' One for each line.
		' Make sure to create an array for each point.
		' You cannot reuse a single array for all points.
		Angle = i * 45
		
		Private Vals(3) As Double
		Vals(0) = Rnd(-100, 101) / 300 * Ampl1 + 5
		Select Angle
			Case 45, 360, 405
'				Vals(0) = 1000000000
		End Select
		Vals(1) = Ampl2 * CosD(Angle) + 2
		Select Angle
			Case 0, 45, 270, 315, 360, 720
'				Vals(1) = 1000000000
		End Select
		Vals(2) = Ampl3 * SinD(Angle) + 4
'		HLineChart1.AddLineMultiplePoints(Angle, Vals, i Mod 90 = 0)
		HLineChart1.AddLineMultiplePoints(i, Vals, True)
		
'		HLineChart1.AddLineMultiplePoints(i, Array As Double(Rnd(-100, 101) / 300 * Ampl1 + 5, Ampl2 * CosD(i) + 2, Ampl3 * SinD(i) + 4), i Mod 90 = 0)
	Next
	HLineChart1.Title = "Three graphs"
	HLineChart1.XAxisName = "Angle"
	HLineChart1.YAxisName = "Values"
'	HLineChart1.YAxisName = ""
'	HLineChart1.IncludeLegend = False
'	HLineChart1.YZeroAxisHighlight = False
	HLineChart1.SetZoomIndexes(0, 10)
	HLineChart1.JumpTo(80)
	HLineChart1.DrawChart


	HLineChart2.ClearData
	HLineChart2.AddLine2("External", xui.Color_Blue, 2dip, "RHOMBUS", False, xui.Color_Blue)
	HLineChart2.Title = "Temperatures"
	HLineChart2.XAxisName = "Day"
	HLineChart2.YAxisName = "Degrees"
	
	Private Ticks As Long
	Private Days() As String = Array As String("", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
	DateTime.DateFormat = "dd.MM.yyyy"
	Ticks = DateTime.DateParse("01.01.2020")
	
	For i = 1 To 366
		HLineChart2.AddLinePointData(Days(DateTime.GetDayOfWeek(Ticks)) & " " & DateTime.Date(Ticks), Rnd(-20, 50), True)
		
		Ticks = Ticks + DateTime.TicksPerDay
	Next
	HLineChart2.SetZoomIndexes(0, 6)
	
	HLineChart2.DrawChart
End Sub

Private Sub CreateAreaData
	Private i As Int
	Private Months(12) As String
	
	Months = Array As String("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

	AreaChart1.ClearData
	AreaChart1.AddLine("2018", xui.Color_Blue)
	AreaChart1.AddLine("2019", xui.Color_Green)
	AreaChart1.AddLine("2020", xui.Color_Red)
	
	For i = 0 To 11
		AreaChart1.AddLineMultiplePoints(Months(i), Array As Double(Rnd(10, 100), Rnd(10, 100), Rnd(10, 100)), True)
	Next
	
	AreaChart1.DrawChart
End Sub

Private Sub CreateStackedAreaData
	Private i As Int
	Private Months(12) As String
	
	Months = Array As String("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
	
	StackedAreaChart1.ClearData
	
	Select AreaIndex
		Case 0
			StackedAreaChart1.AddLine("2018", xui.Color_Blue)
			StackedAreaChart1.AddLine("2019", xui.Color_Green)
			StackedAreaChart1.AddLine("2020", xui.Color_Red)
			StackedAreaChart1.AreaFillAlphaValue = 0x60
			StackedAreaChart1.XAxisName = "Month"
			For i = 0 To 11
				StackedAreaChart1.AddLineMultiplePoints(Months(i), Array As Double(Rnd(10, 100), Rnd(10, 100), Rnd(10, 100)), True)
			Next
		Case 1
			StackedAreaChart1.AddLine2("2018", xui.Color_Blue, 2dip, "CIRCLE", False, xui.Color_Blue)
			StackedAreaChart1.AddLine2("2019", xui.Color_Green, 2dip, "SQUARE", False, xui.Color_RGB(0, 128, 0))
			StackedAreaChart1.AddLine2("2020", xui.Color_Red, 2dip, "RHOMBUS", False, xui.Color_Red)
			StackedAreaChart1.AreaFillAlphaValue = 0x20
			StackedAreaChart1.XAxisName = "Week"
			For i = 0 To 51
				StackedAreaChart1.AddLineMultiplePoints(i + 1, Array As Double(Rnd(10, 150), Rnd(10, 150), Rnd(10, 150)), True)
			Next
			StackedAreaChart1.SetZoomIndexes(0, 6)
	End Select
	StackedAreaChart1.DrawChart
End Sub

Private Sub CreateCandleData
	CandleChart1.ClearData
	
	Select CandleIndex
		Case 0
			' first run with default setting
		Case 1
			' custom setting
			CandleChart1.GradientColors = False
			CandleChart1.CandleWickColor = xui.Color_Black
			CandleChart1.IncreaseColor = xui.Color_Green
			CandleChart1.DecreaseColor = xui.Color_Blue
			CandleChart1.CandleDrawBodyBorder = True
			CandleChart1.CandleDisplayVolume = False
		Case 2
			' sets the default Designer setting back
			CandleChart1.GradientColors = True
			CandleChart1.CandleWickColor = xui.Color_Blue
			CandleChart1.IncreaseColor = xui.Color_RGB(0, 136, 0)
			CandleChart1.DecreaseColor = xui.Color_Red
			CandleChart1.CandleDrawBodyBorder = False
			CandleChart1.CandleDisplayVolume = True
	End Select
	
	CandleIndex = CandleIndex + 1
	If CandleIndex = 3 Then
		CandleIndex = 1
	End If
	
	CandleChart1.ClearData
'	CandleChart1.AddCandlePoint("12:00", 72.0, 72.0, 47.0, 47.0, True)
'	CandleChart1.AddCandlePoint("12:05", 58.0, 72.0, 47.0, 52.0, True)
'	CandleChart1.AddCandlePoint("12:10", 52.0, 72.0, 47.0, 58.0, True)
'	CandleChart1.AddCandlePoint("12:15", 47.0, 72.0, 47.0, 72.0, True)
'	CandleChart1.AddCandlePoint("12:20", 55.0, 72.0, 47.0, 55.0, True)
'	CandleChart1.AddCandlePoint("12:25", 55.1, 72.0, 47.0, 54.9, True)
'	CandleChart1.AddCandlePoint("12:30", 54.9, 72.0, 47.0, 55.1, True)
'	CandleChart1.AddCandlePoint("12:35", 75.0, 75.0, 45.0, 52.1, True)
'	CandleChart1.AddCandlePoint("12:40", 45.0, 75.0, 45.0, 65.1, True)
'	CandleChart1.AddCandlePoint("12:45", 75.0, 78.0, 42.0, 57.1, True)
'	CandleChart1.AddCandlePoint("12:50", 49.0, 82.0, 42.0, 74.1, True)

	CandleChart1.AddCandlePoint2("12:00", 72.0, 72.0, 47.0, 47.0, 5.14E6, True)
	CandleChart1.AddCandlePoint2("12:05", 58.0, 72.0, 47.0, 52.0, 3.15E6, True)
	CandleChart1.AddCandlePoint2("12:10", 52.0, 72.0, 47.0, 58.0, 2.18E6, True)
	CandleChart1.AddCandlePoint2("12:15", 47.0, 72.0, 47.0, 72.0, 8.75E6, True)
	CandleChart1.AddCandlePoint2("12:20", 55.0, 72.0, 47.0, 55.0, 4.98E6, True)
	CandleChart1.AddCandlePoint2("12:25", 55.1, 72.0, 47.0, 54.9, 6.67E6, True)
	CandleChart1.AddCandlePoint2("12:30", 54.9, 72.0, 47.0, 55.1, 2.90E6, True)
	CandleChart1.AddCandlePoint2("12:35", 75.0, 75.0, 45.0, 52.1, 1.3E6, True)
	CandleChart1.AddCandlePoint2("12:40", 45.0, 75.0, 45.0, 65.1, 8.2E6, True)
	CandleChart1.AddCandlePoint2("12:45", 75.0, 78.0, 42.0, 57.1, 7.4E6, True)
	CandleChart1.AddCandlePoint2("12:50", 49.0, 82.0, 42.0, 74.1, 5.3E6, True)

	CandleChart1.DrawChart
End Sub

Private Sub CreateWaterfallData
	Waterfall1.ClearData
	
	Select WaterfallIndex
		Case 0
		Case 1
			' custom setting
			Waterfall1.GradientColors = False
			Waterfall1.DecreaseColor = xui.Color_Blue
			Waterfall1.IncreaseColor = xui.Color_Magenta
			Waterfall1.WaterfallTotalBarColor = xui.Color_Black
		Case 2
			' sets the default Designer setting back
			Waterfall1.GradientColors = True
			Waterfall1.DecreaseColor = xui.Color_Red
			Waterfall1.IncreaseColor = xui.Color_RGB(0, 136, 0)
			Waterfall1.WaterfallTotalBarColor = xui.Color_Blue
	End Select
	
	Waterfall1.AddWaterfallPoint("T", "Start", -1.5)
	Waterfall1.AddWaterfallPoint("V", "Jan", 2.2)
	Waterfall1.AddWaterfallPoint("V", "Feb", -4.6)
	Waterfall1.AddWaterfallPoint("V", "Mar", -11.1)
	Waterfall1.AddWaterfallPoint("T", "1 st", 0)
	Waterfall1.AddWaterfallPoint("V", "Apr", 1.9)
	Waterfall1.AddWaterfallPoint("V", "May", -1.9)
	Waterfall1.AddWaterfallPoint("V", "Jun", 9.3)
	Waterfall1.AddWaterfallPoint("T", "Mid", 0)
	Waterfall1.AddWaterfallPoint("V", "Jul", 3.1)
	Waterfall1.AddWaterfallPoint("V", "Aug", -1.5)
	Waterfall1.AddWaterfallPoint("V", "Sep", 4.5)
	Waterfall1.AddWaterfallPoint("T", "3 rd", 0)
	Waterfall1.AddWaterfallPoint("V", "Oct", 19.3)
	Waterfall1.AddWaterfallPoint("V", "Nov", -1.5)
	Waterfall1.AddWaterfallPoint("V", "Dec", 15.1) ' 8.1
	Waterfall1.AddWaterfallPoint("T", "End", 0)

	Waterfall1.DrawChart
End Sub

Private Sub CreateBubbleData
	Private i As Int
	
	Bubble1.ClearData
	
	Select BubbleIndex
		Case 0	'default settings
			Bubble1.AddBubbleSeries("Series 1", xui.Color_Blue)
			Bubble1.AddBubbleSeries("Series 2", xui.Color_Red)
			
			For i = 0 To 10
				Bubble1.AddBubble(0, Rnd(1, 100), Rnd(1,100), Rnd(10, 1000) / 100)
				Bubble1.AddBubble(1, Rnd(1, 100), Rnd(1,100), Rnd(10, 1000) / 100)
			Next
		Case 1	'custom settings
			Bubble1.BubbleDiameterMax = 20
			Bubble1.BubbleSmallSnap = True
			For i = 0 To 10
				Bubble1.AddBubbleSingle("Bubble " & i, Rnd(1, 100), Rnd(1,100), Rnd(10, 1000) / 100, xui.Color_RGB(Rnd(0, 255), Rnd(0, 255), Rnd(0, 255)))
			Next
		Case 2 'goes back to default settings
			Bubble1.BubbleDiameterMax = 10
			Bubble1.BubbleSmallSnap = False
			
			Bubble1.AddBubbleSeries("Series 1", xui.Color_Blue)
			Bubble1.AddBubbleSeries("Series 2", xui.Color_Red)
			
			For i = 0 To 10
				Bubble1.AddBubble(0, Rnd(1, 100), Rnd(1,100), Rnd(10, 1000) / 100)
				Bubble1.AddBubble(1, Rnd(1, 100), Rnd(1,100), Rnd(10, 1000) / 100)
			Next
	End Select
	
	Bubble1.DrawChart
End Sub

Private Sub DrawDynamicLinePoints
	Private Speed, Direction As Double
	
	DateTime.TimeFormat = "HH:mm:ss"
		
	Private ElapsedTime As String
	ElapsedTime=DateTime.Time( DateTime.Now)		'time in seconds
				
'	Speed = Rnd(0, 60)
'	Direction = Rnd(0, 360)
	Speed = Rnd(0, 60)
	Direction = Rnd(0, 255)
	Speed = Rnd(-60, 0)
	Direction = Rnd(-255, 0)
	
	If DynamicLines1.NbPoints = ReadingsToShow Then
		DynamicLines1.RemovePointData(0)
	End If
		
	DynamicLines1.AddLineMultiplePoints(ElapsedTime, Array As Double(Speed, Direction), True)
	DynamicLines1.DrawChart
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
	
	StackedBarChart1.ClearData
	CreateStackedBarData
	StackedBarChart1.Visible = True
End Sub

Private Sub btnBarChart_Click
	HideCharts

	CreateSingleBarData
	BarChart2.Visible = True
End Sub

Private Sub btnHBarCharts_Click
	HideCharts

	HBarChart1.Visible = True
	HBarIndex= HBarIndex + 1
	If HBarIndex > 2 Then
		HBarIndex = 0
	End If
	CreateHBarData
	
	HStackedBarChart1.Visible = True
	HStackedBarChart1.ClearData
	CreateHStackedBarData
	HSBarIndex= HSBarIndex + 1
	If HSBarIndex > 2 Then
		HSBarIndex = 0
	End If
End Sub

Private Sub btnLineChart_Click
	HideCharts

	LineChart2.DifferentScales = Not(LineChart2.DifferentScales)
	CreateLineChart2Data
	LineChart2.Visible = True
End Sub

Private Sub btnHLineChart_Click
	HideCharts

	Select HLineIndex
		Case 0
			HLineChart1.HChartsTicksTopDown = False
			HLineChart1.HChartsXScaleOnTop = False
			HLineChart1.Subtitle = "Y scale bottom-top, x scale on bottom"
			HLineChart2.Subtitle = "scale on whole chart"
			HLineChart2.ScalesOnZoomedPart = False
		Case 1
			HLineChart1.HChartsTicksTopDown = True
			HLineChart1.HChartsXScaleOnTop = False
			HLineChart1.Subtitle = "Y scale top-bottom, x scale on bottom"
			HLineChart2.Subtitle = "scale on the zoomed part"
			HLineChart2.ScalesOnZoomedPart = True
		Case 2
			HLineChart1.HChartsTicksTopDown = False
			HLineChart1.HChartsXScaleOnTop = True
			HLineChart1.Subtitle = "Y scale bottom-top, x scale on top"
			HLineChart2.Subtitle = "scale on whole chart"
			HLineChart2.ScalesOnZoomedPart = False
		Case 3
			HLineChart1.HChartsTicksTopDown = True
			HLineChart1.HChartsXScaleOnTop = True
			HLineChart1.Subtitle = "Y scale top-bottom, x scale on top"
			HLineChart2.Subtitle = "scale on the zoomed part"
			HLineChart2.ScalesOnZoomedPart = True
	End Select
	CreateHLineChartData
	
	HLineChart1.Visible = True
	HLineChart2.Visible = True

	HLineIndex = HLineIndex + 1
	If HLineIndex > 3 Then
		HLineIndex = 0
	End If
End Sub

Private Sub btnYXChart_Click
	HideCharts

	CreateYXChartData
	YXChart1.Visible = True
	
#If B4J
	btnPrint.Visible = True
#End If
	
	YXChartIndex = YXChartIndex + 1
	If YXChartIndex > 3 Then
		YXChartIndex = 0
	End If
	
	'saves the YXChart to a *.jpg file
	Private bmp As B4XBitmap
	Private Out As OutputStream
	xui.SetDataFolder("ChartsDemo")
	Out = File.OpenOutput(xui.DefaultFolder, "Test.jpg", False)
'	Log(xui.DefaultFolder)
	bmp = YXChart1.Snapshot
	bmp.WriteToStream(Out, 100, "JPEG")
	Out.Close
End Sub

Private Sub btnDynamicLines_Click
	HideCharts

	tmrDynamic.Enabled = True
	CreateDynamicData
	DrawDynamicLinePoints
	DynamicLines1.Visible = True
End Sub

Private Sub btnRadar_Click
	HideCharts

	CreateRadarChartData
	
	RadarChart1.Visible = True
End Sub

Private Sub btnSingleLine_Click
	HideCharts

	CreateSingleLineChartData
	SingleLine1.Visible = True
End Sub

Private Sub btnAreas_Click
	HideCharts

	CreateAreaData
	CreateStackedAreaData
	
	AreaChart1.Visible = True
	StackedAreaChart1.Visible = True
	
	AreaIndex = AreaIndex + 1
	If AreaIndex > 1 Then
		AreaIndex = 0
	End If
End Sub

Private Sub btnCandle_Click
	HideCharts

	CreateCandleData
	
	CandleChart1.Visible = True
End Sub

Private Sub btnWaterfall_Click
	HideCharts

	CreateWaterfallData
	
	Waterfall1.Visible = True
	
	WaterfallIndex = WaterfallIndex + 1
	If WaterfallIndex = 3 Then
		WaterfallIndex = 1
	End If
End Sub

Private Sub btnBubble_Click
	HideCharts

	CreateBubbleData
	
	Bubble1.Visible = True
	
	BubbleIndex = BubbleIndex + 1
	If BubbleIndex = 3 Then
		BubbleIndex = 1
	End If
End Sub

Private Sub HideCharts
	BarChart2.Visible = False
	StackedBarChart1.Visible = False
	PieChart1.Visible = False
	LineChart1.Visible = False
	BarChart1.Visible = False
	LineChart2.Visible = False
	DynamicLines1.Visible = False
	SingleLine1.Visible = False
	RadarChart1.Visible = False
	HBarChart1.Visible = False
	HStackedBarChart1.Visible = False
	AreaChart1.Visible = False
	StackedAreaChart1.Visible = False
	YXChart1.Visible = False
	HLineChart1.Visible = False
	HLineChart2.Visible = False
	CandleChart1.Visible = False
	Waterfall1.Visible = False
	Bubble1.Visible = False
	tmrDynamic.Enabled = False
#If B4J
	btnPrint.Visible = False
#End If
End Sub

Private Sub tmrDynamic_Tick
	If DynamicLines1.Visible = False Then
		tmrDynamic.Enabled = False
	End If
	DrawDynamicLinePoints
End Sub

Private Sub YXChart1_Touch(X As  Double, Y As Double)
	Log(X & " / " & Y)
End Sub

#If B4J
Private Sub btnPrint_Click
	Private bmpSnapShot As B4XBitmap
	Private imvDummy As ImageView
	
	imvDummy.Initialize("")
	
	If YXChart1.Visible = False Then
		YXChart1.Visible = True
	End If
	bmpSnapShot = YXChart1.Snapshot
	YXChart1.Visible = False
	
	Root.AddView(imvDummy, 0, 0, YXChart1.Width, YXChart1.Height)
	imvDummy.SetImage(bmpSnapShot)
	
	
	'Print with dialogs
	Private Answ As Boolean
	Dim PJ As PrinterJob = PrinterJob_Static.CreatePrinterJob
	Private P As Printer = PJ.GetPrinter
	Answ = PJ.ShowPageSetupDialog(Null)
	If Answ = True Then
		Answ = PJ.ShowPrintDialog(Null)
		If Answ = True Then
			Private DPL As PageLayout = P.GetDefaultPageLayout
			
			Private Scale As Double
			Private Orientation As String
			
			If DPL.GetPrintableWidth / DPL.GetPrintableHeight < bmpSnapShot.Width / bmpSnapShot.Height Then
				Orientation = "LANDSCAPE"
			Else
				Orientation = "PORTRAIT"
			End If
			
			Private PL As PageLayout
			PL = P.CreatePageLayout(DPL.GetPaper, Orientation, PL.GetLeftMargin, PL.GetRightMargin, PL.GetTopMargin, PL.GetBottomMargin)
			If Orientation = "LANDSCAPE" Then
				Scale = DPL.GetPrintableWidth / bmpSnapShot.Width
			Else
				Scale = DPL.GetPrintableHeight / bmpSnapShot.Height
			End If
			
			Private SJO As JavaObject
			SJO.InitializeNewInstance("javafx.scene.transform.Scale", Array(Scale, Scale))
			Private NJO As JavaObject = imvDummy
			NJO.RunMethodJO("getTransforms", Null).RunMethod("add", Array(SJO))
			
			PJ.PrintPage2(PL, imvDummy)
		End If
	End If
	PJ.EndJob
	imvDummy.RemoveNodeFromParent
End Sub
#End If
