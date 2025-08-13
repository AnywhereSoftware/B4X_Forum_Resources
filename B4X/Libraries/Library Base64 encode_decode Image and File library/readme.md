###  Library Base64 encode/decode Image and File library by MarcoRome
### 08/26/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/115033/)

**Updated Library** <https://www.b4x.com/android/forum/threads/b4x-library-base64-encode-decode-image-and-file-library.115033/page-2#post-998317>  
  
From an idea of the Great Peter ( <https://www.b4x.com/android/forum/threads/base64-encode-decode-image-library.31031/> ) "…in attached the library for decoding base64 image stings, so I quickly put together this simple but effective base64 encode/decode images library for others to use…"  
  
In version 1.13 also added the BaseAnyFileToString + Base64StringToAnyFile method. To convert any file to Base64.  
  
**The library is for B4X (Tested with B4J, B4A, B4i)**  
  
The Example Code:  
  

```B4X
'File 653 kb  
    File.Copy(File.DirAssets, "653.jpg", File.DirInternal,"653.jpg")  
    Sleep(300)  
  
    'Image to Encode64  
    Dim base As String = Base64EncodeDecodeImage.Base64ImageToString(File.DirInternal,"653.jpg")  
  
    'Check if Valid Base64  
    If Base64EncodeDecodeImage.ValidBase64(base) Then  
        ImageView1.Bitmap = Base64EncodeDecodeImage.Base64StringToImage(base)  
    End If  
  
    Sleep(2000)  
  
    'Convert without Dir / File as request #8  
    Dim bitmap1 As B4XBitmap = ImageView1.Bitmap  
    Dim base As String = Base64EncodeDecodeImage.Base64ImageToString2(bitmap1)  
    ImageView2.Bitmap = Base64EncodeDecodeImage.Base64StringToImage(base)  
  
    'Any File to Encode64  
    Dim pdf_base64 As String = Base64EncodeDecodeImage.Base64AnyFileToString(File.DirApp, "example_5_pages.pdf")  
   
    'Check if Valid Base64  
    If Base64EncodeDecodeImage.ValidBase64(pdf_base64) Then  
       Base64EncodeDecodeImage.Base64StringToAnyFile(pdf_base64, File.DirApp, "convert.pdf")  
    End If
```

  
  
Example Code B4A –> <https://www.dropbox.com/s/mohtg21cnfvaj1p/CONVERTBMPTOCODE64B4.zip?dl=0>  
Example Code B4i –> <https://www.dropbox.com/s/97x5hcexy9xgkm6/CONVERTBMPTOCODE64.zip?dl=0>  
Example Code B4J –><https://www.dropbox.com/s/888ic5l1m18f4d1/B4J-CONVERTBMPTOCODE64.zip?dl=0>  
  
In attachment library b4xlib  
Have a nice day  
Marco  
  
18.04.2021  
Rel. 1.13 –> Add Base64AnyFileToString