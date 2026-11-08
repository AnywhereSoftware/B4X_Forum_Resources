B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'V2.00
Sub Class_Globals
	Private JavaExe As String
	Private Modules As List
	Private ReleaseJavaModules() As String
End Sub

Public Sub Initialize
	JavaExe = File.Combine(GetSystemProperty("java.home", ""), "bin/java")
End Sub

Private Sub FindModules As ResumableSub
	Modules.Initialize
	Dim shl As Shell
	shl.Initialize("jar", JavaExe, Array("--describe-module", "b4j"))
	shl.Run(-1)
	Wait For (shl) jar_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	Dim release As String
	If ExitCode = 0 Then
		Log("Running from standalone package. Collecting modules.")
		Dim m As Matcher = Regex.Matcher2("^contains\s(.*)$", Regex.MULTILINE, StdOut)
		Do While m.Find
			Modules.Add(m.Group(1))
		Loop
		release = File.ReadString(File.DirApp, "release_java_modules.txt")
	Else
		release = File.ReadString(File.DirAssets, "release_java_modules.txt")
	End If
	ReleaseJavaModules = Regex.Split("\s+", release)
	Return True
End Sub

'Kill all java processes where the jar name matches for non-ui apps, or the package name matches for ui apps. You can use GetJarKillName to find the correct name.
'Name - jar name (non-ui) or package name ending with '.main' (ui).
Public Sub KillJavaProcess(Name As String) As ResumableSub
	Dim folder As String = File.Combine(GetSystemProperty("java.home", ""), "bin")
	For Each j As String In Array("jps.exe", "jps")
		If File.Exists(folder, j) Then
			Wait For (KillJavaProcessWithJps(Name)) Complete (Counter As Int)
			Return Counter
		End If
	Next
	Wait For (KillJavaProcessWithPowerShell(Name)) Complete (Counter As Int)
	Return Counter
End Sub

Private Sub KillJavaProcessWithPowerShell(Name As String) As ResumableSub
	Wait For (PowerShellScript($"Get-CimInstance Win32_Process -Filter \"Name='java.exe'\" |  % { '{0} {1}' -f $_.ProcessId, $_.CommandLine}"$)) Complete (Result As ShellSyncResult)
	Dim counter As Int
	If Result.Success And Result.ExitCode = 0 Then
'		Log(Result.StdOut)
		Dim m As Matcher = Regex.Matcher2($"^\s*(\d+).*\Q${Name}\E"$, Regex.MULTILINE, Result.StdOut)
		Do While m.Find
			Dim pid As String = m.Group(1)
			Wait For (TaskKill(pid)) Complete (Success As Boolean)
			counter = counter + 1
		Loop
	End If
	Return counter
End Sub

Private Sub KillJavaProcessWithJps(Name As String) As ResumableSub
	Dim jps As String = File.Combine(GetSystemProperty("java.home", ""), "bin/jps")
	Dim shl As Shell
	shl.Initialize("jar", jps, Array("-l"))
	shl.Run(-1)
	Wait For (shl) jar_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	Log(StdOut)
	Dim counter As Int
	If Success And ExitCode = 0 Then
		Dim m As Matcher = Regex.Matcher2($"^(\d+).*\Q${Name}\E"$, Regex.MULTILINE, StdOut)
		Do While m.Find
			Dim pid As String = m.Group(1)
			Wait For (TaskKill(pid)) Complete (Success As Boolean)
			counter = counter + 1
		Loop
	End If
	Return counter
End Sub

Private Sub TaskKill (pid As String) As ResumableSub
	Dim tk As String = File.Combine(GetEnvironmentVariable("WINDIR", ""), "system32\taskkill.exe")
	If File.Exists(tk, "") = False Then
		LogError("TaskKill not found!")
		Return False
	End If
	Dim shl As Shell
	shl.Initialize("jar", tk, Array("/pid", pid, "/f"))
	shl.Run(-1)
	Wait For (shl) jar_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	Success = Success And ExitCode = 0
	Return Success
End Sub

