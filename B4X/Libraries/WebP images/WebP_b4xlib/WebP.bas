B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.75
@EndOfDesignText@
Sub Class_Globals
	#if B4J
	Private Webp4j As JavaObject
	#end if
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	#if B4J
	Private Webp4j As JavaObject
	Webp4j.InitializeStatic("com.zakgof.webp4j.Webp4j")
	#end if
End Sub

Public Sub LoadWebP (Data() As Byte) As B4XBitmap
#if B4i
	Dim no As NativeObject = Me
	Dim bmp As B4XBitmap = no.RunMethod("convertWebPToUIimage:",Array(no.ArrayToNSData(Data)))
	Return bmp
#Else If B4A
	Dim in As InputStream
	in.InitializeFromBytesArray(Data, 0, Data.Length)
	Dim bmp As Bitmap
	bmp.Initialize2(in)
	in.Close
	Return bmp
#Else If B4J
	Dim jo As JavaObject
	Return jo.InitializeStatic("javafx.embed.swing.SwingFXUtils").RunMethod("toFXImage", Array(Webp4j.RunMethod("decode", Array(Data)), Null))
#End If

End Sub

#if objc
#import <WebP/decode.h>
-(UIImage *)convertWebPToUIimage:  (NSData *) myData{
    int width = 0;
    int height = 0;
    WebPGetInfo([myData bytes], [myData length], &width, &height);
    uint8_t *data = WebPDecodeRGBA([myData bytes], [myData length], &width, &height);
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, data, width*height*4, free_image_data);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef = CGImageCreate(width, height, 8, 32, 4*width, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    return [UIImage imageWithCGImage:imageRef];
}

static void free_image_data(void *info, const void *data, size_t size)
{
    if(info != NULL)
    {WebPFreeDecBuffer(&(((WebPDecoderConfig *)info)->output));}
    else
    {free((void *)data);}
}

#End If