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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private B4X3DVerticalBarChart1 As B4X3DVerticalBarChart
	Private B4X3DHorizontalBarChart1 As B4X3DHorizontalBarChart
	Private B4X3DColumnBarChart1 As B4X3DColumnBarChart
	Private B4X3DStackedBarChart1 As B4X3DStackedBarChart
	Private B4X3DPieChart1 As B4X3DPieChart
	Private B4X3DDonutChart1 As B4X3DDonutChart
	Private B4X3DLineChart1 As B4X3DLineChart
	Private B4X3DStackedAreaChart1 As B4X3DStackedAreaChart
	Private B4X3DCandlestickChart1 As B4X3DCandlestickChart
	Private B4X3DRadarChart1 As B4X3DRadarChart

	Private B4xCmbBoxChart As B4XComboBox
	Private BtnPrintChart As B4XView 'ignore
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	B4XPages.SetTitle(Me, "B4X 3D Charts")
#If B4J
	'B4XPages.GetNativeParent(Me).Resizable = False
	B4XPages.GetNativeParent(Me).Icon = XUI.LoadBitmap(File.DirAssets, "logo.png")
	
	BtnPrintChart.Visible = True
#End If

	B4xCmbBoxChart.SetItems(Array As String("Vertical Bar Chart", "Horizontal Bar Chart", "Column Bar Chart", "Stacked Bar Chart", "Pie Chart", "Donut Chart", "Line Chart", "Stacked Area Chart", "Candlestick Chart", "Radar Chart"))
	B4xCmbBoxChart_SelectedIndexChanged (0)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

