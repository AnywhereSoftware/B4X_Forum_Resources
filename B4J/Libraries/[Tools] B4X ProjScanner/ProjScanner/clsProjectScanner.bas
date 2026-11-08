B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'#############################################################
'# clsProjectScanner.bas
'# Scans all source files of a B4X project (simple or B4XPages)
'#############################################################

#Region VERSIONS
' v. 1.0	09/03/2026
#End Region

Sub Class_Globals
	Type tFileResult(FileName As String, Vars As List, Subs As List, Consts As List)
	Private mFiles As List
End Sub

Public Sub Initialize
	' Initialize internal list of parsed files
	mFiles.Initialize
End Sub

'===========================================================
' Main entry point: scans an entire B4X project directory
'===========================================================
Public Sub ScanProject(ProjectDir As String) As List
	Dim AllFiles As List
	AllFiles.Initialize

	' Detect whether this is a B4XPages project
	Dim IsB4XPages As Boolean = File.Exists(ProjectDir, "B4XMainPage.bas")

	If IsB4XPages Then
		' 1) Add B4XMainPage.bas explicitly
		Dim FP As String = File.Combine(ProjectDir, "B4XMainPage.bas")
		If AllFiles.IndexOf(FP) = -1 Then AllFiles.Add(FP)

		' 2) Add files from platform-specific subprojects
		Dim Platforms() As String = Array As String("B4A", "B4J", "B4I")
		For Each Plat As String In Platforms
			Dim PlatDir As String = File.Combine(ProjectDir, Plat)
			If File.IsDirectory(ProjectDir, Plat) Then
				Dim PlatFiles As List = FindAllSourceFiles(PlatDir)
				For Each F As String In PlatFiles
					If AllFiles.IndexOf(F) = -1 Then AllFiles.Add(F)
				Next
			End If
		Next

	Else
		' Simple project: scan only the main directory
		AllFiles = FindAllSourceFiles(ProjectDir)
	End If

	'===========================================================
	' Parse all collected source files
	'===========================================================
	For Each FullPath As String In AllFiles
		Dim Dir As String = File.GetFileParent(FullPath)
		Dim Name As String = File.GetName(FullPath)

		Dim Parser As clsB4XSourceParser
		Parser.Initialize

		Dim ParseResult As tResult = Parser.ParseBasFile(Dir, Name)
		If ParseResult <> Null Then
			Dim FileResult As tFileResult
			FileResult.Initialize
			FileResult.FileName = FullPath
			FileResult.Vars = ParseResult.Vars
			FileResult.Subs = ParseResult.Subs
			FileResult.Consts = ParseResult.Consts

			mFiles.Add(FileResult)
		End If
	Next

	Return mFiles
End Sub

'===========================================================
' Finds all source files in a project directory
'===========================================================
Private Sub FindAllSourceFiles(ProjectDir As String) As List
	Dim ResultList As List
	ResultList.Initialize

	Dim DirectoryFiles As List = File.ListFiles(ProjectDir)

	' 1) Local source files (.bas, .b4a, .b4j, .b4i)
	For Each FileName As String In DirectoryFiles
		Dim LowerName As String = FileName.ToLowerCase
		If LowerName.EndsWith(".bas") Or LowerName.EndsWith(".b4j") Or LowerName.EndsWith(".b4a") Or LowerName.EndsWith(".b4i") Then
			Dim FullPath As String = File.Combine(ProjectDir, FileName)
			If ResultList.IndexOf(FullPath) = -1 Then ResultList.Add(FullPath)
		End If
	Next

	' 2) Detect project file (.b4j/.b4a/.b4i)
	Dim ProjectFile As String = ""
	For Each FileName As String In DirectoryFiles
		Dim L As String = FileName.ToLowerCase
		If L.EndsWith(".b4j") Or L.EndsWith(".b4a") Or L.EndsWith(".b4i") Then
			ProjectFile = FileName
			Exit
		End If
	Next

	If ProjectFile = "" Then Return ResultList

	' 3) Read project header and extract ModuleX entries
	Dim Lines As List = File.ReadList(ProjectDir, ProjectFile)
	For Each Line As String In Lines
		If Line.StartsWith("@EndOfDesignText@") Then Exit

		If Line.StartsWith("Module") Then
			Dim Parts() As String = Regex.Split("=", Line)
			If Parts.Length > 1 Then
				Dim PathPart As String = Parts(1).Trim
				Dim FullPath As String

				' Resolve relative/absolute module paths
				If PathPart.StartsWith("|relative|") Then
					Dim Rel As String = PathPart.Replace("|relative|", "")
					FullPath = ResolveRelativePath(ProjectDir, Rel)
				Else If PathPart.StartsWith("|absolute|") Then
					FullPath = PathPart.Replace("|absolute|", "")
				Else
					FullPath = File.Combine(ProjectDir, PathPart)
				End If

				FullPath = FullPath & ".bas"

				Dim Dir As String = File.GetFileParent(FullPath)
				Dim Name As String = File.GetName(FullPath)

				' Add module file if it exists
				If File.Exists(Dir, Name) Then
					If ResultList.IndexOf(FullPath) = -1 Then ResultList.Add(FullPath)
				End If
			End If
		End If
	Next

	' Move the project file to the first position
	Dim ProjectFullPath As String = File.Combine(ProjectDir, ProjectFile)
	Dim Index As Int = ResultList.IndexOf(ProjectFullPath)
	If Index > 0 Then
		Dim Temp As String = ResultList.Get(0)
		ResultList.Set(0, ProjectFullPath)
		ResultList.Set(Index, Temp)
	End If

	Return ResultList
End Sub

'===========================================================
' Resolves ".." and "." in relative paths
'===========================================================
Private Sub ResolveRelativePath(BaseDir As String, Relative As String) As String
	Dim Parts() As String = Regex.Split("\\", Relative)
	Dim Current As String = BaseDir

	For Each Part As String In Parts
		Part = Part.Trim
		If Part = "" Or Part = "." Then
			' Same folder, no change
		Else If Part = ".." Then
			' Move up one directory
			Current = File.GetFileParent(Current)
		Else
			' Append subdirectory
			Current = File.Combine(Current, Part)
		End If
	Next

	Return Current
End Sub
