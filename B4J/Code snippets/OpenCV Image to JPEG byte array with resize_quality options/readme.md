### OpenCV Image to JPEG byte array with resize/quality options by OliverA
### 10/29/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143809/)

This is my third "Image to JPEG byte array with resize/quality options" snippet. The various versions are:  

1. Inline Java version, B4J only: <https://www.b4x.com/android/forum/threads/image-to-jpeg-byte-array-with-resize-quality-options.91746/>
2. XUI version, working across B4A, B4i, and B4J: <https://www.b4x.com/android/forum/threads/b4x-xui-image-to-jpeg-byte-array-with-resize-quality-options.91774/>
3. A new OpenCV version that is heavily based on the first version (published here). The initial resize is unchanged, but the code to convert the resulting BufferedImage to a JPG image and then convert it to a byte array is now using OpenCV classes/methods.

This version, unlike the previous ones, has some external prerequisites.  

- For Windows, the prerequisites are the opencv\*.jar and the opencv\*.dll files. The .jar file needs to be placed in the Additional Library folder of B4J. The opencv\*.dll file needs to be located somewhere accessible to the application since it needs to be loaded at runtime. They can be found in the .exe installer from OpenCV's site (<https://opencv.org/releases/>). After downloading the .exe file, you can open it via a zip manager or just unpack it via windows (after renaming the .exe to .zip). The opencv\*.jar file can be found in opencv\build\java and the appropriate opencv\*.dll can be found in \opencv\build\java\x64 for 64bit Windows and \opencv\build\java\x86 for 32bit Windows.

- Note: In my case, I downloaded OpenCV Release 4.6.0. The .exe file was opencv-4.6.0-vc14\_vc15.exe, the .jar file was opencv-460.jar
- One way to handle the .dll files could be to rename them (for example the 64bit opencv\_java460.dll to opencv\_java460\_64.dll and the 32bit opencv\_java460.dll to opencv\_java460\_32.dll) and place them in the Files folder of your project. Then use the following snippet to load the appropriate library for the Windows system your application is running on before using the resize snippet

```B4X
Sub LoadOpenCVDLL  
    If GetSystemProperty("os.name", "unknown").ToLowerCase.Contains("win") Then  
        If Not(File.Exists(File.DirApp, "opencv_java460.dll")) Then  
            Dim bitness As String = GetSystemProperty("sun.arch.data.model", "unknown")  
            File.Copy(File.DirAssets, $"opencv_java460_${bitness}.dll"$, File.DirApp, "opencv_java460.dll")  
        End If  
        Dim joSystem As JavaObject  
        joSystem.InitializeStatic("java.lang.System")  
        joSystem.RunMethod("load", Array(File.Combine(File.DirApp, "opencv_java460.dll")))  
    End If  
End Sub
```

  
Disclaimer: This may not be the proper way to get OpenCV properly working for Java under Windows. This happens to work for me, but maybe a full install of OpenCV is required.  

- Android: May be do-able. Android's Bitmap class has a compress method though that may provide part of the solution without requiring OpenCV. User input welcome.
- Any other OS: User input welcome

  
Why create this version? It's been pointed out by [USER=45973]@Magma[/USER] that the first two versions create temp files (<https://www.b4x.com/android/forum/threads/image-writetostream-using-disk-how-to-avoid-it.143772/>) under Windows. [USER=45973]@Magma[/USER] also wondered if there is a way to do the same without temp files and his research brought up OpenCV (he thought of more and [USER=95980]@kimstudio[/USER] also proposed some solutions, I just picked OpenCV). This version (based on OpenCV) may be the answer to the temp file creation and it seems to be a little under 2 times faster than the first solution and a bit over twice faster than the second solution listed above (via a simplistic testing of running each method 1000 times and noting the time).  
  

```B4X
' Converts image to JPEG a byte array of the resulting JPEG. Ability to resize and adjust JPEG quality.  
' Negative width and height values = %, such that -50 = 50% and -200 = 200%  
' Positive width and height values = pixel dimensions  
' If one value (either width or height) are 0, then the other value is proportionally  
'  calculated from the first.  
' If both width and height are 0 or -100, no resizing takes place  
' If quality = -1, use Java's default quality  
Sub OCVImageToJPEGByteArray(aImage As Image, width As Int, height As Int, quality As Int) As Byte()  
    Dim jo As JavaObject = Me  
    Return jo.RunMethod("ocvImageToJPEGByteArray", Array As Object (aImage, width, height, quality))  
End Sub
```

  

