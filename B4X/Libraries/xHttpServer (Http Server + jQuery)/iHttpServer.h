#import "iArchiver.h"
#import "iCore.h"
#import "iEncryption.h"
#import "iJSON.h"
#import "iNetwork.h"
#import "iRandomAccessFile.h"
#import "iStringUtils.h"
#import "iXUI.h"
@class b4i_xcollections;
@class _tuser;
@class b4i_servletrequest;
@class b4i_servletresponse;
@class b4i_queryelement;
@class b4i_xbitset;
@class b4i_xbytesbuilder;
@class b4i_xorderedmap;
@class b4i_xset;
@interface b4i_httpserver : B4IClass
{
@public B4IMap* __users;
@public B4IServerSocketWrapper* __serv;
@public BOOL __work;
@public NSObject* __mcallback;
@public NSString* __meventname;
@public BOOL __digestauthentication;
@public NSString* __digestpath;
@public NSString* __realm;
@public B4IList* __htdigest;
@public BOOL __ignorenc;
@public int __timeout;
@public NSString* __character_encoding;
@public b4i_xcollections* __xcollections;

}- (NSString*)  _class_globals;
@property (nonatomic)B4IMap* _users;
@property (nonatomic)B4IServerSocketWrapper* _serv;
@property (nonatomic)BOOL _work;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)BOOL _digestauthentication;
@property (nonatomic)NSString* _digestpath;
@property (nonatomic)NSString* _realm;
@property (nonatomic)B4IList* _htdigest;
@property (nonatomic)BOOL _ignorenc;
@property (nonatomic)int _timeout;
@property (nonatomic)NSString* _character_encoding;
@property (nonatomic)b4i_xcollections* _xcollections;
- (NSString*)  _data_handle:(b4i_servletrequest*) _req :(b4i_servletresponse*) _res;
- (NSString*)  _data_handlewebsocket:(b4i_servletrequest*) _req :(b4i_servletresponse*) _resp;
- (NSString*)  _data_switchtowebsocket:(b4i_servletrequest*) _req :(b4i_servletresponse*) _resp;
- (NSString*)  _data_uploadedfile:(b4i_servletrequest*) _req :(b4i_servletresponse*) _resp;
- (NSString*)  _data_websocketclose:(int) _closecode :(NSString*) _closemessage;
- (NSString*)  _getcharacterencoding;
- (NSString*)  _getmyip;
- (NSString*)  _getmywifiip;
- (NSString*)  _gettemppath;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname;
- (NSString*)  _setcharacterencoding:(NSString*) _s;
- (void)  _start:(int) _port;
- (void)  _serv_newconnection:(BOOL) _successful :(B4ISocketWrapper*) _newsocket;
- (NSString*)  _stop;
- (BOOL)  _subexists2:(NSObject*) _callobject :(NSString*) _eventname :(int) _param;
@end

