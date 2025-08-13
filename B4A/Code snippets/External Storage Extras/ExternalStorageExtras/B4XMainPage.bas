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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=ExternalStorageExtras.zip

#IgnoreWarnings: 34

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private Storage As ExternalStorage
	Private chkUsePreviouslySelected As CheckBox
	Private lblPath As Label
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Storage.Initialize (Me, "Storage")
	
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub btnPickFolder_Click
	
'	Dim perm As Boolean = Storage.HasPermisson
'	Dim foldsel As Boolean = Storage.IsStorageFolderSelected
	
	If Not(Storage.HasPermisson) Then
		MsgboxAsync("We show you a file manager, please select or create a new Root folder and select it.","Creating Root Folder")
		Wait For MsgBox_Result (Result As Int)
		
'		Storage.SelectDir(False)
'		Wait For Storage_ExternalFolderAvailable
	Else
		Log("Good. Root folder already exist: " & Storage.Root.Name)	
	End If
	
	Storage.SelectDir(chkUsePreviouslySelected.Checked)
	Wait For Storage_ExternalFolderAvailable
	
	lblPath.Text = "Root folder: " & Storage.Root.Name

	SaveStringExample
	ReadStringExample
    
	WriteListExample
	ReadListExample
    
	WriteMapExample
	ReadMapExample
    
	WriteTextWriter
	ReadTextReader
End Sub

''''''''''''''''''''''''''''''''''''
 
Sub SaveStringExample
	Storage.WriteString(Storage.Root, "String.txt", _
        "This is some string" & CRLF & "and this is another one.")
End Sub

Sub ReadStringExample
	Msgbox(Storage.ReadString(Storage.Root, "String.txt"), "")
End Sub

Sub WriteListExample
	Dim List1 As List
	List1.Initialize
	For i = 1 To 100
		List1.Add(i)
	Next
	Storage.WriteList(Storage.Root, "List.txt", List1)
End Sub

Sub ReadListExample
	Dim List1 As List
	' We are not initializing the list because it just holds the list that returns from File.ReadList
	List1 = Storage.ReadList(Storage.Root, "List.txt")
	Msgbox("List1.Size = " & List1.Size & CRLF & "The third item is: " & List1.Get(2), "")
End Sub

Sub WriteMapExample
	Dim Map1 As Map
	Map1.Initialize
	For i = 1 To 10
		Map1.Put("Key" & i, "Value" & i)
	Next
	Storage.WriteMap(Storage.Root, "Map.txt", Map1)
End Sub

Sub ReadMapExample
	Dim Map1 As Map
	'Again we are not initializing the map.
	Map1 = Storage.ReadMap(Storage.root, "Map.txt")
	'Append all entries to a string builder
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("The map entries are:").Append(CRLF)
	For i = 0 To Map1.Size - 1
		sb.Append("Key = ").Append(Map1.GetKeyAt(i)).Append(", Value = ")
		sb.Append(Map1.GetValueAt(i)).Append(CRLF)
	Next
	Msgbox(sb.ToString,"")
End Sub

Sub WriteTextWriter
	Dim Parent As ExternalFile = Storage.Root
	Dim FileName As String = "Text.txt"
	
	Parent = Storage.FindFileOrCreate(Parent, FileName)
	If Parent.IsInitialized Then
		Dim TextWriter1 As TextWriter
		TextWriter1.Initialize(Storage.OpenOutputStream(Parent))  ' Append False, magari usare CreateNewFile
		For i = 1 To 10
			TextWriter1.WriteLine("Line" & i)
		Next
		TextWriter1.Close
	Else
		LogColor("WriteTextWriter: Cannot write to file", Colors.Red)
	End If
End Sub

Sub ReadTextReader
	Dim Parent As ExternalFile = Storage.Root
	Dim FileName As String = "Text.txt"
		
	Parent = Storage.FindFile(Parent, FileName)  'FindFileOrCreate(Parent, FileName)
	If Parent.IsInitialized Then
		Dim TextReader1 As TextReader
		TextReader1.Initialize(Storage.OpenInputStream(Parent))
		'Append all lines to a string builder
		Dim sb As StringBuilder
		sb.Initialize
		sb.Append("The lines read by TextReader are:").Append(CRLF)
		Dim line As String
		line = TextReader1.ReadLine
		Do While line <> Null
			Log(line) ' Write the line to LogCat
			sb.Append(line).Append(CRLF)
			line = TextReader1.ReadLine
		Loop
		TextReader1.Close
		Msgbox(sb.ToString,"")
	Else
		LogColor("ReadTextReader: Cannot read from file", Colors.Red)
	End If
End Sub
