B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.9
@EndOfDesignText@
Sub Class_Globals
	#if B4A
	Private jme As JavaObject
	#Else If B4i
	Dim no As NativeObject
	#end if
	Public MaxFileSize As Long = 3 * 1024 * 1024
	Private xui As XUI 'ignore
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	#if B4A
	jme = Me
	#Else If B4i
	no = Me
	#end if
End Sub

Public Sub LoadFromHttpJob (Job As HttpJob, MaxWidth As Int, MaxHeight As Int) As ResumableSub
	Dim res As B4XBitmap
	If Job.Success = False Then Return res
	If Job.Response.ContentLength >= MaxFileSize Then
		Log($"File larger than MaxFileSize $1.0{Job.Response.ContentLength}"$)
		Return res
	End If
	#if B4J
	res = Job.GetBitmap
	If res.Width > MaxWidth Or res.Height > MaxHeight Then
		res = res.Resize(MaxWidth, MaxHeight, True)
	End If
	Return res
	#else
	#if B4A
	Dim sf As Object = jme.RunMethod("loadBitmap", Array(Job.GetInputStream, Job.GetInputStream, MaxWidth, MaxHeight))
	Wait For (sf) Bitmap_Loaded (Success As Boolean, Bmp As Object)
	#else if B4i
	Dim sf As Object = no.RunMethod("loadBitmap:", Array(Job.GetInputStream)) 'MaxWidth and MaxHeight not used.
	Wait For (sf) Bitmap_Loaded (Success As Boolean, Bmp As Bitmap)
	#end if
	If Success Then
		res = Bmp
	End If
	Return res
	#End If
End Sub

Public Sub LoadFromFile(Dir As String, Filename As String, MaxWidth As Int, MaxHeight As Int) As ResumableSub
	Dim res As B4XBitmap
	If Dir <> File.DirAssets Then
		If File.Size(Dir, Filename) > MaxFileSize Then
			Log($"File larger than MaxFileSize $1.0{File.Size(Dir, Filename)}"$)
			Return res
		End If
	End If
	#if B4J
	res = xui.LoadBitmap(Dir, Filename)
	If res.Width > MaxWidth Or res.Height > MaxHeight Then
		res = res.Resize(MaxWidth, MaxHeight, True)
	End If
	Return res
	#else
	#if B4A
	Dim sf As Object = jme.RunMethod("loadBitmap", Array(File.OpenInput(Dir, Filename), File.OpenInput(Dir, Filename), MaxWidth, MaxHeight))
	Wait For (sf) Bitmap_Loaded (Success As Boolean, Bmp As Object)
	#else if B4i
	Dim sf As Object = no.RunMethod("loadBitmap:", Array(File.OpenInput(Dir, Filename))) 'MaxWidth and MaxHeight not used.
	Wait For (sf) Bitmap_Loaded (Success As Boolean, Bmp As Bitmap)
	#end if
	If Success Then
		res = Bmp
	End If
	Return res
	#End If
End Sub


#if B4A
#if Java
import android.graphics.Bitmap;
import android.graphics.BitmapFactory.*;
import android.graphics.BitmapFactory;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.concurrent.Callable;
public Object loadBitmap(final InputStream in1, final InputStream in2, final int MaxWidth, final int MaxHeight) {
	Object sender = new Object();
	BA.runAsync(getBA(), sender, "bitmap_loaded", new Object[] {false, null}, 
		new Callable<Object[]>() {
			public Object[] call() throws Exception {
				try {
				Options o = new Options();
				o.inJustDecodeBounds = true;
				BitmapFactory.decodeStream(in1, null, o);
				float r1 = Math.max(o.outWidth / MaxWidth, o.outHeight / MaxHeight);
				Options o2 = null;
				if (r1 > 1f) {
					o2 = new Options();
					o2.inSampleSize = (int) r1;
				}
				Bitmap bmp = BitmapFactory.decodeStream(in2, null, o2);
				bmp.setDensity(160);
				return new Object[] {true, bmp};
				} catch (Exception e) {
					BA.Log("" + e);
					throw e;
				} finally {
					in1.close();
					in2.close();
				}
			}
		}
	);
	return sender;
}
#End If
#else if b4i
#if OBJC
- (NSObject*) loadBitmap:(NSInputStream*)in{
 NSObject *senderFilter = [NSObject new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	 	B4IInputStream* bin = [B4IInputStream new];
		bin.object = in;
        @try {
			B4IBitmap* bmp = [B4IBitmap new];
			[bmp Initialize2:bin];
            [self.bi raiseEventFromDifferentThread:senderFilter event:@"bitmap_loaded::" params:@[@(true), bmp]];
        }  @catch (NSException *e) {
            [B4I SetException:e];
			
            [self.bi raiseEventFromDifferentThread:senderFilter event:@"bitmap_loaded::" params:@[@(false), [NSNull null]]];
        }
		[bin Close];
    });
    return senderFilter;
}
#End If
#End If



