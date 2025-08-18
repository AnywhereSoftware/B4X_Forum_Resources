### [Lib] MediaBrowser by Informatix
### 04/22/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/19121/)

Hello,  
  
This library lists the media content (audio, image and video) of the MediaStore (a database containing meta data for all available media on both internal and external storage devices). It includes an audio player and a media scanner (to scan the new media and add them to the MediaStore).  
  
I added new functions to the library esAudioMediaBrowser provided by Lagore, improved a bit the existing ones, and extended the stuff to images and videos.  
The demo (a media gallery) needs the libs Reflection & StringUtils. It displays only files stored on your external SD card (but the lib can handle internal files).  
  
This lib does not work with Android versions < Gingerbread (2.3).  
  
List of properties and methods:  

- **GetAudioFieldByID** (External As Boolean, ID As Long, Field As String) As String
*Returns a field from the MediaStore about the specified audio file.  
 Examples of field: FIELD\_COMPOSER, FIELD\_DATE\_MODIFIED, FIELD\_MIME\_TYPE, FIELD\_SIZE…*- **GetAudioFileInfo** (Path As String, File As String) As Map
*Returns a Map containing info from the MediaStore about an audio file.  
The fields that are returned are:  
"ID"  
"Title"  
"Album"  
"Artist"  
"Track"  
"Year"  
"Location"  
"DisplayName"  
 "Duration" (in ms)*- **GetAudioFileInfoByID** (External As Boolean, ID As Long) As Map
*Returns a Map containing info from the MediaStore about an audio file.  
The fields that are returned are:  
"ID"  
"Title"  
"Album"  
"Artist"  
"Track"  
"Year"  
"Location"  
"DisplayName"  
 "Duration" (in ms)*- **GetExifAttribute** (Location As String, Attribute As String) As String
*Returns the requested attribute from the Exif data of the specified image.   
Location = complete path name for the file.  
The complete list of attributes can be found here: <https://developer.android.com/reference/android/media/ExifInterface>*- **GetExifLatLong** (Location As String, LatLong As Float()) As Boolean
*Stores the latitude and longitude value of the specified image in a float array. Returns False if these Exif data are not available.  
 Location = complete path name for the file.*- **GetExtImageFileInfo** (Location As String) As Map
*Returns a Map containing info from the MediaStore about an external image file.  
Location = complete path name for the file.  
The fields that are returned are:  
"ID"  
"Location"  
"DisplayName"  
"DateTaken" (in ticks from 1970)  
"Height" (with Android 3.0+)  
"Width" (with Android 3.0+)  
 "Size" (in bytes)*- **GetExtVideoFileInfo** (Location As String) As Map
*Returns a Map containing info from the MediaStore about an external video file.  
Location = complete path name for the file.  
The fields that are returned are:  
"ID"  
"Location"  
"DisplayName"  
"DateTaken" (in ticks from 1970)  
"Resolution" (can be Null for some files)  
 "Size" (in bytes)*- **GetImageDimensions** (Location As String) As Map
*Returns a map containing width and height of the specified file.  
 Location = complete path name for the file.*- **GetImageFieldByID** (External As Boolean, ID As Long, Field As String) As String
*Returns a field from the MediaStore about the specified image file.  
 Examples of field: FIELD\_DATE\_MODIFIED, FIELD\_MIME\_TYPE, FIELD\_ORIENTATION…*- **GetImageFileInfoByID** (External As Boolean, ID As Long) As Map
*Returns a Map containing info from the MediaStore about an image file.  
The fields that are returned are:  
"ID"  
"Location"  
"DisplayName"  
"DateTaken" (in ticks from 1970)  
"Height" (with Android 3.0+)  
"Width" (with Android 3.0+)  
 "Size" (in bytes)*- **GetImgThumbnailByID** (ID As Long, Mini As Boolean) As android.graphics.Bitmap
