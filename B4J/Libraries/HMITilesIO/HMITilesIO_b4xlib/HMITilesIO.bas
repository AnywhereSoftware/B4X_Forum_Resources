B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File: 		HMITilesIO.bas
' Brief:		CustomView Human Machine Interface tile showing assets from a SVG image.
' Date:			See class_globals VERSION.
' Author:		Robert W.B. Linn (c) 2026 MIT
' Description:	HMITilesIO brings structured, industry-inspired high-performance HMI design principles directly into the B4X ecosystem.
'				Target has been to combine highly optimized vector graphics with native input tracking For microcontrollers And IoT applications.
'				This customview (CV) holds various tile types which use Scalable Vector Graphics - open, text-based image format to display two-dimensional graphics.
'				The SVG XML definitions are stored in the assets folder. Each tile type has its own definition with same naming as the tile type.
'				Example: Tile type slider is defined in file `slider.svg`. This definition is loaded in the HTML image `image.html` used for each tile type.
' Notes: 		The HMITile can not be resized after form loaded. Default 120x120px.
'				The tile border is set for each tile in its svg file:
'				<!-- Base Grid Tile Frame - set rx to f.e. 6 for rounded corders -->
'				<rect width="120" height="120" rx="0" fill="transparent" stroke="#334155" stroke-width="1" />
'				Default tile type is Switch.
'				Create a new tile type requires: 
'				- Update designerproperty tiletype like NewTileType
'				- add new class HMITilesIONewTileType - use any existing tile type as a base, like HMITilesIOReadOut
'				- add constant Private TILE_NEWTILETYPE As String = "NEWTILETYPE" - must be upperacase
'				- add Private InstanceNewTileType As HMITilesIONewTileType
'				- update sub InitInstance with the new tile type
'				- update subs setState or setValue depending type of tile
'				- create new svg file in assets like newtiletype.svg (lowercase) and add to the files manager
'
' Raspberry Pi:	Running HMITilesIO tests on a Raspberry Pi from a Windows 11 device ensure to start the B4J-Bridge on the RPi with DISPLAY=:0.
'				Example: DISPLAY=:0 /home/rwbl/prog/jdk21/bin/java -jar /home/rwbl/prog/b4jbridge/b4j-bridge.jar
'					
' Layout:		Panel/Pane with WebView
'				+------------------+
'				|    Panel/Pane    | < 100% 120x120px
'				|+----------------+|
'				||    SVG Image   ||
'				|+----------------+|
'				+------------------+
' ================================================================

' Designer properties (ensure to define the key in lowercase)
#DesignerProperty: Key: tiletype, DisplayName: Tile Type, FieldType: String, List: |Alarm|Battery|Button|ByteStatus|Compass|DualReadOut|Gauge|Horizon|IconIndicator|IOPanel|LEDPanel|LoadingIndicator|MultiState|QuadReadOut|ReadOut|Selector|SevenSegment|Signal|Slider|Spinner|Switch|TiltGauge|Timer|TrendChart|VerticalMeter|Watchdog|, DefaultValue: Switch.
#DesignerProperty: Key: id, DisplayName: ID, FieldType: String, DefaultValue: ID, Description: Unique tile ID.
#DesignerProperty: Key: header, DisplayName: Header, FieldType: String, DefaultValue: , Description: Header for all tiles.
#DesignerProperty: Key: footer, DisplayName: Footer, FieldType: String, DefaultValue: , Description: Footer for all tiles.
#DesignerProperty: Key: value, DisplayName: Value, FieldType: String, DefaultValue: 0, Description: Value for tile Spinner Gauge ReadOut SevenSegment Slider VerticalMeter.
#DesignerProperty: Key: minvalue, DisplayName: Min Value, FieldType: Float, DefaultValue: 0, Description: Min value for all tiles.
#DesignerProperty: Key: maxvalue, DisplayName: Max Value, FieldType: Float, DefaultValue: 100, Description: Max value for all tiles.
#DesignerProperty: Key: greenmaxpct, DisplayName: Green Max Pct, FieldType: Int, DefaultValue: 70, Description: Green segment for tile Gauge.
#DesignerProperty: Key: yellowmaxpct, DisplayName: Yellow Max Pct, FieldType: Int, DefaultValue: 90, Description: Yellow segment for tile Gauge.
#DesignerProperty: Key: state, DisplayName: State, FieldType: Boolean, DefaultValue: False, Description: State true or false for tile Button, Switch, LEDPanel.
#DesignerProperty: Key: backgroundcolor,DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Background color for all tiles.
#DesignerProperty: Key: bordercolor,DisplayName: Border Color, FieldType: Color, DefaultValue: 0xFF334155, Description: Border color for all tiles.
#DesignerProperty: Key: borderwidth, DisplayName: Border Width, FieldType: Int, DefaultValue: 1, Description: Border width for all tiles.
#DesignerProperty: Key: headerfontcolor,DisplayName: Header Font Color, FieldType: Color, DefaultValue: 0xFF475569, Description: Header font color for all tiles.
#DesignerProperty: Key: headerfontsize, DisplayName: Header Font Size, FieldType: Int, DefaultValue: 11, Description: Header font size for all tiles.
#DesignerProperty: Key: valuefontcolor,DisplayName: Value Font Color, FieldType: Color, DefaultValue: 0xFF0F172A, Description: Value font color for all tiles.
#DesignerProperty: Key: valuefontsize, DisplayName: Value Font Size, FieldType: Int, DefaultValue: 24, Description: Value font size for all tiles.
#DesignerProperty: Key: footerfontcolor,DisplayName: Footer Font Color, FieldType: Color, DefaultValue: 0xFF64748B, Description: Footer font color for all tiles.
#DesignerProperty: Key: footerfontsize, DisplayName: Footer Font Size, FieldType: Int, DefaultValue: 10, Description: Footer font size for all tiles.

' Events
#Event: Click(State As Boolean, Value As String)

