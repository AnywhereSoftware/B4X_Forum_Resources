#import "iBitmapCreator.h"
#import "iCore.h"
#import "iHttp.h"
#import "iNetwork.h"
#import "iRandomAccessFile.h"
#import "iXUI.h"
#import "iBLE.h"
@class b4i_lanzebraprinter;
@interface b4i_blezebraprinter : B4IClass
{
@public BleManager* __manager;
@public B4IXUI* __xui;
@public NSObject* __mcallback;
@public NSString* __meventname;
@public NSString* __rotatenormal;
@public NSString* __rotate90;
@public NSString* __rotate180;
@public NSString* __rotate270;
@public NSString* __connectedname;
@public NSString* __id_printer;
@public BOOL __conn;
@public BOOL __scanning;
@public NSString* __encoding;
@public NSString* __servicename;
@public NSString* __charatteristicname;
@public int __currentstate;
@public NSString* __path;
@public B4IStringBuilder* __commandstring;
@public int __widthbytes;
@public int __total;
@public int __blacklimit;
@public B4IMap* __mapcode;
@public NSString* __activation;

}- (NSString*)  _active:(NSString*) _codeactivation;
- (NSString*)  _addbarcode:(int) _x :(int) _y :(int) _height :(NSString*) _code :(int) _size;
- (NSString*)  _addbarcodeean13:(int) _x :(int) _y :(int) _height :(NSString*) _code :(int) _size;
- (NSString*)  _addbarcodeean8:(int) _x :(int) _y :(int) _height :(NSString*) _code :(int) _size;
- (NSString*)  _addcircle:(int) _x :(int) _y :(int) _radius :(int) _strokewidth :(BOOL) _filled;
- (NSString*)  _addhorizline:(int) _x :(int) _y :(int) _width :(int) _strokewidth;
- (NSString*)  _addimage:(int) _x :(int) _y :(B4XBitmapWrapper*) _bmp;
- (NSString*)  _addlogosd:(int) _x :(int) _y;
- (NSString*)  _addqrcode:(int) _x :(int) _y :(int) _height :(NSString*) _code :(int) _size;
- (NSString*)  _addraw:(NSString*) _text;
- (NSString*)  _addrectangle:(int) _x :(int) _y :(int) _width :(int) _height :(int) _strokewidth :(BOOL) _filled :(BOOL) _invertbrush;
- (NSString*)  _addrectanglerounded:(int) _x :(int) _y :(int) _width :(int) _height :(int) _strokewidth :(BOOL) _filled :(int) _rounded;
- (NSString*)  _addsd:(NSString*) _t;
- (NSString*)  _addtext:(int) _x :(int) _y :(NSString*) _text :(int) _textsize :(BOOL) _bold;
- (NSString*)  _addtextrotate:(int) _x :(int) _y :(NSString*) _text :(int) _textsize :(BOOL) _bold :(NSString*) _rotation;
- (NSString*)  _addvertline:(int) _x :(int) _y :(int) _height :(int) _strokewidth;
- (NSString*)  _bytebinary:(NSString*) _binary;
- (NSString*)  _charstostring:(B4IArray*) _ch :(int) _start :(int) _stop;
- (NSString*)  _class_globals;
@property (nonatomic)BleManager* _manager;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)NSString* _rotatenormal;
@property (nonatomic)NSString* _rotate90;
@property (nonatomic)NSString* _rotate180;
@property (nonatomic)NSString* _rotate270;
@property (nonatomic)NSString* _connectedname;
@property (nonatomic)NSString* _id_printer;
@property (nonatomic)BOOL _conn;
@property (nonatomic)BOOL _scanning;
@property (nonatomic)NSString* _encoding;
@property (nonatomic)NSString* _servicename;
@property (nonatomic)NSString* _charatteristicname;
@property (nonatomic)int _currentstate;
@property (nonatomic)NSString* _path;
@property (nonatomic)B4IStringBuilder* _commandstring;
@property (nonatomic)int _widthbytes;
@property (nonatomic)int _total;
@property (nonatomic)int _blacklimit;
@property (nonatomic)B4IMap* _mapcode;
@property (nonatomic)NSString* _activation;
- (NSString*)  _completejob:(int) _taskid :(BOOL) _success :(NSString*) _errormessage :(B4IHttpResponse*) _res;
- (NSString*)  _connect:(NSString*) _id;
- (NSString*)  _creacorpo:(B4XBitmapWrapper*) _originalimage;
- (NSString*)  _creacorpohex:(B4XBitmapWrapper*) _img;
- (BOOL)  _demo;
- (NSString*)  _disconnect;
- (int)  _getblackrange;
- (BOOL)  _getisconnect;
- (BOOL)  _getisscanning;
- (NSString*)  _getraw;
- (NSString*)  _hc_responseerror:(B4IHttpResponse*) _response :(NSString*) _reason :(int) _statuscode :(int) _taskid;
- (NSString*)  _hc_responsesuccess:(B4IHttpResponse*) _response :(int) _taskid;
- (NSString*)  _headdoc;
- (NSString*)  _hextoascii:(NSString*) _code;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (void)  _manager_connected:(B4IList*) _services;
- (NSString*)  _manager_dataavailable:(NSString*) _service :(B4IMap*) _characteristics;
- (NSString*)  _manager_devicefound:(NSString*) _name :(NSString*) _id :(B4IMap*) _advertisingdata :(double) _rssi;
- (NSString*)  _manager_disconnected;
- (NSString*)  _manager_statechanged:(int) _state;
- (NSString*)  _manager_writecomplete:(NSString*) _characteristic :(BOOL) _success;
- (NSString*)  _preview;
- (NSString*)  _print;
- (NSString*)  _scanprinter;
- (NSString*)  _setblackrange:(int) _r;
- (NSString*)  _setlabelwidth:(int) _width;
- (NSString*)  _stopscanning;
- (NSString*)  _zplimage:(B4XBitmapWrapper*) _img :(BOOL) _compresshex;
@end

