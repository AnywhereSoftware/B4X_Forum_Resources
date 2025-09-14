B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' BroadcastBuddyOTP.bas
Private Sub Class_Globals
	Private base As BroadcastBuddyBase
End Sub

Public Sub Initialize(apiKey As String)
	base.Initialize(apiKey)
End Sub

'Generates OTP
Public Sub GenerateOTP As ResumableSub
	Dim sf As Object = base.MakeRequest("otp/generate", "GET", Null)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

'Verifies OTP
Public Sub VerifyOTP(code As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("code", code)
	Dim sf As Object = base.MakeRequest("otp/verify", "GET", data)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub
