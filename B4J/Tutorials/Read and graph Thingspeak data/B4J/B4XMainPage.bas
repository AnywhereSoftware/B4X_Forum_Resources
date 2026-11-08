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

' Examples of requests with json reply
' https://api.thingspeak.com/channels/320990/feeds.json?start=2011-11-11%2010:10:10&end=2011-11-11%2011:11:11
' https://api.thingspeak.com/channels/320990/feeds.json?Days=1
' https://api.thingspeak.com/channels/320990/feeds.json?minutes=60

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private LinkURL As String
	Private MyRoot, channel As Map
	
	
	
	Private lbl_Entries As Label
	Private lbl_ID As Label
	Private lbl_last As Label
	Private lbl_Lat As Label
	Private lbl_Lon As Label
	Private lbl_Name As Label
	Private txt_entries As Label
	Private txt_id As Label
	Private txt_lastdate As Label
	Private txt_lasttime As Label
	Private txt_lat As Label
	Private txt_lon As Label
	Private txt_name As Label
	Private lbl_FiledNames As Label
	Private btn1 As Button
	Private btn2 As Button
	Private btn3 As Button
	Private btn4 As Button
	Private btn5 As Button
	Private btn6 As Button
	
	Private SingleLine1 As xChart
	Private ChartTime As List
	Private f1,f2,f3,f4,f5,f6 As List
	Private SortedData As List
	Private btn_day As Button
	Private btn_week As Button
	Private btn_month As Button
	Private btn_max As Button
	Private nResults As Int=96	'start with 1 day
	Private Xdivisions As Int=nResults/10
	Private cb1 As ComboBox
	Dim ChannelNumber As Int=320990
	
	
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Root.Visible=False
	B4XPages.SetTitle(Me, "Thingspeak Data Viewer")
	
	cb1.Items.Add(320990)
	cb1.Items.Add(1050809)
	cb1.Items.Add(1545308)
	
	' 96 Results/day. 672 Results/week. 2880 Results/month
	LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=${nResults}"$
		
	GetData(LinkURL)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


private Sub GetData(GetLink As String)
	Dim j As HttpJob
	j.Initialize("", Me)
	j.Download(GetLink)
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		Log(j.GetString)
		ParseJSON(j.GetString)
	End If
	j.Release
End Sub

Private Sub ParseJSON(text As String)
	Dim parser As JSONParser
	parser.Initialize(text)
	MyRoot = parser.NextObject
	channel = MyRoot.Get("channel")
	
	txt_id.Text = channel.Get("id")
	txt_entries.Text = channel.Get("last_entry_id")
	txt_lon.Text = channel.Get("longitude")
	txt_lat.Text = channel.Get("latitude")
	txt_name.Text = channel.Get("name")
	'txt_last.Text = channel.Get("updated_at")		this is the last edit date not the last data entry!
	
	btn1.Text = channel.Get("field1")
	btn2.Text = channel.Get("field2")
	btn3.Text = channel.Get("field3")
	btn4.Text = channel.Get("field4")
	btn5.Text = channel.Get("field5")
	btn6.Text = channel.Get("field6")
	
	SortedData.Initialize
	ChartTime.Initialize
	f1.Initialize
	f2.Initialize
	f3.Initialize
	f4.Initialize
	f5.Initialize
	f6.Initialize
	
		
	Dim feeds As List = MyRoot.Get("feeds")
	For Each colfeeds As Map In feeds
		'Dim entry_id As Int = colfeeds.Get("entry_id")
		Dim created_at As String = colfeeds.Get("created_at")
		'Log("Entry numbert: " & entry_id)
		
		'read data fo each field
		Dim field1, field2, field3, field4, field5, field6 As Double
		
		' Trying to read a NAN into a double will cause a crash, hence Try
		Try
			field1=colfeeds.Get("field1")				 
		Catch
			field1=0
		End Try
		
		Try
			field2=colfeeds.Get("field2")
		Catch
			field2=0
		End Try
		
		Try
			field3=colfeeds.Get("field3")
		Catch
			field3=0
		End Try
		
		Try
			field4=colfeeds.Get("field4")
		Catch
			field4=0
		End Try
		
		Try
			field5=colfeeds.Get("field5")
		Catch
			field5=0
		End Try
		
		Try
			field6=colfeeds.Get("field6")
		Catch
			field6=0
		End Try
		 
				
		txt_lastdate.Text=created_at.SubString2(0,10)
		txt_lasttime.Text=ConverttoMEZ(created_at.SubString2(11,19))	' Time is UTC format and we need MEZ
		ChartTime.Add(txt_lastdate.Text & " " & txt_lasttime.Text)
		
		If field1<>0 And field2<>0 And field3<>0 And field4<>0 And field5<>0 And field6<>0 Then
			f1.Add(field1)
			f2.Add(field2)
			f3.Add(field3)
			f4.Add(field4)
			f5.Add(field5)
			f6.Add(field6)			
		Else
			' If all fileds were 0 then the value is NAN. Add previous value again
			f1.Add(f1.Get(f1.Size-1))
			f2.Add(f2.Get(f2.Size-1))
			f3.Add(f3.Get(f3.Size-1))
			f4.Add(f4.Get(f4.Size-1))
			f5.Add(f5.Get(f5.Size-1))
			f6.Add(f6.Get(f6.Size-1))			
		End If
		
	Next
	Root.Visible=True
	btn1_Click
