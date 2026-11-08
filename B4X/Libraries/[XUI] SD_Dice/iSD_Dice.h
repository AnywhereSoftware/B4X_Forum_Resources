#import "iCore.h"
#import "iXUI.h"
#import "iBitmapCreator.h"
@class _point3d_type;
@class _point2d_type;
@class _type_polygon;
@class _touch_type;
@class b4i_diceview;
@interface b4i_dice3d : B4IClass
{
@public B4IXUI* __xui;
@public B4IList* __obj3dlist;
@public float __zoom;
@public BOOL __booleanpatterncache;
@public B4IList* __listverticesonscreen;
@public int __loadtime;
@public int __rotatetime;
@public int __sorttime;
@public int __drawtime;
@public int __light_intensity;

}- (b4i_dice3d*)  _addarcx:(int) _id :(int) _startdegree :(int) _enddegree :(float) _x :(float) _y :(float) _z :(int) _r :(int) _bordercolor :(int) _fillcolor;
- (b4i_dice3d*)  _addarcy:(int) _id :(int) _startdegree :(int) _enddegree :(float) _x :(float) _y :(float) _z :(int) _r :(int) _bordercolor :(int) _fillcolor;
- (b4i_dice3d*)  _addarcz:(int) _id :(int) _startdegree :(int) _enddegree :(float) _x :(float) _y :(float) _z :(int) _r :(int) _bordercolor :(int) _fillcolor;
- (NSString*)  _addobj3d:(_type_polygon*) _obj3d;
- (b4i_dice3d*)  _addpolygon:(int) _id :(B4IArray*) _pointlist :(int) _bordercolor :(int) _fillcolor;
- (b4i_dice3d*)  _addrec:(int) _id :(float) _x1 :(float) _y1 :(float) _z1 :(float) _x2 :(float) _y2 :(float) _z2 :(int) _bordercolor :(int) _fillcolor;
- (NSString*)  _addtouch:(int) _id :(int) _ido :(int) _x :(int) _y;
- (NSString*)  _class_globals;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)B4IList* _obj3dlist;
@property (nonatomic)float _zoom;
@property (nonatomic)BOOL _booleanpatterncache;
@property (nonatomic)B4IList* _listverticesonscreen;
@property (nonatomic)int _loadtime;
@property (nonatomic)int _rotatetime;
@property (nonatomic)int _sorttime;
@property (nonatomic)int _drawtime;
@property (nonatomic)int _light_intensity;
- (NSString*)  _clear;
- (NSString*)  _createdice:(double) _dimension :(int) _colordice :(int) _coloredge :(int) _colordot;
- (_point3d_type*)  _ctp:(float) _x :(float) _y :(float) _z;
- (int)  _depthcolor:(int) _clr :(int) _priority;
- (float)  _dimdp:(int) _z;
- (B4IList*)  _getlistobject;
- (B4IList*)  _getlistobjectfromid:(B4IList*) _idlist;
- (int)  _getobj3dcount;
- (NSString*)  _initialize:(B4I*) _ba;
- (b4i_dice3d*)  _moveobj:(B4IList*) _idlist :(int) _x :(int) _y :(int) _z;
- (B4IList*)  _pointtoview:(int) _id :(int) _idt :(int) _cx :(int) _cy :(_type_polygon*) _obj3d :(BOOL) _inserttotouch;
- (_point2d_type*)  _renderpoint:(_point3d_type*) _p;
- (NSString*)  _rendertoview:(B4XViewWrapper*) _v :(int) _centerx :(int) _centery :(float) _zoomvalue :(int) _limitvisibility;
- (NSString*)  _rendertoviewcanvasdc:(B4XViewWrapper*) _v :(int) _centerx :(int) _centery :(int) _limitvisibility;
- (b4i_dice3d*)  _rotate:(B4IList*) _idlist :(int) _degreex :(int) _degreey :(int) _degreez;
- (b4i_dice3d*)  _rotate2:(B4IList*) _idlist :(int) _degreex :(int) _degreey :(int) _degreez;
- (b4i_dice3d*)  _rotatex:(B4IList*) _idlist :(int) _degree;
- (b4i_dice3d*)  _rotatey:(B4IList*) _idlist :(int) _degree;
- (b4i_dice3d*)  _rotatez:(B4IList*) _idlist :(int) _degree;
- (b4i_dice3d*)  _setcolor:(B4IList*) _idlist :(int) _bordercolor :(int) _fillcolor;
- (NSString*)  _trapezoidimage:(b4i_bitmapcreator*) _bmp :(b4i_bitmapcreator*) _bittrap :(_point2d_type*) _p1 :(_point2d_type*) _p2 :(_point2d_type*) _p3 :(_point2d_type*) _p4;
@end
@interface _point3d_type:NSObject
{
@public BOOL _IsInitialized;
@public float _X;
@public float _Y;
@public float _Z;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)float X;
@property (nonatomic)float Y;
@property (nonatomic)float Z;
-(void)Initialize;
@end
@interface _point2d_type:NSObject
{
@public BOOL _IsInitialized;
@public int _X;
@public int _Y;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)int X;
@property (nonatomic)int Y;
-(void)Initialize;
@end
@interface _type_polygon:NSObject
{
@public BOOL _IsInitialized;
@public int _ID;
@public BOOL _Image;
@public b4i_bitmapcreator* _BC;
@public int _FillColor;
@public int _BorderColor;
@public int _Priority;
@public B4IList* _ListVertices;
@public B4IList* _PointView;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)int ID;
@property (nonatomic)BOOL Image;
@property (nonatomic)b4i_bitmapcreator* BC;
@property (nonatomic)int FillColor;
@property (nonatomic)int BorderColor;
@property (nonatomic)int Priority;
@property (nonatomic)B4IList* ListVertices;
@property (nonatomic)B4IList* PointView;
-(void)Initialize;
@end
@interface _touch_type:NSObject
{
@public BOOL _IsInitialized;
@public int _ID;
@public int _IDo;
@public int _X;
@public int _Y;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)int ID;
@property (nonatomic)int IDo;
@property (nonatomic)int X;
@property (nonatomic)int Y;
-(void)Initialize;
@end

