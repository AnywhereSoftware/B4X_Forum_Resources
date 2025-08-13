#import "iCore.h"
#import "iXUI.h"
@class _disktype;
@class b4i_horizontalpicker;
@class b4i_horizontaltextpicker;
@interface b4i_diskimagepicker : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public B4XViewWrapper* __touch;
@public int __infofsize;
@public int __textfsize;
@public int __buttonfsize;
@public float __textdistance;
@public float __infodistance;
@public int __centralsphere;
@public NSString* __buttontext;
@public int __thickness;
@public int __index;
@public int __bckclr;
@public int __clr1;
@public int __clr2;
@public int __cloveclr;
@public int __ballcolor;
@public int __lastx;
@public int __lasty;
@public long long __lasttouch;
@public B4IList* __listitem;
@public B4XCanvas* __cnv;

}- (b4i_diskimagepicker*)  _additem:(NSString*) _text :(NSString*) _info :(B4XBitmapWrapper*) _img;
- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)B4XViewWrapper* _touch;
@property (nonatomic)int _infofsize;
@property (nonatomic)int _textfsize;
@property (nonatomic)int _buttonfsize;
@property (nonatomic)float _textdistance;
@property (nonatomic)float _infodistance;
@property (nonatomic)int _centralsphere;
@property (nonatomic)NSString* _buttontext;
@property (nonatomic)int _thickness;
@property (nonatomic)int _index;
@property (nonatomic)int _bckclr;
@property (nonatomic)int _clr1;
@property (nonatomic)int _clr2;
@property (nonatomic)int _cloveclr;
@property (nonatomic)int _ballcolor;
@property (nonatomic)int _lastx;
@property (nonatomic)int _lasty;
@property (nonatomic)long long _lasttouch;
@property (nonatomic)B4IList* _listitem;
@property (nonatomic)B4XCanvas* _cnv;
- (NSString*)  _clearlist;
- (NSString*)  _deleteitem:(int) _pos;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (int)  _findlighterordarkercolor:(int) _mycolor :(float) _factor;
- (int)  _getballfontsize;
- (int)  _getcentralballdept;
- (int)  _getinfofontsize;
- (float)  _getinfotopposition;
- (NSString*)  _getiteminfo:(int) _pos;
- (NSString*)  _getitemtext:(int) _pos;
- (int)  _getpickerindex;
- (int)  _getsize;
- (int)  _gettextfontsize;
- (float)  _gettexttopposition;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _invalidate;
- (NSString*)  _refresh:(int) _degree :(BOOL) _press;
- (NSString*)  _setballfontsize:(int) _s;
- (NSString*)  _setcentralballdept:(int) _s;
- (NSString*)  _setinfofontsize:(int) _s;
- (NSString*)  _setinfotopposition:(float) _s;
- (NSString*)  _setpickerindex:(int) _t;
- (NSString*)  _settextfontsize:(int) _s;
- (NSString*)  _settexttopposition:(float) _s;
- (void)  _touch_touch:(int) _action :(float) _x :(float) _y;
@end
@interface _disktype:NSObject
{
@public BOOL _IsInitialized;
@public NSString* _Text;
@public NSString* _Info;
@public B4XBitmapWrapper* _bmp;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSString* Text;
@property (nonatomic)NSString* Info;
@property (nonatomic)B4XBitmapWrapper* bmp;
-(void)Initialize;
@end

#import "iCore.h"
#import "iXUI.h"
@class _disktype;
@class b4i_diskimagepicker;
@class b4i_horizontaltextpicker;
@interface b4i_horizontalpicker : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public NSObject* __tag;
@public B4XViewWrapper* __touch;
@public int __infofsize;
@public int __textfsize;
@public float __textdistance;
@public float __infodistance;
@public int __boxwidth;
@public int __index;
@public int __clr1;
@public int __clr2;
@public int __itemclr;
@public int __blk;
@public int __evidence;
@public int __lastx;
@public long long __lasttouch;
@public int __lastindex;
@public int __leftx;
@public int __rightx;
@public B4IList* __listitem;
@public B4XCanvas* __cnv;

}- (b4i_horizontalpicker*)  _additem:(NSString*) _text :(NSString*) _info :(B4XBitmapWrapper*) _img;
- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)NSObject* _tag;
@property (nonatomic)B4XViewWrapper* _touch;
@property (nonatomic)int _infofsize;
@property (nonatomic)int _textfsize;
@property (nonatomic)float _textdistance;
@property (nonatomic)float _infodistance;
@property (nonatomic)int _boxwidth;
@property (nonatomic)int _index;
@property (nonatomic)int _clr1;
@property (nonatomic)int _clr2;
@property (nonatomic)int _itemclr;
@property (nonatomic)int _blk;
@property (nonatomic)int _evidence;
@property (nonatomic)int _lastx;
@property (nonatomic)long long _lasttouch;
@property (nonatomic)int _lastindex;
@property (nonatomic)int _leftx;
@property (nonatomic)int _rightx;
@property (nonatomic)B4IList* _listitem;
@property (nonatomic)B4XCanvas* _cnv;
- (NSString*)  _clearlist;
- (NSString*)  _deleteitem:(int) _pos;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (int)  _findlighterordarkercolor:(int) _mycolor :(float) _factor;
- (int)  _getinfofontsize;
- (float)  _getinfotopposition;
- (NSString*)  _getiteminfo:(int) _pos;
- (NSString*)  _getitemtext:(int) _pos;
- (int)  _getpickerindex;
- (int)  _getsize;
- (int)  _gettextfontsize;
- (float)  _gettexttopposition;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _invalidate;
- (NSString*)  _refresh:(int) _pass :(BOOL) _press;
- (NSString*)  _setinfofontsize:(int) _s;
- (NSString*)  _setinfotopposition:(float) _s;
- (NSString*)  _setpickerindex:(int) _t;
- (NSString*)  _settextfontsize:(int) _s;
- (NSString*)  _settexttopposition:(float) _s;
- (void)  _touch_touch:(int) _action :(float) _x :(float) _y;
@end

