B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.5
@EndOfDesignText@
'Custom View class
#IgnoreWarnings: 9, 12

#Event: WillBeginZooming (ScrollView As Object, WithView As Object)
#Event: DidZoom          (ScrollView As Object)
#Event: DidEndZooming    (ScrollView As Object, WithView As Object)
#Event: ImageClicked     ()

#DesignerProperty: Key: HorizontalAlignment,  DisplayName: Horizontal Alignment,  FieldType: String,  DefaultValue: CENTER, List: LEFT|CENTER|RIGHT
#DesignerProperty: Key: MaximumZoomScale,     DisplayName: Maximum Zoom Scale,    FieldType: Float,   DefaultValue:  5.0,   MinRange: 0.2, MaxRange: 5.0,  Description: A float property.
#DesignerProperty: Key: MinimumZoomScale,     DisplayName: Minimum Zoom Scale,    FieldType: Float,   DefaultValue:  0.2,   MinRange: 0.2, MaxRange: 5.0,  Description: A float property.
#DesignerProperty: Key: VerticalAlignment,    DisplayName: Vertical Alignment,    FieldType: String,  DefaultValue: CENTER, List: TOP|CENTER|BOTTOM
#DesignerProperty: Key: ZoomEnabled,          DisplayName: Zoom Enabled,          FieldType: Boolean, DefaultValue: True,                                  Description: A boolean property.

Sub Class_Globals

    Private booleanIsVisible                                                    As Boolean
    Private booleanIsZoomEnabled                                                As Boolean
    Private byteHorizontalAlignment                                             As Byte
    Private byteVerticalAlignment                                               As Byte
    Private floatMaximumZoomScale                                               As Float
    Private floatMinimumZoomScale                                               As Float
    Private floatZoomScale                                                      As Float
    Private intBackgroundColor                                                  As Int
    Private nativeObjectMe                                                      As NativeObject = Me
    Private objectCallBack                                                      As Object
    Private stringEventName                                                     As String
    Private weakRefBase                                                         As WeakRef
    Private weakRefContentView                                                  As WeakRef
    Private weakRefImage                                                        As WeakRef
    Private weakRefTag                                                          As WeakRef

End Sub

Public Sub Initialize (Callback As Object, EventName As String)

    stringEventName          = EventName
    objectCallBack           = Callback
    weakRefBase.Value        = Null
    weakRefContentView.Value = Null
    weakRefImage.Value       = Null
    weakRefTag.Value         = Null

    setDefaults

End Sub

Private Sub setDefaults

    booleanIsVisible        = True
    booleanIsZoomEnabled    = True
    byteHorizontalAlignment = 0 ' CENTER
    byteVerticalAlignment   = 0 ' CENTER
    floatMaximumZoomScale   = 5
    floatMinimumZoomScale   = 0.2
    floatZoomScale          = 1.0
    intBackgroundColor      = Colors.Transparent

End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)

    Dim intAlpha                                                                As Int
    Dim intRGB                                                                  As Int

    Base.RemoveAllViews
    weakRefBase.Value = Base

    floatMaximumZoomScale = Props.Get ("MaximumZoomScale")
    floatMinimumZoomScale = Props.Get ("MinimumZoomScale")
    booleanIsZoomEnabled  = Props.Get ("ZoomEnabled")
    Select Case Props.Get ("HorizontalAlignment")
        Case "LEFT"
            byteHorizontalAlignment = 1
        Case "RIGHT"
            byteHorizontalAlignment = 2
        Case Else ' CENTER
            byteHorizontalAlignment = 0
    End Select
    Select Case Props.Get ("VerticalAlignment")
        Case "TOP"
            byteVerticalAlignment = 1
        Case "BOTTOM"
            byteVerticalAlignment = 2
        Case Else ' CENTER
            byteVerticalAlignment = 0
    End Select

    booleanIsVisible     = Base.Visible
    intAlpha = Base.Alpha * 255
    intRGB = Base.Color
    intBackgroundColor   = Bit.ShiftLeft (intAlpha, 24) + Bit.And (intRGB, 0x00FFFFFF)