'Get the name value that should be passed to KillJavaProcess method in order to kill running instances of this jar.
Public Sub GetJarKillName (Jar As String) As String
	Dim mc As String = GetJavaFXClass(Jar)
	If mc <> "" Then Return mc
	Return File.GetName(Jar)
End Sub

Private Sub GetJavaFXClass(Jar As String) As String
	Dim ManifestBytes() As Byte = UnzipEntry(Jar, "META-INF/MANIFEST.MF")
	If ManifestBytes.Length > 0 Then
		Dim manifest As String = BytesToString(ManifestBytes, 0, ManifestBytes.Length, "utf8")
		Dim m As Matcher = Regex.Matcher2("^JavaFX-Application-Class:\s(.*)$", Regex.MULTILINE, manifest)
		If m.Find Then
			Dim mainclass As String = m.Group(1)
			Return mainclass
		End If
		End If
	Return ""
End Sub

'Runs the executable jar. Returns a ShellSyncResult.
'Jar - Full path to the jar.
'Args - Optional arguments.
Public Sub RunJar(Jar As String, Args As List) As ResumableSub
	If Initialized(Modules) = False Then
		Wait For (FindModules) Complete (unused As Boolean)
	End If
	Dim MainClass As String = GetJavaFXClass(Jar)
	If MainClass <> "" Then
		Dim inner As List = B4XCollections.CreateList(Array("-cp", Jar))
		inner.AddAll(ReleaseJavaModules)
		If Modules.Size = 0 Then
			inner.Add("-p")
			inner.Add(File.Combine(GetSystemProperty("java.home", ""), "javafx\lib"))
		End If
		inner.Add(MainClass)
		Wait For (Run(inner, Args, File.GetFileParent(Jar))) Complete (Result As ShellSyncResult)
		Return Result
	End If
	Wait For (Run(Array("-jar", Jar), Args, File.GetFileParent(Jar))) Complete (Result As ShellSyncResult)
	Return Result
End Sub

Private Sub Run(InnerArgs As List, Args As List, WorkingDirectory As String) As ResumableSub
	Dim shl As Shell
	Dim NewArgs As List
	NewArgs.Initialize
	For Each module As String In Modules
		NewArgs.Add("--add-exports")
		NewArgs.Add("b4j/" & module & "=ALL-UNNAMED")
	Next
	NewArgs.Add("-Dfile.encoding=UTF-8")
	NewArgs.Add("-Dsun.stdout.encoding=UTF-8")
	NewArgs.Add("-Dsun.stderr.encoding=UTF-8")
	NewArgs.AddAll(InnerArgs)
	If Initialized(Args) Then NewArgs.AddAll(Args)
	shl.Initialize("jar", JavaExe, NewArgs)
	shl.WorkingDirectory = WorkingDirectory
	shl.Run(-1)
	Wait For (shl) jar_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	Dim res As ShellSyncResult
	res.ExitCode = ExitCode
	res.StdErr = StdErr
	res.StdOut = StdOut
	res.Success = Success
	Return res
End Sub

Private Sub UnzipEntry(ZipPath As String, Entry As String) As Byte()
	Dim result() As Byte
	Dim ZipFile As JavaObject
	ZipFile.InitializeNewInstance("java.util.zip.ZipFile", Array(ZipPath))
	Dim ZipEntry As JavaObject = ZipFile.RunMethod("getEntry", Array(Entry))
	If NotInitialized(ZipEntry) Then Return result
	result = Bit.InputStreamToBytes(ZipFile.RunMethod("getInputStream", Array(ZipEntry)))
	ZipFile.RunMethod("close", Null)
	Return result
End Sub

Private Sub PowerShellScript(s As String) As ResumableSub
'	s = s.Replace(CRLF, ";").Replace("""", "'")
	Dim shl As Shell
	shl.InitializeDoNotHandleQuotes("jar", "powershell.exe", Array("-Command", s))
	shl.Run(-1)
	Wait For (shl) jar_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	Dim res As ShellSyncResult
	res.ExitCode = ExitCode
	res.StdErr = StdErr
	res.StdOut = StdOut
	res.Success = Success
	If StdErr <> "" Then
		Log(StdErr)
		If ExitCode = 0 Then res.ExitCode = 1
	End If
	Return res
End Sub

