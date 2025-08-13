#import "iCore.h"
#import "iXUI.h"
#import "iSD_CreativeBackground.h"
@class _typeed;
@class b4i_sd_keyboard;
@class _type_singlekey;
@class _pinch_attributes;
@class _rotation_attributes;
@class _swipe_attributes;
@class _screenedgepan_attributes;
@class _tap_attributes;
@class _longpress_attributes;
@class _pan_attributes;
@class _gpoint;
@class b4i_gesturerecognizer;
@interface b4i_customkey : B4IClass
{
@public B4IList* __listkey;
@public B4IMap* __specialkey;
@public int __codecanc;
@public int __codetab;
@public int __codeenter;
@public int __codeesc;
@public int __codedel;
@public int __codenext;
@public int __codeshift;
@public int __codeeraseall;
@public int __insertkeytext;

}- (b4i_customkey*)  _addcustomkeytolastrow:(NSString*) _uptext :(int) _upcode :(NSString*) _lotext :(int) _locode :(int) _size :(int) _backgroundkeycolor :(int) _textkeycolor;
- (b4i_customkey*)  _addcustomkeytolastrow2:(NSString*) _uptext :(int) _upcode :(NSString*) _lotext :(int) _locode :(B4IMap*) _alternatekeyup :(B4IMap*) _alternatekeylo :(int) _size :(int) _backgroundkeycolor :(int) _textkeycolor;
- (b4i_customkey*)  _addemptyrow;
- (b4i_customkey*)  _addemptyspacetolastrow;
- (b4i_customkey*)  _addkeytolastrow:(NSString*) _uppertext :(int) _upcode :(NSString*) _lowertext :(int) _locode :(int) _size;
- (b4i_customkey*)  _addkeytolastrow2:(NSString*) _uppertext :(int) _upcode :(NSString*) _lowertext :(int) _locode :(B4IMap*) _alternatekeyupper :(B4IMap*) _alternatekeylower :(int) _size;
- (b4i_customkey*)  _addrow:(B4IList*) _keys;
- (b4i_customkey*)  _addsimplechartolastrow:(B4IArray*) _keys;
- (b4i_customkey*)  _addsimplechartonewrow:(B4IArray*) _keys;
- (b4i_customkey*)  _addstringtokeytonewrow:(B4IArray*) _strings;
- (b4i_customkey*)  _addupperlowerchartolastrow:(B4IArray*) _keys;
- (b4i_customkey*)  _addupperlowerchartonewrow:(B4IArray*) _keys;
- (_type_singlekey*)  _cemptykey;
- (_type_singlekey*)  _ckey:(NSString*) _uppertext :(int) _uppercode :(NSString*) _lowertext :(int) _lowercode :(B4IMap*) _alternateup :(B4IMap*) _alternatelo;
- (_type_singlekey*)  _ckeycustomized:(NSString*) _uppertext :(int) _uppercode :(NSString*) _lowertext :(int) _lowercode :(int) _size :(int) _backgroundkeycolor :(int) _textkeycolor :(B4IMap*) _alternateup :(B4IMap*) _alternatelo;
- (_type_singlekey*)  _ckeysized:(NSString*) _uppertext :(int) _uppercode :(NSString*) _lowertext :(int) _lowercode :(int) _size :(B4IMap*) _alternateup :(B4IMap*) _alternatelo;
- (NSString*)  _class_globals;
@property (nonatomic)B4IList* _listkey;
@property (nonatomic)B4IMap* _specialkey;
@property (nonatomic)int _codecanc;
@property (nonatomic)int _codetab;
@property (nonatomic)int _codeenter;
@property (nonatomic)int _codeesc;
@property (nonatomic)int _codedel;
@property (nonatomic)int _codenext;
@property (nonatomic)int _codeshift;
@property (nonatomic)int _codeeraseall;
@property (nonatomic)int _insertkeytext;
- (NSString*)  _initialize:(B4I*) _ba;
- (B4IList*)  _keyboard;
@end
@interface _type_singlekey:NSObject
{
@public BOOL _IsInitialized;
@public NSString* _UpperText;
@public NSString* _LowerText;
@public int _UpperCode;
@public int _LowerCode;
@public int _size;
@public BOOL _Cstm;
@public int _bkey;
@public int _tkey;
@public B4XViewWrapper* _klb;
@public B4IMap* _AlternateUp;
@public B4IMap* _AlternateLo;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSString* UpperText;
@property (nonatomic)NSString* LowerText;
@property (nonatomic)int UpperCode;
@property (nonatomic)int LowerCode;
@property (nonatomic)int size;
@property (nonatomic)BOOL Cstm;
@property (nonatomic)int bkey;
@property (nonatomic)int tkey;
@property (nonatomic)B4XViewWrapper* klb;
@property (nonatomic)B4IMap* AlternateUp;
@property (nonatomic)B4IMap* AlternateLo;
-(void)Initialize;
@end

#import "iCore.h"
#import "iXUI.h"
#import "iSD_CreativeBackground.h"
@class _typeed;
@class b4i_sd_keyboard;
@class _type_singlekey;
@class b4i_customkey;
@class _pinch_attributes;
@class _rotation_attributes;
@class _swipe_attributes;
@class _screenedgepan_attributes;
@class _tap_attributes;
@class _longpress_attributes;
@class _pan_attributes;
@class _gpoint;
@interface b4i_gesturerecognizer : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mhandler;
@public B4IViewWrapper* __mview;
@public B4INativeObject* __nome;
@public int __mswipedirectionleft;
@public int __mswipedirectionright;
@public int __mswipedirectionup;
@public int __mswipedirectiondown;
@public int __medge_left;
@public int __medge_top;
@public int __medge_right;
@public int __medge_bottom;
@public int __mstate_begin;
@public int __mstate_changed;
@public int __mstate_end;
@public B4IMap* __mgrmap;
@public B4INativeObject* __noobjc;

}- (NSString*)  _addlongpressgesture:(int) _numberoftaps :(int) _numberoftouch :(float) _duration;
- (NSString*)  _addpangesture:(int) _minimumtouch :(int) _maximumtouch;
- (NSString*)  _addpinchgesture;
- (NSString*)  _addrotationgesture;
- (NSString*)  _addscreenedgepangesture:(int) _edge;
- (NSString*)  _addswipegesture:(int) _numberoftouch :(int) _direction;
- (NSString*)  _addtapgesture:(int) _numberoftaps :(int) _numberoftouch;
- (_gpoint*)  _cgpointtopoint:(NSObject*) _cgpoint;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mhandler;
@property (nonatomic)B4IViewWrapper* _mview;
@property (nonatomic)B4INativeObject* _nome;
@property (nonatomic)int _mswipedirectionleft;
@property (nonatomic)int _mswipedirectionright;
@property (nonatomic)int _mswipedirectionup;
@property (nonatomic)int _mswipedirectiondown;
@property (nonatomic)int _medge_left;
@property (nonatomic)int _medge_top;
@property (nonatomic)int _medge_right;
@property (nonatomic)int _medge_bottom;
@property (nonatomic)int _mstate_begin;
@property (nonatomic)int _mstate_changed;
@property (nonatomic)int _mstate_end;
@property (nonatomic)B4IMap* _mgrmap;
@property (nonatomic)B4INativeObject* _noobjc;
- (_gpoint*)  _getcenter:(B4IViewWrapper*) _view;
- (int)  _getedge_bottom;
- (int)  _getedge_left;
- (int)  _getedge_right;
- (int)  _getedge_top;
- (B4IMap*)  _getgestures;
- (int)  _getstate_begin;
- (int)  _getstate_changed;
- (int)  _getstate_end;
- (int)  _getswipe_direction_down;
- (int)  _getswipe_direction_left;
- (int)  _getswipe_direction_right;
- (int)  _getswipe_direction_up;
- (NSString*)  _initialize:(B4I*) _ba :(NSString*) _eventname :(NSObject*) _handler :(B4IViewWrapper*) _v;
- (NSObject*)  _pointtocgpoint:(_gpoint*) _point1;
- (NSString*)  _setcenter:(B4IViewWrapper*) _view :(_gpoint*) _point;
- (NSString*)  _uigesture_longpress:(int) _state :(int) _numtouch :(int) _numtaps :(float) _x :(float) _y :(NSObject*) _obj;
- (NSString*)  _uigesture_pan:(int) _state :(float) _x :(float) _y :(NSObject*) _obj;
- (NSString*)  _uigesture_pinch:(float) _scale :(float) _velocity :(int) _state :(float) _x :(float) _y :(NSObject*) _obj;
- (NSString*)  _uigesture_rotation:(float) _rotation :(float) _velocity :(int) _state :(float) _x :(float) _y :(NSObject*) _obj;
- (NSString*)  _uigesture_screenedgepan:(int) _state :(int) _edge :(float) _x :(float) _y :(NSObject*) _obj;
- (NSString*)  _uigesture_swipe:(int) _state :(int) _direction :(float) _x :(float) _y :(NSObject*) _obj;
- (NSString*)  _uigesture_tap:(int) _state :(int) _numtaps :(int) _numtouch :(float) _x :(float) _y :(NSObject*) _obj;
@end
@interface _pinch_attributes:NSObject
{
@public BOOL _IsInitialized;
@public float _Velocity;
@public float _Scale;
@public float _X;
@public float _Y;
@public NSObject* _Obj;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)float Velocity;
@property (nonatomic)float Scale;
@property (nonatomic)float X;
@property (nonatomic)float Y;
@property (nonatomic)NSObject* Obj;
-(void)Initialize;
@end
@interface _rotation_attributes:NSObject
{
@public BOOL _IsInitialized;
@public float _Velocity;
@public float _Rotation;
@public float _X;
@public float _Y;
@public NSObject* _Obj;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)float Velocity;
@property (nonatomic)float Rotation;
@property (nonatomic)float X;
@property (nonatomic)float Y;
@property (nonatomic)NSObject* Obj;
-(void)Initialize;
@end
@interface _swipe_attributes:NSObject
{
@public BOOL _IsInitialized;
@public int _Direction;
@public float _X;
@public float _Y;
@public NSObject* _Obj;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)int Direction;
@property (nonatomic)float X;
@property (nonatomic)float Y;
@property (nonatomic)NSObject* Obj;
-(void)Initialize;
@end
@interface _screenedgepan_attributes:NSObject
{
@public BOOL _IsInitialized;
@public int _Edge;
@public float _X;
@public float _Y;
@public NSObject* _Obj;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)int Edge;
@property (nonatomic)float X;
@property (nonatomic)float Y;
@property (nonatomic)NSObject* Obj;
-(void)Initialize;
@end
@interface _tap_attributes:NSObject
{
@public BOOL _IsInitialized;
@public int _NumberOfTaps;
@public int _NumberOfTouch;
@public float _X;
@public float _Y;
@public NSObject* _Obj;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)int NumberOfTaps;
@property (nonatomic)int NumberOfTouch;
@property (nonatomic)float X;
@property (nonatomic)float Y;
@property (nonatomic)NSObject* Obj;
-(void)Initialize;
@end
@interface _longpress_attributes:NSObject
{
@public BOOL _IsInitialized;
@public int _NumberOfTaps;
@public int _NumberOfTouch;
@public float _X;
@public float _Y;
@public NSObject* _Obj;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)int NumberOfTaps;
@property (nonatomic)int NumberOfTouch;
@property (nonatomic)float X;
@property (nonatomic)float Y;
@property (nonatomic)NSObject* Obj;
-(void)Initialize;
@end
@interface _pan_attributes:NSObject
{
@public BOOL _IsInitialized;
@public float _X;
@public float _Y;
@public NSObject* _Obj;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)float X;
@property (nonatomic)float Y;
@property (nonatomic)NSObject* Obj;
-(void)Initialize;
@end
@interface _gpoint:NSObject
{
@public BOOL _IsInitialized;
@public float _X;
@public float _Y;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)float X;
@property (nonatomic)float Y;
-(void)Initialize;
@end