End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
    nativeObjectMe.RunMethod ("redrawScrollView", Null)
End Sub

Public Sub getBase As Panel
    Return weakRefBase.Value
End Sub
Public Sub setBase (Base As Panel)
    Base.RemoveAllViews
    weakRefBase.Value = Base
End Sub

Public Sub getContentView As Bitmap
    Return weakRefContentView.Value
End Sub
Public Sub setContentView (View As View)
    weakRefContentView.Value = View
    weakRefImage.Value = Null
    nativeObjectMe.RunMethod ("redrawScrollView", Null)
End Sub

Public Sub getContentImage As Bitmap
    Return weakRefImage.Value
End Sub
Public Sub setContentImage (Bitmap As Bitmap)
    weakRefImage.Value = Bitmap
    weakRefContentView.Value = Null
    nativeObjectMe.RunMethod ("redrawScrollView", Null)
End Sub

Public Sub getMinimumZoomScale As Float
    Return floatMinimumZoomScale
End Sub
Public Sub setMinimumZoomScale (MinimumZoomScale As Float)
    floatMinimumZoomScale = MinimumZoomScale
    nativeObjectMe.RunMethod ("redrawScrollView", Null)
End Sub

Public Sub getMaximumZoomScale As Float
    Return floatMinimumZoomScale
End Sub
Public Sub setMaximumZoomScale (MaximumZoomScale As Float)
    floatMaximumZoomScale = MaximumZoomScale
    nativeObjectMe.RunMethod ("redrawScrollView", Null)
End Sub

Public Sub getZoomScale As Float
    Return floatZoomScale
End Sub
Public Sub setZoomScale (ZoomScale As Float)
    floatZoomScale = ZoomScale
    nativeObjectMe.RunMethod ("redrawScrollView", Null)
End Sub

Public Sub getIsZoomEnabled As Boolean
    Return booleanIsZoomEnabled
End Sub
Public Sub setIsZoomEnabled (IsZoomEnabled As Boolean)
    booleanIsZoomEnabled = IsZoomEnabled
    nativeObjectMe.RunMethod ("redrawScrollView", Null)
End Sub

Public Sub getIsVisible As Boolean
    Return booleanIsVisible
End Sub
Public Sub setIsVisible (IsVisible As Boolean)
    booleanIsVisible = IsVisible
    nativeObjectMe.RunMethod ("redrawScrollView", Null)
End Sub

Public Sub getBackgroundColor As Int
    Return intBackgroundColor
End Sub
Public Sub setBackgroundColor (BackgroundColor As Int)
    intBackgroundColor = BackgroundColor
    nativeObjectMe.RunMethod ("redrawScrollView", Null)
End Sub

Public Sub getHorizontalAlgnment As String
    Select Case byteHorizontalAlignment
        Case 1
            Return "LEFT"
        Case 2
            Return "RIGHT"
        Case Else
            Return "CENTER"
    End Select
End Sub
Public Sub setHorizontalAlgnment (Value As String)
    Select Case Value
        Case "LEFT"
            byteHorizontalAlignment = 1
        Case "RIGHT"
            byteHorizontalAlignment = 2
        Case Else ' CENTER
            byteHorizontalAlignment = 0
    End Select
    nativeObjectMe.RunMethod ("redrawScrollView", Null)
End Sub

Public Sub getVerticalAlgnment As String
    Select Case byteVerticalAlignment
        Case 1
            Return "TOP"
        Case 2
            Return "BOTTOM"
        Case Else
            Return "CENTER"
    End Select
End Sub
Public Sub setVerticalAlgnment (Value As String)
    Select Case Value
        Case "TOP"
            byteVerticalAlignment = 1
        Case "BOTTOM"
            byteVerticalAlignment = 2
        Case Else ' CENTER
            byteVerticalAlignment = 0
    End Select
    nativeObjectMe.RunMethod ("redrawScrollView", Null)
