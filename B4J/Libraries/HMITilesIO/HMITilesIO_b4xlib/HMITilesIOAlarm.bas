B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOAlarm.bas
' Brief:        Industrial Master Alarm Panel / Warning Annunciator
' Date:			2026-10-28
' Description:	An annunciation component utilizing subtle outer border-stroke color signaling to isolate critical process alerts while preserving dashboard grid visual aesthetics.
' Usage:		
'				TileAlarm.Value = "Value"
' ==============================================================================

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)
	Public TEXT_COLOR As String = "#0f172a"
	Public TEXT_SIZE As Int = 24

	' mandatory class locals
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
	Private mParentTile 				As HMITilesIO
	
	' --- Standard Severity Value Mappings ---
	Public Const STATE_OK As Int = 0        ' Normal quiet operation
	Public Const STATE_WARNING As Int = 1   ' Amber Warning (Non-fatal deviance)
	Public Const STATE_ERROR As Int = 2   ' Red Danger Alarm (Critical boundary breach)

	Public Const STATE_OK_LABEL As String = "OK"
	Public Const STATE_WARNING_LABEL As String = "WARNING"
	Public Const STATE_ERROR_LABEL  As String = "ERROR"
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
'   Header - String set text at tile top
'   Footer - String set text at tile bottom
'   Value  - String format containing "SEVERITY,TEXT" (e.g. "2,ERROR")
Public Sub SetTile(Header As String, Footer As String, Value As String)
	mValue = Value
	
	Dim statusCode As Int = STATE_OK
	Dim alertLabel As String = STATE_OK_LABEL
	
	If Value.Contains(",") Then
		Dim parts() As String = Regex.Split(",", Value)
		If IsNumber(parts(0)) Then statusCode = parts(0)
		alertLabel = parts(1).ToUpperCase
	Else
		If IsNumber(Value) Then statusCode = Value
		If statusCode = STATE_ERROR Then alertLabel = STATE_ERROR_LABEL
		If statusCode = STATE_WARNING Then alertLabel = STATE_WARNING_LABEL
	End If
    
	' Color Settings
	Dim hexBorderColor As String = "transparent" ' Removed '#' to prevent double hashing if your CSS needs it clean, or keep it if required by SVG
	Dim hexLabelColor As String = "#64748b"
	
	Select statusCode
		Case STATE_WARNING
			hexBorderColor = "#eab308"
			hexLabelColor  = "#eab308"
        
		Case STATE_ERROR
			hexBorderColor = "#ef4444"
			hexLabelColor  = "#ef4444"
	End Select
	
	' --- NO MORE MANUAL ESCAPING OR RAW JS BLOCKS HERE ---
	
	' Group text changes by element ID
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"tile-value": alertLabel _
	)
	
	' Group attribute changes by element ID -> Attribute Name -> Value
	Dim attrUpdates As Map = CreateMap( _
		"tile-border": CreateMap("stroke": hexBorderColor), _
		"tile-value": CreateMap("fill": hexLabelColor) _
	)
	
	' Bundle it together
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
	' Push to the universal updater
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
