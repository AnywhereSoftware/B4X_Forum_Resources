B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
#Event: Stream(stream as BANanoObject)
#Event: Close()
#Event: Error(Err as BANanoObject)
Sub Class_Globals
	Private BANano As BANano 'ignore
	Private mMediaChannel As BANanoObject
	Private mCallBack As Object
	Private mEventName As String
End Sub

'Wraps WebRTC's media streams. To get one, use peer.call or listen for the call event.
Public Sub Initialize(callBack As Object, eventName As String, MediaChannel As BANanoObject)
	mCallBack = callBack
	mEventName = eventName.ToLowerCase
	mMediaChannel = MediaChannel
	
	Dim Stream As BANanoObject
	Dim err As BANanoObject
	
	mMediaChannel.RunMethod("on", Array("stream", BANano.CallBack(mCallBack, mEventName & "_stream", Array(Stream))))
	mMediaChannel.RunMethod("on", Array("close", BANano.CallBack(mCallBack, mEventName & "_close", Null)))
	mMediaChannel.RunMethod("on", Array("error", BANano.CallBack(mCallBack, mEventName & "_error", Array(err))))
End Sub

' When receiving a call event on a peer, you can call answer on the media connection provided by the callback
' to accept the call and optionally send your own media stream.
'
' Stream: A WebRTC media stream from <a href='https://developer.mozilla.org/en-US/docs/Web/API/Navigator.getUserMedia'>getUserMedia</a>
' sdpTransform: Function which runs before create answer to modify sdp answer message.
public Sub Answer(Stream As BANanoObject, sdpTransform As BANanoObject)
	If Stream = Null Then
		If sdpTransform <> Null Then
			Dim options As BANanoObject
			options.Initialize5
			options.SetField("sdpTransform", sdpTransform)
			mMediaChannel.RunMethod("answer", Array(options))
		Else
			mMediaChannel.RunMethod("answer", Null)
		End If		
	Else
		If sdpTransform <> Null Then
			Dim options As BANanoObject
			options.Initialize5
			options.SetField("sdpTransform", sdpTransform)
			mMediaChannel.RunMethod("answer", Array(Stream, options))
		Else
			mMediaChannel.RunMethod("answer", Array(Stream))
		End If		
	End If	
End Sub

' Closes the media connection.
public Sub Close()
	mMediaChannel.RunMethod("close", Null)
End Sub

' Any type of metadata associated with the connection, passed in by whoever initiated the connection.
public Sub getMetaData() As Object
	Return mMediaChannel.GetField("metadata")
End Sub

' Whether the media connection is active (e.g. your call has been answered). 
' You can check this if you want to set a maximum wait time for a one-sided call.
public Sub getOpen() As Boolean
	Return mMediaChannel.GetField("open").Result
End Sub

' The ID of the peer on the other end of this connection.
public Sub getPeer() As String
	Return mMediaChannel.GetField("peer").Result
End Sub

' For media connections, this is always 'media'.
public Sub getTypeData() As String
	Return mMediaChannel.GetField("type").Result
End Sub