#import "iArchiver.h"
#import "iCore.h"
#import "iEncryption.h"
#import "iJSON.h"
#import "iNetwork.h"
#import "iRandomAccessFile.h"
#import "iStringUtils.h"
#import "iXUI.h"
@class b4i_xcollections;
@class b4i_httpserver;
@class _tuser;
@class b4i_servletrequest;
@class b4i_servletresponse;
@class b4i_xbitset;
@class b4i_xbytesbuilder;
@class b4i_xorderedmap;
@class b4i_xset;
@interface b4i_queryelement : B4IClass
{
@public NSString* __event_change;
@public NSString* __event_click;
@public NSString* __event_dblclick;
@public NSString* __event_focus;
@public NSString* __event_focusin;
@public NSString* __event_focusout;
@public NSString* __event_keyup;
@public NSString* __event_mousedown;
@public NSString* __event_mouseenter;
@public NSString* __event_mouseleave;
@public NSString* __event_mousemove;
@public NSString* __event_mouseup;
@public B4IArray* __noevent;
@public b4i_servletresponse* __resp;
@public b4i_xcollections* __xcollections;

}- (NSString*)  _class_globals;
@property (nonatomic)NSString* _event_change;
@property (nonatomic)NSString* _event_click;
@property (nonatomic)NSString* _event_dblclick;
@property (nonatomic)NSString* _event_focus;
@property (nonatomic)NSString* _event_focusin;
@property (nonatomic)NSString* _event_focusout;
@property (nonatomic)NSString* _event_keyup;
@property (nonatomic)NSString* _event_mousedown;
@property (nonatomic)NSString* _event_mouseenter;
@property (nonatomic)NSString* _event_mouseleave;
@property (nonatomic)NSString* _event_mousemove;
@property (nonatomic)NSString* _event_mouseup;
@property (nonatomic)B4IArray* _noevent;
@property (nonatomic)b4i_servletresponse* _resp;
@property (nonatomic)b4i_xcollections* _xcollections;
- (B4IArray*)  _createevent:(NSString*) _objectname :(NSString*) _event :(B4IArray*) _otherevent;
- (NSString*)  _escapehtml:(NSString*) _raw;
- (NSString*)  _eval:(NSString*) _script :(B4IList*) _params;
- (NSString*)  _evalwithresult:(NSString*) _script :(B4IList*) _params;
- (NSString*)  _getpropriety:(NSString*) _property :(B4IList*) _value;
- (NSString*)  _getval:(NSString*) _id :(B4IList*) _valuelist;
- (NSString*)  _initialize:(B4I*) _ba :(b4i_servletresponse*) _response;
- (BOOL)  _isnull:(NSObject*) _o;
- (NSString*)  _runfunction:(NSString*) _function :(NSString*) _id :(B4IList*) _params;
- (NSString*)  _runfunctionwithresult:(NSString*) _function :(NSString*) _id :(B4IList*) _params;
- (NSString*)  _runmethod:(NSString*) _method :(NSString*) _id :(B4IList*) _params;
- (NSString*)  _runmethodwithresult:(NSString*) _method :(NSString*) _id :(B4IList*) _params;
- (NSString*)  _selectelement:(NSString*) _id;
- (NSString*)  _setautomaticevents:(B4IArray*) _arg;
- (NSString*)  _setautomaticeventsfrompage:(NSString*) _html;
- (NSString*)  _setcommand:(NSString*) _etype :(NSString*) _method :(NSString*) _property :(NSString*) _id :(B4IList*) _params :(B4IList*) _arg;
- (NSString*)  _setcss:(NSString*) _id :(B4IList*) _params;
- (NSString*)  _setdialog:(NSString*) _id :(B4IList*) _params;
- (NSString*)  _sethtml:(NSString*) _id :(B4IList*) _params;
- (NSString*)  _setpropriety:(NSString*) _property :(B4IList*) _value;
- (NSString*)  _settext:(NSString*) _id :(B4IList*) _textlist;
- (NSString*)  _setval:(NSString*) _id :(B4IList*) _valuelist;
@end

