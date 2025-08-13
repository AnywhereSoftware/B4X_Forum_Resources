### Image viewer. A zoomable image within each sliding panel by GeoT
### 03/25/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/147040/)

agraham's [ScaleImageView](https://www.b4x.com/android/forum/threads/scaleimageview-pan-and-zoom-large-images.102190/#content) library allows you to zoom the image by pinching and double-clicking.  
Dominex's [SlidingPanels](https://www.b4x.com/android/forum/threads/class-multi-type-slidingpanels.23303/#content) class allows in part to place large, horizontally sliding panels.  
  
I have put them together by making some modifications to the SlidingPanels class and adaptations with the ScaleImageView library.  
  
[MEDIA=youtube]jRFl7\_RclGw[/MEDIA]  
  
  
Features:  

- Shows a space with painted arrows that allows you to slide the SlidingPanels
- A SlidingPanels is not allowed to slide if its ScaleImageView has been zoomed in
- We make the ACToolBarDark1 semi-transparent when orienting the device in landscape position
- Allows you to remove each SlidingPanels with their contents
- It fills the list of initial scales when changing the panel (SlidPan1\_Change) or onResume
- Now it copies the images from DirAssets to rp.GetSafeDirDefaultExternal("Images") and gets their paths, but the idea is to select them via the system MediaStore class or from a multiple attempt of the Android Gallery
- Optionally put a space for in the future to put a Horizontal ScrollView with the thumbnails with a selector frame for the images. Which I will post soon
- You may also be given the option to edit the image by cropping and rotating it in the future
- Now it only allows to show images, but you could also take representative images from videos without zoom option and show them with a play icon on top
- Images could also be sent in the future
- If the agraham's [Gestures](https://www.b4x.com/android/forum/threads/gestures-multi-touch-library.7421/#content) library is added, SlidingPanels can be slid directly from displayed images, but ScaleImageView's double-click event to modify the zoom is lost
- If you want to change the sample images in DirAssets you have to uninstall the example, manage the images in the File Manager, and maybe clean the project

  
Dependencies: the AppCompat, ScaleImageView, RuntimePermissions and XmlLayoutBuilder libraries. And the SlidingPanels class  
  
I am attaching the example and the images to be placed inside the Files folder