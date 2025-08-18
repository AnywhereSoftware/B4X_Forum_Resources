### Detect QR code from an image by yiankos1
### 08/20/2021
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/133587/)

Hello team,  
  
Here is the iOS version of QR detection:  

```B4X
Dim no As NativeObject = Me  
Dim res As List = no.RunMethod("detectQR:", Array(LoadBitmap(xui.DefaultFolder, "image.jpeg")))  
             
For Each feature As NativeObject In res  
    Log(feature.GetField("messageString").AsString)  
Next  
  
#if OBJC  
@import CoreImage;  
- (NSArray*) detectQR: (UIImage*)img {  
int exifOrientation;  
switch (img.imageOrientation) {  
  case UIImageOrientationUp:  
  exifOrientation = 1;  
  break;  
  case UIImageOrientationDown:  
  exifOrientation = 3;  
  break;  
  case UIImageOrientationLeft:  
  exifOrientation = 8;  
  break;  
  case UIImageOrientationRight:  
  exifOrientation = 6;  
  break;  
  case UIImageOrientationUpMirrored:  
  exifOrientation = 2;  
  break;  
  case UIImageOrientationDownMirrored:  
  exifOrientation = 4;  
  break;  
  case UIImageOrientationLeftMirrored:  
  exifOrientation = 5;  
  break;  
  case UIImageOrientationRightMirrored:  
  exifOrientation = 7;  
  break;  
  default:  
  break;  
}  
  
NSDictionary *detectorOptions = @{ CIDetectorAccuracy : CIDetectorAccuracyHigh };  
CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeQRCode  context:nil options:detectorOptions];  
  
NSArray *features = [faceDetector featuresInImage:[CIImage imageWithCGImage:img.CGImage]  
  options:@{CIDetectorImageOrientation:[NSNumber numberWithInt:exifOrientation]}];  
  
  return features;  
  
}  
#end if
```

  
  
Thank you Erel for your [help](https://www.b4x.com/android/forum/threads/how-to-use-cidetector.70576/post-448130).