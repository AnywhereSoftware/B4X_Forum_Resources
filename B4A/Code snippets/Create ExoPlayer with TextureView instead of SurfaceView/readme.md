### Create ExoPlayer with TextureView instead of SurfaceView by Erel
### 10/23/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163710/)

There are some cases where you need to create an ExoPlayer with TextureView. TextureView can be customized more easily.  
  
1. Add to manifest editor:  

```B4X
CreateResource(layout, layout1.xml,   
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"  
  android:paddingLeft="16dp"  
  android:paddingRight="16dp"  
  android:layout_width="100dp"  
    android:layout_height="100dp"  
  android:orientation="vertical" >  
<androidx.media3.ui.PlayerView  android:id="@+id/exoplayer1"  
    android:layout_width="match_parent" android:layout_height="wrap_content"  
    xmlns:android="http://schemas.android.com/apk/res/android"  
    xmlns:app="http://schemas.android.com/apk/res-auto"  
    app:surface_type="texture_view"  
/>  
</LinearLayout>  
)
```

  
  
2.

```B4X
Private Sub GetSimpleExoPlayerView As SimpleExoPlayerView  
    Dim x As XmlLayoutBuilder  
    x.LoadXmlLayout(Root, "layout1") 'Change to Activity if not B4XPages  
    For Each v As B4XView In Root.GetAllViewsRecursive  
        If GetType(v) = "androidx.media3.ui.PlayerView" Then  
            v.Parent.RemoveViewFromParent  
            v.RemoveViewFromParent  
            Return v  
        End If  
    Next  
    Return Null  
End Sub
```

  
  
Example of flipped video player:  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private Player As SimpleExoPlayer  
    Private PlayerView As SimpleExoPlayerView  
    Private Panel1 As B4XView  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Player.Initialize("player")  
    PlayerView = GetSimpleExoPlayerView  
    PlayerView.Player = Player  
    Panel1.AddView(PlayerView, 0, 0, Panel1.Width, Panel1.Height)  
    Dim TextureView As JavaObject = PlayerView.As(JavaObject).RunMethod("getVideoSurfaceView", Null)  
    TextureView.RunMethod("setScaleX", Array((-1).As(Float)))  
    Player.Prepare(Player.CreateUriSource("https://bestvpn.org/html5demos/assets/dizzy.mp4"))  
End Sub
```