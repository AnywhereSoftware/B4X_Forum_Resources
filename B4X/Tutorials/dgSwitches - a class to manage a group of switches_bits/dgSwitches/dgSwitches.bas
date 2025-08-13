B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Class name: dgSwitches
'Author: UDG
'Version: 0.50
'Last Modified: 2023.04.28

Sub Class_Globals
	Private switches As Long					'64 on/off switches
	Public const SWLONG As Byte  = 64			'8 bytes -9223372036854775808..9223372036854775807
	Public const SWINT As Byte   = 32			'4 bytes -2147483648..2147483647
	Public const SWSHORT As Byte = 16			'2 bytes -32768..32767
	Public const SWBYTE As Byte  =  8			'1 byte -128..127
	
	'Helper constants
	'Public const BIT0 As Byte = 1				
	'Public const BIT1 As Byte = 2
	'Public const BIT2 As Byte = 4
	'Public const BIT3 As Byte = 8
	'Public const BIT4 As Byte = 16
	'Public const BIT5 As Byte = 32
	'Public const BIT6 As Byte = 64
	'Public const BIT7 As Byte = 128	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	switches = 0
End Sub

'Set all 64bits to their set (ON) status
Public Sub SetAllBits
	switches = 0xFFFFFFFFFFFFFFFF
End Sub

'Unset all 64 bits to their unset (OFF) status
Public Sub UnsetAllBits
	switches = 0
End Sub

'Set all switches according to the passed value
'Positives: 0x0000000000000000 (decimal 0) to 0x7FFFFFFFFFFFFFFF (decimal +9223372036854775807)
'Negatives: 0x8000000000000000 (decimal -9223372036854775808) to 0xFFFFFFFFFFFFFFFF (decimal -1)
Public Sub SetAllFromValue(value As Long)
	switches = value
End Sub

'Return the value for the selected bank as the proper type variable based on SwitchType
'Caution: no checks on parameter validity
Public Sub GetValue(SwitchType As Byte, bank As Byte) As Object
	Select SwitchType
		Case SWLONG
			Dim lval As Long = switches
			Return lval
		Case SWINT
			Dim ival As Int = Bit.AndLong(0x00000000FFFFFFFF, Bit.ShiftRightLong(switches, SWINT * bank)).As(Int)
			Return ival
		Case SWSHORT
			Dim sval As Short = Bit.AndLong(0x000000000000FFFF, Bit.ShiftRightLong(switches, SWSHORT * bank)).As(Short)
			Return sval
		Case SWBYTE
			Dim bval As Byte = Bit.AndLong(0x00000000000000FF, Bit.ShiftRightLong(switches, SWBYTE * bank)).As(Byte)
			Return bval
		Case Else
			Dim nval As Long = 0
			Return nval
	End Select
End Sub

#Region Single bit operations

'Set a single bit. Pos ranges from 0 (rightmost) to 63 (leftmost)
Public Sub SetSingleBit(pos As Byte)
	If pos = 63 Then
		switches = Bit.OrLong(switches, 0x8000000000000000)
	Else
		Dim pow As Double = Power(2, pos)
		switches = Bit.OrLong(switches, pow)
	End If
End Sub

'Set a single bit. Uses SwitchType, bank and pos to determine the bit to set
Public Sub SetSingleBit2(SWtype As Byte, bank As Byte, pos As Byte)
	Dim bpos As Byte = pos+(SWtype*bank)
	SetSingleBit(bpos)
End Sub

'Unset a single bit. Pos ranges from 0 (rightmost) to 63 (leftmost)
Public Sub UnSetSingleBit(pos As Byte)
	If pos = 63 Then
		switches = Bit.AndLong(switches, 0x7FFFFFFFFFFFFFFF)
	Else
		Dim pow As Double = Power(2, pos)
		switches = Bit.AndLong(switches, Bit.NotLong(pow))
	End If
End Sub

'Unset a single bit. Uses SwitchType, bank and pos to determine the bit to unset
Public Sub UnSetSingleBit2(SWtype As Byte, bank As Byte, pos As Byte)
	Dim bpos As Byte = pos+(SWtype*bank)
	UnSetSingleBit(bpos)
End Sub

