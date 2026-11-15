B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOReadOut.bas
' Brief:    	ReadOut to show value, text or number.
' Date:			2026-10-25
' Description:	Crisp telemetry display that cleanly outputs dynamic process numbers or 
'				operational status string values (e.g., "23.5 °C", "1013 hPa", "RUNNING").
' Usage:		
'				TileReadOut.Value = "Value"
' ================================================================

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)

	' Mandatory class globals
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
	Private mParentTile 				As HMITilesIO

	' Private class globals
	Private mTextColor 					As String
	Private mTextSize					As String
End Sub

' Initializes the instance
Public Sub Initialize(parent As HMITilesIO, pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
	mParentTile = parent
	mTextColor = HMITilesIOUtils.COLOR_SOFT_TEXT
	mTextSize = HMITilesIOUtils.TEXTSIZE_VALUE
End Sub

' GetParent
' Get the parent tile HMITilesIO to access public methods & fields.
Public Sub GetParent As HMITilesIO
	Return mParentTile
End Sub

' SetTile
' Set tile text header, value and footer.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
' 	Value - String readout the text
Public Sub SetTile(Header As String, Footer As String, Value As String)
	mValue = Value
	
	' Map the structural element IDs directly to their intended text strings
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"tile-value": Value _
	)
	
	' Bundle into the payload layout expected by the universal handler
	Dim updatePayload As Map = CreateMap("text": textUpdates)
	
	' Send directly to the central utility engine
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
End Sub

Public Sub setTextColor(value As String)
	mTextColor = value
End Sub
Public Sub getTextColor As String
	Return mTextColor
End Sub

Public Sub setTextSize(value As Int)
	mTextSize = value
End Sub
Public Sub getTextSize As Int
	Return mTextSize
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
