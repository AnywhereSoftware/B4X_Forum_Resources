### Thumbnailator library - Pnd_Thumbnailator - Create image thumbnails (UI/Non-UI/Server) by Pendrush
### 01/01/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/164895/)

Wrapper is based on Thumbnailator v0.4.20 from [HERE](https://github.com/coobird/thumbnailator).  
  
[SIZE=5]**Features:**[/SIZE]  

- Create high-quality thumbnails from existing images.
- Option to embed a watermark (such as a logo) in the thumbnails.
- Transparency of the watermark is adjustable from transparent (0%) to opaque (100%).
- Supports rotation of thumbnail.
- Multiple quality modes for thumbnail generation.
- Preserves the aspect ratio of resulting thumbnail, if desired.
- Work on UI/Non-UI/Server applications.

  
> **Pnd\_Thumbnailator  
>   
> Author:** Author: Coobird - B4j Wrapper: Pendrush  
> **Version:** 0.90  
>
> - **Pnd\_Thumbnailator**
>
> - **Functions:**
>
> - **AlphaInterpolationDefault**
> *Sets the alpha interpolation mode when performing the resizing operation to generate the thumbnail.  
>  A hint which indicates to use the default alpha interpolation settings.*- **AlphaInterpolationQuality**
> *Sets the alpha interpolation mode when performing the resizing operation to generate the thumbnail.  
>  A hint used to emphasize quality when performing alpha interpolation.*- **AlphaInterpolationSpeed**
> *Sets the alpha interpolation mode when performing the resizing operation to generate the thumbnail.  
>  A hint used to emphasize speed when performing alpha interpolation.*- **AntialiasingDefault**
> *Sets the antialiasing mode when performing the resizing operation to generate the thumbnail.  
>  A hint to use the default antialiasing settings.  
>  Calling this method multiple times will result in an IllegalStateException.*- **AntialiasingOff**
> *Sets the antialiasing mode when performing the resizing operation to generate the thumbnail.  
>  A hint to disable antialiasing.  
>  Calling this method multiple times will result in an IllegalStateException.*- **AntialiasingOn**
> *Sets the antialiasing mode when performing the resizing operation to generate the thumbnail.  
>  A hint to enable antialiasing.  
>  Calling this method multiple times will result in an IllegalStateException.*- **DitheringDefault**
> *Sets the dithering mode when performing the resizing operation to generate the thumbnail.  
>  A hint to use the default dithering settings.*- **DitheringDisable**
> *Sets the dithering mode when performing the resizing operation to generate the thumbnail.  
>  A hint used to disable dithering.*- **DitheringEnable**
> *Sets the dithering mode when performing the resizing operation to generate the thumbnail.  
>  A hint used to enable dithering.*- **ForceSize** (Width As Int, Height As Int)
> *Sets the size of the thumbnail.  
>  The thumbnails will be forced to the specified size, therefore, the aspect ratio of the original image will not be preserved in the thumbnails.*- **Initialize** (ImagePath As String)
> *ImagePath - File names of image for which thumbnails are to be produced for.*- **IsInitialized** As Boolean
> - **OutputFormat** (Format As String)
> *Sets the compression format to use when writing the thumbnail.  
>  For example, to set the output format to JPEG, the following code can be used:  
>  Format - jpg, png, etc…*- **OutputQuality** (Quality As Double)
> *Sets the output quality of the compression algorithm used to compress the thumbnail when it is written to an external destination such as a file or output stream.  
>  The value is a double between 0.0 and 1.0 where 0.0 indicates the minimum quality and 1.0 indicates the maximum quality settings should be used for by the compression codec.  
>  Quality - Between 0.0 and 1.0*- **RenderingDefault**
> *Sets the rendering mode when performing the resizing operation to generate the thumbnail.  
>  A hint to use the default rendering settings.*- **RenderingQuality**
> *Sets the rendering mode when performing the resizing operation to generate the thumbnail.  
>  A hint used to emphasize quality when rendering.*- **RenderingSpeed**
> *Sets the rendering mode when performing the resizing operation to generate the thumbnail.  
>  A hint used to emphasize speed when rendering.*- **Rotate** (Angle As Double)
> *Sets the amount of rotation to apply to the thumbnail.  
>  The thumbnail will be rotated clockwise by the angle specified.  
>  This method can be called multiple times to apply multiple rotations.  
>  If multiple rotations are to be applied, the rotations will be applied in the order that this method is called.*- **Scale** (ScaleWidth As Double, ScaleHeight As Double)
> *Sets the scaling factor for the width and height of the thumbnail.  
>  If the scaling factor for the width and height are not equal, then the thumbnail will not preserve the aspect ratio of the original image.  
>  ScaleWidth - The scaling factor to use for the width when creating a thumbnail. The value must be a double which is greater than 0.0  
>  ScaleHeight - The scaling factor to use for the height when creating a thumbnail.The value must be a double which is greater than 0.0*- **ScalingModeBicubic**
> *Sets the resizing scaling mode to use when creating the thumbnail.  
>  A hint to use bicubic interpolation when resizing images.*- **ScalingModeBilinear**
> *Sets the resizing scaling mode to use when creating the thumbnail.  
>  A hint to use bilinear interpolation when resizing images.*- **ScalingModeProgressiveBilinear**
> *Sets the resizing scaling mode to use when creating the thumbnail.  
>  A hint to use progressing bilinear interpolation when resizing images.*- **Size** (Width As Int, Height As Int)
> *Sets the size of the thumbnail.  
>  The thumbnail will preserve the aspect ratio of the original image.  
>  If the thumbnail should be forced to the specified size, the ForceSize(int, int) method can be used instead of this method.*- **SourceRegion** (X As Int, Y As Int, Width As Int, Height As Int)
> *Specifies the region of the source image where the thumbnail will be created from.  
>  Calling this method multiple times will result in an IllegalStateException to be thrown.  
>  X – The horizontal-component of the top left-hand corner of the source region.  
>  Y – The vertical-component of the top left-hand corner of the source region.  
>  Width – Width of the source region.  
>  Height – Height of the source region.*- **ToFile** (OutFilePath As String)
> *Create a thumbnail and writes it to a File.  
>  When the destination file exists, and overwriting files has been disabled by calling the AllowOverwrite(boolean) method with false, then an IllegalArgumentException will be thrown.  
>  To call this method, the thumbnail must have been created from a single source.  
>  OutFilePath - The file to which the thumbnail is to be written to.*- **ToOutputStream** As java.io .OutputStream
> *Create a thumbnail and writes it to a OutputStream.*- **UseOriginalFormat**
> *Sets the compression format to use the same format as the original image.  
>  Calling this method multiple times will result in an IllegalStateException to be thrown.*- **Watermark** (X As Int, Y As Int, WatermarkImagePath As String, Opacity As Float)
> *Sets the image and opacity and position of the watermark to apply on the thumbnail.  
>  This method can be called multiple times to apply multiple watermarks.  
>  If multiple watermarks are to be applied, the watermarks will be applied in the order that this method is called.  
>  X, Y - The position of the watermark.  
>  WatermarkImagePath - The image of the watermark.  
>  Opacity - The opacity of the watermark. The value should be between 0.0 and 1.0, where 0.0 is completely transparent, and 1.0 is completely opaque.*
> - **Properties:**
>
> - **AllowOverwrite** As Boolean [write only]
> *Specifies whether or not to overwrite files which already exist if they have been specified as destination files.*- **KeepAspectRatio** As Boolean [write only]
> *Sets whether or not to keep the aspect ratio of the original image for the thumbnail.  
>  Setting this method without first calling the Size(int, int) method will result in an IllegalStateException to be thrown.*- **UseExifOrientation** As Boolean [write only]
> *Sets whether or not to use the Exif metadata when orienting the thumbnail.  
>  Calling this method multiple times will result in an IllegalStateException to be thrown.  
>  True if the Exif metadata should be used to determine the orientation of the thumbnail, false otherwise.*