private Sub B4xCmbBoxChart_SelectedIndexChanged (Index As Int)
	If B4X3DVerticalBarChart1.GetBase.Visible Then B4X3DVerticalBarChart1.GetBase.Visible = False
	If B4X3DHorizontalBarChart1.GetBase.Visible Then B4X3DHorizontalBarChart1.GetBase.Visible = False
	If B4X3DColumnBarChart1.GetBase.Visible Then B4X3DColumnBarChart1.GetBase.Visible = False
	If B4X3DStackedBarChart1.GetBase.Visible Then B4X3DStackedBarChart1.GetBase.Visible = False
	If B4X3DDonutChart1.GetBase.Visible Then B4X3DDonutChart1.GetBase.Visible = False
	If B4X3DPieChart1.GetBase.Visible Then B4X3DPieChart1.GetBase.Visible = False
	If B4X3DLineChart1.GetBase.Visible Then B4X3DLineChart1.GetBase.Visible = False
	If B4X3DStackedAreaChart1.GetBase.Visible Then B4X3DStackedAreaChart1.GetBase.Visible = False
	If B4X3DCandlestickChart1.GetBase.Visible Then B4X3DCandlestickChart1.GetBase.Visible = False
	If B4X3DRadarChart1.GetBase.Visible Then B4X3DRadarChart1.GetBase.Visible = False

	Select Index
		Case 0
			B4X3DVerticalBarChart1.Clear
			B4X3DVerticalBarChart1.GetBase.Visible = True
			B4X3DVerticalBarChart1.Title = "Monthly Performance"
			B4X3DVerticalBarChart1.SubTitle = "Q1 - Q2 Overview"
			B4X3DVerticalBarChart1.XAxisTitle = "Month"
			B4X3DVerticalBarChart1.YAxisTitle = "New customers"
			'B4X3DVerticalBarChart1.ValueOrientation = "Vertical"
			B4X3DVerticalBarChart1.ShowMeanLine = True
			B4X3DVerticalBarChart1.MeanLineColor = 0xFFFF00C9
			B4X3DVerticalBarChart1.ShowTouchLine = True
			B4X3DVerticalBarChart1.TouchLineColor = 0xFFFF8C00
			B4X3DVerticalBarChart1.GridSteps = 8
			B4X3DVerticalBarChart1.ShowValues = True
			B4X3DVerticalBarChart1.ShowPopupLegend = True

			Dim Month() As String = Array As String("Jan", "Feb", "Mar", "Apr", "May", "Jun")
			For i = 0 To 5
				B4X3DVerticalBarChart1.AddValue(Rnd(100, 1000), Month(i))
			Next
		Case 1
			B4X3DHorizontalBarChart1.Clear
			B4X3DHorizontalBarChart1.GetBase.Visible = True
			B4X3DHorizontalBarChart1.Title = "Regional Market Share"
			B4X3DHorizontalBarChart1.SubTitle = "2026 Direct Comparison"
			B4X3DHorizontalBarChart1.XAxisTitle = "Share percentage (%)"
			B4X3DHorizontalBarChart1.YAxisTitle = "Country"
			B4X3DHorizontalBarChart1.ShowMeanLine = True
			B4X3DHorizontalBarChart1.MeanLineColor = 0xFFFF00C9
			B4X3DHorizontalBarChart1.ShowTouchLine = True
			B4X3DHorizontalBarChart1.TouchLineColor = 0xFFFF8C00
			B4X3DHorizontalBarChart1.GridSteps = 8
			B4X3DHorizontalBarChart1.ShowValues = True
			B4X3DHorizontalBarChart1.ShowPopupLegend = True

			Dim Vals As List = GenRandomValuesSum100(10)
			Dim Country() As String = Array As String("USA", "UK", "Japan", "Germany", "China", "France", "Italy", "India", "Russia", "Brazil")
			For i = 0 To 9
				B4X3DHorizontalBarChart1.AddValue(Vals.Get(i), Country(i))
			Next
		Case 2
			B4X3DColumnBarChart1.Clear
			B4X3DColumnBarChart1.GetBase.Visible = True
			B4X3DColumnBarChart1.Title = "Acme Tool Sales"
			B4X3DColumnBarChart1.SubTitle = "Units sold"
			B4X3DColumnBarChart1.XAxisTitle = "Quarters"
			B4X3DColumnBarChart1.YAxisTitle = "Units Sold"
			B4X3DColumnBarChart1.SetCategories(Array As String("Q1", "Q2", "Q3", "Q4"))
			'B4X3DColumnBarChart1.ValueOrientation = "Vertical"
			B4X3DColumnBarChart1.ShowMeanLine = True
			B4X3DColumnBarChart1.MeanLineColor = 0xFFFF00C9
			B4X3DColumnBarChart1.ShowTouchLine = True
			B4X3DColumnBarChart1.TouchLineColor = 0xFFFF8C00
			B4X3DColumnBarChart1.GridSteps = 8
			B4X3DColumnBarChart1.ShowValues = True
			B4X3DColumnBarChart1.ShowLegend = True
			B4X3DColumnBarChart1.ShowLegendValues = False
			B4X3DColumnBarChart1.ShowLegendOnChart = False
			B4X3DColumnBarChart1.ShowPopupLegend = True
			B4X3DColumnBarChart1.ShowPopupLegendTotal = False

			Dim Tool() As String = Array As String("Saw", "Hammer", "Drill")
			Dim Colour() As Int = Array As Int(XUI.Color_RGB(77, 137, 249), XUI.Color_RGB(255, 99, 51), XUI.Color_RGB(46, 179, 75))
			For i = 0 To 2
				B4X3DColumnBarChart1.AddSeries(Tool(i), Array As Float(Rnd(180, 400), Rnd(180, 400), Rnd(180, 400), Rnd(180, 400)), Colour(i))
			Next
		Case 3
			B4X3DStackedBarChart1.Clear
			B4X3DStackedBarChart1.GetBase.Visible = True
			B4X3DStackedBarChart1.Title = "Quarterly Revenue Breakdown"
			B4X3DStackedBarChart1.SubTitle = "Sales by Region (£ GPB)"
			B4X3DStackedBarChart1.SetCategories(Array As String("Q1", "Q2", "Q3", "Q4"))
			B4X3DStackedBarChart1.XAxisTitle = "Quarters"
			B4X3DStackedBarChart1.YAxisTitle = "Revenue (£ GBP)"
			B4X3DStackedBarChart1.ShowTouchLine = True
			B4X3DStackedBarChart1.TouchLineColor = 0xFFFF8C00
			B4X3DStackedBarChart1.GridSteps = 8
			B4X3DStackedBarChart1.ShowValues = True
			B4X3DStackedBarChart1.ShowLegend = True
			B4X3DStackedBarChart1.ShowLegendValues = False
			B4X3DStackedBarChart1.ShowLegendOnChart = False
			B4X3DStackedBarChart1.ShowPopupLegend = True
			B4X3DStackedBarChart1.ShowPopupLegendTotal = False

			Dim Region() As String = Array As String("North America", "Europe", "Asia Pacific")
			Dim Colour() As Int = Array As Int(XUI.Color_RGB(33, 150, 243), XUI.Color_RGB(76, 175, 80), XUI.Color_RGB(255, 152, 0))
			For i = 0 To 2
				B4X3DStackedBarChart1.AddSeries(Region(i), Array As Float(Rnd(1000, 10000), Rnd(1000, 10000), Rnd(1000, 10000), Rnd(1000, 10000)), Colour(i))
			Next
		Case 4
			B4X3DPieChart1.Clear
			B4X3DPieChart1.GetBase.Visible = True
			B4X3DPieChart1.Title = "Software Engineering Tasks"
			B4X3DPieChart1.SubTitle = "Weekly Workload Breakdown (%)"
			B4X3DPieChart1.LegendPosition = "None"
			B4X3DPieChart1.LegendTitle = ""
			B4X3DPieChart1.LabelLineLength = 15
			B4X3DPieChart1.ShowValues = True
			B4X3DPieChart1.ShowPopupLegend = True
			
			Dim Vals As List = GenRandomValuesSum100(7)
			Dim Job() As String = Array As String("Feature Dev", "Bug Fixing", "Code Review", "Unit Testing", "Refactoring", "Documentation", "Deployment")
			Dim Colour() As Int = Array As Int(XUI.Color_RGB(33, 150, 243), XUI.Color_RGB(244, 67, 54), XUI.Color_RGB(156, 39, 176), XUI.Color_RGB(76, 175, 80), XUI.Color_RGB(255, 152, 0), XUI.Color_RGB(0, 150, 136), XUI.Color_RGB(121, 85, 72))
			For i = 0 To 6
				B4X3DPieChart1.AddSlice(Vals.Get(i), Colour(i), Job(i))
			Next
		Case 5
			B4X3DDonutChart1.Clear
			B4X3DDonutChart1.GetBase.Visible = True
			B4X3DDonutChart1.Title = "Software Engineering Tasks"
			B4X3DDonutChart1.SubTitle = "Weekly Workload Breakdown (%)"
			B4X3DDonutChart1.LegendPosition = "None"
			B4X3DDonutChart1.LegendTitle = ""
			B4X3DDonutChart1.LabelLineLength = 15
			B4X3DDonutChart1.ShowValues = True
			B4X3DDonutChart1.ShowPopupLegend = True

			Dim Vals As List = GenRandomValuesSum100(7)
			Dim Job() As String = Array As String("Feature Dev", "Bug Fixing", "Code Review", "Unit Testing", "Refactoring", "Documentation", "Deployment")
			Dim Colour() As Int = Array As Int(XUI.Color_RGB(33, 150, 243), XUI.Color_RGB(244, 67, 54), XUI.Color_RGB(156, 39, 176), XUI.Color_RGB(76, 175, 80), XUI.Color_RGB(255, 152, 0), XUI.Color_RGB(0, 150, 136), XUI.Color_RGB(121, 85, 72))
			For i = 0 To 6
				B4X3DDonutChart1.AddSlice(Vals.Get(i), Colour(i), Job(i))
			Next
		Case 6
			B4X3DLineChart1.Clear
			B4X3DLineChart1.GetBase.Visible = True
			B4X3DLineChart1.Title = "Server Network Traffic"
			B4X3DLineChart1.SubTitle = "Bandwidth Usage Over Time (Gbps)"
			B4X3DLineChart1.XAxisTitle = "Time"
			B4X3DLineChart1.YAxisTitle = "Bandwidth (Gbps)"
			B4X3DLineChart1.ShowMeanLine = True
			B4X3DLineChart1.ShowMeanLines = True
			B4X3DLineChart1.MeanLineColor = 0xFFFF00C9
			B4X3DLineChart1.ShowTouchLine = True
			B4X3DLineChart1.TouchLineColor = 0xFFFF8C00
			B4X3DLineChart1.GridSteps = 8
			B4X3DLineChart1.ShowValues = True
			B4X3DLineChart1.ShowLegend = True
			B4X3DLineChart1.ShowLegendOnChart = False
			B4X3DLineChart1.ShowPopupLegend = True
			B4X3DLineChart1.ShowPopupLegendTotal = False
			B4X3DLineChart1.ShowPoints = True 'Use in conjunction with DropDepth (below)
			'B4X3DLineChart1.DropDepth = 1 'Set to 1, 2 or 3 for ShowPoints (above) to work

			B4X3DLineChart1.SetCategories(Array As String("00:00", "04:00", "08:00", "12:00", "16:00", "20:00"))
			B4X3DLineChart1.AddSeries("Transmit", Array As Float(Rnd(25, 50), Rnd(25, 50), Rnd(25, 50), Rnd(25, 50), Rnd(25, 50), Rnd(25, 50)), XUI.Color_RGB(33, 150, 243))
			B4X3DLineChart1.AddSeries("Receive", Array As Float(Rnd(70, 95), Rnd(70, 95), Rnd(70, 95), Rnd(70, 95), Rnd(70, 95), Rnd(70, 95)), XUI.Color_RGB(76, 175, 80))
		Case 7
			B4X3DStackedAreaChart1.Clear
			B4X3DStackedAreaChart1.GetBase.Visible = True
			B4X3DStackedAreaChart1.XAxisTitle = "Time"
			B4X3DStackedAreaChart1.YAxisTitle = "Bandwidth (Gbps)"

			'Set Categories (X-Axis Labels)
			Dim cats As List = Array As String("00:00", "04:00", "08:00", "12:00", "16:00", "20:00")
			B4X3DStackedAreaChart1.SetCategories(cats)

			'Set Properties
			B4X3DStackedAreaChart1.Title = "Server Network Traffic"
			B4X3DStackedAreaChart1.SubTitle = "Bandwidth Usage Over Time (Gbps)"
			B4X3DStackedAreaChart1.Depth = 20
			B4X3DStackedAreaChart1.ShowTouchLine = True
			B4X3DStackedAreaChart1.TouchLineColor = 0xFFFF8C00
			B4X3DStackedAreaChart1.GridSteps = 8
			B4X3DStackedAreaChart1.ShowLegend = True
			B4X3DStackedAreaChart1.ShowValues = True
			B4X3DStackedAreaChart1.ShowLegendOnChart = False
			B4X3DStackedAreaChart1.ShowPopupLegend = True
			B4X3DStackedAreaChart1.ShowPopupLegendTotal = False

			Dim s1Values As List = Array As Float(Rnd(1, 75), Rnd(1, 75), Rnd(1, 75), Rnd(1, 75), Rnd(1, 75), Rnd(1, 75))
			B4X3DStackedAreaChart1.AddSeries("HTTP", XUI.Color_RGB(33, 150, 243), s1Values)

			Dim s2Values As List = Array As Float(Rnd(1, 75), Rnd(1, 75), Rnd(1, 75), Rnd(1, 75), Rnd(1, 75), Rnd(1, 75))
			B4X3DStackedAreaChart1.AddSeries("FTP", XUI.Color_RGB(76, 175, 80), s2Values)

			Dim s3Values As List = Array As Float(Rnd(1, 75), Rnd(1, 75), Rnd(1, 75), Rnd(1, 75), Rnd(1, 75), Rnd(1, 75))
			B4X3DStackedAreaChart1.AddSeries("SSH", XUI.Color_RGB(255, 152, 0), s3Values)
		Case 8
			B4X3DCandlestickChart1.Clear
			B4X3DCandlestickChart1.GetBase.Visible = True
			B4X3DCandlestickChart1.XAxisTitle = "Trading Period: Last 28 Days"
			B4X3DCandlestickChart1.YAxisTitle = "Price ($ USD)"
			B4X3DCandlestickChart1.Title = "AAPL Stock Price"
			B4X3DCandlestickChart1.SubTitle = "3D Daily OHLC Candlesticks"
			B4X3DCandlestickChart1.ShowTouchLine = True
			B4X3DCandlestickChart1.TouchLineColor = 0xFFFF8C00
			B4X3DCandlestickChart1.GridSteps = 8
			B4X3DCandlestickChart1.ShowPopupLegend = True

			'Generate 28 trading days of sample stock data
			Dim currentPrice As Float = Rnd(125, 175)

			For i = 27 To 0 Step -1
				' Generate random price movements
				Dim change As Float = (Rnd(-300, 320) / 100.0)
				Dim openPrice As Float = currentPrice
				Dim closePrice As Float = openPrice + change

				' High must be higher than both Open and Close; Low must be lower
				Dim highPrice As Float = Max(openPrice, closePrice) + (Rnd(20, 150) / 100.0)
				Dim lowPrice As Float = Min(openPrice, closePrice) - (Rnd(20, 150) / 100.0)

				' Format date label going back from today
				Dim dayTicks As Long = DateTime.Add(DateTime.Now, 0, 0, -i)
				DateTime.DateFormat = "d MMM"
				Dim dateStr As String = DateTime.Date(dayTicks)

				' Add candlestick to the chart
				B4X3DCandlestickChart1.AddCandle(openPrice, highPrice, lowPrice, closePrice, dateStr)

				' Next open price starts near previous close
				currentPrice = closePrice
			Next
		Case 9
			B4X3DRadarChart1.Clear
			B4X3DRadarChart1.GetBase.Visible = True
			B4X3DRadarChart1.Title = "Country GDP Chart"
			B4X3DRadarChart1.SubTitle = "Global Performance Metrics"
			B4X3DRadarChart1.ShowLegend = True
			B4X3DRadarChart1.ShowValues = False
			B4X3DRadarChart1.ShowLegendOnChart = False
			B4X3DRadarChart1.ShowPopupLegend = True

			Dim radarCats As List = Array As String("France", "Canada", "Germany", "USA", "Italy", "Spain", "Russia", "Sweden", "Japan")
			B4X3DRadarChart1.SetCategories(radarCats)

			Dim s1Vals As List = Array As Float(Rnd(100, 150), Rnd(100, 150), Rnd(100, 150), Rnd(100, 150), Rnd(100, 150), Rnd(100, 150), Rnd(100, 150), Rnd(100, 150), Rnd(100, 150))
			B4X3DRadarChart1.AddSeries(DateTime.GetYear(DateTime.Now), XUI.Color_RGB(33, 150, 243), s1Vals)

			Dim s2Vals As List = Array As Float(Rnd(50, 95), Rnd(50, 95), Rnd(50, 95), Rnd(50, 95), Rnd(50, 95), Rnd(50, 95), Rnd(50, 95), Rnd(50, 95), Rnd(50, 95))
			B4X3DRadarChart1.AddSeries("1966", XUI.Color_RGB(255, 152, 0), s2Vals)
	End Select
