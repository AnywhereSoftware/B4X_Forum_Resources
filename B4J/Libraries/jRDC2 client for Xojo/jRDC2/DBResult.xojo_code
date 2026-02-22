#tag Class
Protected Class DBResult
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Columns = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDeserialized(obj As Variant) As DBResult
		  Dim result As New DBResult
		  
		  ' The server returns a B4XType with ClassName "dbresult"
		  ' whose Fields contain "Columns" and "Rows".
		  ' After deserialization it could be a B4XType or a Dictionary.
		  
		  Dim fields As Dictionary
		  If obj IsA B4XType Then
		    fields = B4XType(obj).Fields
		  ElseIf obj IsA Dictionary Then
		    fields = Dictionary(obj)
		  Else
		    Raise New RuntimeException("Unexpected result type from server")
		  End If
		  
		  ' Columns
		  If fields.HasKey("Columns") Then
		    Dim colObj As Variant = fields.Value("Columns")
		    If colObj IsA Dictionary Then
		      result.Columns = Dictionary(colObj)
		    End If
		  End If
		  
		  ' Rows — a list (Variant array) of object arrays
		  If fields.HasKey("Rows") Then
		    Dim rowsObj As Variant = fields.Value("Rows")
		    If Not rowsObj.IsNull And rowsObj.IsArray Then
		      Dim rowArr() As Variant = rowsObj
		      For i As Integer = 0 To rowArr.LastIndex
		        result.Rows.Add(rowArr(i))
		      Next
		    End If
		  End If
		  
		  Return result
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Columns As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Rows() As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		Tag As Variant
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
