#import "iCore.h"
#import "iXUI.h"
#import "iBitmapCreator.h"
@class _point3d_type;
@class _point2d_type;
@class _type_polygon;
@class _touch_type;
@interface b4i_object3d : B4IClass
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

}- (b4i_object3d*)  _addarcx:(int) _id :(int) _startdegree :(int) _enddegree :(float) _x :(float) _y :(float) _z :(int) _r :(int) _bordercolor :(int) _fillcolor;
- (b4i_object3d*)  _addarcy:(int) _id :(int) _startdegree :(int) _enddegree :(float) _x :(float) _y :(float) _z :(int) _r :(int) _bordercolor :(int) _fillcolor;
- (b4i_object3d*)  _addarcz:(int) _id :(int) _startdegree :(int) _enddegree :(float) _x :(float) _y :(float) _z :(int) _r :(int) _bordercolor :(int) _fillcolor;
- (b4i_object3d*)  _addbitmapcreator:(int) _id :(b4i_bitmapcreator*) _bmc :(_point3d_type*) _p_topleft :(_point3d_type*) _p_topright :(_point3d_type*) _p_downleft :(_point3d_type*) _p_downright;
- (b4i_object3d*)  _addcube:(int) _id :(float) _x1 :(float) _y1 :(float) _z1 :(float) _x2 :(float) _y2 :(float) _z2 :(int) _bordercolor :(B4IArray*) _fillcolor;
- (b4i_object3d*)  _addimage:(int) _id :(B4XBitmapWrapper*) _image :(_point3d_type*) _p_topleft :(_point3d_type*) _p_topright :(_point3d_type*) _p_downleft :(_point3d_type*) _p_downright;
- (NSString*)  _addobj3d:(_type_polygon*) _obj3d;
- (b4i_object3d*)  _addpolygon:(int) _id :(B4IArray*) _pointlist :(int) _bordercolor :(int) _fillcolor;
- (b4i_object3d*)  _addrec:(int) _id :(float) _x1 :(float) _y1 :(float) _z1 :(float) _x2 :(float) _y2 :(float) _z2 :(int) _bordercolor :(int) _fillcolor;
- (b4i_object3d*)  _addspere:(int) _id_start :(float) _x :(float) _y :(float) _z :(int) _r :(int) _bordercolor :(int) _fillcolor;
- (b4i_object3d*)  _addspere2:(int) _idstart :(float) _x :(float) _y :(float) _z :(int) _r :(int) _bordercolor :(int) _fillcolor :(int) _startlatitude :(int) _stoplatitude :(int) _startlongitude :(int) _stoplongitude :(int) _orizontalstep :(int) _verticalstep;
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
- (_point3d_type*)  _ctp:(float) _x :(float) _y :(float) _z;
- (b4i_object3d*)  _cutobj:(B4IList*) _idlist;
- (int)  _depthcolor:(int) _clr :(int) _priority;
- (float)  _dimdp:(int) _z;
- (NSString*)  _drawline:(b4i_bitmapcreator*) _bc :(int) _x1 :(int) _y1 :(int) _x2 :(int) _y2 :(_argbcolor*) _acolor;
- (NSString*)  _drawpathempty:(b4i_bitmapcreator*) _bitmapview :(B4IList*) _pointlist :(int) _color;
- (NSString*)  _drawpathfill:(b4i_bitmapcreator*) _bitmapview :(B4IList*) _pointlist :(int) _color;
- (B4IList*)  _getlistobject;
- (B4IList*)  _getlistobjectfromid:(B4IList*) _idlist;
- (int)  _getobj3dcount;
- (NSString*)  _initialize:(B4I*) _ba;
- (BOOL)  _loadobiectj3d:(NSString*) _path :(NSString*) _filename;
- (NSString*)  _loadobjfile:(int) _id :(NSString*) _path :(NSString*) _filename :(int) _bordercolor :(int) _fillcolor :(int) _limitspolygon;
- (NSString*)  _loadstlfile:(int) _id :(NSString*) _path :(NSString*) _filename :(int) _bordercolor :(int) _fillcolor :(float) _ratioofsize;
- (b4i_object3d*)  _moveobj:(B4IList*) _idlist :(int) _x :(int) _y :(int) _z;
- (int)  _pointclick:(int) _x :(int) _y :(BOOL) _advise;
- (BOOL)  _pointinside:(B4IList*) _listpoint :(float) _px :(float) _py;
- (B4IList*)  _pointtoview:(int) _id :(int) _idt :(int) _cx :(int) _cy :(_type_polygon*) _obj3d :(BOOL) _inserttotouch;
- (_point2d_type*)  _renderpoint:(_point3d_type*) _p;
- (NSString*)  _rendertoview:(B4XViewWrapper*) _v :(int) _centerx :(int) _centery :(float) _zoomvalue :(int) _drawmode;
- (NSString*)  _rendertoviewbitmapcreator:(B4XViewWrapper*) _v :(int) _centerx :(int) _centery;
- (NSString*)  _rendertoviewbitmapcreatordc:(B4XViewWrapper*) _v :(int) _centerx :(int) _centery;
- (NSString*)  _rendertoviewcanvas:(B4XViewWrapper*) _v :(int) _centerx :(int) _centery;
- (NSString*)  _rendertoviewcanvasdc:(B4XViewWrapper*) _v :(int) _centerx :(int) _centery;
- (NSString*)  _rendertoviewtraslucent:(B4XViewWrapper*) _v :(int) _centerx :(int) _centery;
- (b4i_object3d*)  _rotate:(B4IList*) _idlist :(int) _degreex :(int) _degreey :(int) _degreez;
- (b4i_object3d*)  _rotate2:(B4IList*) _idlist :(int) _degreex :(int) _degreey :(int) _degreez;
- (b4i_object3d*)  _rotatex:(B4IList*) _idlist :(int) _degree;
- (b4i_object3d*)  _rotatey:(B4IList*) _idlist :(int) _degree;
- (b4i_object3d*)  _rotatez:(B4IList*) _idlist :(int) _degree;
- (BOOL)  _saveobiectj3d:(NSString*) _path :(NSString*) _filename;
- (b4i_object3d*)  _setcolor:(B4IList*) _idlist :(int) _bordercolor :(int) _fillcolor;
- (NSString*)  _setvertices:(_point3d_type*) _originalvertices :(float) _x :(float) _y :(float) _z;
- (NSString*)  _trapezoidimage:(b4i_bitmapcreator*) _bmp :(b4i_bitmapcreator*) _bittrap :(_point2d_type*) _p1 :(_point2d_type*) _p2 :(_point2d_type*) _p3 :(_point2d_type*) _p4;
- (int)  _traspcolor:(int) _clr :(int) _z;
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

