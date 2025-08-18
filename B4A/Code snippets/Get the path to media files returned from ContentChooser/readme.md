### Get the path to media files returned from ContentChooser by Erel
### 07/24/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/39313/)

**It is a mistake to try to get a file path from the returned resource. It will not work in most cases, and even if you will be able to get the path, you will not be able to access it.**  
You can use File.OpenInput to access the remote resource.  
  
Correct solution: [[B4X] TextEditor - Save and load external files](https://www.b4x.com/android/forum/threads/132731/#content)  
[SPOILER="Don't Use"]SubName: GetPathFromContentResult  
  
Description: Content providers such as the media gallery return a URL that starts with content://…  
  
If you are just interested in showing the selected image then you can use File.OpenInput to open an input stream. You can also use it together with File.Copy2 to copy the media to a new location.  
  
With the following code you can find the actual file path (if it is available):  
This code depends on ContentResolver and SQL libraries.  

```B4X
Sub GetPathFromContentResult(UriString As String) As String  
  If UriString.StartsWith("/") Then Return UriString 'If the user used a file manager to choose the image  
  Dim Cursor1 As Cursor  
  Dim Uri1 As Uri  
  Dim Proj() As String = Array As String("_data")  
  Dim cr As ContentResolver  
  cr.Initialize("")  
  If UriString.StartsWith("content://com.android.providers.media.documents") Then  
  Dim i As Int = UriString.IndexOf("%3A")  
  Dim id As String = UriString.SubString(i + 3)  
  Uri1.Parse("content://media/external/images/media")  
  Cursor1 = cr.Query(Uri1, Proj, "_id = ?", Array As String(id), "")  
  Else  
  Uri1.Parse(UriString)  
  Cursor1 = cr.Query(Uri1, Proj, "", Null, "")  
  End If  
  Cursor1.Position = 0  
  Dim res As String  
  res = Cursor1.GetString("_data")  
  Cursor1.Close  
  Return res  
End Sub
```

  
  
**In most cases it is a mistake to use this sub. Especially in newer versions of Android. You shouldn't assume that the resource returned from ContentChooser comes from the file system and if it is, you most probably won't have permissions to directly access it.**[/SPOILER]