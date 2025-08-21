###  GPSPolyMap - check if GPS location is inside a polygon by Biswajit
### 05/11/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/117625/)

With this class, you can check if the GPS location coordinate is inside a polygon.  
You can use this class to check whether the user is inside a building, shopping mall or any custom shape.  
This class is only for B4A and B4I.  
  
Here is how can you get the coordinates of an establishment (school, office, shopping mall or your own house):  

1. Open [google map](https://www.google.com/maps).
2. Search for the establishment in which you want to track
3. Start from a point/corner. Click on the starting point /corner.
4. You will see a gray point and at the bottom, you will see a white box containing a coordinate.
5. Add those points like below. And at last, add the starting point to close the polygon.
6. **Remember to add the points in the correct order so that none of the sides overlap with each other.**

  
**B4A/B4I Usage:**  

```B4X
Private PolyPoints As List  
PolyPoints.initialize  
PolyPoints.Add(CreateMap("lat":22.573515, "lng":88.371020))  
PolyPoints.Add(CreateMap("lat":22.569855, "lng":88.370321))  
PolyPoints.Add(CreateMap("lat":22.568923, "lng":88.375217))  
PolyPoints.Add(CreateMap("lat":22.570707, "lng":88.373158))  
PolyPoints.Add(CreateMap("lat":22.571181, "lng":88.376235))  
PolyPoints.Add(CreateMap("lat":22.573515, "lng":88.375136))  
PolyPoints.Add(CreateMap("lat":22.573515, "lng":88.371020)) 'add the first point at last to close the polygon  
  
Private gpm as GPSPolyMap  
gpm.Initialize(PolyPoints)  
  
  
Sub GPS1_LocationChanged (Location1 As Location)  
    Log(gpm.isInside(Location1.Latitude,Location1.Longitude,True))  
End Sub
```