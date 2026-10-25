### Base64 encode/decode image library by Peter Simpson
### 10/23/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/31031/)

I noticed the other day that there were quite a few questions regarding decoding base64 image stings, so I quickly put together this simple but effective base64 encode/decode images library for others to use.  
  
I will be turning more of my simple but useful routines to libraries, but not too many :)  
  
**Instructions:**  
In Globals add the following line  
 Dim Base64Con As Base64Image  
 Dim Base64Con As Base64Convert  
  
To get an encoded base64 data stream, and return it as an bitmap ready to load into an image view for example, use the following line.  
 Base64Con.DecodeToImage(**ImgStr** As String) As Bitmap  
  
**Or**  
  
To get an image file, and encode it into an base64 data stream, ready to save into a database or file for example, use the following line.  
 Base64Con.EncodeFromImage(**FolderPath** As String, **Filename** As String) As String  
  
Quite simple to use really.  
  
Anyway, I hope that it work great for you all, well that's if anybody uses it :)  
Just download the library and let me know what you think about it.  
  
**UPDATED:** 09/04/2018: 1.10  
 Removed logs  
  
This library is extremely simple to use.  
  
**SS\_Base64Convert  
  
Author:** Peter Simpson  
**Version:** 1.1  

- **Base64Convert**

- **Functions:**

- **DecodeToImage** (ImageStr As String) As Bitmap
*Use this call to decode the base64 datastream into an image*- **EncodeFromImage** (FolderPath As String, Filename As String) As String
*Use this call to encode the image into a base64 datastream*- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
***UPDATE - R8 Optimizer:**  
To use this library with the R8 Optimizer, download the attached SS\_Base64Convert.proguard file and place it in your B4A Additional Libraries folder alongside the .jar and .xml files.*  
  
Cheers :cool: