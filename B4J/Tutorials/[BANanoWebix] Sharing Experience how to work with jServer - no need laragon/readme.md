### [BANanoWebix] Sharing Experience how to work with jServer - no need laragon by Magma
### 05/24/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/131010/)

Sharing Experience … :)  
  
  
How to work banonowebix projects at jServer at least the client-side right / **not the php server scripts… (caution!)**  
  
well when you open a project at laragon you just remove lines  
  
at **bananowebix** projects (AppStart) :  
  

```B4X
    Publish = "C:\laragon\www"
```

  
  
also at the end of Appstart remove:  
  

```B4X
    BP.Open(True)  
    ExitApplication
```

  
  
  
  
![](https://www.b4x.com/android/forum/attachments/113868)  
  
add at Process\_Globals this code / and Jserver Library  
  
 **Public SRVR As Server**  
  
and add at Appstart the following code:  
  

```B4X
    'added  
    SRVR.Initialize("")  
    SRVR.Port = 52042  
    SRVR.StaticFilesFolder = File.Combine(File.DirApp,  "www")  
    SRVR.Start  
  
    Publish = File.Combine(File.DirApp,  "www")  
    '———-
```

  
  
  
and remove  

```B4X
    fx.ShowExternalDocument(appPath)  
    #if release  
        ExitApplication  
    #end if
```

  
  
  
And the following the same for webix  
  
at then end of AppStart no need add nothing…  
**because we manually browse then page from the browser we want… like  
  
<http://localhost:52042/>**  
  
  
![](https://www.b4x.com/android/forum/attachments/113869)