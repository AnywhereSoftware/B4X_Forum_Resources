B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
End Sub

'Allocates a new byte buffer.
Public Sub Allocate(Capacity As Int) As ByteBuffer
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.nio.ByteBuffer")
	Dim Wrapper As ByteBuffer
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("allocate",Array As Object(Capacity)))
	Return Wrapper
End Sub
'Allocates a new direct byte buffer.
Public Sub AllocateDirect(Capacity As Int) As ByteBuffer
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.nio.ByteBuffer")
	Dim Wrapper As ByteBuffer
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("allocateDirect",Array As Object(Capacity)))
	Return Wrapper
End Sub

'Wraps a byte array into a buffer.
Public Sub Wrap(TArray() As Byte) As ByteBuffer
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.nio.ByteBuffer")
	Dim Wrapper As ByteBuffer
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("wrap",Array As Object(TArray)))
	Return Wrapper
End Sub
'Wraps a byte array into a buffer.
Public Sub Wrap2(TArray() As Byte, Offset As Int, Length As Int) As ByteBuffer
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.nio.ByteBuffer")
	Dim Wrapper As ByteBuffer
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("wrap",Array As Object(TArray, Offset, Length)))
	Return Wrapper
End Sub