### Dropbox SDK V2 - Java by DonManfred
### 03/04/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/74019/)

![](https://www.b4x.com/android/forum/attachments/51210)  
  
  
This is a wrap for the Dropbox JAVA SDK for Android.  
  
It is a request for the community too to parcitipate to this project doing test or writing documentation for the objects.  
  
List of connected Tutorials:  
- [Dropbox SDK V2 - Authentification](https://www.b4x.com/android/forum/threads/dropbox-sdk-v2-authentification.74341/)  
- [[SIZE=3]Dropbox SDK V2 - Uploading big files to Dropbox[/SIZE]](https://www.b4x.com/android/forum/threads/dropbox-sdk-v2-uploading-big-files-to-dropbox.74430/)  
- [Dropbox SDK - get informed about changes in the used Dropbox](https://www.b4x.com/android/forum/threads/dropbox-sdk-get-informed-about-changes-in-the-used-dropbox.93491/)  
  
  
**DropboxV2  
Comment:** The Dropbox library allows you to communicate with Dropbox  
**Author:** DonManfred (wrapper)  
**Version:** 0.7 (wraps the SDK dropbox-core-sdk-7.0.0)  
  
Wrapped Objects so far  

- **DbxAuth**
- **DbxClientV2**
- **DbxHost**
- **Dimensions**
- **DbxRequestConfig**
- **DbxUserAuthRequests**
- **DropboxV2**
- **DbxUserFilesRequests**
- **FileMetadata**
- **FolderMetadata**
- **FolderSharingInfo**
- **GpsCoordinates**
- **Mediainfo**
- **MediaMetadata**
- **Metadata**
- **RelocationPath**
- **DbxUserSharingRequests**
- **MemberSelector**
- **SharedFileMetadata**
- **SharedFolderMetadata**
- **SharedLinkMetadata**
- **BasicAccount**
- **FullAccount**
- **DbxUserUsersRequests**

  
The Download will always be here in Post #1 of the Thread.  
  
Additional to the provided Library (xml and jar) you need to download:  
1. [Download this file](https://www.dropbox.com/scl/fo/4x8fz4tzb8atoc2onw39r/AFuDNQGTOy316QTDLRzrJyA?rlkey=z6ho7rzisid8cnfnnln0dyaqs&st=qj8w6589&dl=0).  
 Extract the zip and copy the files to your additional libraries folder.  
  
Add this lines to your Mainmodule  

```B4X
#AdditionalJar:dropbox-android-sdk-7.0.0.aar  
#AdditionalJar:dropbox-core-sdk-7.0.0
```

  
  
  
In the following posts i´ll add some more detailed info on the different Objects.