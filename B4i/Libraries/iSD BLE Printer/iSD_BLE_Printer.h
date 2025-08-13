#import "iBitmapCreator.h"
#import "iBLE.h"
#import "iCore.h"
#import "iXUI.h"
@class b4i_esc_pos;
@class b4i_encoding;
@interface b4i_ble_printer : B4IClass
{
@public NSObject* __mcallback;
@public NSString* __meventname;
@public BleManager* __manager;
@public NSString* __connectedname;
@public NSString* __id_printer;
@public BOOL __conn;
@public NSString* __mencoding;
@public NSString* __servicename;
@public NSString* __charatteristicname;
@public B4IList* __bufferimage;
@public BOOL __demo;
@public b4i_esc_pos* __esc_pos;
@public b4i_encoding* __encoding;

}- (BOOL)  _actived;
- (NSString*)  _addtab:(B4IArray*) _arraytab;
- (NSString*)  _addtocode:(B4IArray*) _ar;
- (NSString*)  _centerjustify;
- (NSString*)  _class_globals;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)BleManager* _manager;
@property (nonatomic)NSString* _connectedname;
@property (nonatomic)NSString* _id_printer;
@property (nonatomic)BOOL _conn;
@property (nonatomic)NSString* _mencoding;
@property (nonatomic)NSString* _servicename;
@property (nonatomic)NSString* _charatteristicname;
@property (nonatomic)B4IList* _bufferimage;
@property (nonatomic)BOOL _demo;
@property (nonatomic)b4i_esc_pos* _esc_pos;
@property (nonatomic)b4i_encoding* _encoding;
- (NSString*)  _connect:(NSString*) _id;
- (BOOL)  _getisconnect;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname :(NSString*) _encodingtype :(NSString*) _codeactivation;
- (NSString*)  _initializeprinter;
- (NSString*)  _leftjustify;
- (void)  _manager_connected:(B4IList*) _services;
- (NSString*)  _manager_dataavailable:(NSString*) _service :(B4IMap*) _characteristics;
- (NSString*)  _manager_devicefound:(NSString*) _name :(NSString*) _id :(B4IMap*) _advertisingdata :(double) _rssi;
- (NSString*)  _manager_disconnected;
- (NSString*)  _manager_statechanged:(int) _state;
- (NSString*)  _manager_writecomplete:(NSString*) _characteristic :(BOOL) _success;
- (void)  _printbitmap:(B4IBitmap*) _bmp;
- (NSString*)  _rightjustify;
- (NSString*)  _scanprinter;
- (NSString*)  _senddata:(B4IList*) _l;
- (NSString*)  _setcodepage:(unsigned char) _code;
- (NSString*)  _setcodetable:(int) _code;
- (NSString*)  _setspacing:(int) _spacing;
- (BOOL)  _validity:(NSString*) _num;
- (NSString*)  _write:(NSString*) _text;
- (NSString*)  _write_arraybyte:(B4IArray*) _b;
- (NSString*)  _writebarcode:(NSString*) _code;
- (NSString*)  _writeline:(NSString*) _text;
- (NSString*)  _writelist:(B4IList*) _list;
@end

#import "iBitmapCreator.h"
#import "iBLE.h"
#import "iCore.h"
#import "iXUI.h"
@class b4i_esc_pos;
@class b4i_ble_printer;
@interface b4i_encoding : B4IStaticModule
{
@public NSString* __windows1252;
@public NSString* __utf8;
@public NSString* __iso8859;
@public NSString* __chinese;
@public NSString* __chineses;
@public NSString* __ibm_pc;
@public NSString* __dos_latin_1;
@public int __code_pc437;
@public int __code_pc850;
@public int __code_pc860;
@public int __code_pc863;
@public int __code_wpc1252;
@public int __code_pc857;
@public int __code_pc858;
@public b4i_esc_pos* __esc_pos;

}- (NSString*)  _process_globals;
@property (nonatomic)NSString* _windows1252;
@property (nonatomic)NSString* _utf8;
@property (nonatomic)NSString* _iso8859;
@property (nonatomic)NSString* _chinese;
@property (nonatomic)NSString* _chineses;
@property (nonatomic)NSString* _ibm_pc;
@property (nonatomic)NSString* _dos_latin_1;
@property (nonatomic)int _code_pc437;
@property (nonatomic)int _code_pc850;
@property (nonatomic)int _code_pc860;
@property (nonatomic)int _code_pc863;
@property (nonatomic)int _code_wpc1252;
@property (nonatomic)int _code_pc857;
@property (nonatomic)int _code_pc858;
@property (nonatomic)b4i_esc_pos* _esc_pos;
@end

#import "iBitmapCreator.h"
#import "iBLE.h"
#import "iCore.h"
#import "iXUI.h"
@class b4i_encoding;
@class b4i_ble_printer;
@interface b4i_esc_pos : B4IStaticModule
{
@public NSString* __esc;
@public NSString* __gs;
@public NSString* __exl;
@public NSString* __dle;
@public NSString* __eot;
@public NSString* __initializeprinter;
@public NSString* __boldon;
@public NSString* __boldoff;
@public NSString* __doubleon;
@public NSString* __doubleoff;
@public NSString* __fonta_normal;
@public NSString* __fonta_bold;
@public NSString* __fontb_normal;
@public NSString* __fontb_bold;
@public NSString* __fonta_doublehight;
@public NSString* __fonta_doublewide;
@public NSString* __fonta_doublewideheight;
@public NSString* __fontb_doubleheight;
@public NSString* __fontb_doublewide;
@public NSString* __fontb_doublewideheight;
@public NSString* __horizzontal;
@public NSString* __vertical;
@public NSString* __nounderline;
@public NSString* __underline1;
@public NSString* __underline2;
@public NSString* __queryprinterstatus;
@public NSString* __queryofflinecauses;
@public NSString* __queryerrorcauses;
@public NSString* __querypaperstatus;
@public b4i_encoding* __encoding;

}- (NSString*)  _process_globals;
@property (nonatomic)NSString* _esc;
@property (nonatomic)NSString* _gs;
@property (nonatomic)NSString* _exl;
@property (nonatomic)NSString* _dle;
@property (nonatomic)NSString* _eot;
@property (nonatomic)NSString* _initializeprinter;
@property (nonatomic)NSString* _boldon;
@property (nonatomic)NSString* _boldoff;
@property (nonatomic)NSString* _doubleon;
@property (nonatomic)NSString* _doubleoff;
@property (nonatomic)NSString* _fonta_normal;
@property (nonatomic)NSString* _fonta_bold;
@property (nonatomic)NSString* _fontb_normal;
@property (nonatomic)NSString* _fontb_bold;
@property (nonatomic)NSString* _fonta_doublehight;
@property (nonatomic)NSString* _fonta_doublewide;
@property (nonatomic)NSString* _fonta_doublewideheight;
@property (nonatomic)NSString* _fontb_doubleheight;
@property (nonatomic)NSString* _fontb_doublewide;
@property (nonatomic)NSString* _fontb_doublewideheight;
@property (nonatomic)NSString* _horizzontal;
@property (nonatomic)NSString* _vertical;
@property (nonatomic)NSString* _nounderline;
@property (nonatomic)NSString* _underline1;
@property (nonatomic)NSString* _underline2;
@property (nonatomic)NSString* _queryprinterstatus;
@property (nonatomic)NSString* _queryofflinecauses;
@property (nonatomic)NSString* _queryerrorcauses;
@property (nonatomic)NSString* _querypaperstatus;
@property (nonatomic)b4i_encoding* _encoding;
@end