Private Sub Class_Globals

	Public Const VERSION As String ="HMITilesIO 1.5.0 (Build 20261102)"

	' =========================
	' TILE TYPE NAMES (UPPERCASE) 
	' aligned with the designerProperty tiletype
	' =========================
	Private TILE_ALARM As String 			= "ALARM"				'value
	Private TILE_BATTERY As String 			= "BATTERY"				'value
	Private TILE_BUTTON As String 			= "BUTTON"				'state
	Private TILE_BYTESTATUS As String 		= "BYTESTATUS"			'value
	Private TILE_COMPASS As String 			= "COMPASS"				'value
	Private TILE_DUALREADOUT As String 		= "DUALREADOUT"			'value
	Private TILE_GAUGE As String 			= "GAUGE"				'value
	Private TILE_HORIZON As String 			= "HORIZON"				'value
	Private TILE_IOPANEL As String 			= "IOPANEL"				'value
	Private TILE_ICONINDICATOR As String 	= "ICONINDICATOR"		'value
	Private TILE_SPINNER As String 			= "SPINNER"				'value
	Private TILE_LEDPANEL As String 		= "LEDPANEL"			'state
	Private TILE_LOADINGINDICATOR As String = "LOADINGINDICATOR"	'value
	Private TILE_MULTISTATE As String 		= "MULTISTATE"			'value
	Private TILE_QUADREADOUT As String 		= "QUADREADOUT"			'value
	Private TILE_READOUT As String 			= "READOUT"				'value
	Private TILE_SELECTOR As String 		= "SELECTOR"			'value
	Private TILE_SEVENSEGMENT As String 	= "SEVENSEGMENT"		'value
	Private TILE_SIGNAL As String 			= "SIGNAL"				'value
	Private TILE_SLIDER As String 			= "SLIDER"				'value
	Private TILE_SWITCH As String 			= "SWITCH"				'state
	Private TILE_TILTGAUGE As String 		= "TILTGAUGE"			'value
	Private TILE_TIMER As String 			= "TIMER"				'value
	Private TILE_TRENDCHART As String 		= "TRENDCHART"			'value
	Private TILE_VERTICALMETER As String 	= "VERTICALMETER"		'value
	Private TILE_WATCHDOG As String 		= "WATCHDOG"			'value

	' =========================
	' TYPES
	' =========================
	' Touch data - used by each hmitilesio class method ProcessTouchHandler()
	Type HMITouchData (Action As Int, X As Float, Y As Float, State As Boolean, Value As String)
	' Touch result state
	Type HMITouchResult (State As Object, Value As String)

	' =========================
	' BASE
	' =========================
	Public BasePane As B4XView
	Public Tag As Object
	
	' =========================
	' UI
	' =========================
	Private xui As XUI 					
	Private WebViewSVG As WebView
	Private PanelWebViewSVG As B4XView	
	
	' =========================
	' PROPERTIES
	' =========================
	Private mTileType As String
	Private mID As String = ""
	Private mHeader As String
	Private mFooter As String
	Private mValue As String
	Private mState As Boolean
	Private mMinValue As Float
	Private mMaxValue As Float
	Private mGreenMaxPct As Int
	Private mYellowMaxPct As Int
	Private mBackgroundColor As String
	Private mBorderColor As String
	Private mBorderWidth As Int
	Private mHeaderFontColor As String
	Private mHeaderFontSize As Int
	Private mValueFontColor As String
	Private mValueFontSize As Int
	Private mFooterFontColor As String
	Private mFooterFontSize As Int

	' Local properties for specific tiles, like Selector
	Private mItems As List
	Private mData As Object = Null

	' Local for events
	Private mEventName As String	'ignore
	Private mCallBack As Object 	'ignore

	' =========================
	' INSTANCES 
	' (from the class modules to access properties & methods)
	' =========================
	Public InstanceAlarm 			As HMITilesIOAlarm
	Public InstanceBattery 			As HMITilesIOBattery
	Public InstanceButton 			As HMITilesIOButton
	Public InstanceByteStatus 		As HMITilesIOByteStatus
	Public InstanceCompass 			As HMITilesIOCompass
	Public InstanceDualReadOut 		As HMITilesIODualReadOut
	Public InstanceGauge 			As HMITilesIOGauge
	Public InstanceHorizon 			As HMITilesIOHorizon
	Public InstanceIOPanel 			As HMITilesIOPanel
	Public InstanceIconIndicator 	As HMITilesIOIconIndicator
	Public InstanceLEDPanel 		As HMITilesIOLEDPanel
	Public InstanceLoadingIndicator As HMITilesIOLoadingIndicator
	Public InstanceMultiState 		As HMITilesIOMultiState
	Public InstanceReadOut 			As HMITilesIOReadOut
	Public InstanceQuadReadOut 		As HMITilesIOQuadReadOut
	Public InstanceSelector 		As HMITilesIOSelector
	Public InstanceSevenSegment		As HMITilesIOSevenSegment
	Public InstanceSignal 			As HMITilesIOSignal
	Public InstanceSlider 			As HMITilesIOSlider
	Public InstanceSpinner 			As HMITilesIOSpinner
	Public InstanceSwitch 			As HMITilesIOSwitch
	Public InstanceTiltGauge 		As HMITilesIOTiltGauge
	Public InstanceTimer 			As HMITilesIOTimer
	Public InstanceTrendChart 		As HMITilesIOTrendChart
	Public InstanceVerticalMeter	As HMITilesIOVerticalMeter
	Public InstanceWatchdog			As HMITilesIOWatchdog

	' Ready flag ensuring tiles have completed SVG loading and drawing
	Private mIsReady 						As Boolean = False
	
	' =========================
	' IMAGE MARKUP
	' =========================
	' Tile HTML base file located in the assets folder
	Private TILE_MARKUP_FILE 				As String = "tile.html"
	' Placeholder in the HTML file which is replaced by the SVG file XML content
	Private PH_HTML_IMAGE			 		As String = "#IMAGE_PLACEHOLDER#"
	
	' Placeholder SVG image file which are replaced by the tile properties, like mHeaderFontColor
	Private const PH_SVG_FRAME_FILL         As String = "#FRAME_FILL#"				' Tile background color
	Private const PH_SVG_FRAME_STROKE       As String = "#FRAME_STROKE#"			' Tile border color
	Private const PH_SVG_FRAME_STROKE_WIDTH	As String = "#FRAME_STROKE_WIDTH#"		' Tile border width

	Private const PH_SVG_HEADER_TEXT		As String = "#HEADER_TEXT#"
	Private const PH_SVG_HEADER_FILL		As String = "#HEADER_FILL#"
	Private const PH_SVG_HEADER_FONT_SIZE	As String = "#HEADER_FONT_SIZE#"
	Private const PH_SVG_VALUE_TEXT			As String = "#VALUE_TEXT#"
	Private const PH_SVG_VALUE_FILL			As String = "#VALUE_FILL#"
	Private const PH_SVG_VALUE_FONT_SIZE	As String = "#VALUE_FONT_SIZE#"
	Private const PH_SVG_FOOTER_TEXT		As String = "#FOOTER_TEXT#"
	Private const PH_SVG_FOOTER_FILL		As String = "#FOOTER_FILL#"
	Private const PH_SVG_FOOTER_FONT_SIZE	As String = "#FOOTER_FONT_SIZE#"

	' Special cases like SevenSegment
	Private const PH_SVG_VALUE_CONTAINER_FILL	As String = "#VALUE_CONTAINER_FILL#"			' Container background color
	Private const PH_SVG_VALUE_CONTAINER_STROKE	As String = "#VALUE_CONTAINER_STROKE#"			' Container border color

	' =========================
	' COLORS LIGHTTHEME (DEFAULT)
	' =========================
	Public COLOR_HEADER 					As String = "#94A3B8"
	Public COLOR_VALUE 						As String = "#0F172A"
	Public COLOR_FOOTER 					As String = "#64748b"
	Public COLOR_RED 						As String = "#FF0000"
	Public COLOR_DARKGRAY 					As String = "#64748B"

	' =========================
	' FONTS
	' Colors as HTML HEX string, i.e.#RRGGBB
	' =========================
	Private mHeaderFontSize 				As Int = 11
	Private mHeaderFontColor 				As String = COLOR_HEADER
	Private mValueFontSize 					As Int = 24
	Private mValueFontColor 				As String = COLOR_VALUE	
	Private mFooterFontSize 				As Int = 10
	Private mFooterFontColor 				As String = COLOR_FOOTER

	' =========================
	' COLORS DARKTHEME
	' =========================
	Public THEMEDARK_COLOR_STATE_NORMAL 	As String = "#E0E0E0"
	Public THEMEDARK_COLOR_STATE_WARNING	As String = "#FF0000"

	Public THEMEDARK_BACKGROUNDCOLOR_ROOT 	As String = "#121212"	' xui.Color_ARGB(255, 18, 18, 18)
	Public THEMEDARK_BACKGROUNDCOLOR_TILE 	As String = "#1E1E1E"	' xui.Color_ARGB(255, 30, 30, 30)
	Public THEMEDARK_TEXTCOLOR_HEADER 		As String = "#FFFFFF"
	Public THEMEDARK_TEXTCOLOR_VALUE 		As String = "#E0E0E0"
	Public THEMEDARK_TEXTCOLOR_FOOTER 		As String = "#E0E0E0"

	' =========================
	' SEGMENTS
	' Tile segment names and color HTML HEX format (used by tiles like Gauge)
	' =========================
	Public SEGMENT_GREEN					As String = "green"
	Public SEGMENT_YELLOW					As String = "yellow"
	Public SEGMENT_RED						As String = "red"
	Public SEGMENT_GREEN_COLOR 				As String = "#22c55e"
	Public SEGMENT_YELLOW_COLOR				As String = "#eab308"
	Public SEGMENT_RED_COLOR 				As String = "#ef4444"
	
	' =========================
	' UNITS (SELECTIVE)
	' =========================
	Public UNIT_CELSIUS         			As String = "°C"      ' Ambient/Water temperature
	Public UNIT_HUMIDITY        			As String = "% RH"    ' Relative Humidity (distinguishes from battery %)
	Public UNIT_CO2             			As String = "ppm"     ' Indoor Air Quality / CO2 levels

	Public UNIT_KW              			As String = "kW"      ' High-power draws (EV chargers, Heat pumps)
	Public UNIT_KWH             			As String = "kWh"     ' Daily solar yield / Total consumption
	Public UNIT_VOLT            			As String = "V"       ' Grid or battery voltage monitoring
	Public UNIT_AMPERE          			As String = "A"       ' Current monitoring

	Public UNIT_L_PER_MIN       			As String = "L/min"   ' Current water flow rate
	Public UNIT_M3_PER_HR       			As String = "m³/h"    ' Current gas flow rate

	Public UNIT_W 							As String = "W"
	Public UNIT_PCT 						As String = "%"
	Public UNIT_KWH_PER_YEAR 				As String = "kWh/yr"
	Public UNIT_M3_PER_YEAR 				As String = "m³/yr"

	Public UNIT_EUR             			As String = "€"       ' Current daily cost or feed-in credit
