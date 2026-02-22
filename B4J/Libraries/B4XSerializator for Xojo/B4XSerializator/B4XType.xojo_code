#tag Class
Protected Class B4XType
	#tag Method, Flags = &h0
		Sub Constructor(className As String, data As Dictionary)
		  Dim i As Integer = LastIndexOf(className, "$")
		  If i > -1 Then
		    className = className.Middle(i + 2)
		  ElseIf className.BeginsWith("_") Then
		    className = className.Middle(1)
		  Else
		    className = className.Lowercase
		  End If
		  Self.ClassName = className
		  Self.Fields = data
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LastIndexOf(s As String, search As String) As Integer
		  Dim result As Integer = -1
		  Dim pos As Integer = 0
		  Do
		    Dim found As Integer = s.IndexOf(pos, search)
		    If found < 0 Then Exit
		    result = found
		    pos = found + 1
		  Loop
		  Return result
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ClassName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Fields As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		WriteName As String
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
		#tag ViewProperty
			Name="ClassName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="WriteName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
