#import "iCore.h"
#import "iSpriteKit.h"
#import "iXmlSax.h"
@class _tile;
@class _tileobj;
@class _xmlelement;
@class b4i_xml2map;
@interface b4i_itiled : B4IStaticModule
- (NSString*)  _addobjtomap:(B4IMap*) _miniobjectmap :(B4IMap*) _objatt;
- (NSString*)  _createcropedbmpfromtileset:(B4IMap*) _tilemap;
- (NSString*)  _createobjectlist:(B4IMap*) _objectmap;
- (NSString*)  _createspritetiles:(B4IMap*) _layemap :(SNode*) _tilenode;
- (NSString*)  _getcentroidandvertices:(_tileobj*) _newtileobj :(NSString*) _points;
- (NSString*)  _initialize:(NSString*) _filename :(SNode*) _tilenode;
- (NSString*)  _process_globals;
@property (nonatomic)B4IList* _objectlist;
@property (nonatomic)int _mymapheight;
@property (nonatomic)int _mymapwidth;
@property (nonatomic)int _mymaptileheight;
@property (nonatomic)int _mymaptilewidth;
@property (nonatomic)int _firstgid;
@property (nonatomic)NSString* _myfilename;
@property (nonatomic)int _tilecount;
@property (nonatomic)int _columns;
@property (nonatomic)int _tilewidth;
@property (nonatomic)int _tileheight;
@property (nonatomic)B4IMap* _parseddata;
@property (nonatomic)B4IMap* _spritenodesmap;
@property (nonatomic)float _vpw;
@property (nonatomic)float _vph;
@property (nonatomic)int _totaltiles;
@property (nonatomic)SSize* _tilesize;
@property (nonatomic)B4IMap* _tilebmps;
- (SPoint*)  _returncentroid:(B4IList*) _vertices;
- (B4IList*)  _returnlist:(NSString*) _str;
@end
@interface _tile:NSObject
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)B4IBitmap* bmp;
@property (nonatomic)float width;
@property (nonatomic)float height;
-(void)Initialize;
@end
@interface _tileobj:NSObject
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSString* objtype;
@property (nonatomic)NSString* name;
@property (nonatomic)int id;
@property (nonatomic)float x;
@property (nonatomic)float y;
@property (nonatomic)float width;
@property (nonatomic)float height;
@property (nonatomic)float rotation;
@property (nonatomic)B4IPathWrapper* vertices;
@property (nonatomic)B4IMap* myproperties;
@property (nonatomic)SPoint* centroid;
-(void)Initialize;
@end

#import "iCore.h"
#import "iSpriteKit.h"
#import "iXmlSax.h"
@class b4i_itiled;
@class _tile;
@class _tileobj;
@class _xmlelement;
@interface b4i_xml2map : B4IClass
- (NSString*)  _class_globals;
@property (nonatomic)B4ISaxParser* _parser;
@property (nonatomic)B4IList* _elements;
@property (nonatomic)b4i_itiled* _itiled;
- (_xmlelement*)  _createelement:(NSString*) _name;
- (NSObject*)  _elementtoobject:(_xmlelement*) _element;
- (_xmlelement*)  _getlastelement;
- (NSString*)  _initialize:(B4I*) _ba;
- (B4IMap*)  _parse:(NSString*) _xml;
- (B4IMap*)  _parse2:(B4IInputStream*) _input;
- (NSString*)  _parser_endelement:(NSString*) _uri :(NSString*) _name :(B4IStringBuilder*) _text;
- (NSString*)  _parser_startelement:(NSString*) _uri :(NSString*) _name :(B4IMap*) _attributes;
@end
@interface _xmlelement:NSObject
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSString* Name;
@property (nonatomic)B4IList* Children;
@property (nonatomic)NSString* Text;
@property (nonatomic)B4IMap* Attributes;
-(void)Initialize;
@end

