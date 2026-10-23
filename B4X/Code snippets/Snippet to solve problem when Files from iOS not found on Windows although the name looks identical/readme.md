###  Snippet to solve problem when Files from iOS not found on Windows although the name looks identical (Unicode NFC vs NFD) by kiwi
### 10/19/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/172321/)

**Background**  
In a cross-platform app (B4A / B4i / B4J) attachments are zipped on the sending device and unzipped on the receiver. Zips sent from Android to any platform and from iOS to Android or iOS worked fine. Zips sent **from iOS and unzipped in B4J on Windows** failed: File.Exists returned False for a folder whose name contains an accented character (“Novák”), although the name looked exactly the same in Explorer, in the log and in the code.  
  
  
**Cause**  
An accented character can be stored in Unicode in two ways:  
  
  

- **NFC** – one composed character, á (U+00E1). Used by Windows, Android and normally by B4X strings.
- **NFD** – base letter + combining accent, a + U+0301. Used by Apple file system APIs.

  
Both forms look the same on screen but are different strings. Apple platforms produce NFD names whenever a name goes through the file system path APIs. Zip libraries on iOS take the entry names this way, so the zip contained NFD names even though the app had created the folder with an NFC name.  
  
  
The receiving platform then decides whether this matters:  
  
  

- **Android** (shared storage) and **iOS** (APFS) compare file names normalized, so the NFC name built in code finds the NFD folder.
- **Windows (NTFS)** compares names exactly, so the NFD folder is a different folder than the NFC name built in code.

  
**Not only zip files**  
The zip was just how it showed up in my app. The same problem can affect any file or folder name with accented letters or other non-ASCII characters (e.g. Czech, French, German, Vietnamese, Korean) that is transferred from an Apple device. It happens when both of these are true:  
  
  

1. The name comes from an Apple device through file system or path APIs, for example:

- zip archives created on iOS / macOS,
- files picked in the Files app, received via share or copied to the clipboard,
- names read from a file URL or path, or files coming from a Mac.

Names typed by the user or created by the app from its own strings are usually NFC.2. The receiver compares the name exactly, for example:

- Windows (NTFS) file system,
- **string comparisons in code on any platform**: =, Map keys, SQL queries, lists of known files. Even on Android and iOS, where the file system finds the file, "Novák" = "Novák" returns False in code if one of them is NFD.

  
Pure ASCII names are never affected. Names created on Android or Windows are already NFC.  
**How to detect it**  
Compare the string lengths. Each accented letter in NFD is one character longer:  
  
  
  
Expected: 'Jan Novák\_&123' len=14  
Found: 'Jan Novák\_&123' len=15  
  
**Solution (B4J)**  
Unzip to a temporary folder, convert all folder and file names to NFC, then move them to the destination. On B4A and B4i the archive is unzipped directly as before.  
  

```B4X
'Unzips a received archive into DestDir.  
'B4J: unzips to a temp folder first and converts folder/file names to NFC.  
Private Sub UnzipReceived(inDir As String, inArchiveName As String, DestDir As String) As Boolean  
    #If B4J  
    Dim tmpName As String = "UnzipTmp_" & DateTime.Now  
    File.MakeDir(inDir, tmpName)  
    Dim tmpDir As String = File.Combine(inDir, tmpName)  
    Dim ok As Boolean = UnzipSync(inDir, inArchiveName, tmpDir) ' your unzip routine (e.g. Archiver.UnZip)  
    If ok Then  
        Try  
            MoveTreeNFC(tmpDir, DestDir)  
        Catch  
            Log("UnzipReceived: move failed: " & LastException)  
            ok = False  
        End Try  
    End If  
    DeleteTree(inDir, tmpName)  
    Return ok  
    #Else  
    Return UnzipSync(inDir, inArchiveName, DestDir)  
    #End If  
End Sub  
  
#If B4J  
'Moves all files from SrcDir to DestDir (recursively) with names converted to NFC.  
'Existing folders are merged, existing files are overwritten.  
Private Sub MoveTreeNFC(SrcDir As String, DestDir As String)  
    For Each f As String In File.ListFiles(SrcDir)  
        Dim nfc As String = ToNFC(f)  
        If File.IsDirectory(SrcDir, f) Then  
            If File.Exists(DestDir, nfc) = False Then File.MakeDir(DestDir, nfc)  
            MoveTreeNFC(File.Combine(SrcDir, f), File.Combine(DestDir, nfc))  
            File.Delete(SrcDir, f) ' folder is empty now  
        Else  
            File.Copy(SrcDir, f, DestDir, nfc)  
            File.Delete(SrcDir, f)  
        End If  
    Next  
End Sub  
  
'Deletes a file or a folder including its content.  
Private Sub DeleteTree(Dir As String, Name As String)  
    If File.Exists(Dir, Name) = False Then Return  
    If File.IsDirectory(Dir, Name) Then  
        Dim p As String = File.Combine(Dir, Name)  
        For Each f As String In File.ListFiles(p)  
            DeleteTree(p, f)  
        Next  
    End If  
    File.Delete(Dir, Name)  
End Sub  
  
'Returns the string in Unicode NFC form (single composed characters, e.g. "á").  
Private Sub ToNFC(s As String) As String  
    Dim norm As JavaObject  
    norm.InitializeStatic("java.text.Normalizer")  
    Dim form As JavaObject  
    form.InitializeStatic("java.text.Normalizer$Form")  
    Return norm.RunMethod("normalize", Array(s, form.GetField("NFC")))  
End Sub  
#End If
```

  
  
**Notes**  
  

- ToNFC is useful wherever a name received from an Apple device is used as a path on Windows or compared in code, not only after unzipping. Names that are already NFC are returned unchanged, so it is safe to call it on every received name.
- Files already extracted into an NFD folder before applying the fix have to be moved once manually.

  
Tested with B4A, B4i (iOS 26) and B4J on Windows.