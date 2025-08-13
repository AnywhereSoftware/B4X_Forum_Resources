B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'Code module
#IgnoreWarnings:12

'Subs in this code module will be accessible from all modules.

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim Const MICROSECONDS_PER_MINUTE As Long = 60000000
End Sub

'@SLHide
Sub GetAsHexStr(Str As Object) As String

	'Create the Formatter Object
    Dim Format As JavaObject
    Format.InitializeStatic("java.lang.String")
	Dim FormatStr As String = "%#4x"
	 
	 Return Format.RunMethod("format",Array As Object(FormatStr,Array As Object(Str)))
End Sub

'@SLHide
Sub StringFromBytes(ByteArray() As Byte,ChrSet As String) As String
	Dim StringClass As JavaObject
	Return StringClass.InitializeNewInstance("java.lang.String",Array(ByteArray,ChrSet)).RunMethod("toString",Null)
End Sub

'@SLHide
Sub WriteVarInt(Value As Int) As Byte()
	Dim TList As List
	TList.Initialize
	TList.Add(Array As Byte(Bit.And(Value,0x7F)))
	
	Value = Bit.ShiftRight(Value,7)
	Do While Value > 0
		TList.Add(Array As Byte(Bit.Or(Bit.And(Value,0x7F),0x80)))
		Value = Bit.ShiftRight(Value,7)
	Loop
	Dim Result As SLByteArrayBuffer
	Result.Initialize(TList.Size)
	For i = TList.Size - 1 To 0 Step -1
		Result.AppendByte(TList.get(i),0,1)
	Next
	Return Result.ToByteArray
End Sub
'@SLHide
Private Sub ReadVarInt(Bytes() As Byte) As Int
	Dim Value As Int
	Dim CurrentByte As Int
	Dim Pos As Int
	CurrentByte = Bit.And(Bytes(Pos),0xFF)
	Pos = Pos + 1
	Value = Bit.And(CurrentByte,0x7F)
	Do Until Bit.AND(CurrentByte,0x80) <> 0X80
		CurrentByte = Bit.AND(Bytes(Pos),0xFF)
		Pos = Pos + 1
		Value = Bit.ShiftLeft(Value,7) + Bit.AND(CurrentByte,0x7F)
	Loop
	Return Value
End Sub

'@SLHide
Sub InvalidStatus(Status As Int,L As String)
	Dim Msg As String = GetAsHexStr(Status) & " is not a valid Status"
	If L <> "" Then Msg = Msg & " with length " & L
	ThrowException(Msg)
End Sub

Sub ThrowException(Msg As String)
	Dim Ex As ExceptionEx
	Ex.Initialize(Msg)
	Ex.Throw
End Sub

'@SLHide
Sub Logger(Status As String,Class As String,Message As String)
	If Class <> "" Then Message = Class & " : " & Message
	Select Status.ToUpperCase
		Case "WARNING"
			LogColor(Message,Colors.Magenta)
		Case "INFO"
			LogColor(Message,Colors.DarkGray)
		Case "ERROR"
			LogColor(Status & "! " & Message,Colors.Red)
		Case Else
			LogColor(Status & " " & Message,Colors.Blue)
	End Select
End Sub
'Find the exact, previous or next number in a sorted list of numbers
'Higher = True for the next highest or False for the next lowest
'Returns the index in the list of the required hit
Sub FindPositionNum(Target As Object, L As List, Higher As Boolean) As Int
    Dim iMax,iMin,iMid As Int
    iMax=L.Size-1
    iMin=0
    'Set up for first iteration
    iMid=iMin+((iMax-iMin)/2)
    Dim Val As Object = L.get(iMid)

    'Start
    Do While iMin < iMax
        '1st or second half
        If Val < Target Then
            iMin=iMid+1
        Else
            iMax=iMid
        End If
        'Set pointer to half way for next iteration
        iMid=iMin+((iMax-iMin)/2)
        Val = L.get(iMid)
    Loop

    If Higher Then
        Return iMid
    Else
        If Val = Target Then
            Return iMid
        Else
            If iMid = 0 Then
                Return 0
            Else
                Return iMid - 1
            End If
        End If
    End If
End Sub

Sub Arraycopy(Src As Object,SrcPos As Int,Dst As Object,DstPos As Int,Length As Int)
	Dim StaticClassSystem As JavaObject
	StaticClassSystem.InitializeStatic("java.lang.System")
	StaticClassSystem.RunMethod("arraycopy",Array As Object(Src,SrcPos,Dst,DstPos,Length))
End Sub

Sub CopyOfRange(Source() As Byte,Offset As Int,Length As Int) As Byte()
	Dim StaticClassArrays As JavaObject
	StaticClassArrays.InitializeStatic("java.util.Arrays")
	Return StaticClassArrays.RunMethod("copyOfRange",Array As Object(Source,Offset,Length))
End Sub

'Takes an int and returns a 3 byte array for use with setting the tempo Meta Event
Sub EncodeTempo(MsQN As Int) As Byte()
	Dim Result(3) As Byte
	Result(0) = Bit.ShiftRight(MsQN,16)
	Result(1) = Bit.ShiftRight(MsQN,8)
	Result(2) = MsQN
	Return Result
End Sub

Sub DecodeTempo(Bytes() As Byte) As Int
	Dim Tempo As Int = Bit.OR( _
	Bit.OR( _ 
	Bit.AND(Bytes(2), 0xFF) , _
	Bit.ShiftLeft( Bit.AND(Bytes(1), 0xFF) , 8)), _
	Bit.ShiftLeft(Bit.AND(Bytes(0), 0xFF), 16))
	Return MidiUtils.ConvertTempo(Tempo)
End Sub

'Tempo is BPM or MicrosecondsPerQuarternote(usPQ)
Sub ConvertTempo(Tempo As Double) As Double
	If Tempo <= 0 Then Tempo = 1
	Return MICROSECONDS_PER_MINUTE / Tempo
End Sub