*Returns the micro thumbnail (96x96) or mini thumbnail (512x384) of an image file (it is generated if it doesn't exist).*- **GetMediaAudioList** (External As Boolean, SortCol As String) As Map
*Returns a Map containing a list of all Audio files in the MediaStore which can be sorted.  
The allowed fields for sorting are:  
Null (= FIELD\_ID)  
FIELD\_ALBUM  
FIELD\_ARTIST  
FIELD\_COMPOSER  
FIELD\_DATA (location)  
FIELD\_DATE\_ADDED  
FIELD\_DATE\_MODIFIED  
FIELD\_DISPLAY\_NAME  
FIELD\_DURATION  
FIELD\_MIME\_TYPE  
FIELD\_SIZE  
FIELD\_TITLE  
FIELD\_TRACK  
FIELD\_YEAR  
The fields that are returned are:  
"ID"  
"Title"  
"Album"  
"Artist"  
"Track"  
"Year"  
"Location"  
"DisplayName"  
 "Duration" (in ms)*- **GetMediaImageList** (External As Boolean, SortCol As String) As Map
*Returns a Map containing a list of all Image files in the MediaStore which can be sorted.  
The allowed fields for sorting are:  
Null (= FIELD\_ID)  
FIELD\_DATA (location)  
FIELD\_DATE\_ADDED  
FIELD\_DATE\_MODIFIED  
FIELD\_DATE\_TAKEN  
FIELD\_DISPLAY\_NAME  
FIELD\_HEIGHT  
FIELD\_MIME\_TYPE  
FIELD\_ORIENTATION  
FIELD\_SIZE  
FIELD\_TITLE  
FIELD\_WIDTH  
The fields that are returned are:  
"ID"  
"Location"  
"DisplayName"  
"DateTaken" (in ticks from 1970)  
"Height" (with Android 3.0+)  
"Width" (with Android 3.0+)  
 "Size" (in bytes)*- **GetMediaVideoList** (External As Boolean, SortCol As String) As Map
*Returns a Map containing a list of all Video files in the MediaStore which can be sorted.  
The allowed fields for sorting are:  
Null (= FIELD\_ID)  
FIELD\_DATA (location)  
FIELD\_DATE\_ADDED  
FIELD\_DATE\_MODIFIED  
FIELD\_DATE\_TAKEN  
FIELD\_DISPLAY\_NAME  
FIELD\_MIME\_TYPE  
FIELD\_RESOLUTION  
FIELD\_SIZE  
FIELD\_TITLE  
The fields that are returned are:  
"ID"  
"Location"  
"DisplayName"  
"DateTaken" (in ticks from 1970)  
"Resolution" (can be Null for some files)  
 "Size" (in bytes)*- **GetVideoFieldByID** (External As Boolean, ID As Long, Field As String) As String
*Returns a field from the MediaStore about the specified video file.  
 Examples of field: FIELD\_DATE\_ADDED, FIELD\_DATE\_MODIFIED, FIELD\_MIME\_TYPE…*- **GetVideoFileInfoByID** (External As Boolean, ID As Long) As Map
*Returns a Map containing info from the MediaStore about a video file.  
The fields that are returned are:  
"ID"  
"Location"  
"DisplayName"  
"DateTaken" (in ticks from 1970)  
"Resolution" (can be Null for some files)  
 "Size" (in bytes)*- **GetVideoThumbnailByID** (ID As Long, Mini As Boolean) As android.graphics.Bitmap
*Returns the micro thumbnail (96x96) or mini thumbnail (512x384) of a video file (it is generated if it doesn't exist).   
There's a known bug on some Android versions with micro thumbnails:  
 If the micro thumbnail can't be generated (e.g. video file format not recognized), the result is either null or a random thumbnail. Thus, for video files, it is strongly recommended to check if the mini thumbnail is initialized before trying to get the micro thumbnail.*- **Initialize** (EventName As String)
- **MediaAudioPlay** (External As Boolean, ID As Int)
*Plays an audio file.  
 Raises the "MediaCompleted" event when the file end is reached.*- **MediaIsLooping** As Boolean
*Checks whether the player is looping or non-looping.*- **MediaIsPlaying** As Boolean
- **MediaLength** As Int
*Returns the duration in ms.*- **MediaPause**
- **MediaPosition** As Int
*Gets the current playback position.*- **MediaResume**
- **MediaSeek** (position As Int)
*Seeks to specified time position (in ms).  
 Raises the event "SeekCompleted" when the position change has been completed.*- **MediaSetLooping** (Looping As Boolean)
*Sets the player to be looping or non-looping.*- **MediaSetVolume** (leftVolume As Float, rightVolume As Float)
*Sets the volume on this player (and this player only).  
Note that the passed volume values are raw scalars. UI controls should be scaled logarithmically.  
 This function must be called AFTER MediaAudioPlay.*- **MediaStop**
*Stops the playback and releases the allocated resources.*- **ScanNewMedia** (Paths As String())
*Requests the media scanner to scan the given files and add them to the MediaStore.  
 Raises the "ScanCompleted" event after each file is scanned.*
*Warning:  
There's a known bug on some Android versions with micro thumbnails:  
If the micro thumbnail can't be generated (e.g. video file format not recognized), the result is either null or a random thumbnail. Thus, for video files, it is strongly recommended to check if the mini thumbnail is initialized before trying to get the micro thumbnail.*  
  
v1.2:  
I fixed two bugs.  
  
v1.21:  
I removed the excessive log entries.  
I removed all the Try/Catch that silently trapped errors.  
  
v1.3:  
This version requires Java 7 and B4A v3.82+.  
I added 3 functions:  
- GetImageFileInfoByID(External As Boolean, ID As Long) As Map;  
- GetVideoFileInfoByID(External As Boolean, ID As Long) As Map;  
- ScanNewMedia(Paths() As String).  
I updated the demo so it works with recent Android versions.  
  
v1.31:  
I fixed a mistake in two functions introduced in v1.3.  
  
v1.4:  
I fixed an issue with API 30;  
I added five functions: GetAudioFieldByID, GetImageFieldByID, GetVideoFieldByID, GetExifAttribute and GetExifLatLong;  
I added a few FIELD constants;  
I updated the demo to display the following fields: composer, orientation, latitude and longitude.  
  
Enjoy,  
Fred