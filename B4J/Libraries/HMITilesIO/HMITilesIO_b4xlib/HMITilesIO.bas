B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File: 		HMITilesIO.bas
' Brief:		CustomView HMITile showing an asset from a SVG image.
' Date:			2026-08-23
' Author:		Robert W.B. Linn (c) 2026 MIT
' Description:	
' Hints: 		HMITile can not be resized after form loaded.
' Layout:
'				+------------------+
'				|     SVG Image    |  < 100% 120x120px
'				+------------------+
' ================================================================
#End Region


' Designer properties (ensure to define the key in lowercase)
#DesignerProperty: Key: tiletype, DisplayName: Tile Type, FieldType: String, List: |ByteStatus|Gauge|LEDPanel|ReadOut|SevenSegment|Slider|Spinner|Switch||VerticalMeter|, DefaultValue: Switch
#DesignerProperty: Key: header, DisplayName: Header, FieldType: String, DefaultValue: Header, Description: Header for all tiles
#DesignerProperty: Key: footer, DisplayName: Footer, FieldType: String, DefaultValue: Footer, Description: Footer for all tiles
#DesignerProperty: Key: value, DisplayName: Value, FieldType: String, DefaultValue: , Description: Value for SPINNER Gauge ReadOut SevenSegment Slider VerticalMeter
#DesignerProperty: Key: minvalue, DisplayName: Min Value, FieldType: Float, DefaultValue: 0, Description: Min value for all tiles
#DesignerProperty: Key: maxvalue, DisplayName: Max Value, FieldType: Float, DefaultValue: 100, Description: Max value for all tiles
#DesignerProperty: Key: greenmaxpct, DisplayName: Green Max Pct, FieldType: Int, DefaultValue: 70, Description: Green segment  for Gauge
#DesignerProperty: Key: yellowmaxpct, DisplayName: Yellow Max Pct, FieldType: Int, DefaultValue: 90, , Description: Yellow segment for Gauge
#DesignerProperty: Key: state, DisplayName: State, FieldType: Boolean, DefaultValue: False, Description: State true or false for Switch and LEDPanel
#DesignerProperty: Key: backgroundcolor,DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Background color for all tiles

' Events
#Event: Click(State As Boolean, Value As String)

