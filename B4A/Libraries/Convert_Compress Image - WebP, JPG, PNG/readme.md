### Convert/Compress Image - WebP, JPG, PNG by Pendrush
### 05/17/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/130827/)

Convert/Compress Image between different formats WebP, JPG, PNG.  
  
> **ConvertImage  
>   
> Author:** Pendrush  
> **Version:** 1.00  
>
> - **ConvertImage**
>
> - **Events:**
>
> - **OnComplete**
> - **OnError** (Error As String)
>
> - **Fields:**
>
> - **TO\_JPEG** As android.graphics.Bitmap.CompressFormat
> *Compress to the JPEG format*- **TO\_PNG** As android.graphics.Bitmap.CompressFormat
> *Compress to the PNG format. PNG is lossless, so quality is ignored*- **TO\_WEBP** As android.graphics.Bitmap.CompressFormat
> *Compress to the WEBP format*
> - **Functions:**
>
> - **ConvertBitmapToFile** (InputBitmap As android.graphics.Bitmap, SavePath As String, ToFormat As android.graphics.Bitmap.CompressFormat, Quality As Int)
> *InputBitmap - Bitmap to compress  
> SavePath - Path where new converted/compressed image will be saved  
> ToFormat - Use one of constant TO\_WEBP, TO\_JPEG, TO\_PNG  
> Quality - From 0 to 100. Quality of 0 means compress for the smallest size. 100 means compress for max visual quality.  
> Dim Bitmap1 As Bitmap = LoadBitmap(File.DirAssets, "test.png")  
> Dim SavePathAndFileName As String = File.Combine(File.DirInternal, "test.webp")  
>  ConvertImage1.ConvertBitmapToFile(Bitmap1, SavePathAndFileName, ConvertImage1.TO\_WEBP, 100)*- **Initialize** (EventName As String)
> *Initialize library  
>  ConvertImage1.Initialize("ConvertImage1")*