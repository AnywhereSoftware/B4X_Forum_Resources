### Enhanced EXIF metadata information viewer by Peter Simpson
### 02/28/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170454/)

Hello everyone,  
ReadEXIFData is a B4J library for extracting image metadata. It is designed to give B4J developers a straightforward way to access EXIF (Exchangeable Image File Format) information without navigating Java’s underlying complexity. The library can return full metadata or targeted sets such as EXIF, GPS, IPTC, XMP, ICC, camera details, dates, and embedded thumbnails. Output is delivered through Maps and Lists, with optional events for each metadata category and convenience checks including HasExif, HasGps, and HasIptc. Its emphasis on simple method calls, predictable event sequencing, and clean structure makes it well suited to applications that need to read or process image metadata.  
  
**B4J library tab**  
![](https://www.b4x.com/android/forum/attachments/170314)  
  
**B4J Screenshot**  
![](https://www.b4x.com/android/forum/attachments/170316)  
  
**SS\_ReadEXIFData  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **ReadEXIFData**

- **Events:**

- **OnAllAsJsonReady** (Json As String)
- **OnAllAsMapReady** (Result As Map)
- **OnAllDirectoriesReady** (Dirs As List)
- **OnCameraInfoReady** (HasInfo As Boolean, Info As Map)
- **OnDateTakenReady** (HasDate As Boolean, DateTaken As String)
- **OnError** (Message As String)
- **OnExifFound** (HasExif As Boolean, Exif As Map)
- **OnGpsFound** (HasLocation As Boolean, Latitude As Double, Longitude As Double)
- **OnIccFound** (HasIcc As Boolean, Icc As Map)
- **OnIptcFound** (HasIptc As Boolean, Iptc As Map)
- **OnMetadataReady** (Success As Boolean, Result As Map)
- **OnThumbnailReady** (Success As Boolean, Thumbnail() As Byte)
- **OnXmpFound** (HasXmp As Boolean, Xmp As Map)

- **Functions:**

- **GetAllAsJson** (Dir As String, FileName As String) As String
*Returns all metadata as a JSON string and raises OnAllAsJsonReady.  
 Directory of the file.  
 Name of the file.*- **GetAllAsMap** (Dir As String, FileName As String) As Map
*Returns all metadata as a Map and raises OnAllAsMapReady.  
 Directory of the file.  
 Name of the file.*- **GetAllDirectories** (Dir As String, FileName As String) As List
*Returns a List of all metadata directory names present in the file and raises OnAllDirectoriesReady.  
 Directory of the file.  
 Name of the file.*- **GetCameraInfo** (Dir As String, FileName As String) As Map
*Returns camera information such as Make, Model, LensModel, FocalLength, Aperture, ShutterSpeed, ISO.  
 Raises OnCameraInfoReady.  
 Directory of the file.  
 Name of the file.*- **GetDateTaken** (Dir As String, FileName As String) As String
*Returns the date the photo was taken and raises OnDateTakenReady.  
 Directory of the file.  
 Name of the file.*- **GetExifOnly** (Dir As String, FileName As String) As Map
*Returns a Map containing only EXIF metadata and raises OnExifFound.  
 Directory of the file.  
 Name of the file.*- **GetGpsLocation** (Dir As String, FileName As String) As Map
*Returns GPS latitude and longitude as a Map with keys Latitude and Longitude and raises OnGpsFound.  
 Directory of the file.  
 Name of the file.*- **GetGpsOnly** (Dir As String, FileName As String) As Map
*Returns a Map containing only GPS metadata.  
 Directory of the file.  
 Name of the file.*- **GetIccOnly** (Dir As String, FileName As String) As Map
*Returns a Map containing only ICC profile metadata and raises OnIccFound.  
 Directory of the file.  
 Name of the file.*- **GetIptcOnly** (Dir As String, FileName As String) As Map
*Returns a Map containing only IPTC metadata and raises OnIptcFound.  
 Directory of the file.  
 Name of the file.*- **GetThumbnailBytes** (Dir As String, FileName As String) As Byte()
*Returns the embedded thumbnail as a Base64 string and raises OnThumbnailReady.  
 Directory of the file.  
 Name of the file.*- **GetXmpOnly** (Dir As String, FileName As String) As Map
*Returns a Map containing only XMP metadata and raises OnXmpFound.  
 Directory of the file.  
 Name of the file.*- **HasExif** (Dir As String, FileName As String) As Boolean
*Returns true if EXIF metadata exists.  
 Directory of the file.  
 Name of the file.*- **HasGps** (Dir As String, FileName As String) As Boolean
*Returns true if GPS metadata exists.  
 Directory of the file.  
 Name of the file.*- **HasIptc** (Dir As String, FileName As String) As Boolean
*Returns true if IPTC metadata exists.  
 Directory of the file.  
 Name of the file.*- **Initialize** (eventName As String)
*Initialises the library.  
 Event name prefix for callbacks.*- **ReadMetadata** (Dir As String, FileName As String)
*Reads all metadata and raises the OnMetadataReady event.  
 Event raised: OnMetadataReady (Success As Boolean, Result As Map)  
 Directory of the file.  
 Name of the file.*
  
**PLEASE NOTE:   
TO RUN THE ATTACHED EXAMPLE, YOU NEED TO DOWNLOAD THE THIRD-PARTY JAVA DEPENDENCIES LINKED BELOW, AS WELL AS USING THE ATTACHED POST LIBRARY.**  
[**CLICK HERE** - Download Extra Libraries](https://www.dropbox.com/scl/fi/64z08isb67hja8xc5nh5f/EXIFData.zip?rlkey=huscsreog4t9ailyhjdno84ao&dl=0) <<<<<<<<<<<<<<<<<<<<<<<<  
  
**Enjoy…**