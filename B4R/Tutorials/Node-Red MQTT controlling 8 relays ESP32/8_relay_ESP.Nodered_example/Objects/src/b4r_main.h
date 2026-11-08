
#ifndef b4r_main_h
#define b4r_main_h

class b4r_main {
public:

static void initializeProcessGlobals();
static void _appstart();
static void _astream_error();
static void _astream_newdata(B4R::Array* _buffer);
static bool _broakerrelaysstausupdate(UInt _status);
static void _clearallreg();
static void _mqtt_disconnected();
static void _mqtt_messagearrived(B4R::B4RString* _topic,B4R::Array* _payload);
static void _process_globals();
static B4R::Serial* _serial1;
static B4R::AsyncStreams* _astream;
static B4R::B4RESPWiFi* _wifi;
static B4R::WiFiSocket* _wifistr;
static B4R::MqttClient* _mqtt;
static B4R::MqttConnectOptions* _mqttopt;
static B4R::B4RString* _mqttuser;
static B4R::B4RString* _mqttpassword;
static B4R::B4RString* _mqtthostname;
static Int _mqttport;
static bool _wificonnected;
static bool _mqttconnected;
static bool _mqtterror;
static B4R::B4RString* _wifi_ssid;
static B4R::B4RString* _wifi_pw;
static B4R::LolinPins* _espin;
static Int _relays;
static B4R::Array* _r;
static B4R::ByteConverter* _bc;
static B4R::Timer* _timer1;
static B4R::Timer* _timer2;
static Int _timerd;
static Int _retryd;
static Byte _conn_stat;
static ULong _laststatus;
static ULong _lasttask;
static UInt _rstatus;
static UInt _rset;
static Byte _i;
static B4R::Array* _rs;
static void _timer1_tick();
};

#endif