End Sub

Public Sub getTag () As Object
    Return weakRefTag.Value
End Sub
Public Sub setTag (Tag As Object)
    weakRefTag.Value = Tag
End Sub

Private Sub WillBeginZooming (ScrollView As Object, WithView As Object)
    If SubExists (objectCallBack, stringEventName & "_WillBeginZooming", 2) Then CallSub3 (objectCallBack, stringEventName & "_WillBeginZooming", ScrollView, WithView)
End Sub

Private Sub DidZoom (ScrollView As Object)
    If SubExists (objectCallBack, stringEventName & "_DidZoom", 1) Then CallSub2 (objectCallBack, stringEventName & "_DidZoom", ScrollView)
End Sub

Private Sub DidEndZooming (ScrollView As Object, WithView As Object)
    If SubExists (objectCallBack, stringEventName & "_DidEndZooming", 2) Then CallSub3 (objectCallBack, stringEventName & "_DidEndZooming", ScrollView, WithView)
End Sub

Private Sub ImageClicked
	If SubExists (objectCallBack, stringEventName & "_ImageClicked", 0) Then CallSub (objectCallBack, stringEventName & "_ImageClicked")
End Sub

#If OBJC

#define UIColorFromRGBA(rgbaValue) \
[UIColor colorWithRed: ((float) ((rgbaValue & 0x00FF0000) >> 16)) / 255.0 \
         green:        ((float) ((rgbaValue & 0x0000FF00) >>  8)) / 255.0 \
         blue:         ((float) ((rgbaValue & 0x000000FF) >>  0)) / 255.0 \
         alpha:        ((float) ((rgbaValue & 0xFF000000) >> 24)) / 255.0]

- (void) redrawScrollView
    {
    UIView * parentView  = (UIView *)  [__weakrefbase Value];
    UIView * contentView = (UIView *)  [__weakrefcontentview Value];
    UIImage * image      = (UIImage *) [__weakrefimage Value];
    if (parentView == nil) { return; };
    if ((image == nil) && (contentView == nil)) { return; };

    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake (0, 0, parentView.frame.size.width, parentView.frame.size.height)];
    scrollView.delegate                       = (id<UIScrollViewDelegate>) self;
    scrollView.bounces                        = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView setScrollEnabled:               YES];
    [scrollView setClipsToBounds:               YES];
    [scrollView setBackgroundColor:             UIColorFromRGBA (__intbackgroundcolor)];
    if (__booleaniszoomenabled)
        {
        [scrollView setMaximumZoomScale:            __floatmaximumzoomscale];
        [scrollView setMinimumZoomScale:            __floatminimumzoomscale];
        scrollView.zoomScale =                      __floatzoomscale;
        }
    else
        {
        [scrollView setMaximumZoomScale:            1.0];
        [scrollView setMinimumZoomScale:            1.0];
        scrollView.zoomScale =                      1.0;
        };
    [parentView addSubview: scrollView];

    if (image != nil)
        {
        UIImageView * imageView = [[UIImageView alloc] initWithImage: image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setUserInteractionEnabled: YES];
        [imageView setBackgroundColor: [UIColor clearColor]];
        [imageView setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [imageView setFrame: CGRectMake (0, 0, parentView.frame.size.width, parentView.frame.size.height)];
		UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector (imageViewClick)];
        singleTap.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer: singleTap];
        [scrollView addSubview: imageView];
        }

    if (contentView != nil)
        {
        scrollView.contentSize = contentView.frame.size;
        [contentView removeFromSuperview];
        [contentView setFrame: CGRectMake (0, 0, contentView.frame.size.width, contentView.frame.size.height)];
        [scrollView addSubview: contentView];
        }

    [self alignImageOrView: scrollView];
    }

