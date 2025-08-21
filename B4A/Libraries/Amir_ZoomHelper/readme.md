### Amir_ZoomHelper by User242424
### 08/08/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/121015/)

***[SIZE=5]Hello World![/SIZE]*  
[SIZE=5]Another B4A Library that makes any view to be zoomable. ?[/SIZE]**  
  
**[SIZE=6]Amir\_ZoomHelper [/SIZE]**  
  
[SIZE=4][MEDIA=youtube]SuN1ffQ2tbQ[/MEDIA][/SIZE]  
  
[SIZE=6]Usage : [/SIZE]  

```B4X
Private ZoomHelper As Amir_ZoomHelper  
ZoomHelper.Initialize("ZoomHelper",Activity)  
ZoomHelper.SetViewZoomable(View,True)
```

  
  
And you should add this java code to your activity :  

```B4X
#if java  
import com.aghajari.zoom.Amir_ZoomHelper;  
import android.view.MotionEvent;  
  
@Override  
public boolean dispatchTouchEvent(MotionEvent ev) {  
    return Amir_ZoomHelper.onDispatchTouchEvent(ev) || super.dispatchTouchEvent(ev);  
}  
#End If
```

  
  
Events :  

```B4X
'Initialize Event  
Sub ZoomHelper_onZoomStateChanged (ZoomableView As View,IsZooming As Boolean)  
  
ZoomHelper.SetDoubleClickListener("ZoomHelperClick",Image,200)  
Sub ZoomHelperClick_DoubleClick
```

  
  
Customize :  

```B4X
ZoomHelper.ShadowColor = Colors.Black  
ZoomHelper.AlphaFactory = 6  
ZoomHelper.MinScale = 1.0f  
ZoomHelper.MaxScale = -1 'Unlimited  
ZoomHelper.DialogThemeName = "Theme.AppCompat.Translucent"  
'set view tags (you may need this when you are using zoom in lists)  
ZoomHelper.SetViewTag(View,Tag)  
Log(ZoomHelper.GetViewTag(View))
```

  
  
  
**[SIZE=5]Works fine with Amir\_RecyclerView! [/SIZE]**  
[check out RecyclerView Sample!](https://www.b4x.com/android/forum/threads/amir_recyclerview-samples.120917/post-756441)  
  
Lib+Sample attached :)