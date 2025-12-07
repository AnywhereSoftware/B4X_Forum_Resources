### How to OCR image text by jkhazraji
### 11/30/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/169501/)

1.Download the following .jar files:  
**[FONT=courier new]lept4j-1.19.0.jar[/FONT]**  
[FONT=courier new]**slf4j-api-1.7.32.jar  
jai-imageio-core-1.4.0.jar  
jna-5.14.0.jar**[/FONT]  
**[FONT=courier new]tess4j-5.10.0.jar[/FONT]  
Place then in addLibs ( or whatever)  
Refer to them with #AdditionalJar:**  
2.Download **Tesseract-OCR** and place the folder in **Objects**  
3. Use the following inline Java code:  

```B4X
import java.awt.*;  
import java.awt.image.BufferedImage;  
import java.io.File;  
import javax.imageio.ImageIO;  
import java.io.IOException;  
import net.sourceforge.tess4j.*;  
import net.sourceforge.tess4j.ITessAPI;  
import net.sourceforge.tess4j.Word;  
import java.util.List;  
  
public static void OCRImage(String imgPath) {  
        ITesseract tesseract = new Tesseract();  
        tesseract.setDatapath("tessdata"); // Set the path to tessdata folder Objects\tessdata)  
        try {  
            // Load an image file  
            BufferedImage image = ImageIO.read(new File(imgPath));  
             
            // Perform OCR on the image  
            String text = tesseract.doOCR(image);  
             
            // Print the extracted text  
            System.out.println("Extracted Text: " + text);  
  
        } catch (TesseractException | IOException e) {  
            e.printStackTrace();  
        }  
    }
```

  
4. Call it from b4j:  

```B4X
(Me).As(JavaObject).RunMethod("OCRImage",Array(File.Combine(File.DirApp,"b4j.png")))
```

  
  
**N.B.** This applies to English texts of course.