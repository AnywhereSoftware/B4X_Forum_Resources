#import "iCore.h"
#import "iSD_CreativeBackground.h"
#import "iXUI.h"
#import "iBitmapCreator.h"
@class b4i_b4xtrimmer;
@class _type_itemlist;
@class b4i_xlistview;
@class _type_itemgrid;
@class b4i_xgridlistview;
@interface b4i_b4xrangeseekbar : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public int __color_base;
@public int __color_level;
@public int __color_stick;
@public float __min_value;
@public float __max_value;
@public float __minlimit;
@public float __maxlimit;
@public BOOL __vertical;
@public NSObject* __tag;
@public B4IPanelWrapper* __panelvalue;

}- (NSString*)  _addtoparent:(B4XViewWrapper*) _paneltoadd :(int) _left :(int) _top :(int) _width :(int) _height;
- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _bringtofront;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)int _color_base;
@property (nonatomic)int _color_level;
@property (nonatomic)int _color_stick;
@property (nonatomic)float _min_value;
@property (nonatomic)float _max_value;
@property (nonatomic)float _minlimit;
@property (nonatomic)float _maxlimit;
@property (nonatomic)BOOL _vertical;
@property (nonatomic)NSObject* _tag;
@property (nonatomic)B4IPanelWrapper* _panelvalue;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (B4IPanelWrapper*)  _getbase;
- (BOOL)  _getenable;
- (int)  _getheight;
- (int)  _getleft;
- (float)  _getmaxrange;
- (float)  _getmaxvalue;
- (float)  _getminrange;
- (float)  _getminvalue;
- (int)  _gettop;
- (B4XViewWrapper*)  _getview:(int) _index;
- (BOOL)  _getvisible;
- (int)  _getwidth;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _panelvalue_touch:(int) _action :(float) _x :(float) _y;
- (NSString*)  _redraw;
- (NSString*)  _removeviewfromparent;
- (NSString*)  _requestfocus;
- (NSString*)  _resetevent:(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _rotate:(float) _anglex :(float) _angley :(float) _anglez;
- (NSString*)  _sendtoback;
- (NSString*)  _setcolorbase:(int) _c;
- (NSString*)  _setcolorlevel:(int) _c;
- (NSString*)  _setcolorstick:(int) _c;
- (NSString*)  _setenable:(BOOL) _b;
- (NSString*)  _setheight:(int) _b;
- (NSString*)  _setleft:(int) _b;
- (NSString*)  _setmaxrange:(int) _v;
- (NSString*)  _setmaxvalue:(float) _v;
- (NSString*)  _setminrange:(int) _v;
- (NSString*)  _setminvalue:(float) _v;
- (NSString*)  _settop:(int) _b;
- (NSString*)  _setvisible:(BOOL) _b;
- (NSString*)  _setwidth:(int) _b;
- (B4XViewWrapper*)  _snapshot;
@end

#import "iCore.h"
#import "iSD_CreativeBackground.h"
#import "iXUI.h"
#import "iBitmapCreator.h"
@class b4i_b4xrangeseekbar;
@class _type_itemlist;
@class b4i_xlistview;
@class _type_itemgrid;
@class b4i_xgridlistview;
@interface b4i_b4xtrimmer : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public int __colorbase;
@public int __colortrimmer;
@public int __colorlevel;
@public B4IPanelWrapper* __panelvalue;
@public int __dimdip;
@public int __myvalue;
@public int __stroke;
@public int __ball;
@public int __spacement;
@public int __lastvalue;
@public int __lighttrasparence;
@public int __midlelighttrasparence;
@public b4i_bitmapcreator* __bc;
@public B4IList* __listcircle;
@public NSObject* __tag;

}- (B4XBitmapWrapper*)  _background;
- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)int _colorbase;
@property (nonatomic)int _colortrimmer;
@property (nonatomic)int _colorlevel;
@property (nonatomic)B4IPanelWrapper* _panelvalue;
@property (nonatomic)int _dimdip;
@property (nonatomic)int _myvalue;
@property (nonatomic)int _stroke;
@property (nonatomic)int _ball;
@property (nonatomic)int _spacement;
@property (nonatomic)int _lastvalue;
@property (nonatomic)int _lighttrasparence;
@property (nonatomic)int _midlelighttrasparence;
@property (nonatomic)b4i_bitmapcreator* _bc;
@property (nonatomic)B4IList* _listcircle;
@property (nonatomic)NSObject* _tag;
- (NSString*)  _createcircle;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (NSString*)  _draw;
- (B4IPanelWrapper*)  _getbase;
- (int)  _getvalue;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _panelvalue_touch:(int) _action :(float) _x :(float) _y;
- (NSString*)  _rotate:(float) _anglex :(float) _angley :(float) _anglez;
- (NSString*)  _setvalue:(int) _v;
- (int)  _traspercolor:(int) _mycolor :(float) _factor :(int) _trasparence;
@end

