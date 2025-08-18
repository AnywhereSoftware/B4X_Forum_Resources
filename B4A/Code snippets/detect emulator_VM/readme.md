### detect emulator/VM by AbdurRahman
### 04/05/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/129393/)

**getRadioVersion()** always returns empty on VM,  
and returns version number on real android device.  

```B4X
Sub Process_Globals  
    Private Native As JavaObject  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    If FirstTime Then Native.InitializeContext  
  
    Dim IsVM As Boolean = Native.RunMethod("IsVM", Null)  
    If IsVM Then  
        MsgboxAsync("You are using Virtual Environment","IsVM ?")  
    Else  
        MsgboxAsync("You are using Real Environment","IsVM ?")  
    End If  
      
End Sub  
  
#If JAVA  
public Boolean IsVM()  
{  
    return android.os.Build.getRadioVersion().trim().length() == 0;  
}  
#End If
```

  
Not sure, why this happens, but I know it just works. ?  
I don't have official explanation for this.  
  
**Code:** [github.com/Back-X/anti-vm/blob/main/android/anti-vm.b4a](http://github.com/Back-X/anti-vm/blob/main/android/anti-vm.b4a)  
**Release:** [github.com/Back-X/anti-vm/releases/download/1/anti-vm.apk](http://github.com/Back-X/anti-vm/releases/download/1/anti-vm.apk)