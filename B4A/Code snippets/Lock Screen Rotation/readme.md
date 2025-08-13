### Lock Screen Rotation by Robert Valentino
### 02/11/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/146089/)

A friend of mine asked me if there was a way to temporary stop screen rotation and then restore it.  
  
I didn't get into why they needed to do so, but gave them this code I had  
  

```B4X
Public  Sub LockUnLock_ScreenOrientation(xLock As Boolean)  
             Dim j As JavaObject  
      
             j.InitializeContext  
             j.RunMethod("jLockUnLock_ScreenOrientation",Array(xLock))  
End Sub  
  
#If JAVA  
 import android.content.pm.ActivityInfo;  
   
 public void jLockUnLock_ScreenOrientation(Boolean xlock)  
 {  
     if  (xlock) {  
        BA.Log("**** Lock Orientation");               
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LOCKED);  
    }  
    else {  
        BA.Log("**** UnLock Orientation");                   
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR);      
    }  
 }  
#End If
```

  
  

```B4X
            LockUnLock_ScreenOrientation(True)   ' Lock screen rotation  
            LockUnLock_ScreenOrientation(False)  ' Restore rotation and use sensor to determine which way
```

  
  
Seems to work just fine.  
  
Not sure if this helps anyone.  
  
BobVal