End Sub

Private Sub B4X3DVerticalBarChart1_ItemTouch (Result As VerticalBarTouchResult)
	If Result = Null Then
		Log("Touch/Swipe ended or moved off chart")
	Else
		Log($"Bar Index: ${Result.Index}"$)
		Log($"Value: ${Result.Value}"$)
		Log($"Label: ${Result.Label}"$)
	End If
End Sub

Private Sub B4X3DHorizontalBarChart1_ItemTouch (Result As HorizontalBarTouchResult)
	If Result = Null Then
		Log("Touch/Swipe ended or moved off chart")
	Else
		Log($"Bar Index: ${Result.Index}"$)
		Log($"Value: ${Result.Value}"$)
		Log($"Label: ${Result.Label}"$)
	End If
End Sub

Private Sub B4X3DStackedBarChart1_ItemTouch (Result As StackedBarTouchResult)
	If Result = Null Then
		Log("Touch/Swipe ended or moved off chart")
	Else
		Log($"Category: ${Result.CategoryLabel}"$)
		Log($"Total Stack Sum: ${Result.StackSum}"$)

		For Each SeriesName As String In Result.StackValues.Keys
			Dim SeriesValue As Float = Result.StackValues.Get(SeriesName)
			Log($"Series: ${SeriesName} = ${SeriesValue}"$)
		Next		
	End If
