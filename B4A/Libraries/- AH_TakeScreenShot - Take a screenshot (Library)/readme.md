###  - AH_TakeScreenShot - Take a screenshot (Library) by alirezahassan
### 06/14/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/130872/)

Hi all,  
You can take a screenshot of the screen with a single line of code. in the next version you can take a screen shot with desired view.  
this zip file have a library and a sample.  
  
**Currently version v1.0 (2021/05/23)**  
  
![](https://www.b4x.com/android/forum/attachments/113681)  
  

```B4X
Private Sub BTN_ScreenShot_Click  
    Dim bitmap As Bitmap  
    bitmap.Initialize3(AH_TakeAScreenShot.TakeaScreenShot_Activity)  
    ImageView1.SetBackgroundImage(bitmap)  
    ToastMessageShow("done!",True)  
End Sub
```

  
  
‍Please like this post to increase my motivation. :)  
You can subscribe to my Telegram channel to use my text and video tutorials : [@B4X\_Develop](https://t.me/B4X_Develop)