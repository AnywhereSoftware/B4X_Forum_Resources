### Image file manager (converter / resizer / compressor etc) library by Peter Simpson
### 10/05/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/172209/)

Hello everyone,  
Here is my image file library that is designed for comprehensive image management, processing, and conversion. It provides robust asynchronous background tasks for converting single images or entire folders, alongside precise capabilities for resizing, scaling, cropping, rotating, and extracting detailed EXIF, IPTC, and XMP metadata. Featuring flexible byte array and stream handling, format probing, and custom compression controls, it equips B4J developers with all the tools necessary to manipulate and handle multiple image formats efficiently.  
  
**Read (Load file type):**  
png, jpg, jpeg, webp, tga, targa, bigtiff, tiff, tif, bmp, gif, ico, iff, pcx, pict, pct, sgi  
  
**Write (Convert to file type):**  
bigtiff, bmp, gif, ico, iff, jpeg, jpg, pct, pict, png, tga, targa, tif, tiff, wbmp  
  
If you are converting to either a jpg or jpeg, you can set the saved image quality by using the **Quality** combo-box. When converting to ico, the convert to ico image dimentions must be 256 x 256 or less. At the bottom of the B4XMainPage module, are some basic instructions under '*Here is exactly what this library can and cannot convert using the bundled registered ImageIO readers/writers*'. In theory you shouldn't need to read this section.   
  