End Sub

Sub B4X3DColumnBarChart1_ItemTouch (Result As ColumnBarTouchResult)
	If Result = Null Then
		Log("Touch/Swipe ended or moved off chart")
	Else
		Log($"Category: ${Result.CategoryLabel}"$)
		Log($"Column Total Sum: ${Result.ColumnSum}"$)

		For Each SeriesName As String In Result.ColumnValues.Keys
			Dim SeriesValue As Float = Result.ColumnValues.Get(SeriesName)
			Log($"Series: ${SeriesName} = ${SeriesValue}"$)
		Next		
	End If
End Sub

Private Sub B4X3DPieChart1_ItemTouch (Result As PieTouchResult)
	If Result = Null Then
		Log("Touch/Swipe ended or moved off chart")
	Else
		Log($"Slice Index: ${Result.Index}"$)
		Log($"Value: ${Result.Value}"$)
		Log($"Label: ${Result.Label}"$)		
	End If
End Sub

Private Sub B4X3DDonutChart1_ItemTouch (Result As DonutTouchResult)
	If Result = Null Then
		Log("Touch/Swipe ended or moved off chart")
	Else
		Log($"Slice Index: ${Result.Index}"$)
		Log($"Value: ${Result.Value}"$)
		Log($"Label: ${Result.Label}"$)			
	End If
