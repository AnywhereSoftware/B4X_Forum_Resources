### Explain to user why a permission is needed before displaying Android's cryptic permission prompt by JohnC
### 06/06/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/114979/)

Below is some sample code I use to display the reason why my app needs a particular permission so that the user is well informed of why its needed before I let Android display it's cryptic and sometimes dangerous sounding permission prompts, such as "Allow MyApp to access photos, media, and files on your device?".  
  
This code:  
  
1) Checks to see if the user already gave permission by returning TRUE when called  
2) If the user did not previously give permission, it will first display why the permission is needed, then let android prompt them for it and return their answer  
  
Because this functionality is in just one sub, you can easily call it from various parts of your app when the permission is needed instead of confusing and putting a burden on the user by asking for all the app permissions when they first run your app.  
  

```B4X
Sub cmdSoundPick_Click  
    '**** this is a sample sub that calls the routine I am providing below ****  
    'allows user to pick a notification sound  
  
    Wait for (CheckReadStoragePermission) Complete (Result As Boolean)   'if user already gave permission, then continue below…  
    If Result = False Then Return  'otherwise exit if no permission  
  
    rm.ShowRingtonePicker("rm", Bit.Or(rm.TYPE_RINGTONE, Bit.Or(rm.TYPE_ALARM,rm.TYPE_NOTIFICATION)), False, cmdSoundPick.tag)  
End Sub  
  
Sub CheckReadStoragePermission As ResumableSub  
    If Starter.rp.Check(Starter.rp.PERMISSION_READ_EXTERNAL_STORAGE) = False Then  'see if user already gave permission  
        'if here, then user did not give permission, so display why we need it  
        MsgboxAsync("In order for this app to play a built-in sound on your phone, it needs 'Read-Only' access to your phone's 'Media'. The following screen will ask for that permission. If you deny this permission, then you will not be able to select a custom sound.","Sound Permission")  
        Wait For MsgBox_Result (Result As Int)  
  
        Starter.rp.CheckAndRequest(Starter.rp.PERMISSION_READ_EXTERNAL_STORAGE)   'prompt user for permission because they did not already give it  
        Wait For Activity_PermissionResult (Permission As String, AskResult As Boolean)  
        Return AskResult   'return user choice  
    Else  
        Return True   'user already gave permission, so just return true (no prompt needed)  
    End If  
End Sub
```