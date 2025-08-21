B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private fModule As String
	Private fMethod As String
	Private fError As Int
	Private fErrorStr As String	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	reset
End Sub

public Sub reset
	fModule=""
	fMethod=""
	fError=0
	fErrorStr=""
End Sub

public Sub raise(aModule As String,aMethod As String,aError As Int,aErrorStr As String,aToLog As Boolean)
	fModule=aModule
	fMethod=aMethod
	fError=aError
	fErrorStr=aErrorStr
	If aToLog Then
		Log(formatError)
	End If
	'raise an exception
	Dim i As Int
	i="abc"
End Sub

private Sub formatError As String
	Return $"Module [${fModule}]${CRLF}method [${fMethod}]${CRLF}error [#${fError}]${CRLF}message [${fErrorStr}]"$
End Sub

public Sub info As String
	Dim s As String=formatError
	Log(s)
	reset
	Return s
End Sub

