### MemTypeChecker – 100% Reliable Image Validation (Magic Numbers + MIME + Decoding) by Addo
### 03/02/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/165914/)

**Author:** Addo  
**Version:** 1.0  
**Requires:** Java 8+  
**Library Type:** Java-based wrapper for B4J  
  
MemTypeChecker is a **100% reliable** image validation library for B4J. Unlike simple file extension checks, this library uses **three levels of verification** to ensure an uploaded file is a real image:  
  
✅ **Magic Number Check** – Detects images based on their **actual file signature**.  
✅ **MIME Type Check** – Uses Java's built-in Files.probeContentType().  
✅ **Image Decoding Test** – Ensures the file is **not corrupted** by attempting to decode it.  
  
This ensures **hackers cannot bypass validation** by renaming files like malware.exe → image.jpg! 🚀  
  
[HEADING=1]🔹 **Features**[/HEADING]  
✔ Supports **JPEG, PNG, GIF, BMP, and WebP** images.  
✔ 100% **built-in Java solution** – **no external dependencies**.  
✔ Works on **Java 8 and above**.  
✔ Fast and efficient image verification.  
  
**Usage**  
  

```B4X
' simply declare it  
Dim checker As MemTypeChecker  
  
' then use it  
Log(checker.isValidImageMagicNumber(File.DirApp & "/tempUpload/2.gif"))
```

  
  
**Get MIME Type of a File**  
  

```B4X
Dim mime As String = checker.getMimeType(filePath)  
Log("MIME Type: " & mime)
```

  
  
**Check Only the Magic Number**  
  

```B4X
If checker.IsValidImageMagicNumber(filePath) Then  
    Log("File has a valid image signature!")  
Else  
    Log("Invalid image signature!")  
End If
```

  
  
  
**Check If an Image Can Be Decoded**  

```B4X
If checker.CanDecodeImage(filePath) Then  
    Log("Image is readable!")  
Else  
    Log("Image is corrupted or not an image!")  
End If
```

  
  
[HEADING=1]🔹 **How It Works Internally**[/HEADING]  
1️⃣ **Magic Number Check** – Reads the first few bytes of the file and compares with known image signatures.  
2️⃣ **MIME Type Check** – Uses Files.probeContentType() to verify the OS-reported MIME type.  
3️⃣ **Decode Image** – Uses Java’s ImageIO.read() to confirm the file is **truly** an image.  
  
[HEADING=1]🔹 **Changelog**[/HEADING]  
**v1.0** (Initial Release)  
  

- Added magic number verification for **JPEG, PNG, GIF, BMP, WEBP**.
- Integrated Java **MIME type detection**.
- Added **image decoding validation** using ImageIO.read().

I hope this can be useful to anyone were looking for similar approach in b4j. have a good day/evening everyone