End Sub

' Initialize
' Initialize the tile.
' Parameter:
' Callback - Object
' Eventname - String
Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	mItems.Initialize
End Sub

' DesignerCreateView 
' Base type must be Object.
Private Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)	'ignore
	BasePane = Base
    Tag = BasePane.Tag
    BasePane.Tag = Me 
	' Layout must be loaded after view has been created.
	CallSubDelayed2(Me, "AfterLoadLayout", Props)
End Sub

Private Sub AfterLoadLayout(Props As Map)	'ignore
	BasePane.LoadLayout("hmitilesio")
	
	' Store designer properties (keys must in lowercase) with defaults (use same as #DesignerProperty)
	mTileType 			= Props.GetDefault("tiletype", TILE_READOUT)
	mTileType			= mTileType.ToUpperCase
	mID 				= Props.GetDefault("id", "ID")
	mHeader 			= Props.GetDefault("header", "")
	mFooter 			= Props.GetDefault("footer", "")
	mValue 				= Props.GetDefault("value", 0)
	mMinValue 			= Props.GetDefault("minvalue", 0)
	mMaxValue 			= Props.GetDefault("maxvalue", 100)
	mGreenMaxPct		= Props.GetDefault("greenmaxpct", 70)
	mYellowMaxPct		= Props.GetDefault("yellowmaxpct", 100)
	mState 				= Props.GetDefault("state", False)
	mBackgroundColor	= HMITilesIOUtils.PropsColorToHex(Props.GetDefault("backgroundcolor", 0xFFFFFFFF))
	mBorderColor		= HMITilesIOUtils.PropsColorToHex(Props.GetDefault("bordercolor", 0xFF334155))
	mBorderWidth		= Props.GetDefault("borderwidth", 1)
	mHeaderFontColor 	= HMITilesIOUtils.PropsColorToHex(Props.GetDefault("headerfontcolor", 0xFF475569))
	mHeaderFontSize 	= Props.GetDefault("headerfontsize", 11)
	mValueFontColor 	= HMITilesIOUtils.PropsColorToHex(Props.GetDefault("valuefontcolor", 0xFF0F172A))
	mValueFontSize 		= Props.GetDefault("valuefontsize", 24)
	mFooterFontColor 	= HMITilesIOUtils.PropsColorToHex(Props.GetDefault("footerfontcolor", 0xFF64748B))
	mFooterFontSize 	= Props.GetDefault("footerfontsize", 10)

	' Init the instance depending tiletype
	InitInstance
	
	' Style and resize
	ApplyStyle
	Base_Resize(BasePane.Width, BasePane.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	If Not(WebViewSVG.IsInitialized) Then Return
	DrawImage
End Sub

' =========================
' INSTANCES
' =========================

' InitInstance
' Init the selected instance based on its tiletype.
' After initialization, the tile is set with defaults.
Private Sub InitInstance
	mIsReady = False

	Select mTileType
		Case TILE_ALARM
			InstanceAlarm.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceAlarm.SetTile(mHeader, mFooter, mValue)
		Case TILE_BATTERY
			InstanceBattery.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceBattery.SetTile(mHeader, mFooter, mValue)
		Case TILE_BUTTON
			InstanceButton.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceButton.SetTile(mHeader, mFooter, mState)
		Case TILE_BYTESTATUS
			InstanceByteStatus.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			Dim pins() As Byte = Array As Byte(1,1,1,1,1,1,1,1)
			InstanceByteStatus.SetTile(mHeader, mFooter, pins, mValue)
		Case TILE_COMPASS
			InstanceCompass.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			If mValue.Length = 0 Then mValue = 0
			InstanceCompass.SetTile(mHeader, mFooter, mValue)
		Case TILE_DUALREADOUT
			InstanceDualReadOut.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceDualReadOut.SetTile(mHeader, mFooter, mValue)
		Case TILE_GAUGE
			InstanceGauge.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			If mValue.Length = 0 Then mValue = 0
			InstanceGauge.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mGreenMaxPct, mYellowMaxPct, mValue)
		Case TILE_HORIZON
			InstanceHorizon.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			If mValue.Length = 0 Then mValue = 0
			InstanceHorizon.SetTile(mHeader, mFooter, mValue)
		Case TILE_ICONINDICATOR
			InstanceIconIndicator.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceIconIndicator.SetTile(mHeader, mFooter, mValue)
		Case TILE_IOPANEL
			InstanceIOPanel.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceIOPanel.SetTile(mHeader, mFooter, mValue)
		Case TILE_LEDPANEL
			InstanceLEDPanel.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceLEDPanel.SetTile(mHeader, mFooter, mState)
		Case TILE_LOADINGINDICATOR
			InstanceLoadingIndicator.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceLoadingIndicator.SetTile(mHeader, mFooter, mState)
		Case TILE_MULTISTATE
			InstanceMultiState.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			Dim states() As Byte = Array As Byte(0,0,0,0,0,0,0,0)
			InstanceMultiState.SetTile(mHeader, mFooter, states, mValue)
		Case TILE_READOUT
			InstanceReadOut.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceReadOut.SetTile(mHeader, mFooter, mValue)
		Case TILE_QUADREADOUT
			InstanceQuadReadOut.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceQuadReadOut.SetTile(mHeader, mFooter, mValue)
		Case TILE_SELECTOR
			InstanceSelector.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceSelector.SetTile(mHeader, mFooter, mValue)
		Case TILE_SEVENSEGMENT
			InstanceSevenSegment.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceSevenSegment.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue)
		Case TILE_SIGNAL
			InstanceSignal.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			If Not(IsNumber(mValue)) Then mValue = 0
			If mValue.Length = 0 Then mValue = 0
			InstanceSignal.SetTile(mHeader, mFooter, mValue)
		Case TILE_SLIDER
			InstanceSlider.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			If Not(IsNumber(mValue)) Then mValue = 0
			If mValue.Length = 0 Then mValue = 0
			InstanceSlider.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue)
		Case TILE_SPINNER
			InstanceSpinner.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			If Not(IsNumber(mValue)) Then mValue = 0
			If mValue.Length = 0 Then mValue = 0
			InstanceSpinner.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue)
		Case TILE_SWITCH
			InstanceSwitch.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceSwitch.SetTile(mHeader, mFooter, mState)
		Case TILE_TRENDCHART
			InstanceTrendChart.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			If mValue.Length = 0 Then mValue = 0
			InstanceTrendChart.SetTile(mHeader, mFooter, mValue)
		Case TILE_TILTGAUGE
			InstanceTiltGauge.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			If mValue.Length = 0 Then mValue = 0
			InstanceTiltGauge.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue, InstanceTiltGauge.Inverted)
		Case TILE_TIMER
			InstanceTimer.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			If mValue.Length = 0 Then mValue = 0
			InstanceTimer.SetTile(mHeader, mFooter, mValue)
		Case TILE_VERTICALMETER
			InstanceVerticalMeter.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			If mValue.Length = 0 Then mValue = 0
			InstanceVerticalMeter.SetTile(mHeader, mFooter, "#22c55e", mMinValue, mMaxValue, mValue)
		Case TILE_WATCHDOG
			InstanceWatchdog.Initialize(Me, PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			If mValue.Length = 0 Then mValue = 0
			InstanceWatchdog.SetTile(mHeader, mFooter, mValue)
		Case Else
			Return
	End Select
End Sub

' =========================
' TILE STYLE
' =========================

' ApplyStyle
' Apply style Normal with border styling borderless.
Private Sub ApplyStyle
	BasePane.Color = HMITilesIOUtils.HexToColor(mBackgroundColor) '0xFF4A5560	
	BasePane.SetColorAndBorder(BasePane.Color, 0, 0, 0)
End Sub

' =========================
' Drawing methods
' =========================

' DrawImage
' Load the static canvas structure only one single time.
' When done, the event webview pagefinished is called.
Public Sub DrawImage
	' Load the core HTML, named the image markup, to dispay the SVG image
	Dim htmlcode As String = File.ReadString(File.DirAssets, TILE_MARKUP_FILE)

	' Get the image SVG XML markup using the tiletype (lowercase)
	Dim filename As String = $"${mTileType.ToLowerCase}.svg"$
	Try
		' Read the SVG XML file like readout.svg
		Dim tilesvgmarkup As String = File.ReadString(File.DirAssets, filename)		
	Catch
		Log($"[HTMLTilesIO.DrawImage][E] Failed loading SVG ${filename}: ${LastException.Message}"$)
		Return
	End Try
	
	' Check special cases
	Select mTileType
		Case TILE_SEVENSEGMENT
			' Load the svg markup with digital font
			tilesvgmarkup = InstanceSevenSegment.LoadTemplate(tilesvgmarkup)
	End Select

	' Append a random ID attribute so the WebEngine treats it as a completely brand new document structure.
	Dim UniqueID As String = $"id="svg_render_${DateTime.Now}""$
	If htmlcode.Contains("<body") Then
		htmlcode= htmlcode.Replace("<body", $"<body ${UniqueID}"$)
	End If

	' Replace the placeholders
	' Imageplace holder in the HMTL file with the SVG xml content
	htmlcode = htmlcode.Replace(PH_HTML_IMAGE, tilesvgmarkup)

	' SVG placeholders
	htmlcode = htmlcode.Replace(PH_SVG_FRAME_FILL			, mBackgroundColor)
	htmlcode = htmlcode.Replace(PH_SVG_FRAME_STROKE			, mBorderColor)
	htmlcode = htmlcode.Replace(PH_SVG_FRAME_STROKE_WIDTH	, mBorderWidth)
	htmlcode = htmlcode.Replace(PH_SVG_HEADER_TEXT			, mHeader)
	htmlcode = htmlcode.Replace(PH_SVG_HEADER_FILL			, mHeaderFontColor)
	htmlcode = htmlcode.Replace(PH_SVG_HEADER_FONT_SIZE		, mHeaderFontSize)
	htmlcode = htmlcode.Replace(PH_SVG_VALUE_TEXT			, mValue)
	htmlcode = htmlcode.Replace(PH_SVG_VALUE_FILL			, mValueFontColor)
	htmlcode = htmlcode.Replace(PH_SVG_VALUE_FONT_SIZE		, mValueFontSize)
	htmlcode = htmlcode.Replace(PH_SVG_FOOTER_TEXT			, mFooter)
	htmlcode = htmlcode.Replace(PH_SVG_FOOTER_FILL			, mFooterFontColor)
	htmlcode = htmlcode.Replace(PH_SVG_FOOTER_FONT_SIZE		, mFooterFontSize)
	' Special cases
	htmlcode = htmlcode.Replace(PH_SVG_VALUE_CONTAINER_FILL		, mBackgroundColor)
	htmlcode = htmlcode.Replace(PH_SVG_VALUE_CONTAINER_STROKE	, mBorderColor)

	' Load the HTML markup with the XML markup
	WebViewSVG.LoadHtml(htmlcode)
End Sub

' =========================
' Public API
' =========================

'---------------------------------------
' TILETYPE
'---------------------------------------

' Set or get the tile type.
' Parameter:
' value - String Tile type, like Gauge, Switch etc.
Public Sub setTileType(value As String)
	mTileType = value.ToUpperCase
	
	' 1. Reinit instance properties
	InitInstance
	
	' 2. Generate and load the completely fresh HTML file layout structure
	DrawImage
	
	' 3. SAFE GUARD: Allow the browser engine a brief moment to finish
	' parsing the new layout nodes before data updates are transmitted
	Sleep(50)
End Sub
Public Sub getTileType As String
	Return mTileType
End Sub

'---------------------------------------
' STATE
'---------------------------------------

' Get or set tile state.
' Supported are all tiles which use a state, like Button, LEDPanel, Switch.
' The state is assigned to mValue as binary 0 or 1 to global class var
' Parameter:
' state - Boolean False = Off/Closed, True = On/Open
Public Sub setState(state As Boolean)
	' Assign state as boolean to global class var
	mState = state

	' Delegate internally based on the instance configuration
	Select mTileType
		Case TILE_BUTTON
			mValue = IIf(state, 1, 0)
			InstanceButton.SetTile(mHeader, mFooter, mState)
		Case TILE_LEDPANEL
			mValue = IIf(state, 1, 0)
			InstanceLEDPanel.SetTile(mHeader, mFooter, mState)
		Case TILE_LOADINGINDICATOR
			mValue = IIf(state, 1, 0)
			InstanceLoadingIndicator.SetTile(mHeader, mFooter, mState)
		Case TILE_SWITCH
			mValue = IIf(state, 1, 0)
			InstanceSwitch.SetTile(mHeader, mFooter, mState)
		Case Else
			Return
	End Select
	' Mandatory sleep
	Sleep(1)
End Sub
Public Sub getState As Boolean
	Return mState
End Sub

'---------------------------------------
' VALUE
'---------------------------------------

' Set or get the tile value.
' Supported are tiles which use a value, like ByteStatus, Gauge, Selector, SevenSegment, Spinner, Slider, VerticalMeter.
' Parameter:
' value - String Value between min and max properties. The value is casted according tile type.
Public Sub setValue(value As String)
	' Assign the state value as binary 0 or 1 to global class var
	mValue = value

	' GLOBAL RENDERING GUARD: If the WebView hasn't finished rendering the base SVG yet,
	' exit early. The PageFinished event will automatically draw this mValue once it is ready.
	If Not(mIsReady) Then Return

	' Select the tile type and assign the value to global var with casting as required	
	Select mTileType
		Case TILE_ALARM
			InstanceAlarm.SetTile(mHeader, mFooter, mValue)
		Case TILE_BATTERY
			InstanceBattery.SetTile(mHeader, mFooter, mValue)
		Case TILE_BYTESTATUS
			InstanceByteStatus.SetTile(mHeader, mFooter, InstanceByteStatus.PinsAttached, mValue)
		Case TILE_COMPASS
			InstanceCompass.SetTile(mHeader, mFooter, mValue)
		Case TILE_DUALREADOUT
			InstanceDualReadOut.SetTile(mHeader, mFooter, mValue)
		Case TILE_GAUGE
			InstanceGauge.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mGreenMaxPct, mYellowMaxPct, mValue)
		Case TILE_HORIZON
			InstanceHorizon.SetTile(mHeader, mFooter, mValue)
		Case TILE_ICONINDICATOR
			InstanceIconIndicator.SetTile(mHeader, mFooter, mValue)
		Case TILE_IOPANEL
			InstanceIOPanel.SetTile(mHeader, mFooter, mValue)
		Case TILE_MULTISTATE
			InstanceMultiState.SetTile(mHeader, mFooter, InstanceMultiState.States, mValue)
		Case TILE_READOUT
			InstanceReadOut.SetTile(mHeader, mFooter, mValue)
		Case TILE_QUADREADOUT
			InstanceQuadReadOut.SetTile(mHeader, mFooter, mValue)
		Case TILE_SELECTOR
			InstanceSelector.SetTile(mHeader, mFooter, mValue)
		Case TILE_SEVENSEGMENT
			InstanceSevenSegment.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue)
		Case TILE_SIGNAL
			InstanceSignal.SetTile(mHeader, mFooter, mValue)
		Case TILE_SLIDER
			InstanceSlider.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue)
		Case TILE_SPINNER
			InstanceSpinner.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue)
		Case TILE_TILTGAUGE
			InstanceTiltGauge.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue, InstanceTiltGauge.Inverted)
		Case TILE_TIMER
			InstanceTimer.SetTile(mHeader, mFooter, mValue)
		Case TILE_TRENDCHART
			InstanceTrendChart.SetTile(mHeader, mFooter, mValue)
		Case TILE_VERTICALMETER
			InstanceVerticalMeter.SetTile(mHeader, mFooter, InstanceVerticalMeter.COLOR_TRACK, mMinValue, mMaxValue, mValue)
		Case TILE_WATCHDOG
			InstanceWatchdog.SetTile(mHeader, mFooter, mValue)
		Case Else
			Return
	End Select
