B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ==============================================================================
' File:         HMITilesIOTiltGauge.bas
' Brief:        A specialized quadrant-type gauge designed for 90° process status tracking.
' Date:         2026-09-20
' Description:  Designed for angular positions, tilt monitoring, incline tracking, 
'               or physical gate/valve status visualization sweeping a 90° arc.
'
'               Industry Alignment Layout:
'               * Value 0 = 90° (Vertical Default Standard):
'                 Represents 0% Open / Fully Closed (zero flow or active safety barrier). 
'                 Physically, a gate rests vertically to block a pipe, channel, or path.
'               * Max Value = 0° (Horizontal):
'                 Represents 100% Open (maximum flow or clear path). The gate swings into 
'                 a horizontal position to let mediums pass.
'
'               The Butterfly Valve & Quarter-Turn Exception:
'               * While vertical-to-closed is standard for structural gates, certain 
'                 quarter-turn elements utilize 0° (Horizontal) = Closed and 90° = Open. 
'                 The integrated 'Inverted' parameter natively handles both tracking configurations.
'
' Usage:        Initialize your target container then modify values or styles dynamically:
'               TileTiltGauge.Value = 25
'               TileTiltGauge.InstanceTiltGauge.SetPositionSegmentColor("#FF0000")
' ==============================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI

	' Mandatory class globals but private
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
	
	' Additional properties
	Private mInverted 					As Boolean = False
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
                   Value As Float, _
                   Inverted As Boolean)
    
	mInverted = Inverted
	
	' Guard input values inside safety boundaries
	Value = Max(MinValue, Min(MaxValue, Value))
	mValue = Value
	
	' Calculate percentage position across your custom scale range
	Dim totalRange As Float = MaxValue - MinValue
	Dim pct As Float = 0
	If totalRange > 0 Then pct = (Value - MinValue) / totalRange
    
	' If inverted, flip the percentage calculation
	If Inverted Then
		pct = 1.0 - pct
	End If
	
	' Quadrant sweep calculation math (Pivot at 42, 78)
	' pct = 0.0 -> Needle stays at 0 degrees (Vertical pointing straight up)
	' pct = 1.0 -> Needle rotates 90 degrees clockwise (Horizontal pointing right)
	Dim targetDegrees As Float = pct * 90.0
    
	' Clean text variables
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
    
	' Calculate position track offset (Total Arc Length = 56.55px)
	Dim positionOffset As Float = 56.55 - (56.55 * pct)
    
	' EXECUTION GUARD: Prevents random rendering race conditions during initialization
	Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var arcPos = document.getElementById("arc-position");
        
        if(head) { head.textContent = "${Header}"; };
        if(foot) { foot.textContent = "${Footer}"; };
        if(arcPos) { arcPos.setAttribute("stroke-dashoffset", "${positionOffset}"); };
        
        function applyTransform() {
            var needle = document.getElementById("gauge-needle");
            if (needle) {
                needle.style.transform = "";
                needle.style.transformOrigin = "";
                needle.style.transition = "";
                var deg = ${targetDegrees};
                needle.setAttribute("transform", "rotate(" + deg + ", 42, 78)");
            } else {
                setTimeout(applyTransform, 20);
            }
        }
        applyTransform();
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
		Log($"[TiltGauge.UpdateTile][E] Can not update the tile."$)
	End If
End Sub

' SetPositionSegmentColor
' Parameter:
'	segment - Arc red, yellow or green (lowercase)
'	value - Web HMTL color with # prefix
Public Sub SetPositionSegmentColor(value As String)
	Dim segment As String = $"arc-position"$
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
		Log($"[TiltGauge.UpdateSegment][E] Can not update the tile."$)
	End If
End Sub

Public Sub setInverted(value As Boolean)
	mInverted = value
End Sub
Public Sub getInverted As Boolean
	Return mInverted
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
