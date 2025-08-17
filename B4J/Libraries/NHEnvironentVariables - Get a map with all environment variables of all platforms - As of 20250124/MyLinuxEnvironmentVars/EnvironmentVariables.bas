B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Private Sub Class_Globals
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub GetTheEnvironmentVariables As Map
	Dim sOS As String = GetSystemProperty("os.name", "")
	
	
	Log(sOS)
	
'	Dim sReturn As String = $"HOSTNAME=f3850c6a7e0e
'	SHLVL=1
'	HOME=/root
'	TESTLETSSEE=123
'	JAVA_VERSION=19-ea+5
'	TERM=xterm
'	PATH=/opt/openjdk-19/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
'	JAVA_HOME=/opt/openjdk-19
'	PWD=/webapp"$
'	
	Dim m As Map

	m.Initialize
	
	Select Case True
		Case sOS.ToLowerCase.Contains("linux")
			Dim js As Shell
			js.Initialize("js", "/usr/bin/env", Null)
			Dim jsrs As ShellSyncResult  = js.RunSynchronous(1500)
			Dim sEnvVars As String = jsrs.StdOut
			Log(sEnvVars)
			m = GetKeyValuePairsFromString(sEnvVars)
		Case sOS.ToLowerCase.Contains("win")
			Dim js As Shell
			js.Initialize("js", "cmd", Array As String ("/c", "set"))
			Dim jsrs As ShellSyncResult  = js.RunSynchronous(1500)
			Dim sEnvVars As String = jsrs.StdOut
			Log(sEnvVars)
			m = GetKeyValuePairsFromString(sEnvVars)
		Case sOS.ToLowerCase.Contains("mac")
			Dim js As Shell
			js.Initialize("js", "/usr/bin/printenv", Null)
			Dim jsrs As ShellSyncResult  = js.RunSynchronous(1500)
			Dim sEnvVars As String = jsrs.StdOut
			Log(sEnvVars)
			m = GetKeyValuePairsFromString(sEnvVars)
		Case Else
			'
	End Select
	
	Return m
End Sub


Private Sub GetKeyValuePairsFromString(KeyValuePairsString As String) As Map
	Private mRet As Map
	mRet.Initialize
	Dim sSplitted() As String = Regex.Split(Chr(10), KeyValuePairsString)
	For Each line As String In sSplitted
		Dim s() As String = Regex.Split("=", line.Trim)
		mRet.Put(s(0), s(1))
	Next
	Return mRet
End Sub