End Sub
Public Sub getValue As String
	Return mValue
End Sub

' Set the tile value font size.
' Parameter:
' value - Int font size in pixels, like 24. Must be greater 0 else set to 24.
Public Sub setValueFontSize(value As Int)
	mValueFontSize = IIf(value > 0, value, 24)

	' Establish an attribute updates tracking map
	Dim attrUpdates As Map
	attrUpdates.Initialize
	
	' Prepare the safe, inline CSS rule text string
	Dim styleString As String = "font-size: " & value & "px;"

	' Resolve target element IDs safely using B4X rules instead of JavaScript variables
	Select mTileType
		Case TILE_DUALREADOUT
			' Target both sides of your split readout simultaneously
			attrUpdates.Put("value-left",  CreateMap("style": styleString))
			attrUpdates.Put("value-right", CreateMap("style": styleString))
			
		Case Else
			' Standard default layout text node target ID
			attrUpdates.Put("tile-value",  CreateMap("style": styleString))
	End Select

	' Bundle into your standard payload structure (no raw text updates needed here)
	Dim updatePayload As Map = CreateMap("attrs": attrUpdates)
	
	' Push directly to your central utility engine (removes the local 'Wait For' loop)
	HMITilesIOUtils.UpdateElementsViaJSON(WebViewSVG, updatePayload)
