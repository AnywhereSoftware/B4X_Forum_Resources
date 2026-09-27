B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOIconIndicator.bas
' Brief:    	Show icon as value depending value.
' Date:			2026-09-06
' Description:	Icon Indicator: High-visibility visual alert interface rendering a scalable 48x48px vector symbol frame. Dynamically handles inline status updates (e.g., "OK", "WARNING", "ERROR", "INFO") using low-latency embedded strings.
' Usage:		
'				TileIconIndicator.Value = "INFO"
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)
'	Public TEXT_COLOR As String = "#0f172a"
'	Public TEXT_SIZE As Int = 24

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
End Sub

' Initializes the instance
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
End Sub

' SetTile for Icon Indicator
' Parameter:
'   Header - String text at tile top
'   Footer - String text at tile bottom
'   Value - Status string: "OK", "WARN", "ERR", or "INFO"
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   Value As String)

	' Select the embedded vector string based on status
	Dim IconVector As String = ICON_INFO
	Select Value.ToUpperCase
		Case STATE_OK
			IconVector = ICON_OK
		Case STATE_WARNING
			IconVector = ICON_WARNING
		Case STATE_ERROR
			IconVector = ICON_ERROR
	End Select

	' Inside your SetTile routine, flatten the string to a single line before passing to JS:
	IconVector = IconVector.Replace(CRLF, "").Replace(Chr(10), "").Replace(Chr(13), "")
	IconVector = Regex.Replace("\s+", IconVector, " ") ' Strips out all the tabs and indentation spaces


	' Formulate a safe, compact single-line DOM manipulator execution string
	' Seamless single-line execution string updating the href data target
	Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var icon = document.getElementById("tile-icon");

        if (head) { head.textContent = "${Header}"; };
        if (foot) { foot.textContent = "${Footer}"; };
        if (icon) { icon.setAttribute("href", "${IconVector}"); };
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
		Log($"[IconIndicator.UpdateTile][E] Can not update the tile."$)
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
