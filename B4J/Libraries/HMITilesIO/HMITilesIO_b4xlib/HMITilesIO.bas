B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File: 		HMITilesIO.bas
' Brief:		CustomView Human Machine Interface tile showing assets from a SVG image.
' Date:			2026-09-15
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
' Layout:		Panel/Pane with WebView
'				+------------------+
'				|    Panel/Pane    | < 100% 120x120px
'				|+----------------+|
'				||    SVG Image   ||
'				|+----------------+|
'				+------------------+
' ================================================================
#End Region

' Designer properties (ensure to define the key in lowercase)
#DesignerProperty: Key: tiletype, DisplayName: Tile Type, FieldType: String, List: |Battery|Button|ByteStatus|DualReadOut|Gauge|IconIndicator|IOPanel|LEDPanel|MultiState|ReadOut|Selector|SevenSegment|Signal|Slider|Spinner|Switch|Timer|TrendChart|VerticalMeter|, DefaultValue: Switch.
#DesignerProperty: Key: header, DisplayName: Header, FieldType: String, DefaultValue: , Description: Header for all tiles.
#DesignerProperty: Key: footer, DisplayName: Footer, FieldType: String, DefaultValue: , Description: Footer for all tiles.
#DesignerProperty: Key: value, DisplayName: Value, FieldType: String, DefaultValue: , Description: Value for tile Spinner Gauge ReadOut SevenSegment Slider VerticalMeter.
#DesignerProperty: Key: minvalue, DisplayName: Min Value, FieldType: Float, DefaultValue: 0, Description: Min value for all tiles.
#DesignerProperty: Key: maxvalue, DisplayName: Max Value, FieldType: Float, DefaultValue: 100, Description: Max value for all tiles.
#DesignerProperty: Key: greenmaxpct, DisplayName: Green Max Pct, FieldType: Int, DefaultValue: 70, Description: Green segment for tile Gauge.
#DesignerProperty: Key: yellowmaxpct, DisplayName: Yellow Max Pct, FieldType: Int, DefaultValue: 90, , Description: Yellow segment for tile Gauge.
#DesignerProperty: Key: state, DisplayName: State, FieldType: Boolean, DefaultValue: False, Description: State true or false for tile Switch and LEDPanel.
#DesignerProperty: Key: backgroundcolor,DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Background color for all tiles.

' Events
#Event: Click(State As Boolean, Value As String)

