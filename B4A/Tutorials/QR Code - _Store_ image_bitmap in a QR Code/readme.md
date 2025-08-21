### QR Code - "Store" image/bitmap in a QR Code by Johan Schoeman
### 04/10/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/116155/)

See attached B4A project:  
  
1. It takes an image (png or jpg) and convert it into a byte array  
2. The byte array is converted into a Base64 String  
3. The String is then converted into a QR Code (bitmap)  
4. Use the QR Code bitmap and decodes it into a string (Base64)  
5. Convert the Base64 string extracted from the QR Code into a byte array  
6. Converts the byte array into a Bitmap and display it in iv3  
  
You need to extract core-3.3.2.jar from the attached zip folder and copy it to your additional library folder.  
  
Same can be done by using PDF417 and other 2D barcodes.  
  
Enjoy!  
  
  
![](https://www.b4x.com/android/forum/attachments/91546)  
Probably not the ideal thing to do with QR Codes i.e storing a bitmap/image in a QR Code (QR Code limited in terms of number of bytes) but it can be done as what the attached project demonstrates.  
  
Sample Code:  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: b4aQRImage  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: portrait  
    #CanInstallToExternalStorage: False  
#End Region  
  
#AdditionalJar: core-3.3.2.jar  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
     
    Dim nativeMe As JavaObject  
  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Private iv1 As ImageView  
    Private iv2 As ImageView  
    Private iv3 As ImageView  
     
    Dim  bm As Bitmap  
     
    Dim su As StringUtils  
     
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("main")  
    nativeMe.InitializeContext  
     
    bm.Initialize(File.DirAssets, "jhs.png")  
    Dim b() As Byte = GetImageBytes  
     
    Dim s As String = su.EncodeBase64(b)  
    Log(s)  
     
    iv2.Bitmap = nativeMe.RunMethod("encodeAsBitmap", Array(s))  
     
    Dim decoded As String = nativeMe.RunMethod("decodeQRImage", Array(iv2.Bitmap))  
    Log(decoded)  
     
    Dim nb() As Byte = su.DecodeBase64(decoded)  
    iv3.Bitmap = BytesToImage(nb)  
   
     
   
   iv1.Bitmap = bm  
  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub GetImageBytes() As Byte()  
    Dim bytes() As Byte = Bit.InputStreamToBytes(File.OpenInput(File.DirAssets,"jhs.png"))  
    Return bytes  
End Sub  
  
  
Public Sub BytesToImage(bytes() As Byte) As Bitmap  
    Dim In As InputStream  
    In.InitializeFromBytesArray(bytes, 0, bytes.Length - 1)  
    Dim bmp As Bitmap  
    bmp.Initialize2(In)                  
    Return bmp  
End Sub  
  
  
#if Java  
  
  
import com.google.zxing.MultiFormatWriter;  
import android.graphics.Bitmap;  
import com.google.zxing.common.BitMatrix;  
import com.google.zxing.BarcodeFormat;  
import com.google.zxing.WriterException;  
  
import android.graphics.BitmapFactory;  
  
import com.google.zxing.BinaryBitmap;  
import com.google.zxing.ChecksumException;  
import com.google.zxing.FormatException;  
import com.google.zxing.LuminanceSource;  
import com.google.zxing.NotFoundException;  
import com.google.zxing.RGBLuminanceSource;  
import com.google.zxing.Reader;  
import com.google.zxing.Result;  
import com.google.zxing.common.HybridBinarizer;  
import com.google.zxing.qrcode.QRCodeReader;  
  
  
  
public static int white = 0xFFFFFFFF;  
public static int black = 0xFF000000;  
public final static int WIDTH = 500;  
  
public Bitmap encodeAsBitmap(String str) throws WriterException {  
    BitMatrix result;  
    Bitmap bitmap=null;  
    try  
    {  
        result = new MultiFormatWriter().encode(str,  
                BarcodeFormat.QR_CODE, WIDTH, WIDTH, null);  
  
        int w = result.getWidth();  
        int h = result.getHeight();  
        int[] pixels = new int[w * h];  
        for (int y = 0; y < h; y++) {  
            int offset = y * w;  
            for (int x = 0; x < w; x++) {  
                pixels[offset + x] = result.get(x, y) ? black:white;  
            }  
        }  
        bitmap = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);  
        bitmap.setPixels(pixels, 0, WIDTH, 0, 0, w, h);  
    } catch (Exception iae) {  
        iae.printStackTrace();  
        return null;  
    }  
    return bitmap;  
}  
  
public static String decodeQRImage(Bitmap bMap) {  
  
    String decoded = null;  
  
    int[] intArray = new int[bMap.getWidth() * bMap.getHeight()];  
    bMap.getPixels(intArray, 0, bMap.getWidth(), 0, 0, bMap.getWidth(),  
            bMap.getHeight());  
    LuminanceSource source = new RGBLuminanceSource(bMap.getWidth(),  
            bMap.getHeight(), intArray);  
    BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));  
  
    Reader reader = new QRCodeReader();  
    try {  
        Result result = reader.decode(bitmap);  
        decoded = result.getText();  
    } catch (NotFoundException e) {  
        e.printStackTrace();  
    } catch (ChecksumException e) {  
        e.printStackTrace();  
    } catch (FormatException e) {  
        e.printStackTrace();  
    }  
    return decoded;  
}  
  
#End If
```

  
  
Base64 String of original image that gets converted to a QR Code:  

```B4X
iVBORw0KGgoAAAANSUhEUgAAACwAAAA6AQMAAADxxSnEAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAASdAAAEnQF8NGuhAAAAB3RJTUUH5AQKCjgSMo399QAAAPBJREFUGNN9kLFuwjAQhv+QAh0qYTY24A14g0QsHfMCDFGfogOSzZNk7ApPUG99BbZEHchWuSoCV40wlztATD3Z+uTz+fz/B1wjsox+xUi8ZJ/wT0xoPwKKMOKFGSfaiwfA5UAP+KGOHQHFUb6pjaDAgPK1toNPQtgnEbALfkEdvjZFoVKc3ptym6LUzTOJyQ7LPAbmzudU+eZe2y5T69gB1qKLf4q+GfHKpexuS2rQtUswZneWYe+e3fBy8Rh4EpOGT0pKlajvSEksGMrg/hih5IGExGAMeG0xtlC/BpmDOhl8kGJtULWoYGmE2rMOxhkq4FQS8JQDxwAAAABJRU5ErkJggg==
```