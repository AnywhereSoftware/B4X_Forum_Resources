### [BANanoVuetifyAD3] Help me run gmap-cluster and get latlng in events (gmap_CenterChanged, gmap_mousemove, gmap_click) by NGUYEN TUAN ANH
### 11/01/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/157147/)

Dear Mr [USER=44364]@Mashiane[/USER] and all,  
i comeback to research BANanoVuetifyAD3 in Google Map subject  
I see in VueGmap module has Sub Use:  

```B4X
Sub Use(vuetify As VuetifyApp)  
        'ensure that the module is loaded  
        If vuetify.ModuleExist("googlemap") = False Then  
            Dim VueGoogleMaps As BANanoObject  
            VueGoogleMaps.Initialize("GmapVue")  
            Dim opt As Map = CreateMap()  
            BANanoShared.PutRecursive(opt, "load.key", mGoogleMapKey)  
            BANanoShared.PutRecursive(opt, "load.libraries", "places,directions,drawing")  
            BANanoShared.PutRecursive(opt, "installComponents", True)  
            BANanoShared.PutRecursive(opt, "autobindAllEvents", True)  
            vuetify.Use1(VueGoogleMaps, opt)  
'————————————————-  
'        Dim Cluster As BANanoObject = VueGoogleMaps.GetField("Cluster")  
'        google = VueGoogleMaps.GetField("gmapApi")  
'        vuetify.ImportComponentBO("gmap-cluster", Cluster)  
'——————————————————  
            vuetify.AddModule("googlemap")  
        End If  
End Sub
```

  
  
Could you please Help me run gmap-cluster in Google Map.  
Additional, help me get latitude, longtitude in some events (gmap\_CenterChanged, gmap\_mousemove, gmap\_click)  
Thanks you very much  
Best Regards.