End Sub

Private Sub B4X3DLineChart1_ItemTouch (Result As LinePointTouchResult)
	If Result = Null Then
		Log("Touch/Swipe ended or moved off chart")
	Else
		Log($"Category: ${Result.CategoryLabel}"$)
		Log($"Category Total: ${Result.CategoryTotal}"$)

		For Each SeriesName As String In Result.StackValues.Keys
			Dim SeriesValue As Float = Result.StackValues.Get(SeriesName)
			Log($"Series: ${SeriesName} = ${SeriesValue}"$)
		Next		
	End If
End Sub

Private Sub B4X3DStackedAreaChart1_ItemTouch (Result As StackedAreaTouchResult)
	If Result = Null Then
		Log("Touch/Swipe ended or moved off chart")
	Else
		Log($"Category: ${Result.CategoryLabel}"$)
		Log($"Stack Total Sum: ${Result.StackSum}"$)

		For Each SeriesName As String In Result.StackValues.Keys
			Dim SeriesValue As Float = Result.StackValues.Get(SeriesName)
			Log($"Series: ${SeriesName} = ${SeriesValue}"$)
		Next
	End If
End Sub

Private Sub B4X3DCandlestickChart1_ItemTouch (Result As CandleTouchResult)
	If Result = Null Then
		Log("Touch/Swipe ended or moved off chart")
	Else
		Log($"Candle Index: ${Result.Index}"$)
		Log($"Date: ${Result.DateLabel}"$)
		Log($"Open: ${Result.OpenVal}"$)
		Log($"High: ${Result.HighVal}"$)
		Log($"Low: ${Result.LowVal}"$)
		Log($"Close: ${Result.CloseVal}"$)
	End If
