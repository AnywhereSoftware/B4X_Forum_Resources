### Dynamically detect change of device orientation portrait<=>landscape - FROM A SERVICE - courtesy of Claude Code. by JackKirk
### 06/11/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171235/)

This code allows you to dynamically detect change of device orientation portrait<=>landscape - **from a service** - courtesy of Claude Code.  
  
Took me about 15 minutes - and I don't do Java :)  

```B4X
'************************************************************************************  
'  
'This procedure gets control when device physical orientation flips between portrait  
'and landscape - raised by OrientationEventListener in inline Java below  
'  
   
'Input parameters are:  
'  
'       Orientation = 1 = portrait (upright or upside down), 2 = landscape  
'  
'Returns:  
'  
'       -  
'  
'Notes on this procedure:  
'  
'       o Listener is accelerometer driven so fires regardless of which app is in  
'         foreground, rotation lock state, or whether Main is paused  
'       o Java side maps raw degrees to buckets around a 30 degree threshold -  
'         landscape (green) when 25 degrees or less off horizontal, portrait (red)  
'         when more than 30 off - strips therefore go red before camera's own  
'         ~45 degree snap point would start classifying shots as portrait  
'       o 25-30 degree band is 5 degree hysteresis - last bucket retained - so  
'         color can not flicker from sensor jitter at boundary - event raised  
'         only when bucket changes  
'       o No event when phone is flat - degrees are indeterminate so last bucket  
'         is retained  
'  
'************************************************************************************  
Private Sub OrientationChanged(Orientation As Int)  
  
    'If portrait…  
    If Orientation = 1 Then  
  
        '…  
  
    'Otherwise landscape…  
    Else  
  
        '…  
  
    End If  
  
End Sub  
  
#If Java  
private static android.view.OrientationEventListener _orientListener;  
private static int _lastOrientBucket = 0;  
  
public static void StartOrientationListener() {  
    if (_orientListener != null) return;  
    _orientListener = new android.view.OrientationEventListener(BA.applicationContext) {  
        @Override  
        public void onOrientationChanged(int degrees) {  
            if (degrees == ORIENTATION_UNKNOWN) return;  
            int bucket = _lastOrientBucket;  
            // distance from nearest horizontal axis (90 or 270)  
            int d = Math.min(Math.abs(degrees - 90), Math.abs(degrees - 270));  
            if (d <= 25) bucket = 2;     // within 25 of landscape - green  
            else if (d > 30) bucket = 1; // more than 30 off landscape - red  
            // 25-30 = 5 degree hysteresis band - retain last bucket - prevents strip  
            // flicker from sensor jitter at boundary - default unresolved start to red  
            if (bucket == 0) bucket = 1;  
            if (bucket != _lastOrientBucket) {  
                _lastOrientBucket = bucket;  
                processBA.raiseEventFromUI(null, "orientationchanged", bucket);  
            }  
        }  
    };  
    if (_orientListener.canDetectOrientation()) _orientListener.enable();  
}  
  
public static void StopOrientationListener() {  
    if (_orientListener != null) {  
        _orientListener.disable();  
        _orientListener = null;  
    }  
}  
#End If
```