Private Sub Class_Globals

	' Constants
	' Tile type names (uppercase) aligned with the designerProperty tiletype
	Private TILE_BATTERY As String 			= "BATTERY"
	Private TILE_BUTTON As String 			= "BUTTON"
	Private TILE_BYTESTATUS As String 		= "BYTESTATUS"
	Private TILE_DUALREADOUT As String 		= "DUALREADOUT"
	Private TILE_GAUGE As String 			= "GAUGE"
	Private TILE_IOPANEL As String 			= "IOPANEL"
	Private TILE_ICONINDICATOR As String 	= "ICONINDICATOR"
	Private TILE_SPINNER As String 			= "SPINNER"
	Private TILE_LEDPANEL As String 		= "LEDPANEL"
	Private TILE_MULTISTATE As String 		= "MULTISTATE"
	Private TILE_READOUT As String 			= "READOUT"
	Private TILE_SELECTOR As String 		= "SELECTOR"
	Private TILE_SEVENSEGMENT As String 	= "SEVENSEGMENT"
	Private TILE_SIGNAL As String 			= "SIGNAL"
	Private TILE_SLIDER As String 			= "SLIDER"
	Private TILE_SWITCH As String 			= "SWITCH"
	Private TILE_TIMER As String 			= "TIMER"
	Private TILE_TRENDCHART As String 		= "TRENDCHART"
	Private TILE_VERTICALMETER As String 	= "VERTICALMETER"

	' Tile segment names and color HTML HEX format (used by tiles like Gauge)	
	Public SEGMENT_GREEN			As String = "green"
	Public SEGMENT_YELLOW			As String = "yellow"
	Public SEGMENT_RED				As String = "red"
	Public SEGMENT_GREEN_COLOR 		As String = "#22c55e"
	Public SEGMENT_YELLOW_COLOR		As String = "#eab308"
	Public SEGMENT_RED_COLOR 		As String = "#ef4444"

	' Touch data
	Type HMITouchData (Action As Int, X As Float, Y As Float, State As Boolean, Value As String)
	' Touch result state
	Type HMITouchResult (State As Object, Value As String)

	' Base
	Public BasePane As B4XView
	Public Tag As Object
	
	' UI
	Private xui As XUI 'ignore
	Private WebViewSVG As WebView
	Private PanelWebViewSVG As B4XView	
	
	' Properties
	Private mTileType As String
	Private mHeader As String
	Private mFooter As String
	Private mValue As String
	Private mMinValue As Float
	Private mMaxValue As Float
	Private mGreenMaxPct As Int
	Private mYellowMaxPct As Int
	Private mBackgroundColor As String
	Private mState As Boolean

	' Local properties for specific tiles, like Selector
	Private mItems As List										' Selector

	' Local for events
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore

	' Instances (from the class modules)
	Public InstanceBattery 			As HMITilesIOBattery
	Public InstanceButton 			As HMITilesIOButton
	Public InstanceByteStatus 		As HMITilesIOByteStatus
	Public InstanceDualReadOut 		As HMITilesIODualReadOut
	Public InstanceGauge 			As HMITilesIOGauge
	Public InstanceIOPanel 			As HMITilesIOPanel
	Public InstanceIconIndicator 	As HMITilesIOIconIndicator
	Public InstanceLEDPanel 		As HMITilesIOLEDPanel
	Public InstanceMultiState 		As HMITilesIOMultiState
	Public InstanceReadOut 			As HMITilesIOReadOut
	Public InstanceSelector 		As HMITilesIOSelector
	Public InstanceSevenSegment		As HMITilesIOSevenSegment
	Public InstanceSignal 			As HMITilesIOSignal
	Public InstanceSlider 			As HMITilesIOSlider
	Public InstanceSpinner 			As HMITilesIOSpinner
	Public InstanceSwitch 			As HMITilesIOSwitch
	Public InstanceTimer 			As HMITilesIOTimer
	Public InstanceTrendChart 		As HMITilesIOTrendChart
	Public InstanceVerticalMeter	As HMITilesIOVerticalMeter
	
	' Local for SVG image
	Private IMAGE_MARKUP_PLACEHOLDER As String = "#IMAGE_PLACEHOLDER#"
	' SVG Image HMTL 
	Private IMAGE_MARKUP_FILE As String = "image.html"
	Private ImageMarkup As String

	' Local for font
	' Colors as HTML HEX string, i.e.#RRGGBB
	Private mHeaderFontSize 		As Int = 11
	Private mHeaderFontColor 		As String = "#94a3b8"		
	Private mValueFontSize 			As Int = 24
	Private mValueFontColor 		As String = "#0f172a"		
	Private mFooterFontSize 		As Int = 10
	Private mFooterFontColor 		As String = "64748b"		
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	mItems.Initialize
End Sub

'Base type must be Object
Private Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)	'ignore
	BasePane = Base
    Tag = BasePane.Tag
    BasePane.Tag = Me 
	CallSubDelayed2(Me, "AfterLoadLayout", Props)
End Sub

Private Sub AfterLoadLayout(Props As Map)	'ignore
	BasePane.LoadLayout("hmitilesio")

	' Store designer properties
	mTileType 			= Props.GetDefault("tiletype", "noasset")
	mTileType			= mTileType.ToUpperCase
	mHeader 			= Props.GetDefault("header", "")
	mFooter 			= Props.GetDefault("footer", "")
	mValue 				= Props.GetDefault("value", 0)
	mMinValue 			= Props.GetDefault("minvalue", 0)
	mMaxValue 			= Props.GetDefault("maxvalue", 100)
	mGreenMaxPct		= Props.GetDefault("greenmaxpct", 70)
	mYellowMaxPct		= Props.GetDefault("yellowmaxpct", 100)
	mState 				= Props.GetDefault("state", False)
	' Color
	Dim clr As Int		= xui.PaintOrColorToColor(Props.Get("backgroundcolor"))
	' Convert the B4X Int color to a standard web CSS hex string (#RRGGBB)
	mBackgroundColor	= $"#${Bit.ToHexString(clr).SubString(2)}"$

	' Load the HTML
	ImageMarkup = File.ReadString(File.DirAssets, IMAGE_MARKUP_FILE)

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

