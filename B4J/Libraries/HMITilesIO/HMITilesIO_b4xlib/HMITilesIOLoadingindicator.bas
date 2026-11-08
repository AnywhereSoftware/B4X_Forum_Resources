B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:         HMITilesIOLoadingIndicator.bas
' Brief:        LoadingIndicator to visualize long-running processes or polling states.
' Date:         2026-10-05
' Description:  An industrial dashboard indicator designed around an SVG vector asset. 
'               Features a high-performance CSS-animated rotating blue arc for active processes,
'               and morphs into a static, neutral full circle upon task completion.
' Usage:        
'               TileLoading.Start("DATA SYNC", "Fetching registers...")
'               TileLoading.Stop("DATA SYNC", "COMPLETE", True)
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables
	Private mState                      As Boolean
	Private mValue                      As String
	Private mParentPanel                As B4XView      'ignore Local panel holding the webview
	Private mWebView                    As WebView      'ignore Local WebView reference handle container
	Private mEventName                  As String
	Private mCallBack                   As Object
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
' 	Value - String readout the text
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   State As Boolean)
	' Escape text values cleanly for safe JS execution strings
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")

	If State Then
		Start(Header, Footer)
	Else
		Stop(Header, Footer, False)
	End If
End Sub

' Start
' Activates the high-performance CSS rotation loop and updates the text properties.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
Public Sub Start(Header As String, Footer As String)
	Dim js As String = $"
		var head = document.getElementById("tile-header");
		var foot = document.getElementById("tile-footer");
		var container = document.getElementById("stateContainer");

		if(head) { head.textContent = "${Header}"; };
		if(foot) { foot.textContent = "${Footer}"; };
		
		if(container) {
			container.setAttribute("class", "is-loading");
		}
	"$
	UpdateTile(js)
End Sub

' Stop
' Freezes the rotation, snaps the ring to a full static circle, and handles optional automatic hiding.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
'	HideTileAfterwards - Boolean if true, cleanly hides the tile frame from the grid layout after a small delay
Public Sub Stop(Header As String, Footer As String, HideTileAfterwards As Boolean)
	Dim js As String = $"
		var head = document.getElementById("tile-header");
		var foot = document.getElementById("tile-footer");
		var container = document.getElementById("stateContainer");

		if(head) { head.textContent = "${Header}"; };
		if(foot) { foot.textContent = "${Footer}"; };
		
		if(container) {
			container.setAttribute("class", "is-stopped");
		}
	"$
	UpdateTile(js)

	If HideTileAfterwards Then
		' Give the operator 800ms to visually parse the finished solid circle
		' state before the element safely drops out of the dashboard mesh
		Sleep(800)
		
		Dim hideJs As String = "document.getElementById('tile-value').style.visibility = 'hidden';"
		UpdateTile(hideJs)
	End If
End Sub

' Reset
' Completely zeros out text fields, reverts the graphic to a neutral idle color state, and forces visibility back on.
Public Sub Reset
	Dim js As String = $"
		var head = document.getElementById("tile-header");
		var foot = document.getElementById("tile-footer");
		var container = document.getElementById("stateContainer");
		var root = document.getElementById("tile-value");

		if(head) { head.textContent = ""; };
		if(foot) { foot.textContent = ""; };
		
		if(container) {
			container.setAttribute("class", "is-stopped");
		}
		
		if(root) {
			root.style.visibility = "visible";
		}
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
		Log($"[LoadingIndicator.UpdateTile][E] Can not update the tile."$)
	End If
End Sub

' ProcessTouchHandler
' Process the tile touch event.
' Parameter:
'	Data - Type with all touch properties
Public Sub ProcessTouchHandler(Data As HMITouchData) As HMITouchResult
	mState = Data.State
	mValue = Data.Value

	If Data.Action = HMITilesIOUtils.ACTION_DOWN Then
		If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
			CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue)
		End If
	End If
    
	Dim result As HMITouchResult
	result.Initialize
	result.State = mState
	result.Value = mValue
	Return result
End Sub
