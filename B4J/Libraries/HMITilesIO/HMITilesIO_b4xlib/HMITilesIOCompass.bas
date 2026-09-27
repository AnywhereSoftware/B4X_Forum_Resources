B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ==============================================================================
' File:         HMITilesIOCompass.bas
' Brief:        A specialized directional vector status compass tile.
' Date:         2026-09-22
' Description:  Tracks rotational orientation paths, material flows, or wind vectors
'               natively using a 0 to 360 degree input variable.
'
' Usage:        TileCompass.Value = 180 ' Points directly South
'				TileCompass.Value = 165
'				TileCompass.Footer = TileCompass.InstanceCompass.GetDirectionString(TileCompass.Value)
' ==============================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)
'	Public TEXT_COLOR As String = "#0f172a"
'	Public TEXT_SIZE As Int = 24

	' Mandatory class globals private
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
' 	Value - String converted to value degress 0-360
Public Sub SetTile(Header As String, Footer As String, Value As String)
    
	' Safe Cast String to Float/Int for structural degree math
	Dim degrees As Float = 0
	If IsNumber(Value) Then 
		degrees = Value
	Else
		Return
	End If
    
	' Enforce standard compass bounding rules (wrap degrees inside 0-360)
	degrees = (degrees Mod 360)
	If degrees < 0 Then degrees = degrees + 360
	
	' Update class locals
	mValue = degrees
	'Log($"[HMITilesIOCompass.SetTile] value=${mValue}, direction=${mDirection}"$)
    
	' Clean text variables
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
    
	Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var arrow = document.getElementById("compass-arrow");
        
        if(head) { head.textContent = "${Header}"; };
        if(foot) { foot.textContent = "${Footer}"; };
        
        if(arrow) {
            arrow.style.transform = "";
            arrow.style.transformOrigin = "";
            arrow.style.transition = "";
            var deg = ${degrees};
            arrow.setAttribute("transform", "rotate(" + deg + ", 60, 60)");
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
		Log($"[HMITilesIOCompass.UpdateTile][E] Can not update the tile."$)
	End If
End Sub

'Public Sub GetDirectionFrmValue(Value As String) As String
'	Return 
'End Sub

' GetDirection
' Converts numerical degrees (0-360) into a standard 16-point compass heading string
' Handles negative loops and excessive range overflows gracefully
Public Sub GetDirection(Value As String) As String
	' Guard against non-numeric or empty string values
	Dim degrees As Float = 0
	If IsNumber(Value) Then degrees = Value
    
	' Normalize degrees strictly into the 0.0 to 359.99 geometric range
	' Handles large values (e.g. 740 Mod 360 = 20) and wraps around perfectly
	degrees = degrees Mod 360
	If degrees < 0 Then degrees = degrees + 360
	
	' 16-Point Compass Rose Array Map (22.5° per sector block)
	Dim directions() As String = Array As String( _
        "N", "NNE", "NE", "ENE", _
        "E", "ESE", "SE", "SSE", _
        "S", "SSW", "SW", "WSW", _
        "W", "WNW", "NW", "NNW" _
    )
    
	' Shift by 11.25° (half a sector) so 'N' spans from 348.75° to 11.25°
	Dim index As Int = Floor((degrees + 11.25) / 22.5) Mod 16
	
	Return directions(index)
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
