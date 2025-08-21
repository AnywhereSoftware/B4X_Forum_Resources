B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@

Sub Class_Globals
	Private TempFolder As String
	Type Parameter (Name As String, VarType As String)
	Type Member (MemberType As String, Name As String, Comment As String, ReturnType As String, Parameters As List)
	Type Class (Name As String, ShortName As String, Comment As String, Events As B4XSet, Members As Map)
	Private CurrentComment As String
End Sub

Public Sub Initialize
	File.MakeDir(File.DirApp, "temp")
	TempFolder = File.Combine(File.DirApp, "temp")
End Sub

Public Sub ParseLib (b4xlib As String) As String
	PrepareFiles(b4xlib)
	Dim files As List
	files.Initialize
	Dim manifest(1) As String
	FindBasFiles(TempFolder, files, manifest)
	Dim classes As List
	classes.Initialize
	For Each f As String In files
		classes.Add(ParseModule(f))
	Next
	Dim ManifestMap As Map = CreateMap()
	If manifest(0) <> "" Then
		ManifestMap = ParseManifest(manifest(0))
	End If
	Return GenerateXML(classes, ManifestMap)
End Sub


Private Sub PrepareFiles (b4xlib As String)
	DeleteFolder(TempFolder)
	Dim a As Archiver
	a.UnZip("", b4xlib, TempFolder, "")
End Sub


Private Sub FindBasFiles (Folder As String, Files As List, Manifest() As String)
	For Each f As String In File.ListFiles(Folder)
		If File.IsDirectory(Folder, f) Then
			FindBasFiles(File.Combine(Folder, f), Files, Manifest)
		End If
		If f.ToLowerCase.EndsWith(".bas") Then Files.Add(File.Combine(Folder, f))
		If f.ToLowerCase = "manifest.txt" Then Manifest(0) = File.Combine(Folder, f)
	Next
End Sub


Private Sub DeleteFolder (folder As String)
	For Each f As String In File.ListFiles(folder)
		If File.IsDirectory(folder, f) Then
			DeleteFolder(File.Combine(folder, f))
		End If
		File.Delete(folder, f)
	Next
End Sub

Private Sub ParseManifest (FileName As String) As Map
	Dim res As Map = CreateMap()
	For Each line As String In File.ReadList(FileName, "")
		Dim m As Matcher = Regex.Matcher("^([^=]+)=(.*)$", line)
		If m.Find Then
			res.Put(m.Group(1).ToLowerCase, m.Group(2).Trim)
		End If
	Next
	Return res
End Sub

Private Sub ParseModule (FileName As String) As Class
	Dim cls As Class
	cls.Initialize
	cls.Members.Initialize
	cls.Events.Initialize
	Dim m As Matcher = Regex.Matcher2(".*\\([^\\]+)\.bas", Regex.CASE_INSENSITIVE, FileName)
	m.Find
	cls.Name = m.Group(1)
	cls.ShortName = cls.Name
	For Each line As String In File.ReadList(FileName, "")
		m = Regex.Matcher("^\s*'(.*)", line)
		If m.Find Then
			CurrentComment = CurrentComment & CRLF & m.Group(1).Trim
		Else If Regex.IsMatch2("^\s*public\s*sub\s+.*", Regex.CASE_INSENSITIVE, line) Then
			Dim member As Member = ParseSubLine(line)
			If member <> Null Then
				If cls.Members.ContainsKey(member.Name.ToLowerCase) = False Then
					cls.Members.Put(member.Name.ToLowerCase, member)
				Else if member.MemberType = "property" Then
					Dim ExistingProperty As Member = cls.Members.Get(member.Name.ToLowerCase)
					If ExistingProperty.MemberType = "property" Then
						If member.ReturnType <> "" Then ExistingProperty.ReturnType = member.ReturnType
						ExistingProperty.Parameters.AddAll(member.Parameters)
					End If
					
				End If
			End If
			CurrentComment = ""
		Else
			m = Regex.Matcher2("^\s*#Event:\s*(.*)$", Regex.CASE_INSENSITIVE, line)
			If m.Find Then
				cls.Events.Add(m.Group(1))
			Else
				m = Regex.Matcher2("^\s*public\s+([\w_]+)\s+as\s+([\w_]+)", Regex.CASE_INSENSITIVE, line)
				If m.Find Then
					Dim field As Member
					field.Initialize
					field.MemberType = "field"
					field.Name = m.Group(1)
					field.ReturnType = m.Group(2)
					field.Comment = CurrentComment
					cls.Members.Put(field.Name.ToLowerCase, field)
				End If
			End If
			
			CurrentComment = ""
		End If
	Next
	Return cls