End Sub

Private Sub B4X3DRadarChart1_ItemTouch (Result As RadarTouchResult)
	If Result = Null Then
		Log("Touch/Swipe ended or moved off chart")
	Else
		Log($"Series: ${Result.SeriesName} (Index: ${Result.SeriesIndex})"$)
		Log($"Category: ${Result.CategoryLabel} (Index: ${Result.PointIndex})"$)
		Log($"Value: ${Result.Value}"$)
	End If
End Sub

'Returns specified number of values that total 100
Public Sub GenRandomValuesSum100 (GetValues As Int) As List
	Dim Values As List
		Values.Initialize

	' Generate random split points between 1 and 99
	Dim Cuts As List
		Cuts.Initialize

	Do While Cuts.Size < GetValues - 1
		Dim p As Int = Rnd(1, 100)
		If Cuts.IndexOf(p) = -1 Then Cuts.Add(p)
	Loop

	' Sort the split points
	Cuts.Sort(True)

	' Calculate differences to get parts that total 100
	Dim LastCut As Int = 0
	For i = 0 To Cuts.Size - 1
		Dim currentCut As Int = Cuts.Get(i)
		Values.Add(currentCut - LastCut)
		LastCut = currentCut
	Next
	Values.Add(100 - LastCut)

	Return Values
