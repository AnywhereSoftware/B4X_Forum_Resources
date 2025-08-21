#import <Foundation/Foundation.h>
#import "iCore.h"

@class FLAnimatedImageView;

//~version          : 1.00
//~shortname        : GifView
//~ObjectWrapper    : NSObject *

@interface iGifView : B4IObjectWrapper

- (void) Initialize : (NSString *) Directory
                    : (NSString *) FileName
                    : (UIView *)   ParentView
                    : (float)      desiredLeft
                    : (float)      desiredTop
                    : (float)      desiredWidth
                    : (float)      desiredHeight
                    : (bool)       keepAspectRatio;
- (void) Release;

@property (nonatomic, readonly)  NSObject * Image;
@property (nonatomic, readonly)  NSObject * ImageView;
@property (nonatomic, readonly)  float      Width;
@property (nonatomic, readonly)  float      Height;
@property (nonatomic, readwrite) NSObject * Tag;

@end
