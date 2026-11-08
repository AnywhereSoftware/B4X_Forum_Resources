B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.51
@EndOfDesignText@
Sub Class_Globals
	Type SelfieSegmentationResult (Success As Boolean, ForegroundBitmap As B4XBitmap)
	#if B4I
	Private recognizer As NativeObject
	#else if B4A
	Private recognizer As JavaObject
	#end if
End Sub

Public Sub Initialize
	#if B4I
	Dim options As NativeObject
	options = options.Initialize("MLKSelfieSegmenterOptions").RunMethod("new", Null)
	options.SetField("segmenterMode", 0) '0 - MLKSegmenterModeSingleImage, 1 - MLKSegmenterModeStream
	Dim recognizer As NativeObject
	recognizer = recognizer.Initialize("MLKSegmenter").RunMethod("segmenterWithOptions:", Array(options))
	#else if B4A
	Dim options As JavaObject
	options = options.InitializeNewInstance("com.google.mlkit.vision.segmentation.selfie.SelfieSegmenterOptions$Builder", Null) _
		.RunMethodJO("setDetectorMode", Array(2)).RunMethodJO("build", Null)
	recognizer = recognizer.InitializeStatic("com.google.mlkit.vision.segmentation.Segmentation") _
		.RunMethod("getClient", Array(options))
	#end if
End Sub


Public Sub Process (bmp As B4XBitmap) As ResumableSub
	Dim res As SelfieSegmentationResult
	res.Initialize
	#if B4I
	recognizer.RunMethod("processImage:completion:", Array(ImageToMLImage(bmp), Me.as(NativeObject).RunMethod("createBlock", Null)))
	Wait For Process_Result(Success As Boolean, MaskBitmap As Object)
	res.Success = Success
	If Success Then
		res.ForegroundBitmap = MaskBitmap
	End If
	#else if B4A
	Dim task As JavaObject = recognizer.RunMethod("process", Array(ImageToMLImage(bmp)))
	Do While task.RunMethod("isComplete", Null).As(Boolean) = False
		Sleep(50)
	Loop
	If task.RunMethod("isSuccessful", Null) Then
		res.Success = True
		Dim SegmentationMask As JavaObject = task.RunMethod("getResult", Null)
		res.ForegroundBitmap = Me.As(JavaObject).RunMethod("convertMaskToImage", Array(SegmentationMask))
	Else
		Log(task.RunMethod("getException", Null))
	End If
	#End If
	Return res
End Sub

Private Sub ImageToMLImage(bmp As B4XBitmap) As Object
	#if B4I
	Dim image As NativeObject
	image = image.Initialize("MLKVisionImage").RunMethod("alloc", Null).RunMethod("initWithImage:", Array(bmp))
	#else if B4A
	Dim image As JavaObject
	image = image.InitializeStatic("com.google.mlkit.vision.common.InputImage").RunMethod("fromBitmap", Array(bmp, 0))
	#end if
	Return image
End Sub

#if OBJC
#import "MLKitSegmentationCommon/MLKitSegmentationCommon.h"
-(void (^)(id, id)) createBlock {
	void (^block)(id result, id error) = ^void (MLKSegmentationMask* mask, id error){
		if (error != nil || mask == nil) {
			[B4I shared].lastError = error;
			[self.bi raiseUIEvent:nil event:@"process_result::" params:@[@(false), [NSNull null]]];
		} else {
		CVPixelBufferRef pixelBuffer = mask.buffer;
		CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
		CIContext *temporaryContext = [CIContext contextWithOptions:nil];
		CGImageRef videoImage = [temporaryContext
		                   createCGImage:ciImage
		                   fromRect:CGRectMake(0, 0, 
		                          CVPixelBufferGetWidth(pixelBuffer),
		                          CVPixelBufferGetHeight(pixelBuffer))];
		UIImage *uiImage = [UIImage imageWithCGImage:videoImage];
		CGImageRelease(videoImage);
			[self.bi raiseUIEvent:nil event:@"process_result::" params:@[@(true), uiImage]];
		}
	};
	return block;
}
#End If

#if JAVA
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import androidx.annotation.ColorInt;
import com.google.mlkit.vision.segmentation.SegmentationMask;
import java.nio.ByteBuffer;
public Object convertMaskToImage(SegmentationMask segmentationMask) {
 	ByteBuffer mask = segmentationMask.getBuffer();
    int maskWidth = segmentationMask.getWidth();
    int maskHeight = segmentationMask.getHeight();
	return Bitmap.createBitmap(
            convertBufferToInts(mask, maskWidth, maskHeight), maskWidth, maskHeight, Config.ARGB_8888);
}
private int[] convertBufferToInts(ByteBuffer byteBuffer, int maskWidth, int maskHeight) {
    int[] colors = new int[maskWidth * maskHeight];
    for (int i = 0; i < maskWidth * maskHeight; i++) {
      float backgroundLikelihood = byteBuffer.getFloat();
	  int c = Math.min(255, Math.max(0, (int) (backgroundLikelihood * 255 + 0.5)));
	  colors[i] = Color.argb(255, c, c, c);
      
    }
    return colors;
  }

#End If