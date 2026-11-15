B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOBattery.bas
' Brief:    	Battery indicator
' Date:			2026-10-28
' Description:	Smart, low-footprint charge level layout displaying a responsive 4-segment vertical vector cell. Automatically transitions through visibility and warning color profiles based on raw 0-100% capacity data blocks.
' Usage:		Show a low level battery with red cell.
'				TileBattery.Value = 10
' ================================================================

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)
	Public TEXT_COLOR As String = "#0f172a"
	Public TEXT_SIZE As Int = 24

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

' SetTile
' Set all tile properties.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
' 	Value - String converted to 0-100 percentage
Public Sub SetTile(Header As String, Footer As String, Value As String)
	' Clean input parameters safely
	If Not(IsNumber(Value)) Then Return
	
	mValue = Value
	
	Dim BatteryPct As Double = Value.As(Double)
    
	' Ensure boundaries stay within 0-100% constraints
	If BatteryPct < 0 Then BatteryPct = 0
	If BatteryPct > 100 Then BatteryPct = 100

	Dim PctString As String = NumberFormat2(BatteryPct, 1, 0, 0, False)
	Dim PctInt As Int = PctString.As(Int) ' Used for step thresholds

	' 1. Calculate color based on percentage thresholds in B4X
	Dim hexColor As String = "#22c55e" ' Default green
	If PctInt <= 20 Then
		hexColor = "#ef4444" ' Red
	Else If PctInt <= 50 Then
		hexColor = "#f59e0b" ' Amber
	End If

	' 2. Formulate standard text content mappings
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"tile-value": PctString & "%" _
	)
	
	' 3. Map individual attribute fills based on thresholds
	Dim attrUpdates As Map = CreateMap( _
		"bat-lvl1": CreateMap("fill": IIf(PctInt > 5,   hexColor, "none")), _
		"bat-lvl2": CreateMap("fill": IIf(PctInt >= 25, hexColor, "none")), _
		"bat-lvl3": CreateMap("fill": IIf(PctInt >= 50, hexColor, "none")), _
		"bat-lvl4": CreateMap("fill": IIf(PctInt >= 75, hexColor, "none")) _
	)
	
	' 4. Bundle and ship to your single centralized engine
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
