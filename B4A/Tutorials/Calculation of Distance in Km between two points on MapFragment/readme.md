### Calculation of Distance in Km between two points on MapFragment by WebQuest
### 08/08/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/133264/)

Hi I share a simple solution to calculate the distance in km between two points on MapFragment. I hope it will be of help to anyone who works with the GoogleMaps v2.50 library.  
  
The coordinates used for this example are set in the image.  
  
![](https://www.b4x.com/android/forum/attachments/117589)  
  
  
The code is the translation of Haversine's formula.  
  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
      
    Activity.LoadLayout("1")  
      
    CalcDistance(48.0193200,9.4042800,48.01932, 11.3819)  
          
EndSub     
  
Sub CalcDistance(lat1 As Double,lon1 As Double,lat2 As Double, lon2 As Double)  
      
    Dim R As Double=6371  
    Dim dLat As Double=toRad(lat2-lat1)  
    Dim dLon As Double=toRad(lon2-lon1)  
    Dim alat1 As Double=toRad(lat1)  
    Dim alat2 As Double=toRad(lat2)  
      
    Dim a As Double = ASin(dLat/2)*ASin(dLat/2)+ASin(dLon/2)*ASin(dLon/2)*ACos(alat1)*ACos(alat2)  
    Dim c As Double=2*ATan2(Sqrt(a),Sqrt(1-a))  
    Dim d As Double=R*c  
    Log("Distance: "&Round2(d,1))  
    Return d  
      
      
End Sub  
  
Sub toRad(Value As Double) As Double  
      
    Dim value2 As Double  
      
    value2 = Value*cPI/180  
      
    Return value2  
  
End Sub
```