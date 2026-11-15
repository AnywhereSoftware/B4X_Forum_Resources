B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOVerticalMeter.bas
' Brief:    	Vertical meter with actual value arrow.
' Date:			2026-10-28
' Description:	Simplified scale column with a perfectly aligned left-pointing reference tracking arrow.
' Usage:		
'				TileVerticalMeter.Value = 68
' ================================================================

Private Sub Class_Globals
	Private xui As XUI

'	Public TEXT_COLOR As String = "#0f172a"
'	Public TEXT_SIZE As Int = 24
	Public COLOR_TRACK As String = "#808080"

	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
	Private mParentTile 				As HMITilesIO

	Private mMinValue					As Float		'ignore
	Private mMaxValue					As Float		'ignore
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
    
	' 1. Group core structural text readouts
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"meter-value": Value.As(Int) _
	)
    
	' 2. Pre-format the SVG arrow translate vector string safely
	Dim arrowTransform As String = "translate(0, " & NumberFormat2(-barHeight, 1, 2, 2, False) & ")"
    
	' 3. Map all geometric presentation attributes cleanly
	Dim attrUpdates As Map = CreateMap( _
		"meter-level": CreateMap( _
			"y":      NumberFormat2(barY, 1, 2, 2, False), _
			"height": NumberFormat2(barHeight, 1, 2, 2, False), _
			"fill":   TrackColor _
		), _
		"meter-arrow": CreateMap( _
			"fill":      TrackColor, _
			"transform": arrowTransform _
		) _
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
