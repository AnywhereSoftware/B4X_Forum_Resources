B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOIconIndicator.bas
' Brief:    	Show icon as value depending value.
' Date:			2026-10-28
' Description:	Icon Indicator: High-visibility visual alert interface rendering a scalable 48x48px vector symbol frame. Dynamically handles inline status updates (e.g., "OK", "WARNING", "ERROR", "INFO") using low-latency embedded strings.
' Usage:		
'				TileIconIndicator.Value = "INFO"
' ================================================================

Private Sub Class_Globals
	Private xui As XUI

	' Public states
	Public STATE_INFO 		As String = "INFO"
	Public STATE_OK			As String = "OK"
	Public STATE_WARNING	As String = "WARNING"
	Public STATE_ERROR		As String = "ERROR"

	' Private icon SVG definitions
	Private ICON_XMLNS As String = "xmlns='http://www.w3.org/2000/svg'"
	
	Private ICON_INFO As String = $"
	    data:image/svg+xml;utf8,
	    <svg ${ICON_XMLNS} width='48' height='48' viewBox='0 0 48 48' fill='%2338bdf8'>
	        <circle cx='24' cy='24' r='20' stroke='%2338bdf8' stroke-width='3.5' fill='none'/>
	        <line x1='24' y1='33' x2='24' y2='24' stroke='%2338bdf8' stroke-width='3.5' stroke-linecap='round'/>
	        <line x1='24' y1='15' x2='24.01' y2='15' stroke='%2338bdf8' stroke-width='3.5' stroke-linecap='round'/>
	    </svg>
	"$

	Private ICON_WARNING As String = $"
	    data:image/svg+xml;utf8,
	    <svg ${ICON_XMLNS} width='48' height='48' viewBox='0 0 48 48' fill='%23f59e0b'>
	        <path d='M24 4L2 44h44L24 4zm0 8l17.5 28h-35L24 12zm-2 7v10h4V19h-4zm0 14v4h4v-4h-4z'/>
	    </svg>
	"$

	Private ICON_ERROR As String = $"
	    data:image/svg+xml;utf8,
	    <svg ${ICON_XMLNS} width='48' height='48' viewBox='0 0 48 48' fill='%23ef4444'>
	        <circle cx='24' cy='24' r='20' stroke='%23ef4444' stroke-width='3.5' fill='none'/>
	        <line x1='31' y1='17' x2='17' y2='31' stroke='%23ef4444' stroke-width='3.5' stroke-linecap='round'/>
	        <line x1='17' y1='17' x2='31' y2='31' stroke='%23ef4444' stroke-width='3.5' stroke-linecap='round'/>
	    </svg>
	"$

	Private ICON_OK As String = $"
	    data:image/svg+xml;utf8,
	    <svg ${ICON_XMLNS} width='48' height='48' viewBox='0 0 48 48' fill='%2322c55e'>
	        <circle cx='24' cy='24' r='20' stroke='%2322c55e' stroke-width='3.5' fill='none'/>
	        <path d='M16.5 24l5 5 10-10' stroke='%2322c55e' stroke-width='3.5' fill='none' stroke-linecap='round' stroke-linejoin='round'/>
	    </svg>
	"$

	' Mandatory for all tile classes
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

' SetTile for Icon Indicator
' Parameter:
'   Header - String text at tile top
'   Footer - String text at tile bottom
'   Value - Status string: "OK", "WARN", "ERR", or "INFO"
Public Sub SetTile(Header As String, Footer As String, Value As String)

	mValue = Value

	' 1. Select the embedded vector string based on status
	Dim IconVector As String = ICON_INFO
	Select Value.ToUpperCase
		Case STATE_OK
			IconVector = ICON_OK
		Case STATE_WARNING
			IconVector = ICON_WARNING
		Case STATE_ERROR
			IconVector = ICON_ERROR
	End Select

	' --- NO MORE MANUAL STRIP, FLATTEN, OR REGEX CLEANUP CODE NEEDED HERE ---

	' 2. Group all standard text content mappings
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer _
	)
	
	' 3. Map the SVG sprite href target element attribute cleanly
	Dim attrUpdates As Map = CreateMap( _
		"tile-icon": CreateMap("href": IconVector) _
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
