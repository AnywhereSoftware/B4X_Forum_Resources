### screen orientation - constant values by Dave O
### 07/11/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/132436/)

Just finishing reading some threads about setting screen orientation, and noticed that some threads were just using numeric values, and others were using constants with the *wrong* numeric values (e.g. sensorPortrait is 7, not 9).  
  
So I looked up the Android dev docs and compiled this list of constants that you can use with the **SetScreenOrientation** call from the **phone** library (or elsewhere in your code):  
  

```B4X
    Public Const ORIENTATION_UNSPECIFIED As Int = -1  
    Public Const ORIENTATION_LANDSCAPE As Int = 0  
    Public Const ORIENTATION_PORTRAIT As Int = 1  
    Public Const ORIENTATION_USER As Int = 2  
    Public Const ORIENTATION_BEHIND As Int = 3  
    Public Const ORIENTATION_SENSOR As Int = 4  
    Public Const ORIENTATION_NO_SENSOR As Int = 5  
    Public Const ORIENTATION_SENSOR_LANDSCAPE As Int = 6  
    Public Const ORIENTATION_SENSOR_PORTRAIT As Int = 7  
    Public Const ORIENTATION_REVERSE_LANDSCAPE As Int = 8  
    Public Const ORIENTATION_REVERSE_PORTRAIT As Int = 9  
    Public Const ORIENTATION_FULL_SENSOR As Int = 10  
    Public Const ORIENTATION_USER_LANDSCAPE As Int = 11  
    Public Const ORIENTATION_USER_PORTRAIT As Int = 12  
    Public Const ORIENTATION_FULL_USER As Int = 13  
    Public Const ORIENTATION_LOCKED As Int = 14
```

  
  
These values are described here in the Android docs. Some have been supported forever, some need somewhat newer Android versions:  
<https://developer.android.com/reference/android/R.attr?hl=el#screenOrientation>  
  
Hope this helps!