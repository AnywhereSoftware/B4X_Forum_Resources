B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOMultiState.bas
' Brief:    	Matrix 4x2 to set the state of the 8-bits for a byte value.
' Date:			2026-09-06
' Description:	An 8-bit digital register status word display mapping a raw byte (0-255) into a high-visibility 2x4 diagnostic grid matrix with real-time hexadecimal footer logging.
'				Array-Based Configuration — Introduced a human-readable byte-Array masking scheme (`PinsAttached`) To easily enable, disable, Or gray out individual Bit status slots.
'				The matrix 8 items are named pins.
' Usage:		Set the value range 0-255.
'				TileByteStatus.Value = 103	' 0110 0111
'
'				Shows R=0 (OFF), G=1 (ON):
'				[R][G][G][R]
'				[R][G][G][G]
'				Default all pins are set 1,1,1,1,1,1,1,1.
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI

	' Channel range configurations
	Private Const MIN_STATE_INDEX		As Byte = 0
	Private Const MAX_STATE_INDEX		As Byte = 7
	Private Const TOTAL_STATE_COUNT		As Byte = 8	'ignore
	
	' Locals
	Private mStates() As Byte

	' Locals consistent across all tiles
	Private mState						As Boolean		' Holds state
	Private mValue As Int
	Private mParentPanel 				As B4XView		' Local panel holding the webview
	Private mWebView					As WebView		' Local WebView reference handle container
	Private mEventName 					As String 'ignore
	Private mCallBack 					As Object 'ignore
End Sub

Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb

	' Set all states as used
	mStates = Array As Byte(1,1,1,1,1,1,1,1)
End Sub

' ================================================================
' PUBLIC API
' ================================================================

' Set or get all states
Public Sub setStates(values() As Byte)
	mStates = values
	For i = MIN_STATE_INDEX To MAX_STATE_INDEX
		SetStateVisibility(i, IIf(mStates(i) = 1, True, False))
	Next
End Sub
Public Sub getStates As Byte()
	Return mStates
End Sub

' Set a dedicated state to 1 (true) or 0 (false).
' Updated the global class array: mPinsAttached() 
Public Sub SetState(statenr As Byte, state As Boolean)
	' Boundary guard check to prevent runtime array errors (Index 0 to 7)
	If statenr < MIN_STATE_INDEX Or statenr > MAX_STATE_INDEX Then
		Log("[SetState][E] Invalid state number. Must be 0-7.")
		Return
	End If
	
	' Convert the Boolean state directly into your 1 or 0 byte layout rule
	If state = True Then
		mStates(statenr) = 1
	Else
		mStates(statenr) = 0
	End If
End Sub

' Get a dedicated state from the class global mStates()
' Parameter:
'	statenr - Byte 0-7
' Returns:
'	Boolean - true (1) or false (0)
Public Sub GetState(statenr As Byte) As Boolean
	' Boundary guard check to prevent runtime array errors (Index 0 to 7)
	If statenr < MIN_STATE_INDEX Or statenr > MAX_STATE_INDEX Then
		Log("[GetState][E] Invalid state number. Must be 0-7.")
		Return False
	End If
	
	' Returns True only if the monitored configuration array index is exactly 1
	Return (mStates(statenr) = 1)
End Sub

' Sets a custom short alphanumeric descriptor (max 3 characters) for a specific channel box slot layout node.
' Parameter:
'	channelnr - Byte 0-7 tracking indicator index layout mapping
'	text - The shorthand text string to print inside the box (e.g. "PMP", "ERR", "VAL")
Public Sub SetStateText(statenr As Byte, text As String)
	' Boundary guard check to prevent layout DOM injection failures
	If statenr < MIN_STATE_INDEX Or statenr > MAX_STATE_INDEX Then
		Log("[SetStateText][E] Invalid state layout index. Must be 0-7.")
		Return
	End If
	
	' Safety bounds limitation adjustment ensuring string fits inside the visual node boundaries
	Dim CleansedText As String = text
	If CleansedText.Length > 3 Then
		CleansedText = CleansedText.SubString2(0, 3)
	End If
	
	' Generate dynamic JavaScript targeting your specific text ID tags
	Dim js As String = $"
		var txtEl = document.getElementById("state-txt${statenr}");
		if (txtEl) { txtEl.textContent = "${CleansedText}"; };
	"$
	
	' Execute layout adjustment change synchronously using JavaScript Wait For architecture
	Wait For (HMITilesIOUtils.ExecuteJS(mWebView, js.Replace(Chr(10), " ").Replace(Chr(13), " "))) complete (result As Boolean)
	If Not(result) Then
		Log($"[SetStateText][E] Can not set the state text for tile IOPanel"$)
	End If
