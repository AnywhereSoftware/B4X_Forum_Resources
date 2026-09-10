B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOSignal.bas
' Brief:    	Wi-Fi/Radio Signal Strength Bars.
' Date:			2026-09-06
' Description:	Signal Strength: Robust infrastructure diagnostics tile displaying an ascending 4-bar vector staircase. Features built-in string parsing that auto-detects and processes raw whole percentages ("50%"), decimal ratios (".50"), or negative RSSI dBm telemetry ("-65").
' Usage:		
'				TileSignal.Value = "68%"
' ================================================================
#End Region

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
' 	Value - String readout the text
Public Sub SetTile(Header As String, _
                   Footer As String, _
                   Value As String)
    
	' Clean incoming raw string from any hidden returns
	Dim CleanValue As String = Value.Replace(CRLF, "").Replace(Chr(10), "").Replace(Chr(13), "").Trim
    
	' Save the original clean value text to display exactly what the micro sent (e.g. "20%", "-65 dBm")
	Dim DisplayText As String = CleanValue
    
	' Normalize the string to extract raw numeric values for the bar math
	' Strip common units so we can parse the number safely
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
		' -30 dBm or better is 100% signal, -90 dBm or worse is 0% signal
		If RawSignal > -30 Then RawSignal = -30
		If RawSignal < -90 Then RawSignal = -90
		SignalPct = ((RawSignal + 90) / 60) * 100
	Else If RawSignal > 0 And RawSignal <= 1.0 And CleanValue.Contains("%") = False Then
		' Format B: Decimal Fraction ratio (e.g. .20 or 0.20)
		SignalPct = RawSignal * 100
		' Update display text to show a clean percentage representation instead of the raw fraction
		DisplayText = NumberFormat2(SignalPct, 1, 0, 0, False) & "%"
	Else
		' Format C: Standard whole number percentage (e.g. 20 or 20%)
		' Automatically append the % symbol to the text readout if it's a raw integer
		If IsNumber(CleanValue) Then
			DisplayText = CleanValue & "%"
		End If
	End If
    
	' Enforce standard mathematical constraints (0 to 100)
	If SignalPct < 0 Then SignalPct = 0
	If SignalPct > 100 Then SignalPct = 100

	Dim EscapedHeader As String = Header.Replace("'", "\'").Replace("""", "\""")
	Dim EscapedFooter As String = Footer.Replace("'", "\'").Replace("""", "\""")
	Dim JS_Pct As String = NumberFormat2(SignalPct, 1, 0, 0, False)

	' Formulate the execution string using backticks ` for maximum stability
	Dim js As String = $"
        var head = document.getElementById('tile-header');
        var foot = document.getElementById('tile-footer');
        var valTxt = document.getElementById('current-value');
        
        var bar1 = document.getElementById('sig-bar1');
        var bar2 = document.getElementById('sig-bar2');
        var bar3 = document.getElementById('sig-bar3');
        var bar4 = document.getElementById('sig-bar4');

        if (head) { head.textContent = `${EscapedHeader}`; };
        if (foot) { foot.textContent = `${EscapedFooter}`; };
        if (valTxt) { valTxt.textContent = `${DisplayText}`; };

        var pct = parseInt(`${JS_Pct}`);
        var color = '#22c55e'; 
        if (pct <= 25) { color = '#ef4444'; }       
        else if (pct <= 60) { color = '#f59e0b'; }  

        if (bar1) { bar1.setAttribute('fill', pct > 5   ? color : '#cbd5e1'); }
        if (bar2) { bar2.setAttribute('fill', pct >= 30 ? color : '#cbd5e1'); }
        if (bar3) { bar3.setAttribute('fill', pct >= 60 ? color : '#cbd5e1'); }
        if (bar4) { bar4.setAttribute('fill', pct >= 85 ? color : '#cbd5e1'); }
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
		Log($"[Signal.UpdateTile][E] Can not update the tile."$)
	End If
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
