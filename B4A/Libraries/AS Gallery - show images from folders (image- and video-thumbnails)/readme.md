### AS Gallery - show images from folders (image- and video-thumbnails) by Alexander Stolte
### 08/13/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/118451/)

I want to share my class to create a image preview list like in the gallery app.  
This class is based on xCustomListView and PreoptimizedCLV.  
The class is creating a cached thumbnail of a image if needed, to avoid performance issues on scrolling.  
The cache folder is created here: [ICODE]File.MakeDir(File.DirInternal , "cache")[/ICODE]  
  
You can set the tile count, per default it is 4.  
I have tested the class with .mp4,.jpg and .png files.  
  

```B4X
    Dim rp As RuntimePermissions  
    rp.CheckAndRequest(rp.PERMISSION_READ_EXTERNAL_STORAGE)  
    Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
  
    Dim tmp_lst As List : tmp_lst.Initialize2(Array As String(File.DirRootExternal & "/Snapchat",File.DirRootExternal & "/Fast InstaSaver"))  
  
    ASGallery1.WildCards = "*.jpg,*.png,*.jpeg,*.bmp"',*.mp4"  
    ASGallery1.GetContent(tmp_lst)
```

  
![](https://www.b4x.com/android/forum/attachments/95000)  
  
  
**ASGallery  
Author: Alexander Stolte  
Version: 1.03**  

- **ASGallery**

- **Events:**

- **PreviewClick** (path As String, isImage As Boolean)

- **Functions:**

- **Class\_Globals** As String
- **CreateFileAndTime** (Name As String, Time As Long, dir As String) As FileAndTime
- **CreateMyImageData** (IndexOfFirstImage As Int, lst\_image\_filename As List) As MyImageData
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetContent** (lst\_dirs As List)
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setWildCards** (wildcards As String) As String
- **xclv\_main\_VisibleRangeChanged** (FirstIndex As Int, LastIndex As Int) As String

- **Properties:**

- **WildCards**

- **FileAndTime**

- **Fields:**

- **dir** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Name** As String
- **Time** As Long

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **MyImageData**

- **Fields:**

- **IndexOfFirstImage** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **lst\_image\_filename** As List

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
**Changelog**  

- **1.00**

- Release

- **1.01**

- add get xCustomListView
- add get mbase
- add bug fixes

- **1.02**

- add BitmapAsync - only for image files

- **1.03**

- automatically rotates the preview image when it is horizontal
- new dependency JpegUtils

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.me/stoltex)