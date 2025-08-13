###  Calculate the bearing between two coordinates by aminoacid
### 02/11/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/146074/)

I have seen several discussions of this on the forum but could not fined anything specific to my needs. Here is a B4X sub that will determine the bearing between two GPS coordinates. It's been translated, slightly modified and tested from the original post by [USER=966]@schimanski[/USER] (many thanks!). It does not require any external libraries.  
  
Original Post:  
<https://www.b4x.com/android/forum/threads/calculate-bearing-to-other-location.46513/>  
  
   

```B4X
Sub GetBearing (lat1 As Double, lon1 As Double, lat2 As Double, lon2 As Double) As Int  
  
    Dim d, tc1, sn As Double  
    Dim latAlt, lonAlt, latNeu, lonNeu As Double  
   
    'Conversion of coordinates from degrees to radians  
    'LatAlt and LonAlt Are the old coordinates from which the bearing is to be determined'  
    latAlt = lat1 * cPI / 180  
    lonAlt = -lon1 * cPI / 180  
    latNeu = lat2 * cPI / 180  
    lonNeu = -lon2 * cPI / 180  
   
    'Formula to calculate the distance between the old and the new position'  
    d = 2 * ASin(Sqrt(Power((Sin((latAlt-latNeu)/2)),2)+ Cos(latAlt)*Cos(latNeu)*Power((Sin((lonAlt-lonNeu)/2)),2)))  
   
    'Formula to calculate the bearing from the old position to the new position depending on north In radians'  
    If Cos(latAlt) < 1e-7 Then  
        If (latAlt > 0) Then  
            tc1 = cPI  
        Else  
            tc1= 2*cPI  
        End If  
    Else  
        sn = Sin(lonNeu-lonAlt)  
        If Abs(sn) < 1e-7 Then  
            If latAlt > latNeu Then tc1 = cPI Else tc1 = 2*cPI  
        Else If sn < 0 Then  
            tc1=ACos((Sin(latNeu)-Sin(latAlt)*Cos(d))/(Sin(d)*Cos(latAlt)))  
        Else  
            tc1=2*cPI-ACos((Sin(latNeu)-Sin(latAlt)*Cos(d))/(Sin(d)*Cos(latAlt)))  
        End If  
    End If  
   
    'Recalculate the bearing from radians to degrees'  
    Dim bearing As Int  
    bearing = NumberFormat(tc1 * 180 / cPI,1,0)  
   
    Return bearing  
End Sub
```