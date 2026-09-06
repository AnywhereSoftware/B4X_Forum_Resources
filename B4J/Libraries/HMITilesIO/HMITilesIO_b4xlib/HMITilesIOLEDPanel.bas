B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOLEDPanel.bas
' Brief:    	LED with status ON (Green) or OFF (Red).
' Date:			2026-08-29
' Description:	Deep, polished status lens with a realistic glare overlay.
' Usage:		Set state ON:
'				TileLEDPanel.State = True
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI
		
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
' 	State - Boolean True (ON, Green) or False (OFF, Red)
Public Sub SetTile(Header As String, _
					Footer As String, _
					State As Boolean) As String
	Dim js As String
    
	' Escape text values cleanly for safe JS execution strings
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
    
	If State Then
		js = $"
            var head = document.getElementById("tile-header");
            var foot = document.getElementById("tile-footer");
            var lens = document.getElementById("led-lens");
            if(head) { head.textContent = "${Header}"; };
            if(foot) {
                foot.textContent = "${Footer}";
                foot.setAttribute("fill", "#64748b");
            };
            if(lens) {
                lens.setAttribute("fill", "url(#ledGreen)");
                lens.setAttribute("filter", "url(#lensGlow)");
            };
        "$
	Else
		js = $"
            var head = document.getElementById("polygon-header");
            var head = document.getElementById("tile-header");
            var foot = document.getElementById("tile-footer");
            var lens = document.getElementById("led-lens");
            if(head) { head.textContent = "${Header}"; };
            if(foot) {
                foot.textContent = "${Footer}";
                foot.setAttribute("fill", "#64748b");
            };
            if(lens) {
                lens.setAttribute("fill", "url(#ledOff)");
                lens.removeAttribute("filter");
            };
        "$
	End If
	Return js
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
