B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private TxtFolder As B4XView
	Private AARFile, JarFile As String
	Private TempAarDir, TempClassesDir As String
	Private PackageFolder As String
	Private ShAar, ShClasses, ShUpdate As Shell
End Sub

Public Sub Initialize
End Sub

Public Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	B4XPages.SetTitle(Me, "Merge AAR → JAR")
	B4XPages.GetNativeParent(Me).Icon = XUI.LoadBitmap(File.DirAssets, "merge.png")

	'Check if JDK is available
	Dim ShCheck As Shell
		ShCheck.Initialize("shCheck", "jar", Array("--version"))
		ShCheck.Run(10000) 'Timeout after 10 seconds
End Sub

Private Sub btnSelectAAR_Click
	Dim FC As FileChooser
		FC.Initialize
		FC.SetExtensionFilter("AAR Files", Array("*.aar"))

	Dim f As String = FC.ShowOpen(Main.MainForm)
	If f <> "" Then
		AARFile = f
		XUI.MsgboxAsync("Selected AAR:" & CRLF & AARFile, "Info")
	End If
End Sub

Private Sub btnSelectJar_Click
	Dim FC As FileChooser
		FC.Initialize
		FC.SetExtensionFilter("JAR Files", Array("*.jar"))

	Dim f As String = FC.ShowOpen(Main.MainForm)
	If f <> "" Then
		JarFile = f
		XUI.MsgboxAsync("Selected JAR:" & CRLF & JarFile, "Info")
	End If
End Sub

