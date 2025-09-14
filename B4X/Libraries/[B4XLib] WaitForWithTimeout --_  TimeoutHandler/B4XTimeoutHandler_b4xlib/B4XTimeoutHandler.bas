B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.1
@EndOfDesignText@
'Static code module
' Version: 1.11	05/31/2020
'		"Converted" to code module - Creating a B4XLib.
'		Removed the "lblCoundDown feature".
'		Removed fx to create a B4XLib.
' Version: 1.10	10/23/2019	Just added the description of the method with example code
' Version: 1.00	10/23/2019

Sub Process_Globals
End Sub

'Callback - the calling module
'EventName - the event you are waiting for
'Cancel() - used to check if time is out
'Duration - the time out
'Example:
'<code>
'	Dim Canceled(1) As Boolean
'	B4XTimeoutHandler.SetTimeout(Me, "Answer", Canceled, 5)
'	Wait For Answer(ReturnedValue As Object)
'
'	If Not(Canceled(0)) Then
'		Canceled(0) = True
'		Log("Answer: " & ReturnedValue)
'	Else
'		Log("Time is out.")
'	End If
'</code>
Public Sub SetTimeout(Callback As Object, EventName As String, _
				Cancel() As Boolean, Duration As Int)
	Do While Duration > 0
		Sleep(1000)
		If Cancel(0) Then Return
		Duration = Duration - 1
	Loop
	Cancel(0) = True
	CallSubDelayed2(Callback, EventName, Null)
End Sub