End Sub


Private Sub btn6_Click
	' Initialize the single line data
	' Remember to set the chart type in designer or use the type attribute
	SingleLine1.ClearData
  
	SingleLine1.Title = txt_name.Text
	SingleLine1.XAxisName = "Time"
	SingleLine1.YAxisName = btn6.Text
	SingleLine1.IncludeLegend = "BOTTOM"
	SingleLine1.XScaleTextOrientation = "VERTICAL"
	SingleLine1.AddLine(btn6.Text, xui.Color_Yellow)
	SingleLine1.AutomaticScale = False
	
	SortedData.Clear
	SortedData.AddAll(f6)
	SortedData.Sort(True)
	MinMax(SortedData.Get(0), SortedData.Get(SortedData.Size-1))

		
	For i=0 To ChartTime.Size-1
		SingleLine1.AddLinePointData(ChartTime.Get(i), f6.Get(i), i Mod Xdivisions = 0)
	Next
	SingleLine1.DrawChart
End Sub

Private Sub btn5_Click
	' Initialize the single line data
	' Remember to set the chart type in designer or use the type attribute
	SingleLine1.ClearData
  
	SingleLine1.Title = txt_name.Text
	SingleLine1.XAxisName = "Time"
	SingleLine1.YAxisName = btn5.Text
	SingleLine1.IncludeLegend = "BOTTOM"
	SingleLine1.XScaleTextOrientation = "VERTICAL"
	SingleLine1.AddLine(btn5.Text, xui.Color_Magenta)
	SingleLine1.AutomaticScale = False
	
	SortedData.Clear
	SortedData.AddAll(f5)
	SortedData.Sort(True)
	MinMax(SortedData.Get(0), SortedData.Get(SortedData.Size-1))

		
	For i=0 To ChartTime.Size-1
		SingleLine1.AddLinePointData(ChartTime.Get(i), f5.Get(i), i Mod Xdivisions = 0)
	Next
	SingleLine1.DrawChart
End Sub

Private Sub btn4_Click
	' Initialize the single line data
	' Remember to set the chart type in designer or use the type attribute
	SingleLine1.ClearData
  
	SingleLine1.Title = txt_name.Text
	SingleLine1.XAxisName = "Time"
	SingleLine1.YAxisName = btn4.Text
	SingleLine1.IncludeLegend = "BOTTOM"
	SingleLine1.XScaleTextOrientation = "VERTICAL"
	SingleLine1.AddLine(btn4.Text, xui.Color_Cyan)
	SingleLine1.AutomaticScale = False
	
	SortedData.Clear
	SortedData.AddAll(f4)
	SortedData.Sort(True)
	MinMax(SortedData.Get(0), SortedData.Get(SortedData.Size-1))

		
	For i=0 To ChartTime.Size-1
		SingleLine1.AddLinePointData(ChartTime.Get(i), f4.Get(i), i Mod Xdivisions = 0)
	Next
	SingleLine1.DrawChart
End Sub

Private Sub btn3_Click
	' Initialize the single line data
	' Remember to set the chart type in designer or use the type attribute
	SingleLine1.ClearData
  
	SingleLine1.Title = txt_name.Text
	SingleLine1.XAxisName = "Time"
	SingleLine1.YAxisName = btn3.Text
	SingleLine1.IncludeLegend = "BOTTOM"
	SingleLine1.XScaleTextOrientation = "VERTICAL"
	SingleLine1.AddLine(btn3.Text, xui.Color_Blue)
	SingleLine1.AutomaticScale = False
	
	SortedData.Clear
	SortedData.AddAll(f3)
	SortedData.Sort(True)
	MinMax(SortedData.Get(0), SortedData.Get(SortedData.Size-1))

		
	For i=0 To ChartTime.Size-1
		SingleLine1.AddLinePointData(ChartTime.Get(i), f3.Get(i), i Mod Xdivisions = 0)
	Next
	SingleLine1.DrawChart
End Sub

Private Sub btn2_Click
	' Initialize the single line data
	' Remember to set the chart type in designer or use the type attribute
	SingleLine1.ClearData
  
	SingleLine1.Title = txt_name.Text
	SingleLine1.XAxisName = "Time"
	SingleLine1.YAxisName = btn2.Text
	SingleLine1.IncludeLegend = "BOTTOM"
	SingleLine1.XScaleTextOrientation = "VERTICAL"
	SingleLine1.AddLine(btn2.Text, xui.Color_Green)
	SingleLine1.AutomaticScale = False
	
	SortedData.Clear
	SortedData.AddAll(f2)
	SortedData.Sort(True)
	MinMax(SortedData.Get(0), SortedData.Get(SortedData.Size-1))
		
	For i=0 To ChartTime.Size-1
		SingleLine1.AddLinePointData(ChartTime.Get(i), f2.Get(i), i Mod Xdivisions = 0)
	Next
	SingleLine1.DrawChart
