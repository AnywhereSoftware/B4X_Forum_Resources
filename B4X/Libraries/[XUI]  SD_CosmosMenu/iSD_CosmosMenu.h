#import "iCore.h"
#import "iXUI.h"
@interface b4i_sd_cosmosmenu : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public NSObject* __tag;
@public int __tcolor;
@public int __bcolor;
@public BOOL __centerball;
@public B4IMap* __listamenu;
@public int __diameter;
@public int __deg;

}- (void)  _animation:(B4XViewWrapper*) _b;
- (void)  _animationtext:(B4XViewWrapper*) _b;
- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)NSObject* _tag;
@property (nonatomic)int _tcolor;
@property (nonatomic)int _bcolor;
@property (nonatomic)BOOL _centerball;
@property (nonatomic)B4IMap* _listamenu;
@property (nonatomic)int _diameter;
@property (nonatomic)int _deg;
- (NSString*)  _clear;
- (NSString*)  _createroundbitmap:(B4XViewWrapper*) _xview :(B4XBitmapWrapper*) _input :(int) _size;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (NSString*)  _effect_click;
- (NSString*)  _effect_longclick;
- (int)  _getballdiameter;
- (B4XViewWrapper*)  _getbase;
- (int)  _getheight;
- (NSString*)  _getitemtype:(NSString*) _id;
- (int)  _getleft;
- (int)  _getrotatedegree;
- (int)  _gettop;
- (BOOL)  _getvisible;
- (int)  _getwidth;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _invalidate;
- (NSString*)  _label_click;
- (NSString*)  _label_longclick;
- (NSString*)  _panel_click;
- (NSString*)  _panel_longclick;
- (NSString*)  _removeitem:(NSString*) _id :(BOOL) _forcerefresh;
- (NSString*)  _setballdiameter:(int) _d;
- (NSString*)  _setheight:(int) _b;
- (NSString*)  _setitem:(NSString*) _id :(NSString*) _text :(B4XFont*) _textfont :(BOOL) _lighteffect :(BOOL) _forcerefresh;
- (NSString*)  _setitemimage:(NSString*) _id :(B4XBitmapWrapper*) _image :(BOOL) _lighteffect :(BOOL) _forcerefresh;
- (NSString*)  _setleft:(int) _b;
- (NSString*)  _setrotatedegree:(int) _d;
- (NSString*)  _settop:(int) _b;
- (NSString*)  _setvisible:(BOOL) _b;
- (NSString*)  _setwidth:(int) _b;
- (B4XBitmapWrapper*)  _snapshot;
- (B4XViewWrapper*)  _xlighteffect:(int) _dpt :(NSObject*) _id;
@end

