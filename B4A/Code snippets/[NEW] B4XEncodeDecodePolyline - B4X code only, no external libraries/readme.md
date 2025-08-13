### [NEW] B4XEncodeDecodePolyline - B4X code only, no external libraries by TILogistic
### 12/01/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/133331/)

New class to encode and decode polylines.  
  
1. Decode points from encoded coordinates.  
2. Encode points from polyline coordinates.  
3. Generate GeoJSON from polyline coordinates.  
4. Generate KML from polyline coordinates (v2).  
5. Decode KML to polyline coordinates (v2).  
6. Generate GPX from polyline coordinates (v2).  
7. Decode GPX to polyline coordinates (v2).  
  

```B4X
    Dim Polyline As B4XEncodeDecodePolyline  
    Polyline.Initialize  
  
    Dim TextCoded As String = "mfp_I__vpAb@EwCc~@[oCcIuXyR_f@mGmLpKiZ_DoDPi@kCuC"  
  
    Log("———– Decode ———–")  
  
    Log(TextCoded)  
  
    Dim ListPoints As List = Polyline.Decode(TextCoded,5)  
  
    For Each Points As Coordinates In ListPoints  
        Log($"${Points.Latitude},${Points.Longitude}"$)  
    Next  
    
    TextCoded = Polyline.Encode(ListPoints, 5)  
   
    Log("———– Encode ———–")  
    
    For Each Points As Coordinates In Polyline.Decode(TextCoded,5)  
        Log($"${Points.Latitude},${Points.Longitude}"$)  
    Next  
    Log(TextCoded)  
    
    Log("———– GeoJSON ———–")  
    Log(Polyline.ToGeoJSON(TextCoded,5).As(JSON).ToCompactString)
```

  
  
![](https://www.b4x.com/android/forum/attachments/122475)  
  
![](https://www.b4x.com/android/forum/attachments/159135)  
  
**Get the source code for the class with a donation.  
😉😉**