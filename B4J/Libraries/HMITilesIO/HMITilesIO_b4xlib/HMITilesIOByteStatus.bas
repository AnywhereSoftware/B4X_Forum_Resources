B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOByteStatus.bas
' Brief:    	Matrix 4x2 to set the state of the 8-bits for a byte value.
' Date:			2026-10-28
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

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)
	Public TEXT_COLOR As String = "#0f172a"
	Public TEXT_SIZE As Int = 24
	Public PinsAttached() As Byte = Array As Byte (1,1,1,1,1,1,1,1)

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
' Updates the header, footer and the state of the 8 pins without page reloads.
Public Sub SetTile(Header As String, Footer As String, Pins() As Byte, Value As String)
	mValue = Value
	
	PinsAttached = Pins

	' 1. Guard check to ensure the array passed has exactly 8 elements
	If Pins.Length <> 8 Then
		Log("[SetTile][E] Pins array must contain exactly 8 elements.")
		Return
	End If

	' Convert the value safely into an integer representing our status byte (0-255)
	Dim StatusByte As Int = 0
	If IsNumber(Value) Then StatusByte = Value.As(Int)

	' 2. Calculate hex formatting padding for the live data display
	Dim HexStr As String = Bit.ToHexString(StatusByte).ToUpperCase
	If HexStr.Length = 1 Then HexStr = "0" & HexStr
	Dim LiveFooter As String = "0x" & HexStr

	' 3. Formulate standard text content mappings
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": LiveFooter _ ' Dynamically over-written by the live Hex string per original design
	)

	' 4. Process the bitmask array mappings inside B4X
	Dim attrUpdates As Map
	attrUpdates.Initialize

	For i = 0 To 7
		Dim IsEnabled As Boolean = (Pins(i) = 1)
		Dim UrlFill As String
		
		If Not(IsEnabled) Then
			UrlFill = "url(#stateDisabled)"
		Else
			' Map array index 0 to Bit 7 (Far Left), array index 7 to Bit 0 (Far Right)
			Dim BitPosition As Int = 7 - i
			Dim IsOn As Boolean = (Bit.And(StatusByte, Bit.ShiftLeft(1, BitPosition)) <> 0)
			
			If IsOn Then
				UrlFill = "url(#stateOn)"
			Else
				UrlFill = "url(#stateOff)"
			End If
		End If
		
		' Dynamic map entry creation targeting element keys: "bit0", "bit1", etc.
		attrUpdates.Put("bit" & i, CreateMap("fill": UrlFill))
	Next

	' 5. Bundle everything up and push to your central utility engine
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
