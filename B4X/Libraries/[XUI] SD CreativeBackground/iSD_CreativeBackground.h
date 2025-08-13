#import "iCore.h"
#import "iXUI.h"
#import "iBitmapCreator.h"
@class b4i_nativeshadow;
@class _sepoint;
@class b4i_shadoweffectbackground;
@interface b4i_gradientbackground : B4IClass
{
@public B4IXUI* __xui;
@public NSString* __fill_radial;
@public NSString* __fill_tr_bl;
@public NSString* __fill_tl_br;
@public NSString* __fill_bl_tr;
@public NSString* __fill_br_tl;
@public NSString* __fill_top_bottom;
@public NSString* __fill_bottom_top;
@public NSString* __fill_right_left;
@public NSString* __fill_left_right;

}- (NSString*)  _class_globals;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)NSString* _fill_radial;
@property (nonatomic)NSString* _fill_tr_bl;
@property (nonatomic)NSString* _fill_tl_br;
@property (nonatomic)NSString* _fill_bl_tr;
@property (nonatomic)NSString* _fill_br_tl;
@property (nonatomic)NSString* _fill_top_bottom;
@property (nonatomic)NSString* _fill_bottom_top;
@property (nonatomic)NSString* _fill_right_left;
@property (nonatomic)NSString* _fill_left_right;
- (NSString*)  _deletelateeffect:(B4XViewWrapper*) _vw;
- (B4XBitmapWrapper*)  _generategradient:(int) _width :(int) _height :(B4IArray*) _tintcolor :(NSString*) _fill :(int) _bordercolor :(float) _borderwidth;
- (B4XBitmapWrapper*)  _generategradientrounded:(int) _width :(int) _height :(B4IArray*) _tintcolor :(NSString*) _fill :(int) _bordercolor :(float) _borderwidth :(float) _cornerradius;
- (NSString*)  _gradienttoview:(B4XViewWrapper*) _vw :(B4IArray*) _tintcolor :(NSString*) _fill :(int) _bordercolor :(float) _borderwidth :(float) _cornerradius;
- (NSString*)  _initialize:(B4I*) _ba;
- (B4IArray*)  _patterncolor:(int) _patternnumber;
@end

#import "iCore.h"
#import "iXUI.h"
#import "iBitmapCreator.h"
@class b4i_gradientbackground;
@class _sepoint;
@class b4i_shadoweffectbackground;
@interface b4i_nativeshadow : B4IClass
{

}- (NSString*)  _class_globals;
- (NSString*)  _initialize:(B4I*) _ba;
- (NSString*)  _nativeshadowtoview:(B4XViewWrapper*) _vw :(float) _shadowswidth;
@end

#import "iCore.h"
#import "iXUI.h"
#import "iBitmapCreator.h"
@class b4i_gradientbackground;
@class b4i_nativeshadow;
@class _sepoint;
@interface b4i_shadoweffectbackground : B4IClass
{
@public B4IXUI* __xui;
@public NSString* __typerect;
@public NSString* __typehexagonshadow;
@public NSString* __typeheart;
@public NSString* __typedaisy4;
@public NSString* __typedaisy5;
@public NSString* __typedaisy8;
@public NSString* __typecomics;
@public float __darkfactor;
@public float __lightfactor;
@public int __softness;

}- (NSString*)  _class_globals;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)NSString* _typerect;
@property (nonatomic)NSString* _typehexagonshadow;
@property (nonatomic)NSString* _typeheart;
@property (nonatomic)NSString* _typedaisy4;
@property (nonatomic)NSString* _typedaisy5;
@property (nonatomic)NSString* _typedaisy8;
@property (nonatomic)NSString* _typecomics;
@property (nonatomic)float _darkfactor;
@property (nonatomic)float _lightfactor;
@property (nonatomic)int _softness;
- (B4IArray*)  _comicslist:(float) _width :(float) _height :(int) _depthedge :(int) _rcs;
- (NSString*)  _createpathshadow:(B4XCanvas*) _can :(B4IArray*) _listpoint :(int) _edge :(int) _fromcolor :(int) _upcolor :(int) _downcolor :(int) _expo :(float) _degree :(BOOL) _swapshadow;
- (NSString*)  _createshadow:(B4XCanvas*) _can :(int) _width :(int) _height :(int) _cornerradius :(int) _edge :(int) _fromcolor :(int) _upcolor :(int) _downcolor :(int) _expo :(int) _recursive :(BOOL) _swapshadow :(float) _degree;
- (B4IArray*)  _daisy4list:(float) _width :(float) _height :(int) _depthedge :(int) _rcs;
- (B4IArray*)  _daisy5list:(float) _width :(float) _height :(int) _depthedge :(int) _rcs;
- (B4IArray*)  _daisy8list:(float) _width :(float) _height :(int) _depthedge :(int) _rcs;
- (NSString*)  _deletelateeffect:(B4XViewWrapper*) _vw;
- (NSString*)  _effectbackgroundtoview:(B4XViewWrapper*) _vw :(NSString*) _effect :(BOOL) _invertshadow :(int) _color :(int) _depthedge :(int) _cornerradius :(int) _recursive :(BOOL) _alternateshadow;
- (B4IArray*)  _exagonlist:(float) _width :(float) _height :(int) _depthedge :(int) _rcs;
- (int)  _findlighterordarkercolor:(int) _mycolor :(float) _factor;
- (int)  _findsolidcolorbetween:(int) _colora :(int) _colorb :(float) _progress;
- (B4XBitmapWrapper*)  _generateeffectbackground:(B4XViewWrapper*) _vw :(NSString*) _effect :(BOOL) _invertshadow :(int) _color :(int) _depthedge :(int) _cornerradius :(int) _recursive :(BOOL) _alternateshadow;
- (B4IArray*)  _hearthlist:(float) _width :(float) _height :(int) _depthedge :(int) _rcs;
- (NSString*)  _initialize:(B4I*) _ba;
- (B4IArray*)  _listtoarray:(B4IList*) _l;
- (B4IArray*)  _newlist:(float) _width :(float) _height :(int) _depthedge :(int) _rcs;
@end
@interface _sepoint:NSObject
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

