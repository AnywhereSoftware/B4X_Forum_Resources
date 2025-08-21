B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6
@EndOfDesignText@
#IgnoreWarnings : 9

Sub Class_Globals

    Private booleanIsAnimatedDismiss                                            As Boolean
    Private mCallBack                                                           As Object
    Private mEventName                                                          As String
    Private mPage                                                               As Page
    Private nsDictionaryGPS                                                     As Object
    Public  nsDictionaryMetadata                                                As Object
    Public  UIImage                                                             As Object

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize  (Callback As Object, EventName As String, Page As Page)

    mEventName = EventName
    mCallBack  = Callback
    mPage      = Page

    ReleaseMemory

End Sub

Public Sub ReleaseMemory

    UIImage              = Null
    nsDictionaryGPS      = Null
    nsDictionaryMetadata = Null

End Sub

Public Sub SetLocation (booleanIsLocationValid As Boolean, locationInstance As Location, doubleMagneticHeading As Double, doubleTrueHeading As Double)

    Dim mapGPS                                                                  As Map

    nsDictionaryGPS = Null
    If booleanIsLocationValid = False Then Return

    mapGPS.Initialize

    If locationInstance.VerticalAccuracy >= 0 Then
        If locationInstance.Altitude >= 0 Then
            mapGPS.Put ("Altitude", locationInstance.Altitude)
            mapGPS.Put ("AltitudeRef", 0)
        Else
            mapGPS.Put ("Altitude", - locationInstance.Altitude)
            mapGPS.Put ("AltitudeRef", 1)
        End If
    End If

    If locationInstance.Time > 0 Then
        DateTime.DateFormat = "yyyy:MM:dd"
        mapGPS.Put ("DateStamp", DateTime.Date (locationInstance.Time - DateTime.TimeZoneOffset * DateTime.TicksPerHour)) ' UTC
    End If

    If doubleTrueHeading >= 0 Then ' IOS makes DestBearing = ImgDirection
        mapGPS.Put ("DestBearing",    doubleTrueHeading)
        mapGPS.Put ("DestBearingRef", "T")
    Else If doubleMagneticHeading >= 0 Then
        mapGPS.Put ("DestBearing",    doubleMagneticHeading)
        mapGPS.Put ("DestBearingRef", "M")
    End If

    If locationInstance.Accuracy >= 0 Then mapGPS.Put ("HPositionError", locationInstance.Accuracy)

    If locationInstance.Latitude >= 0 Then
        mapGPS.Put ("Latitude",     locationInstance.Latitude)
        mapGPS.Put ("LatitudeRef", "N")
    Else
        mapGPS.Put ("Latitude",     - locationInstance.Latitude)
        mapGPS.Put ("LatitudeRef", "S")
    End If

    If locationInstance.Accuracy >= 0 Then
        If locationInstance.Longitude >= 0 Then
            mapGPS.Put ("Longitude",    locationInstance.Longitude)
            mapGPS.Put ("LongitudeRef", "E")
        Else
            mapGPS.Put ("Longitude",    - locationInstance.Longitude)
            mapGPS.Put ("LongitudeRef", "W")
        End If
    End If

    If locationInstance.Speed >= 0 Then
        mapGPS.Put ("Speed",     locationInstance.Speed * 3.6) ' m/sec -> km/h
        mapGPS.Put ("SpeedRef", "K")
    End If

    If locationInstance.Time > 0 Then
        mapGPS.Put ("TimeStamp", DateTime.Time (locationInstance.Time - DateTime.TimeZoneOffset * DateTime.TicksPerHour))
    End If

    If doubleTrueHeading >= 0 Then
        mapGPS.Put ("ImgDirection",    doubleTrueHeading)
        mapGPS.Put ("ImgDirectionRef", "T")
    Else If doubleMagneticHeading >= 0 Then
        mapGPS.Put ("ImgDirection",    doubleMagneticHeading)
        mapGPS.Put ("ImgDirectionRef", "M")
    End If

    nsDictionaryGPS = mapGPS.ToDictionary

End Sub

Public Sub LoadImage (Folder As String, FileName As String)

    Dim nativeObjectMe                                                          As NativeObject

    nativeObjectMe = Me
    nativeObjectMe.RunMethod ("getImageFromFile:",  Array (Folder & "/" & FileName))

End Sub

