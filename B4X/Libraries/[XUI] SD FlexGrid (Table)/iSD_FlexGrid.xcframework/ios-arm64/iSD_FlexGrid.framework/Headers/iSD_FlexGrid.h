#import <iCore/iCore.h>
#import <iXUI/iXUI.h>
#import <AVFoundation/AVFoundation.h>
@class _head_type;
@class _cell_type;
@class _flexorder_type;
@class b4i_flexgrid;
@class _parsednode;
@class _orderdata;
@interface b4i_eval : B4IClass
{
@public int __number_type;
@public int __operator_type;
@public _parsednode* __root;
@public int __parseindex;
@public B4IList* __nodes;
@public B4IMap* __operatorlevel;
@public BOOL __error;
@public b4i_flexgrid* __flexg;

}- (_parsednode*)  _buildtree;
- (double)  _calcsubexpression:(NSString*) _expr;
- (double)  _calculate:(NSString*) _expression;
- (NSString*)  _class_globals;
@property (nonatomic)int _number_type;
@property (nonatomic)int _operator_type;
@property (nonatomic)_parsednode* _root;
@property (nonatomic)int _parseindex;
@property (nonatomic)B4IList* _nodes;
@property (nonatomic)B4IMap* _operatorlevel;
@property (nonatomic)BOOL _error;
@property (nonatomic)b4i_flexgrid* _flexg;
- (_parsednode*)  _createnumbernode:(double) _d;
- (_parsednode*)  _createoperatornode:(NSString*) _operator;
- (double)  _evalhelper:(NSString*) _expr;
- (double)  _evalnode:(_parsednode*) _pn;
- (NSString*)  _initialize:(B4I*) _ba :(b4i_flexgrid*) _fg;
- (NSString*)  _prepareexpression:(NSString*) _expr;
- (_parsednode*)  _takenextnode;
@end
@interface _parsednode:NSObject
{
@public BOOL _IsInitialized;
@public NSString* _Operator;
@public _parsednode* _Left;
@public _parsednode* _Right;
@public int _NodeType;
@public double _Value;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSString* Operator;
@property (nonatomic)_parsednode* Left;
@property (nonatomic)_parsednode* Right;
@property (nonatomic)int NodeType;
@property (nonatomic)double Value;
-(void)Initialize;
@end
@interface _orderdata:NSObject
{
@public BOOL _IsInitialized;
@public int _Index;
@public int _Level;
@public int _Added;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)int Index;
@property (nonatomic)int Level;
@property (nonatomic)int Added;
-(void)Initialize;
@end

#import <iCore/iCore.h>
#import <iXUI/iXUI.h>
#import <AVFoundation/AVFoundation.h>
@class _head_type;
@class _cell_type;
@class _flexorder_type;
@class _parsednode;
@class _orderdata;
@class b4i_eval;
@interface b4i_flexgrid : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4XViewWrapper* __selectpanel;
@public B4XViewWrapper* __selectpaneldown;
@public B4IXUI* __xui;
@public B4XViewWrapper* __gray;
@public int __typeint;
@public int __typefloat;
@public int __typedouble;
@public int __typestring;
@public int __typecheck;
@public int __typeimage;
@public int __typebutton;
@public int __typelist;
@public int __edittextcolor;
@public int __editbackgroundcolor;
@public int __headerheight;
@public int __heightcell;
@public int __feeterheight;
@public BOOL __singleline;
@public int __colscount;
@public int __textcolor;
@public int __backgroundcolor;
@public BOOL __headvisible;
@public int __headtextcolor;
@public int __headbackgroundcolor;
@public BOOL __feetvisible;
@public int __feettextcolor;
@public int __feetbackgroundcolor;
@public int __bordercolor;
@public B4XFont* __fonttext;
@public B4XFont* __headerfonttext;
@public B4XFont* __feetfonttext;
@public BOOL __scrollbyuser;
@public B4IScrollView* __gridpanel;
@public B4IScrollView* __mainpanel;
@public B4IList* __headerlist;
@public B4IList* __listrow;
@public B4IList* __listheightrow;
@public int __widthsize;
@public B4IMap* __cellcustomize;
@public int __selcolstart;
@public int __selrowstart;
@public int __selcolend;
@public int __selrowend;
@public int __selleft;
@public int __seltop;
@public int __lastx;
@public int __lasty;
@public int __pleft;
@public int __ptop;
@public int __pright;
@public int __pbottom;

}- (NSString*)  _activeselectviewer;
- (NSString*)  _addrow:(B4IArray*) _cell :(BOOL) _refresh;
- (NSString*)  _addrow2:(B4IArray*) _cell :(int) _heightrow :(BOOL) _refresh;
- (NSString*)  _addrowat:(int) _index :(B4IArray*) _cell :(BOOL) _refresh;
- (NSString*)  _addrowcustomize:(B4IArray*) _cell :(int) _text_color :(int) _background_color :(B4XFont*) _textfont :(BOOL) _refresh;
- (NSString*)  _addtoparent:(B4XViewWrapper*) _parent :(int) _left :(int) _top :(int) _width :(int) _height :(int) _colsnumber;
- (NSString*)  _addview:(B4XViewWrapper*) _sc :(B4XViewWrapper*) _v :(int) _left :(int) _top :(int) _width :(int) _height;
- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _cell_click;
- (NSString*)  _cell_longclick;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4XViewWrapper* _selectpanel;
@property (nonatomic)B4XViewWrapper* _selectpaneldown;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)B4XViewWrapper* _gray;
@property (nonatomic)int _typeint;
@property (nonatomic)int _typefloat;
@property (nonatomic)int _typedouble;
@property (nonatomic)int _typestring;
@property (nonatomic)int _typecheck;
@property (nonatomic)int _typeimage;
@property (nonatomic)int _typebutton;
@property (nonatomic)int _typelist;
@property (nonatomic)int _edittextcolor;
@property (nonatomic)int _editbackgroundcolor;
@property (nonatomic)int _headerheight;
@property (nonatomic)int _heightcell;
@property (nonatomic)int _feeterheight;
@property (nonatomic)BOOL _singleline;
@property (nonatomic)int _colscount;
@property (nonatomic)int _textcolor;
@property (nonatomic)int _backgroundcolor;
@property (nonatomic)BOOL _headvisible;
@property (nonatomic)int _headtextcolor;
@property (nonatomic)int _headbackgroundcolor;
@property (nonatomic)BOOL _feetvisible;
@property (nonatomic)int _feettextcolor;
@property (nonatomic)int _feetbackgroundcolor;
@property (nonatomic)int _bordercolor;
@property (nonatomic)B4XFont* _fonttext;
@property (nonatomic)B4XFont* _headerfonttext;
@property (nonatomic)B4XFont* _feetfonttext;
@property (nonatomic)BOOL _scrollbyuser;
@property (nonatomic)B4IScrollView* _gridpanel;
@property (nonatomic)B4IScrollView* _mainpanel;
@property (nonatomic)B4IList* _headerlist;
@property (nonatomic)B4IList* _listrow;
@property (nonatomic)B4IList* _listheightrow;
@property (nonatomic)int _widthsize;
@property (nonatomic)B4IMap* _cellcustomize;
@property (nonatomic)int _selcolstart;
@property (nonatomic)int _selrowstart;
@property (nonatomic)int _selcolend;
@property (nonatomic)int _selrowend;
@property (nonatomic)int _selleft;
@property (nonatomic)int _seltop;
@property (nonatomic)int _lastx;
@property (nonatomic)int _lasty;
@property (nonatomic)int _pleft;
@property (nonatomic)int _ptop;
@property (nonatomic)int _pright;
@property (nonatomic)int _pbottom;
- (NSString*)  _clearrows;
- (NSString*)  _clearselection;
- (NSString*)  _colorscroll:(B4XViewWrapper*) _s :(int) _color;
- (NSString*)  _colorscrollpanel:(B4IScrollView*) _sc :(int) _color;
- (B4XViewWrapper*)  _createcell:(_head_type*) _head :(int) _height :(NSObject*) _cell :(int) _row :(int) _col :(int) _tc :(int) _bc :(B4XFont*) _fc;
- (_flexorder_type*)  _createflexorder_type:(NSObject*) _key :(NSObject*) _value;
- (void)  _creategrid:(int) _rowstart :(int) _rowend;
- (NSString*)  _createheaderandfeet;
- (NSString*)  _createrow:(B4IArray*) _cell :(int) _heightcolumn :(int) _row :(int) _top;
- (NSString*)  _deleterow:(int) _row;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (NSString*)  _editcell:(int) _row :(int) _col;
- (NSString*)  _editcellonsite:(int) _row :(int) _col;
- (NSString*)  _edittext_enterpressed;
- (NSString*)  _edittextonsite_endedit;
- (NSString*)  _edittextonsite_enterpressed;
- (NSString*)  _feet_click;
- (B4XViewWrapper*)  _findcell:(int) _row :(int) _col;
- (B4IMap*)  _get_padding:(B4XViewWrapper*) _v;
- (B4XViewWrapper*)  _getbase;
- (int)  _getcellbackgroundcolor:(int) _row :(int) _col;
- (B4IArray*)  _getcellcol:(int) _col;
- (NSObject*)  _getcellcontent:(int) _row :(int) _col;
- (B4IArray*)  _getcellrow:(int) _row;
- (int)  _getcelltextcolor:(int) _row :(int) _col;
- (B4XFont*)  _getcelltextfont:(int) _row :(int) _col;
- (NSObject*)  _getcellvalue:(int) _row :(int) _col;
- (int)  _getcolcount;
- (B4IArray*)  _getcolsname;
- (B4IArray*)  _getfootvalue;
- (BOOL)  _getheadvisible;
- (int)  _getheight;
- (int)  _getrowcount;
- (double)  _getscrollx;
- (double)  _getscrolly;
- (B4IArray*)  _getselectcell;
- (int)  _getselectedcolumnend;
- (int)  _getselectedcolumnstart;
- (int)  _getselectedrowend;
- (int)  _getselectedrowstart;
- (int)  _gettypecol:(int) _col;
- (int)  _getwidth;
- (NSString*)  _gray_touch:(int) _action :(float) _x :(float) _y;
- (NSString*)  _gridheight;
- (NSString*)  _gridpanel_scrollchanged:(int) _offsetx :(int) _offsety;
- (NSString*)  _head_click;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _invalidate;
- (NSString*)  _listbox_itemselected:(int) _column :(int) _row;
- (NSString*)  _mainpanel_scrollchanged:(int) _offsetx :(int) _offsety;
- (NSString*)  _redrawcell:(int) _row :(int) _col;
- (NSString*)  _redrawrow:(int) _row;
- (NSString*)  _removeallviews:(B4XViewWrapper*) _sc;
- (NSString*)  _removerow:(int) _row;
- (NSString*)  _resetcustomizecell:(int) _col :(int) _row;
- (int)  _searchincolumn:(NSString*) _text :(int) _col :(int) _fromrow :(BOOL) _exactly :(BOOL) _ignorecap;
- (B4IList*)  _searchincolumn2:(NSString*) _text :(int) _col :(int) _fromrow :(BOOL) _exactly :(BOOL) _ignorecap;
- (NSString*)  _selectcell:(int) _row :(int) _col :(BOOL) _mobile;
- (NSString*)  _selectcells:(int) _fromrow :(int) _fromcol :(int) _torow :(int) _tocol :(BOOL) _mobile;
- (NSString*)  _selectcol:(int) _col;
- (NSString*)  _selectpanel_touch:(int) _action :(float) _x :(float) _y;
- (NSString*)  _selectrow:(int) _row;
- (NSString*)  _selectviewer;
- (NSString*)  _set_padding:(B4XViewWrapper*) _v;
- (NSString*)  _setbackgroundcolor:(int) _color;
- (NSString*)  _setcellcustomize:(int) _row :(int) _col :(int) _text_color :(int) _background_color :(B4XFont*) _textfont;
- (NSString*)  _setcelllistindex:(int) _row :(int) _col :(int) _index;
- (NSString*)  _setcellvalue:(int) _row :(int) _col :(NSObject*) _value;
- (NSString*)  _setcolalignment:(int) _columnindex :(NSString*) _alignment;
- (NSString*)  _setcolcustomize:(int) _col :(int) _text_color :(int) _background_color :(B4XFont*) _textfont;
- (NSString*)  _setcolname:(int) _columnindex :(NSString*) _name;
- (NSString*)  _setcolorselectedarea:(int) _c;
- (NSString*)  _setcolorselectingarea:(int) _c;
- (NSString*)  _setcolsalignment:(B4IArray*) _alignment;
- (NSString*)  _setcolsname:(B4IArray*) _name;
- (NSString*)  _setcolsnumber:(int) _columnnumber;
- (NSString*)  _setcolstype:(B4IArray*) _typ;
- (NSString*)  _setcolswidth:(B4IArray*) _width;
- (NSString*)  _setcoltype:(int) _columnindex :(int) _typ;
- (NSString*)  _setcolwidth:(int) _columnindex :(int) _width;
- (NSString*)  _setdatarow:(int) _row :(B4IArray*) _cell;
- (NSString*)  _setdatarow2:(int) _row :(B4IArray*) _cell :(int) _heightrow;
- (NSString*)  _setfeetheight:(int) _height;
- (NSString*)  _setfont:(B4XFont*) _f;
- (NSString*)  _setfootcolvalue:(int) _col :(NSString*) _fv;
- (NSString*)  _setfootfont:(B4XFont*) _f;
- (NSString*)  _setfootvalue:(B4IArray*) _fv;
- (NSString*)  _setfootvisible:(BOOL) _b;
- (NSString*)  _setheaderalignment:(int) _col :(NSString*) _alignment;
- (NSString*)  _setheaderfont:(B4XFont*) _f;
- (NSString*)  _setheadervisible:(BOOL) _b;
- (NSString*)  _setheadheight:(int) _height;
- (void)  _setheight:(int) _h;
- (NSString*)  _setpadding:(int) _left :(int) _top :(int) _right :(int) _bottom;
- (NSString*)  _setrowcustomize:(int) _row :(int) _text_color :(int) _background_color :(B4XFont*) _textfont;
- (NSString*)  _setrowheight:(int) _indexrow :(int) _height;
- (NSString*)  _setrowsheight:(int) _height;
- (NSString*)  _setscrolltocol:(int) _c;
- (NSString*)  _setscrolltorow:(int) _r;
- (void)  _setscrollx:(double) _position;
- (void)  _setscrolly:(double) _position;
- (NSString*)  _setsingleline:(BOOL) _sline;
- (NSString*)  _settextorcsbuildertolabel:(B4XViewWrapper*) _lbl_or_button :(NSObject*) _text;
- (void)  _setwidth:(int) _w;
- (NSString*)  _sortforcol:(int) _column;
- (NSString*)  _switch_valuechanged:(BOOL) _value;
- (NSString*)  _totalpanelheigth;
@end
@interface _head_type:NSObject
{
@public BOOL _IsInitialized;
@public NSString* _Name;
@public NSString* _FeetString;
@public int _Width;
@public int _TP;
@public NSString* _HeaderAlignment;
@public NSString* _Alignment;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSString* Name;
@property (nonatomic)NSString* FeetString;
@property (nonatomic)int Width;
@property (nonatomic)int TP;
@property (nonatomic)NSString* HeaderAlignment;
@property (nonatomic)NSString* Alignment;
-(void)Initialize;
@end
@interface _cell_type:NSObject
{
@public BOOL _IsInitialized;
@public int _TextColor;
@public int _BackgroundColor;
@public B4XFont* _TextFont;
@public NSString* _Alignment;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)int TextColor;
@property (nonatomic)int BackgroundColor;
@property (nonatomic)B4XFont* TextFont;
@property (nonatomic)NSString* Alignment;
-(void)Initialize;
@end
@interface _flexorder_type:NSObject
{
@public BOOL _IsInitialized;
@public NSObject* _Key;
@public NSObject* _Value;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSObject* Key;
@property (nonatomic)NSObject* Value;
-(void)Initialize;
@end

