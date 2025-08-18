### Identify Lat Lon geodata by address by Wolli013
### 06/19/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/131796/)

Hello friends  
I would like to share with you my code that I created this afternoon to find the geodata based on an address.  
I hope you can do something with it.  
Maybe you can extend it and create a list for the multiple entries with selection and post it here if you want.  
  

```B4X
Sub Geodaten  
      
Dim HttpJobGPS As HttpJob  
HttpJobGPS.Initialize("GPS_Daten", Me)  
  
Dim url,Stadt,Platz,Strasse,Nummer As String  
'—————————————————–  
    Stadt = "33602 Bielefeld"  
    Platz = ""  
    Strasse = "Jahnplatz"  
    Nummer = "10"  
'—————————————————–   
url = "https://nominatim.openstreetmap.org/search?format=json&limit=10&addressdetails=1"  
url = url & "&q=" & Platz & "%20" & Stadt & "%20" & Nummer & "%20" & Strasse  
HttpJobGPS.download(url)  
      
End Sub  
  
Sub JobDone(Job As HttpJob)  
      
If Job.Success = True Then  
 Dim res As String  
 res = Job.GetString  
   
Dim parser As JSONParser  
parser.Initialize(res)  
 Log("Parser " & res)  
End If  
  
Dim root As List = parser.NextArray  
For Each colroot As Map In root  
'—————————————————–  
 Dim boundingbox As List = colroot.Get("boundingbox")  
 Log(boundingbox.Get(0))  
 Log(boundingbox.Get(2))  
 Log(boundingbox.Get(1))  
 Log(boundingbox.Get(3))  
'—————————————————–   
 Dim address As Map = colroot.Get("address")  
 Log(address.Get("country"))  
 Log(address.Get("country_code"))  
 Log(address.Get("town"))  
 Log(address.Get("road"))  
 Log(address.Get("neighbourhood"))  
 Log(address.Get("county"))  
 Log(address.Get("postcode"))  
 Log(address.Get("suburb"))  
 Log(address.Get("house_number"))  
 Log(address.Get("state"))  
'—————————————————–  
 Log(colroot.Get("importance"))  
 Log(colroot.Get("display_name"))  
 Log(colroot.Get("type"))  
 Log(colroot.Get("class"))  
 Log(colroot.Get("place_id"))  
 Log(colroot.Get("lat"))  
 Log(colroot.Get("lon"))  
   
Next  
   
End Sub
```