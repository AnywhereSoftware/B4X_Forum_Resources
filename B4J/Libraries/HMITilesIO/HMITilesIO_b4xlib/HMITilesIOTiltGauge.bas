B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ==============================================================================
' File:         HMITilesIOTiltGauge.bas
' Brief:        A specialized quadrant-type gauge designed for 90° process status tracking.
' Date:         2026-10-28
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

Private Sub Class_Globals
	Private xui As XUI

	' Mandatory class globals but private
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
	Private mParentTile 				As HMITilesIO
	
	' Additional properties
	Private mInverted 					As Boolean = False
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
	Dim targetDegrees As Float = pct * 90.0
    
	' Calculate position track offset (Total Arc Length = 56.55px)
	Dim positionOffset As Float = 56.55 - (56.55 * pct)
    
	' 1. Group core structural text updates together
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer _
	)
	
	' 2. Construct the exact needle SVG transform rotation string
	Dim rotationString As String = "rotate(" & NumberFormat2(targetDegrees, 1, 2, 2, False) & ", 42, 78)"
	
	' 3. Map SVG presentation attributes cleanly
	Dim attrUpdates As Map = CreateMap( _
		"arc-position": CreateMap("stroke-dashoffset": NumberFormat2(positionOffset, 1, 2, 2, False)), _
		"gauge-needle": CreateMap("transform": rotationString) _
	)
	
	' 4. Bundle everything up and push to your central utility engine
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
End Sub

' SetPositionSegmentColor
' Parameter:
'	value - Web HTML color with or without # prefix
Public Sub SetPositionSegmentColor(value As String)
	If Not(value.StartsWith("#")) Then value = "#" & value
	
	' 1. Formulate direct attribute update data packet
	Dim attrUpdates As Map = CreateMap( _
		"arc-position": CreateMap("stroke": value) _
	)
	Dim updatePayload As Map = CreateMap("attrs": attrUpdates)
	
	' 2. Pass straight to the engine
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
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
