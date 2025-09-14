B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private Tjo As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	Tjo.InitializeNewInstance("javax.swing.JTextArea",Null)
End Sub

Public Sub SetFont(Font As AWTFont)
	Tjo.RunMethod("setFont",Array(Font.GetObject))
End Sub
Public Sub SetBackground(Color As AWTColor)
	Tjo.RunMethod("setBackground",Array(Color.GetObject))
End Sub

Public Sub SetForeground(Color As AWTColor)
	Tjo.RunMethod("setForeground",Array(Color.GetObject))
End Sub

Public Sub SetLineWrap(State As Boolean)
	Tjo.RunMethod("setLineWrap",Array(State))
End Sub

Public Sub GetPrintable As Object
	Return Tjo.RunMethod("getPrintable",Array(Null,Null))
End Sub

Public Sub SetWrapStyleWord(State As Boolean)
	Tjo.RunMethod("setWrapStyleWord",Array(State))
End Sub

Public Sub SetText(Text As String)
	Tjo.RunMethod("setText",Array(Text))
End Sub


Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

Public Sub GetObject As Object
	Return Tjo
End Sub