End Sub
Public Sub getValueFontSize As Int
	Return mValueFontSize
End Sub

' Set or get the tile value font color.
' Parameter:
' value - String Font color as HEX string with # prefix, like #FF0000 (red)
Public Sub setValueFontColor(value As String)
	' 1. Establish an attribute updates tracking map
	Dim attrUpdates As Map
	attrUpdates.Initialize
	
	' Prepare the safe, inline CSS rule text string
	Dim styleString As String = "fill: " & value & ";"

	' 2. Resolve target element IDs safely using B4X rules instead of JavaScript variables
	Select mTileType
		Case TILE_DUALREADOUT
			' Target both sides of your split readout simultaneously
			attrUpdates.Put("value-left",  CreateMap("style": styleString))
			attrUpdates.Put("value-right", CreateMap("style": styleString))
			
		Case Else
			' Standard default layout text node target ID
			attrUpdates.Put("tile-value",  CreateMap("style": styleString))
	End Select

	' 3. Bundle into your standard payload structure (no raw text updates needed here)
	Dim updatePayload As Map = CreateMap("attrs": attrUpdates)
	
	' 4. Push directly to your central utility engine (removes the local 'Wait For' loop)
	HMITilesIOUtils.UpdateElementsViaJSON(WebViewSVG, updatePayload)
