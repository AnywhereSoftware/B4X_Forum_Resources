### COVID API by Almora
### 03/22/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/115244/)

API for live information about COVID-19  
  
[##source##](https://github.com/javieraviles/covidAPI)  
  
  

```B4X
Sub covid  
  
    Dim cov1 As HttpJob  
    cov1.Initialize("GetAddress", Me)  
    cov1.Download("https://coronavirus-19-api.herokuapp.com/all/")  
    Wait For (cov1) JobDone(cov1 As HttpJob)  
    If cov1.Success Then  
        ProgressDialogHide  
        Dim parser As JSONParser  
        parser.Initialize(cov1.GetString)  
        Dim root As Map = parser.NextObject  
        Dim recovered As Int = root.Get("recovered")  
        Dim cases As Int = root.Get("cases")    
        Dim deaths As Int = root.Get("deaths")  
         
     
    End If  
  
  
    cov1.Release  
  
  
  
End Sub
```