End Sub

Private Sub ParseSubLine (Line As String) As Member
	Dim m As Matcher = Regex.Matcher2("^\s*public\s*sub\s+([^\s(]+)", Regex.CASE_INSENSITIVE, Line)
	If m.Find = False Then Return Null
	Dim member As Member
	member.Initialize
	member.MemberType = "method"
	member.Name = m.Group(1)
	If member.Name.StartsWith("get") Or member.Name.StartsWith("set") Then
		member.MemberType = "property"
		member.Name = member.Name.SubString(3)
	End If
	member.Parameters.Initialize
	member.Comment = CurrentComment.Trim
	Dim i1 As Int = Line.IndexOf("(")
	Dim i2 As Int = Line.LastIndexOf(")")
	If i1 > -1 And i2 > -1 Then
		m = Regex.Matcher2("([\w_]+)(?:\(\))?\s+as\s+([\w_]+)", Regex.CASE_INSENSITIVE, Line.SubString2(i1 + 1, i2))
		Do While m.Find
			Dim p As Parameter
			p.Initialize
			p.Name = m.Group(1)
			p.VarType = m.Group(2)
			member.Parameters.Add(p)
		Loop
		m = Regex.Matcher2("as\s+([\w_]+(?:\(\))?)$", Regex.CASE_INSENSITIVE, Line)
		If m.Find Then
			member.ReturnType = m.Group(1)
		End If
	Else
		m = Regex.Matcher2("as\s+([\w_]+(?:\(\))?)$", Regex.CASE_INSENSITIVE, Line)
		If m.Find Then
			member.ReturnType = m.Group(1)
		End If
	End If
	Return member
End Sub

Private Sub GenerateXML (Classes As List, ManifestMap As Map) As String
	Dim m2x As Map2Xml
	m2x.Initialize
	Dim LibraryAttributes As Map = CreateMap()
	LibraryAttributes.Put("NOTE", "This XML file should only be used for documentation purposes.")
	LibraryAttributes.Put("doclet-version-NOT-library-version", "0")
	Dim ClassesElements As List
	ClassesElements.Initialize
	For Each cls As Class In Classes
		Dim c As Map = CreateMap("name": cls.Name, "shortname": cls.ShortName)
		If cls.Events.Size > 0 Then
			c.Put("event", cls.Events.AsList)
		End If
		PutIfNotEmpty(c, "comment", cls.Comment)
		For Each t As String In Array("method", "field", "property")
			Dim members As List = AddMembers(cls.Members, t)
			If members.Size > 0 Then c.Put(t, members)
		Next
		ClassesElements.Add(c)
	Next
	LibraryAttributes.Put("class", ClassesElements)
	PutIfNotEmpty(LibraryAttributes, "version", ManifestMap.GetDefault("version", ""))
	PutIfNotEmpty(LibraryAttributes, "author", ManifestMap.GetDefault("author", ""))
	
	Return m2x.MapToXml(CreateMap("root": LibraryAttributes))
End Sub

Private Sub AddMembers (members As Map, MemberType As String) As List
	Dim res As List
	res.Initialize
	For Each Member As Member In members.Values
		If Member.MemberType <> MemberType Then Continue
		Dim m As Map = CreateMap("name": Member.Name, "comment": Member.Comment, "returntype": Member.ReturnType)
		If Member.Parameters.IsInitialized And Member.Parameters.Size > 0 Then
			Dim parameters As List
			parameters.Initialize
			For Each param As Parameter In Member.Parameters
				parameters.Add(CreateMap("name": param.Name, "type": param.VarType))
			Next
			m.Put("parameter", parameters)
		End If
		res.Add(m)
	Next
	Return res
End Sub

Private Sub PutIfNotEmpty(m As Map, key As String, value As String)
	value = value.Trim
	If value <> "" Then m.Put(key, value)
End Sub