**B4J Library Tab**  
![](https://www.b4x.com/android/forum/attachments/173920)  
  
**SS\_ImageConverter**  
  
**Author:** Peter Simpson  
**Version:** 1.0  

- **ImageConverter**

- **Events:**

- **Complete** (Success As Boolean, SourcePath As String, TargetPath As String, Message As String)
- **FolderComplete** (Success As Boolean, Count As Int, Message As String)
- **MetadataComplete** (Meta As Map)
- **Progress** (Percent As Int, CurrentFile As String)

- **Fields:**

- **UseCompression** As Boolean
*Determines whether output compression is enabled. Default is false.  
 When true, explicit compression is applied only to JPG, JPEG, TIF, TIFF, and BigTIFF formats.*
- **Functions:**

- **ConvertBufferedImageToBytes** (img As java.awt.image.BufferedImage, formatName As String) As Byte()
*Converts a BufferedImage into a raw byte array using the specified format.  
 img specifies the source BufferedImage object.  
 formatName specifies the target format extension.*- **ConvertBytesToImage** (data As Byte(), targetPath As String, formatName As String) As Boolean
*Decodes a byte array into an image and saves it to a file.  
 data specifies the raw image byte array.  
 targetPath specifies the absolute path for the saved image.  
 formatName specifies the target format extension.*- **ConvertFolder** (sourceDir As String, targetDir As String, formatName As String, newWidth As Int, newHeight As Int, keepProportions As Boolean, imageQuality As Int)
*Scans a directory and asynchronously converts all valid images into the target format on a background thread.  
 sourceDir specifies the absolute path of the source directory.  
 targetDir specifies the absolute path of the destination directory.  
 formatName specifies the target format extension for all files.  
 newWidth specifies the target width in pixels (use 0 to keep original).  
 newHeight specifies the target height in pixels (use 0 to keep original).  
 keepProportions specifies whether to lock the aspect ratio during resize.  
 imageQuality specifies the output compression quality from 0 to 100 for JPG.*- **ConvertImage** (sourcePath As String, targetPath As String, formatName As String, newWidth As Int, newHeight As Int, keepProportions As Boolean, imageQuality As Int)
*Converts an image file on a background thread.  
 sourcePath specifies the absolute path of the original image.  
 targetPath specifies the absolute path for the converted image.  
 formatName specifies the target format extension.  
 newWidth specifies the target width in pixels (use 0 to keep original).  
 newHeight specifies the target height in pixels (use 0 to keep original).  
 keepProportions specifies whether to lock the aspect ratio during resize.  
 imageQuality specifies the output compression quality from 0 to 100 for JPG.*- **ConvertImageBuffered** (sourceImage As java.awt.image.BufferedImage, imageType As Int) As java.awt.image.BufferedImage
*Converts a BufferedImage to a different image type in memory.  
 sourceImage specifies the original BufferedImage.  
 imageType specifies the target integer image type.*- **ConvertImageStream** (inputStream As java.io.InputStream, outputStream As java.io.OutputStream, formatName As String) As Boolean
*Reads an image from an input stream and writes it to an output stream in the requested format.  
 inputStream specifies the source data stream.  
 outputStream specifies the target data stream.  
 formatName specifies the target format extension.*- **ConvertImageToBufferedImage** (imageData As Byte()) As java.awt.image.BufferedImage
*Converts a raw byte array of image data into a BufferedImage.  
 imageData specifies the raw image byte array.*- **ConvertImageToBytes** (sourcePath As String, formatName As String) As Byte()
*Reads an image and exports it directly to a byte array in the requested format.  
 sourcePath specifies the absolute path of the image file.  
 formatName specifies the target format extension.*- **CropImage** (sourcePath As String, targetPath As String, x As Int, y As Int, width As Int, height As Int, formatName As String) As Boolean
*Crops a rectangular region from an image and saves it to a new file.  
 sourcePath specifies the absolute path of the original image.  
 targetPath specifies the absolute path for the cropped image.  
 x specifies the starting X coordinate.  
 y specifies the starting Y coordinate.  
 width specifies the crop region width.  
 height specifies the crop region height.  
 formatName specifies the target format extension.*- **GetFormat** (sourcePath As String) As String
*Probes an image file to detect its actual format name.  
 sourcePath specifies the absolute path of the image file.*- **GetHeight** (sourcePath As String) As Int
*Reads an image file and returns its height.  
 sourcePath specifies the absolute path of the image file.*- **GetImageInfo** (sourcePath As String) As String
*Retrieves a quick summary of the image format and dimensions.  
 sourcePath specifies the absolute path of the image file.*- **GetMetadata** (sourcePath As String)
*Extracts available EXIF, IPTC, and XMP metadata from an image file on a background thread.  
 sourcePath specifies the absolute path of the image file.*- **GetWidth** (sourcePath As String) As Int
*Reads an image file and returns its width.  
 sourcePath specifies the absolute path of the image file.*- **HasReader** (formatName As String) As Boolean
*Checks if a reader plugin is available for a given format.  
 formatName specifies the image format extension to check.*- **HasWriter** (formatName As String) As Boolean
*Checks if a writer plugin is available for a given format.  
 formatName specifies the image format extension to check.*- **Initialize** (EventName As String)
*Initialises the converter object.  
 EventName specifies the event name prefix for callbacks.*- **IsInitialized** As Boolean
*Returns true if the object has been initialized.*- **LoadImage** (sourcePath As String) As java.awt.image.BufferedImage
*Loads an image from a file path directly into a BufferedImage.  
 sourcePath specifies the absolute path of the image file.*- **ResizeImage** (sourcePath As String, targetPath As String, newWidth As Int, newHeight As Int, formatName As String, keepProportions As Boolean, imageQuality As Int) As Boolean
*Resizes an image to explicit pixel dimensions and saves it to a new file.  
 sourcePath specifies the absolute path of the original image.  
 targetPath specifies the absolute path for the resized image.  
 newWidth specifies the target width in pixels.  
 newHeight specifies the target height in pixels.  
 formatName specifies the target format extension.  
 keepProportions specifies whether to lock the aspect ratio during resize.  
 imageQuality specifies the output compression quality from 0 to 100 for JPG.*- **RotateImage** (sourcePath As String, targetPath As String, degrees As Double, formatName As String) As Boolean
*Rotates an image by a set number of degrees and saves it to a new file.  
 sourcePath specifies the absolute path of the original image.  
 targetPath specifies the absolute path for the rotated image.  
 degrees specifies the rotation angle.  
 formatName specifies the target format extension.*- **SaveImage** (img As java.awt.image.BufferedImage, targetPath As String, formatName As String) As Boolean
*Saves a BufferedImage directly to a file on disk.  
 img specifies the source BufferedImage object.  
 targetPath specifies the absolute path for the saved image.  
 formatName specifies the target format extension.*- **ScaleImage** (sourcePath As String, targetPath As String, scaleFactor As Double, formatName As String) As Boolean
*Scales an image based on a multiplication factor and saves it to a new file.  
 sourcePath specifies the absolute path of the original image.  
 targetPath specifies the absolute path for the scaled image.  
 scaleFactor specifies the multiplier for dimensions.  
 formatName specifies the target format extension.*- **Stop**
*Signals any active conversion or folder batch operation to stop immediately.*- **SupportedFormats** As String()
*Returns an array of all supported format names available for reading.*- **SupportedWriterFormats** As String()
*Returns an array of all supported format names available for writing.*
- **Properties:**

- **LastError** As String [read only]
*Retrieves the last error message that occurred during an operation.*
  
**B4J Screenshots below**  
![](https://www.b4x.com/android/forum/attachments/173921)  
  
**Select what to convert the image to**  
![](https://www.b4x.com/android/forum/attachments/173922)  
  
**PLEASE NOTE:  
TO RUN THE ATTACHED EXAMPLE, YOU NEED TO DOWNLOAD THE THIRD-PARTY **JAVA DEPENDENCIES** LINKED BELOW, AS WELL AS USING THE ATTACHED POST LIBRARY.**  
[**CLICK HERE**](https://www.dropbox.com/scl/fi/pdadzn9k1takkiyhyecu1/Image-Converter-Dependencies.zip?rlkey=hjobhtk7t3v1qdtziq2mh78rn&st=9p1byv3u&dl=0) to download extra dependencies <<<<<<<<<<<<<<<<<<<<<<<<  
  
  
**Enjoy…**