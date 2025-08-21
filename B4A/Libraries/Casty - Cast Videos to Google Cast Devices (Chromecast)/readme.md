### Casty - Cast Videos to Google Cast Devices (Chromecast) by DonManfred
### 01/05/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/101768/)

This is a wrap for this [Github project](https://github.com/DroidsOnRoids/Casty). I started doing the wrap back in 2017 but did not got it working. A few tries later i now got it working ;-)  
  
**Casty  
Author:** DonManfred  
**Version:** 1.0  

*Class representing local media metadata.*

- **Fields:**

- **KEY\_CONTENT\_TYPE** As String
- **KEY\_IMAGES** As String
- **KEY\_STUDIO** As String
- **KEY\_SUBTITLE** As String
- **KEY\_TITLE** As String
- **KEY\_URL** As String

- **Functions:**

- **addImage** (url As String)
- **fromBundle** (wrapper As android.os.Bundle) As de.donmanfred.MediaItem
- **getImage** (index As Int) As String
- **hasImage** As Boolean
- **toBundle** As android.os.Bundle

- **Properties:**

- **ContentType** As String
- **Duration** As Int
- **Images** As java.util.ArrayList [read only]
- **Studio** As String
- **SubTitle** As String
- **Title** As String
- **Url** As String

- **CastSession**
*Class representing local media metadata.*

- **Functions:**

- **CastSessionWrapper** (session As com.google.android.gms.cast.framework.Session)
- **Initialize** (session As com.google.android.gms.cast.framework.Session)
- **IsInitialized** As Boolean

- **Properties:**

- **Category** As String [read only]
- **Connected** As Boolean [read only]
- **Connecting** As Boolean [read only]
- **Disconnected** As Boolean [read only]
- **Disconnecting** As Boolean [read only]
- **Resuming** As Boolean [read only]
- **SessionId** As String [read only]
- **SessionRemainingTimeMs** As Long [read only]
- **Suspended** As Boolean [read only]

- **Casty**

- **Events:**

- **onCastSessionUpdated** (session As Object, remoteMediaClient As Object)
- **onCastStateChanged** (State As Int)
- **onConnected()**
- **onDisConnected()**
- **onSessionEnded** (session As Object, info As Int)
- **onSessionEnding** (session As Object)
- **onSessionResumed** (session As Object, info As Boolean)
- **onSessionResumeFailed** (session As Object, info As Int)
- **onSessionResuming** (session As Object, info As String)
- **onSessionStarted** (session As Object, info As String)
- **onSessionStartFailed** (session As Object, info As Int)
- **onSessionStarting** (session As Object)
- **onSessionSuspended** (session As Object, info As Int)

- **Functions:**

- **addMediaRouteMenuItem** (menu As android.view.Menu)
- **addMinicontroller**
- **buildMediaInfo** (title As String, studio As String, subTitle As String, duration As Int, url As String, mimeType As String, imgUrl As String, bigImageUrl As String) As de.donmanfred.MediaItem
- **configure** (receiverId As String)
*Sets the custom receiver ID. Should be used in the {@link Application} class.  
 receiverId: the custom receiver ID, e.g. Styled Media Receiver - with custom logo and background*- **configureReceiver** (receiverId As String)
- **Initialize** (EventName As String)
- **loadMediaAndPlay** (mediaData As pl.droidsonroids.casty.MediaData)
- **loadMediaAndPlay3** (mediaInfo As com.google.android.gms.cast.MediaInfo, autoPlay As Boolean, position As Long)
- **loadMediaAndPlayInBackground** (mediaData As pl.droidsonroids.casty.MediaData)
- **loadMediaAndPlayInBackground3** (mediaInfo As com.google.android.gms.cast.MediaInfo, autoPlay As Boolean, position As Long)
- **pause**
- **play**
- **seek** (time As Long)
- **setUpMediaRouteButton** (menu As android.view.Menu, item As Int)
- **setUpMediaRouteButton2** (MediaButton As android.support.v7.app.MediaRouteButton)
- **togglePlayPause**

- **Properties:**

- **Buffering** [read only]
- **Connected** As Boolean [read only]
- **Paused** [read only]
- **Player** As pl.droidsonroids.casty.CastyPlayer [read only]
- **Playing** [read only]
- **UpMediaRouteButton** As android.support.v7.app.MediaRouteButton [write only]

- **IntroductoryOverlay**

- **Events:**

- **onOverlayDismissed()**

- **Functions:**

- **Initialize** (EventName As String, item As android.view.MenuItem)
- **onPause**
- **onResume**
- **remove**
- **setSingleTime**
- **show**

- **Properties:**

- **ButtonText** As String [write only]
- **FocusRadius** As Float [write only]
- **OverlayColor** As Int [write only]
- **TitleText** As String [write only]

- **MediaDataBuilder**

- **Functions:**

- **addPhotoUrl** (photoUrl As String) As MediaDataBuilder
- **build** As pl.droidsonroids.casty.MediaData
- **Initialize** (EventName As String, url As String) As MediaDataBuilder
- **IsInitialized** As Boolean
- **setAutoPlay** (autoPlay As Boolean) As MediaDataBuilder
- **setContentType** (contentType As String) As MediaDataBuilder
- **setMediaType** (mediaType As Int) As MediaDataBuilder
- **setPosition** (position As Long) As MediaDataBuilder
- **setStreamDuration** (streamDuration As Long) As MediaDataBuilder
- **setStreamType** (streamType As Int) As MediaDataBuilder
- **setSubtitle** (subtitle As String) As MediaDataBuilder
- **setTitle** (title As String) As MediaDataBuilder

- **MediaRouteButton**

- **Functions:**

- **BringToFront**
- **DesignerCreateView** (base As Panel, lw As Label, props As Map)
- **Initialize** (EventName As String, AppID As String)
- **Invalidate**
- **Invalidate2** (arg0 As android.graphics.Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized** As Boolean
- **RemoveView**
- **RequestFocus** As Boolean
- **SendToBack**
- **SetBackgroundImage** (arg0 As android.graphics.Bitmap) As BitmapDrawable
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)

- **Properties:**

- **Background** As android.graphics.drawable.Drawable
- **Color** As Int [write only]
- **DialogFactory** As android.support.v7.app.MediaRouteDialogFactory
- **Enabled** As Boolean
- **Height** As Int
- **Left** As Int
- **Padding** As Int()
- **Parent** As Object [read only]
- **RemoteIndicatorDrawable** As android.graphics.drawable.Drawable [write only]
- **RouteSelector** As android.support.v7.media.MediaRouteSelector
- **Tag** As Object
- **Top** As Int
- **Visibility** As Int [write only]
- **Visible** As Boolean
- **Width** As Int

  
Setup:  
- Make your App AppCompat-Compatible. It is mandatory as you need to use the Appcompat Menu creation…  

```B4X
Sub Activity_CreateMenu(Menu As ACMenu)  
    Menu.Clear  
    cast.addMediaRouteMenuItem(Menu)  
    Menu.Add(2, 4, "Overflow2", Null)  
    Menu.Add(3, 5, "Overflow3", Null)  
End Sub
```

  
and  

```B4X
#If Java  
public boolean _onCreateOptionsMenu(android.view.Menu menu) {  
    if (processBA.subExists("activity_createmenu")) {  
        processBA.raiseEvent2(null, true, "activity_createmenu", false, new de.amberhome.objects.appcompat.ACMenuWrapper(menu));  
        return true;  
    }  
    else  
        return false;  
}  
#End If
```

  
  
- Add the following to your main module  

```B4X
#Extends: android.support.v7.app.AppCompatActivity  
#AdditionalJar: com.google.android.gms:play-services-cast-framework  
#AdditionalJar: casty.aar
```

  
  
Add the following code to your Manifest  

```B4X
SetApplicationAttribute(android:theme, "@style/MyAppTheme")  
  
CreateResource(values, theme.xml,  
<resources>  
    <style name="MyAppTheme" parent="Theme.AppCompat.Light.NoActionBar">  
        <item name="colorPrimary">#0098FF</item>  
        <item name="colorPrimaryDark">#007CF5</item>  
        <item name="colorAccent">#AAAA00</item>  
        <item name="windowNoTitle">true</item>  
        <item name="windowActionBar">false</item>  
    </style>  
</resources>  
)  
AddApplicationText(  
<meta-data android:value="" android:name="app_id"></meta-data>  
)  
AddApplicationText(  
<activity  
  android:name="pl.droidsonroids.casty.ExpandedControlsActivity"  
  android:theme="@style/MyAppTheme" />  
<meta-data  
  android:name="com.google.android.gms.cast.framework.OPTIONS_PROVIDER_CLASS_NAME"  
  android:value="de.donmanfred.CastOptionsProvider" />  
<receiver android:name="com.google.android.gms.cast.framework.media.MediaIntentReceiver" />  
  
<service android:name="com.google.android.gms.cast.framework.media.MediaNotificationService" />  
<service android:name="com.google.android.gms.cast.framework.ReconnectionService" />  
)  
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)
```

  
  
Note that the line
> <meta-data android:value="" android:name="app\_id"></meta-data>

**can** be used to define YOUR App-ID though it is not needed. If the String is an Empty string then the default Receiverapp will do the Job.  
  
Update Jan 2020:  
It is mandatory to use your own app\_id which must be registered at the Google Cast Developer console.  
<https://cast.google.com/publish/#/overview>  
  
<https://support.google.com/cast-developer/answer/4512496?hl=en>  
  
[SIZE=6]**Before you begin**[/SIZE]  
  
There is a **one-time, non-refundable $5 registration fee** charged for a Google Cast Developer account. Google charge this fee to encourage higher quality applications utilizing Google Cast.  
  
  
  
You can see the Example on how to use everything.  
  
In short you can say that you can start Playing Videos when you successfully connected to the Cast device and a Session is opened.  
  

```B4X
Sub Casty_onConnected()  
    Log($"Casty_onConnected()"$)  
    Dim mb As MediaDataBuilder  
    mb.Initialize("","http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_normal.mp4").setAutoPlay(True).setContentType("videos/mp4").setMediaType(1).setStreamType(1).setTitle("DonManfred presents").setSubtitle("B4A Casting Video").addPhotoUrl("https://peach.blender.org/wp-content/uploads/bbb-splash.png?x11217")  
  
    cast.loadMediaAndPlayInBackground(mb.build)  
End Sub
```

  
  
![](http://snapshots.basic4android.de/chromecast_097.png)  
  
[MEDIA=youtube]ko7ZhSBSBmQ[/MEDIA]