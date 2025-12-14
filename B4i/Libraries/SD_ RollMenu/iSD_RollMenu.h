#import "iCore.h"
@class _mytype;
@class _mtype;
@class b4i_turnoutmenu;
@interface b4i_rolloutmenu : B4IClass
{
@public BOOL __isopen;
@public int __timeanimation;
@public int __spacefromtop;
@public B4IPanelWrapper* __view;
@public BOOL __stick;
@public B4IList* __listbutton;
@public NSObject* __callback;
@public NSString* __event;
@public int __dimen;
@public BOOL __moviment;
@public BOOL __demo;

}- (NSString*)  _addimagebutton:(B4IBitmap*) _bitmap :(NSString*) _id;
- (NSString*)  _class_globals;
@property (nonatomic)BOOL _isopen;
@property (nonatomic)int _timeanimation;
@property (nonatomic)int _spacefromtop;
@property (nonatomic)B4IPanelWrapper* _view;
@property (nonatomic)BOOL _stick;
@property (nonatomic)B4IList* _listbutton;
@property (nonatomic)NSObject* _callback;
@property (nonatomic)NSString* _event;
@property (nonatomic)int _dimen;
@property (nonatomic)BOOL _moviment;
@property (nonatomic)BOOL _demo;
- (void)  _close:(BOOL) _animation;
- (void)  _closefrom:(int) _from;
- (B4IPanelWrapper*)  _getpanel;
- (NSString*)  _imageview_click;
- (NSString*)  _initialize:(B4I*) _ba :(NSString*) _eventaname :(NSObject*) _me_callback :(B4IPanelWrapper*) _rootpanel :(BOOL) _leftstick :(int) _hightwidh;
- (void)  _open:(BOOL) _animation;
- (NSString*)  _rotationx:(B4IViewWrapper*) _v :(float) _angle;
- (NSString*)  _rotationy:(B4IViewWrapper*) _v :(float) _angle;
@end
@interface _mytype:NSObject
{
@public BOOL _IsInitialized;
@public B4IImageViewWrapper* _ImageView;
@public NSString* _ID;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)B4IImageViewWrapper* ImageView;
@property (nonatomic)NSString* ID;
-(void)Initialize;
@end

#import "iCore.h"
@class _mytype;
@class b4i_rolloutmenu;
@class _mtype;
@interface b4i_turnoutmenu : B4IClass
{
@public BOOL __isopen;
@public int __timeanimation;
@public int __spacefromtop;
@public B4IPanelWrapper* __view;
@public BOOL __stick;
@public B4IList* __listbutton;
@public NSObject* __callback;
@public NSString* __event;
@public int __dimen;
@public BOOL __moviment;
@public BOOL __demo;

}- (NSString*)  _addimagebutton:(B4IBitmap*) _bitmap :(NSString*) _id;
- (NSString*)  _class_globals;
@property (nonatomic)BOOL _isopen;
@property (nonatomic)int _timeanimation;
@property (nonatomic)int _spacefromtop;
@property (nonatomic)B4IPanelWrapper* _view;
@property (nonatomic)BOOL _stick;
@property (nonatomic)B4IList* _listbutton;
@property (nonatomic)NSObject* _callback;
@property (nonatomic)NSString* _event;
@property (nonatomic)int _dimen;
@property (nonatomic)BOOL _moviment;
@property (nonatomic)BOOL _demo;
- (void)  _close:(BOOL) _animation;
- (void)  _closefrom:(int) _from;
- (B4IPanelWrapper*)  _getpanel;
- (NSString*)  _imageview_click;
- (NSString*)  _initialize:(B4I*) _ba :(NSString*) _eventaname :(NSObject*) _me_callback :(B4IPanelWrapper*) _rootpanel :(BOOL) _leftstick :(int) _hightwidh;
- (void)  _open:(BOOL) _animation;
- (NSString*)  _rotationx:(B4IViewWrapper*) _v :(float) _angle;
- (NSString*)  _rotationy:(B4IViewWrapper*) _v :(float) _angle;
@end
@interface _mtype:NSObject
{
@public BOOL _IsInitialized;
@public B4IImageViewWrapper* _ImageView;
@public NSString* _ID;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)B4IImageViewWrapper* ImageView;
@property (nonatomic)NSString* ID;
-(void)Initialize;
@end

