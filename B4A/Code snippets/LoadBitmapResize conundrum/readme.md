### LoadBitmapResize conundrum by drgottjr
### 01/17/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/113123/)

A current project involves manipulating images shared from the camera app or pictures gallery (or, presumably, any other  
source capable of sharing images). The images are initially loaded and displayed in an imageview which is set to the  
dimensions of the device. Since the images are expected to be large, LoadBitmapResize() is used. This insures  
1) the entire image will be displayed nice and big, 2) the aspect ratio maintained, and 3) hopefully, OutOfMemoryError  
exceptions avoided.  
  
To my surprise, I discovered that LoadBitmapResize() not only resizes large images down to fill an imageview, but it also  
resizes images up. Which, in the case of small images, can make them look really bad (unless total pixelation is the goal).  
  
So one might say, for large images use a large imageview and LoadBitmapResize(), and for small images, use a small imageview  
and plain LoadBitmap(). The problem is that you don't know the dimensions of the image until you load it, by which time  
you may have experienced OutOfMemory. And even if there isn't a crash, you would still have to resize the large image after  
having loaded it, a potentially 2-step operation for every image.  
  
I suspected there was a way to determine an image's dimensions (I realize this is not the size of the image) without loading it,  
otherwise LoadBitmapResize() would essentially have to perform a LoadBitmap() and then a bitmap.resize().   
Android's BitmapFactory class does provide a way to determine the image's width and height without (apparently) creating a  
bitmap, assuming I read the documentation correctly.  
  
Based on that information, I cobbled together the attached inline Java-like snippet. Anyone who would care to turn it into  
real Java is welcome to. I would imagine a purely B4A version is doable; when I see such examples in the forum, I can  
picture myself writing one, but it was easier for me to do it the way I did it.   
  
In the event this is simply a solution for which there was no problem, the circular file is always an option. No harm, no foul.  
The name of the function peekImage() is a nod to the devilish twins of yore peek() and poke(), seen in the attached image.  
  

```B4X
From B4A:  
Dim in As JavaObject = Activity.GetStartingIntent  
Dim uri as string = in.RunMethod("getParcelableExtra", Array("android.intent.extra.STREAM"))  
             
Dim nativeme As JavaObject  
nativeme.InitializeContext  
         
Dim intarray(2) As Int = nativeme.RunMethod("peekImage",  Array As String(uri))  
' make your decisions as to how to load based on width (intarray(0)) and height (intarray(1)) of image  
' ———————————————————————————————————–  
  
#If JAVA  
  
import anywheresoftware.b4a.*;  
import android.graphics.Bitmap;  
import android.graphics.BitmapFactory;  
import android.content.ContentResolver;  
import java.io.File;  
import java.io.InputStream;  
import android.net.Uri;  
  
public final int[] peekImage(String uri) {  
    int[] ret = new int[2];  
         
    BitmapFactory.Options options = new BitmapFactory.Options();  
    options.inJustDecodeBounds = true;  
  
    try {  
        Uri thisuri = Uri.parse(uri);  
        InputStream is = getContentResolver().openInputStream(thisuri);  
        Bitmap bmp = BitmapFactory.decodeStream(is, null, options);         
  
        ret[0] = options.outWidth;  
        ret[1] = options.outHeight;  
             
        BA.Log(options.outWidth + " x " + options.outHeight);  
    }  
    catch(Exception e) {  
           BA.Log("You've failed again: " + e.toString());  
        ret[0] = -1;  
        ret[1] = -1;  
    }  
             
    return(ret);  
}  
#End If
```