'Check if selected bit is set. Return True for a set bit, False for an unset bit
Public Sub IsSetBit(pos As Byte) As Boolean
	If pos = 63 Then
		Return (Bit.AndLong(switches, 0x8000000000000000) = 0x8000000000000000)
	Else
		Dim pow As Double = Power(2, pos)
		Return (Bit.Andlong(switches, pow) = pow)
	End If
End Sub

'Check if selected bit is set. Uses SwitchType, bank and pos to determine whether the bit is set
Public Sub IsSetBit2(SWtype As Byte, bank As Byte, pos As Byte) As Boolean
	Dim bpos As Byte = pos+(SWtype*bank)
	Return IsSetBit(bpos)
End Sub

#End Region

#Region Multiple bits operations

'Set a combination of bits
Public Sub SetBits(value As Long)
	switches = Bit.OrLong(switches, value)
End Sub

'Set a combination of bits for the specified bank of the specified SwitchType
Public Sub SetBits2(SWtype As Byte, bank As Byte, value As Long)
	Dim temp As Long = Bit.ShiftLeftLong(value, SWtype * bank)
	switches = Bit.OrLong(switches, temp)
End Sub

'Set multiple bits according to the swlist parameter
Public Sub SwFromList(swlist As List)
	For i = 0 To swlist.Size-1
		Dim pos As Byte = swlist.Get(i)
		SetSingleBit(pos)
	Next
End Sub

'Set all the switches according to the swstr parameter. Caution: No sanity checks performed
'swstr is a 64chars long string, made of 0s and 1s representing switches' positions. 
Public Sub SwFromString(swstr As String)
	switches = IIf((swstr.CharAt(0)="1"), 0x8000000000000000, 0)
	For i = 1 To 63
		Dim temp As Long = IIf((swstr.CharAt(i)="1"), Power(2, 63-i), 0)
		switches = switches + temp
	Next
End Sub

'Set multiple switches according to the swstr parameter. Caution: No sanity checks performed
'Switches from other banks keep or not their current state based on the KeepState parameter
'swstr length must conform to the chosen SwitchType.
'swstr is made of 0s and 1s, representing individual switches in the specified bank of switches
Public Sub SwFromString2(SWtype As Byte, bank As Byte, swstr As String, KeepState As Boolean)
	If KeepState Then SwFromString21(SWtype, bank, swstr) Else SwFromString22(SWtype, bank, swstr)
End Sub

'Set multiple switches according to the swstr parameter. Caution: No sanity checks performed
'Switches from other banks keep their current state
Private Sub SwFromString21(SWtype As Byte, bank As Byte, swstr As String)
	For i = 0 To swstr.length-1
		If (swstr.CharAt(i)="1") Then SetSingleBit2(SWtype, bank, SWtype-i)
	Next
End Sub

'Set multiple switches according to the swstr parameter. Caution: No sanity checks performed
'Switches from other banks will be unset (OFF)
Private  Sub SwFromString22(SWtype As Byte, bank As Byte, swstr As String)
	Dim top As Byte = (SWtype * bank) + SWtype-1
	If top = 63 Then
		switches = IIf((swstr.CharAt(0)="1"), 0x8000000000000000, 0)
		For i = 1 To swstr.length-1
			Dim temp As Long = IIf((swstr.CharAt(i)="1"), Power(2, 63-i), 0)
			switches = switches + temp
		Next
	Else
		switches = 0
		For i = 0 To swstr.length-1
			Dim temp As Long = IIf((swstr.CharAt(i)="1"), Power(2, top-i), 0)
			switches = switches + temp
		Next
	End If
End Sub

'Return a string of 0s and 1s as a binary representation of value according to SwitchType
Public Sub SwToString(SwitchType As Byte, value As Long) As String
	Dim sb As StringBuilder
	sb.Initialize
	If SwitchType = SWLONG Then
		Dim temp As Long = Bit.ShiftRightLong(value, 63)
		sb.Append(IIf((Bit.Andlong(temp, 1) = 1), "1", "0").As(String))
		For pos = 62 To 0 Step-1
			Dim pow As Double = Power(2, pos)
			sb.Append(IIf((Bit.Andlong(value, pow) = pow), "1", "0").As(String))
		Next
	Else
		For pos = SwitchType-1 To 0 Step-1
			Dim pow As Double = Power(2, pos)
			sb.Append(IIf((Bit.Andlong(value, pow) = pow), "1", "0").As(String))
		Next
	End If
	Return sb.ToString
End Sub

#End Region


