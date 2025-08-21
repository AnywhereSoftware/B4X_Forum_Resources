###  Sharing layouts between platforms by Erel
### 09/05/2019
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/109296/)

Sharing code between the platforms is quite simple with the reference modules feature: <https://www.b4x.com/android/forum/threads/b4x-modules-files-groups-and-folders.86587/#content>  
Once you learn how to use XUI library with B4XView and the various cross platform controls you can share 95%+ of the code and use conditional compilation or platform specific modules for the other 5%.  
  
Sharing files can be done with a CustomBuildAction as explained here: <https://www.b4x.com/android/forum/threads/xui2d-cross-platform-tips.96815/#content>  
  
Starting from B4A v9.50, B4J v7.80 and B4i v6.00 it is possible to "share" layouts between the platforms.  
The three tools now support copying and pasting controls.  
  
![](https://www.b4x.com/basic4android/images/tSMBhiL6kb.gif)  
  
This allows you to build the layout on one platform and later copy all of it or parts of it to other platforms.  
  
Each platform has unique controls. These cannot be copied. The same is true for unique properties that are not available in other platforms.  
Custom views, and especially custom views that are built over XUI and are intended to be cross platform (example: [XUI Views](https://www.b4x.com/android/forum/threads/b4x-xui-views-cross-platform-views-and-dialogs.100836/#content)), can be shared with all there properties.  
  
It is also possible to declare views as B4XViews directly from the designer. Note that custom views do not need to be declared as B4XViews. Then should be declared with the custom type, which is cross platform.  
Tip: you can always cast B4XViews to the explicit type and vice versa.