#import "iBitmapCreator.h"
#import "iCore.h"
#import "iHttp.h"
#import "iNetwork.h"
#import "iRandomAccessFile.h"
#import "iXUI.h"
#import "iBLE.h"
@class b4i_blezebraprinter;
@interface b4i_lanzebraprinter : B4IClass
{
@public B4ISocketWrapper* __client;
@public B4IAsyncStreams* __astream;
@public B4IXUI* __xui;
@public NSObject* __mcallback;
@public NSString* __mevent;
@public int __mobile;
@public int __desktop;
@public NSString* __rotatenormal;
@public NSString* __rotate90;
@public NSString* __rotate180;
@public NSString* __rotate270;
@public NSString* __encoding;
@public BOOL __compressimage;
@public NSString* __path;
@public B4IStringBuilder* __commandstring;
@public int __widthbytes;
@public int __total;
@public int __blacklimit;
@public B4IMap* __mapcode;
@public NSString* __activation;

}- (NSString*)  _active:(NSString*) _codeactivation;
- (NSString*)  _addbarcode:(int) _x :(int) _y :(int) _height :(NSString*) _code :(int) _size;
- (NSString*)  _addbarcodeean13:(int) _x :(int) _y :(int) _height :(NSString*) _code :(int) _size;
- (NSString*)  _addbarcodeean8:(int) _x :(int) _y :(int) _height :(NSString*) _code :(int) _size;
- (NSString*)  _addcircle:(int) _x :(int) _y :(int) _radius :(int) _strokewidth :(BOOL) _filled;
- (NSString*)  _addhorizline:(int) _x :(int) _y :(int) _width :(int) _strokewidth;
- (NSString*)  _addimage:(int) _x :(int) _y :(B4XBitmapWrapper*) _bmp;
- (NSString*)  _addlogosd:(int) _x :(int) _y;
- (NSString*)  _addqrcode:(int) _x :(int) _y :(int) _height :(NSString*) _code :(int) _size;
- (NSString*)  _addraw:(NSString*) _text;
- (NSString*)  _addrectangle:(int) _x :(int) _y :(int) _width :(int) _height :(int) _strokewidth :(BOOL) _filled :(BOOL) _invertbrush;
- (NSString*)  _addrectanglerounded:(int) _x :(int) _y :(int) _width :(int) _height :(int) _strokewidth :(BOOL) _filled :(int) _rounded;
- (NSString*)  _addsd:(NSString*) _t;
- (NSString*)  _addtext:(int) _x :(int) _y :(NSString*) _text :(int) _textsize :(BOOL) _bold;
- (NSString*)  _addtextrotate:(int) _x :(int) _y :(NSString*) _text :(int) _textsize :(BOOL) _bold :(NSString*) _rotation;
- (NSString*)  _addvertline:(int) _x :(int) _y :(int) _height :(int) _strokewidth;
- (NSString*)  _astream_error;
- (NSString*)  _astream_newdata:(B4IArray*) _buffer;
- (NSString*)  _astream_terminated;
- (NSString*)  _bytebinary:(NSString*) _binary;
- (NSString*)  _charstostring:(B4IArray*) _ch :(int) _start :(int) _stop;
- (NSString*)  _class_globals;
@property (nonatomic)B4ISocketWrapper* _client;
@property (nonatomic)B4IAsyncStreams* _astream;
@property (nonatomic)B4IXUI* _xui;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)NSString* _mevent;
@property (nonatomic)int _mobile;
@property (nonatomic)int _desktop;
@property (nonatomic)NSString* _rotatenormal;
@property (nonatomic)NSString* _rotate90;
@property (nonatomic)NSString* _rotate180;
@property (nonatomic)NSString* _rotate270;
@property (nonatomic)NSString* _encoding;
@property (nonatomic)BOOL _compressimage;
@property (nonatomic)NSString* _path;
@property (nonatomic)B4IStringBuilder* _commandstring;
@property (nonatomic)int _widthbytes;
@property (nonatomic)int _total;
@property (nonatomic)int _blacklimit;
@property (nonatomic)B4IMap* _mapcode;
@property (nonatomic)NSString* _activation;
- (NSString*)  _clear;
- (NSString*)  _client_connected:(BOOL) _successful;
- (NSString*)  _close;
- (NSString*)  _completejob:(int) _taskid :(BOOL) _success :(NSString*) _errormessage :(B4IHttpResponse*) _res;
- (NSString*)  _creacorpo:(B4XBitmapWrapper*) _originalimage;
- (NSString*)  _creacorpohex:(B4XBitmapWrapper*) _img;
- (BOOL)  _demo;
- (int)  _getblackrange;
- (NSString*)  _getraw;
- (NSString*)  _hc_responseerror:(B4IHttpResponse*) _response :(NSString*) _reason :(int) _statuscode :(int) _taskid;
- (NSString*)  _hc_responsesuccess:(B4IHttpResponse*) _response :(int) _taskid;
- (NSString*)  _headdoc;
- (NSString*)  _hextoascii:(NSString*) _code;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _event;
- (NSString*)  _open:(NSString*) _host :(int) _typeprinter;
- (NSString*)  _preview;
- (NSString*)  _print;
- (void)  _printandclose;
- (NSString*)  _setblackrange:(int) _r;
- (NSString*)  _setlabelwidth:(int) _width;
- (NSString*)  _zplimage:(B4XBitmapWrapper*) _img :(BOOL) _compresshex;
@end

