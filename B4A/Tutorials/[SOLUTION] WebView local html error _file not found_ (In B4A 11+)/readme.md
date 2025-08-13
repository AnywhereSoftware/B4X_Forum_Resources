### [SOLUTION] WebView local html error "file not found" (In B4A 11+) by Kita
### 08/18/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/142410/)

Normaly in linking a file in the assets folder would be "file:///android\_assets/<file path in assets folder>". but it turns out in the latest IDE you can only link files which are in assets folder using that method.  
  
Its really near to imposible to use folders in the assets folder but here is a fix which you can modify to meet your needs.  
  
If lets say you have an "index.html" file linked to "javascript, css and other resources in the assets"  
  
Folders in the assets folder are refrenced like this  

```B4X
Files  
    css  
        css.css  
    js  
        js.js  
    index.html
```

  
path for css is "file:///android\_assets/css%5Ccss.css" not "file:///android\_assets/css/css.css"  
  

```B4X
Sub FixUrl(Folder As String, Url As String) As String  
    Dim TempUrl As String  
    TempUrl = Url.Replace("/","\")  
      
    If TempUrl.Contains("file:\\\android_asset\") Then  
        'If the main html file is in the assets folder  
        If Folder = "" Then  
            TempUrl = TempUrl.Replace("file:\\\android_asset\","file:///android_asset/")  
            Log("In assets: "&TempUrl)  
        Else  
            TempUrl = TempUrl.Replace("file:\\\android_asset\","file:///android_asset/"&Folder&"\")  
            Log("Folder In assets: "&TempUrl)  
        End If  
    Else  
        If Folder = "" Then  
            TempUrl = TempUrl.Replace("file:\\\","file:///android_asset/")  
            Log("In assets: "&TempUrl)  
        Else  
            TempUrl = TempUrl.Replace("file:\\\","file:///android_asset/"&Folder&"\")  
            Log("Folder In assets: "&TempUrl)  
        End If  
    End If  
    Return TempUrl  
    'File:\\\android_asset\  
End Sub
```

  
  
Usage:  
  

```B4X
Private Sub WebView1_OverrideUrl (Url As String) As Boolean  
    'If file is directily in assets folder  
    'You use ""  
    WebView1.LoadUrl(FixUrl("Replace with folder containing main html",Url))  
End Sub
```

  
  
For the css and js  
replace path   

```B4X
<!–If you css is –>  
<link rel="stylesheet" href="css/css.css">  
<!– Replace "/" with "%5C" as shown below –>  
<link rel="stylesheet" href="css%5Ccss.css">  
  
<!– If your javascript is linked as below –>  
<script src="js/js.js"></script>  
<!– again replace "/" with "%5C" as below –>  
<script src="js%5Cjs.js"></script>  
  
<!– This will only work if the css and js folder are in the assets folder –>
```