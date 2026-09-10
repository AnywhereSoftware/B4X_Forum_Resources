B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOSwitch.bas
' Brief:    	Switch with state ON (True, Green) and OFF (False, Red).
' Date:			2026-09-06
' Description:	The Rocker Switch with crisp, tactile 3D effect with clear status symbols.
' Usage:		
'				TileSwitch.State = False - set state OFF, Red
'				TileSwitch.State = True - set state ON, Green
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
'	State - Boolean True (ON, Green) or False (OFF, Red)
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   State As Boolean)

	' Escape text values cleanly for safe JS execution strings
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
    
	Dim js As String
    
	If State Then
		' State: ON -> Top part turns GREEN / Glowing (Pressed up). Bottom part turns dark dim.
		js = $"
            var head = document.getElementById("tile-header");
            var foot = document.getElementById("tile-footer");
            var topSeg = document.getElementById("rocker-top");
            var topSym = document.getElementById("rocker-symbol-i");
            var botSeg = document.getElementById("rocker-bottom");
            var botSym = document.getElementById("rocker-symbol-o");
            
            if(head) { head.textContent = "${Header}"; };
            if(foot) { foot.textContent = "${Footer}"; };
            if(topSeg) {
                topSeg.setAttribute("fill", "url(#greenGlow)");
                topSeg.setAttribute("stroke", "#86efac");
                topSeg.setAttribute("height", "29");
                topSym.setAttribute("stroke", "#ffffff");
                topSym.setAttribute("filter", "url(#neonGlow)");
            };
            if(botSeg) {
                botSeg.setAttribute("fill", "#14532d");
                botSeg.setAttribute("stroke", "#052e16");
                botSeg.setAttribute("y", "62");
                botSeg.setAttribute("height", "25");
                botSym.setAttribute("stroke", "#166534");
                botSym.removeAttribute("filter");
            };
        "$
	Else
		' State: OFF -> Top part turns dark dim. Bottom part turns RED / Glowing (Pressed down).
		js = $"
            var head = document.getElementById("tile-header");
            var foot = document.getElementById("tile-footer");
            var topSeg = document.getElementById("rocker-top");
            var topSym = document.getElementById("rocker-symbol-i");
            var botSeg = document.getElementById("rocker-bottom");
            var botSym = document.getElementById("rocker-symbol-o");
            
            if(head) { head.textContent = "${Header}"; };
            if(foot) { foot.textContent = "${Footer}"; };
            if(topSeg) {
                topSeg.setAttribute("fill", "#450a0a");
                topSeg.setAttribute("stroke", "#1e0202");
                topSeg.setAttribute("height", "26");
                topSym.setAttribute("stroke", "#991b1b");
                topSym.removeAttribute("filter");
            };
            if(botSeg) {
                botSeg.setAttribute("fill", "url(#redGlow)");
                botSeg.setAttribute("stroke", "#fca5a5");
                botSeg.setAttribute("y", "60");
                botSeg.setAttribute("height", "27");
                botSym.setAttribute("stroke", "#ffffff");
                botSym.setAttribute("filter", "url(#neonGlow)");
            };
        "$
	End If
	UpdateTile(js)
End Sub

' UpdateTile
' Change the state using JavaScript.
' Parameters:
'	js - JavaScript to update the tile elements.
Private Sub UpdateTile(js As String)
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[Switch.UpdateTile][E] Can not update the tile."$)
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
