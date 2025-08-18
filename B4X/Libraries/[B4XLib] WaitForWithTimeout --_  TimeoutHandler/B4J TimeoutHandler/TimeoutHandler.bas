B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
' TimeoutHandler - class
' Version: 1.1	10/23/2019	Just added the description of the method with example code
' Version: 1.0	10/23/2019

Sub Class_Globals
#If B4J
	Private fx As JFX
#End If
End Sub

Public Sub Initialize
	
End Sub

'Callback - the calling module
'EventName - the event you are waiting for
'Cancel() - used to check if time is out
'Duration - the time out
'lblCoundDown (optional, you can pass Null) - to display the countdown
'Example:
'<code>
'	Dim Timeout As TimeoutHandler
'	Timeout.Initialize
'	Dim Canceled(1) As Boolean
'	Timeout.SetTimeout(Me, "CardPlayed", Canceled, 3, lblCountdown)
'	Wait For CardPlayed(ReturnedValue As Object)
'	If Not(Canceled(0)) Then
'		Canceled(0) = True
'		lblExecuted.Text = "Played: " & ReturnedValue
'	Else
'		lblExecuted.Text = "too slow"
'	End If
'</code>
Public Sub SetTimeout(Callback As Object, EventName As String, _
				Cancel() As Boolean, Duration As Int, lblCountdown As B4XView)
	Do While Duration > 0
		If lblCountdown.IsInitialized Then
			lblCountdown.Text = Duration
		End If
		Sleep(1000)
		If Cancel(0) Then Return
		Duration = Duration - 1
	Loop
	Cancel(0) = True
	CallSubDelayed2(Callback, EventName, Null)
End Sub