End Sub

#Region PRINT CHARTS (Using inline Java) 

#If B4J
Private Sub BtnPrintChart_Click
	Dim IV As ImageView
		IV.Initialize("")
		IV.SetSize(810, 555) 'A great ImageView/Form size for printing on A4 paper

	Select B4xCmbBoxChart.SelectedIndex
		Case 0
			IV.SetImage(B4X3DVerticalBarChart1.Snapshot)
			PrintContent(IV, True, True, "A4", 20, 20, 20,20, "DRAFT", "Vertical Bar Chart")
		Case 1
			IV.SetImage(B4X3DHorizontalBarChart1.Snapshot)
			PrintContent(IV, True, True, "A4", 20, 20, 20,20, "HIGH", "Horizontal Bar Chart")
		Case 2
			IV.SetImage(B4X3DColumnBarChart1.Snapshot)
			PrintContent(IV, True, True, "A4", 20, 20, 20,20, "HIGH", "Column Bar Chart")
		Case 3
			IV.SetImage(B4X3DStackedBarChart1.Snapshot)
			PrintContent(IV, True, True, "A4", 20, 20, 20,20, "HIGH", "Stacked Bar Chart")
		Case 4
			IV.SetImage(B4X3DPieChart1.Snapshot)
			PrintContent(IV, True, True, "A4", 20, 20, 20,20, "HIGH", "Pie Chart")
		Case 5
			IV.SetImage(B4X3DDonutChart1.Snapshot)
			PrintContent(IV, True, True, "A4", 20, 20, 20,20, "HIGH", "Donut Chart")
		Case 6
			IV.SetImage(B4X3DLineChart1.Snapshot)
			PrintContent(IV, True, True, "A4", 20, 20, 20,20, "HIGH", "Line Chart")
		Case 7
			IV.SetImage(B4X3DStackedAreaChart1.Snapshot)
			PrintContent(IV, True, True, "A4", 20, 20, 20,20, "HIGH", "Stacked Area Chart")
		Case 8
			IV.SetImage(B4X3DCandlestickChart1.Snapshot)
			PrintContent(IV, True, True, "A4", 20, 20, 20,20, "HIGH", "Candlestick Chart")
		Case 9
			IV.SetImage(B4X3DRadarChart1.Snapshot)
			PrintContent(IV, True, True, "A4", 20, 20, 20,20, "HIGH", "Radar Chart")
	End Select
End Sub

