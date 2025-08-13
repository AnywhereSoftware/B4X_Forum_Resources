B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Dim TJO As JavaObject
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(PseudoClassName As String)
	Dim tPseudoClass As JavaObject
	tPseudoClass.InitializeStatic("javafx.css.PseudoClass")
	
	TJO = tPseudoClass.RunMethod("getPseudoClass",Array(PseudoClassName))
	
End Sub

Public Sub SetState(V As B4XView,State As Boolean)
	V.As(JavaObject).RunMethod("pseudoClassStateChanged",Array(TJO,State))
End Sub