#import "iCore.h"
#import "iXUI.h"
#import "iSD_CreativeBackground.h"
@class _typeed;
@class _type_singlekey;
@class b4i_customkey;
@class _pinch_attributes;
@class _rotation_attributes;
@class _swipe_attributes;
@class _screenedgepan_attributes;
@class _tap_attributes;
@class _longpress_attributes;
@class _pan_attributes;
@class _gpoint;
@class b4i_gesturerecognizer;
@interface b4i_sd_keyboard : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4XViewWrapper* __extrapanel;
@public NSObject* __tag;
@public B4IXUI* __xui;
@public B4XBitmapWrapper* __imagebg;
@public B4XCanvas* __can;
@public NSString* __keyshiftup;
@public NSString* __keyshiftdown;
@public NSString* __keyshiftlock;
@public NSString* __keycanc;
@public NSString* __keydel;
@public NSString* __keytab;
@public NSString* __keynext;
@public NSString* __keyenter;
@public NSString* __keyeraseall;
@public B4IMap* __mapview;
@public NSObject* __lastview;
@public int __heightrow;
@public int __widhtsize;
@public int __kbackground;
@public int __keycolor;
@public int __keytextcolor;
@public int __between;
@public int __cornerradius;
@public int __cornersize;
@public int __cornercolor;
@public BOOL __autoclose;
@public BOOL __key3d;
@public B4XFont* __kfont;
@public B4XFont* __skfont;
@public int __textsize;
@public BOOL __vibrate;
@public b4i_shadoweffectbackground* __seb;
@public NSString* __typekey;
@public int __timelapsemillisec;
@public BOOL __insertalwaysatend;
@public long long __lastupcase;
@public int __timeupcase;
@public int __recursive;
@public BOOL __inverse;
@public BOOL __fontloaded;
@public B4IPanelWrapper* __root_panel;
@public B4INativeObject* __feedbackgenerator;
@public BOOL __demo;
@public B4XViewWrapper* __xlbl;

}- (NSString*)  _activate:(int) _code;
- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _bkgv:(B4XViewWrapper*) _v :(int) _kc;
- (B4IResumableSubWrapper*)  _bkgvinverte:(B4XViewWrapper*) _v;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4XViewWrapper* _extrapanel;
@property (nonatomic)NSObject* _tag;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)B4XBitmapWrapper* _imagebg;
@property (nonatomic)B4XCanvas* _can;
@property (nonatomic)NSString* _keyshiftup;
@property (nonatomic)NSString* _keyshiftdown;
@property (nonatomic)NSString* _keyshiftlock;
@property (nonatomic)NSString* _keycanc;
@property (nonatomic)NSString* _keydel;
@property (nonatomic)NSString* _keytab;
@property (nonatomic)NSString* _keynext;
@property (nonatomic)NSString* _keyenter;
@property (nonatomic)NSString* _keyeraseall;
@property (nonatomic)B4IMap* _mapview;
@property (nonatomic)NSObject* _lastview;
@property (nonatomic)int _heightrow;
@property (nonatomic)int _widhtsize;
@property (nonatomic)int _kbackground;
@property (nonatomic)int _keycolor;
@property (nonatomic)int _keytextcolor;
@property (nonatomic)int _between;
@property (nonatomic)int _cornerradius;
@property (nonatomic)int _cornersize;
@property (nonatomic)int _cornercolor;
@property (nonatomic)BOOL _autoclose;
@property (nonatomic)BOOL _key3d;
@property (nonatomic)B4XFont* _kfont;
@property (nonatomic)B4XFont* _skfont;
@property (nonatomic)int _textsize;
@property (nonatomic)BOOL _vibrate;
@property (nonatomic)b4i_shadoweffectbackground* _seb;
@property (nonatomic)NSString* _typekey;
@property (nonatomic)int _timelapsemillisec;
@property (nonatomic)BOOL _insertalwaysatend;
@property (nonatomic)long long _lastupcase;
@property (nonatomic)int _timeupcase;
@property (nonatomic)int _recursive;
@property (nonatomic)BOOL _inverse;
@property (nonatomic)BOOL _fontloaded;
@property (nonatomic)B4IPanelWrapper* _root_panel;
@property (nonatomic)B4INativeObject* _feedbackgenerator;
@property (nonatomic)BOOL _demo;
@property (nonatomic)B4XViewWrapper* _xlbl;
- (NSString*)  _clearkeyboard;
- (void)  _closekeyboard;
- (B4XViewWrapper*)  _createkey:(NSString*) _name :(int) _keycode;
- (void)  _delaycallsub:(NSString*) _eventname;
- (void)  _delaycallsub1:(NSString*) _eventname :(NSObject*) _argument;
- (void)  _delaycallsub2:(NSString*) _eventname :(NSObject*) _argument1 :(NSObject*) _argument2 :(NSString*) _textdigit;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (NSString*)  _draw:(B4XViewWrapper*) _v;
- (NSString*)  _drawkeyboard:(B4XViewWrapper*) _v;
- (NSObject*)  _eventsender;
- (NSString*)  _extrapanel_touch:(int) _action :(float) _x :(float) _y;
- (B4XViewWrapper*)  _getbase;
- (float)  _getdarkfactor;
- (int)  _getheight;
- (int)  _getleft;
- (float)  _getlightfactor;
- (BOOL)  _getshowkeyboard;
- (int)  _gettop;
- (BOOL)  _getvisible;
- (int)  _getwidth;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _invalidate;
- (NSString*)  _key_longpress:(B4XViewWrapper*) _b;
- (void)  _key_press:(B4XViewWrapper*) _b;
- (void)  _complete:(BOOL) _success;
- (NSString*)  _keypress_click;
- (NSString*)  _keypress_longclick;
- (void)  _keypress_tap:(int) _stato :(_tap_attributes*) _att;
- (NSString*)  _menualternative:(_type_singlekey*) _singlekey;
- (NSString*)  _setdarkfactor:(float) _f;
- (NSString*)  _setevent:(B4ITextFieldWrapper*) _view :(_typeed*) _te;
- (NSString*)  _setfont:(B4XFont*) _f;
- (NSString*)  _setheight:(int) _b;
- (NSString*)  _setimagebackground:(B4XBitmapWrapper*) _img;
- (NSString*)  _setkeyboard:(B4XViewWrapper*) _texteditorview :(NSString*) _nativeeventname :(b4i_customkey*) _customizekeyboard :(BOOL) _shifton :(B4XViewWrapper*) _nextfocus;
- (NSString*)  _setkeystyle:(int) _v;
- (NSString*)  _setleft:(int) _b;
- (NSString*)  _setlightfactor:(float) _f;
- (NSString*)  _setroot:(B4IPanelWrapper*) _rootpane;
- (NSString*)  _setshowkeyboard:(BOOL) _b;
- (NSString*)  _setspecialkeyfont:(B4XFont*) _f;
- (NSString*)  _settop:(int) _b;
- (NSString*)  _setupcolor:(int) _backgroundcolorkey :(int) _textcolorkey :(int) _backgroundcolorboard;
- (NSString*)  _setvisible:(BOOL) _b;
- (NSString*)  _setwidth:(int) _b;
- (NSString*)  _shifon:(BOOL) _s;
- (BOOL)  _shiftstatus;
- (B4XBitmapWrapper*)  _snapshot;
- (NSString*)  _specialfolder;
@end
@interface _typeed:NSObject
{
@public BOOL _IsInitialized;
@public NSString* _NativeEventName;
@public b4i_customkey* _ck;
@public B4XViewWrapper* _NextFocus;
@public int _Status;
@public int _InputType;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSString* NativeEventName;
@property (nonatomic)b4i_customkey* ck;
@property (nonatomic)B4XViewWrapper* NextFocus;
@property (nonatomic)int Status;
@property (nonatomic)int InputType;
-(void)Initialize;
@end