#import "iCore.h"
#import "iXUI.h"
#import "iBitmapCreator.h"
@class _point3d_type;
@class _point2d_type;
@class _type_polygon;
@class _touch_type;
@class b4i_dice3d;
@interface b4i_diceview : B4IClass
{
@public NSString* __meventname;
@public NSObject* __mcallback;
@public B4XViewWrapper* __mbase;
@public B4IXUI* __xui;
@public NSObject* __tag;
@public b4i_dice3d* __p3d;
@public double __dimension;
@public int __colordice;
@public int __coloredge;
@public int __colordot;
@public B4XViewWrapper* __pan;
@public double __propsize;
@public int __timemovment;

}- (NSString*)  _base_resize:(double) _width :(double) _height;
- (NSString*)  _class_globals;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)B4XViewWrapper* _mbase;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)NSObject* _tag;
@property (nonatomic)b4i_dice3d* _p3d;
@property (nonatomic)double _dimension;
@property (nonatomic)int _colordice;
@property (nonatomic)int _coloredge;
@property (nonatomic)int _colordot;
@property (nonatomic)B4XViewWrapper* _pan;
@property (nonatomic)double _propsize;
@property (nonatomic)int _timemovment;
- (NSString*)  _designercreateview:(NSObject*) _base :(B4ILabelWrapper*) _lbl :(B4IMap*) _props;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _move:(int) _x :(int) _y :(int) _z;
- (NSString*)  _panel_click;
- (void)  _rollto:(int) _facenumber;
- (NSString*)  _rotate:(int) _degreex :(int) _degreey :(int) _degreez;
@end

