B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=11.8
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private bc As ByteConverter
End Sub

Public Sub To_Unsigned(b As Byte) As Int
	Return Bit.And(0xFF, b)
End Sub



Public Sub To_Bytes(s As Short, order As Boolean, unsigned As Boolean) As Byte()
	Dim t() As Byte = bc.ShortsToBytes(Array As Short(s))
	Dim tt(t.Length) As Byte
	
	If order Then
		tt(0) = t(1)
		tt(1) = t(0)
	Else
		tt(0) = t(0)
		tt(1) = t(1)
	End If
	
	If unsigned Then
		tt(0) = To_Unsigned(tt(0))
		tt(1) = To_Unsigned(tt(1))
	End If
	
	Return tt
End Sub



Public Sub To_Short(Hb As Byte, Lb As Byte) As Short
	Dim s() As Short = bc.ShortsFromBytes(Array As Byte(Hb,Lb))
	Return s(0)
End Sub

Public Sub To_BinaryString(number As Int) As String
	Dim sb As StringBuilder
	sb.Initialize
	Dim x As Int = Bit.ShiftLeft(1, 31)
	For i = 0 To 31
		Dim ii As Int = Bit.And(number, x)
		If ii <> 0 Then    sb.Append("1") Else    sb.Append("0")
		x = Bit.UnsignedShiftRight(x, 1)
	Next
	Return sb.ToString
End Sub

public Sub To_Bin(num As Int, digits As Int) As String

	Dim s As String
   
	For k=0 To digits-1
		If Bit.And(num,1)=1 Then
			s="1"&s
		Else
			s="0"&s
		End If
		num=Bit.ShiftRight(num,1)
	Next
	Return s
End Sub

Public Sub List2Array (a_lstArgs As List) As ModbusQuery()
	Dim arrArgs(a_lstArgs.Size) As ModbusQuery
	For i = 0 To arrArgs.Length - 1
		arrArgs(i) = a_lstArgs.Get(i)
	Next
	Return arrArgs
End Sub