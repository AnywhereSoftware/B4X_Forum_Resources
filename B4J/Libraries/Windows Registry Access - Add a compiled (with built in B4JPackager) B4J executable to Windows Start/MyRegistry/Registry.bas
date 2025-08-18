B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub CheckAndAddInStartup(AddInLocalMachineForAllUsersFalseOnlyForCurrentUser As Boolean, ApplicationName As String, ExecutableNameAfterCreatingWithBuiltInB4JPackager11 As String)
	Dim sKey As String
	Dim jShell As Shell
	
	
	If AddInLocalMachineForAllUsersFalseOnlyForCurrentUser = False Then
		sKey = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"
	Else
		sKey = "HKEY_LOCAL_mACHINE\Software\Microsoft\Windows\CurrentVersion\Run"
	End If
	
	
	
	If CheckIfWindows = True Then
		Log("Checked OS: Windows")
		jShell.Initialize("js", "C:\Windows\System32\Reg.exe", Array As String("QUERY", sKey, "/v", ApplicationName))
	
		Dim shr As ShellSyncResult = jShell.RunSynchronous(3000)
	
		LogTheResult(shr)
	
		If shr.StdOut.Contains(ApplicationName) Then
			Log("Not adding anything")
		Else
			Try
				jShell.Initialize("js", "C:\Windows\System32\Reg.exe", Array As String("ADD", sKey, "/v", ApplicationName, "/d", File.Combine(File.GetFileParent(File.DirApp), ExecutableNameAfterCreatingWithBuiltInB4JPackager11) ))
				shr = jShell.RunSynchronous(3000)
				LogTheResult(shr)
			Catch
				Log(LastException)
			End Try

		End If
	Else
		Log("Checked OS: Not Windows")
	End If	

End Sub


Public Sub Delete (AddInLocalMachineForAllUsersFalseOnlyForCurrentUser As Boolean, ApplicationName As String)
	Dim sKey As String
	Dim jShell As Shell
	
	
	If AddInLocalMachineForAllUsersFalseOnlyForCurrentUser = False Then
		sKey = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"
	Else
		sKey = "HKEY_LOCAL_mACHINE\Software\Microsoft\Windows\CurrentVersion\Run"
	End If
	
	
	
	If CheckIfWindows = True Then
		Log("Checked OS: Windows")
		jShell.Initialize("js", "C:\Windows\System32\Reg.exe", Array As String("QUERY", sKey, "/v", ApplicationName))
	
		Dim shr As ShellSyncResult = jShell.RunSynchronous(3000)
		
		LogTheResult(shr)
		
		If shr.StdOut.Contains(ApplicationName) Then
			Try
				jShell.Initialize("js", "C:\Windows\System32\Reg.exe", Array As String("DELETE", sKey, "/v", ApplicationName, "/f"))
				shr = jShell.RunSynchronous(3000)
				LogTheResult(shr)
			Catch
				Log(LastException)
			End Try

		Else		
			Log("Not deleting anything")
		End If
	Else
		Log("Checked OS: Not Windows")
	End If
	
End Sub


Private Sub LogTheResult(shr As ShellSyncResult)
	Log("---stdout----")
	If shr.StdOut = "" Then 
		Log("----")
	Else
		Log(shr.StdOut)
	End If
	Log("---stderr----")
	If shr.Stderr = "" Then
		Log("----")
	Else
		Log(shr.StdErr)
	End If
End Sub


Private Sub CheckIfWindows As Boolean
	Return GetSystemProperty("os.name", "").ToLowerCase.Contains("windows")
End Sub