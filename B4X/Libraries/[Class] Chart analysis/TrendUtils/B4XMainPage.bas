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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private xChartLines As xChart
	Private lbl As B4XView
	Private cbo As B4XComboBox
	Private xChart2 As xChart
	Dim t As Trend
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(B4XPages.MainPage, "Trends analysis")
	Dim L As List
	L.Initialize
	L.Add("--SELECT--")
	L.Add("Rising chart")
	L.Add("Falling chart")
	L.Add("Wobbling chart")
	L.Add("Chart with maximum")
	L.Add("Chart with minimum")
	L.Add("Custom chart")
	cbo.SetItems(L)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

'Draw part of the data set, from StartPercent upto StopPercent
Sub Draw(Name As String, m As Map, StartPercent As Int, StopPercent As Int)
	Dim count As Int = m.Size
	Dim StartPercent2 As Int = StartPercent * count / 100
	Dim StopPercent2 As Int = StopPercent * count / 100
	
	xChartLines.ClearData
	xChartLines.AddLine2(Name, xui.Color_Green, 2dip, "CIRCLE", True, xui.Color_LightGray)
	For i = StartPercent2 To StopPercent2 - 1
		xChartLines.AddLinePointData(m.GetKeyAt(i), m.GetValueAt(i), True)
	Next
	xChartLines.DrawChart
	xChartLines.Visible = True
End Sub

'Draw second chart, from StartPercent upto StopPercent
Sub Draw2(Name As String, m As Map, StartPercent As Int, StopPercent As Int)
	Dim count As Int = m.Size
	Dim StartPercent2 As Int = StartPercent * count / 100
	Dim StopPercent2 As Int = StopPercent * count / 100
	
	xChart2.ClearData
	xChart2.AddLine2(Name, xui.Color_Green, 2dip, "CIRCLE", True, xui.Color_LightGray)
	For i = StartPercent2 To StopPercent2 - 1
		xChart2.AddLinePointData(m.GetKeyAt(i), m.GetValueAt(i), True)
	Next
	xChart2.DrawChart
	xChart2.Visible = True
End Sub

Sub logg(s As String)
	Log(s)
	lbl.Text = s & CRLF & lbl.Text
	Sleep(0)
End Sub

Sub SortMapKeys (m As Map, SortAsc As Boolean)
	Try
		If m.IsInitialized = False Or m.Size = 0 Then Return

		Private KeysList As List:KeysList.Initialize
		Private m1 As Map:m1.Initialize
		Private m2 As Map:m2.Initialize
		
		For i = 0 To m.Size - 1
			Private key As String = m.GetKeyAt(i)
			Private key2 As String
			If IsNumber(key) Then
				key2 = NumberFormat2(key, 5, 0, 0, False)
			Else
				key2 = key
			End If
			
			m1.Put(key2, m.GetValueAt(i))
			KeysList.Add(key2)
		Next
		
		KeysList.SortCaseInsensitive(SortAsc)

		For x=0 To KeysList.Size - 1
			Private key As String = KeysList.Get(x)
			Private val As Object = m1.Get(key)
			m2.Put(key, val)
		Next
		m.Clear
		For Each m2Key As String In m2.Keys
			m.Put(m2Key, m2.Get(m2Key))
		Next
		'Log("m sorted:" & m)
	Catch
		Log("SortMapKeys.error: " & LastException)
	End Try
End Sub


Private Sub cbo_SelectedIndexChanged (Index As Int)
	Dim st As Int = 0	'start %
	Dim fin As Int = 100	'stop %
	
	Select Index
		Case 0
			xChartLines.Visible = False
			xChart2.Visible = False
		Case 1	'"Rising chart"
			t.Initialize
			Dim RisingMap As Map = CreateMap("0":10, "1":13, "2":16, "3":19, "4":30, "5":35, "6":34, "7":38, "8":45, "9":49, "10":50, "11":70)
			t.DataMapToTrend(RisingMap)
			logg("RisingMap isRising = " & t.isRisingY(st, fin))
'			logg("RisingMap isFalling = " & t.isFallingY(st, fin).falling)
'			logg("RisingMap isWobbling = " & t.isWobblingY(st, fin).wobbling)
'			logg("RisingMap hasMaximum = " & t.hasMaximum(st, fin).hasMaxY)
'			logg("RisingMap hasMinimum = " & t.hasMinimum(st, fin).hasMinY)
'			logg("RisingMap isStable within 30% = " & t.isStableY(30, st, fin))
'			logg("RisingMap auto = " & t.AutoAnalysis1(st, fin))
			
			Draw("Rising", RisingMap, st, fin)
			Dim m As Map = t.AutoAnalysis2(st, fin)
			Draw2("Approx", m, st, fin)
			
			logg(t.AutoAnalysis_Whole_Simple)
			logg("---------")
			t.Close
		Case 2	'"Falling chart"
			t.Initialize
			Dim FallingMap As Map = CreateMap("0":100, "1":90, "2":70, "3":60, "4":50, "5":40, "6":30, "7":20, "8":10, "9":5, "10":3, "11":1)
			t.DataMapToTrend(FallingMap)
'			logg("FallingMap isRising = " & t.isRisingY(st, fin).rising)
			logg("FallingMap isFalling = " & t.isFallingY(st, fin))
