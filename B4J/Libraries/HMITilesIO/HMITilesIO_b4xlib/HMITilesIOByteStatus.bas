B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOByteStatus.bas
' Brief:    	Matrix 4x2 to set the state of the 8-bits for a byte value.
' Date:			2026-08-29
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
End Sub

' Initializes the instance
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
End Sub

' SetTile
' Updates the header, footer and the state of the 8 pins without page reloads.
' Parameter:
'	Header - Tile header
'	Footer - Tile footer
'	Pins() - Byte array with 8 items 0 or 1
'	Value - Value used to set the binary state of the pins()
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   Pins() As Byte, _ 
				   Value As String) As String
	Dim sb As StringBuilder

	PinsAttached = Pins

	sb.Initialize	
	sb.Append($"
		var head = document.getElementById("tile-header");
		var foot = document.getElementById("tile-footer");
		if(head) {
			head.textContent = "${Header}";
		};
			
		if(foot) {
			foot.textContent = "${Footer}";
		};
	"$)
	sb.Append(UpdateByteStatus(Value.As(Byte), Pins))
	Return sb.ToString
End Sub

' Updates all 8 bits visually by passing a raw status byte and an activity layout array
' Parameter:
' 	StatusByte - The live data integer (0 - 255)
' 	PinsAttached - An array of 8 bytes where 1 = Active/Monitored, 0 = Disabled/Gray
' Returns:
'	String - Javascript to set the pins and the tile footer
Private Sub UpdateByteStatus(StatusByte As Int, Pins() As Byte) As String
	Dim sb As StringBuilder
	sb.Initialize

	' Guard check to ensure the array passed has exactly 8 elements
	If Pins.Length <> 8 Then
		Log("[UpdateByteStatus][E] PinsAttached array must contain exactly 8 elements.")
		Return ""
	End If
	
	' Loop through each of the 8 grid positions from left to right (Index 0 to 7)
	For i = 0 To 7
		' Read straight from your configuration array definition
		Dim IsEnabled As Boolean = (Pins(i) = 1)
		
		Dim UrlFill As String
		If Not(IsEnabled) Then
			UrlFill = "url(#stateDisabled)"
		Else
			' Map the array position to its mathematical binary bit shift position
			' Array Index 0 = Bit 7 (Far left) ... Array Index 7 = Bit 0 (Far right)
			Dim BitPosition As Int = 7 - i
			
			Dim IsOn As Boolean = (Bit.And(StatusByte, Bit.ShiftLeft(1, BitPosition)) <> 0)
			If IsOn Then
				UrlFill = "url(#stateOn)"
			Else
				UrlFill = "url(#stateOff)"
			End If
		End If
		
		' Build the single-line atomic execution payload
		sb.Append($"var el${i} = document.getElementById("bit${i}"); if(el${i}){el${i}.setAttribute("fill", "${UrlFill}");};"$)
	Next
	
	' Dynamically update the footer hex display string node
	Dim HexStr As String = Bit.ToHexString(StatusByte).ToUpperCase
	If HexStr.Length = 1 Then HexStr = "0" & HexStr ' Clean two-digit formatting string padding
	sb.Append($"var ft = document.getElementById("tile-footer"); if(ft){ft.textContent = "0x${HexStr.ToUpperCase}";};"$)
	
	Return sb.ToString
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
