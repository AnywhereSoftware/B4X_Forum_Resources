### Measure distance between 2 LatLng points by Daica
### 05/24/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/131034/)

I am working on a mapping application that needs to measure the distance between 2 points, I found a function on Google and convert it to B4A (B4X) code.  
  
K is kilometers  
N is nautical miles  
M (or anything else) will return the result in miles.  
You can add other units into the function and just use math to convert from miles.  
  
decimalPlace = the result will be rounded to X decimal places.  
  
Modify as you wish and enjoy. From my testing, it seems to be very accurate.  
  
![](https://www.b4x.com/android/forum/attachments/113935)  
  

```B4X
Sub MeasureLatLng(lat1 As Double, lng1 As Double, lat2 As Double, lng2 As Double, unit As Char, decimalPlace As Int) As Double  
    If lat1 = lat2 And lng1 = lng2 Then  
        Return 0  
    Else  
        Dim theta As Double = lng1 - lng2  
        Dim dist As Double = Sin(lat1 * cPI / 180.0) * Sin(lat2 * cPI / 180.0) + Cos(lat1 * cPI / 180.0) * Cos(lat2 * cPI / 180.0) * Cos(theta * cPI / 180.0)  
        dist = ACos(dist)  
        dist = dist / cPI * 180.0  
        dist = dist * 60 * 1.1515  
        If unit = "K" Then  
            dist = dist * 1.609344  
        Else If unit = "N" Then  
            dist = dist * 0.8684  
        End If  
        dist = Round2(dist, decimalPlace)  
        Return dist  
    End If  
End Sub
```