'InitInstance
' Init the selected instances from the tiletype
Private Sub InitInstance

	Select mTileType
		Case TILE_BATTERY
			InstanceBattery.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceBattery.SetTile(mHeader, mFooter, mValue)
		Case TILE_BUTTON
			InstanceButton.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceButton.SetTile(mHeader, mFooter, mState)
		Case TILE_BYTESTATUS
			InstanceByteStatus.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			Dim pins() As Byte = Array As Byte(1,1,1,1,1,1,1,1)
			InstanceByteStatus.SetTile(mHeader, mFooter, pins, mValue)
		Case TILE_DUALREADOUT
			InstanceDualReadOut.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceDualReadOut.SetTile(mHeader, mFooter, mValue)
		Case TILE_GAUGE
			InstanceGauge.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceGauge.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mGreenMaxPct, mYellowMaxPct, mValue)
		Case TILE_ICONINDICATOR
			InstanceIconIndicator.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceIconIndicator.SetTile(mHeader, mFooter, mValue)
		Case TILE_IOPANEL
			InstanceIOPanel.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceIOPanel.SetTile(mHeader, mFooter, mValue)
		Case TILE_LEDPANEL
			InstanceLEDPanel.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceLEDPanel.SetTile(mHeader, mFooter, mState)
		Case TILE_MULTISTATE
			InstanceMultiState.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			Dim states() As Byte = Array As Byte(0,0,0,0,0,0,0,0)
			InstanceMultiState.SetTile(mHeader, mFooter, states, mValue)
		Case TILE_READOUT
			InstanceReadOut.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceReadOut.SetTile(mHeader, mFooter, mValue)
		Case TILE_SELECTOR
			InstanceSelector.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceSelector.SetTile(mHeader, mFooter, mValue)
		Case TILE_SEVENSEGMENT
			InstanceSevenSegment.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceSevenSegment.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue)
		Case TILE_SIGNAL
			InstanceSignal.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceSignal.SetTile(mHeader, mFooter, mValue)
		Case TILE_SLIDER
			InstanceSlider.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceSlider.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue)
		Case TILE_SPINNER
			InstanceSpinner.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceSpinner.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue)
		Case TILE_SWITCH
			InstanceSwitch.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceSwitch.SetTile(mHeader, mFooter, mState)
		Case TILE_TRENDCHART
			InstanceTrendChart.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceTrendChart.SetTile(mHeader, mFooter, mValue)
		Case TILE_TIMER
			InstanceTimer.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceTimer.SetTile(mHeader, mFooter, mValue)
		Case TILE_VERTICALMETER
			InstanceVerticalMeter.Initialize(PanelWebViewSVG, WebViewSVG, mEventName, mCallBack)
			InstanceVerticalMeter.SetTile(mHeader, mFooter, "#22c55e", mMinValue, mMaxValue, mValue)
		Case Else
			Return
	End Select
	Sleep(1)
End Sub

' =========================
' TILE STYLE
' =========================

' ApplyStyle
' Apply style Normal with border styling borderless.
Private Sub ApplyStyle
	BasePane.Color = 0xFF4A5560	
	BasePane.SetColorAndBorder(BasePane.Color, 0, 0, 0)
End Sub

' =========================
' Drawing methods
' =========================

