#import "iCore.h"
@interface b4i_ilottie : B4IClass
{
@public B4IViewWrapper* __animationview;
@public int __aspect_fit_content;
@public int __aspect_fill_content;
@public int __scale_fill_content;
@public NSString* __eventname;
@public NSObject* __mcallback;
@public B4INativeObject* __n;

}- (NSString*)  _animationcompleted:(BOOL) _complete;
- (NSString*)  _animationfromfile:(NSString*) _dir :(NSString*) _filename;
- (NSString*)  _animationfromjsonstring:(NSString*) _jsonstring;
- (NSString*)  _animationfromurl:(NSString*) _url;
- (NSString*)  _class_globals;
@property (nonatomic)B4IViewWrapper* _animationview;
@property (nonatomic)int _aspect_fit_content;
@property (nonatomic)int _aspect_fill_content;
@property (nonatomic)int _scale_fill_content;
@property (nonatomic)NSString* _eventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4INativeObject* _n;
- (float)  _getanimationduration;
- (BOOL)  _getisanimationplaying;
- (NSString*)  _initialize:(B4I*) _ba :(NSString*) _event :(NSObject*) _callback;
- (NSString*)  _pause;
- (NSString*)  _play;
- (NSString*)  _playfromtoframe:(int) _fromframe :(int) _toframe;
- (NSString*)  _playfromtoprogress:(float) _fromprogress :(float) _toprogress;
- (NSString*)  _playtoframe:(int) _toframe;
- (NSString*)  _setanimationframe:(int) _frame;
- (NSString*)  _setanimationprogress:(float) _progress;
- (NSString*)  _setanimationspeed:(float) _speed;
- (NSString*)  _setautoreverseanimation:(BOOL) _reverse;
- (NSString*)  _setcacheenable:(BOOL) _enable;
- (NSString*)  _setcontentmode:(int) _mode;
- (NSString*)  _setloopanimation:(BOOL) _indefinitely;
- (NSString*)  _stop;
@end