#import "iArchiver.h"
#import "iCore.h"
#import "iEncryption.h"
#import "iJSON.h"
#import "iNetwork.h"
#import "iRandomAccessFile.h"
#import "iStringUtils.h"
#import "iXUI.h"
@class b4i_xcollections;
@class b4i_httpserver;
@class _tuser;
@class b4i_servletresponse;
@class b4i_queryelement;
@class b4i_xbitset;
@class b4i_xbytesbuilder;
@class b4i_xorderedmap;
@class b4i_xset;
@interface b4i_servletrequest : B4IClass
{
@public B4IArray* __dday;
@public B4IArray* __mmmonth;
@public B4ISocketWrapper* __client;
@public B4IAsyncStreams* __astream;
@public NSObject* __mcallback;
@public NSString* __meventname;
@public B4IByteConverter* __bc;
@public NSString* __method;
@public NSString* __requesturi;
@public NSString* __requesthost;
@public NSString* __address;
@public NSString* __connport;
@public NSString* __id;
@public B4IMap* __requestheader;
@public B4IMap* __requestparameter;
@public B4IMap* __requestcookies;
@public B4IList* __requestpostdatarow;
@public BOOL __connectionalive;
@public NSString* __character_encoding;
@public b4i_httpserver* __callserver;
@public b4i_servletresponse* __response;
@public B4IMap* __users;
@public NSString* __username;
@public NSString* __password;
@public BOOL __otherdata;
@public B4IArray* __cache;
@public B4IArray* __bbb;
@public iStringUtils* __su;
@public BOOL __logprivate;
@public BOOL __logactive;
@public NSString* __contenttype;
@public long long __contentlength;
@public B4IMap* __multipartfilename;
@public BOOL __logfirstrefuse;
@public long long __timeout;
@public long long __lastbrowsercomunicate;
@public BOOL __gzip;
@public BOOL __deflate;
@public BOOL __websocket;
@public NSString* __keywebsocket;
@public NSString* __websocketstring;
@public unsigned char __lastopcode;
@public b4i_xcollections* __xcollections;

}- (B4IArray*)  _arrayappend:(B4IArray*) _data1 :(B4IArray*) _data2;
- (B4IArray*)  _arraycopy:(B4IArray*) _data;
- (int)  _arrayindexof:(B4IArray*) _data :(B4IArray*) _searchdata;
- (B4IArray*)  _arrayinitialize;
- (B4IArray*)  _arrayinsert:(B4IArray*) _datasource :(int) _index :(B4IArray*) _datainsert;
- (int)  _arraylastindexof:(B4IArray*) _data :(B4IArray*) _searchdata;
- (B4IArray*)  _arrayremove:(B4IArray*) _data :(int) _start :(int) _last;
- (NSString*)  _astream_error;
- (NSString*)  _astream_newdata:(B4IArray*) _buffer;
- (NSString*)  _astream_terminated;
- (void)  _browsertimeout;
- (NSString*)  _callevent;
- (NSString*)  _class_globals;
@property (nonatomic)B4IArray* _dday;
@property (nonatomic)B4IArray* _mmmonth;
@property (nonatomic)B4ISocketWrapper* _client;
@property (nonatomic)B4IAsyncStreams* _astream;
@property (nonatomic)NSObject* _mcallback;
@property (nonatomic)NSString* _meventname;
@property (nonatomic)B4IByteConverter* _bc;
@property (nonatomic)NSString* _method;
@property (nonatomic)NSString* _requesturi;
@property (nonatomic)NSString* _requesthost;
@property (nonatomic)NSString* _address;
@property (nonatomic)NSString* _connport;
@property (nonatomic)NSString* _id;
@property (nonatomic)B4IMap* _requestheader;
@property (nonatomic)B4IMap* _requestparameter;
@property (nonatomic)B4IMap* _requestcookies;
@property (nonatomic)B4IList* _requestpostdatarow;
@property (nonatomic)BOOL _connectionalive;
@property (nonatomic)NSString* _character_encoding;
@property (nonatomic)b4i_httpserver* _callserver;
@property (nonatomic)b4i_servletresponse* _response;
@property (nonatomic)B4IMap* _users;
@property (nonatomic)NSString* _username;
@property (nonatomic)NSString* _password;
@property (nonatomic)BOOL _otherdata;
@property (nonatomic)B4IArray* _cache;
@property (nonatomic)B4IArray* _bbb;
@property (nonatomic)iStringUtils* _su;
@property (nonatomic)BOOL _logprivate;
@property (nonatomic)BOOL _logactive;
@property (nonatomic)NSString* _contenttype;
@property (nonatomic)long long _contentlength;
@property (nonatomic)B4IMap* _multipartfilename;
@property (nonatomic)BOOL _logfirstrefuse;
@property (nonatomic)long long _timeout;
@property (nonatomic)long long _lastbrowsercomunicate;
@property (nonatomic)BOOL _gzip;
@property (nonatomic)BOOL _deflate;
@property (nonatomic)BOOL _websocket;
@property (nonatomic)NSString* _keywebsocket;
@property (nonatomic)NSString* _websocketstring;
@property (nonatomic)unsigned char _lastopcode;
@property (nonatomic)b4i_xcollections* _xcollections;
- (NSString*)  _close;
- (NSString*)  _completedate:(long long) _dt;
- (BOOL)  _connected;
- (NSString*)  _decode:(NSString*) _s;
- (NSString*)  _dectohex:(int) _dec;
- (B4IArray*)  _demasked:(B4IArray*) _maskdata :(B4IArray*) _maskingkey :(long long) _length :(long long) _spacement :(BOOL) _masked;
- (NSString*)  _elaboratehandshake:(NSString*) _handshake :(B4IArray*) _data;
- (NSString*)  _elaboratehandskakedigestmessage:(b4i_servletrequest*) _request :(b4i_servletresponse*) _sresponse;
- (NSString*)  _elaboratewebsocket:(B4IArray*) _data;
- (NSString*)  _encode:(NSString*) _s;
- (NSString*)  _extracthandshake;
- (NSString*)  _extractparameterfromdata;
- (NSString*)  _findcredential:(NSString*) _un;
- (_tuser*)  _finduser:(NSString*) _naddress :(NSString*) _opaque;
- (NSString*)  _getcharacterencoding;
- (NSString*)  _getheader:(NSString*) _name;
- (B4IList*)  _getheadersname;
- (B4IInputStream*)  _getinputstream;
- (NSString*)  _getmethod;
- (NSString*)  _getrequesthost;
- (NSString*)  _getrequesturi;
- (BOOL)  _getwebsocketcompressdeflateaccept;
- (BOOL)  _getwebsocketcompressgzipaccept;
- (B4IMap*)  _getwebsocketmapdata;
- (NSString*)  _getwebsocketstringdata;
- (int)  _hextodec:(NSString*) _hex;
- (B4IArray*)  _inflatedate:(B4IArray*) _data;
- (NSString*)  _initialize:(B4I*) _ba :(NSObject*) _callback :(NSString*) _eventname :(B4ISocketWrapper*) _sck;
- (NSString*)  _lgc:(NSString*) _message :(int) _color;
- (NSString*)  _lgp:(NSString*) _message;
- (NSString*)  _md5:(NSString*) _stringtoconvert;
- (_tuser*)  _newuser:(NSString*) _naddress;
- (B4IMap*)  _parametermap;
- (NSString*)  _remoteaddress;
- (int)  _remoteport;
- (NSString*)  _sendacceptkeyws;
- (NSString*)  _sendrefuse:(b4i_servletresponse*) _sresponse :(_tuser*) _user;
- (NSString*)  _setcharacterencoding:(NSString*) _s;
- (B4IArray*)  _subarray:(B4IArray*) _data :(int) _pos;
- (B4IArray*)  _subarray2:(B4IArray*) _data :(int) _start :(int) _last;
- (BOOL)  _subexists2:(NSObject*) _callobject :(NSString*) _eventname :(int) _param;
- (NSString*)  _websocketkey:(NSString*) _key;
@end
@interface _tuser:NSObject
{
@public BOOL _IsInitialized;
@public NSString* _Address;
@public int _nc;
@public NSString* _nonce;
@public NSString* _opaque;
@public long long _LastRequest;
@public NSString* _realm;

}
@property (nonatomic)BOOL IsInitialized;
@property (nonatomic)NSString* Address;
@property (nonatomic)int nc;
@property (nonatomic)NSString* nonce;
@property (nonatomic)NSString* opaque;
@property (nonatomic)long long LastRequest;
@property (nonatomic)NSString* realm;
-(void)Initialize;
@end