' DrawImage
' Load the static canvas structure only one single time
' When done, the event webview pagefinished is called
Public Sub DrawImage
	' Get the image SVG XML markup using the tiletype (lowercase)
	Dim filename As String = $"${mTileType.ToLowerCase}.svg"$
	Try
		' Read the XML markup
		Dim xmlmarkup As String = File.ReadString(File.DirAssets, filename)		
	Catch
		Log($"[Public Sub DrawImage][E] can not load SVG ${filename} ${LastException.Message}"$)
		Return
	End Try
	
	' Check special cases
	Select mTileType
		Case TILE_SEVENSEGMENT
			' Load the xml markup with digital font
			xmlmarkup = InstanceSevenSegment.LoadTemplate(xmlmarkup)
	End Select
	
	' Load the HTML markup with the XML markup
	WebViewSVG.LoadHtml(ImageMarkup.Replace(IMAGE_MARKUP_PLACEHOLDER, xmlmarkup))
End Sub

' =========================
' Public API
' =========================

' Set or get the tile type.
' Parameter:
'	value - Tile type, like Gauge, Switch etc.
' Returns:
'	String
Public Sub setTileType(value As String)
	mTileType = value.ToLowerCase
	DrawImage
End Sub
Public Sub getTileType As String
	Return mTileType
End Sub

'---------------------------------------
' STATE
'---------------------------------------

' Get or set tile state.
' Supported are all tiles which use a state, like Button, LEDPanel, Switch.
' Parameter
' 	state: False = Off/Closed, True = On/Open
Public Sub setState(state As Boolean)
	' Assign state as boolean to global class var
	mState = state
	' Assign the state value as binary 0 or 1 to global class var 
	mValue = IIf(state, 1, 0)

	' Delegate internally based on the instance configuration
	Select mTileType
		Case TILE_BUTTON
			InstanceButton.SetTile(mHeader, mFooter, mState)
		Case TILE_LEDPANEL
			InstanceLEDPanel.SetTile(mHeader, mFooter, mState)
		Case TILE_SWITCH
			InstanceSwitch.SetTile(mHeader, mFooter, mState)
		Case Else
			Return
	End Select
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
'	value - Value between min and max properties. The value is casted according tile type.
Public Sub setValue(value As String)
	' Assign the state value as binary 0 or 1 to global class var
	mValue = value

	' Select the tile type and assign the value to global var with casting as required	
	Select mTileType
		Case TILE_BATTERY
			InstanceBattery.SetTile(mHeader, mFooter, mValue)
		Case TILE_BYTESTATUS
			InstanceByteStatus.SetTile(mHeader, mFooter, InstanceByteStatus.PinsAttached, mValue)
		Case TILE_DUALREADOUT
			InstanceDualReadOut.SetTile(mHeader, mFooter, mValue)
		Case TILE_GAUGE
			InstanceGauge.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mGreenMaxPct, mYellowMaxPct, mValue)
		Case TILE_ICONINDICATOR
			InstanceIconIndicator.SetTile(mHeader, mFooter, mValue)
		Case TILE_IOPANEL
			InstanceIOPanel.SetTile(mHeader, mFooter, mValue)
		Case TILE_MULTISTATE
			InstanceMultiState.SetTile(mHeader, mFooter, InstanceMultiState.States, mValue)
		Case TILE_READOUT
			InstanceReadOut.SetTile(mHeader, mFooter, mValue)
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
		Case TILE_TIMER
			InstanceTimer.SetTile(mHeader, mFooter, mValue)
		Case TILE_TRENDCHART
			InstanceTrendChart.SetTile(mHeader, mFooter, mValue)
		Case TILE_VERTICALMETER
			InstanceVerticalMeter.SetTile(mHeader, mFooter, InstanceVerticalMeter.COLOR_TRACK, mMinValue, mMaxValue, mValue)
		Case Else
			Return
	End Select
	Sleep(1)
End Sub
Public Sub getValue As String
	Return mValue
End Sub

