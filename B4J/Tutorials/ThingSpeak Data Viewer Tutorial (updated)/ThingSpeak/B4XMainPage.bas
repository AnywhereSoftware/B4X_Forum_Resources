B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
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
	
	Private AppName As String = "ThingSpeak Data Viewer"
	Private Version As String = "0.0.1"
	Private mapSettings As Map
	Private txtID As TextField
	Private lblDataPoints As Label
	Private lblError As Label
	Private lblLastEntry As Label
	Private lblSampleRate As Label
	Private lblLat As Label
	Private lblLon As Label
	Private lblName As Label
	Private lbl_FiledNames As Label
	Private btn1 As Button
	Private btn2 As Button
	Private btn3 As Button
	Private btn4 As Button
	Private btn5 As Button
	Private btn6 As Button
	Private chkRemove As CheckBox
	Private SingleLine1 As xChart
	Private ChartTime As List
	Private SortedData As List
	Private btn_day As Button
	Private btn_week As Button
	Private btn_month As Button
	Private btn_max As Button
	Private cb1 As ComboBox
	Private btnSelectChannel As Button
	
	Private color(6) As Int	
	Private numFields As Int = 6
	Private lstFields( numFields ) As List
	Private Xdivisions As Int
	Dim ChannelNumber As Int = 2561629 ' pool monitor
	Dim numChannels As Int = 20
	Type ChannelType (ID As String, Name As String)
	Dim Channels( numChannels ) As ChannelType
	Dim currentField As Int = 0
	Dim sampleRate As Float
	Dim TIME_FRAME_ALL As Int = 0
	Dim TIME_FRAME_DAY As Int = 1
	Dim TIME_FRAME_WEEK As Int = 7
	Dim TIME_FRAME_MONTH As Int = 30
	Dim plotTimeFrame As Long = TIME_FRAME_WEEK
	Dim Entries_Total As Long
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created( Root1 As B4XView )
	Root = Root1
	Root.LoadLayout( "MainPage" )
	Root.Visible = False
	B4XPages.SetTitle( Me, AppName & " " & Version )

	mapSettings.Initialize
	For i = 0 To numChannels-1
		Channels(i).Initialize
	Next
	SettingsGet
	If Channels(0).ID.Length = 0 Then
		Channels(0).ID = "2561629"
		Channels(1).ID = "2421172"
		Channels(2).ID = "2057381"
		Channels(3).ID = "320990"
		Channels(4).ID = "1050809"
		Channels(5).ID = "1545308"
		Channels(6).ID = "357142"
	End If
	PopulateCb1
	cb1.SelectedIndex = 0
	
	color(0) = xui.Color_Red
	color(1) = xui.Color_Green
	color(2) = xui.Color_Blue
	color(3) = xui.Color_Cyan
	color(4) = xui.Color_Magenta
	color(5) = xui.Color_Yellow
	
	LinkURL = $"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=8000"$
	GetData( LinkURL )
End Sub ' B4XPage_Created()

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

' populate the ComboBox with the channel info 
Sub PopulateCb1
	Dim i As Int
	' clear the ComboBox entirely
	For i=0 To cb1.Items.Size-1
		cb1.Items.Clear
	Next
	For i=0 To Channels.Length-1
		If Channels(i).ID.Length > 0 Then 
			If Channels(i).Name.Length > 0 Then
				cb1.Items.Add( Channels(i).ID & " - " & Channels(i).Name )
			Else
				cb1.Items.Add( Channels(i).ID )
			End If
		End If
	Next
End Sub ' PopulateCb1

' fetch a new channel, display the data, save to the ComboBox and save to settings
Private Sub txtID_Action
	ChannelNumber = txtID.Text.Trim
	currentField = 0
	For i=0 To Channels.Length-1
		If Channels(i).ID = ChannelNumber Then Exit
		If Channels(i).ID.Length = 0 Then
			Channels(i).ID = ChannelNumber
			Channels(i).Name = ""
			Exit
		End If
	Next
	PopulateCb1
	SettingsSave
	LinkURL = $"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=8000"$
	GetData( LinkURL )
End Sub ' txtID_Action

' show and open the ComboBox
' (ComboBox is too big to be permanently displayed)
Private Sub btnSelectChannel_Click
	If cb1.Visible Then
		cb1.Visible = False
	Else
		cb1.Visible = True
		cb1.RequestFocus
		' make the combo box drop down
		cb1.As( JavaObject ).RunMethod( "show", Null )
	End If
End Sub ' btnSelectChannel_Click

