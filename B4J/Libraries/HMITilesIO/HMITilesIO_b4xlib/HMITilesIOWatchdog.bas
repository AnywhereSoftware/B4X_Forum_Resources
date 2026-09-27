B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ==============================================================================
' File:         HMITilesIOWatchdog.bas
' Brief:        An industrial instrumentation bezel telemetry health and latency monitor.
' Date:         2026-09-22
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
#End Region

Private Sub Class_Globals
	Private xui As XUI
	
'	' Instance-specific configuration variables (completely isolated for each tile)
'	Public TEXT_COLOR As String = "#0f172a"
'	Public TEXT_SIZE As Int = 24

	' Mandatory glass globals 
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object

	' Public class globals
	Public STATUS_OK As Int = 0
	Public STATUS_WARNING As Int = 1
	Public STATUS_ERROR As Int = 2

	' Local class globals
	Private mLatency As Int = 12 ' Default latency
	Private mUnit As String = "ms"
End Sub

' Initializes the instance
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
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

	Dim StatusCode As Int = 0
	If IsNumber(Value) Then StatusCode = Value

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

	' Clean text variables
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
    
	Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var val = document.getElementById("value-display");
        var dot = document.getElementById("status-dot");
        var pnl = document.getElementById("status-panel-bg");
        
        if(head) { head.textContent = "${Header}"; };
        if(foot) { foot.textContent = "${Footer}"; };
        if(val)  { 
            val.textContent = "${valueText}"; 
            val.setAttribute("fill", "${textColor}");
        };
        if(dot)  { dot.setAttribute("fill", "${dotColor}"); };
        if(pnl)  { 
            pnl.setAttribute("fill", "${panelColor}"); 
            pnl.setAttribute("stroke", "${textColor}");
        };
    "$
	UpdateTile(js)
End Sub

' UpdateTile
' Change the state using JavaScript.
' Parameters:
'	js - JavaScript to update the tile elements.
Private Sub UpdateTile(js As String)
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[Watchdog.UpdateTile][E] Can not update the tile."$)
	End If
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