' Set or get the tile value font size.
' Parameter:
'	value - font size, like 24
Public Sub setValueFontSize(value As Int)
	Dim js As String 

	mValueFontSize = value

	' Handle special cases
	Select mTileType
		Case TILE_DUALREADOUT
			js = $"
					var valueleft = document.getElementById("value-left");
					var valueright = document.getElementById("value-right");
					if(valueleft) { valueleft.style.fontSize = "${value}"; };
					if(valueright) { valueright.style.fontSize = "${value}"; };
				"$
		Case Else
			js = $"
		        	var valuedisplay = document.getElementById("value-display");
		        	if (valuedisplay) { valuedisplay.style.fontSize = "${value}px"; }
		    	"$
	End Select

	Wait for (HMITilesIOUtils.ExecuteJS(WebViewSVG, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setValueFontSize][E] Can not set the value font size ${mValueFontSize}"$)
	End If
End Sub
Public Sub getValueFontSize As Int
	Return mValueFontSize
End Sub

' Set or get the tile value font color.
' Parameter:
'	value - Font color as HEX string with # prefix, like #FF0000 (red)
Public Sub setValueFontColor(value As String)
	Dim js As String
	
	mValueFontColor = value
 
 	Select mTileType
		Case TILE_DUALREADOUT
			js = $"
					var valueleft = document.getElementById("value-left");
					var valueright = document.getElementById("value-right");
					if(valueleft) { valueleft.style.fill = "${value}"; };
					if(valueright) { valueright.style.fill = "${value}"; };
				"$			
		Case Else
			js = $"
        			var valuedisplay = document.getElementById("value-display");
			        if (valuedisplay) { valuedisplay.style.fill = "${value}"; }
    			"$

	End Select
	
	Wait for (HMITilesIOUtils.ExecuteJS(WebViewSVG, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setValueFontColor][E] Can not set color ${mValueFontColor}; js=${js}"$)
	End If
End Sub
Public Sub getValueFontColor As String
	Return mValueFontColor
End Sub

' Get or set items as list
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

' Set or get the tile header.
' Parameter:
'	value - header
Public Sub setHeader(value As String)
	mHeader = value.Replace("'", "\'")
	Dim js As String = $"
        var header = document.getElementById("tile-header");
        if(header) { header.textContent = "${mHeader}"; };
    "$

	Wait for (HMITilesIOUtils.ExecuteJS(WebViewSVG, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setHeader][E] Can not set the tile header ${mTileType}"$)
	End If
End Sub
Public Sub getHeader As String
	Return mHeader
End Sub

' Set or get the tile header font size.
' Parameter:
'	value - font size, like 24
Public Sub setHeaderFontSize(value As Int)
	mHeaderFontSize = value
	Dim js As String = $"
        var tileheader = document.getElementById("tile-header");
        if (tileheader) { tileheader.style.fontSize = "${value}px"; }
    "$

	Wait for (HMITilesIOUtils.ExecuteJS(WebViewSVG, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setHeaderFontSize][E] Can not set the value font size ${mHeaderFontSize}"$)
	End If
End Sub
Public Sub getHeaderFontSize As Int
	Return mHeaderFontSize
End Sub

' Set or get the tile header font color.
' Parameter:
'	value - Font color as HEX string with # prefix, like #FF0000 (red)
Public Sub setHeaderFontColor(value As String)
	mHeaderFontColor = value
	Dim js As String = $"
        var tileheader = document.getElementById("tile-header");
        if (tileheader) { tileheader.style.fill = "${value}"; }
    "$

	Wait for (HMITilesIOUtils.ExecuteJS(WebViewSVG, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setHeaderFontColor][E] Can not set color ${mHeaderFontColor}"$)
	End If
End Sub
Public Sub getHeaderFontColor As String
	Return mHeaderFontColor
End Sub

'---------------------------------------
' FOOTER
'---------------------------------------

' Set or get the tile footer.
' Parameter:
'	value - footer
Public Sub setFooter(value As String)
	mFooter = value.Replace("'", "\'")
	Dim js As String = $"
        var footer = document.getElementById("tile-footer");
        if(footer) { footer.textContent = "${mFooter}"; };
    "$

	Wait for (HMITilesIOUtils.ExecuteJS(WebViewSVG, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setFooter][E] Can not set the tile footer ${mTileType}"$)
	End If
End Sub
Public Sub getFooter As String
	Return mFooter
End Sub

' Set or get the tile footer font size.
' Parameter:
'	value - font size, like 24
Public Sub setFooterFontSize(value As Int)
	' mValueFontSize = value
	Dim js As String = $"
        var tilefooter = document.getElementById("tile-footer");
        if (tilefooter) { tilefooter.style.fontSize = "${value}px"; }
    "$

	Wait for (HMITilesIOUtils.ExecuteJS(WebViewSVG, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setFooterFontSize][E] Can not set the value font size ${mFooterFontSize}"$)
	End If
End Sub
Public Sub getFooterFontSize As Int
	Return mFooterFontSize
End Sub

' Set or get the tile footer font color.
' Parameter:
'	value - Font color as HEX string with # prefix, like #FF0000 (red)
Public Sub setFooterFontColor(value As String)
	mFooterFontColor = value
	Dim js As String = $"
        var tilefooter = document.getElementById("tile-footer");
        if (tilefooter) { tilefooter.style.fill = "${value}"; }
    "$

	Wait for (HMITilesIOUtils.ExecuteJS(WebViewSVG, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setFooterFontColor][E] Can not set color ${mFooterFontColor}"$)
	End If
End Sub
Public Sub getFooterFontColor As String
	Return mFooterFontColor
End Sub


' Get or set the tile background color.
' Dynamically Sets the background color of both the WebView Tile and the HTML content
'	value - Font color as HEX string with # prefix, like #FF0000 (red)
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
	Wait for (HMITilesIOUtils.ExecuteJS(WebViewSVG, js)) complete (result As Boolean)
	If Not(result) Then
		Log("[setBackgroundColor][E] DOM not ready yet, but styling rule queued.")
	End If
End Sub
Public Sub getBackgroundColor As String
	Return mBackgroundColor
End Sub

' Set segment color for tile gauge.
' Parameter:
'	segment - string green, yellow, red
'	value - string with HTML HEX color, i.e. "#00FF00
Public Sub SetSegmentColor(segment As String, value As String)
	Select mTileType
		Case TILE_GAUGE
			InstanceGauge.SetSegmentColor(segment, value)
	End Select
End Sub

' =========================
' WEBVIEW EVENTS
' =========================

' PageFinished
' Automatically fires the moment the HTML DOM finishes loading completely
Private Sub WebViewSVG_PageFinished (Url As String)
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

	setValue(mValue)
End Sub

' LocationChanged
' Handle webview location changed by a tile type
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
' Action: Down (0) and Move (2) to handle tracking and dragging, Up(1) not used
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
		Case TILE_DUALREADOUT:		targetInstance = InstanceDualReadOut
		Case TILE_GAUGE:			targetInstance = InstanceGauge
		Case TILE_ICONINDICATOR:	targetInstance = InstanceIconIndicator
		Case TILE_IOPANEL:			targetInstance = InstanceIOPanel
		Case TILE_MULTISTATE:		targetInstance = InstanceMultiState
		Case TILE_LEDPANEL:			targetInstance = InstanceLEDPanel
		Case TILE_READOUT:			targetInstance = InstanceReadOut
		Case TILE_SELECTOR:			targetInstance = InstanceSelector
		Case TILE_SEVENSEGMENT:		targetInstance = InstanceSevenSegment
		Case TILE_SIGNAL:			targetInstance = InstanceSignal
		Case TILE_SLIDER:			targetInstance = InstanceSlider
		Case TILE_SPINNER:			InstanceSpinner.MinValue = mMinValue
									InstanceSpinner.MaxValue = mMaxValue
									targetInstance = InstanceSpinner
		Case TILE_SWITCH:			targetInstance = InstanceSwitch
		Case TILE_TRENDCHART:		targetInstance = InstanceTrendChart
		Case TILE_VERTICALMETER:	targetInstance = InstanceVerticalMeter
	End Select

	' Process the touch handler for the assigned instance
	If targetInstance <> Null Then
		' Pass all 5 parameters inside a single type asset
		Dim res As HMITouchResult = CallSub2(targetInstance, "ProcessTouchHandler", touchData)
		mState = res.State
		mValue = res.Value
	End If
End Sub