#import "iArchiver.h"
#import "iCore.h"
#import "iEncryption.h"
#import "iJSON.h"
#import "iNetwork.h"
#import "iRandomAccessFile.h"
#import "iStringUtils.h"
#import "iXUI.h"
@class b4i_xcollections;
@class b4i_httpserver;
@class _tuser;
@class b4i_servletrequest;
@class b4i_queryelement;
@class b4i_xbitset;
@class b4i_xbytesbuilder;
@class b4i_xorderedmap;
@class b4i_xset;
@interface b4i_servletresponse : B4IClass
{
@public b4i_servletrequest* __request;
@public B4IAsyncStreams* __astream;
@public B4IMap* __responseheader;
@public B4IMap* __responseparameter;
@public B4IMap* __responsecookies;
@public B4IMap* __code;
@public B4IMap* __mime;
@public B4ISocketWrapper* __client;
@public int __status;
@public NSString* __contenttype;
@public NSString* __character_encoding;
@public int __contentlenght;
@public B4IArray* __dday;
@public B4IArray* __mmmonth;
@public B4IByteConverter* __bc;
@public b4i_queryelement* __myquery;
@public B4IArray* __final;
@public b4i_xcollections* __xcollections;

}- (NSString*)  _appenfinal:(B4IArray*) _b;
- (NSString*)  _astream_write:(B4IArray*) _data;
- (NSString*)  _class_globals;
@property (nonatomic)b4i_servletrequest* _request;
@property (nonatomic)B4IAsyncStreams* _astream;
@property (nonatomic)B4IMap* _responseheader;
@property (nonatomic)B4IMap* _responseparameter;
@property (nonatomic)B4IMap* _responsecookies;
@property (nonatomic)B4IMap* _code;
@property (nonatomic)B4IMap* _mime;
@property (nonatomic)B4ISocketWrapper* _client;
@property (nonatomic)int _status;
@property (nonatomic)NSString* _contenttype;
@property (nonatomic)NSString* _character_encoding;
@property (nonatomic)int _contentlenght;
@property (nonatomic)B4IArray* _dday;
@property (nonatomic)B4IArray* _mmmonth;
@property (nonatomic)B4IByteConverter* _bc;
@property (nonatomic)b4i_queryelement* _myquery;
@property (nonatomic)B4IArray* _final;
@property (nonatomic)b4i_xcollections* _xcollections;
- (NSString*)  _close;
- (NSString*)  _completedate:(long long) _dt;
- (BOOL)  _connected;
- (B4IArray*)  _datamask:(B4IArray*) _data :(B4IArray*) _maskingkey;
- (B4IArray*)  _deflatedate:(B4IArray*) _data;
- (NSString*)  _getcharacterencoding;
- (B4IOutputStream*)  _getoutputstream;
- (b4i_queryelement*)  _getquery;
- (NSString*)  _handshakefile:(NSString*) _lastmodified :(long long) _filesize;
- (NSString*)  _handshakestring;
- (NSString*)  _initialize:(B4I*) _ba :(b4i_servletrequest*) _req :(B4IAsyncStreams*) _ast :(B4ISocketWrapper*) _sck;
- (NSString*)  _resetcookies;
- (NSString*)  _searchmime:(NSString*) _nm;
- (NSString*)  _sendfile:(NSString*) _dir :(NSString*) _filename;
- (NSString*)  _sendfile2:(NSString*) _dir :(NSString*) _filename :(NSString*) _content_type;
- (NSString*)  _sendnotfound:(NSString*) _filenamenotfound;
- (NSString*)  _sendraw:(B4IArray*) _data;
- (NSString*)  _sendredirect:(NSString*) _address;
- (NSString*)  _sendstring:(NSString*) _text;
- (NSString*)  _sendwebsocketbinary:(B4IArray*) _data :(BOOL) _masked;
- (NSString*)  _sendwebsocketclose;
- (NSString*)  _sendwebsocketping;
- (NSString*)  _sendwebsocketpong;
- (NSString*)  _sendwebsocketstring:(NSString*) _text :(BOOL) _masked :(NSString*) _compressed;
- (NSString*)  _setcharacterencoding:(NSString*) _s;
- (NSString*)  _setcookies:(NSString*) _name :(NSString*) _value;
- (NSString*)  _setheader:(NSString*) _name :(NSString*) _value;
- (NSString*)  _statuscode:(int) _sts;
- (NSString*)  _write:(NSString*) _text;
@end

