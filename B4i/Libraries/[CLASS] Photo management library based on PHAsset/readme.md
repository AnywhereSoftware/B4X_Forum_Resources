### [CLASS] Photo management library based on PHAsset by JackKirk
### 03/18/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/110812/)

This class is a collaborative effort between myself and Narek Adonts.  
  
The basic architecture and original Objective C was provided by Narek, I did some additional Objective C (and I don't do Objective C) and a major tidy up and rationalization.  
  
The enclosing example wrapper is intentionally minimalistic - it is linear in nature and requires you to analyse the log as you work through it.  
  
The functionality covered is:  

- Initialize
- PermissionGet
- SmartAlbumsGet - get all smart albums and contents
- UserAlbumsGet - get all user albums and contents
- UserAlbumAdd - add a user album by its name
- UserAlbumExists - check if a user album exists by its name
- UserAlbumDelete - delete a user album by its name
- PhotoAdd - add a photo as bitmap to a user album by its name - returns saved photos GUID
- PhotoGet - get a photo as bitmap by its GUID
- VideoAdd - add a video as ??? to a user album by its name - returns saved videos GUID
- VideoGet - get a video as ??? by its GUID
- AssetExists - check if photo or video exists by its GUID
- AssetDelete - delete a photo or video by its GUID

The functionality not covered includes:  

- Cloud
- Thumbnails
- Add/delete pointer to a photo/video asset in a user album

I have been using this for some months and feel that it is stable, however…  
  
Happy coding…  
  
**VERY IMPORTANT INSTALLATION NOTE**  
  
Because of the ridiculously small limit on size of files that can be uploaded, the attached PHAssets.zip file contains a dummy testvideo.mp4 in the Files folder of the project.  
  
Find an .mp4 video of your choice and copy it to the Files folder with the name "testvideo.mp4"  
  
**MAJOR UPDATE - 2.0** - see new zip below  
  
For reason for the update see:  
  
<https://www.b4x.com/android/forum/threads/my-phassets-class-died-at-ios-18-ms-copilot-to-the-rescue.166185/>