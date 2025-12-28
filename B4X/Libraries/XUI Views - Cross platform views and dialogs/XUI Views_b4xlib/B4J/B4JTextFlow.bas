B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private texts As List
	Private lastItem As JavaObject
End Sub

Public Sub Initialize
	Reset
End Sub

Public Sub Reset As B4JTextFlow
	texts.Initialize
	Return Me
End Sub

Public Sub Append(text As String) As B4JTextFlow
	Dim lastItem As JavaObject
	lastItem.InitializeNewInstance("javafx.scene.text.Text", Array(text))
	texts.Add(lastItem)
	Return Me
End Sub

Public Sub SetFont(Font As Font) As B4JTextFlow
	lastItem.RunMethod("setFont", Array(Font))
	Return Me
End Sub

Public Sub SetColor(Color As Int) As B4JTextFlow
	lastItem.RunMethod("setFill", Array(fx.Colors.From32Bit(Color)))
	Return Me	
End Sub

Public Sub SetUnderline(Underline As Boolean) As B4JTextFlow
	lastItem.RunMethod("setUnderline", Array(Underline))
	Return Me
End Sub

Public Sub SetStrikethrough(Strikethrough As Boolean) As B4JTextFlow
	lastItem.RunMethod("setStrikethrough", Array(Strikethrough))
	Return Me
End Sub



Public Sub CreateTextFlow As Pane
	Dim tf As JavaObject
	tf.InitializeNewInstance("javafx.scene.text.TextFlow", Null)
	tf.RunMethod("setTextAlignment", Array("CENTER"))
	tf.RunMethodJO("getChildren", Null).RunMethod("addAll", Array(texts))
	Return tf
End Sub