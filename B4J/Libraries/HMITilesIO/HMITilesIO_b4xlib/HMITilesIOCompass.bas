B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ==============================================================================
' File:         HMITilesIOCompass.bas
' Brief:        A specialized directional vector status compass tile.
' Date:         2026-10-28
' Description:  Tracks rotational orientation paths, material flows, or wind vectors
'               natively using a 0 to 360 degree input variable.
'
' Usage:        TileCompass.Value = 180 ' Points directly South
'				TileCompass.Value = 165
'				TileCompass.Footer = TileCompass.InstanceCompass.GetDirectionString(TileCompass.Value)
' ==============================================================================

Private Sub Class_Globals
	Private xui As XUI

	' Mandatory class globals private
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
' 	Value - String converted to value degress 0-360
Public Sub SetTile(Header As String, Footer As String, Value As String)
	' Safe Cast String to Float for structural degree math
	If Not(IsNumber(Value)) Then Return
	
	mValue = Value
	
	Dim degrees As Float = Value.As(Float)
    
	' Enforce standard compass bounding rules (wrap degrees inside 0-360)
	degrees = (degrees Mod 360)
	If degrees < 0 Then degrees = degrees + 360
	
	' Update class locals
	mValue = degrees
    
	' 1. Formulate standard text content mappings
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer _
	)
	
	' 2. Construct the exact SVG transform rotation string expression
	Dim rotationString As String = "rotate(" & NumberFormat2(degrees, 1, 1, 1, False) & ", 60, 60)"
	
	' 3. Map attributes cleanly (universal engine updates the DOM directly)
	Dim attrUpdates As Map = CreateMap( _
		"compass-arrow": CreateMap("transform": rotationString) _
	)
	
	' 4. Bundle everything up and push to your central utility engine
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
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
