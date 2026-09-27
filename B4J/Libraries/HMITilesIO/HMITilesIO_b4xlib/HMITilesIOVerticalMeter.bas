B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOVerticalMeter.bas
' Brief:    	Vertical meter with actual value arrow.
' Date:			2026-09-06
' Description:	Simplified scale column with a perfectly aligned left-pointing reference tracking arrow.
' Usage:		
'				TileVerticalMeter.Value = 68
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI

	Public TEXT_COLOR As String = "#0f172a"
	Public TEXT_SIZE As Int = 24
	Public COLOR_TRACK As String = "#808080"

	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object

	Private mMinValue					As Float		'ignore
	Private mMaxValue					As Float		'ignore
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
'	TrackColor - String HTML HEX Color of the tracking showing the current value
' 	MinValue / MaxValue - Float for calibration floor and ceiling limits
' 	Value - Float current value
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   TrackColor As String, _ 
				   MinValue As Float, _
				   MaxValue As Float, _
				   Value As Float)
    
	' Guard input values inside safety boundaries
	Value = Max(MinValue, Min(MaxValue, Value))

	mMinValue = MinValue
	mMaxValue = MaxValue
	mValue = Value
    
	' Calculate percentage position across custom scale range
	Dim totalRange As Float = MaxValue - MinValue
	Dim pct As Float = 0
	If totalRange > 0 Then pct = (Value - MinValue) / totalRange
    
	' Calculate explicit height and tracking coordinates (Total track slot span = 64px)
	Dim barHeight As Float = pct * 64.0
	Dim barY As Float = 94.0 - barHeight
    
	' Calculate vertical slide translate vector shift for the pointer arrow
	Dim arrowShiftY As Float = -barHeight
    
	' Clean text variables
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
	TrackColor = TrackColor.Replace("'", "\'")
    
	' Isolated script execution prevents global DOM crashes
	Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var vtxt = document.getElementById("meter-val");
        var level = document.getElementById("meter-level");
        var arrow = document.getElementById("meter-arrow");
        
        if(head) { head.textContent = "${Header}"; };
        if(foot) { foot.textContent = "${Footer}"; };
        if(vtxt) { vtxt.textContent = "${Value.As(Int)}"; };
        
        if(level) { 
            level.setAttribute("y", "${barY}");
            level.setAttribute("height", "${barHeight}");
            level.setAttribute("fill", "${TrackColor}");
        };
        
        if(arrow) {
            arrow.setAttribute("fill", "${TrackColor}");
            arrow.setAttribute("transform", "translate(0, " + ${arrowShiftY} + ")");
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
		Log($"[VerticalMeter.UpdateTile][E] Can not update the tile."$)
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
