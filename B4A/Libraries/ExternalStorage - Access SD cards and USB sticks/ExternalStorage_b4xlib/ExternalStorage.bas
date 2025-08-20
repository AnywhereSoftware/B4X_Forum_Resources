B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.81
@EndOfDesignText@
#Event: ExternalFolderAvailable
Sub Class_Globals
	Private ion As Object
	Private PersistantUri As String
	Public PreviousUriFileName As String = "PersistantUri"
	Private ctxt As JavaObject
	Private mCallback As Object
	Private mEventName As String
	Public Root As ExternalFile
	Type ExternalFile (Name As String, Length As Long, LastModified As Long, IsFolder As Boolean, Native As JavaObject)
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mCallback = Callback
	mEventName = EventName
	ctxt.InitializeContext
End Sub

'Lets the user pick a folder.
'Optionally using the previously selected folder.
Public Sub SelectDir (UsePreviouslySelectedIfAvailable As Boolean)
	If UsePreviouslySelectedIfAvailable And File.Exists(File.DirInternal, PreviousUriFileName) Then
		PersistantUri = File.ReadString(File.DirInternal, PreviousUriFileName)
		Dim list As List = ctxt.RunMethodJO("getContentResolver", Null).RunMethod("getPersistedUriPermissions", Null)
		If list.IsInitialized Then
			For Each uripermission As JavaObject In list
				Dim u As Uri = uripermission.RunMethod("getUri", Null)
				Dim temp As Object = u 
				Dim s As String = temp
				If s = PersistantUri And uripermission.RunMethod("isWritePermission", Null) = True Then
					Log("Can use persistant uri!")
					SetPickedDir
					Return
				End If
			Next
		End If
	End If
	Dim i As Intent
	i.Initialize("android.intent.action.OPEN_DOCUMENT_TREE", "")
	i.PutExtra("android.content.extra.SHOW_ADVANCED", True)
	StartActivityForResult(i)
End Sub

'List all files in the given folder.
Public Sub ListFiles (Folder As ExternalFile) As List
	Dim files() As Object = Folder.Native.RunMethod("listFiles", Null)
	Dim res As List
	res.Initialize
	For Each o As Object In files
		Dim f As JavaObject = o
		res.Add(DocumentFileToExternalFile(f))
	Next
	Return res
End Sub
'Finds the file with the given name.
'Returns an uninitialized ExternalFile if not found.
Public Sub FindFile (Parent As ExternalFile, Name As String) As ExternalFile
	Dim f As JavaObject = Parent.Native.RunMethod("findFile", Array(Name))
	Return DocumentFileToExternalFile(f)
End Sub

'Creates a new file.
Public Sub CreateNewFile (Parent As ExternalFile, Name As String) As ExternalFile
	Return DocumentFileToExternalFile(Parent.Native.RunMethod("createFile", Array("", Name)))
End Sub

'Creates a new folder.
Public Sub CreateNewDir (Parent As ExternalFile, Name As String) As ExternalFile
	Return DocumentFileToExternalFile(Parent.Native.RunMethod("createDirectory", Array(Name)))
End Sub

'Deletes the file.
Public Sub DeleteFile (EF As ExternalFile) As Boolean
	If EF.IsInitialized = False Then Return False
	Return EF.Native.RunMethod("delete", Null)
End Sub

'Open an output stream that writes to the file.
Public Sub OpenOutputStream(EF As ExternalFile) As OutputStream
	Return ctxt.RunMethodJO("getContentResolver", Null).RunMethod("openOutputStream", Array(EF.Native.RunMethod("getUri", Null)))
End Sub
'Open an input stream that reads from the file.
Public Sub OpenInputStream(EF As ExternalFile) As InputStream
	Return ctxt.RunMethodJO("getContentResolver", Null).RunMethod("openInputStream", Array(EF.Native.RunMethod("getUri", Null)))
End Sub

'Finds the file with the given name. If not found creates a new file.
Public Sub FindFileOrCreate (Parent As ExternalFile, Name As String) As ExternalFile
	Dim f As ExternalFile = FindFile(Parent, Name)
	If f.IsInitialized = False Then
		Return CreateNewFile(Parent, Name)
	Else
		Return f
	End If
End Sub

'Finds a file or folder with the given name. Creates a new folder if not exists.
Public Sub FindDirOrCreate(Parent As ExternalFile, Name As String) As ExternalFile
	Dim f As ExternalFile = FindFile(Parent, Name)
	If f.IsInitialized = False Then
		Return CreateNewDir(Parent, Name)
	Else
		Return f
	End If
End Sub


Private Sub DocumentFileToExternalFile (DocumentFile As JavaObject) As ExternalFile
	Dim ef As ExternalFile
	If DocumentFile.IsInitialized = False Then
		Return ef
	End If
	ef.Initialize
	ef.Name = DocumentFile.RunMethod("getName", Null)
	ef.Length = DocumentFile.RunMethod("length", Null)
	ef.IsFolder = DocumentFile.RunMethod("isDirectory", Null)
	ef.Native = DocumentFile
	ef.LastModified = DocumentFile.RunMethod("lastModified", Null)
	Return ef
End Sub

Private Sub SetPickedDir
	Root = DocumentFileToExternalFile(GetPickedDir(PersistantUri))
	CallSubDelayed(mCallback, mEventName & "_ExternalFolderAvailable")
End Sub

Private Sub ion_Event (MethodName As String, Args() As Object) As Object
	If -1 = Args(0) Then 'resultCode = RESULT_OK
		Dim i As Intent = Args(1)
		Dim jo As JavaObject = i
		Dim treeUri As Uri = jo.RunMethod("getData", Null)
		Dim takeFlags As Int = Bit.And(i.Flags, 3)
		ctxt.RunMethodJO("getContentResolver", Null).RunMethod("takePersistableUriPermission", Array(treeUri, takeFlags))
		Dim temp As Object = treeUri
		PersistantUri = temp
		File.WriteString(File.DirInternal, PreviousUriFileName, PersistantUri)
		Log(PersistantUri)
		SetPickedDir
	End If
	Return Null
End Sub



Private Sub GetPickedDir (uri As String) As JavaObject
	Dim DocumentFileStatic As JavaObject
	Dim treeUri As Uri
	treeUri.Parse(uri)
	Dim PickedDir As JavaObject = DocumentFileStatic.InitializeStatic("android.support.v4.provider.DocumentFile").RunMethod("fromTreeUri", Array(ctxt, treeUri))
	Return PickedDir
End Sub

Private Sub StartActivityForResult(i As Intent)
	Dim jo As JavaObject = GetBA
	ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)
	jo.RunMethod("startActivityForResult", Array As Object(ion, i))
End Sub

Private Sub GetBA As Object
	Dim jo As JavaObject = Me
	Return jo.RunMethod("getBA", Null)
End Sub