End Sub
Public Sub getValueFontColor As String
	Return mValueFontColor
End Sub

' Set or get items as list.
' Used for the tiletype SELECTOR.
' Parameter:
' values - List with strings
Public Sub setItems(value As List)
	mItems = value
	Select mTileType
		Case TILE_SELECTOR
			InstanceSelector.SetItems(mItems)
	End Select
End Sub
Public Sub getItems As List
	Return mItems
End Sub

'---------------------------------------
' HEADER
'---------------------------------------

' Set or get tile header text.
' Parameter:
' value - String with the header text.
Public Sub setHeader(value As String)
	mHeader = value ' No manual character escaping needed!
	
	' Map the string directly to the header element ID in a text update container
	Dim textUpdates As Map = CreateMap("tile-header": mHeader)
	Dim updatePayload As Map = CreateMap("text": textUpdates)
	
	HMITilesIOUtils.UpdateElementsViaJSON(WebViewSVG, updatePayload)
End Sub
Public Sub getHeader As String
	Return mHeader
End Sub

' Set or get tile header font size.
' Parameter:
' value - Int font size; must be greater 0 else set to 12.
Public Sub setHeaderFontSize(value As Int)
	mHeaderFontSize = IIf(value > 0, value, 11)
	
	' 1. Map the inline CSS rule securely
	Dim attrUpdates As Map = CreateMap("tile-header": CreateMap("style": "font-size: " & value & "px;"))
	Dim updatePayload As Map = CreateMap("attrs": attrUpdates)
	
	HMITilesIOUtils.UpdateElementsViaJSON(WebViewSVG, updatePayload)
End Sub
Public Sub getHeaderFontSize As Int
	Return mHeaderFontSize
End Sub

' Set or get tile header font color.
' Parameter:
' value - String with font volor in HEX, like #FF0000 (red).
Public Sub setHeaderFontColor(value As String)
	mHeaderFontColor = value

	' Map the SVG fill attribute directly
	Dim attrUpdates As Map = CreateMap("tile-header": CreateMap("fill": value))
	Dim updatePayload As Map = CreateMap("attrs": attrUpdates)
	
	HMITilesIOUtils.UpdateElementsViaJSON(WebViewSVG, updatePayload)