```B4X
#if Java  
import java.awt.AlphaComposite;  
import java.awt.image.BufferedImage;  
import java.awt.image.DataBufferByte;  
import java.awt.geom.AffineTransform;  
import java.awt.Graphics2D;  
  
import javafx.scene.image.Image;  
import javafx.embed.swing.SwingFXUtils;  
  
import org.opencv.core.CvType;  
import org.opencv.core.Mat;  
import org.opencv.core.MatOfByte;  
import org.opencv.core.MatOfInt;  
import org.opencv.imgcodecs.Imgcodecs;  
  
// Image resizing  
// https://stackoverflow.com/a/4205711  
// https://stackoverflow.com/questions/21540378/convert-javafx-image-to-bufferedimage  
// https://stackoverflow.com/a/13605411  
// https://www.mkyong.com/java/how-to-convert-bufferedimage-to-byte-in-java/  
  
// OpenCV links for creating JPG at given quality  
// Convert BufferedImage (Java) to byte array in put to Mat (OpenCV)  
// https://stackoverflow.com/a/15095653  
// Convert Mat to byte array  
// https://stackoverflow.com/a/45960893  
  
  
// Converts image to JPEG a byte array of the resulting JPEG. Ability to resize and adjust JPEG quality.  
// Negative width and height values = %, such that -50 = 50% and -200 = 200%  
// Positive width and height values = pixel dimensions  
// If one value (either width or height) are 0, then the other value is proportionally  
//  calculated from the first.  
// If both width and height are 0 or -100, no resizing takes place  
// If quality = -1, use Java's default quality  
public static byte[] ocvImageToJPEGByteArray(Image aImage, int width, int height, int qualityPercent) {  
  
   if ((qualityPercent < -1) || (qualityPercent > 100)) {  
      throw new IllegalArgumentException("Quality out of bounds!");  
    }  
     
   //float quality = qualityPercent / 100f;  
   //OpenCV just needs an int  
   int quality = qualityPercent;  
   
   double oldWidth = aImage.getWidth();  
   double oldHeight = aImage.getHeight();  
   if (oldWidth == 0 || oldHeight == 0) {  
       throw new IllegalArgumentException("Source image with 0 width and/or height!");  
   }  
   
   boolean resize = true;  
   if ((width == 0 && height == 0) || (width == -100 && height == -100)) resize = false;  
  
   BufferedImage destImage;  
   if (resize) {  
       double newWidth = (double) width;  
       double newHeight = (double) height;  
       // Calculate new dimensions  
       if (newWidth < 0) newWidth = -1 * oldWidth * newWidth / 100;  
       if (newHeight < 0) newHeight = -1 * oldHeight * newHeight / 100;  
       if (newWidth == 0) newWidth = oldWidth * newHeight / oldHeight;  
       if (newHeight == 0) newHeight = oldHeight * newWidth / oldWidth;  
       // Convert JavaFX image to BufferedImage and transform according to new dimensions  
       destImage = new BufferedImage((int) newWidth, (int) newHeight, BufferedImage.TYPE_3BYTE_BGR);  
       BufferedImage srcImage = SwingFXUtils.fromFXImage(aImage, null);  
       Graphics2D g = destImage.createGraphics();  
       AffineTransform at = AffineTransform.getScaleInstance(newWidth/oldWidth, newHeight/oldHeight);  
       g.drawRenderedImage(srcImage, at);  
       g.dispose();  
   } else {  
       //destImage = SwingFXUtils.fromFXImage(aImage, null);  
       //Need to see if we alread have the correct BufferedImage type, if not, convert  
       if (srcImage.getType() != BufferedImage.TYPE_3BYTE_BGR) {  
          //http://stackoverflow.com/questions/21740729/converting-bufferedimage-to-mat-opencv-in-java  
           destImage = new BufferedImage(srcImage.getWidth(), srcImage.getHeight(), BufferedImage.TYPE_3BYTE_BGR);  
           g = destImage.createGraphics();  
           g.setComposite(AlphaComposite.Src);  
           g.drawImage(srcImage, 0, 0, null);  
           g.dispose();  
       } else {  
          destImage = srcImage;  
       }  
   }  
   
   //Create OpenCV Mat, retrieve data from BufferedImage and assign to Mat  
   Mat mRGB = new Mat(destImage.getHeight(), destImage.getWidth(), CvType.CV_8UC3);  
   byte[] pixels = ((DataBufferByte) destImage.getRaster().getDataBuffer()).getData();  
   mRGB.put(0, 0, pixels);  
    
    
   //Convert mat to JPG byte array of given quality  
   MatOfByte mob=new MatOfByte();                        //Destination Mat byte array  
   int[] intParams = new int[2];                        //Create parameters for imencode  
   intParams[0] = Imgcodecs.IMWRITE_JPEG_QUALITY;  
   intParams[1] = (int) quality;  
   MatOfInt params = new MatOfInt(intParams);  
   Imgcodecs.imencode(".jpg", mRGB, mob, params);         
    
   return mob.toArray();                                //Convert Mat byte array to regular byte array  
}  
  
#End If
```

  
1st Edit: Cleaned up the Java code. Removed unnecessary imports, IOException declaration, and unneeded byte array.  
2nd Edit: Thanks to the prodding from [USER=95980]@kimstudio[/USER], I found a mistake in the original code. The incorrect BufferedImage was created/used when no resizing was done.