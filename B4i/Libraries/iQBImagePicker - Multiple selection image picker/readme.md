### iQBImagePicker - Multiple selection image picker by CaptKronos
### 05/22/2021
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/103780/)

This is a wrapper for QBImagePicker <https://github.com/questbeat/QBImagePicker>, an image picker that provides for multiple image and video selection.  
  
The wrapper includes helper functions which are primarily to copy the selected assets to a folder on the device but a few others have been included since I required them.  
  
I have noticed that on the Simulator only local (in the DCIM folder) assets can be copied (not sure why) but on a real device I haven't noticed that limitation.  
  
The list of PHAssetCollectionSubtypes (one or more of which are passed to the load function) can be found here <https://github.com/mstg/iOS-full-sdk/blob/master/iPhoneOS9.3.sdk/System/Library/Frameworks/Photos.framework/Headers/PhotosTypes.h>  
  
QBImagePicker has built-in support for the following languages: English, French, German, Spanish, Italian, Korean, Japanese, Chinese Taiwan, Simplified Chinese, Portuguese, Polish, Russian.  
  
Installation instructions (modified one of Alberto Iglesias' posts since I haven't tried the MAC HOSTED approach):  
  
- Unzip QBImagePicker.zip into the folder "Libs" in your MAC or in your MAC HOSTED by AnywhereSoftware, normally in "B4i-MacServer\Libs" folder. This will result in iQBImagePicker.h, libiQBImagePicker.a and the folder QBImagePicker.framework being copied to the "Libs" folder.  
  
-Copy the iQBImagePicker.xml to your custom libraries folder in B4i  
  
-If you wish to use the simulator then use QBImagePickerSim.zip instead of QBImagePicker.zip. (There are only two files that are different between the two zips: libiQBImagePicker.a and QBImagePicker.framework/QBImagePicker.)  
  
22/01/21 - Updated the demo and XML file to remove the references to passing -1 as a subType since it doesn't work.  
  
08/05/21 - ver 1.10   
[indent]Added Russian language localisation.[/indent]  
  
22/05/21 - ver 1.20  
[indent]Added a call to add your own language translation.  
[indent]If you wish to use QBImagePicker with a language that is not built-in to the framework, you can you the command QBImagePicker.translations to provide your own translations for the required 11 strings. [/indent][/indent]  
[indent]Added a call to return the framework's version number: QBImagePicker.frameworkVersion[/indent]  
  
For the non-English languages to be recognised, you need to create subfolders in your project's files/special folder as per this thread: <https://www.b4x.com/android/forum/threads/tutorial-for-localization-of-app-name.69618>  
  
**iQBImagePicker**  
  
**Author:**  Capt Kronos  
**Version:** 1.2  

- **QBImagePicker**

- **Events:**

- **cancelled**
- **picked** (assets As List)

- **Functions:**

