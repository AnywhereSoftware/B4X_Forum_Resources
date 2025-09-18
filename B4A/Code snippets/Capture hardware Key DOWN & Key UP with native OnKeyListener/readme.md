###  Capture hardware Key DOWN & Key UP with native OnKeyListener by scsjc
### 09/14/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168632/)

I’m attaching a minimal snippet in case anyone needs reliable **key DOWN & key UP** detection in B4A—useful for shooter-style games or any scenario where you must **avoid repeat triggers** and **don’t want to use any debounce/timer** logic. It uses a native OnKeyListener and just logs the first DOWN (ignores repeats) and the UP.  
  
  

```B4X
' === Globals ===  
Private KeyListener As Object  
  
Sub Activity_Create(FirstTime As Boolean)  
    InstallNativeKeyListener  
End Sub  
  
Private Sub InstallNativeKeyListener  
    Dim jo As JavaObject = Activity  
    jo.RunMethod("setFocusableInTouchMode", Array(True))  
    jo.RunMethod("requestFocus", Null)  
    ' Create the native OnKeyListener without writing inline Java  
    KeyListener = jo.CreateEvent("android.view.View$OnKeyListener", "K", Null)  
    jo.RunMethod("setOnKeyListener", Array(KeyListener))  
End Sub  
  
' Native handler: captures DOWN/UP and ignores autorepeat using getRepeatCount()  
Private Sub K_Event (MethodName As String, Args() As Object) As Object  
    ' Args = [View v, int keyCode, KeyEvent event]  
    Dim keyCode As Int = Args(1)  
    Dim ev As JavaObject = Args(2)  
    Dim action As Int = ev.RunMethod("getAction", Null)        ' 0 = ACTION_DOWN, 1 = ACTION_UP  
    Dim repeats As Int = ev.RunMethod("getRepeatCount", Null)  ' 0 on the first DOWN  
  
    ' Example: use VOL+ (24) and ENTER (66) as shutter keys  
    If keyCode = 24 Or keyCode = 66 Then  
        If action = 0 Then                 ' ACTION_DOWN  
            If repeats = 0 then  
                   Log($"DOWN ${keyCode} rep=${repeats}"$)  
            end if  
            Return True  
        Else If action = 1 Then            ' ACTION_UP  
            Log($"UP ${keyCode}"$)  
            Return True  
        End If  
    End If  
  
    ' Other keys: don't consume  
    Return False  
End Sub
```