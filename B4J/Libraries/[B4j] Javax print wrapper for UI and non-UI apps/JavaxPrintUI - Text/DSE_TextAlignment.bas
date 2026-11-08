B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub SetTextAlignment(DesignerArgs As DesignerArgs)
	For i = 0 To DesignerArgs.Arguments.Size - 1
		Dim View As B4XView = DesignerArgs.GetViewFromArgs(i)
		Dim TA As String
		If View Is Button Then
			TA = View.As(Button).Alignment
		Else If View Is Label Then
			TA = View.As(Label).Alignment
		Else If View Is RadioButton Then
			TA = View.As(RadioButton).Alignment
		Else if View Is CheckBox Then
			TA = View.As(CheckBox).Alignment
		Else if View Is ToggleButton Then
			TA = View.As(ToggleButton).Alignment
		End If
		If TA <> "" Then
			View.As(JavaObject).RunMethod("setAlignment",Array(TA))
			Dim Pos As Int = TA.IndexOf("_")
			If Pos > -1 Then TA = TA.SubString(Pos+1)
			View.As(JavaObject).RunMethod("setTextAlignment",Array(TA))
		End If
	Next
End Sub