private Sub Class_Globals

	' Constants
	Private TILE_BYTESTATUS As String 		= "BYTESTATUS"
	Private TILE_GAUGE As String 			= "GAUGE"
	Private TILE_SPINNER As String 			= "SPINNER"
	Private TILE_LEDPANEL As String 		= "LEDPANEL"
	Private TILE_READOUT As String 			= "READOUT"
	Private TILE_SEVENSEGMENT As String 	= "SEVENSEGMENT"
	Private TILE_SLIDER As String 			= "SLIDER"
	Private TILE_SWITCH As String 			= "SWITCH"
	Private TILE_VERTICALMETER As String 	= "VERTICALMETER"
	
	' Base
	Public BasePane As B4XView
	Public Tag As Object
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	
	' UI
	Private xui As XUI 'ignore
	Private WebViewSVG As WebView
	' #if B4A
	Private PanelWebViewSVG As B4XView	
	' #End If
	
	' Properties
	Private mTileType As String
	Private mHeader As String
	Private mFooter As String
	Private mValue As String
	Private mMinValue As Float
	Private mMaxValue As Float
	Private mGreenMaxPct As Int
	Private mYellowMaxPct As Int
	Private mBackgroundColor As Int
	Private mState As Boolean
	
	' Locals
	Private IMAGE_MARKUP_PLACEHOLDER As String = "#IMAGE_PLACEHOLDER#"
	' SVG Image HMTL 
	Private IMAGE_MARKUP_FILE As String = "image.html"
	Private ImageMarkup As String

	Private mValueFontSize As Int
	Private mValueFill As String
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
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
	mHeader 			= Props.GetDefault("header", "Header")
	mFooter 			= Props.GetDefault("footer", "Footer")
	mValue 				= Props.GetDefault("value", 0)
	mMinValue 			= Props.GetDefault("minvalue", 0)
	mMaxValue 			= Props.GetDefault("maxvalue", 100)
	mGreenMaxPct		= Props.GetDefault("greenmaxpct", 70)
	mYellowMaxPct		= Props.GetDefault("yellowmaxpct", 100)
	mState 				= Props.GetDefault("state", False)
	mBackgroundColor	= xui.PaintOrColorToColor(Props.Get("backgroundcolor"))

	' Load the HTML
	ImageMarkup = File.ReadString(File.DirAssets, IMAGE_MARKUP_FILE)

	' Style and resize
	ApplyStyle
	Base_Resize(BasePane.Width, BasePane.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	If Not(WebViewSVG.IsInitialized) Then Return
	DrawImage
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
			xmlmarkup = HMITilesIOSevenSegment.LoadTemplate(xmlmarkup)
	End Select
	
	' Load the HTML markup with the XML markup
	WebViewSVG.LoadHtml(ImageMarkup.Replace(IMAGE_MARKUP_PLACEHOLDER, xmlmarkup))
End Sub

' =========================
' Public API
' =========================

Public Sub setTileType(value As String)
	mTileType = value.ToLowerCase
	DrawImage
End Sub
Public Sub getTileType As String
	Return mTileType
End Sub

' Get or set tile state.
' Supported are tile Switch, LEDPanel.
' State: False = Off/Closed, True = On/Open
Public Sub setState(state As Boolean)
	Dim js As String

	mState = state
	mValue = IIf(state, 1, 0)

	' Delegate internally based on the instance configuration
	Select mTileType
		Case TILE_SWITCH
			' js = HMITilesIOSwitch.SetState(state)
			js = HMITilesIOSwitch.SetTile(mHeader, mFooter, mState)
		Case TILE_LEDPANEL
			' js = HMITilesIOLEDPanel.SetState(state)
			js = HMITilesIOLEDPanel.SetTile(mHeader, mFooter, mState)
		Case Else
			Return
	End Select

	' Change the state using JavaScript
	Wait for (ExecuteJS(js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setState][E] Can not set the state for tile ${mTileType}"$)
	End If
End Sub
Public Sub getState As Boolean
	Return mState
End Sub

' Set or get the tile value.
' Supported are tile Gauge, SevenSegment, Slider, VerticalMeter.
' Parameter:
'	value - Value between min and max properties. The value is casted according tile type.
Public Sub setValue(value As String)
	Dim js As String
	
	Select mTileType
		Case TILE_BYTESTATUS
			mValue = value.As(Byte)
			js = HMITilesIOByteStatus.SetTile(mHeader, mFooter, HMITilesIOByteStatus.PinsAttached, mValue)
		Case TILE_GAUGE
			mValue = Max(mMinValue, Min(mMaxValue, value.As(Float)))
			js = HMITilesIOGauge.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mGreenMaxPct, mYellowMaxPct, mValue)
		Case TILE_SPINNER
			mValue = Max(mMinValue, Min(mMaxValue, value.As(Float)))
			js = HMITilesIOSpinner.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue)
		Case TILE_READOUT
			mValue = value
			js = HMITilesIOReadOut.SetTile(mHeader, mFooter, mValue)
		Case TILE_SEVENSEGMENT
			mValue = Max(mMinValue, Min(mMaxValue, value.As(Float)))
			js = HMITilesIOSevenSegment.SetTile(mHeader, mFooter, HMITilesIOSevenSegment.TEXT_COLOR, mValue)
		Case TILE_SLIDER
			mValue = Max(mMinValue, Min(mMaxValue, value.As(Float)))
			js = HMITilesIOSlider.SetTile(mHeader, mFooter, mMinValue, mMaxValue, mValue)
		Case TILE_VERTICALMETER
			mValue = Max(mMinValue, Min(mMaxValue, value.As(Float)))
			js = HMITilesIOVerticalMeter.SetTile(mHeader, mFooter, HMITilesIOVerticalMeter.COLOR_TRACK, mMinValue, mMaxValue, mValue)
		Case Else
			Return
	End Select
	' 
	Wait for (ExecuteJS(js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setValue][E] Can not set the value for tile ${mTileType}"$)
	End If
End Sub
Public Sub getValue As String
	Return mValue
End Sub

Public Sub setHeader(value As String)
	mHeader = value.Replace("'", "\'")
	Dim js As String = $"
        var header = document.getElementById("tile-header");
        if(header) { header.textContent = "${mHeader}"; };
    "$
	Wait for (ExecuteJS(js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setHeader][E] Can not set the tile header ${mTileType}"$)
	End If
End Sub
Public Sub getHeader As String
	Return mHeader
End Sub

Public Sub setFooter(value As String)
	mFooter = value.Replace("'", "\'")
	Dim js As String = $"
        var footer = document.getElementById("tile-footer");
        if(footer) { footer.textContent = "${mFooter}"; };
    "$
	Wait for (ExecuteJS(js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setFooter][E] Can not set the tile footer ${mTileType}"$)
	End If
End Sub
Public Sub getFooter As String
	Return mFooter
End Sub

Public Sub setValueFontSize(value As Int)
	mValueFontSize = value
	Dim js As String = $"
        var valuedisplay = document.getElementById("value-display");
        if (valuedisplay) { valuedisplay.style.fontSize = "${value}px"; }
    "$
	Wait for (ExecuteJS(js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setValueFontSize][E] Can not set the value font size ${mValueFontSize}"$)
	End If
End Sub
Public Sub getValueFontSize As Int
	Return mValueFontSize
End Sub

Public Sub setValueFill(value As String)
	mValueFill = value
	Dim js As String = $"
        var valuedisplay = document.getElementById("value-display");
        if (valuedisplay) { valuedisplay.style.fill = "${value}"; }
    "$
	Wait for (ExecuteJS(js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[setValueFill][E] Can not set the value font color ${mValueFill}"$)
	End If
End Sub
Public Sub getValueFill As String
	Return mValueFill
End Sub

' Dynamically Sets the background color of both the WebView Tile and the HTML content
Public Sub setBackgroundColor(ColorAsInt As Int)
	mBackgroundColor = ColorAsInt

	' Convert the B4X Int color to a standard web CSS hex string (#RRGGBB)
	Dim hexColor As String = $"#${Bit.ToHexString(ColorAsInt).SubString(2)}"$
        
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
        styleEl.innerHTML = "html, body { background-color: ${hexColor} !important; } svg > rect:first-of-type { fill: ${hexColor} !important; }";
    "$
	wait for (ExecuteJS(js)) complete (result As Boolean)
	If Not(result) Then
		Log("[setBackgroundColor][E] DOM not ready yet, but styling rule queued.")
	End If
End Sub
Public Sub getBackgroundColor As Int
	Return mBackgroundColor
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
			ExecuteJS(HMITilesIOSlider.Init(False))			
			#End If
			#if B4A
			ExecuteJS(HMITilesIOSlider.Init(0))
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

' NOIT USED as replaced by panelwebview_touch event
' MouseClicked
' Every Tile a mouse clicked event with parameters state and value.
'#if B4J
'Private Sub WebViewSVG_MouseClicked (EventData As MouseEvent)
'	If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
'		CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue.As(String))
'	End If
'End Sub
'#End If

' =========================
' PANELWEBVIEW EVENTS
' =========================

' PanelWebViewSVG_Touch
' Handle touching the panel.
' Down (0) and Move (2) actions to handle tracking and dragging, Up(1) not used
Private Sub PanelWebViewSVG_Touch (Action As Int, X As Float, Y As Float)
	Dim ACTION_DOWN As Int = 0
	Dim ACTION_UP As Int = 1
	Dim ACTION_MOVE As Int = 2
	
	' Action Up not handled
	If Action = ACTION_UP Then Return

	Select mTileType

		' Tile click call click event
		Case TILE_BYTESTATUS, TILE_GAUGE, TILE_LEDPANEL, TILE_READOUT, TILE_SWITCH
			If Action = ACTION_DOWN Then
				If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
					CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue)
				End If
			End If
			Return
		
		' Tile spinner value up or down
        Case TILE_SPINNER
            ' Only trigger increments on the initial touch down event
            If Action = ACTION_DOWN Then
                Dim PanelWidth As Float = PanelWebViewSVG.Width
                ' Translate the physical screen pixel touch point into your 120-unit SVG matrix space
                Dim svgTouchX As Float = (X / PanelWidth) * 120
                
                Dim ValueChanged As Boolean = False
                
                ' Check boundary conditions based on exact 120-unit canvas sizing layout
                If svgTouchX <= 40 Then
                    ' MINUS REGION CLICKED
                    mValue = mValue - 1
                    ValueChanged = True
                Else If svgTouchX >= 80 Then
                    ' PLUS REGION CLICKED
                    mValue = mValue + 1
                    ValueChanged = True
                End If
				' Set the new value                
				If ValueChanged Then
					setValue(mValue)
                End If
            End If
            Return

		' Tile slider new value
		Case TILE_SLIDER
			If Action = ACTION_DOWN Or Action = ACTION_MOVE Then
				Dim PanelWidth As Float = PanelWebViewSVG.Width
				Dim svgTouchX As Float = (X / PanelWidth) * 120
		
				If svgTouchX < 20 Then svgTouchX = 20
				If svgTouchX > 100 Then svgTouchX = 100
		
				Dim pct As Float = (svgTouchX - 20) / 80
				Dim finalValue As Int = Round(pct * 100)
		
				' Only execute UI updates and raise events if the value has actually shifted
				If finalValue <> mValue Then
					mValue = finalValue
			
					' Update the vector graphics layers inside the WebView container
					Dim jsUpdate As String = $"
						var handle = document.getElementById("hmi-handle");
						var prog = document.getElementById("hmi-progress");
						var txt = document.getElementById("slider-val");
						
						if (handle) { handle.setAttribute("x", "${svgTouchX - 5}"); }
						if (prog)   { prog.setAttribute("x2", "${svgTouchX}"); }
						if (txt)    { txt.textContent = "${finalValue}"; }
					"$
					ExecuteJS(jsUpdate.Replace(Chr(10), " ").Replace(Chr(13), " "))
		
					If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
						CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue)
					End If
				End If
			End If
	End Select
End Sub

' ================================================================
' JAVASCRIPT
' ================================================================

' ExecuteJS
' Helper to execute a JavaScript string inside the B4AB4J WebView engine using JavaObject
Private Sub ExecuteJS(js As String)As ResumableSub
	' Check js length
	If js.Length == 0 Then
		Return False
	End If

	' Standard flattening to safeguard single-line delivery execution
	js = js.Replace(Chr(10), " ").Replace(Chr(13), " ")
	' Log($"[ExecuteJS] ${js}"$)

	' Short sleep 
	Sleep(1)

	' Initialize a JavaObject pointing directly to the WebView instance wrapper
	Dim joWebView As JavaObject = WebViewSVG

	' Try executing the JavaScript
	Try
		#if B4A
		' Define a null callback object since we are pushing data outwards (Fire-and-forget)
		Dim callback As Object = Null
		' Invoke the native android.webkit.WebView.evaluateJavascript method
		joWebView.RunMethod("evaluateJavascript", Array(js, callback))
		#End If

		#If B4J
		Dim engine As JavaObject = joWebView.RunMethodJO("getEngine", Null)
		engine.RunMethod("executeScript", Array(js))
		#End If

		Return True
	Catch
		Log("[ExecuteJS][E]" & LastException.Message)
		Return False
	End Try
End Sub

' ================================================================
' COLORS
' ================================================================

' Helper to get uniform colors
Private Sub GetStateColor(State As Int) As String	'ignore
	Select State
		Case 1: 	Return "#20bf6b" 	' Muted Green (Running)
		Case 2: 	Return "#eb3b5a" 	' Muted Red (Alarm)
		Case Else: Return "#4b6584"		' Muted Slate (Off)
	End Select
End Sub

' Evaluates incoming ESP32 data and returns an ISA-101 compliant color string
Private Sub GetLimitColor(CurrentValue As Float, WarningLimit As Float, AlarmLimit As Float) As String	'ignore
	If CurrentValue >= AlarmLimit Then
		Return "#dc2626" ' Level 4: Critical Alarm Red
	Else If CurrentValue >= WarningLimit Then
		Return "#d97706" ' Level 3: Warning Amber
	Else
		Return "#0f172a" ' Level 2: Normal Black/Dark Slate (Visually quiet)
	End If
End Sub
