#tag Class
Protected Class jRDC2
	#tag Method, Flags = &h0
		Sub Cleanup()
		  ' Call this when you're done (e.g. Window.Closing)
		  If mRequestManager <> Nil Then
		    RemoveHandler mRequestManager.QueryComplete, AddressOf HandleQueryComplete
		    RemoveHandler mRequestManager.BatchComplete, AddressOf HandleBatchComplete
		    mRequestManager = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  ' empty — call Initialize to set up
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetRecord(command As String, parameters() As Variant, tag As String)
		  Dim cmd As New DBCommand
		  cmd.Name = command
		  If parameters.Count > 0 Then
		    cmd.SetParameters(parameters)
		  End If
		  mRequestManager.ExecuteQuery(cmd, 0, tag)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetRecordNoParams(command As String, tag As String)
		  Dim emptyParams() As Variant
		  GetRecord(command, emptyParams, tag)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleBatchComplete(sender As DBRequestManager, tag As String, success As Boolean, errorMessage As String)
		  Dim answer As New Dictionary
		  answer.Value("Tag") = tag
		  answer.Value("Success") = success
		  If success Then
		    answer.Value("Message") = "Command executed successfully"
		  Else
		    answer.Value("Error") = errorMessage
		  End If
		  RaiseEvent RequestComplete(answer)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleQueryComplete(sender As DBRequestManager, tag As String, success As Boolean, result As DBResult, errorMessage As String)
		  Dim answer As New Dictionary
		  answer.Value("Tag") = tag
		  answer.Value("Success") = success
		  If success Then
		    answer.Value("Data") = result
		    answer.Value("Message") = "Data have been read successfully"
		  Else
		    answer.Value("Error") = errorMessage
		  End If
		  RaiseEvent RequestComplete(answer)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialize(serverLink As String)
		  mServerLink = serverLink
		  mRequestManager = New DBRequestManager(mServerLink)
		  AddHandler mRequestManager.QueryComplete, AddressOf HandleQueryComplete
		  AddHandler mRequestManager.BatchComplete, AddressOf HandleBatchComplete
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertUpdateRecord(command As String, parameters() As Variant, tag As String)
		  Dim cmd As New DBCommand
		  cmd.Name = command
		  If parameters.Count > 0 Then
		    cmd.SetParameters(parameters)
		  End If
		  mRequestManager.ExecuteCommand(cmd, tag)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event RequestComplete(answer As Dictionary)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mRequestManager As DBRequestManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerLink As String
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
