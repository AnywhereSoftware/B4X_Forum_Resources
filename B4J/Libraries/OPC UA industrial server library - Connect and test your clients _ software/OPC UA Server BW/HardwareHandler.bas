B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.5
@EndOfDesignText@
Sub Process_Globals
	
End Sub

' This method is dynamically invoked by the OPCUAவரின் Java wrapper when any variable changes value
Public Sub Write (VariableName As String, Value As Object)
	Log("Variable Changed: " & VariableName)
	Log("New Value: " & Value)
    
	' Handle specific variable triggers, such as your boolean example
	If VariableName = "MyBoolean" Then
		Dim boolVal As Boolean = Value
		If boolVal Then
			Log("MyBoolean is TRUE - Performing action (e.g. turning relay ON)")
			' Add your specific hardware control logic here
		Else
			Log("MyBoolean is FALSE - Performing action (e.g. turning relay OFF)")
			' Add your specific hardware control logic here
		End If
	End If
End Sub
