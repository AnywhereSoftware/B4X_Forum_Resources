### [BANano] How BANano.GeoLocation helped us with developing Seeking.Shelter & GPS locations querying from a database by Mashiane
### 04/16/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/129798/)

Ola  
  
[Seeking.Shelter](https://tgifzone.com/seekshelter) is an app for people in distress. It helps one find the police stations, courts, shelters, clinics and hospitals around South Africa.  
  
One of the WebApp reviewers made a suggestion to include a "Near Me" functionality, where when selected, it should pick up, the persons device location and then find nearest locations for police, courts, shelters, clinics and hospitals.  
  
[MEDIA=youtube]S-5d7ZFVnLs[/MEDIA]  
  
  
  
Now the GPS co-ordinates for all these modules are stored on the SQLite database.  
  
With the Near Me functionality, a person should select a court, shelter, clinic, police and the WebApp needs to  
  
1. get the current location.  
2. search from GPS positions stored on a database the nearest locations for that selected service.  
  
So, with BANano.Geolocation, getting ones current location is rather easy peasy..  
  

```B4X
Sub GetMyCurrentLocation  
    vuetify.pagepause  
    Dim args As List  
    Dim trackSuccess As BANanoObject = banano.CallBack(Me, "locationFound", args)  
    Dim trackError As BANanoObject = banano.callback(Me, "locationError", args)  
    '  
    banano.GeoLocation.GetCurrentPosition(trackSuccess, trackError)  
End Sub
```

  
  
This is passed 2 callbacks, one for the success and one for the error.  
  
So when the location is found, we call a method called **locationFound** which receives the GPS location. When the location is not found, we call **locationError**, which receives an integer value of the error.  
  
So on **LocationFound,** we need to create queries to query the backend data-base and find the nearest 10KM points of interest.  
  
**Step 1: What we needed to do first was update our database.**  
  
![](https://www.b4x.com/android/forum/attachments/111769)  
  
This meant that for each lat/lon, we calculate the **sin** and **cos** points and store them. We name these coslat, coslng, sinlat, sinlng. These are calculated with  
  

```B4X
Dim cur_cos_lat As Double = Cos(lat * PI / 180)  
    Dim cur_sin_lat As Double = Sin(lat * PI / 180)  
    Dim cur_cos_lng As Double = Cos(lng * PI / 180)  
    Dim cur_sin_lng As Double = Sin(lng * PI / 180)
```

  
  
We store these in the database for each point.  
  
**Step 2: Getting a users device location and then querying the nearest from the DB.**  
  
This is done with GetMyCurrentPosition which then filters down to locationFound. From the found GPS position, we use the formula above and apply it to that point and then we run these against the sin and cos of the database.  
  

```B4X
Sub locationFound(position As BANanoGeoPosition)   'ignoredeadcode  
    Log("locationFound")  
    Dim lat As Double = position.Latitude  
    lat = banano.parseFloat(lat)  
    '  
    Dim lng As Double = position.Longitude  
    lng = banano.parseFloat(lng)  
    
    'geospatial the point  
    Dim PI As Double = 3.14159  
    '  
    Dim cur_cos_lat As Double = Cos(lat * PI / 180)  
    Dim cur_sin_lat As Double = Sin(lat * PI / 180)  
    Dim cur_cos_lng As Double = Cos(lng * PI / 180)  
    Dim cur_sin_lng As Double = Sin(lng * PI / 180)  
    
    'nearest to 10KM  
    Dim cos_allowed_distance As Double = Cos(10.0 / 6371)  
    'what are we looking for  
    Dim sfindnearme As String = vuetify.GetData("findnearme")  
    'update all queries  
    Dim policeqry As String = $"SELECT * FROM police WHERE ${cur_sin_lat} * sinlat + ${cur_cos_lat} * coslat * (coslng * ${cur_cos_lng} + sinlng * ${cur_sin_lng}) > ${cos_allowed_distance} order by (abs(longitude -(${lng})) +( abs(latitude-(${lat}))*2.1))"$  
    '  
    Dim courtsqry As String = $"SELECT * FROM courts WHERE ${cur_sin_lat} * sinlat + ${cur_cos_lat} * coslat * (coslng * ${cur_cos_lng} + sinlng * ${cur_sin_lng}) > ${cos_allowed_distance} order by (abs(longitude -(${lng})) +( abs(latitude-(${lat}))*2.1))"$  
    '  
    Dim clinicsqry As String = $"SELECT * FROM clinics WHERE ${cur_sin_lat} * sinlat + ${cur_cos_lat} * coslat * (coslng * ${cur_cos_lng} + sinlng * ${cur_sin_lng}) > ${cos_allowed_distance} order by (abs(longitude -(${lng})) +( abs(latitude-(${lat}))*2.1))"$  
    '  
    Dim sheltersqry As String = $"SELECT * FROM shelters WHERE ${cur_sin_lat} * sinlat + ${cur_cos_lat} * coslat * (coslng * ${cur_cos_lng} + sinlng * ${cur_sin_lng}) > ${cos_allowed_distance} order by (abs(longitude -(${lng})) +( abs(latitude-(${lat}))*2.1))"$  
    
    vuetify.SetData("nearmepolice", policeqry)  
    vuetify.SetData("nearmecourts", courtsqry)  
    vuetify.SetData("nearmeclinics", clinicsqry)  
    vuetify.SetData("nearmeshelters", sheltersqry)  
    vuetify.pageresume  
    vuetify.NavigateTo($"/${sfindnearme}"$)  
End Sub
```

  
  
**Step 3: Knowing which points are nearer and which points where further?**  
  
This was possible with the ORDER BY clause.  
  

```B4X
(abs(longitude -(${lng})) +( abs(latitude-(${lat}))*2.1))"
```

  
  
This ensures that the first record on the list is the nearest and the one on the bottom of the list the further.  
  
The next plan will be to draw the points on the map.  
  
With BANano.Geolocation, one is also able to track in real time his/her own location, but remember, for this to work smart, a real mobile device is required. Running from a hosted ISP will definately report the location of your ISP.  
  
Whilst the Seeking.Shelter WebApp is built using BVAD3, the application here is broad and can be used in any BANano WebApp.  
  
If interested, you can check the source code for the WebApp, [**here**](https://github.com/Mashiane/SeekingShelter.Show-for-Women).  
  
Enjoy!