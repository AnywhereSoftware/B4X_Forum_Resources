B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

Public Sub Convert(PathTOFFMpeg As String, SourcePath As String,SourceFile As String,TargetPath As String,TargetFile As String)
	Dim Args As List
	Args.Initialize
			
	Args.AddAll(Array("-y","-i"))
	Args.AddAll(Array(File.Combine(SourcePath,SourceFile),File.Combine(TargetPath, TargetFile)))
		
	Dim Sh As Shell
	Sh.Initialize("SH",PathTOFFMpeg,Args)
	Sh.Run(-1)
		
	Wait For SH_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
		
'			Log("Success " & Success)
'			Log("Std Err" & StdErr)
'			Log("StdOut" & StdOut)
End Sub