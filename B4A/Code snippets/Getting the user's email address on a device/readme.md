### Getting the user's email address on a device by Dave O
### 03/31/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/160193/)

I just spent two days trying to puzzle out how to get some user details (first name and email) from the device, so that I don't have to ask them to enter it (and possibly enter the wrong account's email or mistype it).  
  
There are several old forum posts about this, but they're tedious to wade through and cross-reference, so I thought my solution (a mash-up of existing ones) might be easier to grab here in a single snippet.  
  
**Background**  
I wanted the first name of the user and their account's email address, so I could use them in my app for sharing data between devices. I hoped that I could just ask Android for this (for the current user) so it would save them some typing (and mis-typing).  
  
**Methods**  
There are several ways to do this, but after lots of experimenting, I found that:  

- Using [ContentResolver](https://www.b4x.com/android/forum/threads/owner-accounts-with-all-field.41101/post-246786) gave me the full name but not a reliable email address (often nothing).

- Devices before Android 6 needed a manifest permission (android.permission.READ\_CONTACTS), which might spook some users as a dangerous permission. Silent after that.
- Devices with Android 6+ needed the same as a runtime permission, a bit less spooky because you can tell them what you need it for just beforehand. Silent after that.

- Using **AccountManager.getAccountsByType** got me the email address, but not the name, and only worked on devices before Android 8.

- Devices before Android 6 needed a manifest permission (android.permission.GET\_ACCOUNTS), which might spook some users as a dangerous permission. Silent after that.
- Devices with Android 6-7 needed the same as a runtime permission, a bit less spooky because you can tell them what you need it for just beforehand. Silent after that.

- Using **AccountManager.newChooseAccountIntent** got me the email address, but not the name, and works on Android 6+.

- No permission needed (yay!), but pops up an account picker each time.

The email address is the main thing I wanted, so I decided to give up on the first name and just use the second and third methods.  
  
Here's a code excerpt that should get you most of the way there:  
  

```B4X
sub getAccountEmail  
    If sdkVersion < 23 Then                                '< Android 6 - permission already granted in manifest file  
        userEmail = getAccountsForOlderDevices.Get(0)  
    else If sdkVersion < 26 Then                           'Android 6-7 - need runtime permission  
        warnAboutGetAccountPermission  
    Else                                                   '>= Android 8 - use account picker (no permission needed)  
        warnAboutPickingAccount  
    End If  
end sub  
  
'https://www.b4x.com/android/forum/threads/owner-accounts-with-all-field.41101/  
'for devices less than Android 8, return a list of account email addresses. (newer devices get an empty list)  
Sub getAccountsForOlderDevices As List  
    Dim wAccounts As List  
    wAccounts.Initialize  
    If sdkVersion < 26 Then  
        Dim r As Reflector  
        r.Target = r.RunStaticMethod("android.accounts.AccountManager", "get", Array As Object(r.GetContext), Array As String("android.content.Context"))  
        Dim accounts() As Object  
        accounts = r.RunMethod2("getAccountsByType", "com.google", "java.lang.String")  
        For i = 0 To accounts.Length - 1  
            r.Target = accounts(i)  
            wAccounts.Add(r.GetField("name"))   'actually email address  
        Next  
    Else  
        LogColor("getAccounts: empty list for Android 8+", Colors.Yellow)  
    End If  
    Return wAccounts             
End Sub  
  
'check/request permission, then get their email from their Google account on this device  
Sub warnAboutGetAccountPermission  
    MsgboxAsync("This app needs your permission to get your account's email for sharing.", "Heads up!")  
    wait for Msgbox_Result(result As Int)  
    askAndGetAccountInfo  
End Sub  
  
Sub askAndGetAccountInfo  
    rp.CheckAndRequest(c.rp.PERMISSION_GET_ACCOUNTS)  
    wait for Activity_PermissionResult(Permission As String, result As Boolean)  
    If result = True Then  
        userEmail = getAccountsForOlderDevices.Get(0)  
    Else  
        MsgboxAsync("Sorry, can't continue without your account details", "No sharing")  
    End If  
End Sub  
  
'ask the user to pick their Google account, then get their name and email from their Google account on this device  
Sub warnAboutPickingAccount  
    MsgboxAsync("Please pick your current account so the app can get your email address.", "Heads up!")  
    wait for Msgbox_Result(result As Int)  
    pickAccountToGetEmail  
End Sub  
  
'https://www.b4x.com/android/forum/threads/get-email-accounts-returns-empty-list.105275/post-659474  
Sub pickAccountToGetEmail  
    Dim jo As JavaObject  
    jo.InitializeStatic("android.accounts.AccountManager")  
    StartActivityForResult(jo.RunMethod("newChooseAccountIntent", Array(Null, Null, Array As String("com.google"), Null, Null, Null, Null)))  
    Wait For ion_Event(MethodName As String, Args() As Object)  
    If -1 = Args(0) Then     'resultCode = RESULT_OK  
        Dim i As Intent = Args(1)  
        userEmail = i.GetExtra("authAccount")    'email address of account  
    Else  
        userEmail = ""  
        MsgboxAsync("Sorry, could not get your account details", "Error")  
    End If  
End Sub  
  
Sub StartActivityForResult(i As Intent)  
    Dim jo As JavaObject = GetBA  
    ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)  
    jo.RunMethod("startActivityForResult", Array As Object(ion, i))  
End Sub  
  
Sub GetBA As Object  
    Dim jo As JavaObject  
    Dim cls As String = Me  
    cls = cls.SubString("class ".Length)  
    jo.InitializeStatic(cls)  
    Return jo.GetField("processBA")  
End Sub
```

  
  
There's a bit of additional jiggerypokery to handle the activity being paused and resumed, but this is the main bit. Seems to work well on my range of test devices from Android 5 to 12.  
  
Hope this helps!