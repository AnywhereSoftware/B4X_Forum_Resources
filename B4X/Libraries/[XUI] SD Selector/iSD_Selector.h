#import "iCore.h"
#import "iXUI.h"
@class b4i_fourselectorplus;
@interface b4i_fourselector : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public NSObject* __tag;
@public B4XViewWrapper* __fund;
@public B4XCanvas* __can;
@public int __wheelcolor;
@public int __textcolor;
@public int __backcolor;
@public int __firstx;
@public int __firsty;
@public int __lastx;
@public int __lasty;
@public B4IArray* __lab;
@public B4IArray* __pan;
@public B4IArray* __panlab;
@public B4XViewWrapper* __labtemp;
@public B4IArray* __colrs;
@public B4IArray* __soption;
@public B4IArray* __sindex;
@public int __selectornumber;
@public int __velocity;

}- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _centerfund;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)NSObject* _tag;
@property (nonatomic)B4XViewWrapper* _fund;
@property (nonatomic)B4XCanvas* _can;
@property (nonatomic)int _wheelcolor;
@property (nonatomic)int _textcolor;
@property (nonatomic)int _backcolor;
@property (nonatomic)int _firstx;
@property (nonatomic)int _firsty;
@property (nonatomic)int _lastx;
@property (nonatomic)int _lasty;
@property (nonatomic)B4IArray* _lab;
@property (nonatomic)B4IArray* _pan;
@property (nonatomic)B4IArray* _panlab;
@property (nonatomic)B4XViewWrapper* _labtemp;
@property (nonatomic)B4IArray* _colrs;
@property (nonatomic)B4IArray* _soption;
@property (nonatomic)B4IArray* _sindex;
@property (nonatomic)int _selectornumber;
@property (nonatomic)int _velocity;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (NSString*)  _draw:(int) _degree :(int) _side;
- (NSString*)  _fund_touch:(int) _action :(float) _x :(float) _y;
- (B4XViewWrapper*)  _getbase;
- (int)  _getitemindex:(int) _nselector;
- (NSString*)  _getitemvalue:(int) _nselector;
- (int)  _getwheelspeed;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (int)  _minmax:(int) _value :(int) _maxrange;
- (NSString*)  _setitemindex:(int) _nselector :(int) _index;
- (NSString*)  _setitems:(int) _nselector :(B4IList*) _listitem;
- (NSString*)  _setwheelcolors:(int) _upcolor :(int) _rigthcolor :(int) _downcolor :(int) _leftcolor;
- (NSString*)  _setwheelspeed:(int) _v;
@end

#import "iCore.h"
#import "iXUI.h"
@class b4i_fourselector;
@interface b4i_fourselectorplus : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public NSObject* __tag;
@public B4XViewWrapper* __fondo;
@public B4XCanvas* __can;
@public int __wheelcolor;
@public int __textcolor;
@public int __backcolor;
@public int __stextcolor;
@public int __sbackcolor;
@public B4XFont* __tfont;
@public B4IArray* __v;
@public int __mindex;

}- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _centerfondo;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)NSObject* _tag;
@property (nonatomic)B4XViewWrapper* _fondo;
@property (nonatomic)B4XCanvas* _can;
@property (nonatomic)int _wheelcolor;
@property (nonatomic)int _textcolor;
@property (nonatomic)int _backcolor;
@property (nonatomic)int _stextcolor;
@property (nonatomic)int _sbackcolor;
@property (nonatomic)B4XFont* _tfont;
@property (nonatomic)B4IArray* _v;
@property (nonatomic)int _mindex;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (NSString*)  _draw;
- (NSString*)  _fondo_touch:(int) _action :(float) _x :(float) _y;
- (B4XViewWrapper*)  _getbase;
- (int)  _getindex;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _setindex:(int) _i;
- (NSString*)  _setitems:(NSString*) _item1 :(NSString*) _item2 :(NSString*) _item3 :(NSString*) _item4;
- (NSString*)  _settextfont:(B4XFont*) _f;
@end