End Sub

Public Sub GetStateText(statenr As Byte) As ResumableSub
	' Boundary guard check to prevent layout DOM injection failures
	If statenr < MIN_STATE_INDEX Or statenr > MAX_STATE_INDEX Then
		Log("[GetStateText][E] Invalid state layout index. Must be 0-7.")
		Return ""
	End If
	
	' JavaScript payload targeting the specific text element ID and extracting its text
	Dim js As String = $"
		(function() {
			var txtEl = document.getElementById("state-txt${statenr}");
			return txtEl ? txtEl.textContent : "";
		})();
	"$
	
	' Execute layout evaluation synchronously using JavaScript Wait For architecture
	Wait For (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As String)
	
	Return result
End Sub

' SetStateVisibility
' Set the visibility of a state incl text
' Example:
'	For i = MIN_STATE To MAX_STATE
'		SetStateVisibility(i, IIf(mStates(i) = 1, True, False))
'	Next
Public Sub SetStateVisibility(statenr As Byte, visible As Boolean)
	' Boundary guard check to prevent layout DOM injection failures
	If statenr < MIN_STATE_INDEX Or statenr > MAX_STATE_INDEX Then
		Log("[SetStateVisibility][E] Invalid state layout index. Must be 0-7.")
		Return
	End If
	
	' Determine display property value based on visibility flag
	Dim displayStyle As String = "block"
	If Not(visible) Then displayStyle = "none"
	
	' Targets the rect, then jumps up to the parent <g> group to hide everything inside
	Dim js As String = $"
		var rectEl = document.getElementById("state${statenr}");
		if (rectEl) { 
			rectEl.parentElement.style.display = "${displayStyle}"; 
		};
	"$
	
	' Execute layout adjustment change synchronously using JavaScript Wait For architecture
	Wait For (HMITilesIOUtils.ExecuteJS(mWebView, js.Replace(Chr(10), " ").Replace(Chr(13), " "))) complete (result As Boolean)
	If Not(result) Then
		Log($"[SetStateVisibility][E] Can not alter visibility for tile IOPanel"$)
	End If
End Sub

' SetTile (MultiState Grid Version)
' Updates the header, footer and the active selected index without page reloads.
' Parameter:
'	Header - Tile header
'	Footer - Tile footer (If empty string is passed, it falls back to displaying the Active state string)
'	States() - Byte array with 8 items where 1 = Visible/Clickable State Option, 0 = Invisible/Disabled State
'	Value - String integer index (e.g. "2") representing the currently chosen active state option
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   States() As Byte, _ 
				   Value As String)

	setStates(States)
	
	mValue = Value.As(Int) ' Sync internal state tracker variable

	Dim js As String = $"
		var head = document.getElementById("tile-header");
		var foot = document.getElementById("tile-footer");
		if(head) {
			head.textContent = "${Header}";
		};
	"$
	js = $"${js}${UpdateLayout(mValue, getStates)}"$
	UpdateTile(js)
End Sub

' UpdateTile
' Change the state using JavaScript.
' Parameters:
'	js - JavaScript to update the tile elements.
Private Sub UpdateTile(js As String)
	Sleep(50)
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[MultiState.UpdateTile][E] Can not update the tile."$)
	End If
End Sub