#import "iArchiver.h"
#import "iCore.h"
#import "iEncryption.h"
#import "iJSON.h"
#import "iNetwork.h"
#import "iRandomAccessFile.h"
#import "iStringUtils.h"
#import "iXUI.h"
@class b4i_xcollections;
@class b4i_httpserver;
@class _tuser;
@class b4i_servletrequest;
@class b4i_servletresponse;
@class b4i_queryelement;
@class b4i_xbytesbuilder;
@class b4i_xorderedmap;
@class b4i_xset;
@interface b4i_xbitset : B4IClass
{
@public B4IArray* __data;
@public int __msize;
@public b4i_xcollections* __xcollections;

}- (NSString*)  _class_globals;
@property (nonatomic)B4IArray* _data;
@property (nonatomic)int _msize;
@property (nonatomic)b4i_xcollections* _xcollections;
- (NSString*)  _clear;
- (BOOL)  _get:(int) _index;
- (int)  _getsize;
- (NSString*)  _initialize:(B4I*) _ba :(int) _size;
- (NSString*)  _set:(int) _index :(BOOL) _value;
@end

#import "iArchiver.h"
#import "iCore.h"
#import "iEncryption.h"
#import "iJSON.h"
#import "iNetwork.h"
#import "iRandomAccessFile.h"
#import "iStringUtils.h"
#import "iXUI.h"
@class b4i_xcollections;
@class b4i_httpserver;
@class _tuser;
@class b4i_servletrequest;
@class b4i_servletresponse;
@class b4i_queryelement;
@class b4i_xbitset;
@class b4i_xorderedmap;
@class b4i_xset;
@interface b4i_xbytesbuilder : B4IClass
{
@public B4IArray* __mbuffer;
@public int __mlength;
@public b4i_xcollections* __xcollections;

}- (b4i_xbytesbuilder*)  _append:(B4IArray*) _data;
- (b4i_xbytesbuilder*)  _append2:(B4IArray*) _data :(int) _startindex :(int) _length;
- (int)  _changelength:(int) _newlength;
- (NSString*)  _class_globals;
@property (nonatomic)B4IArray* _mbuffer;
@property (nonatomic)int _mlength;
@property (nonatomic)b4i_xcollections* _xcollections;
- (NSString*)  _clear;
- (B4IArray*)  _getinternalbuffer;
- (int)  _getlength;
- (int)  _indexof:(B4IArray*) _searchfor;
- (int)  _indexof2:(B4IArray*) _searchfor :(int) _index;
- (NSString*)  _initialize:(B4I*) _ba;
- (NSString*)  _insert:(int) _index :(B4IArray*) _data;
- (B4IArray*)  _remove:(int) _beginindex :(int) _endindex;
- (NSString*)  _set:(int) _index :(B4IArray*) _data;
- (B4IArray*)  _subarray:(int) _beginindex;
- (B4IArray*)  _subarray2:(int) _beginindex :(int) _endindex;
- (B4IArray*)  _toarray;
@end