#import "iCore.h"
#import "iXUI.h"
@class _disktype;
@class b4i_diskimagepicker;
@class b4i_horizontalpicker;
@interface b4i_horizontaltextpicker : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public NSObject* __tag;
@public B4XViewWrapper* __touch;
@public int __infofsize;
@public int __textfsize;
@public float __infodistance;
@public int __boxwidth;
@public int __boxheight;
@public int __index;
@public int __clr1;
@public int __clr2;
@public int __itemclr;
@public int __blk;
@public int __evidence;
@public int __lastx;
@public int __leftx;
@public int __rightx;
@public long long __lasttouch;
@public int __lastindex;
@public B4IList* __listitem;
@public B4XCanvas* __cnv;

}- (b4i_horizontaltextpicker*)  _additem:(NSString*) _text :(NSString*) _info;
- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)NSObject* _tag;
@property (nonatomic)B4XViewWrapper* _touch;
@property (nonatomic)int _infofsize;
@property (nonatomic)int _textfsize;
@property (nonatomic)float _infodistance;
@property (nonatomic)int _boxwidth;
@property (nonatomic)int _boxheight;
@property (nonatomic)int _index;
@property (nonatomic)int _clr1;
@property (nonatomic)int _clr2;
@property (nonatomic)int _itemclr;
@property (nonatomic)int _blk;
@property (nonatomic)int _evidence;
@property (nonatomic)int _lastx;
@property (nonatomic)int _leftx;
@property (nonatomic)int _rightx;
@property (nonatomic)long long _lasttouch;
@property (nonatomic)int _lastindex;
@property (nonatomic)B4IList* _listitem;
@property (nonatomic)B4XCanvas* _cnv;
- (NSString*)  _clearlist;
- (NSString*)  _deleteitem:(int) _pos;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (int)  _findlighterordarkercolor:(int) _mycolor :(float) _factor;
- (int)  _getinfofontsize;
- (float)  _getinfotopposition;
- (NSString*)  _getiteminfo:(int) _pos;
- (NSString*)  _getitemtext:(int) _pos;
- (int)  _getpickerindex;
- (int)  _getsize;
- (int)  _gettextfontsize;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _invalidate;
- (NSString*)  _refresh:(int) _pass :(BOOL) _press;
- (NSString*)  _setinfofontsize:(int) _s;
- (NSString*)  _setinfotopposition:(float) _s;
- (NSString*)  _setpickerindex:(int) _t;
- (NSString*)  _settextfontsize:(int) _s;
- (void)  _touch_touch:(int) _action :(float) _x :(float) _y;
@end