#import "iCore.h"
#import "iSD_CreativeBackground.h"
#import "iXUI.h"
#import "iBitmapCreator.h"
@class b4i_b4xrangeseekbar;
@class b4i_b4xtrimmer;
@class _type_itemlist;
@class b4i_xlistview;
@class _type_itemgrid;
@interface b4i_xgridlistview : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public int __textcolor;
@public int __secondlinecolor;
@public int __infotextcolor;
@public int __backgroundcolor;
@public int __itembackgroundcolor;
@public int __itembordercolor;
@public b4i_gradientbackground* __gb;
@public B4XCanvas* __can;
@public int __widthitem;
@public int __heightitem;
@public int __stepitem;
@public int __timeanimation;
@public B4XFont* __textfont;
@public NSString* __textalignment;
@public NSString* __secondlinealignment;
@public B4XFont* __secondlinefont;
@public B4XFont* __infofont;
@public int __lateralbar;
@public int __border;
@public int __borderwidth;
@public int __borderdistance;
@public int __shadow;
@public int __roundeditem;
@public float __percfirstrow;
@public float __percsecondrow;
@public B4IList* __lista;
@public B4IScrollView* __scrollnativa;
@public B4XViewWrapper* __scroll;
@public B4XViewWrapper* __pan;

}- (NSString*)  _add:(NSString*) _text :(NSString*) _secondline :(NSString*) _info :(NSObject*) _id;
- (NSString*)  _additem:(_type_itemgrid*) _item :(int) _pos;
- (NSString*)  _addwithimage:(NSString*) _text :(NSString*) _secondline :(NSString*) _info :(NSObject*) _id :(B4XBitmapWrapper*) _image :(BOOL) _imagetoright;
- (void)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)int _textcolor;
@property (nonatomic)int _secondlinecolor;
@property (nonatomic)int _infotextcolor;
@property (nonatomic)int _backgroundcolor;
@property (nonatomic)int _itembackgroundcolor;
@property (nonatomic)int _itembordercolor;
@property (nonatomic)b4i_gradientbackground* _gb;
@property (nonatomic)B4XCanvas* _can;
@property (nonatomic)int _widthitem;
@property (nonatomic)int _heightitem;
@property (nonatomic)int _stepitem;
@property (nonatomic)int _timeanimation;
@property (nonatomic)B4XFont* _textfont;
@property (nonatomic)NSString* _textalignment;
@property (nonatomic)NSString* _secondlinealignment;
@property (nonatomic)B4XFont* _secondlinefont;
@property (nonatomic)B4XFont* _infofont;
@property (nonatomic)int _lateralbar;
@property (nonatomic)int _border;
@property (nonatomic)int _borderwidth;
@property (nonatomic)int _borderdistance;
@property (nonatomic)int _shadow;
@property (nonatomic)int _roundeditem;
@property (nonatomic)float _percfirstrow;
@property (nonatomic)float _percsecondrow;
@property (nonatomic)B4IList* _lista;
@property (nonatomic)B4IScrollView* _scrollnativa;
@property (nonatomic)B4XViewWrapper* _scroll;
@property (nonatomic)B4XViewWrapper* _pan;
- (NSString*)  _clear;
- (B4XViewWrapper*)  _creaimage:(B4XBitmapWrapper*) _b;
- (B4XViewWrapper*)  _crealabel:(NSString*) _text :(int) _tcolor :(B4XFont*) _fnt :(NSString*) _alignment :(NSObject*) _tag;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (int)  _findlighterordarkercolor:(int) _mycolor :(float) _factor;
- (B4XViewWrapper*)  _getbase;
- (int)  _getelementbackgroundcolor;
- (int)  _getheight;
- (int)  _getindexfromid:(NSObject*) _id;
- (int)  _getindexfromvalue:(NSObject*) _value;
- (NSString*)  _getinfo:(NSObject*) _value;
- (NSString*)  _getinfofromindex:(int) _index;
- (int)  _getitemcornerradius;
- (int)  _getitemcornerwidth;
- (int)  _getitemheight;
- (int)  _getitemwidth;
- (int)  _getlatelarbarwidth;
- (int)  _getleft;
- (int)  _getmaxcol;
- (NSString*)  _getsecondline:(NSObject*) _value;
- (NSString*)  _getsecondlinefromindex:(int) _index;
- (int)  _getsize;
- (NSObject*)  _gettag;
- (NSString*)  _gettext:(NSObject*) _value;
- (NSString*)  _gettextfromindex:(int) _index;
- (int)  _gettop;
- (NSObject*)  _getvaluefromindex:(int) _index;
- (int)  _getwidth;
- (int)  _getwidthbetweenitem;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _insertat:(int) _position :(NSString*) _text :(NSString*) _info :(NSObject*) _id;
- (NSString*)  _insertwithimageat:(int) _position :(NSString*) _text :(NSString*) _secondline :(NSString*) _info :(NSObject*) _id :(B4XBitmapWrapper*) _image :(BOOL) _imagetoright;
- (NSString*)  _invalidate;
- (NSString*)  _item_click;
- (NSString*)  _item_longclick;
- (NSString*)  _redispose;
- (NSString*)  _removeat:(int) _pos;
- (NSString*)  _scrolltobottom;
- (NSString*)  _setcol:(int) _n;
- (NSString*)  _setelementbackgroundcolor:(int) _c;
- (NSString*)  _setheight:(int) _v;
- (NSString*)  _setinfo:(NSObject*) _id :(NSString*) _text;
- (NSString*)  _setitemcornerradius:(int) _v;
- (NSString*)  _setitemcornerwidth:(int) _v;
- (NSString*)  _setitemheight:(int) _v;
- (NSString*)  _setitemwidth:(int) _v;
- (NSString*)  _setlatelarbarwidth:(int) _l;
- (NSString*)  _setleft:(int) _v;
- (NSString*)  _setsecondline:(NSObject*) _id :(NSString*) _text;
- (NSString*)  _setsingleitemcolorbackground:(NSObject*) _id :(int) _color;
- (NSString*)  _settag:(NSObject*) _t;
- (NSString*)  _settext:(NSObject*) _id :(NSString*) _text;
- (NSString*)  _settop:(int) _v;
- (NSString*)  _setwidth:(int) _v;
- (NSString*)  _setwidthbetweenitem:(int) _v;
@end
@interface _type_itemgrid:NSObject
{
@public BOOL _IsInitialized;
@public NSString* _text;
@public NSString* _SecondLine;
@public NSString* _Info;
@public NSObject* _Value;
@public B4XBitmapWrapper* _Image;
@public int _inm;
@public B4XViewWrapper* _pbase;
@public B4XViewWrapper* _pshadow;
@public int _bc;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSString* text;
@property (nonatomic)NSString* SecondLine;
@property (nonatomic)NSString* Info;
@property (nonatomic)NSObject* Value;
@property (nonatomic)B4XBitmapWrapper* Image;
@property (nonatomic)int inm;
@property (nonatomic)B4XViewWrapper* pbase;
@property (nonatomic)B4XViewWrapper* pshadow;
@property (nonatomic)int bc;
-(void)Initialize;
@end

#import "iCore.h"
#import "iSD_CreativeBackground.h"
#import "iXUI.h"
#import "iBitmapCreator.h"
@class b4i_b4xrangeseekbar;
@class b4i_b4xtrimmer;
@class _type_itemlist;
@class _type_itemgrid;
@class b4i_xgridlistview;
@interface b4i_xlistview : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public int __textcolor;
@public int __secondlinecolor;
@public int __infotextcolor;
@public int __backgroundcolor;
@public int __itembackgroundcolor;
@public int __itembordercolor;
@public b4i_gradientbackground* __gb;
@public B4XCanvas* __can;
@public int __heightitem;
@public int __stepitem;
@public int __timeanimation;
@public B4XFont* __textfont;
@public NSString* __textalignment;
@public NSString* __secondlinealignment;
@public B4XFont* __secondlinefont;
@public B4XFont* __infofont;
@public int __lateralbar;
@public int __border;
@public int __borderwidth;
@public int __borderdistance;
@public int __shadow;
@public int __roundeditem;
@public B4IList* __lista;
@public B4IScrollView* __scrollnativa;
@public B4XViewWrapper* __scroll;
@public B4XViewWrapper* __pan;

}- (NSString*)  _add:(NSString*) _text :(NSString*) _secondline :(NSString*) _info :(NSObject*) _id;
- (NSString*)  _additem:(_type_itemlist*) _item :(int) _pos;
- (NSString*)  _addwithimage:(NSString*) _text :(NSString*) _secondline :(NSString*) _info :(NSObject*) _id :(B4XBitmapWrapper*) _image :(BOOL) _imagetoright;
- (void)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)int _textcolor;
@property (nonatomic)int _secondlinecolor;
@property (nonatomic)int _infotextcolor;
@property (nonatomic)int _backgroundcolor;
@property (nonatomic)int _itembackgroundcolor;
@property (nonatomic)int _itembordercolor;
@property (nonatomic)b4i_gradientbackground* _gb;
@property (nonatomic)B4XCanvas* _can;
@property (nonatomic)int _heightitem;
@property (nonatomic)int _stepitem;
@property (nonatomic)int _timeanimation;
@property (nonatomic)B4XFont* _textfont;
@property (nonatomic)NSString* _textalignment;
@property (nonatomic)NSString* _secondlinealignment;
@property (nonatomic)B4XFont* _secondlinefont;
@property (nonatomic)B4XFont* _infofont;
@property (nonatomic)int _lateralbar;
@property (nonatomic)int _border;
@property (nonatomic)int _borderwidth;
@property (nonatomic)int _borderdistance;
@property (nonatomic)int _shadow;
@property (nonatomic)int _roundeditem;
@property (nonatomic)B4IList* _lista;
@property (nonatomic)B4IScrollView* _scrollnativa;
@property (nonatomic)B4XViewWrapper* _scroll;
@property (nonatomic)B4XViewWrapper* _pan;
- (NSString*)  _clear;
- (B4XViewWrapper*)  _creaimage:(B4XBitmapWrapper*) _b;
- (B4XViewWrapper*)  _crealabel:(NSString*) _text :(int) _tcolor :(B4XFont*) _fnt :(NSString*) _alignment;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (int)  _findlighterordarkercolor:(int) _mycolor :(float) _factor;
- (B4XViewWrapper*)  _getbase;
- (int)  _getelementbackgroundcolor;
- (int)  _getheight;
- (int)  _getindexfromvalue:(NSObject*) _value;
- (NSString*)  _getinfo:(NSObject*) _value;
- (NSString*)  _getinfofromindex:(int) _index;
- (int)  _getitemcornerradius;
- (int)  _getitemcornerwidth;
- (int)  _getitemheight;
- (int)  _getleft;
- (NSString*)  _getsecondline:(NSObject*) _value;
- (NSString*)  _getsecondlinefromindex:(int) _index;
- (int)  _getsize;
- (NSObject*)  _gettag;
- (NSString*)  _gettext:(NSObject*) _value;
- (NSString*)  _gettextfromindex:(int) _index;
- (int)  _gettop;
- (NSObject*)  _getvaluefromindex:(int) _index;
- (int)  _getwidth;
- (int)  _getwidthbetweenitem;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _insertat:(int) _position :(NSString*) _text :(NSString*) _info :(NSObject*) _id;
- (NSString*)  _insertwithimageat:(int) _position :(NSString*) _text :(NSString*) _secondline :(NSString*) _info :(NSObject*) _id :(B4XBitmapWrapper*) _image :(BOOL) _imagetoright;
- (NSString*)  _invalidate;
- (NSString*)  _item_click;
- (NSString*)  _item_longclick;
- (NSString*)  _redispose;
- (NSString*)  _removeat:(int) _pos;
- (void)  _scrolltobottom;
- (NSString*)  _setelementbackgroundcolor:(int) _color;
- (NSString*)  _setheight:(int) _v;
- (NSString*)  _setitemcornerradius:(int) _v;
- (NSString*)  _setitemcornerwidth:(int) _v;
- (NSString*)  _setitemheight:(int) _v;
- (NSString*)  _setleft:(int) _v;
- (NSString*)  _settag:(NSObject*) _t;
- (NSString*)  _settop:(int) _v;
- (NSString*)  _setwidth:(int) _v;
- (NSString*)  _setwidthbetweenitem:(int) _v;
@end
@interface _type_itemlist:NSObject
{
@public BOOL _IsInitialized;
@public NSString* _text;
@public NSString* _SecondLine;
@public NSString* _Info;
@public NSObject* _Value;
@public B4XBitmapWrapper* _Image;
@public int _inm;
@public B4XViewWrapper* _pbase;
@public B4XViewWrapper* _pshadow;
@public int _bc;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSString* text;
@property (nonatomic)NSString* SecondLine;
@property (nonatomic)NSString* Info;
@property (nonatomic)NSObject* Value;
@property (nonatomic)B4XBitmapWrapper* Image;
@property (nonatomic)int inm;
@property (nonatomic)B4XViewWrapper* pbase;
@property (nonatomic)B4XViewWrapper* pshadow;
@property (nonatomic)int bc;
-(void)Initialize;
@end

