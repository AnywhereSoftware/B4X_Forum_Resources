### Consent Code Class by Robert Valentino
### 11/23/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/111616/)

**Description**: Display privacy policy webpage and then user has to Accept or Deny  
  
**Version:** 1  
  
**SubName:** cConsent  
  
Google has been driving me nuts with this Privacy Stuff.  
  
Real pain for me, because I do not have ADs and do nothing with users data.  
  
So I wrote this cConsent Class  
  
To use is pretty simple  
  
In Main:  
  

```B4X
Sub Globals  
  
Private mConsent as cConsent  
  
end sub  
  
#Region ConstantState  
Public Sub    Consent_StateAvailable  
  
           If  mConsent.IsInitialized = False Then  
               mConsent.Initialize(Activity)  
           End If  
           
           wait for (mConsent.WaitForResult(False)) complete (ConsentGiven As Boolean)  
               
           If  ConsentGiven = False Then  
               Activity.Finish  
           End If  
           
           CallSubDelayed(Starter, "Continue_Create")               
End Sub  
#end Region  
  
Private Sub Activity_Pause (UserClosed As Boolean)  
           If  mConsent.IsInitialized And mConsent.IsShowing Then  
               mConsent.EndShowing(True)  
               Activity.Finish  
           End If  
  
          …. rest of activity pause  
End Sub
```

  
  
In Starter:  

```B4X
#Region Service_Create / Service_Start  
Public  Sub Service_Create   
  
             Do  While IsPaused(Main)  
                   Sleep(100)  
               Loop  
           
               CallSubDelayed(Main, "Consent_StateAvailable")           
End Sub  
  
Public Sub Continue_Create   
         ……. finish up starter stuff  
end sub
```

  
  
  
Hope this makes life easier for someone  
  
BobVal