End Sub
Public Sub getHeaderFontColor As String
	Return mHeaderFontColor
End Sub

'---------------------------------------
' FOOTER
'---------------------------------------

' Set or get the tile footer text.
' Parameter:
' value - String footer text.
Public Sub setFooter(value As String)
	mFooter = value
	
	Dim textUpdates As Map = CreateMap("tile-footer": mFooter)
	Dim updatePayload As Map = CreateMap("text": textUpdates)
	
	HMITilesIOUtils.UpdateElementsViaJSON(WebViewSVG, updatePayload)
End Sub
Public Sub getFooter As String
	Return mFooter
End Sub

' Get or set tile footer font size.
' Parameter:
' value - Int font size, like 24. Must be greater 0 else set to 12.
Public Sub setFooterFontSize(value As Int)
	mFooterFontSize = IIf(value > 0, value, 10)
	
	Dim attrUpdates As Map = CreateMap("tile-footer": CreateMap("style": "font-size: " & value & "px;"))
	Dim updatePayload As Map = CreateMap("attrs": attrUpdates)
	
	HMITilesIOUtils.UpdateElementsViaJSON(WebViewSVG, updatePayload)
End Sub
Public Sub getFooterFontSize As Int
	Return mFooterFontSize
End Sub

' Set or get the tile footer font color.
' Parameter:
' value - Font color as HEX string with # prefix, like #FF0000 (red)
Public Sub setFooterFontColor(value As String)
	mFooterFontColor = value
	
	Dim attrUpdates As Map = CreateMap("tile-footer": CreateMap("fill": value))
	Dim updatePayload As Map = CreateMap("attrs": attrUpdates)
	
	HMITilesIOUtils.UpdateElementsViaJSON(WebViewSVG, updatePayload)
End Sub

Public Sub getFooterFontColor As String
	Return mFooterFontColor
End Sub

'---------------------------------------
' COLOR
'---------------------------------------

' Get or set the tile background color.
' Dynamically Sets the background color of both the WebView Tile and the HTML content.
' Parameter:
' value - String color HEX format, like #FFFFFF (white)
Public Sub setBackgroundColor(value As String)
	mBackgroundColor = value

	' Create a global runtime CSS rule style script block
	' This overrides any hardcoded fill="url(#...)" attributes immediately upon element creation
	Dim js As String = $"
        var styleId = "b4x-dynamic-theme";
        var styleEl = document.getElementById(styleId);
        if (!styleEl) {
            styleEl = document.createElement("style");
            styleEl.id = styleId;
            document.head.appendChild(styleEl);
        };
        styleEl.innerHTML = "html, body { background-color: ${mBackgroundColor} !important; } svg > rect:first-of-type { fill: ${mBackgroundColor} !important; }";
    "$
	'
	HMITilesIOUtils.ExecuteJS(WebViewSVG, js)
End Sub
Public Sub getBackgroundColor As String
	Return mBackgroundColor
End Sub

' Get or set the tile border color.
' Parameter:
' value - String color HEX format, like #000000 (black)
Public Sub setBorderColor(value As String)
	mBorderColor = value
	
	' Map the structural tile frame element ID directly
	Dim attrUpdates As Map = CreateMap("tile-frame": CreateMap("stroke": value))
	Dim updatePayload As Map = CreateMap("attrs": attrUpdates)
	
	HMITilesIOUtils.UpdateElementsViaJSON(WebViewSVG, updatePayload)
End Sub
Public Sub getBorderColor As String
	Return mBorderColor
End Sub

' Get or set the tile border stroke width.
' Parameter:
' value - Int border width. Must be greater 0 else set to 1
Public Sub setBorderWidth(value As Int)
	If value < 0 Then value = 1
	mBorderWidth = value
	
	' Map the stroke-width presentation property cleanly
	Dim attrUpdates As Map = CreateMap("tile-frame": CreateMap("stroke-width": value))
	Dim updatePayload As Map = CreateMap("attrs": attrUpdates)
	
	HMITilesIOUtils.UpdateElementsViaJSON(WebViewSVG, updatePayload)
End Sub
Public Sub getBorderWidth As Int
	Return mBorderWidth
End Sub

' Set segment color for tile gauge.
' Parameter:
' segment - String green, yellow, red
' value - String with HTML HEX color, i.e. #00FF00
Public Sub SetSegmentColor(segment As String, value As String)
	Select mTileType
		Case TILE_GAUGE
			InstanceGauge.SetSegmentColor(segment, value)
	End Select
End Sub

' Set base properties for a tile backgroundcolor; header,value,footer font color and size.
' Recommendation: set the base properties for a tile in the designer, because if having many tiles webview sync issues might occur resultung in non-complete drawn tiles.
' Parameter:
' bgclr - String tile background color
' headerfontclr - String
' headerfontsize - Int
' valuefontclr - String
' valuefontsize - Int
' footerfontclr - String
' footerfontsize - Int
Public Sub SetBaseProperties( _
		bgclr As String, _
		headerfontclr As String, headerfontsize As Int, _
		valuefontclr As String, valuefontsize As Int, _
		footerfontclr As String, footerfontsize As Int)

	' Store operational variables in class variables so they survive across threads
	mBackgroundColor	= bgclr
	mHeaderFontColor   	= headerfontclr
	mHeaderFontSize    	= IIf(headerfontsize > 0, headerfontsize, 11)
	mValueFontColor    	= valuefontclr
	mValueFontSize     	= IIf(valuefontsize > 0, valuefontsize, 24)
	mFooterFontColor   	= footerfontclr
	mFooterFontSize    	= IIf(footerfontsize > 0, footerfontsize, 10)

	' Trigger background rule override injection
	setBackgroundColor(mBackgroundColor)

	' Attempt an initial synchronous styling push
	SyncTileBaseStyles
End Sub

' --- Central Private Utility to enforce style safety matrices ---
Private Sub SyncTileBaseStyles
	' Guard condition: If elements aren't initialized yet, let PageFinished catch it on the next loop
	If mHeaderFontColor = "" Then Return
	If mValueFontColor = "" Then Return
	If mFooterFontColor = "" Then Return

	' Group visual presentation attributes as explicit separate fields
	Dim attrUpdates As Map = CreateMap( _
		"tile-header": CreateMap("fill": mHeaderFontColor, "font-size": mHeaderFontSize & "px"), _
		"tile-value":  CreateMap("fill": mValueFontColor,  "font-size": mValueFontSize & "px"), _
		"tile-footer": CreateMap("fill": mFooterFontColor, "font-size": mFooterFontSize & "px") _
	)
	
	Dim updatePayload As Map = CreateMap("attrs": attrUpdates)
	HMITilesIOUtils.UpdateElementsViaJSON(WebViewSVG, updatePayload)
