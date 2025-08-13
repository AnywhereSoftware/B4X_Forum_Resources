### Android Live Wallpaper tutorial by Erel
### 10/14/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/12605/)

The user can set live wallpapers by long pressing on the home screen and choosing Wallpapers - Live Wallpapers.  
Creating a live wallpaper is not too difficult.  
A service is responsible for handling the wallpaper events and drawing the wallpaper.  
  
There can be several instances of the same wallpaper at the same time. For example the user can set your wallpaper as the home screen wallpaper and also see a demo of your wallpaper in the wallpaper preview dialog.  
  
LiveWallpaper library contains two objects: LWManager and LWEngine.  
LWManager is responsible for raising the events.  
The first parameter of each event is of type LWEngine. LWEngine represents a specific wallpaper instance.  
LWEngine includes a Canvas property which is used to draw the wallpaper.  
When you finish drawing you must call LWEngine.Refresh or LWEngine.RefreshAll. Otherwise the drawing will not appear.  
  
As there could be several different engines, it is convenient to work with the local engine.  
LWEngine includes a Tag property which you can use to store data specific to that engine.  
  
LWManager includes an internal timer that you can use if you need to do animations. The Tick event will only be raised for visible wallpapers. This is important to conserve battery.  
  
For example the following code draws the time on the wallpaper:  

```B4X
Sub Process_Globals  
   Dim lwm As LWManager  
End Sub  
  
Sub Service_Create  
   lwm.Initialize("lwm", True)  
   lwm.StartTicking(1000) 'tick every second  
End Sub  
  
Sub LWM_Tick (Engine As LWEngine)  
   Engine.Canvas.DrawColor(Colors.Black) 'Erase the background  
   Engine.Canvas.DrawText(DateTime.Time(DateTime.Now), _  
      300dip, 100dip, Typeface.DEFAULT_BOLD, 40, Colors.White, "LEFT")  
   Engine.RefreshAll  
End Sub
```

  
![](http://www.b4x.com/basic4android/images/SS-2011-11-15_11.23.06.png)  
  
**Offsets**  
  
On most devices the wallpaper virtual size is wider than a single screen. When the user moves to a different screen the offset changes.  
You can use the OffsetChanged event to handle those changes.  
LWEngine.FullWallpaperWidth / Height return the full size of the wallpaper.  
LWEngine.CurrentOffsetX / Y return the current position.  
Note that the wallpaper scrolls less than the foreground layer with the icons.  
  
The LiveWallpaperImage demonstrates how to use those properties to display an image over the full wallpaper.  
  
**LWManager events**  
  
*SizeChanged* - Raised when the engine is first ready and when the screen size changes (for example when the orientation changes).  
*VisibilityChanged* - Raised when a wallpaper becomes visible or invisible.  
*Touch* - Raised when the user touches the wallpaper.  
*Tick* - The internal timer tick event.  
*OffsetChanged* - Raised when the wallpaper offsets change.  
*EngineDestroyed* - Raised when an engine is destroyed.  
  
**Configuration**  
  
Manifest editor:  

```B4X
AddApplicationText(  
<service  
        android:label="My Livewallpaper"  
        android:name="anywheresoftware.b4a.objects.WallpaperInternalService"  
        android:permission="android.permission.BIND_WALLPAPER"  
        android:exported="true">  
        <intent-filter >  
            <action android:name="android.service.wallpaper.WallpaperService" />  
        </intent-filter>  
        <meta-data android:name="android.service.wallpaper" android:resource="@xml/wallpaper" />  
</service>  
)  
CreateResource(xml, wallpaper.xml,  
<wallpaper xmlns:android="http://schemas.android.com/apk/res/android"  
  android:thumbnail="@drawable/icon"  
/>  
)
```

  
  
**Updates**  
  
- v1.10 - fixes issues related to targetSdkVersion=34. Previous versions will not work.  
- Example was updated. It is based on B4XPages. The XML resource is created in the manifest editor directly.  
  
![](https://www.b4x.com/android/forum/attachments/157541)  
  
**Copy the updated library to the internal libraries folder.**