B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:        HMITilesIOQuadReadOut.bas
' Brief:       High-density 2x2 multi-variable industrial readout tile
' Date:        2026-10-28
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

Private Sub Class_Globals
	Private xui As XUI
	
	' Mandatory class globals
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
	Private mParentTile 				As HMITilesIO

	' Flexibly defined arrays for layout properties (1-indexed for 4 quadrants)
	Private mLabels(5)                  As String
	Private mUnits(5)                   As String
	Private mColors(5)                  As String
	Private mActiveQuads                As Int			'
End Sub

' Initializes the instance with safe, high-performance HMI defaults
Public Sub Initialize(parent As HMITilesIO, pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
	mActiveQuads = 4
	mParentTile = parent
	
	' Fill arrays with clean defaults
	For i = 1 To mActiveQuads
		mLabels(i) = "Quad " & i
		mUnits(i)  = ""
		mColors(i) = "#0f172a" ' Default crisp dark text slate color
	Next
End Sub

' GetParent
' Get the parent tile HMITilesIO to access public methods & fields.
Public Sub GetParent As HMITilesIO
	Return mParentTile
End Sub

' SetQuadConfiguration
' Flexible method to customize labels, units, and colors for a specific cell.
Public Sub SetQuadConfiguration(QuadIndex As Int, Label As String, Unit As String, HexColor As String)
	If QuadIndex < 1 Or QuadIndex > 4 Then Return
	mLabels(QuadIndex) = Label
	mUnits(QuadIndex)  = Unit
	mColors(QuadIndex) = HexColor
End Sub

' SetTile
' Value must be a flat comma-separated string mapping values to active quadrants (e.g. "2288,178,9,31")
Public Sub SetTile(Header As String, Footer As String, Value As String)
	mValue = Value
	
	Dim valItems() As String = Regex.Split(",", mValue)
	
	' 1. Group core structural text updates
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer _
	)
	
	Dim attrUpdates As Map
	attrUpdates.Initialize
	
	' Track layout matrix line visibility entirely within B4X boolean flags
	Dim showTL As Boolean = False
	Dim showTR As Boolean = False
	Dim showBL As Boolean = False
	Dim showBR As Boolean = False

	' 2. Evaluate each quadrant matrix loop natively in B4X
	For i = 1 To 4
		Dim currentVal As String = ""
		If (i - 1) < valItems.Length Then
			currentVal = valItems(i - 1).Trim
		End If
		
		Dim isQuadActive As Boolean = (currentVal <> "" Or mLabels(i) <> "")
		
		If isQuadActive Then
			' Toggle our layout tracking coordinates
			If i = 1 Then showTL = True
			If i = 2 Then showTR = True
			If i = 3 Then showBL = True
			If i = 4 Then showBR = True
			
			' Set display block style rules
			attrUpdates.Put("quad-" & i, CreateMap("style": "display: block;"))
			
			' Put quadrant values and text colors securely into the payload map
			textUpdates.Put("q" & i & "-value", currentVal)
			attrUpdates.Put("q" & i & "-value", CreateMap("fill": mColors(i)))
			
			' Target custom label and unit explicit IDs directly
			textUpdates.Put("q" & i & "-label", mLabels(i))
			textUpdates.Put("q" & i & "-unit", mUnits(i))
		Else
			' Instantly hide unused quadrants
			attrUpdates.Put("quad-" & i, CreateMap("style": "display: none;"))
		End If
	Next

	' 3. Matrix Math Engine: Calculate lines visibility inside B4X
	Dim showVerticalLine As Boolean = (showTL And showTR) Or (showBL And showBR)
	Dim showHorizontalLine As Boolean = (showTL And showBL) Or (showTR And showBR)
	
	' Map divider visibility rules cleanly
	attrUpdates.Put("divider-h", CreateMap("style": "display: " & IIf(showHorizontalLine, "block;", "none;")))
	attrUpdates.Put("divider-v", CreateMap("style": "display: " & IIf(showVerticalLine, "block;", "none;")))

	' 4. Bundle everything up and push to your central utility engine
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
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
	
	' 1. Group a pinpoint target map update purely for the modified element ID string
	Dim textUpdates As Map = CreateMap("q" & QuadIndex & "-value": NewValue)
	Dim updatePayload As Map = CreateMap("text": textUpdates)
	
	' 2. Execute via safe data serialization pipeline
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
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
