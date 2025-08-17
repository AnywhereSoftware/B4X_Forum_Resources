### [Web][SithasoKITT] - Voice Command for your Web Applications by Mashiane
### 02/06/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/159058/)

Hi Fam  
  
![](https://www.b4x.com/android/forum/attachments/150397)  
  
If you grew up in my days, you will recognize this car. KITT, Michael Knights pride. A car that could talk and do wonders!!! Anyway…  
  
SithasoKITT is just a simple wrap of Speech Synthesis, of github wrap. <https://github.com/TalAter/annyang>, which helps you "talk" to your pc. You give it commands and it executes.  
  
So I decided to play around with SithasoIONIC7 Wireframes..  
  
Usage:  
  
1. Define in class globals.  
  

```B4X
Private kitt As SithasoKITT
```

  
  
2. Initialize and add some commands and the callbacks they will fire.  
  

```B4X
kitt.Initialize(Me, "kitt")  
    kitt.addCommand("database bugs", "kitt_database_bugs")  
    kitt.addCommand("download image", "kitt_download_image")  
    kitt.addCommand("download wireframe", "kitt_download_wireframe")  
    kitt.addCommand("upload wireframe", "kitt_upload_wireframe")  
    kitt.addCommand("download guide", "kitt_download_guide")  
    kitt.addCommand("download resources", "kitt_download_resources")  
    kitt.addCommand("delete everything", "kitt_delete_everything")  
    kitt.addCommand("revert", "kitt_revert")  
    kitt.addCommand("redo", "kitt_redo")
```

  
  
The callbacks  
  

```B4X
Sub kitt_download_resources(e As BANanoEvent)  
    Log("kitt_download_resources")  
End Sub  
  
Sub kitt_download_guide(e As BANanoEvent)  
    Log("kitt_download_guide")  
End Sub  
  
Sub kitt_database_bugs(e As BANanoEvent)  
    Log("kitt_database_bugs")  
End Sub  
  
Sub kitt_download_image(e As BANanoEvent)  
    Log("kitt_download_image")  
End Sub  
  
Sub kitt_download_wireframe(e As BANanoEvent)  
    Log("kitt_download_wireframe")  
End Sub  
     
Sub kitt_upload_wireframe(e As BANanoEvent)  
    Log("kitt_upload_wireframe")  
End Sub
```

  
  
3. You can pause / resume the Speech Engine  
  

```B4X
Sub kittpause_click(e As BANanoEvent)  
    Log("kittpause_click")  
    app.SetElementVisible("kittpause", False)  
    app.SetElementVisible("kittresume", True)  
    kitt.pause  
End Sub  
  
Sub kittresume_click(e As BANanoEvent)  
    Log("kittresume_click")  
    app.SetElementVisible("kittpause", True)  
    app.SetElementVisible("kittresume", False)  
    kitt.resume  
End Sub
```

  
  
4. Getting what end user said… (before match / no match is found of your command)  
  

```B4X
Sub kitt_result(phrases As List)  
    Log("kitt_result")  
    Log(phrases)  
End Sub
```

  
  
5. If a match is found / a match is not found  
  

```B4X
Sub kitt_resultMatch(userSaid As String, commandText As String, phrases As List)  
    Log("kitt_resultMatch")  
    Log(userSaid)  
    Log(commandText)  
    Log(phrases)  
End Sub  
  
Sub kitt_resultNoMatch(phrases As List)  
    Log("kitt_resultNoMatch")  
    Log(phrases)  
End Sub
```

  
  
6. Trap some other interesting events.  
  

```B4X
Sub kitt_soundStart(e As BANanoEvent)  
    Log("kitt_soundStart")  
End Sub  
  
Sub kitt_end(e As BANanoEvent)  
    'app.ShowToastSuccess("KITT", "The Speech Command has ended!")  
    app.SetElementVisible("kittpause", True)  
    app.SetElementVisible("kittresume", False)  
    app.SetElementVisible("kitton", True)  
    app.SetElementVisible("kittoff", False)  
End Sub  
  
Sub kitt_start(e As BANanoEvent)  
    'app.ShowToastSuccess("KITT", "The Speech Command has been started!")  
    app.SetElementVisible("kittpause", True)  
    app.SetElementVisible("kittresume", False)  
    app.SetElementVisible("kitton", False)  
    app.SetElementVisible("kittoff", True)  
End Sub  
  
Sub kitt_error(e As BANanoEvent)  
    app.ShowToastError("KITT", "The Speech Command experienced an error!")  
End Sub  
  
Sub kitt_errorNetwork(e As BANanoEvent)  
    app.ShowToastError("KITT", "The Speech Command experienced a network error!")  
End Sub  
  
Sub kitt_errorPermissionBlocked(e As BANanoEvent)  
    app.ShowToastError("KITT", "The Speech Command experienced a permission blocked error!")  
End Sub  
  
Sub kitt_errorPermissionDenied(e As BANanoEvent)  
    app.ShowToastError("KITT", "The Speech Command experienced a permission denied error!")  
End Sub
```

  
  
7. You can start the Speech Engine & Stop it via code  
  

```B4X
'turn speech on  
Sub kitton_click(e As BANanoEvent)  
    e.PreventDefault  
    app.SetElementVisible("kitton", False)  
    app.SetElementVisible("kittoff", True)  
    'start to listen  
    kitt.start  
End Sub  
  
Sub kittoff_click(e As BANanoEvent)  
    e.PreventDefault  
    app.SetElementVisible("kitton", True)  
    app.SetElementVisible("kittoff", False)  
    kitt.abort  
End Sub
```

  
  
*In your BANano project add this in Main, download the file from the repo.*  
  

```B4X
BANano.Header.AddJavascriptFile("annyang.min.js")
```

  
  
  
Better to use the \_result callback to process the next stuff in line.  
  
[MEDIA=youtube]rSmP0kOY2pc[/MEDIA]  
  
  
#WatchThisSpace.