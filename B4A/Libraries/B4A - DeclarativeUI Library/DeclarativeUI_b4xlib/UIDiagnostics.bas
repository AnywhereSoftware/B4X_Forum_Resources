B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private mIssues As List
	Private mEnabled As Boolean
End Sub

' Creates an empty diagnostic collector.
Public Sub Initialize As UIDiagnostics
	mIssues.Initialize
	mEnabled = True
	Return Me
End Sub

' Enables or disables collection without changing the caller API.
Public Sub Enabled(Value As Boolean) As UIDiagnostics
	mEnabled = Value
	Return Me
End Sub

Public Sub IsEnabled As Boolean
	Return mEnabled
End Sub

' Records a recoverable error without throwing into the application.
Public Sub ReportError(Operation As String, Message As String) As UIDiagnostics
	AddIssue("error", Operation, Message)
	Return Me
End Sub

' Records a non-fatal warning.
Public Sub ReportWarning(Operation As String, Message As String) As UIDiagnostics
	AddIssue("warning", Operation, Message)
	Return Me
End Sub

Private Sub AddIssue(Severity As String, Operation As String, Message As String)
	If mEnabled = False Then Return
	If mIssues.IsInitialized = False Then mIssues.Initialize
	Dim issue As Map
	issue.Initialize
	issue.Put("Severity", Severity)
	issue.Put("Operation", Operation)
	issue.Put("Message", Message)
	mIssues.Add(issue)
End Sub

Public Sub HasIssues As Boolean
	If mIssues.IsInitialized = False Then Return False
	Return mIssues.Size > 0
End Sub

Public Sub IssueCount As Int
	If mIssues.IsInitialized = False Then Return 0
	Return mIssues.Size
End Sub

' Returns a snapshot so callers cannot mutate the internal collection.
Public Sub GetIssues As List
	Dim result As List
	result.Initialize
	If mIssues.IsInitialized = False Then Return result
	For Each issue As Map In mIssues
		Dim copy As Map
		copy.Initialize
		For Each key As String In issue.Keys
			copy.Put(key, issue.Get(key))
		Next
		result.Add(copy)
	Next
	Return result
End Sub

Public Sub GetLastIssue As Map
	Dim result As Map
	result.Initialize
	If mIssues.IsInitialized = False Then Return result
	If mIssues.Size = 0 Then Return result
	Dim issue As Map = mIssues.Get(mIssues.Size - 1)
	For Each key As String In issue.Keys
		result.Put(key, issue.Get(key))
	Next
	Return result
End Sub

Public Sub Clear
	If mIssues.IsInitialized Then mIssues.Clear
End Sub