### jMagicImage - Read exif and metadata data, convert, compress image, also some basic image filters by Pendrush
### 05/21/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/130857/)

Original libarary: <https://github.com/magiclen/MagicImage>  
  
jMagicImage is a B4j (wrapper) library for image processing. It can support many formats of images in Java programs and provide common functions to make adjustments to the image.  
After you finish adjusting your images, you can export them to many formats, too.  
  
![](https://www.b4x.com/android/forum/attachments/113813)  
  
Download library from [**THIS LINK**](https://www.dropbox.com/s/clit6kxtvhwb6lj/MagicImageLibrary.zip?dl=0).  
  
> **jMagicImage  
>   
> Author:** Author: Magiclen - B4j Wrapper: Pendrush  
> **Version:** 1.10  
>
> - **jMagicImage**
>
> - **Functions:**
>
> - **BinaryImage**
> *Method to create a binary image (only black and white colors).   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "nasa.png"))  
> MagicImage1.BinaryImage()  
> Dim PngFilePathBinaryImage As String = MagicImage1.ExportToPNG(File.Combine(File.DirApp, "nasa2-binary.png"))  
> Log("PngFilePathBinaryImage: " & PngFilePathBinaryImage)*- **BlurImage** (BlurLevel As Int)
> *Method to blur an image. You can also decide how much you want to blur.   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "test.png"))  
> Dim BlurLevel As Int = 20  
> MagicImage1.BlurImage(BlurLevel)  
> Dim PngFilePathBlur As String = MagicImage1.ExportToPNG(File.Combine(File.DirApp, "test2-blur.png"))  
> Log("PngFilePathBlur: " & PngFilePathBlur)*- **Crop** (Width As Int, Height As Int, X As Int, Y As Int)
> *Method to crop an image.   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "nasa.png"))  
> MagicImage1.Crop(200, 200, 50, 50)  
> Dim PngFilePathCropImage As String = MagicImage1.ExportToPNG(File.Combine(File.DirApp, "nasa2-crop.png"))  
> Log("PngFilePathCropImage: " & PngFilePathCropImage)*- **ExportToBMP** (ExportFilePath As String) As String
> *Export image to BMP format.   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "test.png"))  
> Dim BmpFilePath As String = MagicImage1.ExportToBMP(File.Combine(File.DirApp, "test5.bmp"))  
> Log("BmpFilePath: " & BmpFilePath)*- **ExportToGIF** (ExportFilePath As String) As String
> *Export image to GIF format.   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "test.png"))  
> Dim GifFilePath As String = MagicImage1.ExportToGIF(File.Combine(File.DirApp, "test4.gif"))  
> Log("GifFilePath: " & GifFilePath)*- **ExportToJPEG** (ExportFilePath As String, Quality As Float) As String
> *Export image to JPEG format. You can also decide its quality to compress the file size.  
> Quality as float from 0.01 to 1.0   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "test.png"))  
> Dim Quality As Float = 0.5  
> Dim JpegFilePath As String = MagicImage1.ExportToJPEG(File.Combine(File.DirApp, "test1.jpg"), Quality)  
> Log("JpegFilePath:" & JpegFilePath)*- **ExportToPNG** (ExportFilePath As String) As String
> *Export image to PNG format.   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "test.png"))  
> Dim PngFilePath As String = MagicImage1.ExportToPNG(File.Combine(File.DirApp, "test2.png"))  
> Log("PngFilePath: " & PngFilePath)*- **ExportToTIFF** (ExportFilePath As String, Quality As Float, Lossless As Boolean) As String
> *Export image to TIFF format. You can also decide its compression quality to decrease the file size, and lossless or lossy.  
> Quality as float from 0.01 to 1.0   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "test.png"))  
> Dim Quality As Float = 0.1  
> Dim TiffFilePath As String = MagicImage1.ExportToTIFF(File.Combine(File.DirApp, "test3.tiff"), Quality, True)  
> Log("TiffFilePath: " & TiffFilePath)*- **GaussianBlur** (GaussianBlurLevel As Int)
> *Method to gaussian blur an image. You can also decide how much you want to blur.   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "test.png"))  
> Dim GaussianBlurLevel As Int = 30  
> MagicImage1.GaussianBlur(GaussianBlurLevel)  
> Dim PngFilePathGaussianBlur As String = MagicImage1.ExportToPNG(File.Combine(File.DirApp, "test2-gaussian-blur.png"))  
> Log("PngFilePathGaussianBlur: " & PngFilePathGaussianBlur)*- **GetImageAsInputStream** As java.io.InputStream
> *Return current image as InputStream.*- **GrayImage**
> *Method to create a grayscale image.   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "test.png"))  
> MagicImage1.GrayImage  
> Dim PngFilePathGrey As String = MagicImage1.ExportToPNG(File.Combine(File.DirApp, "test2-gray.png"))  
> Log("PngFilePathGrey: " & PngFilePathGrey)*- **Initialize**
> *Initialize library*- **LoadImage** (ImagePath As String)
> *Load image file   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "test.png"))*- **NegativeImage**
> *Method to create a negative image.   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "test.png"))  
> MagicImage1.NegativeImage  
> Dim PngFilePathNegative As String = MagicImage1.ExportToPNG(File.Combine(File.DirApp, "test2-negative.png"))  
> Log("PngFilePathNegative: " & PngFilePathNegative)*- **ReadMetadataFromFile** (FilePath As String) As String
> *Read metadata from file in JSON format   
> Dim JsonData As String = MagicImage1.ReadMetadataFromFile(File.Combine(File.DirApp, "test.png"))  
> Log(JsonData)*- **Resize** (MaxSide As Int, Sharpen As Float, OnlyShrink As Boolean, SharpenOnlyShrink As Boolean)
> *Method to resize an image. It can also sharpen the image resized automatically.   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "nasa.png"))  
> MagicImage1.Resize(1000, 10, False, False)  
> Dim PngFilePathResize As String = MagicImage1.ExportToPNG(File.Combine(File.DirApp, "nasa2-resize.png"))  
> Log("PngFilePathResize: " & PngFilePathResize)*- **SharpenImage** (SharpenLevel As Float)
> *Method to sharpen an image. You can also decide how much you want to sharpen.   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "test.png"))  
> Dim SharpenLevel As Float = 3  
> MagicImage1.SharpenImage(SharpenLevel)  
> Dim PngFilePathSharpen As String = MagicImage1.ExportToPNG(File.Combine(File.DirApp, "test2-sharpen.png"))  
> Log("PngFilePathSharpen: " & PngFilePathSharpen)*- **Shrink** (MaxWidth As Int, MaxHeight As Int, Sharpen As Float)
> *Method to shrink an image. It can also sharpen the image resized automatically.   
> MagicImage1.LoadImage(File.Combine(File.DirApp, "nasa.png"))  
> MagicImage1.Shrink(100, 100, 1)  
> Dim PngFilePathShrink As String = MagicImage1.ExportToPNG(File.Combine(File.DirApp, "nasa2-shrink.png"))  
> Log("PngFilePathShrink: " & PngFilePathShrink)*