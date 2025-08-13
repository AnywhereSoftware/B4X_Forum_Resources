B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.5
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

Public Sub LogViewLayout(Name As String,V As B4XView)
	Log($"***** ${Name}:"$)
	Log($"Left ${V.Left}, Top ${V.Top}, Width ${V.Width} Height${V.Height}"$)
End Sub

Public Sub isMac As Boolean
	Dim S As String = GetSystemProperty("os.name","").ToLowerCase
	If S.IndexOf("mac") > -1 Then Return True
	Return False
End Sub

Public Sub isWindows As Boolean
	Dim S As String = GetSystemProperty("os.name","").ToLowerCase
	If S.IndexOf("win") > -1 Then Return True
	Return False
End Sub

Public Sub isSolaris As Boolean
	Dim S As String = GetSystemProperty("os.name","").ToLowerCase
	If S.IndexOf("sunos") > -1 Then Return True
	Return False
End Sub
	
Public Sub isUnix As Boolean
	Dim S As String = GetSystemProperty("os.name","").ToLowerCase
	If S.IndexOf("nix") > -1 Or S.IndexOf("nux") > -1 Or S.IndexOf("aix") > -1 Then Return True
	Return False
End Sub

Public Sub LogTime(Msg As String)
	
	Log(DateTime.Time(DateTime.Now) & " : " & Msg)
End Sub

Public Sub LinuxDesktop As String
	If isUnix = False Then Return ""
	Dim Info As String = GetEnvironmentVariable("XDG_CURRENT_DESKTOP","None")
	Return Info
End Sub