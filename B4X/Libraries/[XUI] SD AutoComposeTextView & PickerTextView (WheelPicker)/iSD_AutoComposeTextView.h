#import "iCore.h"
#import "iXUI.h"
#import "iSQL.h"
@class b4i_pickertextview;
@interface b4i_autocomposetextview : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public B4IList* __find;
@public B4XViewWrapper* __textview;
@public B4XViewWrapper* __listview;
@public int __startpos;
@public int __heighttextview;
@public int __maxfind;
@public float __velocity;
@public BOOL __fromuser;
@public float __firsty;
@public B4ISQL* __db;
@public NSString* __table;
@public NSString* __field;
@public BOOL __searchstartwith;

}- (NSString*)  _additems:(B4IList*) _items;
- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _bringtofront;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)B4IList* _find;
@property (nonatomic)B4XViewWrapper* _textview;
@property (nonatomic)B4XViewWrapper* _listview;
@property (nonatomic)int _startpos;
@property (nonatomic)int _heighttextview;
@property (nonatomic)int _maxfind;
@property (nonatomic)float _velocity;
@property (nonatomic)BOOL _fromuser;
@property (nonatomic)float _firsty;
@property (nonatomic)B4ISQL* _db;
@property (nonatomic)NSString* _table;
@property (nonatomic)NSString* _field;
@property (nonatomic)BOOL _searchstartwith;
- (NSString*)  _clearitems;
- (B4XViewWrapper*)  _createlabel:(NSString*) _text;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (int)  _getcolor;
- (int)  _getheight;
- (int)  _getleft;
- (NSObject*)  _gettext;
- (int)  _gettextcolor;
- (int)  _gettop;
- (BOOL)  _getvisible;
- (int)  _getwidth;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _initializeinternaldb;
- (NSString*)  _listview_touch:(int) _action :(float) _x :(float) _y;
- (void)  _populatedb:(B4IList*) _l;
- (void)  _sql_nonquerycomplete:(BOOL) _success;
- (NSString*)  _removeviewfromparent;
- (NSString*)  _requestfocus;
- (void)  _searchtext:(NSString*) _new;
- (void)  _sql_querycomplete:(BOOL) _success :(B4IResultSet*) _rs;
- (NSString*)  _sendtoback;
- (NSString*)  _setcolor:(int) _c;
- (NSString*)  _setfont:(B4XFont*) _f;
- (NSString*)  _setheight:(int) _b;
- (NSString*)  _setitems:(B4IList*) _items;
- (NSString*)  _setitemsfromsqlite:(NSString*) _folder :(NSString*) _filename :(NSString*) _tablename :(NSString*) _fieldname;
- (NSString*)  _setlayoutanimated:(int) _duration :(int) _left :(int) _top :(int) _width :(int) _height;
- (NSString*)  _setleft:(int) _b;
- (NSString*)  _settext:(NSString*) _s;
- (NSString*)  _settextcolor:(int) _c;
- (NSString*)  _settop:(int) _b;
- (NSString*)  _setvisible:(BOOL) _b;
- (NSString*)  _setwidth:(int) _b;
- (NSString*)  _textview_enterpressed;
- (NSString*)  _textview_focuschanged:(BOOL) _hasfocus;
- (NSString*)  _textview_textchanged:(NSString*) _old :(NSString*) _new;
- (NSString*)  _update;
@end

#import "iCore.h"
#import "iXUI.h"
#import "iSQL.h"
@class b4i_autocomposetextview;
@interface b4i_pickertextview : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public NSString* __alignm;
@public B4XViewWrapper* __textview;
@public B4XViewWrapper* __listview;
@public int __startpos;
@public float __fontsize;
@public int __heighttextview;
@public float __velocity;
@public float __firsty;
@public B4IList* __listdic;

}- (NSString*)  _add:(NSString*) _element;
- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _bringtofront;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)NSString* _alignm;
@property (nonatomic)B4XViewWrapper* _textview;
@property (nonatomic)B4XViewWrapper* _listview;
@property (nonatomic)int _startpos;
@property (nonatomic)float _fontsize;
@property (nonatomic)int _heighttextview;
@property (nonatomic)float _velocity;
@property (nonatomic)float _firsty;
@property (nonatomic)B4IList* _listdic;
- (NSString*)  _clearitems;
- (B4XViewWrapper*)  _createlabel:(NSString*) _text;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (NSString*)  _getalign;
- (int)  _getcolor;
- (int)  _getheight;
- (int)  _getleft;
- (int)  _getselectedindex;
- (NSString*)  _getselecteditem;
- (NSObject*)  _gettext;
- (int)  _gettextcolor;
- (int)  _gettop;
- (BOOL)  _getvisible;
- (int)  _getwidth;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _listview_touch:(int) _action :(float) _x :(float) _y;
- (NSString*)  _removeviewfromparent;
- (NSString*)  _requestfocus;
- (NSString*)  _sendtoback;
- (NSString*)  _setalign:(NSString*) _alignment;
- (NSString*)  _setcolor:(int) _c;
- (NSString*)  _setfont:(B4XFont*) _f;
- (NSString*)  _setheight:(int) _b;
- (NSString*)  _setitems:(B4IList*) _items;
- (NSString*)  _setlayoutanimated:(int) _duration :(int) _left :(int) _top :(int) _width :(int) _height;
- (NSString*)  _setleft:(int) _b;
- (NSString*)  _setselectedindex:(int) _pos;
- (NSString*)  _settext:(NSString*) _s;
- (NSString*)  _settextcolor:(int) _c;
- (NSString*)  _settop:(int) _b;
- (NSString*)  _setvisible:(BOOL) _b;
- (NSString*)  _setwidth:(int) _b;
- (NSString*)  _textview_click;
- (NSString*)  _update;
@end

