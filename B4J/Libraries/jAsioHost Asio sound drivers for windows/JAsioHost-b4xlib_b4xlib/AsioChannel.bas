B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
' The <code>AsioChannel</code> class represents an input Or output channel available form the
' ASIO driver. It provides information such As current state And sample Type. This class also
' encapsulates And makes available native audio buffers If it Is active. Convenience methods
' are also available To facilitate consuming audio.
Sub Class_Globals
	Private TJO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub getChannelIndex As Int
	Return TJO.RunMethod("getChannelIndex",Null)
End Sub

Public Sub IsInput As Boolean
	Return TJO.RunMethod("isInput",Null)
End Sub

Public Sub IsActive As Boolean
	Return TJO.RunMethod("isActive",Null)
End Sub

Public Sub GetChannelGroup As Int
	Return TJO.RunMethod("getChannelGroup",Null)
End Sub

Public Sub GetSampleType As String
	Return TJO.RunMethod("getSampleType",Null)
End Sub

Public Sub GetChannelName As String
	Return TJO.RunMethod("getChannelName",Null)
End Sub


'Returns the current buffer To Read Or Write from, with the position reset To zero. The endian-ness
' of the buffer And of the underlying system has been accounted For. Note that input buffers 
' <code>IsInput()</code> are Read-only.
Public Sub GetByteBuffer As JavaObject
	Return TJO.RunMethod("getByteBuffer",Null)
End Sub


'A convenience method To Write a <code>float</code> Array of samples To the output. The Array 
' values are expected To be bounded To the range of [-1,1]. The need To convert To the correct 
' sample Type Is abstracted. The <code>output</code> Array should be same size As the buffer.
' If it Is larger, Then a <code>BufferOverflowException</code> will be thrown. If it Is smaller,
' the buffer will be incompletely filled. 
' If the ASIO host does Not use <code>float</code>s To represent samples, Then the <code>AsioChannel</code>'s
' <code>ByteBuffer</code> should be directly manipulated. Use <code>GetByteBuffer</code> To access the buffer.
' @param output  A <code>float</code> Array To Write To the output.
Public Sub Write(Output() As Float)
	TJO.RunMethod("write",Array(Output))
End Sub

Public Sub Read(Input() As Float)
	TJO.RunMethod("Read",Array(Input))
End Sub

Public Sub Equals(Obj As Object) As Boolean
	Return TJO.RunMethod("equals",Array(Obj))
End Sub

Public Sub ToString As String
	Return TJO.RunMethod("toString",Null)
End Sub

Public Sub GetObject As Object
	Return TJO
End Sub

Public Sub SetObject(tObject As Object)
	TJO = tObject
End Sub