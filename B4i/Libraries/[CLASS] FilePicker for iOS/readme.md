### [CLASS] FilePicker for iOS by ilan
### 07/17/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/120280/)

Need a filepickerdialog? to choose files from your File.Dirdocument Folder? With this class it is super easy and you can costumize it if you want.  
  
Instructions:  
  
1, Add the Class to your Project  
  
2, Initialize the Class in a button\_click Event like this:  
  

```B4X
Sub btn_Click  
    If Not(fp.IsInitialized) Then fp.Initialize(Me,Page1.RootPanel,"fp",File.DirDocuments)  
  
    Dim extensions() As Int = Array As Int(fp.Extensions_allfiles)  
    fp.fp_setFileExtensions(extensions)  
    fp.fp_show  
End Sub
```

  
  
3. Add the File extension you would like to filter like in the code above.  
  
4. show the dialog.  
  
After the user will select the files the class will return a Map with the selected files in it. Each object will contain a Path and a Filename.  
  
this is the Event that will we called after user clicks "Add" button.  
  

```B4X
Sub fp_selectedFiles(filemap As Map)  
    For Each key As String In filemap.Keys  
        Dim myfile As fileatt = filemap.Get(key)  
        Log(myfile.path)  
        Log(myfile.filename)  
  
        'you can get the complete filepath like this  
        Log(File.Combine(myfile.path,myfile.filename))  
  
        'we know we have only text files so i can read the string form it  
        Log(File.ReadString(myfile.path,myfile.filename))  
    Next  
  
End Sub
```

  
  
I include the complete example and the class.  
  
(If you like my work then you can show it with a donation of 1.000.000 $ :p, a smaller amount will not be accepted ?)  
  
Have Fun!  
  
(EDIT: i decided to include the source so you can play with it as you wish and not compile it to a library.)  
  
[MEDIA=youtube]KWBkYYWDhF0[/MEDIA]