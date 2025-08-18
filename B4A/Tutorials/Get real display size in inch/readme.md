### Get real display size in inch by yo3ggx
### 03/27/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/139343/)

Hello,  
  
Maybe this can be useful for others.  
You can get the exact screen diagonal size (in inch) using the following simple routine.  
  

```B4X
Sub GetDevicePhysicalSize As Double  
#If JAVA  
import android.graphics.*;  
import android.util.DisplayMetrics;  
public double getScreenSizeOfDevice() {  
    Point point = new Point();  
    getWindowManager().getDefaultDisplay().getRealSize(point);  
    DisplayMetrics dm = getResources().getDisplayMetrics();  
    double x = Math.pow(point.x/ dm.xdpi, 2);  
    double y = Math.pow(point.y / dm.ydpi, 2);  
    double screenInches = Math.sqrt(x + y);  
    return screenInches;  
}  
#End If  
    Return NativeMe.RunMethod("getScreenSizeOfDevice", Null)  
End Sub
```

  
  
Tested on Android 4.4 (LG GPad 8.3), 5.1 (Xperia ZL), 11 (Lenovo Yoga Tab 13) and 12 (Pixel 3a) with perfect results.