End Sub

Private Sub btn1_Click
	' Initialize the single line data
	' Remember to set the chart type in designer or use the type attribute
	SingleLine1.ClearData
  
	SingleLine1.Title = txt_name.Text
	SingleLine1.XAxisName = "Time"
	SingleLine1.YAxisName = btn1.Text
	SingleLine1.IncludeLegend = "BOTTOM"
	SingleLine1.XScaleTextOrientation = "VERTICAL"
	SingleLine1.AddLine(btn1.Text, xui.Color_Red)
	SingleLine1.AutomaticScale = False
	
	SortedData.Clear
	SortedData.AddAll(f1)
	SortedData.Sort(True)
	
	MinMax(SortedData.Get(0), SortedData.Get(SortedData.Size-1))	
	
	For i=0 To ChartTime.Size-1
		SingleLine1.AddLinePointData(ChartTime.Get(i), f1.Get(i), i Mod Xdivisions = 0)
	Next
	SingleLine1.DrawChart
End Sub

Sub ConverttoMEZ (s As String) As String
	Dim t As Long
	t=DateTime.TimeParse(s)
	t=t+(DateTime.TimeZoneOffset*DateTime.TicksPerHour)
	Return DateTime.Time(t)
End Sub

'	Data from JSON Tree Example
#Region
'	Dim elevation As String = channel.Get("elevation")
'	Dim last_entry_id As Int = channel.Get("last_entry_id")
'	Dim latitude As String = channel.Get("latitude")
'	Dim description As String = channel.Get("description")
'	Dim created_at As String = channel.Get("created_at")
'	Dim field1 As String = channel.Get("field1")
'	Dim updated_at As String = channel.Get("updated_at")
'	Dim name As String = channel.Get("name")
'	Dim field6 As String = channel.Get("field6")
'	Dim id As Int = channel.Get("id")
'	Dim field3 As String = channel.Get("field3")
'	Dim field2 As String = channel.Get("field2")
'	Dim field5 As String = channel.Get("field5")
'	Dim longitude As String = channel.Get("longitude")
'	Dim field4 As String = channel.Get("field4")
'	Dim feeds As List = MyRoot.Get("feeds")
'	For Each colfeeds As Map In feeds
'		Dim field1 As String = colfeeds.Get("field1")
'		Dim created_at As String = colfeeds.Get("created_at")
'		Dim field6 As String = colfeeds.Get("field6")
'		Dim field3 As String = colfeeds.Get("field3")
'		Dim entry_id As Int = colfeeds.Get("entry_id")
'		Dim field2 As String = colfeeds.Get("field2")
'		Dim field5 As String = colfeeds.Get("field5")
'		Dim field4 As String = colfeeds.Get("field4")
'	Next
#End Region

Private Sub btn_month_Click
	nResults=2880
	Xdivisions=nResults/10
	'LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=48"$
	LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=${nResults}"$
	GetData(LinkURL)
End Sub

Private Sub btn_week_Click
	nResults=672
	Xdivisions=nResults/10
	'LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=16"$
	LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=${nResults}"$
	GetData(LinkURL)
End Sub

Private Sub btn_day_Click
	nResults=96
	Xdivisions=nResults/10
	'LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?Days=1"$
	LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=${nResults}"$
	GetData(LinkURL)
End Sub

Private Sub btn_max_Click
	nResults=8000
	Xdivisions=nResults/10
	'LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?Days=1"$
	LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=${nResults}"$
	GetData(LinkURL)
End Sub

Private Sub cb1_ValueChanged (Value As Object)
	ChannelNumber=Value
	nResults=96
	Xdivisions=nResults/10
	'LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?Days=1"$
	LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=${nResults}"$
	GetData(LinkURL)
End Sub

private Sub MinMax(ymin As Double, ymax As Double)
'	Dim difference As Double=ymax-ymin
'	Dim ydivision As Double=difference/10
'	Dim miny, maxy As Int
'	miny=Floor(ymin-ydivision)
'	maxy=Floor(ymax+ydivision)
'	
'	SingleLine1.YScaleMinValue=miny
'	SingleLine1.YScaleMaxValue=maxy
'	
'	Log("Miny: " & miny)
'	Log("Maxy: " & maxy)

	Dim ValMin, ValMax As Int
	ValMin = Floor(ymin)
	ValMax = Ceil(ymax)
	Dim difference As Int = ValMax - ValMin
	Dim ydivision As Int = difference / 10
	Dim miny, maxy As Int
	miny = ValMin - ydivision
	maxy = ValMax + ydivision
	'Return Array As Int(miny, maxy)
	SingleLine1.YScaleMinValue=miny
	SingleLine1.YScaleMaxValue=maxy
End Sub