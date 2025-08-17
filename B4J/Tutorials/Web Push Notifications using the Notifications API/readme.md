### Web Push Notifications using the Notifications API by Mashiane
### 12/21/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/144942/)

Hi  
  
I just had the pleasure of looking at this Notifications API again. Below is my example.  
  
![](https://www.b4x.com/android/forum/attachments/137160)  
  
  
You can get more infomation about it here, <https://developer.mozilla.org/en-US/docs/Web/API/Notifications_API>  
  
It could be useful to your web applications. You can also use this lib in your web application, <https://pushjs.org/#>  
  
This is what you can include in your notification.  
  
1. A Title  
2. An Image  
3. An Icon  
4. A Decription  
5. Actions and more and more like rtl content  
6. You can also trap the click, close, show, error events on the notification.  
  
My example is based on this code..  
  

```B4X
Sub btnNotif_click (e As BANanoEvent)  
    app.ShowBrowserNotification("SithasoDaisy", _  
    "Thank you so much for activating the Notifications, this will help us keep you informed about SithasoDaisy developments.", _  
    "https://www.b4x.com/android/forum/threads/sithasodaisy-tailwindcss-daisyui-toolbox.143549/#content", _  
    "./assets/SithasoDaisyLogo.jpg", "./assets/daisyui.jpg", True, 5)  
End Sub
```

  
  
PS: If you can do it in JavaScript, its possible.  
  
Happy Coding.