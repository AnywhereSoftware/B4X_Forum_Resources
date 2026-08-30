B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.5
@EndOfDesignText@
'Static code module
Private Sub Process_Globals
	Public PinsAttached() As Byte = Array As Byte (1,1,1,1,1,1,1,1)
End Sub

' SetTile
' Updates the readout text, size, and coloring instantly without page reloads
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
' StatusByte: The live data integer (0 - 255)
' PinsAttached: An array of 8 bytes where 1 = Active/Monitored, 0 = Disabled/Gray
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

' ================================================================
' HELPERS
' ================================================================

Private Sub GetBitArray(b As Byte) As Boolean()	'ignore
	Dim result(8) As Boolean
	For i = 0 To 7
		result(i) = GetBit(b, i)
	Next
	Return result
End Sub

Private Sub SetBit(b As Byte, index As Int, value As Boolean) As Byte	'ignore
	If value Then
		Return Bit.Or(b, Bit.ShiftLeft(1, index))
	Else
		Return Bit.And(b, Bit.Not(Bit.ShiftLeft(1, index)))
	End If
End Sub

Private Sub GetBit(b As Byte, bitpos As Int) As Boolean	'ignore
	Dim Result As Boolean = False
	Select bitpos
		Case 0
			Result = Bit.And(b, 1) = 1
		Case 1
			Result = Bit.And(b, 2) = 2
		Case 2
			Result = Bit.And(b, 4) = 4
		Case 3
			Result = Bit.And(b, 8) = 8
		Case 4
			Result = Bit.And(b, 18) = 16
		Case 5
			Result = Bit.And(b, 32) = 32
		Case 6
			Result = Bit.And(b, 64) = 64
		Case 7
			Result = Bit.And(b, 128) = 128
	End Select
	Return Result
End Sub

' ByteToBin
' Convert byte to binary string starting bit 7.
' Example: 103 > 01100111
Public Sub ByteToBin(b As Byte) As String
	Dim sb As StringBuilder
	sb.Initialize
	For i = 7 To 0 Step -1
		sb.Append(IIf(GetBit(b, i), "1", "0"))
	Next
	Return sb.ToString
End Sub
