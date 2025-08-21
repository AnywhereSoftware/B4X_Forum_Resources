### Running B4A Apps in Split Screen Mode by agraham
### 07/03/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/119715/)

**Tutorial – Running B4A Apps in Split Screen Mode**  
  
I’m learning this as I go along so there may be errors of fact. If so then post a correction below and I will modify this tutorial accordingly.  
  
I’ve been playing with split screen mode, in anticipation of the forthcoming foldable and dual screen devices, to see what implications there are when trying to use this capability for B4A apps. The good news is that it seems to work quite well!  
  
Since Android 7 it has been possible to run two apps side by side in split screen mode. Any app targeting API 24 or above will, by default, run in a split screen although the layout will probably need adjustment to make this an acceptable user experience  
  
On Android 9 and below only one of the two apps displayed in split screen mode can be in a resumed state, the other will be paused. Under Android 10 and later both apps will be resumed. I find it quite impressive to see two mapping programs running side by side both positioning their maps from GPS data with one showing a 50K overview map and the other a detailed street level map.  
  
Normally in split screen mode when an app starts another activity the new activity displays on top of the starting activity as normal. It is possible to start the new activity alongside the old one with one activity resumed and the other paused. You can switch between the activities by touching one or the other which will then resume whilst the other pauses. On Android 10 or later both activities will be resumed at the same time as long as the app targets API 29 or above.  
  
Let’s take this a step at a time  
  
  
Making a B4A app split screen aware  
  
It seems that on any individual device LoadLayout will only ever select one portrait and one landscape variant. This means that is it not possible to have a third variant in a layout which is sized for split screen use. As a layout suitable for split screen use will usually be almost square this means that in split screen mode a different layout will be needed, but probably only a single variant will be needed for both landscape and portrait orientations. Bear in mind that you will have less than half the usual screen area to play with so the split screen layout may need to be rather different to the full screen one.  
  
So first we need to establish whether we are in split screen mode like this  

```B4X
Sub IsSplitMode As Boolean  
    Dim jo As JavaObject  
    jo.InitializeContext  
    Try  
        Return jo.RunMethod("isInMultiWindowMode", Null)  
    Catch  
        Return False  
    End Try  
End Sub
```

  
Now we have this we can use it to load our split screen layout in Activity\_Create  

```B4X
If IsSplitMode Then  
      Activity.LoadLayout("Square") ' Single variant caters for split screen both landscape and portrait  
Else  
      Activity.LoadLayout("Main") ' Two individual variants for full screen landscape and portrait  
End If
```

  
  
That’s it! Your app should now adapt nicely to split screen mode.  
  
The above code has assumes that the app is running on a single screen phone and that the split screen layout can use a single almost square layout for both landscape and portrait orientations. When we see actual foldable and dual screen devices this assumption will probably be wrong and more sophisticated layout choice logic will be required once we see how the various permutations of normal and split screen sizes work in practice.  
  
  
Starting another Activity alongside  
  
Rather than a newly started activity overlaying the calling one it is possible to have the new activity start alongside it in Android 7 and later. If both activities are to be resumed simultaneously the app must be running on Android 10 and the manifest must target API 29 or later.  

```B4X
Sub StartActivityAlongSide(act As Object)  
    Dim ctxt As JavaObject  
    ctxt.InitializeContext  
    Dim jin As JavaObject  
    Dim in As Intent = jin.InitializeNewInstance("android.content.Intent", Array(ctxt, act))  
    'add flags here  
    in.Flags = in.Flags + 0x00001000 +  0x10000000 ' FLAG_ACTIVITY_LAUNCH_ADJACENT + FLAG_ACTIVITY_NEW_TASK  
    StartActivity(in)  
End Sub
```

  
You can then perhaps have a ‘SideBySide’ checkbox in your split screen layout that chooses whether to overlay a new activity or to start it alongside.  

```B4X
      If chkSideBySide.Checked Then  
        StartActivityAlongSide(Viewer)  
      Else  
        StartActivity(Viewer)  
      End If
```

  
  
At the moment it seems that it is better to decide whether the additional activities are alongside or not and to maintain that choice while the app is open. When switching between alongside and overlaid activities it seems possible to end up with two instances of the same activity, one overlaid and one alongside which is probably not intended.  
  
  
That’s all for now folks! Attached is a project that tries to demonstrate the above.  
  
EDIT: Here's an additional bit of code to determine if the device is in portrait or landscape orientation  

```B4X
Sub IsPortrait As Boolean  
    Dim jo As JavaObject  
    jo.InitializeContext  
    jo = jo.RunMethod("getResources", Null)  
    jo = jo.RunMethod("getConfiguration", Null)  
    Dim i As Int = jo.GetField("orientation")  
    If i = 2 Then  
        Return False  
    End If  
    Return True  
End Sub
```