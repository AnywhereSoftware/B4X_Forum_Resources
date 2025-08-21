### Amir_TileService by User242424
### 08/06/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/120948/)

Another B4A Library ?  
  
[SIZE=5]**Amir\_TileService (#B4A)**[/SIZE]  
**[SIZE=6]Quick Settings Tiles [/SIZE]**  
  
> Requiring that a user open your app is *so* 2008. Widgets and notifications have been around since the early days of Android to provide additional surfaces for displaying important controls and information from your app even when the app isn’t open. New in Android 7.0 (API 24), any app can now create a **quick settings tile** for quick access to critical pieces of functionality available above the notification tray.

  
![](https://miro.medium.com/max/405/0*zYn9jRHUGJTkE4CB.)  
  
Tiles gives the user quick access to a specific task or functionality of the app without opening the app itself,  
improving the productivity and overall user-experience of the app.   
  
[SIZE=7]**Building a TileService :**  
1. Create an StandardClass for TileService Events :[/SIZE]  
  

```B4X
Private Sub Class_Globals  
End Sub  
  
Public Sub Initialize (TileService As Amir_TileService)  
    'Amir_TileService will create and initialize this class!  
End Sub  
  
Private Sub TileService_Clicked (TileService As Amir_TileService)  
    'Called when the user clicks on this tile.  
End Sub  
  
Private Sub TileService_Added (TileService As Amir_TileService)  
    'Called when the user adds this tile to Quick Settings.  
End Sub  
  
Private Sub TileService_Removed (TileService As Amir_TileService)  
    'Called when the user removes this tile from Quick Settings.  
End Sub  
  
Private Sub TileService_StartListening (TileService As Amir_TileService)  
    'Called when this tile moves into a listening state. (when the Tile becomes visible)  
End Sub  
  
Private Sub TileService_StopListening (TileService As Amir_TileService)  
    'Called when this tile moves out of the listening state. (when the tile is no longer visible)  
End Sub
```

  
[FONT=tahoma][/FONT]  
[FONT=arial][SIZE=6]2. Manifest Codes[/SIZE][/FONT]  

```B4X
AddApplicationText(  
<service  
    android:name="com.aghajari.tileservice.TileService"  
    android:icon="$ICON$"  
    android:label="$LABEL$"  
    android:permission="android.permission.BIND_QUICK_SETTINGS_TILE">  
      
    <meta-data android:name="com.aghajari.tileservice.TileService"  
               android:value="$StandardClassName$" />  
      
    <intent-filter>  
        <action android:name="android.service.quicksettings.action.QS_TILE" />  
    </intent-filter>  
</service>)
```

  
**Icon** : default tile icon (Ex: [ICODE]android:icon="@android:drawable/ic\_media\_play"[/ICODE])  
**Label** : default tile label  
**StandardClassName** : name of the class that you created in first step  
  
**[SIZE=5]And we are done! ?[/SIZE]**  
  
You can update the Tile info from the class events. Example :   

```B4X
Private Sub TileService_Clicked (TileService As Amir_TileService)  
    Dim Tile As Amir_Tile = TileService.QsTile  
    Tile.State = Tile.STATE_ACTIVE  
    Tile.Icon = Tile.CreateIconWithAndroidResource("ic_media_pause")  
    Tile.Label = "Connected"  
    Tile.ContentDescription = "AmirTileService"  
    Tile.UpdateTile  
End Sub
```

  
  
You can request an update for tile whenever you want . Example :  

```B4X
Dim p As Phone  
If p.SdkVersion>=24 Then  
    Dim TS As Amir_TileService  
    TS.Initialize(Null)  
    TS.RequestListeningState2(1)  
End If
```

  
  
[SIZE=6]Tile States :[/SIZE]  

- [*STATE\_ACTIVE*](https://developer.android.com/reference/android/service/quicksettings/Tile.html?utm_campaign=adp_series_quicksettingstiles_092916&utm_source=medium&utm_medium=blog#STATE_ACTIVE) which is the on/enabled state
- [*STATE\_INACTIVE*](https://developer.android.com/reference/android/service/quicksettings/Tile.html?utm_campaign=adp_series_quicksettingstiles_092916&utm_source=medium&utm_medium=blog#STATE_INACTIVE) which is the off/disabled state
- [*STATE\_UNAVAILABLE*](https://developer.android.com/reference/android/service/quicksettings/Tile.html?utm_campaign=adp_series_quicksettingstiles_092916&utm_source=medium&utm_medium=blog#STATE_UNAVAILABLE) which disables the click action for your tile

Depending on the state of the Tile, the icon will automatically be tinted.   
![](https://miro.medium.com/max/700/1*ZkkIMFPbUec04QsJ5Rq7gA.png)  
  
  
***Quick Settings Tiles supports Android 7.0 (API 24) and above!***  
Document : <https://developer.android.com/reference/android/service/quicksettings/TileService>  
[also read about quick settings tiles in Medium](https://medium.com/androiddevelopers/quick-settings-tiles-e3c22daf93a8)  
  
Lib+Sample attached :)