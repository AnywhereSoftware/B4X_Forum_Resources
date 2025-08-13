### AndroidNetUri2 (Uri wrapper) by Ivica Golubovic
### 12/05/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/157807/)

This is a new and complete wrapper of the [**android.net.Uri**](https://developer.android.com/reference/android/net/Uri) class and the [**android.net.Uri.Builder**](https://developer.android.com/reference/android/net/Uri.Builder) subclass, as well as the [**android.content.ContentUris**](https://developer.android.com/reference/android/content/ContentUris) class that contains static methods.  
  
This library will be used in the development of all my future libraries if they require "Uri".  
  
All static methods are placed in modules for easy access. The modules contained in this library are **AndroidNetUri** and **ContentUris**.  
  
The library also contains **AndroidNetUr**i and **AndroidNetUriBuilder** classes.  
  
To create a new **AndroidNetUri** instance, you can use **AndroidNetUriBuilder** or one of the methods from the **AndroidNetUri** module.  

```B4X
AndroidNetUri.FromFile([Some dir], [Some file])  
  
'Or  
  
AndroidNetUri.Parse([Some uri string])
```

  
  
This library is the successor of the [**AndroidNetUri**](https://www.b4x.com/android/forum/threads/androidneturi-library.136402/) library from this forum. The old version was done as **B4X class**, while this new version is wrapped through "**Eclipse**". There are differences between the new and the old library.  
  
If this libraries makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>