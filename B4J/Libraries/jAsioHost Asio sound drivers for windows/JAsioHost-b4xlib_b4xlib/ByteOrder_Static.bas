B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

'Constant denoting big-endian byte order.
Public Sub BIG_ENDIAN As ByteOrder
	Dim Wrapper As ByteOrder
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.nio.ByteOrder")
	Wrapper.SetObject(Tjo.GetField("BIG_ENDIAN"))
	Return Wrapper
End Sub

'Constant denoting little-endian byte order.
Public Sub LITTLE_ENDIAN As ByteOrder
	Dim Wrapper As ByteOrder
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.nio.ByteOrder")
	Wrapper.SetObject(Tjo.GetField("LITTLE_ENDIAN"))
	Return Wrapper
End Sub

'Retrieves the native byte order of the underlying platform.
Public Sub NativeOrder As ByteOrder
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.nio.ByteOrder")
	Dim Wrapper As ByteOrder
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("nativeOrder",Null))
	Return Wrapper
End Sub