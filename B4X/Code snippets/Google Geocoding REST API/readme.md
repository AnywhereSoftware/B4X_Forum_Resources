###  Google Geocoding REST API by Erel
### 12/12/2019
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/83870/)

This code is compatible with B4A, B4i and B4J.  
  
1. Get an API key: <https://developers.google.com/maps/documentation/geocoding/get-api-key>  
  
2.  

```B4X
Sub PlaceToLatLon(Place As String) As ResumableSub  
   Dim res() As Double = Array As Double(9999, 9999)  
   Dim j As HttpJob  
   j.Initialize("", Me)  
   j.Download2("https://maps.googleapis.com/maps/api/geocode/json", Array As String("key", API_KEY, "address", Place))  
   Wait For (j) JobDone(j As HttpJob)  
   If j.Success Then  
     Dim jp As JSONParser  
     jp.Initialize(j.GetString)  
     Dim m As Map = jp.NextObject  
     If m.Get("status") = "OK" Then  
       Dim results As List = m.Get("results")  
       If results.Size > 0 Then  
         Dim first As Map = results.Get(0)  
         Dim geometry As Map = first.Get("geometry")  
         Dim location As Map = geometry.Get("location")  
         res(0) = location.Get("lat")  
         res(1) = location.Get("lng")  
       End If  
     End If  
   Else  
     Log("Error!")  
   End If  
   j.Release  
   Return res  
End Sub
```

  
  
Usage example:  

```B4X
Wait For(PlaceToLatLon("Israel Yodfat")) Complete (ll() As Double)  
If ll(0) <> 9999 Then  
   Log("Location: " & ll(0) & ", " & ll(1))  
Else  
   Log("Failed to geocode.")  
End If
```