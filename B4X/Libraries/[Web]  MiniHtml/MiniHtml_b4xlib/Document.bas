B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private mFlat         As Boolean
	Private mBuilder      As StringBuilder
	Private mIndents      As Int
	Private mIndentString As String
End Sub

Public Sub Initialize
	mBuilder.Initialize
	mIndentString = "  "
End Sub

' Set amount of Indent
Public Sub setIndents (Value As Int)
	mIndents = Value
End Sub

' Set Indent String
' Default = "  " (2 whitespaes)
Public Sub setIndentString (Value As String)
	mIndentString = Value
End Sub

' set to true for no indents and CRLF
Public Sub setFlat (Value As Boolean)
	mFlat = Value
End Sub

' Add Indent based on amount of Indent
Public Sub AddIndent
	If mFlat Then Return
	For n = 0 To mIndents - 1
		mBuilder.Append(mIndentString)
	Next
End Sub

' Add Indent by value
' Amount of Indent is not change
Public Sub AddIndent2 (Value As Int)
	If mFlat Then Return
	For n = 0 To Value - 1
		mBuilder.Append(mIndentString)
	Next
End Sub

' Increase amount of Indent
Public Sub IndentMore
	mIndents = mIndents + 1
End Sub

' Reduce amount of Indent
Public Sub IndentLess
	mIndents = mIndents - 1
End Sub

' Add raw text (No CRLF or Indent)
Public Sub Append (mText As String) As Document
	mBuilder.Append(mText)
	Return Me
End Sub

' Add raw text (Add CRLF and Indent)
Public Sub Append2 (mText As String) As Document
	If Not(mFlat) Then mBuilder.Append(CRLF)
	AddIndent
	mBuilder.Append(mText)
	Return Me
End Sub

' returns <code><!DOCTYPE html></code>
Public Sub AppendDocType
	mBuilder.Append($"<!DOCTYPE html>"$)
End Sub

Public Sub ToString As String
	Return mBuilder.ToString
End Sub