End Sub

'---------------------------------------
' MIN/MAXVALUE
'---------------------------------------

' Set or get the min value.
' Parameter:
' value - Float
' Returns:
' Float
Public Sub setMinValue(value As Float)
	mMinValue = value
	setValue(mValue)
End Sub
Public Sub getMinValue As Float
	Return mMinValue
End Sub

' Set or get the max value.
' Parameter:
' value - Float
' Returns:
' Float
Public Sub setMaxValue(value As Float)
	mMaxValue = value
	setValue(mValue)
End Sub
Public Sub getMaxValue As Float
	Return mMaxValue
End Sub

'---------------------------------------
' ID/DATA
'---------------------------------------

' Set or get the id.
' Parameter:
' value - String
' Returns:
' String
Public Sub setID(value As String)
	mID = value
End Sub
Public Sub getID As String
	Return mID
End Sub

' Set or get the additional data.
' Parameter:
' value - Object
' Returns:
' Object
Public Sub setData(value As Object)
	mData = value
End Sub
Public Sub getData As Object
	Return mData
End Sub


' =========================
' WEBVIEW EVENTS
' =========================

' PageFinished
' Automatically fires the moment the HTML DOM finishes loading completely.
' Parameter:
' url - String
Private Sub WebViewSVG_PageFinished (url As String)
	' Log($"[WebViewSVG_PageFinished] url=${Url}"$)
	setBackgroundColor(mBackgroundColor)

	Select mTileType
		Case TILE_SLIDER
			#if B4J
			InstanceSlider.Init(False)
			#End If
			#if B4A
			InstanceSlider.Init(0)
			#End If
	End Select

	' Set global readiness flag to TRUE now that the DOM tree exists completely
	mIsReady = True
	
	setState(mState)
	
	setValue(mValue)
End Sub

' LocationChanged
' Handle webview location changed by a tile type.
' Parameter:
' url - String
Private Sub WebViewSVG_LocationChanged (url As String) As Boolean
	' Log($"[WebViewSVG_LocationChanged] url=${url}"$)
    
	' Check the sender - ensure prefix is http://
	If url.StartsWith("http://slider") Then
		Dim valIdx As Int = url.IndexOf("val=")
		If valIdx > -1 Then
			Dim rawVal As String = url.SubString(valIdx + 4)
            
			' Extract the value and cast to integer safely
			Dim sliderPercentage As Int = Bit.ParseInt(rawVal, 10)
			mValue = sliderPercentage

			' Log($"[WebViewSVG_LocationChanged] value=${mValue}"$)
			If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
				CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue.As(String))
			End If
		End If
		' Block the WebView from trying to physically load a real webpage
		Return True
	End If
	Return False
End Sub

' =========================
' PANELWEBVIEW EVENTS
' =========================

' PanelWebViewSVG_Touch
' Handle touching the panel.
' Parameter:
' Action - Int Down (0) and Move (2) to handle tracking and dragging, Up(1) not used.
' X - Int x position.
' Y - Int y position.
Private Sub PanelWebViewSVG_Touch (Action As Int, X As Float, Y As Float)
	' Action Up not handled
	If Action = HMITilesIOUtils.ACTION_UP Then Return

	Dim targetInstance As Object = Null
	Dim touchData As HMITouchData
	
	' Assign the touch data
	touchData.Initialize
	touchData.Action = Action
	touchData.X = x
	touchData.Y = y
	touchData.state = mState
	touchData.value = mValue

	' Assign the targetinstance
	Dim targetInstance As Object = Null

	' Select the tiletype and assign the targetinstance
	Select mTileType		
		Case TILE_BATTERY:			targetInstance = InstanceBattery
		Case TILE_BUTTON:			targetInstance = InstanceButton
		Case TILE_BYTESTATUS:		targetInstance = InstanceByteStatus
		Case TILE_COMPASS:			targetInstance = InstanceCompass
		Case TILE_DUALREADOUT:		targetInstance = InstanceDualReadOut
		Case TILE_GAUGE:			targetInstance = InstanceGauge
		Case TILE_HORIZON:			targetInstance = InstanceHorizon
		Case TILE_ICONINDICATOR:	targetInstance = InstanceIconIndicator
		Case TILE_IOPANEL:			targetInstance = InstanceIOPanel
		Case TILE_MULTISTATE:		targetInstance = InstanceMultiState
		Case TILE_LEDPANEL:			targetInstance = InstanceLEDPanel
		Case TILE_LOADINGINDICATOR:	targetInstance = InstanceLoadingIndicator
		Case TILE_READOUT:			targetInstance = InstanceReadOut
		Case TILE_QUADREADOUT:		targetInstance = InstanceQuadReadOut
		Case TILE_SELECTOR:			targetInstance = InstanceSelector
		Case TILE_SEVENSEGMENT:		targetInstance = InstanceSevenSegment
		Case TILE_SIGNAL:			targetInstance = InstanceSignal
		Case TILE_SLIDER:			targetInstance = InstanceSlider
		Case TILE_SPINNER:			InstanceSpinner.MinValue = mMinValue
									InstanceSpinner.MaxValue = mMaxValue
									targetInstance = InstanceSpinner
		Case TILE_SWITCH:			targetInstance = InstanceSwitch
		Case TILE_TILTGAUGE:		targetInstance = InstanceTiltGauge
		Case TILE_TIMER:			targetInstance = InstanceTimer
		Case TILE_TRENDCHART:		targetInstance = InstanceTrendChart
		Case TILE_VERTICALMETER:	targetInstance = InstanceVerticalMeter
		Case TILE_WATCHDOG:			targetInstance = InstanceWatchdog
	End Select

	' Process the touch handler for the assigned instance
	If targetInstance <> Null Then
		' Pass all 5 touchdata parameters inside a single type asset
		Dim res As HMITouchResult = CallSub2(targetInstance, "ProcessTouchHandler", touchData)
		mState = res.State
		mValue = res.Value
	End If
End Sub