- **convertPHAssetToImage** (thePHAsset As PHAsset\*) As UIImage\*
*<code>dim bmp as bitmap = aQBImagePicker.ConvertPHAssetToImage(assets.Get(i))</code>*- **copyPHAssetToFile** (ThePHAsset As PHAsset\*, destination As NSString\*)
*<code>aQBImagePicker.CopyPHAssetToFile(assets.Get(i), "filename")</code>*- **createAlbum** (albumName As NSString\*) As BOOL
*<code>aQBImagePicker.createAlbum("myalbum") 'if myalbum already exists another album of the same name will be created</code>*- **existsAlbum** (albumName As NSString\*) As BOOL
*<code>aQBImagePicker.existsAlbum("myalbum") 'returns true if myalbum exists</code>*- **frameworkVersion** As NSString\*
*Returns the version of the framework.*- **getImageDataFromAsset** (thePHAsset As PHAsset\*) As NSDictionary\*
*Be very careful with this one. Depending on which key you inspect, it can crash your app.  
<code>Dim dict As Object, dictMap As Map  
dict=QBImagePicker.getImageDataFromAsset(assets.Get(0))  
dictMap=NSDictionaryToMap(dict)  
Log(dictMap.Get("PHImageFileUTIKey"))</code>*- **getImageURLFromAsset** (thePHAsset As PHAsset\*) As NSString\*
*<code>Dim url As String=QBPicker.getImageURLFromAsset(assets.Get(i))  
url=url.SubString(7) 'convert to regular path and filename</code>*- **initialize** (bi As B4I\*, eventName As NSString\*)
*Initialises the picker.  
Example:<code>aQBImagePicker.initialize("qbimagepicker")</code>*- **load** (myViewController As UIViewController\*, mediaType As Int, subType As NSArray\*, multiSelect As BOOL, minNumber As Int, maxNumber As Int, numColsInPortrait As Int, numColsInLandscape As Int, useiCloud As BOOL)
*Displays the picker.  
MyViewController: The page to host the picker  
MediaType: 1 - images; 2 - videos; 0 - any  
SubType: a list of PHAssetCollectionSubtypes - see below for the values  
 <code>[github.com/mstg/iOS-full-sdk/blob/master/iPhoneOS9.3.sdk/System/Library/Frameworks/Photos.framework/Headers/PhotosTypes.h](http://github.com/mstg/iOS-full-sdk/blob/master/iPhoneOS9.3.sdk/System/Library/Frameworks/Photos.framework/Headers/PhotosTypes.h)</code>  
MultiSelect: True - allows more than one asset to be selected  
MinNumber: The minimum number of assets that must be selected  
MaxNumber: The maximum number of assets that can be selected  
NumColsInPortrait: The number of assets to display horizontally when in portrait (0 for default value)  
NumColsInLandscape: The number of assets to display horizontally when in landscape (0 for default value)  
useiCloud: True - will display assets on iCloud  
Example:<code>  
aQBImagePicker.load(pg, 1, subType, True, 1, 100, 0, 0, True)</code>*- **saveImageFileToAlbum** (albumName As NSString\*, imageURL As NSString\*) As BOOL
*<code>aQBImagePicker.saveImageFileToAlbum("myalbum", File.Combine(File.DirDocuments,"myimage.jpg"))</code>*- **saveImageToAlbum** (albumName As NSString\*, image As UIImage\*) As BOOL
*<code>aQBImagePicker.saveImageToAlbum("myalbum", bmp)</code>*- **saveVideoFileToAlbum** (albumName As NSString\*, videoURL As NSString\*) As BOOL
*<code>aQBImagePicker.saveVideoFileToAlbum("myalbum", File.Combine(File.DirDocuments,"myvideo.mp4"))</code>*- **translations** (albumsTitle As NSString\*, assetsToolbarItemsSelected As NSString\*, assetsToolbarItemSelected As NSString\*, assetsFooterPhotoAndVideo As NSString\*, assetsFooterPhotoAndVideos As NSString\*, assetsFooterPhotosAndVideo As NSString\*, assetsFooterPhotosAndVideos As NSString\*, assetsFooterPhoto As NSString\*, assetsFooterPhotos As NSString\*, assetsFooterVideos As NSString\*, assetsFooterVideos As NSString\*)
*Overrides built-in translations  
<code>aQBImagePicker.translations( \_   
[indent]"Photos", \_[/indent]  
[indent]"%ld Items Selected", \_[/indent]  
[indent]"%ld Item Selected", \_[/indent]  
[indent]"%ld Photo, %ld Video", \_[/indent]  
[indent]"%ld Photo, %ld Videos", \_[/indent]  
[indent]"%ld Photos, %ld Video", \_[/indent]  
[indent]"%ld Photos, %ld Videos", \_[/indent]  
[indent]"%ld Photo", \_[/indent]  
[indent]"%ld Photos", \_[/indent]  
[indent]"%ld Video", \_[/indent]  
[indent]"%ld Videos")[/indent]</code>*
  
  
Usage:  

```B4X
Dim aQBImagePicker As QBImagePicker  
Dim subType As List  
subType.Initialize  
subType.Add(201)  
aQBImagePicker.initialize("QBImagePicker")  
'optionally, add a translation (translate the English parameters to the required language)  
aQBImagePicker.translations( _   
	"Photos", _  
	"%ld Items Selected", _  
	"%ld Item Selected", _  
	"%ld Photo, %ld Video", _  
	"%ld Photo, %ld Videos", _  
	"%ld Photos, %ld Video", _  
	"%ld Photos, %ld Videos", _  
	"%ld Photo", _  
	"%ld Photos", _  
	"%ld Video", _  
	"%ld Videos")  
aQBImagePicker.load(Page1,1,subType,True,0,10,0,0,True)  
  
Sub QBImagePicker_picked (assets As List)  
    For i=0 To assets.Size-1  
        QBPicker.CopyPHAssetToFile(assets.Get(i), destFilname)  
    Next  
End Sub
```