- (void) alignImageOrView: (UIScrollView *) scrollView
    {
    UIView * parentView  = (UIView *)  [__weakrefbase Value];
    UIView * contentView = (UIView *)  [__weakrefcontentview Value];
    UIImage * image      = (UIImage *) [__weakrefimage Value];
    if (parentView == nil) { return; };

    CGSize scrollViewSize = scrollView.frame.size;

    if (image != nil)
        {
        UIImageView * imageView = scrollView.subviews.firstObject;

        CGSize imageViewSize = imageView.frame.size;
        CGSize imageSize = imageView.image.size;

        CGSize realImageSize;
        if (imageSize.width / imageSize.height > imageViewSize.width / imageViewSize.height) { realImageSize = CGSizeMake (imageViewSize.width, imageViewSize.width / imageSize.width * imageSize.height); }
                                                                                    else { realImageSize = CGSizeMake (imageViewSize.height / imageSize.height * imageSize.width, imageViewSize.height); };
        CGRect frame = CGRectMake (0, 0, 0, 0);
        frame.size = realImageSize;
        imageView.frame = frame;
        float offsetX = 0;
        if (scrollViewSize.width > realImageSize.width)
            {
            if (__bytehorizontalalignment == 0) { offsetX = (scrollViewSize.width - realImageSize.width) / 2; };
            if (__bytehorizontalalignment == 2) { offsetX = (scrollViewSize.width - realImageSize.width); };
            };
        float offsetY = 0;
        if (scrollViewSize.height > realImageSize.height)
            {
            if (__byteverticalalignment == 0) { offsetY = (scrollViewSize.height - realImageSize.height) / 2; };
            if (__byteverticalalignment == 2) { offsetY = (scrollViewSize.height - realImageSize.height); };
            };
        scrollView.contentInset = UIEdgeInsetsMake (offsetY, offsetX, 0, 0); // (scrollViewSize.height - realImageSize.height) - offsetY, (scrollViewSize.width - realImageSize.width) - offsetX);
        };

    if (contentView != nil)
        {
        CGSize contentViewSize = contentView.frame.size;
        float offsetX = 0;
        if (scrollViewSize.width > contentViewSize.width)
            {
            if (__bytehorizontalalignment == 0) { offsetX = (scrollViewSize.width - contentViewSize.width) / 2; };
            if (__bytehorizontalalignment == 2) { offsetX = (scrollViewSize.width - contentViewSize.width); };
            };
        float offsetY = 0;
        if (scrollViewSize.height > contentViewSize.height)
            {
            if (__byteverticalalignment == 0) { offsetY = (scrollViewSize.height - contentViewSize.height) / 2; };
            if (__byteverticalalignment == 2) { offsetY = (scrollViewSize.height - contentViewSize.height); };
            };
        scrollView.contentInset = UIEdgeInsetsMake (offsetY, offsetX, 0, 0); // (scrollViewSize.height - contentViewSize.height) - offsetY, (scrollViewSize.width - contentViewSize.width) - offsetX);
        };
    }

- (UIView *) viewForZoomingInScrollView: (UIScrollView *) scrollView { return scrollView.subviews.firstObject;}
- (void) scrollViewWillBeginDragging: (UIScrollView *) scrollView { [[UIApplication sharedApplication] sendAction: @selector (resignFirstResponder) to: nil from: nil forEvent: nil]; }
- (void) scrollViewWillBeginZooming: (UIScrollView *) scrollView withView: (UIView *) view { [self.bi raiseEvent: nil event: @"willbeginzooming::" params: @[scrollView, view]]; }
- (void) scrollViewDidEndZooming: (UIScrollView *) scrollView withView: (UIView *) view atScale: (CGFloat) scale
    {
    __floatzoomscale = scale;
    [self alignImageOrView: scrollView];
    [self.bi raiseEvent: nil event: @"didendzooming::" params: @[scrollView, view]];
    }
- (void) scrollViewDidZoom: (UIScrollView *) scrollView { [self.bi raiseEvent: nil event: @"didzoom:" params: @[scrollView]]; }

-(void) imageViewClick { [self.bi raiseEvent: nil event: @"imageclicked" params: nil]; }

#End If