' select a new channel from the MRU list
Private Sub cb1_ValueChanged( Value As Object )
	If Value.As( String ) <> "null" Then
		Dim s() As String = Regex.Split( " - ", Value )
		If s.Length > 0 Then
			ChannelNumber = s(0)
			currentField = 0
			'txtID.Text = Value
			LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=8000"$
			GetData( LinkURL )
		End If
	End If
	cb1.Visible = False
End Sub ' cb1_ValueChanged()

' remove the currently displayed channel ID from the cb1 combobox and the MRU settings
Private Sub chkRemove_CheckedChange( Checked As Boolean)
	Dim i, j As Int
	If Checked = True Then
		For i=0 To Channels.Length-1
			If Channels(i).ID = txtID.text Then 
				Channels(i).ID = ""
				Channels(i).Name = ""
				j = 0
				Do While (i+j+1) < numChannels And Channels(i+j+1).ID.Length > 0
					Channels(i+j) = Channels(i+j+1)
					j = j+1
				Loop
				If (j+i) < numChannels Then 
					Channels(i+j).ID = ""
					Channels(i+j).Name = ""
				End If
				PopulateCb1
				SettingsSave
				chkRemove.Checked = False
				Return
			End If
		Next
	End If
End Sub ' chkRemove_CheckedChange(

' get all the data points we can get from Thingspeak
' (this must be a public channel)
' then call ParseJSON and then PlotData
private Sub GetData( GetLink As String )
	Dim j As HttpJob
	j.Initialize( "", Me )
	j.Download( GetLink )
	lblError.Text = "Fetching Data..."
	Wait For (j) JobDone( j As HttpJob )
	If j.Success Then
		Log( j.GetString )
		ParseJSON( j.GetString )
		If lstFields( currentField ).size > 0 Then
			PlotData
			lblError.Text = ""
		Else
			SingleLine1.ClearData
			SingleLine1.DrawChart
			lblError.Text = "No data to plot"
		End If
	Else
		lblError.Text = "Cannot load channel " & ChannelNumber 
		Log( lblError.Text )
	End If
	j.Release
End Sub ' GetData()

' given the entire JSON string returned from ThingSpeak for the given channel,
' extract the header info and populate the labels on the form
' then select the feeds that fall within the requested time frame (day, week, month or all)
' and save the chart data in CharTime and lstFields()
Private Sub ParseJSON( text As String )
	Dim parser As JSONParser
	parser.Initialize( text )
	MyRoot = parser.NextObject
	channel = MyRoot.Get( "channel" )
	
	txtID.Text = channel.Get( "id" ) ' this should match the requested channel...
	Entries_Total = channel.Get( "last_entry_id" )
	
	lblLon.Text = channel.Get( "longitude" )
	lblLat.Text = channel.Get( "latitude" )
	lblName.Text = channel.Get( "name" )
	lblName.TooltipText = lblName.text
	CheckChannelName( txtID.Text, lblName.Text )
	'txt_last.Text = channel.Get( "updated_at" )		this is the last edit date not the last data entry!
	
	LoadButton( btn1, "field1" )
	LoadButton( btn2, "field2" )
	LoadButton( btn3, "field3" )
	LoadButton( btn4, "field4" )
	LoadButton( btn5, "field5" )
	LoadButton( btn6, "field6" )
	
	SortedData.Initialize
	ChartTime.Initialize
	For i=0 To numFields-1
		lstFields(i).Initialize
	Next

	Dim feeds As List = MyRoot.Get( "feeds" )
	Dim strLastEntryTime As String
	Dim LastEntryTime As Long
	Dim lastFeed As Map = feeds.Get(feeds.Size-1)
	Dim entryTime, desiredEntryTime As Long
	Dim firstEntryTime As Long = 0
	
	' get time of latest entry
	strLastEntryTime = lastFeed.Get( "created_at" )
	LastEntryTime = ConvertToLocalDateTime( strLastEntryTime )
	
	' how many milliseconds of plot time do we need?
	If plotTimeFrame = 0 Then
		desiredEntryTime = 0 ' display all 8000 points
	Else
		desiredEntryTime = LastEntryTime - plotTimeFrame*24*60*60*1000
	End If
	
	' TODO: we could start from the most recent and work backwards so that we could stop once we are before the first point to be plotted
	' but with a reasonably quick computer, this is pretty fast
	For Each colfeeds As Map In feeds
		Dim created_at As String = colfeeds.Get( "created_at" )
		
		'read data fo each field
		Dim field( numFields ) As Double
		
		For i=0 To numFields-1
			field( i ) = tryColFeed( colfeeds, "field" & (i+1) )
		Next
		entryTime = ConvertToLocalDateTime( created_at )
		If firstEntryTime = 0 Then firstEntryTime = entryTime
		If entryTime >= desiredEntryTime Then
			ChartTime.Add( DateTime.Date( entryTime ) & " " & DateTime.Time( entryTime ))
			For i=0 To numFields-1
				lstFields(i).Add( tryAdd( field(i), lstFields(i) ))
			Next
		End If
	Next
	sampleRate = (LastEntryTime - firstEntryTime) / feeds.Size / 60000 ' in minutes
	lblSampleRate.Text = NumberFormat( sampleRate, 1, 1 )
	lblDataPoints.Text = ChartTime.Size & "/"& Entries_Total
	Root.Visible=True
