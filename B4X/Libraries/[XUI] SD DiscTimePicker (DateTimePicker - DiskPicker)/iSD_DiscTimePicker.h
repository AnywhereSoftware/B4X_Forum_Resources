#import "iCore.h"
#import "iXUI.h"
@class _disktype;
@class b4i_diskpicker;
@interface b4i_disctimepicker : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public B4XViewWrapper* __touch;
@public int __thickness;
@public long long __dt;
@public int __bckclr;
@public int __clr;
@public int __lastx;
@public int __lasty;

}- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)B4XViewWrapper* _touch;
@property (nonatomic)int _thickness;
@property (nonatomic)long long _dt;
@property (nonatomic)int _bckclr;
@property (nonatomic)int _clr;
@property (nonatomic)int _lastx;
@property (nonatomic)int _lasty;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (long long)  _getdatetimeticks;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _invalidate;
- (NSString*)  _refresh:(int) _degreeday :(int) _degreeminutes;
- (NSString*)  _setdatetimeticks:(long long) _t;
- (NSString*)  _touch_touch:(int) _action :(float) _x :(float) _y;
@end

#import "iCore.h"
#import "iXUI.h"
@class b4i_disctimepicker;
@class _disktype;
@interface b4i_diskpicker : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public B4XViewWrapper* __touch;
@public int __infofsize;
@public int __textfsize;
@public float __textupdistance;
@public float __infoupdistance;
@public float __textdown1distance;
@public int __thickness;
@public int __indexup;
@public int __indexdown1;
@public int __indexdown2;
@public int __bckclr;
@public int __clr;
@public int __lastx;
@public int __lasty;
@public B4IList* __listup;
@public B4IList* __listdown1;
@public B4IList* __listdown2;

}- (b4i_diskpicker*)  _addtodown1:(NSString*) _text :(NSString*) _info;
- (b4i_diskpicker*)  _addtodown2:(NSString*) _text :(NSString*) _info;
- (b4i_diskpicker*)  _addtolistup:(NSString*) _text :(NSString*) _info;
- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)B4XViewWrapper* _touch;
@property (nonatomic)int _infofsize;
@property (nonatomic)int _textfsize;
@property (nonatomic)float _textupdistance;
@property (nonatomic)float _infoupdistance;
@property (nonatomic)float _textdown1distance;
@property (nonatomic)int _thickness;
@property (nonatomic)int _indexup;
@property (nonatomic)int _indexdown1;
@property (nonatomic)int _indexdown2;
@property (nonatomic)int _bckclr;
@property (nonatomic)int _clr;
@property (nonatomic)int _lastx;
@property (nonatomic)int _lasty;
@property (nonatomic)B4IList* _listup;
@property (nonatomic)B4IList* _listdown1;
@property (nonatomic)B4IList* _listdown2;
- (NSString*)  _clearlistdown1;
- (NSString*)  _clearlistdown2;
- (NSString*)  _clearlistup;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (int)  _getinfofontsize;
- (int)  _getpickerindexdown1;
- (int)  _getpickerindexdown2;
- (int)  _getpickerindexup;
- (int)  _gettextfontsize;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _invalidate;
- (NSString*)  _refresh:(int) _degreeup :(int) _degreedown;
- (NSString*)  _setinfofontsize:(int) _s;
- (NSString*)  _setpickerindexdown1:(int) _t;
- (NSString*)  _setpickerindexdown2:(int) _t;
- (NSString*)  _setpickerindexup:(int) _t;
- (NSString*)  _settextfontsize:(int) _s;
- (NSString*)  _touch_touch:(int) _action :(float) _x :(float) _y;
@end
@interface _disktype:NSObject
{
@public BOOL _IsInitialized;
@public NSString* _Text;
@public NSString* _Info;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSString* Text;
@property (nonatomic)NSString* Info;
-(void)Initialize;
@end

