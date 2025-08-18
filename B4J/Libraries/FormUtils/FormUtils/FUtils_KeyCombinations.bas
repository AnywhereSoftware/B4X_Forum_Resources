Type=StaticCode
Version=5.9
ModulesStructureVersion=1
B4J=true
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Public Const KC_CONTROL As String = "Ctrl"
	Public Const KC_SHIFT As String = "Shift"
	Public Const KC_ALT As String = "Alt"
	Public Const KC_SHORTCUT As String = "Shortcut"
End Sub

Private Sub List(ShortCut As String)				'ignore
	Dim JO As JavaObject
	JO.InitializeStatic("javafx.scene.input.KeyCombination.Modifier")
	Dim KC As JavaObject
	KC.InitializeStatic("javafx.scene.input.KeyCombination")
	Log(KC.GetFieldJO(ShortCut).RunMethod("toString",Null))
End Sub

Public Sub GetKeyCombination(Combination() As String) As Object

	Dim KC As JavaObject
	KC.InitializeStatic("javafx.scene.input.KeyCombination")
	Dim KCS As String
	For i = 0 To Combination.Length - 1
		If i > 0 Then KCS = KCS & "+"
		KCS = KCS & Combination(i)
	Next
	Return KC.RunMethod("keyCombination",Array(KCS))
End Sub
