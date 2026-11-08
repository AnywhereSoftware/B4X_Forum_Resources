Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.52
@EndOfDesignText@
#Event: NewText (Text As String)
#Event: Terminated

'version: 1.00
'Class module
Sub Class_Globals
	Private mTarget As Object
	Private mEventName As String
	Private astreams As AsyncStreams
	Public charset As String = "UTF8"
	Private sb As StringBuilder
End Sub

Public Sub Initialize (TargetModule As Object, EventName As String, In As InputStream, out As OutputStream)
	mTarget = TargetModule
	mEventName = EventName
	astreams.Initialize(In, out, "astreams")
	sb.Initialize
End Sub

'Sends the text. Note that this method does not add end of line characters.
Public Sub Write(Text As String)
	astreams.Write(Text.GetBytes(charset))
End Sub

Private Sub astreams_NewData (Buffer() As Byte)
	Dim newDataStart As Int = sb.Length
	sb.Append(BytesToString(Buffer, 0, Buffer.Length, charset))
	Dim s As String = sb.ToString
	Dim start As Int = 0
	For i = newDataStart To s.Length - 1
		Dim c As Char = s.CharAt(i)
			If i = 0 And c = Chr(10) Then '\n...
			start = 1 'might be a broken end of line character
			Continue
		End If
		If c = Chr(10) Then '\n
			CallSubDelayed2(mTarget, mEventName & "_NewText", s.SubString2(start, i))
			start = i + 1
		Else If c = Chr(13) Then '\r
			CallSubDelayed2(mTarget, mEventName & "_NewText", s.SubString2(start, i))
			If i < s.Length - 1 And s.CharAt(i + 1) = Chr(10) Then '\r\n
				i = i + 1
			End If
			start = i + 1
		End If
	Next
	If start > 0 Then sb.Remove(0, start)
End Sub
Private Sub astreams_Terminated
	CallSubDelayed(mTarget, mEventName & "_Terminated")
End Sub

Private Sub astreams_Error
	Log("error: " & LastException)
	astreams.Close
	CallSubDelayed(mTarget, mEventName & "_Terminated")
End Sub

Public Sub Close
	astreams.Close
End Sub
