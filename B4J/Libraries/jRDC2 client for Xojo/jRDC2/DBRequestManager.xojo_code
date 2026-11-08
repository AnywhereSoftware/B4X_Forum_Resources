#tag Class
Protected Class DBRequestManager
	#tag Method, Flags = &h21
		Private Sub Conn_ContentReceived(sender As URLConnection, url As String, httpStatus As Integer, content As String)
		  RemoveHandler sender.ContentReceived, AddressOf Conn_ContentReceived
		  RemoveHandler sender.Error, AddressOf Conn_Error
		  
		  Dim info As Dictionary
		  If mPendingConnections.HasKey(sender) Then
		    info = Dictionary(mPendingConnections.Value(sender))
		    mPendingConnections.Remove(sender)
		  End If
		  
		  Dim tag As String
		  Dim method As String
		  If info <> Nil Then
		    tag = info.Value("Tag").StringValue
		    method = info.Value("Method").StringValue
		  End If
		  
		  If httpStatus >= 200 And httpStatus < 300 Then
		    Try
		      If method = "query2" Then
		        Dim mb As MemoryBlock = content
		        Dim responseBytes() As Byte
		        For i As Integer = 0 To mb.Size - 1
		          responseBytes.Add(mb.UInt8Value(i))
		        Next
		        
		        Dim obj As Variant = mSerializer.ConvertBytesToObject(responseBytes)
		        Dim result As DBResult = DBResult.FromDeserialized(obj)
		        result.Tag = tag
		        RaiseEvent QueryComplete(tag, True, result, "")
		      Else
		        RaiseEvent BatchComplete(tag, True, "")
		      End If
		    Catch e As RuntimeException
		      If method = "query2" Then
		        RaiseEvent QueryComplete(tag, False, Nil, e.Message)
		      Else
		        RaiseEvent BatchComplete(tag, False, e.Message)
		      End If
		    End Try
		  Else
		    If method = "query2" Then
		      RaiseEvent QueryComplete(tag, False, Nil, "HTTP " + Str(httpStatus))
		    Else
		      RaiseEvent BatchComplete(tag, False, "HTTP " + Str(httpStatus))
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Conn_Error(sender As URLConnection, e As RuntimeException)
		  RemoveHandler sender.ContentReceived, AddressOf Conn_ContentReceived
		  RemoveHandler sender.Error, AddressOf Conn_Error
		  
		  Dim info As Dictionary
		  Dim tag As String
		  Dim method As String
		  
		  If mPendingConnections.HasKey(sender) Then
		    info = Dictionary(mPendingConnections.Value(sender))
		    mPendingConnections.Remove(sender)
		    tag = info.Value("Tag").StringValue
		    method = info.Value("Method").StringValue
		  End If
		  
		  If method = "query2" Then
		    RaiseEvent QueryComplete(tag, False, Nil, e.Message)
		  Else
		    RaiseEvent BatchComplete(tag, False, e.Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ConnectorLink As String)
		  mLink = ConnectorLink
		  mSerializer = New B4XSerializator
		  mPendingConnections = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecuteBatch(commands As B4XList, tag As String)
		  Dim payload As New Dictionary
		  payload.Value("commands") = commands
		  payload.Value("version") = 2
		  
		  Dim data() As Byte = mSerializer.ConvertObjectToBytes(payload)
		  SendJob(data, tag, "batch2")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecuteCommand(cmd As DBCommand, tag As String)
		  Dim cmds As New B4XList
		  cmds.Add(cmd.ToB4XType())
		  ExecuteBatch(cmds, tag)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecuteQuery(cmd As DBCommand, limit As Integer, tag As String)
		  Dim payload As New Dictionary
		  payload.Value("command") = cmd.ToB4XType()
		  payload.Value("limit") = limit
		  payload.Value("version") = 2
		  
		  Dim data() As Byte = mSerializer.ConvertObjectToBytes(payload)
		  SendJob(data, tag, "query2")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrintTable(table As DBResult)
		  Dim sb As String
		  
		  For Each col As Variant In table.Columns.Keys
		    sb = sb + col.StringValue + Chr(9)
		  Next
		  System.DebugLog(sb)
		  
		  For i As Integer = 0 To table.Rows.LastIndex
		    Dim row() As Variant = table.Rows(i)
		    sb = ""
		    For Each cell As Variant In row
		      If Not cell.IsNull Then
		        sb = sb + cell.StringValue + Chr(9)
		      Else
		        sb = sb + "NULL" + Chr(9)
		      End If
		    Next
		    System.DebugLog(sb)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SendJob(data() As Byte, tag As String, method As String)
		  Dim conn As New URLConnection
		  
		  Dim info As New Dictionary
		  info.Value("Tag") = tag
		  info.Value("Method") = method
		  mPendingConnections.Value(conn) = info
		  
		  AddHandler conn.ContentReceived, AddressOf Conn_ContentReceived
		  AddHandler conn.Error, AddressOf Conn_Error
		  
		  Dim mb As New MemoryBlock(data.Count)
		  For i As Integer = 0 To data.LastIndex
		    mb.Byte(i) = data(i)
		  Next
		  
		  conn.SetRequestContent(mb, "application/octet-stream")
		  conn.Send("POST", mLink + "?method=" + method)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event BatchComplete(tag As String, success As Boolean, errorMessage As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event QueryComplete(tag As String, success As Boolean, result As DBResult, errorMessage As String)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mLink As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingConnections As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSerializer As B4XSerializator
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
