### SaveAs - Let the user select a target folder + list of other related methods by Erel
### 11/01/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/129897/)

**B4A + B4i example: <https://www.b4x.com/android/forum/threads/b4x-texteditor-save-and-load-external-files.132731/#post-838166>**  
List of classes or libraries that can be used to access secondary storages:  
  
*ContentChooser* (Phone libray) - allows the user to select a resource or file using external providers. Very useful and doesn't require permissions.  
  
*ExternalStorage* - Allows accessing external (secondary) storages. Requires the user to first select the target folder. Once the user selected a folder, your app can read and write from that folder. Doesn't require any permission.  
Not all folders are accessible with ExternalStorage in Android 11+. Specifically, root, Android/data and Download are not accessible: [more information](https://medium.com/androiddevelopers/android-11-storage-faq-78cefea52b7c).  
  
*SaveAs*- this code, the opposite of ContentChooser or the simpler version of ExternalStorage. Allows the user to choose the place where the file will be saved. Simple to work with and doesn't require permissions. Possible alternative to the external storage permission, which is mostly no longer available.  
  
RuntimePermissions.GetSafeDirDefaultExternal - A folder on the secondary storage, where you app can access without permissions. The path is a bit cumbersome (Log it to see). Note that other apps can't access this folder.  
  
Special *MANAGE\_EXTERNAL\_STORAGE* permission - mostly relevant to non-Google Play apps: <https://www.b4x.com/android/forum/threads/manage-external-storage-access-internal-external-storage-sdk-30.130411/>  
  
  

```B4X
Sub SaveAs (Source As InputStream, MimeType As String, Title As String) As ResumableSub  
    Dim intent As Intent  
    intent.Initialize("android.intent.action.CREATE_DOCUMENT", "")  
    intent.AddCategory("android.intent.category.OPENABLE")  
    intent.PutExtra("android.intent.extra.TITLE", Title)  
    intent.SetType(MimeType)  
    StartActivityForResult(intent)  
    Wait For ion_Event (MethodName As String, Args() As Object)  
    If -1 = Args(0) Then 'resultCode = RESULT_OK  
        Dim result As Intent = Args(1)  
        Dim jo As JavaObject = result  
        Dim ctxt As JavaObject  
        Dim ContentResolver As JavaObject = ctxt.InitializeContext.RunMethodJO("getContentResolver", Null)  
        Dim out As OutputStream = ContentResolver.RunMethod("openOutputStream", Array(jo.RunMethod("getData", Null), "wt")) 'wt = Write+Trim  
        File.Copy2(Source, out)  
        out.Close  
        Return True  
    End If  
    Return False  
End Sub  
  
Sub StartActivityForResult(i As Intent)  
    Dim jo As JavaObject = GetBA  
    ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)  
    jo.RunMethod("startActivityForResult", Array(ion, i))  
End Sub  
  
Sub GetBA As Object  
    Dim jo As JavaObject = Me  
    Return jo.RunMethod("getBA", Null)  
End Sub
```

  
  
Usage example:  

```B4X
Private Sub Button1_Click  
    File.WriteString(File.DirInternal, "test.txt", "test") 'just for the example.  
    Wait For (SaveAs(File.OpenInput(File.DirInternal, "test.txt"), "application/octet-stream", "test.txt")) Complete (Success As Boolean)  
    Log("File saved successfully? " & Success)  
End Sub
```

  
  
If not using B4XPages, replace GetBA with:  

```B4X
Sub GetBA As Object  
   Dim jo As JavaObject  
   Dim cls As String = Me  
   cls = cls.SubString("class ".Length)  
   jo.InitializeStatic(cls)  
   Return jo.GetField("processBA")  
End Sub
```

  
  
Supported in Android 5+ (21+).  
Note that the user can change the file name. No simple way to get the chosen name.