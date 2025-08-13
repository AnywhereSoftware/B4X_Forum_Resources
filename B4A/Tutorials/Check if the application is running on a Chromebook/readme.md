### Check if the application is running on a Chromebook by yo3ggx
### 01/16/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/145496/)

If you want to check if the application is running on a Chromebook (for example to do some specific GUI reconfiguration to run in a resizable Window), you can use the following routine.  
Hope it helps. Returns true if is a Chromebook, False otherwise.  

```B4X
Sub isChromebook As Boolean  
#If JAVA  
import android.content.Context;  
import android.content.pm.FeatureInfo;  
import android.content.pm.PackageManager;  
public static final String ARC_FEATURE = "org.chromium.arc";  
public static final String ARC_DEVICE_MANAGEMENT_FEATURE = "org.chromium.arc.device_management";  
  
     /** Returns true if the device has a given system feature */  
    public boolean hasSystemFeature(String feature) {  
        return getPackageManager().hasSystemFeature(feature);  
    }  
      
    /** Returns {@code true} if device is an ARC++ device. */  
    public boolean isArc() {  
        return hasSystemFeature(ARC_FEATURE) || hasSystemFeature(ARC_DEVICE_MANAGEMENT_FEATURE);  
    }  
  
#End If  
    Dim ctx As JavaObject  
    ctx.InitializeContext  
    Return ctx.RunMethod("isArc",Null)  
End Sub
```