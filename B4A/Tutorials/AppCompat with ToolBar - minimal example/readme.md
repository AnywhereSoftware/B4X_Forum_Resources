### AppCompat with ToolBar - minimal example by Erel
### 06/23/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/79896/)

**In most cases AppCompat is no longer needed and will only make things more complicated.**  
B4XPages example with dynamic menu: <https://www.b4x.com/android/forum/threads/b4x-menu-badges.133301/>  
  
![](https://www.b4x.com/android/forum/attachments/56464)  
  
  
  
The project attached uses the powerful [AppCompat library](https://www.b4x.com/android/forum/threads/48423/#content) to replace the built-in ActionBar with a more robust ToolBar.  
  
The NavigationItemClick event is raised when the icon is clicked.  
  
You can set *ToolbarHelper.ShowUpIndicator = True* to show an up arrow instead. It will raise the same event.  
  
![](https://www.b4x.com/basic4android/images/SS-2017-05-24_12.20.07.png)  
  
You can change the toolbar color in the manifest editor.  
  
**Sliding side menu + dynamic menu items:** <https://www.b4x.com/android/forum/threads/appcompat-with-toolbar-minimal-example.79896/#post-509530>  
  
![](https://www.b4x.com/basic4android/images/SS-2017-06-08_17.06.06.png)  
  
Example based on B4ADrawer: <https://www.b4x.com/android/forum/threads/class-b4adrawer-sliding-drawer.97828/#post-616518>  
  
![](http://www.b4x.com/basic4android/images/b4adrawer.gif)  
  
  
Edit: depending on your Android SDK version, you might get this error:  
  
java.lang.NoClassDefFoundError: Failed resolution of: Landroidx/arch/core/executor/ArchTaskExecutor;  
  
The solution is to add this line in the main activity:  

```B4X
#AdditionalJar: androidx.arch.core:core-runtime
```