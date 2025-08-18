### Keep Track of Pages (getCurrentPage) [e.g. Access Network Dialog workaround] by Mike1970
### 05/24/2021
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/131030/)

Hi everyone, i want to share a stupid piece of code that could be useful (to me it did).  
I had the need to know what was the page displayed when *Application\_Active* sub is fired -> [this is the post](https://www.b4x.com/android/forum/threads/get-name-of-current-page-on-resume-application_active.130979/#post-824667)  
  
**[SIZE=6]What I did[/SIZE]**  
  
Create a code module where i save all the useful functions and created a single function to move between pages.  
Everytime it is called, the page is saved in the navigationcontroller tag  
[SPOILER="GoToPage Function"]  

```B4X
Sub GoToPage(PageModule As Object, PageObject As Page, Animated As Boolean)  
    If PageObject.IsInitialized Then  
        Main.NavControl.ShowPage2(PageObject, Animated)  
    Else  
        Main.NavControl.ShowPage2(CallSub(PageModule, "Initialize"), Animated)  
    End If  
    Main.NavControl.Tag = PageObject  
End Sub
```

  
[/SPOILER]  
  
Then, in the Application\_Active sub i did this:  
[SPOILER="Application\_Active Sub"]  

```B4X
Private Sub Application_Active  
    If NavControl.Tag <> Null Then  
        
        Select NavControl.Tag  
            Case PageModule.PageObject  
                …  
        End Select  
    End If  
End Sub
```

  
[/SPOILER]  
  
Don't forget to put

```B4X
NavControl.Tag = Null
```

in the *Application\_Start* Sub  
  
**NOTE: you should update the NavControl.Tag when you call the .PageStack function too, and putting the first page in it.  
  
  
  
  
[SIZE=6]Why i did it[/SIZE]**  
[SIZE=4]I did it because of the fact that Apple after i install my compiled app asks for the permission to Access The Network… while you don't allow you are not able to do REST requests, and the dialog is NOT BLOCKING.[/SIZE]  
Giving the fact that my app needs to download some datas with GET requests just after the opening, i had trouble for the first start because the httpjob fails. SO  
i tried to make it "blocking like" this way:  
  
I also made a Question post a while ago about this "issue" -> [here](https://www.b4x.com/android/forum/threads/access-network-dialog-ios-wait-for-answer.126580/#post-791832)  
Thanks to [USER=106971]@Semen Matusovskiy[/USER] , [USER=42781]@Alex\_197[/USER] and others that helped me.  
Semen suggested to checking the status using UDP.. but honestly i did not manged to work in that way (pretty sure it's my fault). i used POST requests.. maybe if someone find out how to replace a POST with something better it will be cool :D  
  
This is how i did it (is still a bit glitchy :/)  
  

```B4X
Sub Process_Globals  
    …  
    Dim sf As NativeObject  
End Sub  
  
Private Sub Application_Background  
    If sf.IsInitialized Then  
        sf.RunMethod("dismissWithClickedButtonIndex:animated:", Array(-1, True)) 'programmatically close the msgbox  
        sf = Null  
    End If  
End Sub  
  
Private Sub Application_Active  
    If NavControl.Tag <> Null Then  
        Select NavControl.Tag  
            Case SplashscreenPg ' It do the check only if i am in the splashscreen  
                Wait For (AccessNetworkEnabled) Complete (resAccess As Boolean)  
                If resAccess Then  ' True or False'             
                    ' OK, GOOD TO GO  
                End If  
        End Select  
    End If  
End Sub  
  
Sub AccessNetworkEnabled As ResumableSub  
   ' i try to make a useless POST request to an endpoint on my server that just answers "ok"  
   ' i noticed that a POST request will fail until the user allow the access  
    Wait For (RichiesteAPI1.PostTest) Complete (resPostTest As Boolean)  
    'Log(resPostTest)  
    If resPostTest == False Then  
        If App.OSVersion >= 8 Then 'if the os version is greater then 8 i can open the settings page of my app in Settings App of iOS  
            If Not(sf.IsInitialized) Then  
                sf = Msgbox2("Msg", "Seems like you didn't allow for access the network", "Not Allowed", Array ("Allow Now"))  
                Wait For Msg_Click (ButtonText As String)  
                If ButtonText = "Allow now" Then  
                    App.OpenURL("app-settings:")  
               End If  
           End If  
        Else  
            Msgbox("Seems like you didn't allow for access the network", "Not Allowed")  
        End If  
        
        Return False  
    Else  
        If sf.IsInitialized Then  
            sf.RunMethod("dismissWithClickedButtonIndex:animated:", Array(-1, True)) 'programmatically close the msgbox  
        End If  
        Return True  
    End If  
End Sub
```

  
  
![](https://lh3.googleusercontent.com/lKHArr58Nuiy-7UIY8Bs0OSs2deqmyeLhi1uPuqnOgkPslvY0Mfkm7Io_OkUP7LGXmzqRtg1vJi2z3pr5nGr=w1920-h890)