B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4.19
@EndOfDesignText@
Sub Process_Globals
 
End Sub
 
Sub GetBus(BusNumber As Int) As JavaObject
 
	Dim factory As JavaObject
	Return factory.InitializeStatic("com.pi4j.io.i2c.I2CFactory").RunMethodJO("getInstance", Array As Object(BusNumber))
 
End Sub
 
'Bus methods
Sub GetDevice(Bus As JavaObject, Address As Int) As JavaObject
 
	Return Bus.RunMethodJO("getDevice", Array As Object(Address))
 
End Sub
 
Sub CloseBus (Bus As JavaObject)
 
	Bus.RunMethod("close", Null)
 
End Sub
 
'Device methods
Sub Read(Device As JavaObject) As Int
 
	Return Device.RunMethod("read", Null)
 
End Sub
 
Sub Read2 (Device As JavaObject, Buffer() As Byte, Offset As Int, Size As Int) As Int
 
	Return Device.RunMethod("read", Array As Object(Buffer, Offset, Size))
 
End Sub
 
Sub Write(Device As JavaObject, b As Byte)
 
	Device.RunMethod("write", Array As Object(b))
 
End Sub
 
Sub Write2(Device As JavaObject, Buffer() As Byte, Offset As Int, Size As Int)
 
	Device.RunMethod("write", Array As Object(Buffer, Offset, Size))
 
End Sub
 