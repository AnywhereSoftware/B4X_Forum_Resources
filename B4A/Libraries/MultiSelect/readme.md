### MultiSelect by T201016
### 09/09/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/109424/)

Hello!  
The library **MultiSelect v.1.02** created below for own needs has the ability to select several items from the list in the following example POIs. Interestingly, the "All Select" selection bar always remains visible when scrolling through the list. I am interested in your opinions :)  
  
Of course, at a later time I will also add a way to build a list of elements.  
  
  

```B4X
Example:  
1. Add to Files Manager: dialog_transparent.bal and app_ico.png  
  
Sub Globals  
    Dim mss As MultiSelect  
    Dim bmp As Bitmap = LoadBitmap(File.DirAssets, "app_ico.png")  
    …  
End Sub  
  
'An example of calling the MultiSelect dialog  
mss.Initialize  
mss.InputDialog(True,Me,Activity,"Available Categories in\n'"&fd.ChosenName&"'","Select All",bmp,"mss")  
mss.Show  
  
Sub Activity_KeyPress(KeyCode As Int) As Boolean  
    ' Not mandatory, it depends on your app and device  
    Private Menu As Reflector  
  
    Select KeyCode  
      Case KeyCodes.KEYCODE_BACK  
        If mss.IsInitialized Then  
            If mss.IsShowDialog Then  
                mss.Hide '————————- > Close MultiSelect window.  
            End If  
        End If  
        Return True  
      Case KeyCodes.KEYCODE_MENU  
        Menu.Target = Menu.GetActivity  
        ' clear the menu items, the original menu itself still exists  
        Menu.SetField2("menuItems", Null)  
        ' add the required menu items  
        '  
         
        ' rebuild the menu  
        Menu.RunMethod("invalidateOptionsMenu")  
    End Select  
    Return False  
End Sub  
  
Sub mss_Response(Response As Int)  
    ToastMessageShow("Dialogresponse: " & Response, False)  
End Sub
```

  
  
This library is Donationware. [![](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LA4MS7XJEP4Z6&source=url)  
You can download the library, you can test the library.  
But if you want to USE the library in your App you need to Donate for it.  
Please click here to donate (You can donate any amount you want to donate for the library (or my work)).