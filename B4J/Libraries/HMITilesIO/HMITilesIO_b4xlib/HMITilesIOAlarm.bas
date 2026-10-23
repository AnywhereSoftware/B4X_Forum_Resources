B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOAlarm.bas
' Brief:        Industrial Master Alarm Panel / Warning Annunciator
' Date:			2026-09-25
' Description:	
' Usage:		
'				TileAlarm.Value = "Value"
' ==============================================================================
#End Region

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
	
	' --- Standard Severity Value Mappings ---
	Public Const STATE_OK As Int = 0        ' Normal quiet operation
	Public Const STATE_WARNING As Int = 1   ' Amber Warning (Non-fatal deviance)
	Public Const STATE_ERROR As Int = 2   ' Red Danger Alarm (Critical boundary breach)

	Public Const STATE_OK_LABEL As String = "OK"
	Public Const STATE_WARNING_LABEL As String = "WARNING"
	Public Const STATE_ERROR_LABEL  As String = "ERROR"
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
'   Header - String set text at tile top
'   Footer - String set text at tile bottom
'   Value  - String format containing "SEVERITY,TEXT" (e.g. "2,ERROR")
Public Sub SetTile(Header As String, Footer As String, Value As String)
    
	mValue = Value

	'     
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
	
	' --- Standard Palette Map for Dark HMI Frameworks ---
	Dim hexBorderColor As String      = "#transparent" ' Default: Muted Dark Slate Gray (Boring/Quiet)
	Dim hexLabelColor As String    = "#64748b" ' Default: Muted gray label

	Select statusCode
		Case STATE_WARNING  ' (Level 2 Alarm)
			' Solid, medium-saturation Amber/Yellow.
			' Requires high-contrast dark text for optimum industrial readability.
			hexBorderColor     = "#eab308"
			hexLabelColor   = "#eab308" ' Dark slate text over light background
        
		Case STATE_ERROR  ' (Level 1 High Priority Alarm)
			' Solid, unmistakable Crimson Red.
			' Stark white text for extreme readability under emergency conditions.
			hexBorderColor     = "#ef4444"
			hexLabelColor   = "#ef4444" ' White text over red background
	End Select
    
	' Safe string parsing
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
	alertLabel = alertLabel.Replace("'", "\'")
    
	Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var tile = document.getElementById("alarm-border");
        var label = document.getElementById("alarm-label");
        
        if(head) { 
			head.textContent = "${Header}"; 
		};
        
		if(foot) { 
			foot.textContent = "${Footer}";
		};
        
		if (tile) {
			tile.setAttribute("stroke", "${hexBorderColor}");
        };
        
        if (label) {
            label.textContent = "${alertLabel}";
            label.setAttribute("fill", "${hexLabelColor}");
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
		Log($"[Alarm.UpdateTile][E] Can not update the tile."$)
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
