### Capture volume keys events while app is in the background by toby
### 11/25/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/124899/)

Could some Java guru kindly convert the following codes into B4A code for me, if possible, please? I would greatly appreciate it!   
  
I'm looking for a reliable solution as a background service to intercept volume key press events with screen off(just anything indicating key\_press is enough for my app, either Up or Down key).   
I've tried both [intent based solution](https://www.b4x.com/android/forum/threads/intercept-volume-button-press.28179/post-163378) and [BroadcastReceiver approach](https://www.b4x.com/android/forum/threads/broadcastreceiver-to-know-volume_up-or-volume_down-is-pressed.72011/post-457770), and neither of them meets my need.  
  
I found the [following Java code on StackOverflow website](https://stackoverflow.com/questions/10154118/listen-to-volume-buttons-in-background-service/43304591#43304591).   
  

```B4X
import android.app.Service;  
import android.content.Intent;  
import android.os.IBinder;  
import android.support.v4.media.VolumeProviderCompat;  
import android.support.v4.media.session.MediaSessionCompat;  
import android.support.v4.media.session.PlaybackStateCompat;  
  
public class PlayerService extends Service {  
    private MediaSessionCompat mediaSession;  
  
    [USER=69643]@override[/USER]  
    public void onCreate() {  
        super.onCreate();  
        mediaSession = new MediaSessionCompat(this, "PlayerService");  
        mediaSession.setFlags(MediaSessionCompat.FLAG_HANDLES_MEDIA_BUTTONS |  
                MediaSessionCompat.FLAG_HANDLES_TRANSPORT_CONTROLS);  
        mediaSession.setPlaybackState(new PlaybackStateCompat.Builder()  
                .setState(PlaybackStateCompat.STATE_PLAYING, 0, 0) //you simulate a player which plays something.  
                .build());  
  
        //this will only work on Lollipop and up, see https://code.google.com/p/android/issues/detail?id=224134  
        VolumeProviderCompat myVolumeProvider =  
                new VolumeProviderCompat(VolumeProviderCompat.VOLUME_CONTROL_RELATIVE, /*max volume*/100, /*initial volume level*/50) {  
            [USER=69643]@override[/USER]  
            public void onAdjustVolume(int direction) {  
                /*  
                -1 – volume down  
                1 – volume up  
                0 – volume button released  
                 */  
            }  
        };  
  
        mediaSession.setPlaybackToRemote(myVolumeProvider);  
        mediaSession.setActive(true);  
    }  
  
  
    [USER=69643]@override[/USER]  
    public IBinder onBind(Intent intent) {  
        return null;  
    }  
  
    [USER=69643]@override[/USER]  
    public void onDestroy() {  
        super.onDestroy();  
        mediaSession.release();  
    }  
}
```

  
  

```B4X
<application …>  
    …  
    <service android:name=".PlayerService"/>  
</application>
```

  
  

```B4X
[USER=69643]@override[/USER]  
protected void onCreate(Bundle savedInstanceState) {  
    super.onCreate(savedInstanceState);  
    …  
    startService(new Intent(this, PlayerService.class));  
}
```

  
  
  
TIA