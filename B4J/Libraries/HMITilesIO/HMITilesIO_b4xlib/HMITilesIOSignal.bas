B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOSignal.bas
' Brief:    	Wi-Fi/Radio Signal Strength Bars.
' Date:			2026-10-28
' Description:	Signal Strength: Robust infrastructure diagnostics tile displaying an ascending 4-bar vector staircase. Features built-in string parsing that auto-detects and processes raw whole percentages ("50%"), decimal ratios (".50"), or negative RSSI dBm telemetry ("-65").
' Usage:		
'				TileSignal.Value = "68%"
' ================================================================

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)
	Public TEXT_COLOR As String = "#0f172a"
	Public TEXT_SIZE As Int = 24

	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
	Private mParentTile 				As HMITilesIO
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
' 	Value - String readout the text
Public Sub SetTile(Header As String, Footer As String, Value As String)
	mValue = value
    
	' Clean incoming raw string from any hidden returns
	Dim CleanValue As String = Value.Replace(CRLF, "").Replace(Chr(10), "").Replace(Chr(13), "").Trim
	If CleanValue.Length = 0 Then CleanValue = "0"
    
	' Save the original clean value text to display exactly what the micro sent
	Dim DisplayText As String = CleanValue
    
	' Normalize the string to extract raw numeric values for the bar math
	Dim NumericString As String = CleanValue.toLowerCase.Replace("%", "").Replace("dbm", "").Replace("db", "").Trim
    
	Dim RawSignal As Double = 0
	Try
		RawSignal = NumericString
	Catch
		Log("[HMITilesIO.Signal] Error parsing value: " & CleanValue)
	End Try
    
	Dim SignalPct As Double = RawSignal
    
	' Smart Format Auto-Detection Loops
	If RawSignal < 0 Then
		' Format A: Standard negative dBm RSSI (e.g. -65)
		If RawSignal > -30 Then RawSignal = -30
		If RawSignal < -90 Then RawSignal = -90
		SignalPct = ((RawSignal + 90) / 60) * 100
	Else If RawSignal > 0 And RawSignal <= 1.0 And CleanValue.Contains("%") = False Then
		' Format B: Decimal Fraction ratio (e.g. 0.20)
		SignalPct = RawSignal * 100
		DisplayText = NumberFormat2(SignalPct, 1, 0, 0, False) & "%"
	Else
		' Format C: Standard whole number percentage (e.g. 20%)
		If IsNumber(CleanValue) Then
			DisplayText = CleanValue & "%"
		End If
	End If
    
	' Enforce standard mathematical constraints (0 to 100)
	If SignalPct < 0 Then SignalPct = 0
	If SignalPct > 100 Then SignalPct = 100

	' Calculate percentage as an explicit Int for crisp threshold gating
	Dim PctInt As Int = NumberFormat2(SignalPct, 1, 0, 0, False).As(Int)

	' 1. Determine signal bar color based on percentage thresholds inside B4X
	Dim hexColor As String = "#22c55e" ' Default Green
	If PctInt <= 25 Then
		hexColor = "#ef4444" ' Red
	Else If PctInt <= 60 Then
		hexColor = "#f59e0b" ' Amber
	End If

	' 2. Group core structural text updates together
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"tile-value":  DisplayText _
	)
	
	' 3. Map individual attribute fills based on thresholds using B4X inline If
	Dim attrUpdates As Map = CreateMap( _
		"sig-bar1": CreateMap("fill": IIf(PctInt > 5,   hexColor, "#cbd5e1")), _
		"sig-bar2": CreateMap("fill": IIf(PctInt >= 30, hexColor, "#cbd5e1")), _
		"sig-bar3": CreateMap("fill": IIf(PctInt >= 60, hexColor, "#cbd5e1")), _
		"sig-bar4": CreateMap("fill": IIf(PctInt >= 85, hexColor, "#cbd5e1")) _
	)
	
	' 4. Bundle everything up and push to your central utility engine
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
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
