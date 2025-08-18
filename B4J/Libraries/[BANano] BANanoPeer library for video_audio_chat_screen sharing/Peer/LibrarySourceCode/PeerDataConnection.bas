B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
#Event: Data(data as BANanoObject)
#Event: Open()
#Event: Close()
#Event: Error(Err as BANanoObject)
Sub Class_Globals
	Private BANano As BANano 'ignore	
	Private mDataChannel As BANanoObject
	Private mCallBack As Object
	Private mEventName As String
End Sub

' Wraps WebRTC's DataChannel. To get one, use peer.Connect or listen for the connect event
Public Sub Initialize(callBack As Object, eventName As String, DataChannel As BANanoObject)
	mCallBack = callBack
	mEventName = eventName.ToLowerCase
	mDataChannel = DataChannel
	
	Dim Data As BANanoObject
	Dim Err As BANanoObject
	
	mDataChannel.RunMethod("on", Array("data", BANano.CallBack(mCallBack, mEventName & "_data", Array(Data))))
	mDataChannel.RunMethod("on", Array("open", BANano.CallBack(mCallBack, mEventName & "_open", Null)))
	mDataChannel.RunMethod("on", Array("close", BANano.CallBack(mCallBack, mEventName & "_close", Null)))
	mDataChannel.RunMethod("on", Array("error", BANano.CallBack(mCallBack, mEventName & "_error", Array(Err))))
End Sub

' A reference to the RTCDataChannel object associated with the connection.
public Sub getDataChannel() As BANanoObject
	Return mDataChannel.GetField("dataChannel")
End Sub

' The optional label passed in or assigned by PeerJS when the connection was initiated.
public Sub getLabel() As String
	Return mDataChannel.GetField("label").Result
End Sub

' Any type of metadata associated with the connection, passed in by whoever initiated the connection.
public Sub getMetaData() As Object
	Return mDataChannel.GetField("metadata")
End Sub

' This is true if the connection is open and ready for read/write.
public Sub getOpen() As Boolean
	Return mDataChannel.GetField("open").Result
End Sub

' A reference to the RTCPeerConnection object associated with the connection.
public Sub getPeerConnection() As BANanoObject
	Return mDataChannel.GetField("peerConnection")
End Sub

' The ID of the peer on the other end of this connection.
public Sub getPeer() As String
	Return mDataChannel.GetField("peer").Result
End Sub

' Whether the underlying data channels are reliable; defined when the connection was initiated.
public Sub getReliable() As Boolean
	Return mDataChannel.GetField("reliable")
End Sub

' The serialization format of the data sent over the connection. Can be binary (default), binary-utf8, json or none.
public Sub getSerialization() As String
	Return mDataChannel.GetField("serialization").Result
End Sub

' For data connections, this is always 'data'.
public Sub getTypeData() As String
	Return mDataChannel.GetField("type").Result
End Sub

' The number of messages queued to be sent once the browser buffer is no longer full.
public Sub getBufferSize() As Long
	Return mDataChannel.GetField("bufferSize")
End Sub

' data is serialized by BinaryPack by default and sent to the remote peer.
' You can send any type of data, including objects, strings, and blobs.
public Sub Send(Data As Object)
	mDataChannel.RunMethod("send", Array(Data))
End Sub

'Closes the data connection gracefully, cleaning up underlying DataChannels and PeerConnections.
public Sub Close()
	mDataChannel.RunMethod("close", Null)
End Sub
