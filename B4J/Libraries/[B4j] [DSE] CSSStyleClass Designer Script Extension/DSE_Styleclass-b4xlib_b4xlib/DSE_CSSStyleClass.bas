B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'Parameters: ClassNames As String (Comma delimited), 1 or more Views comma delimited
'Designer Script : B4XMainPage.AddStyleClass("button-sl",Button1,Button2,Button3)
Public Sub AddStyleClass(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim ClassNames() As String = Regex.Split(",",DesignerArgs.Arguments.Get(0))
		For i = 1 To DesignerArgs.Arguments.Size - 1
			Dim V As Node = DesignerArgs.GetViewFromArgs(i)
			For Each ClassName As String In ClassNames
				ClassName = ClassName.Trim
				If V.StyleClasses.IndexOf(ClassName) = -1 Then
					V.StyleClasses.Add(ClassName)
				End If
			Next
		Next
	End If
End Sub