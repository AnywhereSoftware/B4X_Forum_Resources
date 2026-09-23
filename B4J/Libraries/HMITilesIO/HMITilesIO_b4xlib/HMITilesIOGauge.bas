B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOGauge.bas
' Brief:    	Gauge with 3 segments.
' Date:			2026-09-06
' Description:	180° Gauge with beautiful, perfectly mapped left-to-right neon tracking arc.
' Usage:		
'				' Gauge with segments green > yellow > red
'				' Properties designer: Green Max Pxt 70, Yellow Max Pct 90
'				Private TileGauge As HMITilesIO
'				' Gauge with segments reversed red > yellow > green
'				' Properties designer: Green Max Pxt 10, Yellow Max Pct 20
'				Private TileGaugeReverse As HMITilesIO
'
'				TileGauge.Value = TileSlider.Value
'				TileGauge.SetFooter($"${NumberFormat(TileGauge.Value, 0, 0)}"$)
'
'				TileGaugeReverse.Value = TileSlider.Value
'				TileGaugeReverse.SetFooter($"${NumberFormat(TileGauge.Value, 0, 0)}"$)
'				TileGaugeReverse.SetSegmentColor(TileGaugeReverse.SEGMENT_RED, TileGaugeReverse.SEGMENT_GREEN_COLOR)
'				TileGaugeReverse.SetSegmentColor(TileGaugeReverse.SEGMENT_YELLOW, TileGaugeReverse.SEGMENT_YELLOW_COLOR)
'				TileGaugeReverse.SetSegmentColor(TileGaugeReverse.SEGMENT_GREEN, TileGaugeReverse.SEGMENT_RED_COLOR)
'
'				TileGauge.Value = value.As(Float)
'				TileGauge.SetFooter($"${NumberFormat(TileGauge.Value, 0, 0)}"$)
'				TileGaugeReverse.Value = value.As(Float)
'				TileGaugeReverse.SetFooter($"${NumberFormat(TileGaugeReverse.Value, 0, 0)}"$)
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI

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
' Parameters:
' 	Header: Tile label text
' 	FooterText: Dynamic unit value display string (e.g. "45.2 PSI")
' 	MinValue: Bottom scale value (maps to -180 degrees)
' 	MaxValue: Top scale value (maps to 0 degrees)
' 	GreenMaxPct: At what percentage of the total range does Green end? (e.g., 50)
' 	YellowMaxPct: At what percentage of the total range does Yellow end? (e.g., 85)
' 	Value: The actual reading
' Returns:
'	String - JavaScript
Public Sub SetTile(Header As String, _
				   Footer As String, _
                   MinValue As Float, _
				   MaxValue As Float, _
                   GreenMaxPct As Float, _
				   YellowMaxPct As Float, _
				   Value As Float)
    
	' Guard input values inside safety boundaries
	Value = Max(MinValue, Min(MaxValue, Value))
	mValue = Value
	
	' 2. Calculate percentage position across your custom scale range
	Dim totalRange As Float = MaxValue - MinValue
	Dim pct As Float = 0
	If totalRange > 0 Then pct = (Value - MinValue) / totalRange
    
	' 3. Symmetrical 180-degree sweep calculation math
	' Pct = 0.0 (0%)   -> Angle maps to -180 degrees (Pointing exactly West / Left)
	' Pct = 0.5 (50%)  -> Angle maps to -90 degrees  (Pointing exactly North / Straight Up)
	' Pct = 1.0 (100%) -> Angle maps to 0 degrees    (Pointing exactly East / Right)
	Dim targetDegrees As Float = -90.0 + (pct * 180.0)
    
	' 4. Clean text variables
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
    
	' 5. Calculate mask offsets to reveal zones from left to right (Total Arc = 113.1px)
	Dim greenOffset As Float = 113.1 - (113.1 * (GreenMaxPct / 100.0))
	Dim yellowOffset As Float = 113.1 - (113.1 * (YellowMaxPct / 100.0))
    
	Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var needle = document.getElementById("gauge-needle");
        var arcG = document.getElementById("arc-green");
        var arcY = document.getElementById("arc-yellow");
        
        if(head) { head.textContent = "${Header}"; };
        if(foot) { foot.textContent = "${Footer}"; };
        
        if(arcG) { arcG.setAttribute("stroke-dashoffset", "${greenOffset}"); };
        if(arcY) { arcY.setAttribute("stroke-dashoffset", "${yellowOffset}"); };
        
        if(needle) {
            needle.style.transform = "";
            needle.style.transformOrigin = "";
            needle.style.transition = "";
            var deg = ${targetDegrees};
            needle.setAttribute("transform", "rotate(" + deg + ", 60, 80)");
        };
    "$
	UpdateTile(js)
End Sub

' UpdateTile
' Change the state using JavaScript.
' Parameters:
'	js - JavaScript to update the tile elements.
Private Sub UpdateTile(js As String)
	Sleep(50)
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[Gauge.UpdateTile][E] Can not update the tile."$)
	End If
End Sub

' SetSegmentColor
' Parameter:
'	segment - Arc red, yellow or green (lowercase)
'	value - Web HMTL color with # prefix
Public Sub SetSegmentColor(segment As String, value As String)
	segment = $"arc-${segment.ToLowerCase}"$
	If Not(value.StartsWith("#")) Then value = $"#${value}"$
	Dim js As String = $"
        var segment = document.getElementById("${segment}");
        if(segment) { segment.setAttribute("stroke", "${value}"); };
    "$
	UpdateSegment(js)
End Sub

' UpdateSegment
' Change the segment using JavaScript.
' Parameters:
'	js - JavaScript to update the tile elements.
Private Sub UpdateSegment(js As String)
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[Gauge.UpdateSegment][E] Can not update the tile."$)
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
