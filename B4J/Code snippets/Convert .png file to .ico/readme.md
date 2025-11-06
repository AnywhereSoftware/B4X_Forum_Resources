### Convert .png file to .ico by walt61
### 11/05/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/169222/)

```B4X
' IMPORTANT: this didn't seem to work with png files sized 512x512.  
' It did work with 256x256; I didn't try any other sizes.  
Private Sub PNGtoICO(pngDir As String, pngFile As String, icoDir As String, icoFile As String)  
  
    ' Dependencies:  
    ' - #AdditionalJar: image4j-0.7.2 (from https://image4j.sourceforge.net)  
    ' - Library: JavaObject  
  
    ' Code based on:  
    ' - https://www.b4x.com/android/forum/threads/solved-how-to-create-jpeg-output-stream.83830/#post-531280  
    ' - https://zetcode.com/articles/javaico/  
  
    Dim img As Image  
    img.Initialize(pngDir, pngFile)  
    Dim outputStream1 As OutputStream = File.OpenOutput(icoDir, icoFile, False)  
    Me.as(JavaObject).RunMethod("saveImageAsICO", Array(img, outputStream1))  
    outputStream1.Close  
  
End Sub  
  
#If Java  
    import java.awt.image.BufferedImage;  
    import java.io.IOException;  
    import java.io.OutputStream;  
    import javafx.scene.image.Image;  
    import javafx.embed.swing.SwingFXUtils;  
    import net.sf.image4j.codec.ico.ICOEncoder;  
  
    public static void saveImageAsICO(Image img,  
            OutputStream stream) throws IOException {  
        BufferedImage buffimg = SwingFXUtils.fromFXImage(img, null);  
        ICOEncoder.write(buffimg, stream);  
    }  
#End If
```