'Prints a UI layout, form, or image using native JavaFX printing.
'Target: The object to print. Pass a layout root (B4XView) or an ImageView containing a bitmap.
'ShowDialog: True to show the system print dialog, False to print directly to the default printer.
'IsLandscape: True for landscape orientation, False for portrait.
'PaperSize: Standard paper size as a string (e.g., "A4", "A3", "LETTER", "LEGAL").
'Top, Right, Bottom, Left: Margins in typographical points (72 points = 1 inch).
'Quality: Print quality level. Options: "HIGH", "NORMAL", "LOW", or "DRAFT".
'JobName: The name of the print job (used for the print queue or default PDF filename).
Public Sub PrintContent(Target As Object, ShowDialog As Boolean, IsLandscape As Boolean, PaperSize As String, Top As Double, Right As Double, Bottom As Double, Left As Double, Quality As String, JobName As String)
	Dim MeJO As JavaObject = Me
	Dim TargetJO As JavaObject = Target

	MeJO.RunMethod("printAnyNode", Array(TargetJO, ShowDialog, IsLandscape, PaperSize, Top, Right, Bottom, Left, Quality, JobName))
End Sub
#End If

#If B4J
#If Java
import javafx.print.PrinterJob;
import javafx.print.Printer;
import javafx.print.PageLayout;
import javafx.print.Paper;
import javafx.print.PageOrientation;
import javafx.print.PrintQuality;
import javafx.scene.Node;
import javafx.application.Platform;
import java.util.Set;

public void printAnyNode(final Node node, final boolean showDialog, final boolean isLandscape, final String paperSizeStr, final double top, final double right, final double bottom, final double left, final String qualityStr, final String jobName) {
    Platform.runLater(() -> {
        PrinterJob job = PrinterJob.createPrinterJob();
        if (job != null) {
            Printer printer = job.getPrinter();

            // Paper Size setup
            Paper paper = Paper.A4;
            if (paperSizeStr != null) {
                switch(paperSizeStr.toUpperCase().replace(" ", "_")) {
                    case "A0": paper = Paper.A0; break;
                    case "A1": paper = Paper.A1; break;
                    case "A2": paper = Paper.A2; break;
                    case "A3": paper = Paper.A3; break;
                    case "A4": paper = Paper.A4; break;
                    case "A5": paper = Paper.A5; break;
                    case "A6": paper = Paper.A6; break;
                    case "LEGAL": paper = Paper.LEGAL; break;
                    case "LETTER":
                    case "NA_LETTER": paper = Paper.NA_LETTER; break;
                    case "TABLOID": paper = Paper.TABLOID; break;
                    case "JAPANESE_POSTCARD": paper = Paper.JAPANESE_POSTCARD; break;
                }
            }

            // Page setup
            PageOrientation orientation = isLandscape ? PageOrientation.LANDSCAPE : PageOrientation.PORTRAIT;
            PageLayout pageLayout = printer.createPageLayout(paper, orientation, left, right, top, bottom);
            job.getJobSettings().setPageLayout(pageLayout);

            // Quality setup
            PrintQuality quality = PrintQuality.NORMAL;
            if (qualityStr != null) {
                switch(qualityStr.toUpperCase()) {
                    case "HIGH": quality = PrintQuality.HIGH; break;
                    case "DRAFT": quality = PrintQuality.DRAFT; break;
                    case "LOW": quality = PrintQuality.LOW; break;
                }
            }
            
            Set<PrintQuality> supportedQualities = printer.getPrinterAttributes().getSupportedPrintQuality();
            if (supportedQualities != null && supportedQualities.contains(quality)) {
                job.getJobSettings().setPrintQuality(quality);
            } else {
                job.getJobSettings().setPrintQuality(PrintQuality.NORMAL);
            }

            // Job Name setup
            if (jobName != null && !jobName.isEmpty()) {
                job.getJobSettings().setJobName(jobName);
            }

            // Print dialog & execution
            boolean proceed = true;
            if (showDialog) {
                proceed = job.showPrintDialog(node.getScene() != null ? node.getScene().getWindow() : null);
            }
            
            if (proceed) {
                boolean success = job.printPage(node);
                if (success) {
                    job.endJob();
                }
            }
        }
    });
}
#End If
#End If

#End Region 