Public Sub getWidth As Int

    Dim nativeObjectMe                                                          As NativeObject

    nativeObjectMe = Me
    Return nativeObjectMe.RunMethod ("getImageWidth", Null).AsNumber

End Sub

Public Sub getHeight As Int

    Dim nativeObjectMe                                                          As NativeObject

    nativeObjectMe = Me
    Return nativeObjectMe.RunMethod ("getImageHeight", Null).AsNumber

End Sub

Public Sub Resize (intNewWidth As Int, intNewHeight As Int)

    Dim nativeObjectMe                                                          As NativeObject

    nativeObjectMe = Me
    nativeObjectMe.RunMethod ("resizeImage::",  Array (intNewWidth, intNewHeight))

End Sub

Public Sub SaveImage (Folder As String, FileName As String, CompressQuality As Float)

    Dim nativeObjectMe                                                          As NativeObject

    nativeObjectMe = Me
    nativeObjectMe.RunMethod ("saveImageToFile::",  Array (Folder & "/" & FileName, 0.01 * CompressQuality))

End Sub

Public Sub takePhoto (isFrontCamera As Boolean, isAnimatedAppearence As Boolean, isAnimatedDismiss As Boolean, isAllowsEditing As Boolean)

    Dim nativeObjectMe                                                          As NativeObject

    booleanIsAnimatedDismiss = isAnimatedDismiss
    nativeObjectMe = Me
    nativeObjectMe.RunMethod ("takePhoto::::", Array (mPage, isFrontCamera, isAnimatedAppearence, isAllowsEditing))

End Sub

Private Sub takePhoto_Complete (intResult As Int)

    Dim nativeObjectInstance                                                    As NativeObject

    If intResult = -2 Then
        CallSub (mCallBack, mEventName & "_getLocation")
    Else
        nativeObjectInstance = mPage
        nativeObjectInstance.RunMethod ("dismissViewControllerAnimated:completion:", Array (booleanIsAnimatedDismiss, Null))
        CallSubDelayed2 (mCallBack, mEventName & "_Complete", intResult)
    End If

End Sub

#If OBJC
#import <UIKit/UIKit.h>

- (void) getImageFromFile : (NSString *) path
    {
    self->__uiimage = nil;
    self->__nsdictionarymetadata = nil;
    NSData * imageData = [NSData dataWithContentsOfFile: path];
    CGImageSourceRef source = CGImageSourceCreateWithData ((__bridge CFDataRef) imageData, NULL);
    if (source != nil)
        {
        self->__nsdictionarymetadata = CFBridgingRelease (CGImageSourceCopyPropertiesAtIndex (source, 0, NULL));
        self->__uiimage = [UIImage imageWithData:imageData];
        CFRelease (source);
        }
    }

- (int) getImageWidth  { return ((UIImage *) self->__uiimage).size.width; }

- (int) getImageHeight { return ((UIImage *) self->__uiimage).size.height; }

- (void) resizeImage : (int) newWidth : (int) newHeight
    {
    CGSize size = CGSizeMake (newWidth, newHeight);
    UIGraphicsBeginImageContext (size);
    [(UIImage *) self->__uiimage drawInRect: CGRectMake (0, 0, size.width, size.height)];
    self->__uiimage = UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext ();

    NSMutableDictionary * dictionaryRoot = [[NSMutableDictionary alloc] init];
    if (self->__nsdictionarymetadata) { [dictionaryRoot addEntriesFromDictionary: self->__nsdictionarymetadata]; };
    [self setMetaDataSizeAndOrientation: self->__uiimage dictionary : dictionaryRoot];
    self->__nsdictionarymetadata = dictionaryRoot;
    }

- (void) saveImageToFile : (NSString *) path : (CGFloat) compressionQuality
    {
    NSData * imageData = UIImageJPEGRepresentation (self->__uiimage, compressionQuality);
    CGImageSourceRef source = CGImageSourceCreateWithData ((__bridge CFDataRef) imageData, NULL);
    CFStringRef UTI = CGImageSourceGetType (source);
    NSMutableData * dest_data = [NSMutableData data];
    CGImageDestinationRef destination = CGImageDestinationCreateWithData ((__bridge CFMutableDataRef) dest_data, UTI, 1, NULL);

    NSMutableDictionary * dictionaryRoot = [[NSMutableDictionary alloc] init];
    if (self->__nsdictionarymetadata) { [dictionaryRoot addEntriesFromDictionary: self->__nsdictionarymetadata]; };
    [self setMetaDataSizeAndOrientation: self->__uiimage dictionary : dictionaryRoot];
    self->__nsdictionarymetadata = dictionaryRoot;
    CGImageDestinationAddImageFromSource (destination, source, 0, (__bridge CFDictionaryRef) self->__nsdictionarymetadata);

    BOOL success = CGImageDestinationFinalize (destination);
    CFRelease (destination);
    CFRelease (source);
    [dest_data writeToFile: path atomically: YES];
    }

