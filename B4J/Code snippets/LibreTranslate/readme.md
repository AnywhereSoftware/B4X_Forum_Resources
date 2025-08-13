### LibreTranslate by micro
### 11/27/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/144431/)

Hi to all  
I needed for an application the ability to translate texts according to the selected language but it had to work offline and searching around I found LibreTranslate (free) although as suggeed by Mash there are others like Argos, Apertium…  
I working with Windows had to first install linux on windows with the microsoft utility WLS and installed the package with docker  
[Link](https://github.com/LibreTranslate/LibreTranslate#readme)  
After that it will be available as http server on port 5000  
  

```B4X
Sub AppStart (Args() As String)  
    CallSubDelayed(Me, "Go")  
    StartMessageLoop  
End Sub  
  
Sub Go  
    Dim linguasorg As String = "it"  
    Dim linguadest As String = "en"  
    Dim tradurre As String = "Io Amo B4x, grazie Erel"  
    Dim j As HttpJob  
    j.Initialize("", Me)  
    Dim json As JSONGenerator  
    json.Initialize(CreateMap("q": tradurre, "source": linguasorg, "target": linguadest, _  
    "format": "text", "api_key": ""))  
    j.PostString($"http://localhost:5000/translate"$, json.ToString)  
    j.GetRequest.SetContentType("application/json")  
    Wait For(j) JobDone(j As HttpJob)  
    Dim b As Boolean = j.Success  
    If b Then  
        Dim jpars As JSONParser  
        jpars.Initialize(j.GetString)  
        Log(jpars.NextObject.GetDefault("translatedText", "??"))  
    Else  
       Log("??")  
    End If  
    j.Release  
    StopMessageLoop  
    ExitApplication  
End Sub
```

  
![](https://www.b4x.com/android/forum/attachments/136494)  
  
For those who know a different and better solution than doker for windows to achieve this can communicate it here, thanks.