B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private mBuilder As StringBuilder
	Private mTabs As Int
	Private mFlat As Boolean
End Sub

Public Sub Initialize '(Name As String)
	mBuilder.Initialize
End Sub

Public Sub setTabs (Value As Int)
	mTabs = Value
End Sub

' set to true for no tabs and CRLF
Public Sub setFlat (Value As Boolean)
	mFlat = Value
End Sub

Public Sub AddTab
	If mFlat Then Return
	For n = 0 To mTabs - 1
		mBuilder.Append(TAB)
	Next
End Sub

Public Sub AddTabs (Value As Int)
	For n = 0 To Value - 1
		mBuilder.Append(TAB)
	Next
End Sub

Public Sub TabsIncrease
	mTabs = mTabs + 1
End Sub

Public Sub TabsDecrease
	mTabs = mTabs - 1
End Sub

' Add raw text
Public Sub Append (mText As String)
	AddTab
	mBuilder.Append(mText)
	If Not(mFlat) Then mBuilder.Append(CRLF)
End Sub

' returns <code><!DOCTYPE html></code>
Public Sub AppendDocType
	mBuilder.Append($"<!DOCTYPE html>"$)
	If Not(mFlat) Then mBuilder.Append(CRLF)
End Sub

Public Sub ToString As String
	Return mBuilder.ToString
End Sub