Private Sub IsValidPackageFolder(s As String) As Boolean
	If s.Length = 0 Then Return False
	If s.StartsWith("/") Or s.EndsWith("/") Then Return False
	If s.Contains("\") Then Return False
	If s.Contains(" ") Then Return False
	If s.Contains("//") Then Return False

	'Each segment must start with a letter or underscore
	Dim parts() As String = Regex.Split("/", s)
	For Each p As String In parts
		If p.Length = 0 Then Return False
		If Regex.IsMatch("^[A-Za-z_][A-Za-z0-9_]*$", p) = False Then Return False
	Next
	Return True
End Sub

Private Sub BtnMarge_Click
	Dim FolderName As String = TxtFolder.Text.Trim

	If AARFile = "" Then
		XUI.MsgboxAsync("Please select the source AAR file before merging.", "Error")
		Return
	End If

	If JarFile = "" Then
		XUI.MsgboxAsync("Please select the target JAR file before merging.", "Error")
		Return
	End If

	If FolderName = "" Then
		XUI.MsgboxAsync("Please enter the Subpackage folder name (for example: hoho).", "Error")
		Return
	End If

	If IsValidPackageFolder(FolderName) = False Then
		XUI.MsgboxAsync("Invalid package folder name." & CRLF & _
        "Examples:" & CRLF & _
        "  hoho" & CRLF & _
        "  google/android/gms" & CRLF & _
        "  example/lib/core", "Error")
		Return
	End If

	'Subpackage name, e.g. "hoho"
	PackageFolder = FolderName

	'Create temp dirs
	Dim TempAarName As String = "aar_extract_" & Rnd(10000, 99999)
	TempAarDir = File.Combine(File.DirTemp, TempAarName)
	File.MakeDir(File.DirTemp, TempAarName)

	Dim TempClassesName As String = "classes_extract_" & Rnd(10000, 99999)
	TempClassesDir = File.Combine(File.DirTemp, TempClassesName)
	File.MakeDir(File.DirTemp, TempClassesName)

	'Copy AAR into temp as lib.aar
	File.Copy(File.GetFileParent(AARFile), File.GetName(AARFile), TempAarDir, "lib.aar")

	'Step 1: Extract classes.jar from AAR
	'IMPORTANT: Java JDK needs to be installed for this line to work.
	'Everything hinges on this line, the line launches the Java jar executable.
	ShAar.Initialize("shAar", "jar", Array("xf", "lib.aar"))
	ShAar.WorkingDirectory = TempAarDir
	ShAar.Run(-1)
End Sub

'Step 1 completion: AAR extracted
Private Sub shAar_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	If Success = False Or ExitCode <> 0 Then
		XUI.MsgboxAsync("Failed to extract AAR." & CRLF & "ExitCode: " & ExitCode & CRLF & StdErr, "Error")
		Return
	End If

	If File.Exists(TempAarDir, "classes.jar") = False Then
		XUI.MsgboxAsync("classes.jar was not found after extracting the AAR.", "Error")
		Return
	End If

	'Copy classes.jar to second temp folder
	File.Copy(TempAarDir, "classes.jar", TempClassesDir, "classes.jar")

	'Step 2: Extract com/<folder> from classes.jar
	Dim packagePath As String = "com/" & PackageFolder   'Example com/hoho
	ShClasses.Initialize("shClasses", "jar", Array("xf", "classes.jar", packagePath))
	ShClasses.WorkingDirectory = TempClassesDir
	ShClasses.Run(-1)
End Sub

'Step 2 completion: Package extracted from classes.jar
Private Sub shClasses_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	If Success = False Or ExitCode <> 0 Then
		XUI.MsgboxAsync("Failed to extract package from classes.jar." & CRLF & "ExitCode: " & ExitCode & CRLF & StdErr, "Error")
		Return
	End If

	If File.Exists(File.Combine(TempClassesDir, "com"), PackageFolder) = False Then
		XUI.MsgboxAsync("Folder com/" & PackageFolder & " was not found in classes.jar.", "Error")
		Return
	End If

	'Step 3: Update SLC JAR: add com/<folder> from temp ClassesDir
	ShUpdate.Initialize("shUpdate", "jar", Array("uf", JarFile, "-C", TempClassesDir, "com"))
	ShUpdate.Run(-1)
End Sub

'Step 3 completion: JAR updated
Private Sub shUpdate_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	If Success = False Or ExitCode <> 0 Then
		XUI.MsgboxAsync("Failed to update target JAR." & CRLF & "ExitCode: " & ExitCode & CRLF & StdErr, "Error")
		Return
	End If

	'Edit the XML next to the selected JAR
	Dim JarDir As String = File.GetFileParent(JarFile)
	Dim JarName As String = File.GetName(JarFile)
	Dim BaseName As String = JarName.SubString2(0, JarName.LastIndexOf("."))   'For example, only fetch ABC from ABC.jar
	Dim XMLName As String = BaseName & ".xml"

	If File.Exists(JarDir, XMLName) Then
		Dim XMLText As String = File.ReadString(JarDir, XMLName)

		'Normalise the selected name, could be ABC or ABC.aar
		Dim Selected As String = File.GetName(AARFile)

		'Derive both valid forms
		Dim NoExt As String = Selected
		If NoExt.Contains(".") Then NoExt = NoExt.SubString2(0, NoExt.LastIndexOf("."))

		Dim AsAAR As String = NoExt & ".aar"

		'Remove the entire line including its CRLF
		Dim Pattern As String = "(?im)^[ \t]*<dependsOn>\s*(" & NoExt & "|" & AsAAR & ")\s*</dependsOn>[ \t]*\r?\n" 'Regex pattern to remove the dependency (dependsOn) from the XML file
		Dim Cleaned As String = Regex.Replace(Pattern, XMLText, "")
		File.WriteString(JarDir, XMLName, Cleaned)
	End If

	XUI.MsgboxAsync("Updated JAR:" & CRLF & JarFile, "Merge complete")

	'Delete Temp Files and Folders
	Try
		DeleteFolderRecursive(TempAarDir) 
		DeleteFolderRecursive(TempClassesDir)
	Catch
		Log("Hmm, can't delete files and folders")
	End Try
End Sub

Private Sub DeleteFolderRecursive(Dir As String)
	Dim Files As List = File.ListFiles(Dir)
	For Each f As String In Files
		Dim p As String = File.Combine(Dir, f)

		If File.IsDirectory(Dir, f) Then
			DeleteFolderRecursive(p)
		Else
			File.Delete(Dir, f)
		End If
	Next

	'Now the folder is empty, delete it
	Dim Parent As String = File.GetFileParent(Dir)
	Dim Name As String = Dir.SubString(Dir.LastIndexOf("\") + 1)
	If File.Delete(Parent, Name) = False Then Log("Could not delete folder: " & Dir)
End Sub

Private Sub shCheck_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	If Success = False Or ExitCode <> 0 Then
		XUI.MsgboxAsync("Java JDK is required for this tool to work." & CRLF & _
            "The 'jar' command was not found." & CRLF & _
            "Please install a JDK and ensure it's on your PATH.", "Missing JDK")
	Else
		Log("Java JDK detected. Using version: " & StdOut.Trim)
	End If
End Sub
