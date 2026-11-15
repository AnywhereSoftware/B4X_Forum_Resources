B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ==============================================================================
' File:         HMITilesIOWatchdog.bas
' Brief:        An industrial instrumentation bezel telemetry health and latency monitor.
' Date:         2026-10-28
' Description:  Displays real-time node latency diagnostics and communication safety
'               timeouts using an enclosed digital hardware panel design.
'
'               Standardized Selection Logic:
'               * Value = 0 (STATUS_OK)      -> Green LED, Cyan Readout, Dark Slate Window.
'               * Value = 1 (STATUS_WARNING) -> Amber LED, Amber Readout, Dark Amber Window.
'               * Value = 2 (STATUS_ERROR)   -> Red LED, Light Red "FAIL" Text, Dark Red Window.
'
'               Dedicated Properties:
'               * State (Boolean): Set to True for STATUS_OK, and False for WARNING/ERROR.
'               * Latency (Int): Tracked via setLatency() / getLatency(), defaults to 12ms.
'
' Usage:        TileWatchdog.Value = TileWatchdog.InstanceWatchdog.STATUS_WARNING
'               TileWatchdog.Value = 1 ' Warning
' ==============================================================================

Private Sub Class_Globals
	Private xui As XUI

	' Mandatory glass globals 
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
	Private mParentTile 				As HMITilesIO

	' Public class globals
	Public STATUS_OK As Int = 0
	Public STATUS_WARNING As Int = 1
	Public STATUS_ERROR As Int = 2

	' Local class globals
	Private mLatency As Int = 12 ' Default latency
	Private mUnit As String = "ms"
End Sub

' Initializes the instance
Public Sub Initialize(parent As HMITilesIO, pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
	mParentTile = parent
End Sub

' GetParent
' Get the parent tile HMITilesIO to access public methods & fields.
Public Sub GetParent As HMITilesIO
	Return mParentTile
End Sub

' SetTile
' Set all tile properties.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
' 	Value - StatusCode Mapping Guide:
	' 0 = Healthy (Green dot, clean blue text)
	' 1 = Latency Warning (Yellow dot, yellow text)
	' 2 = Offline / Critical (Red dot, red text)
' The state is set according the statuscode: True for statuscode 0, False for statuscode > 0
Public Sub SetTile(Header As String, Footer As String, Value As String)
	' Industrial Default Theme Elements
	Dim dotColor As String   = "#22c55e"  ' Green Indicator LED
	Dim panelColor As String = "#1e293b"  ' Slate Dark Sub-Frame
	Dim textColor As String  = "#38bdf8"  ' High-Contrast Cyan Vector Text
	Dim valueText As String  = mLatency & "ms"

	mState = True
	mValue = Value

	Dim StatusCode As Int = 0
	If IsNumber(Value) Then StatusCode = Value.As(Int)

	Select StatusCode
		Case STATUS_OK
			dotColor   = "#22c55e"
			panelColor = "#1e293b"
			textColor  = "#38bdf8"
			valueText  = mLatency & mUnit
			mState     = True
            
		Case STATUS_WARNING
			dotColor   = "#eab308"   ' Warning Amber
			panelColor = "#2d2a10"   ' Dim Warning Alert Enclosure Backing
			textColor  = "#eab308"
			valueText  = mLatency & mUnit
			mState     = False
            
		Case STATUS_ERROR, 3
			dotColor   = "#ef4444"   ' Direct Danger Indicator Red
			panelColor = "#451a1a"   ' Industrial Red Enclosure Alert Frame Fills
			textColor  = "#fca5a5"   ' Soft Light-Red for Maximum Readability
			valueText  = "FAIL"
			mState     = False
	End Select

	' 1. Group standard text updates directly
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"tile-value":  valueText _
	)
	
	' 2. Map all theme element presentation attributes cleanly
	Dim attrUpdates As Map = CreateMap( _
		"tile-value":      CreateMap("fill": textColor), _
		"status-dot":      CreateMap("fill": dotColor), _
		"status-panel-bg": CreateMap("fill": panelColor, "stroke": textColor) _
	)
	
	' 3. Bundle everything up and push to your central utility engine
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
End Sub

' Set or get Latency.
' Value - Latrency (ms)
Public Sub setLatency(Value As Int)
	mLatency = Value
End Sub
Public Sub getLatency As Int
	Return mLatency
End Sub

' ProcessTouchHandler
' Process the tile touch event.
' Parameter:
'	Data - Type with all touch properties
Public Sub ProcessTouchHandler(Data As HMITouchData) As HMITouchResult
	' Update internal class state
	mState = Data.State
	mValue = Data.Value

	' Only trigger interactions on the initial touch down event
	If Data.Action = HMITilesIOUtils.ACTION_DOWN Then
		' Trigger the event if it exists in the parent module
		If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
			CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue)
		End If
	End If
    
	' Simplify result creation using standard B4X Type initialization shorthand
	Dim result As HMITouchResult
	result.Initialize
	result.State = mState
	result.Value = mValue
	Return result
End Sub