End Sub ' ParseJSON()

' get a button's name from the header, or use N/A if field is not available
' save the save string to the button's ToolTip in case the string is too long for the button itself
Sub LoadButton( btn As Button, field As String )
	If channel.ContainsKey( field ) Then
		btn.Text = channel.Get( field )
		btn.TooltipText = btn1.text
	Else
		btn.Text = "N/A"
		btn.TooltipText = ""
	End If
End Sub ' LoadButton()

' looks through Channels() for the ID and add/replace Name
Sub CheckChannelName( id As String, name As String )
	For i=0 To numChannels-1
		If Channels(i).ID = id Then
			Channels(i).Name = name
			PopulateCb1
			SettingsSave
			Return
		End If
	Next
End Sub

' using the info in CharTime and lstFields(), plot the data using xChart
' plotting starts from the right so that the time ticks can be regularly spaced from the latest point
private Sub PlotData
	' Initialize the single line data
	' Remember to set the chart type in designer or use the type attribute
	SingleLine1.ClearData
	SingleLine1.Title = lblName.Text
	SingleLine1.XAxisName = "Time"
	SingleLine1.YAxisName = channel.Get( "field" & (currentField+1)) ' btn1.Text
	SingleLine1.IncludeLegend = "BOTTOM"
	SingleLine1.XScaleTextOrientation = "VERTICAL"
	SingleLine1.AddLine( channel.Get( "field" & (currentField+1)), color( currentField ))
	SingleLine1.AutomaticScale = False
	
	' find the min and max values in the data to be plotted
	SortedData.Clear
	SortedData.AddAll( lstFields( currentField ) )
	SortedData.Sort( True )
	MinMax( SortedData.Get(0), SortedData.Get( SortedData.Size-1 ))
	
	' select the number of vertical divisions depending on the selected time frame
	' make sure we have 8 divisions in border cases
	Select plotTimeFrame 
		Case TIME_FRAME_DAY
			Xdivisions = ChartTime.Size/8 ' tick every 3 hours
			SingleLine1.XAxisName = "Time (day)"
		Case TIME_FRAME_WEEK
			Xdivisions = ChartTime.Size/7
			SingleLine1.XAxisName = "Time (week)"
		Case TIME_FRAME_MONTH
			Xdivisions = ChartTime.Size/10 ' every ~3 days
			SingleLine1.XAxisName = "Time (month)"
		Case Else
			Xdivisions = ChartTime.Size/10
			SingleLine1.XAxisName = "Time (max)"
	End Select

	If Xdivisions = 0 Then Xdivisions = ChartTime.Size/8
	' start plotting from the right (most recent to oldest)
	For i=ChartTime.Size-1 To 0 Step -1
		SingleLine1.AddLinePointData( ChartTime.Get(ChartTime.Size-1-i), lstFields( currentField ).Get(ChartTime.Size-1-i), i Mod Xdivisions = 0 )
	Next
	' draw time for last point (left edge of graph)
	SingleLine1.AddLinePointData( ChartTime.Get(0), lstFields( currentField ).Get(0), True )
	lblLastEntry.Text = ChartTime.Get( ChartTime.Size-1 )
	SingleLine1.DrawChart
End Sub ' PlotData

' ThingSpeak time stamps are in UTC
Sub ConvertToLocalDateTime( s As String ) As Long
	' example: s = "2024-03-28T09:26:30Z"
	Dim dt, tm As String
	dt = s.SubString2( 0, 10 )
	tm = s.SubString2( 11, 19 )
	Dim t As Long
	DateTime.DateFormat="yyyy-MM-dd"
	t = DateTime.DateTimeParse( dt, tm )
	t = t+(DateTime.TimeZoneOffset*DateTime.TicksPerHour) ' TicksPerHours is 3,600,000 (1mS rate)
	Return t
End Sub ' ConvertToLocalDateTime()

