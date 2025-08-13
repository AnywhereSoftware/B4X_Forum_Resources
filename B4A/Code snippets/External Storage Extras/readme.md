### External Storage Extras by max123
### 04/14/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143576/)

Hi all,  
  
Now that ExternalStorage is the only way to access a shared file in an app that need to be released on Google Play Store, I mixed this:  
<https://www.b4x.com/android/forum/threads/externalstorage-access-sd-cards-and-usb-sticks.90238/#content>  
with this:  
<https://www.b4x.com/android/forum/threads/text-files.6690/>  
  
adding these methods to original ExternalStorage class:  
  
**File.WriteString** - Writes the given text to a new file.  
**File.ReadString** - Reads a file and returns it content as a string.  
**File.WriteList** - Writes all values stored in a list to a file. All values are converted to string type if required. Each value will be stored in its own line.  
Note that if a value contains the new line character it will saved over more than one line and when you read it, it will be read as multiple items.  
**File.ReadList** - Reads a file and stores each line as an item in a list.  
**File.WriteMap -** Takes a map object which holds pairs of key and value elements and stores it in a text file. The file format is known as Java Properties file: [.properties - Wikipedia, the free encyclopedia](http://en.wikipedia.org/wiki/.properties)  
The file format is not too important unless the file is supposed to be edited manually. This format makes it easy to edit it manually.  
One common usage of File.WriteMap is to save a map of "settings" to a file.  
**File.ReadMap -** Reads a properties file and returns its key/value pairs as a Map object. Note that the order of entries returned might be different than the original order.  
  
Note that the class is inline in the project (taken from ExternalStorage b4xlib), if you like it you can put in the b4xlib.  
  
If you do not need to release app on Google Play Store consider this that is a better option:  
<https://www.b4x.com/android/forum/threads/manage-external-storage-access-internal-external-storage-sdk-30.130411/>  
  
I've attached the example project that works as in the second link but with ExternalStorage.  
  
I even added an useful method to copy files to external storage:  

```B4X
'Copy a file to External Storage.  
'Dir:   The current input file directory, eg. File.DirAssets etc.  
'Name:   The current input file name  
'Parent:   External Storage parent name (Directory where place a file)  
'Rename:   Optionally rename the output file. Pass "" to mantain original name.  
Public Sub CopyFileToExternalStorage (Dir As String, Name As String, Parent As ExternalFile, Rename As String) As Boolean  
    If File.Exists(Dir, Name) = False Then  
        Log("File do not exist while copy to External Storage: " & Name)  
        Return False  
    End If  
   
    Dim iStream As InputStream, oStream As OutputStream  
    Dim oFile As ExternalFile  
   
    If Rename <> "" Then  
        oFile = FindFileOrCreate(Parent, Rename)  ' Optionally rename output file, pass "" to Rename argument will mantain original name  
    Else  
        oFile = FindFileOrCreate(Parent, Name)  
    End If  
   
    If oFile.IsInitialized Then  
        iStream = File.OpenInput(Dir, Name)  
        oStream = OpenOutputStream(oFile)  
        File.copy2(iStream, oStream)  
        iStream.Close  
        oStream.Close  
        Return True  
    Else  
        Log("Cannot create file on External Storage: " & Name)  
        Return False  
    End If  
End Sub
```

  
  
**I have 2 questions here, I know that the class store a file with URIs in DirInternal, but how to know these at runtime ?**  
  
- If user not already granted a permisson (so we can show a messagebox to explain that need to select a folder, only if no permisson granted and before Storage.SelectDir)  
- If permisson already granted, but user removed the Root folder, eg with a file manager.  
  
Please, reply to my questions  
and enjoy with this code.  
  
Here a full class code:  

```B4X
#Event: ExternalFolderAvailable  
Private Sub Class_Globals  
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
    If UsePreviouslySelectedIfAvailable And File.Exists(File.DirInternal, PreviousUriFileName) Then     ' ORIGINALE  
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
  
#Region Private Subs  
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
#End Region  
  
'——————– MY ADDONS TO ORIGINAL CLASS ———————-  
  
'    External Storage text file addons.  
'  
'    Storage.ReadString - Reads a file and returns it content as a string. (OK)  
'    Storage.WriteString - Writes the given text to a new file. (OK)  
'  
'    Storage.ReadList - Reads a file and stores each line as an item in a list.  (OK)  
'    Storage.WriteList - Writes all values stored in a list to a file. (OK)  
'                     All values are converted to string type if required.  
'                          Each value will be stored in its own line.  
'                     Note that if a value contains the new line character it will saved over more than one line and when you read it,  
'                          it will be read as multiple items.  
'  
'  Storage.ReadMap - Reads a properties file and returns its key/value pairs as a map object. Note that the order of entries returned might be different than the original order.  
'    Storage.WriteMap - Takes a map object which holds pairs of key and value elements and stores it in a text file.  
'                    The file format is known as Java Properties file: .properties - Wikipedia, the free encyclopedia  
'                  The file format is not too important unless the file is supposed to be edited manually.  
'                  This format makes it easy to edit it manually.  
'                  One common usage of File.WriteMap is to save a map of "settings" to a file.  
  
'Reads the file and returns its content as a string.  
'Example:<code>  
'Dim text As String = Storage.ReadString(Storage.Root, "myfile.txt")</code>  
Public Sub ReadString (Parent As ExternalFile, Name As String) As String  
    If Parent.IsInitialized Then  
        Parent = FindFile(Parent, Name)  'FindFileOrCreate(Parent, Name)  
        If Parent.IsInitialized Then  
            Dim iStream As InputStream = OpenInputStream(Parent)  
            Dim b() As Byte = Bit.InputStreamToBytes(iStream)  
            Return BytesToString(b, 0, b.Length, "UTF-8")  
        Else  
            LogColor("CANNOT READ STRING FROM FILE", Colors.Red)  
            Return ""  
        End If  
    Else  
        LogColor("WRONG FOLDER WHILE READ STRING FROM FILE", Colors.Red)  
        Return ""  
    End If  
End Sub  
  
'Writes the given text to an existing or new file.  
'Example:<code>  
'Storage.WriteString(Storage.Root, "myfile.txt", "Some text here")</code>  
Public Sub WriteString (Parent As ExternalFile, Name As String, Text As String)  
    If Parent.IsInitialized Then  
        Parent = FindFileOrCreate(Parent, Name)  
        If Parent.IsInitialized Then  
            Dim iStream As InputStream  
            Dim oStream As OutputStream  
            Dim b() As Byte = Text.GetBytes("UTF8")  
            iStream.InitializeFromBytesArray(b, 0, b.Length)  
            oStream = OpenOutputStream(Parent)  
            File.Copy2(iStream, oStream)  
        Else  
            LogColor("CANNOT WRITE STRING TO FILE", Colors.Red)  
        End If  
    Else  
        LogColor("WRONG FOLDER WHILE WRITE STRING TO FILE", Colors.Red)  
    End If  
End Sub  
  
'Reads the entire file and returns a List with all lines (as strings).  
'Example:<code>  
'Dim List1 As List = Storage.ReadList(Storage.Root, "mylist.txt")  ' Use FindDirOrCreate to point another directory  
'For i = 0 to List1.Size - 1  
'   Log(List1.Get(i))  
'Next </code>  
Public Sub ReadList (Parent As ExternalFile, Name As String) As List  
    If Parent.IsInitialized Then  
        Parent = FindFile(Parent, Name)  ' FindFileOrCreate(Parent, Name)  
        If Parent.IsInitialized Then  
            Dim iStream As InputStream = OpenInputStream(Parent)  
            Dim b() As Byte = Bit.InputStreamToBytes(iStream)  
            Dim s As String = BytesToString(b, 0, b.Length, "UTF-8")  
            Dim components() As String = Regex.Split(CRLF, s) ' Split lines  
            Dim lineList As List  
            lineList.Initialize2(components)  
            Return lineList  
        Else  
            LogColor("CANNOT READ LIST FROM FILE", Colors.Red)  
            Return Null  
        End If  
    Else  
        LogColor("WRONG FOLDER WHILE READ LIST FROM FILE", Colors.Red)  
        Return Null  
    End If  
End Sub  
  
'Writes each item in the list as a single line.  
'Note that a value containing CRLF will be saved as two lines (which will return two item when read with ReadList).  
'All values will be converted to strings.  
'Example:<code>  
'Storage.WriteList(Storage.Root, "mylist.txt", List1)  ' Use FindDirOrCreate to point another directory</code>  
Public Sub WriteList (Parent As ExternalFile, Name As String, List As List)  
    If Parent.IsInitialized Then  
        Parent = FindFileOrCreate(Parent, Name)  
        If Parent.IsInitialized Then  
            Dim sb As StringBuilder  
            sb.Initialize  
            For Each line As String In List  
                sb.Append(line).Append(CRLF)  
            Next  
   
            Dim iStream As InputStream  
            Dim oStream As OutputStream  
            Dim b() As Byte = sb.ToString.GetBytes("UTF8")  
            iStream.InitializeFromBytesArray(b, 0, b.Length)  
            oStream = OpenOutputStream(Parent)  
            File.Copy2(iStream, oStream)  
        Else  
            LogColor("CANNOT WRITE LIST TO FILE", Colors.Red)  
        End If  
    Else  
        LogColor("WRONG FOLDER WHILE WRITE LIST TO FILE", Colors.Red)  
    End If  
End Sub  
  
'Reads the file and parses each line as a key-value pair (of strings).  
'See this link for more information about the actual format: <link>Properties format|http://en.wikipedia.org/wiki/.properties</link>.  
'You can use Storage.WriteMap to write a map to a file.  
'Note that the order of items in the map may not be the same as the order in the file.  
Public Sub ReadMap (Parent As ExternalFile, Name As String) As Map  
    If Parent.IsInitialized Then  
        Parent = FindFile(Parent, Name)  ' FindFileOrCreate(Parent, Name)  
        If Parent.IsInitialized Then  
            Dim iStream As InputStream = OpenInputStream(Parent)  
            Dim b() As Byte = Bit.InputStreamToBytes(iStream)  
            Dim str As String = BytesToString(b, 0, b.Length, "UTF-8")  
            Dim components() As String = Regex.Split(CRLF, str) ' Split lines  
   
            Dim lineMap As Map  
            lineMap.Initialize  
            For i = 0 To components.Length-1  
                Dim s As String = components(i)  
                Dim keyval() As String = Regex.Split("=", s) ' Split key-val  
                If keyval.Length = 2 Then  
                    lineMap.Put(keyval(0), keyval(1))  
                Else  
                    LogColor("CANNOT EVALUTATE KEY-VALUE PAIRS WHILE READ MAP FROM FILE: " & Parent.Name, Colors.Red)  
                End If  
            Next  
            Return lineMap  
        Else  
            LogColor("CANNOT READ MAP FROM FILE", Colors.Red)  
            Return Null  
        End If  
    Else  
        LogColor("WRONG FOLDER WHILE READ MAP FROM FILE", Colors.Red)  
        Return Null  
    End If  
End Sub  
  
'Uses existing file or creates a new file and writes the given map. Each key value pair is written as a single line.  
'All values are converted to strings.  
'See this link for more information about the actual format: <link>Properties format|http://en.wikipedia.org/wiki/.properties</link>.  
'You can use Storage.ReadMap to read this file.  
Public Sub WriteMap (Parent As ExternalFile, Name As String, Map As Map)  
    If Parent.IsInitialized Then  
        Parent = FindFileOrCreate(Parent, Name)  
        If Parent.IsInitialized Then  
            Dim sb As StringBuilder  
            sb.Initialize  
            For Each Key As String In Map.Keys  
                sb.Append(Key).Append("=").Append(Map.Get(Key)).Append(CRLF)  
            Next  
            Dim iStream As InputStream  
            Dim oStream As OutputStream  
            Dim b() As Byte = sb.ToString.GetBytes("UTF8")  
            iStream.InitializeFromBytesArray(b, 0, b.Length)  
            oStream = OpenOutputStream(Parent)  
            File.Copy2(iStream, oStream)  
        Else  
            LogColor("CANNOT WRITE MAP TO FILE", Colors.Red)  
        End If  
    Else  
        LogColor("WRONG FOLDER WHILE WRITE MAP TO FILE", Colors.Red)  
    End If  
End Sub  
  
'Copy a file to External Storage.  
'Dir:   The current input file directory, eg. File.DirAssets etc.  
'Name:   The current input file name  
'Parent:   External Storage parent name (Directory where place a file)  
'Rename:   Optionally rename the output file. Pass "" to mantain original name.  
Public Sub CopyFileToExternalStorage (Dir As String, Name As String, Parent As ExternalFile, Rename As String) As Boolean  
    If File.Exists(Dir, Name) = False Then  
        Log("File do not exist on DirAssets while copy to External Storage: " & Name)  
        Return False  
    End If  
   
    Dim iStream As InputStream, oStream As OutputStream  
    Dim oFile As ExternalFile  
   
    If Rename <> "" Then  
        oFile = FindFileOrCreate(Parent, Rename)  ' Optionally rename output file, pass "" to Rename argument will mantain original name  
    Else  
        oFile = FindFileOrCreate(Parent, Name)  
    End If  
   
    If oFile.IsInitialized = True Then  
        iStream = File.OpenInput(Dir, Name)  
        oStream = OpenOutputStream(oFile)  
        File.copy2(iStream, oStream)  
        iStream.Close  
        oStream.Close  
        Return True  
    Else  
        Log("Cannot create file on External Storage: " & Name)  
        Return False  
    End If  
End Sub  
  
'Need check. Probably call it FileExists, it use FindFile(Parent, Name) and I'm not sure if it is good for folders.  
Public Sub Exists (Parent As ExternalFile, Name As String) As Boolean  
    Dim ef As ExternalFile = FindFile(Parent, Name)  
'    Log("ExternalStorage Exists: [" & Parent.Name & "/" & Name & "]     IsInitialized: " & tmp.IsInitialized)  
    Return ef.IsInitialized  
End Sub  
  
'Create a folder  
Public Sub MakeDir (Parent As ExternalFile, Name As String) As ExternalFile  
    Log("MakeDir: [" & Parent.Name & "/" & Name & "]")  
    Return CreateNewDir(Parent, Name)  
End Sub  
  
'Check if permission is already granted.  
Public Sub HasPermission As Boolean  ' <<<<<< We need to check here if user removed root folder  
    Return File.Exists(File.DirInternal, PreviousUriFileName) And File.ReadString(File.DirInternal, PreviousUriFileName).Length > 0  
End Sub  
  
'Public Sub IsStorageFolderSelected As Boolean  
'    PersistantUri = File.ReadString(File.DirInternal, PreviousUriFileName)  
'    If PersistantUri.Length > 0 Then  
'        Root = DocumentFileToExternalFile(GetPickedDir(PersistantUri))  
'        Log("Root.Length=" & Root.Length)  
'    End If  
'    Return File.Exists(File.DirInternal, PreviousUriFileName) And (Root.Length > 0)  
'End Sub
```