- (void) photoIsReady { [self.bi raiseUIEvent: nil event: @"takephoto_complete:" params: @[@((int) -2)]]; }

- (void) takePhoto: (UIViewController *) page : (BOOL) booleanIsFrontCamera : (BOOL) booleanIsAnimated : (BOOL) booleanIsAllowsEditing
    {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if (! [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) { [self.bi raiseUIEvent: nil event: @"takephoto_complete:" params: @[@((int) -1)]]; return; }
    picker.sourceType             = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice           = UIImagePickerControllerCameraDeviceRear;
    if (booleanIsFrontCamera) { if ([UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceFront]) { picker.cameraDevice = UIImagePickerControllerCameraDeviceFront; }; };
    picker.showsCameraControls    = YES;
    picker.allowsEditing          = booleanIsAllowsEditing;
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (photoIsReady) name:@"_UIImagePickerControllerUserDidCaptureItem" object:nil ];
    [ page presentViewController: picker animated: booleanIsAnimated completion: nil ];
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary <UIImagePickerControllerInfoKey, id> *) info;
    {
    [[NSNotificationCenter defaultCenter] removeObserver: self];

    NSDictionary * dictionaryOriginal = [info objectForKey: UIImagePickerControllerMediaMetadata];
    UIImage * image                   = [info objectForKey: UIImagePickerControllerEditedImage];
    if (! image) image                = [info objectForKey: UIImagePickerControllerOriginalImage];

    CGSize size = image.size;
    UIGraphicsBeginImageContext (size);
    [image drawInRect:CGRectMake (0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext ();
    self->__uiimage = image;

    NSMutableDictionary * dictionaryRoot = [[NSMutableDictionary alloc] init];
    if (dictionaryOriginal) { [dictionaryRoot addEntriesFromDictionary: dictionaryOriginal]; };
    if (self->__nsdictionarygps) { [dictionaryRoot setObject: self->__nsdictionarygps forKey: @"{GPS}"]; };
    [self setMetaDataSizeAndOrientation: image dictionary : dictionaryRoot];
    self->__nsdictionarymetadata = dictionaryRoot;

    [self.bi raiseUIEvent: nil event: @"takephoto_complete:" params: @[@((int) 1)]];
    }

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
    {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    self->__uiimage = nil;
    self->__nsdictionarymetadata = nil;
    [self.bi raiseUIEvent: nil event: @"takephoto_complete:" params: @[@((int) 0)]];
    }

- (void) setMetaDataSizeAndOrientation: (UIImage *) image  dictionary : (NSMutableDictionary *) dictionaryRoot
    {
    [dictionaryRoot setObject: @(1)                 forKey: @"Orientation"];
    [dictionaryRoot setObject: @(image.size.height) forKey: @"PixelHeight"];
    [dictionaryRoot setObject: @(image.size.width)  forKey: @"PixelWidth"];

    NSMutableDictionary * dictionaryExif = [[NSMutableDictionary alloc] init];
    [dictionaryExif addEntriesFromDictionary: [dictionaryRoot objectForKey: @"{Exif}"]];
    [dictionaryExif setObject: @(image.size.width)  forKey: @"PixelXDimension"];
    [dictionaryExif setObject: @(image.size.height) forKey: @"PixelYDimension"];
    [dictionaryRoot setObject: dictionaryExif forKey: @"{Exif}"];

    NSMutableDictionary * dictionaryTIFF = [[NSMutableDictionary alloc] init];
    [dictionaryTIFF addEntriesFromDictionary: [dictionaryRoot objectForKey: @"{TIFF}"]];
    [dictionaryTIFF setObject: @(1)           forKey: @"Orientation"];
    [dictionaryRoot setObject: dictionaryTIFF forKey: @"{TIFF}"];
    }

#End If

#End Region