' return the current value in the list, or return the previous value if current 
' value is not available, or return 0 if that too fails
private Sub tryAdd( f As Double, l As List ) As Double
	If f > 0 Then
		Return f
	Else
		If l.Size > 0 Then
			Return l.Get(l.Size-1)
		Else
			Return 0
		End If
	End If
End Sub ' tryAdd()

' Read a NAN into a double will cause a crash, hence use Try
private Sub tryColFeed( m As Map, field As String ) As Double
	Try
		Return m.Get( field )
	Catch
		Return 0
	End Try
End Sub ' tryColFeed()

Private Sub btn_day_Click
	plotTimeFrame = TIME_FRAME_DAY
	'LinkURL = $"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=${nDesiredDataPoints}"$
	LinkURL = $"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=8000"$
	GetData( LinkURL )
End Sub ' btn_day_Click

Private Sub btn_week_Click
	plotTimeFrame = TIME_FRAME_WEEK
	'LinkURL = $"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=16"$
	LinkURL = $"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=8000"$
	GetData( LinkURL )
End Sub ' btn_week_Click

Private Sub btn_month_Click
	plotTimeFrame = TIME_FRAME_MONTH
	'LinkURL = $"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=48"$
	LinkURL = $"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=8000"$
	GetData( LinkURL )
End Sub ' btn_month_Click

Private Sub btn_max_Click
	plotTimeFrame = TIME_FRAME_ALL
	'LinkURL = $"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?Days=1"$
	'LinkURL = $"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=${nDesiredDataPoints}"$
	LinkURL = $"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=8000"$
	GetData( LinkURL )
End Sub ' btn_max_Click

Private Sub btn1_Click
	currentField = 0
	PlotData
End Sub ' btn1_Click

Private Sub btn2_Click
	currentField = 1
	PlotData
End Sub ' btn2_Click

Private Sub btn3_Click
	currentField = 2
	PlotData
End Sub ' btn3_Click

Private Sub btn4_Click
	currentField = 3
	PlotData
End Sub ' btn4_Click

Private Sub btn5_Click
	currentField = 4
	PlotData
End Sub ' btn_Click

Private Sub btn6_Click
	currentField = 5
	PlotData
End Sub ' btn6_Click

' given the min and max values in the data to be plotted, set YScaleMinValue and YScaleMaxValue accordingly
' do the sensible thing if both values are equal or both are zero
private Sub MinMax( ymin As Double, ymax As Double )
	Dim ValMin, ValMax As Int
	Dim miny, maxy As Int
	If ymin = ymax Then
		ymin = ymin * 0.9
		ymax = ymax * 1.1
	End If
	If ymin = 0 And ymax = 0 Then
		ymin = -1
		ymax = 1
	End If
	ValMin = Floor( ymin )
	ValMax = Ceil( ymax )
	Dim difference As Int = ValMax - ValMin
	Dim ydivision As Int = difference / 10
	miny = ValMin - ydivision
	maxy = ValMax + ydivision
	SingleLine1.YScaleMinValue = miny
	SingleLine1.YScaleMaxValue = maxy
End Sub ' MinMax()

' save the Most Recently Used channel IDs and Names
' map file is saved to:
' C:\Users\<user>\AppData\Roaming\ThingSpeak Data Viewer
Sub SettingsSave
	mapSettings.Clear
	For i=0 To Channels.Length-1
		If Channels(i).ID.Length > 0 Then
			mapSettings.Put( "Channels(" & i & ")", Channels(i).ID & " - " & Channels(i).Name )
		End If
	Next
	File.WriteMap( File.DirData( AppName ), AppName & ".cfg", mapSettings )
End Sub ' SettingsSave

' get the MRUs from the map file
Sub SettingsGet
	Dim key, arrValue() As String, i, ndx As Int
	If File.Exists( File.DirData( AppName ), AppName & ".cfg" ) = True Then
		mapSettings = File.ReadMap( File.DirData( AppName ), AppName & ".cfg" )
		For i=0 To mapSettings.Size - 1
			key = mapSettings.GetKeyAt(i)
			If key.IndexOf("Channels(" )  = 0 Then
				' Channels() looks ike this:
				' Channels(0)=2561629,Pool Chlorine Generator
				arrValue = Regex.Split( " - ", mapSettings.GetValueAt(i) )
				Try
					ndx = key.SubString2( key.IndexOf("(")+1, key.IndexOf(")") )
					If ndx < numChannels Then
						Channels(ndx).ID = arrValue(0)
						If arrValue.Length = 2 Then
							Channels(ndx).Name = arrValue(1)
						End If
					End If
				Catch
					Log( LastException )
				End Try
			End If
		Next
	End If
End Sub ' SettingsGet




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
