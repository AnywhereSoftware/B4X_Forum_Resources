#tag Class
Protected Class DBCommand
	#tag Method, Flags = &h0
		Sub Constructor()
		  mHasParameters = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetParameters(params() As Variant)
		  ' Use this method to set parameters.
		  ' Direct array assignment won't track whether params were provided.
		  Parameters = params
		  mHasParameters = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToB4XType() As B4XType
		  Dim d As New Dictionary
		  d.Value("Name") = Self.Name
		  Dim paramList() As Variant
		  If Self.Parameters.Count > 0 Then
		    For i As Integer = 0 To Self.Parameters.LastIndex
		      paramList.Add(Self.Parameters(i))
		    Next
		  End If
		  ' Always send an array, never Nil
		  d.Value("Parameters") = paramList
		  Return New B4XType("_dbcommand", d)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Dim d As New Dictionary
		  d.Value("Name") = Self.Name
		  If mHasParameters And Self.Parameters.Count > 0 Then
		    Dim paramList() As Variant
		    For i As Integer = 0 To Self.Parameters.LastIndex
		      paramList.Add(Self.Parameters(i))
		    Next
		    d.Value("Parameters") = paramList
		  Else
		    d.Value("Parameters") = Nil
		  End If
		  Return d
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHasParameters As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Parameters() As Variant
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