'			logg("FallingMap isWobbling = " & t.isWobblingY(st, fin).wobbling)
'			logg("FallingMap hasMaximum = " & t.hasMaximum(st, fin).hasMaxY)
'			logg("FallingMap hasMinimum = " & t.hasMinimum(st, fin).hasMinY)
'			logg("FallingMap isStable within 30% = " & t.isStableY(30, st, fin))
'			logg("FallingMap auto = " & t.AutoAnalysis1(st, fin))

			Draw("Falling", FallingMap, st, fin)
			Dim m As Map = t.AutoAnalysis2(st, fin)
			Draw2("Approx", m, st, fin)
			
			logg(t.AutoAnalysis_Whole_Simple)
			logg("---------")
			t.Close
		Case 3	'"Wobbling chart"
			t.Initialize
			Dim WobblingMap As Map = CreateMap("0":10, "1":13, "2":16, "3":14, "4":9, "5":15, "6":19, "7":11, "8":20, "9":17, "10":13, "11":19)
			t.DataMapToTrend(WobblingMap)
'			logg("WobblingMap isRising = " & t.isRisingY(st, fin).rising)
'			logg("WobblingMap isFalling = " & t.isFallingY(st, fin).falling)
			logg("WobblingMap isWobbling = " & t.isWobblingY(st, fin))
'			logg("WobblingMap hasMaximum = " & t.hasMaximum(st, fin).hasMaxY)
'			logg("WobblingMap hasMinimum = " & t.hasMinimum(st, fin).hasMinY)
'			logg("WobblingMap isStable within 100% = " & t.isStableY(100, st, fin))
'			logg("WobblingMap auto = " & t.AutoAnalysis1(st, fin))
			Draw("Wobbling", WobblingMap, st, fin)

			Dim m As Map = t.AutoAnalysis2(st, fin)
			Draw2("Approx", m, st, fin)
			logg(t.AutoAnalysis_Whole_Simple)
			logg("---------")
			t.Close
		Case 4	'"Chart with maximum"
			t.Initialize
			Dim MaximumMap As Map = CreateMap("0":10, "1":13, "2":16, "3":19, "4":30, "5":35, "6":53, "7":46, "8":41, "9":34, "10":25, "11":20)
			t.DataMapToTrend(MaximumMap)
'			logg("MaximumMap isRising = " & t.isRisingY(st, fin).rising)
'			logg("MaximumMap isFalling = " & t.isFallingY(st, fin).falling)
'			logg("MaximumMap isWobbling = " & t.isWobblingY(st, fin).wobbling)
			logg("MaximumMap hasMaximum = " & t.hasMaximum(st, fin))
'			logg("MaximumMap hasMinimum = " & t.hasMinimum(st, fin).hasMinY)
'			logg("MaximumMap isStable within 30% = " & t.isStableY(30, st, fin))
'			logg("MaximumMap auto = " & t.AutoAnalysis1(st, fin))
			Draw("Max", MaximumMap, st, fin)
			Dim m As Map = t.AutoAnalysis2(st, fin)
			Draw2("Approx", m, st, fin)
			logg(t.AutoAnalysis_Whole_Simple)
			logg("---------")
			t.Close
		Case 5	'"Chart with minimum"
			t.Initialize
			Dim MinimumMap As Map = CreateMap("0":100, "1":90, "2":0, "3":30, "4":60, "5":35, "6":40, "7":46, "8":49, "9":60, "10":70, "11":90)
			t.DataMapToTrend(MinimumMap)
'			logg("MinimumMap isRising = " & t.isRisingY(st, fin).rising)
'			logg("MinimumMap isFalling = " & t.isFallingY(st, fin).falling)
'			logg("MinimumMap isWobbling = " & t.isWobblingY(st, fin).wobbling)
'			logg("MinimumMap hasMaximum = " & t.hasMaximum(st, fin).hasMaxY)
			logg("MinimumMap hasMinimum = " & t.hasMinimum(st, fin))
'			logg("MinimumMap isStable within 30% = " & t.isStableY(30, st, fin))
'			logg("MinimumMap auto = " & t.AutoAnalysis1(st, fin))
			Draw("Min", MinimumMap, st, fin)
			Dim m As Map = t.AutoAnalysis2(st, fin)
			Draw2("Approx", m, st, fin)
			logg(t.AutoAnalysis_Whole_Simple)
			logg("---------")
			t.Close
		Case 6	'"Custom chart"
			#if B4A
				ProgressDialogShow("")
				Sleep(10)
			#end if
			t.Initialize
			Dim CustomMap As Map = File.ReadMap(File.DirAssets, "custom_data.csv")
			SortMapKeys(CustomMap, True)

			t.DataMapToTrend(CustomMap)

'			logg("CustomMap isRising = " & t.isRisingY(st, fin).rising)
'			logg("CustomMap isFalling = " & t.isFallingY(st, fin).falling)
'			logg("CustomMap isWobbling = " & t.isWobblingY(st, fin).wobbling)
'			logg("CustomMap hasMaximum = " & t.hasMaximum(st, fin).hasMaxY)
'			logg("CustomMap hasMinimum = " & t.hasMinimum(st, fin).hasMinY)
			logg("CustomMap isStable within 85% = " & t.isStableY(85, st, fin))
'			logg("CustomMap isStable within 5% = " & t.isStableY(5, st, fin))
'			logg("CustomMap auto = " & t.AutoAnalysis1(st, fin))
			Draw("Custom", CustomMap, st, fin)
			Dim m As Map = t.AutoAnalysis2(st, fin)
			Draw2("Approx", m, st, fin)
			Sleep(0)
			logg(t.AutoAnalysis_Whole_Simple)
			logg("---------")
			t.Close
	End Select
	#if B4A
		ProgressDialogHide
	#End If
End Sub