#import "iArchiver.h"
#import "iCore.h"
#import "iEncryption.h"
#import "iJSON.h"
#import "iNetwork.h"
#import "iRandomAccessFile.h"
#import "iStringUtils.h"
#import "iXUI.h"
@class b4i_httpserver;
@class _tuser;
@class b4i_servletrequest;
@class b4i_servletresponse;
@class b4i_queryelement;
@class b4i_xbitset;
@class b4i_xbytesbuilder;
@class b4i_xorderedmap;
@class b4i_xset;
@interface b4i_xcollections : B4IStaticModule
{

}- (b4i_xbitset*)  _createbitset:(int) _size;
- (b4i_xorderedmap*)  _createorderedmap;
- (b4i_xorderedmap*)  _createorderedmap2:(B4IList*) _keys :(B4IList*) _values;
- (b4i_xset*)  _createset;
- (b4i_xset*)  _createset2:(B4IList*) _values;
- (NSString*)  _process_globals;
@end

#import "iArchiver.h"
#import "iCore.h"
#import "iEncryption.h"
#import "iJSON.h"
#import "iNetwork.h"
#import "iRandomAccessFile.h"
#import "iStringUtils.h"
#import "iXUI.h"
@class b4i_xcollections;
@class b4i_httpserver;
@class _tuser;
@class b4i_servletrequest;
@class b4i_servletresponse;
@class b4i_queryelement;
@class b4i_xbitset;
@class b4i_xbytesbuilder;
@class b4i_xset;
@interface b4i_xorderedmap : B4IClass
{
@public B4IMap* __map;
@public B4IList* __list;
@public b4i_xcollections* __xcollections;

}- (NSString*)  _class_globals;
@property (nonatomic)B4IMap* _map;
@property (nonatomic)B4IList* _list;
@property (nonatomic)b4i_xcollections* _xcollections;
- (NSString*)  _clear;
- (BOOL)  _containskey:(NSObject*) _key;
- (NSObject*)  _get:(NSObject*) _key;
- (NSObject*)  _getdataforserializator;
- (NSObject*)  _getdefault:(NSObject*) _key :(NSObject*) _defaultvalue;
- (B4IList*)  _getkeys;
- (int)  _getsize;
- (B4IList*)  _getvalues;
- (NSString*)  _initialize:(B4I*) _ba;
- (NSString*)  _put:(NSObject*) _key :(NSObject*) _value;
- (NSString*)  _remove:(NSObject*) _key;
- (NSString*)  _setdatafromserializator:(NSObject*) _data;
@end

#import "iArchiver.h"
#import "iCore.h"
#import "iEncryption.h"
#import "iJSON.h"
#import "iNetwork.h"
#import "iRandomAccessFile.h"
#import "iStringUtils.h"
#import "iXUI.h"
@class b4i_xcollections;
@class b4i_httpserver;
@class _tuser;
@class b4i_servletrequest;
@class b4i_servletresponse;
@class b4i_queryelement;
@class b4i_xbitset;
@class b4i_xbytesbuilder;
@class b4i_xorderedmap;
@interface b4i_xset : B4IClass
{
@public b4i_xorderedmap* __map;
@public b4i_xcollections* __xcollections;

}- (NSString*)  _add:(NSObject*) _value;
- (B4IList*)  _aslist;
- (NSString*)  _class_globals;
@property (nonatomic)b4i_xorderedmap* _map;
@property (nonatomic)b4i_xcollections* _xcollections;
- (NSString*)  _clear;
- (BOOL)  _contains:(NSObject*) _value;
- (int)  _getsize;
- (NSString*)  _initialize:(B4I*) _ba;
- (NSString*)  _remove:(NSObject*) _value;
@end

