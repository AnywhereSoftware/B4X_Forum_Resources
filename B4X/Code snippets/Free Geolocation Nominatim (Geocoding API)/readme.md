###  Free Geolocation Nominatim (Geocoding API) by TILogistic
### 06/20/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/131804/)

Here's a demo of how to use the nominatim geocoding API for free.  
  
**Note:**  
There are other geocoding options if you want to know, leave your comments.  
  
**Demo file attached**  
  

```B4X
Sub GeoCoderNominatim(Query As String) As ResumableSub  
    Dim ResultURL As String  
    Dim j As HttpJob  
    Dim Parameter() As String = Array As String ("q", Query, "format", "json", "limit", "1", "addressdetails", "1")  
    Try  
        j.Initialize("", Me)  
        j.Download2("https://nominatim.openstreetmap.org/search", Parameter)  
        j.GetRequest.SetHeader("Content-Type","application/json")  
        Wait For (j) JobDone(j As HttpJob)  
        If j.Success Then  
            ResultURL = j.GetString  
        Else  
            Log(j.ErrorMessage)  
        End If  
    Catch  
        Log(LastException)  
    End Try  
    j.Release  
    Return ResultURL  
End Sub
```

  
  
**Enter address get location**   
  
![](https://www.b4x.com/android/forum/attachments/115232) ![](https://www.b4x.com/android/forum/attachments/115233)  
  
**Enter location get address**   
  
![](https://www.b4x.com/android/forum/attachments/115234) ![](https://www.b4x.com/android/forum/attachments/115235)