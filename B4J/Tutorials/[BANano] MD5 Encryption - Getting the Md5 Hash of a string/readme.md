### [BANano] MD5 Encryption - Getting the Md5 Hash of a string by Mashiane
### 11/16/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/112108/)

Ola  
  
Was recently requested to look at this by a friend, for encryption  
  
1. Download this repo here to get the md5 javascript resource  
  
<https://github.com/blueimp/JavaScript-MD5>  
  
2. In your BANano project, add the javascript file  

```B4X
BANano.Header.AddJavascriptFile("md5.min.js")
```

  
  
3. Add this code to your code module in your project  
  

```B4X
'get md5hash  
Sub Md5Hash(value As String, key As String, raw As Boolean) As String  
    Dim res As Object = BANano.RunJavascriptMethod("md5", Array(value, key, raw))  
    Return res  
End Sub
```

  
  
4. Usage  
  

```B4X
Log(Md5Hash("TheMash", Null, False))  
    Log(Md5Hash("TheMash", "AneleMbanga", False))  
    Log(Md5Hash("TheMash", Null, True))  
    Log(Md5Hash("TheMash", "AneleMbanga", True))
```

  
  
5. Output.  
  
![](https://www.b4x.com/android/forum/attachments/86252)  
  
One can use this to store hashed passwords in the database, checksums to verify data integrity, detect unintentional data corruption depending on the complexity ones need.  
  
Enjoy.