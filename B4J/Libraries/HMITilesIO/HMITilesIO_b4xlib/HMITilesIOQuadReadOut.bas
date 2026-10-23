B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:        HMITilesIOQuadReadOut.bas
' Brief:       High-density 2x2 multi-variable industrial readout tile
' Date:        2026-09-06
' Description: Renders up to 4 distinct sub-channels (quadrants) inside 
'              a standard 120x120px grid layout. Features an intelligent
'              dynamic layout engine that hides unused quadrants and layout
'              lines automatically to re-balance the visual white space.
' Usage:       
'              1. Configure static layouts once during initialization:
'                 Tile.SetQuadConfiguration(1, "Solar", "W", "#10b981")
'                 Tile.SetQuadConfiguration(2, "House", "W", "#0f172a")
'
'              2. If you only want 2 side-by-side variables, explicitly 
'                 clear out configurations for quadrants 3 and 4:
'                 Tile.SetQuadConfiguration(3, "", "", "")
'                 Tile.SetQuadConfiguration(4, "", "", "")
'
'              3. Refresh real-time numbers via a comma-separated array:
'                 Tile.SetTile("OVERVIEW", "System Active", "2288,178")
'
'              4. Low-latency update for a single target field register:
'                 Tile.UpdateSingleValue(1, "2304")
'
' Hints:       - Value indexing is 1-based (Quadrants 1 to 4).
'              - Leave a quadrant's value and configuration empty to 
'                dynamically morph the tile into a clean split-panel grid.
'              - Uses strict string slicing routines to guarantee zero 
'                B4X syntax compiler exceptions during quick runtime checks.
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI
	
	' Mandatory class globals
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object

	' Flexibly defined arrays for layout properties (1-indexed for 4 quadrants)
	Private mLabels(5)                  As String
	Private mUnits(5)                   As String
	Private mColors(5)                  As String
	Private mActiveQuads                As Int			'
End Sub

' Initializes the instance with safe, high-performance HMI defaults
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
	mActiveQuads = 4
	
	' Fill arrays with clean defaults
	For i = 1 To mActiveQuads
		mLabels(i) = "Quad " & i
		mUnits(i)  = ""
		mColors(i) = "#0f172a" ' Default crisp dark text slate color
	Next
End Sub

' SetQuadConfiguration
' Flexible method to customize labels, units, and colors for a specific cell.
Public Sub SetQuadConfiguration(QuadIndex As Int, Label As String, Unit As String, HexColor As String)
	If QuadIndex < 1 Or QuadIndex > 4 Then Return
	mLabels(QuadIndex) = Label
	mUnits(QuadIndex)  = Unit
	mColors(QuadIndex) = HexColor
End Sub

' UpdateSingleValue
' Directly updates just one quadrant's value without forcing a full array re-parse
Public Sub UpdateSingleValue(QuadIndex As Int, NewValue As String)
	If QuadIndex < 1 Or QuadIndex > 4 Then Return
	
	' Reconstruct the global CSV mValue string to keep internal states perfectly accurate
	Dim items() As String = Regex.Split(",", mValue)
	Dim values(4) As String
	For i = 0 To 3
		If i < items.Length Then values(i) = items(i) Else values(i) = ""
	Next
	values(QuadIndex - 1) = NewValue
	mValue = values(0) & "," & values(1) & "," & values(2) & "," & values(3)
	
	' Low-latency single element target swap
	Dim js As String = $"
		var txt = document.getElementById("q${QuadIndex}-value");
		if(txt) { txt.textContent = "${NewValue}"; }
	"$
	UpdateTile(js)
End Sub

' SetTile
' Value must be a flat comma-separated string mapping values to active quadrants (e.g. "2288,178,9,31")
' The max number f quadrants is 4.
Public Sub SetTile(Header As String, Footer As String, Value As String)
	mValue = Value
	
	' Split out individual quadrant strings from the main flat value string
	Dim valItems() As String = Regex.Split(",", mValue)
	
	Dim sb As StringBuilder
	sb.Initialize
	
	' Update global frame layout definitions and reset divider tracking states
	sb.Append($"
		var head = document.getElementById("tile-header");
		var foot = document.getElementById("tile-footer");
		if(head) { head.textContent = "${Header}"; };
		if(foot) { foot.textContent = "${Footer}"; };
		var showTL = 0;
		var showTR = 0;
		var showBL = 0;
		var showBR = 0;
	"$)

	' Inject visibility, layout formatting, and structural tracking values
	For i = 1 To 4
		Dim currentVal As String = ""
		
		' Safely check if the index exists inside your passed array bounds
		If (i - 1) < valItems.Length Then
			currentVal = valItems(i - 1).Trim
		End If
		
		' A quadrant is active if it contains a value or a configuration label
		Dim isQuadActive As Boolean = (currentVal <> "" Or mLabels(i) <> "")
		
		If isQuadActive Then
			' Update inner script tracking integers dynamically inside the JS runtime environment
			If i = 1 Then sb.Append("showTL = 1;")
			If i = 2 Then sb.Append("showTR = 1;")
			If i = 3 Then sb.Append("showBL = 1;")
			If i = 4 Then sb.Append("showBR = 1;")
			
			sb.Append($"
				var q${i} = document.getElementById("quad-${i}");
				var q${i}_lbl = document.querySelector("#quad-${i} text:nth-child(1)");
				var q${i}_val = document.getElementById("q${i}-value");
				var q${i}_unt = document.querySelector("#quad-${i} text:nth-child(3)");
				
				if(q${i}) { q${i}.style.display = "block"; }
				if(q${i}_lbl) { q${i}_lbl.textContent = "${mLabels(i)}"; }
				if(q${i}_val) { 
					q${i}_val.textContent = "${currentVal}"; 
					q${i}_val.setAttribute("fill", "${mColors(i)}");
				}
				if(q${i}_unt) { q${i}_unt.textContent = "${mUnits(i)}"; }
			"$)
		Else
			' Instantly strip the unused elements out of the viewport DOM tree
			sb.Append($"
				var q${i} = document.getElementById("quad-${i}");
				if(q${i}) { q${i}.style.display = "none"; }
			"$)
		End If
	Next

	' Layout Engine: Toggles dividers based on mathematical matrix flags
	sb.Append($"
		var divH = document.getElementById("divider-h");
		var divV = document.getElementById("divider-v");
		
		var showVerticalLine = ((showTL === 1) && (showTR === 1)) || ((showBL === 1) && (showBR === 1));
		var showHorizontalLine = ((showTL === 1) && (showBL === 1)) || ((showTR === 1) && (showBR === 1));
		
		if(divH) { divH.style.display = showHorizontalLine ? "block" : "none"; }
		if(divV) { divV.style.display = showVerticalLine ? "block" : "none"; }
	"$)

	UpdateTile(sb.ToString)
End Sub

Private Sub UpdateTile(js As String)
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[QuadReadout.UpdateTile][E] Error executing layout calculation script."$)
	End If
End Sub

Public Sub ProcessTouchHandler(Data As HMITouchData) As HMITouchResult
	mState = Data.State
	mValue = Data.Value
	If Data.Action = HMITilesIOUtils.ACTION_DOWN Then
		If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
			CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue)
		End If
	End If
	Dim result As HMITouchResult
	result.Initialize: result.State = mState: result.Value = mValue
	Return result
End Sub