Private Sub UpdateLayout(ActiveState As Int, states() As Byte) As String
	Dim displaystyle As String
	Dim sb As StringBuilder

	sb.Initialize

	' Guard check to ensure the state density configuration array contains exactly 8 slots
	If states.Length <> 8 Then
		Log("[MultiState.UpdateLayout][E] States array must contain exactly 8 elements.")
		Return ""
	End If
	
	' Loop through each of the 8 grid blocks linearly from left to right (Index 0 to 7)
	For i = MIN_STATE_INDEX To MAX_STATE_INDEX
		Dim IsConfiguredState As Boolean = (states(i) = 1)
		
		Dim UrlFill As String
		If Not(IsConfiguredState) Then
			' Dynamically handle less states by graying out unconfigured block slots
			UrlFill = "url(#stateDisabled)"
			displaystyle = HMITilesIOUtils.DISPLAY_STYLE_NONE
		Else
			' Radio group mutual exclusion logic:
			' Only the block exactly matching the selected ActiveState index lights up green
			If i = ActiveState Then
				UrlFill = "url(#stateActive)"
			Else
				UrlFill = "url(#stateInactive)"
			End If
			displaystyle = HMITilesIOUtils.DISPLAY_STYLE_BLOCK
		End If
		
		' Append the execution statement targeting your element IDs
		sb.Append($"
			var el${i} = document.getElementById("state${i}"); 
			if(el${i}){
				el${i}.setAttribute("fill", "${UrlFill}");};
				el${i}.parentElement.style.display = "${displaystyle}"; 
			"$)
	Next
	Return sb.tostring
End Sub

' Updates all 8 state blocks visually by checking a selected state index against a configuration layout array
' Parameter:
' 	ActiveState - The selected integer index option (0 - 7)
' 	PStates - An array of 8 bytes where 1 = State is configured/available, 0 = State is unused/grayed-out
' Returns:
'	String - Compiled Javascript execution lines to update the active selections
Public Sub UpdateStates(ActiveState As Int, States() As Byte)
	Dim js As String = UpdateLayout(ActiveState, States)
	Wait For (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[MultiState.UpdateStates][E] Can not update tile IOMultiState"$)
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
		Dim PanelWidth As Float = mParentPanel.Width
		Dim PanelHeight As Float = mParentPanel.Height
			
		' Translate the physical screen pixel touch points into your 120-unit SVG matrix space
		Dim svgTouchX As Float = (Data.X / PanelWidth) * 120
		Dim svgTouchY As Float = (Data.Y / PanelHeight) * 120
			
		' This tracks the direct index option (0 to 7) matching state0 through state7 linearly
		Dim ChosenState As Int = -1
			
		' Check Row 1: States 0 to 3 (SVG Y-axis range: 32 to 57)
		If svgTouchY >= 32 And svgTouchY <= 57 Then
			If svgTouchX >= 12 And svgTouchX <= 32 Then ChosenState = 0
			If svgTouchX >= 38 And svgTouchX <= 58 Then ChosenState = 1
			If svgTouchX >= 64 And svgTouchX <= 84 Then ChosenState = 2
			If svgTouchX >= 90 And svgTouchX <= 110 Then ChosenState = 3
			
			' Check Row 2: States 4 to 7 (SVG Y-axis range: 64 to 89)
		Else If svgTouchY >= 64 And svgTouchY <= 89 Then
			If svgTouchX >= 12 And svgTouchX <= 32 Then ChosenState = 4
			If svgTouchX >= 38 And svgTouchX <= 58 Then ChosenState = 5
			If svgTouchX >= 64 And svgTouchX <= 84 Then ChosenState = 6
			If svgTouchX >= 90 And svgTouchX <= 110 Then ChosenState = 7
		End If
			
		' If a valid block area was tapped, process the clean index shift
		If ChosenState >= 0 Then
				
			' GUARD CHECK: Prevent selection if the clicked state is configured as disabled/unattached (0)
			' Uses your global mPinsAttached array directly (where 1 = configured state, 0 = hidden/gray)
			If GetState(ChosenState)Then 
					
				' Assign the chosen index directly as the single value parameter
				mValue = ChosenState
					
				' Call dedicated rendering method to instantly compile the JS string
				UpdateStates(mValue, getStates)
			
				' Bubble up single-parameter callback execution data structure safely using local references
				If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
					CallSubDelayed3(mCallBack, mEventName & "_Click", mState, ChosenState.As(String))
				End If
			End If
		End If
	End If
    
	' Simplify result creation using standard B4X Type initialization shorthand
	Dim result As HMITouchResult
	result.Initialize
	result.State = mState
	result.Value = mValue
	' Log($"[IOMultiState.Touch] newstate=${result.State} mvalue=${result.Value}"$)
	Return result
End Sub
