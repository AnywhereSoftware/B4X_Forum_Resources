//  iGifView.m
//  iGifView

#import "iGifView.h"

@implementation iGifView

+(Class) getClass { return [FLAnimatedImageView class]; }

@synthesize ImageView       = _imageView;
@synthesize Image           = _image;
@synthesize Width           = _width;
@synthesize Height          = _height;
@synthesize Tag             = _tag;

- (void) Initialize : (NSString *)       Directory
                    : (NSString *)       FileName
                    : (UIView *)         ParentView
                    : (float)            desiredLeft
                    : (float)            desiredTop
                    : (float)            desiredWidth
                    : (float)            desiredHeight
                    : (bool)             keepAspectRatio
    {
    [self Release];
    NSString * path = [[[B4ICommon shared] File] checkAssets: Directory : FileName : false];
    _imageView = [[FLAnimatedImageView alloc] init];
    _image = [FLAnimatedImage animatedImageWithGIFData: [NSData dataWithContentsOfFile: [[[B4ICommon shared] File] Combine: Directory : path]]];
    self.object = _imageView;
    if (_image == nil)
        { [NSException raise: @"" format: @"Error loading GIF file."]; }
    else
        {
        float imageLeft, imageTop, imageWidth, imageHeight;
        _imageView.animatedImage = _image;
        _width = _image.size.width;
        _height = _image.size.height;
        imageWidth = desiredWidth;
        imageHeight = desiredHeight;
        if ((_width > 0) && (_height > 0) && (keepAspectRatio == true))
            {
            imageHeight = desiredWidth * (_height / _width);
            if (imageHeight > desiredHeight) { imageHeight = desiredHeight; }
            imageWidth = imageHeight * (_width / _height);
            }
        imageLeft = desiredLeft + (desiredWidth - imageWidth) / 2;
        imageTop = desiredTop + (desiredHeight - imageHeight) / 2;
        _imageView.frame = CGRectMake (imageLeft, imageTop, imageWidth, imageHeight);
        [ParentView addSubview : _imageView];
        }
    }

- (void) Release
    {
    if (_imageView != nil) { [(UIView *) _imageView removeFromSuperview]; }
    _image = nil;
    _imageView = nil;
    self.object = _imageView;
    _width = 0;
    _height = 0;
    }

- (FLAnimatedImage *) Image { return _image; }
- (FLAnimatedImageView *) ImageView { return _imageView; }
- (float) Width { return _width; }
- (float) Height { return _height; }

- (void) setTag: (NSObject *) value { _tag = value; }
- (NSObject *) Tag { return _tag; }

@end
