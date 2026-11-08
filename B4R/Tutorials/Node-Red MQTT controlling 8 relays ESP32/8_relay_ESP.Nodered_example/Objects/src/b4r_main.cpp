#include "B4RDefines.h"

B4R::Serial* b4r_main::_serial1;
B4R::AsyncStreams* b4r_main::_astream;
B4R::B4RESPWiFi* b4r_main::_wifi;
B4R::WiFiSocket* b4r_main::_wifistr;
B4R::MqttClient* b4r_main::_mqtt;
B4R::MqttConnectOptions* b4r_main::_mqttopt;
B4R::B4RString* b4r_main::_mqttuser;
B4R::B4RString* b4r_main::_mqttpassword;
B4R::B4RString* b4r_main::_mqtthostname;
Int b4r_main::_mqttport;
bool b4r_main::_wificonnected;
bool b4r_main::_mqttconnected;
bool b4r_main::_mqtterror;
B4R::B4RString* b4r_main::_wifi_ssid;
B4R::B4RString* b4r_main::_wifi_pw;
B4R::LolinPins* b4r_main::_espin;
Int b4r_main::_relays;
B4R::Array* b4r_main::_r;
B4R::ByteConverter* b4r_main::_bc;
B4R::Timer* b4r_main::_timer1;
B4R::Timer* b4r_main::_timer2;
Int b4r_main::_timerd;
Int b4r_main::_retryd;
Byte b4r_main::_conn_stat;
ULong b4r_main::_laststatus;
ULong b4r_main::_lasttask;
UInt b4r_main::_rstatus;
UInt b4r_main::_rset;
Byte b4r_main::_i;
B4R::Array* b4r_main::_rs;
static B4R::Serial be_gann1_3;
static B4R::AsyncStreams be_gann2_3;
static B4R::B4RESPWiFi be_gann3_3;
static B4R::WiFiSocket be_gann4_3;
static B4R::MqttClient be_gann5_3;
static B4R::MqttConnectOptions be_gann6_3;
static B4R::B4RString be_gann7_5;
static B4R::B4RString be_gann8_5;
static B4R::B4RString be_gann9_5;
static B4R::B4RString be_gann14_5;
static B4R::B4RString be_gann15_5;
static B4R::LolinPins be_gann16_3;
static B4R::Pin be_gann18_4e1[8];
static B4R::Array be_gann18_4e2;
static B4R::Pin* be_gann18_4e3[8];
static B4R::ByteConverter be_gann20_3;
static B4R::Timer be_gann21_3;
static B4R::Timer be_gann21_7;
static Byte be_gann29_4e1[1];
static B4R::Array be_gann29_4e2;


 void b4r_main::_appstart(){
const UInt cp = B4R::StackMemory::cp;
 //BA.debugLineNum = 89;BA.debugLine="Private Sub AppStart";
 //BA.debugLineNum = 90;BA.debugLine="Serial1.Initialize(115200)";
b4r_main::_serial1->Initialize((ULong) (115200));
 //BA.debugLineNum = 91;BA.debugLine="Delay(1000)";
Common_Delay((ULong) (1000));
 //BA.debugLineNum = 92;BA.debugLine="Log(\"AppStart\")";
B4R::Common::LogHelper(1,102,F("AppStart"));
 //BA.debugLineNum = 98;BA.debugLine="R(0).Initialize(ESPin.D15, R(0).MODE_OUTPUT) '";
((B4R::Pin**)b4r_main::_r->getData((UInt) (0)))[B4R::Array::staticIndex]->Initialize(b4r_main::_espin->D15,Pin_MODE_OUTPUT);
 //BA.debugLineNum = 99;BA.debugLine="R(1).Initialize(ESPin.D2, R(1).MODE_OUTPUT) '";
((B4R::Pin**)b4r_main::_r->getData((UInt) (1)))[B4R::Array::staticIndex]->Initialize(b4r_main::_espin->D2,Pin_MODE_OUTPUT);
 //BA.debugLineNum = 100;BA.debugLine="R(2).Initialize(ESPin.D0, R(2).MODE_OUTPUT) '";
((B4R::Pin**)b4r_main::_r->getData((UInt) (2)))[B4R::Array::staticIndex]->Initialize(b4r_main::_espin->D0,Pin_MODE_OUTPUT);
 //BA.debugLineNum = 101;BA.debugLine="R(3).Initialize(ESPin.D4, R(3).MODE_OUTPUT) '";
((B4R::Pin**)b4r_main::_r->getData((UInt) (3)))[B4R::Array::staticIndex]->Initialize(b4r_main::_espin->D4,Pin_MODE_OUTPUT);
 //BA.debugLineNum = 102;BA.debugLine="R(4).Initialize(ESPin.D16, R(4).MODE_OUTPUT) '";
((B4R::Pin**)b4r_main::_r->getData((UInt) (4)))[B4R::Array::staticIndex]->Initialize(b4r_main::_espin->D16,Pin_MODE_OUTPUT);
 //BA.debugLineNum = 103;BA.debugLine="R(5).Initialize(ESPin.D17, R(5).MODE_OUTPUT) '";
((B4R::Pin**)b4r_main::_r->getData((UInt) (5)))[B4R::Array::staticIndex]->Initialize(b4r_main::_espin->D17,Pin_MODE_OUTPUT);
 //BA.debugLineNum = 104;BA.debugLine="R(6).Initialize(ESPin.D5, R(6).MODE_OUTPUT) '";
((B4R::Pin**)b4r_main::_r->getData((UInt) (6)))[B4R::Array::staticIndex]->Initialize(b4r_main::_espin->D5,Pin_MODE_OUTPUT);
 //BA.debugLineNum = 105;BA.debugLine="R(7).Initialize(ESPin.D13, R(7).MODE_OUTPUT) '";
((B4R::Pin**)b4r_main::_r->getData((UInt) (7)))[B4R::Array::staticIndex]->Initialize(b4r_main::_espin->D13,Pin_MODE_OUTPUT);
 //BA.debugLineNum = 110;BA.debugLine="ClearAllReg";
_clearallreg();
 //BA.debugLineNum = 112;BA.debugLine="AStream.Initialize(Serial1.Stream, \"Astream_Ne";
b4r_main::_astream->Initialize(b4r_main::_serial1->getStream(),_astream_newdata,_astream_error);
 //BA.debugLineNum = 127;BA.debugLine="Timer1.Initialize(\"Timer1_Tick\", 1000)";
b4r_main::_timer1->Initialize(_timer1_tick,(ULong) (1000));
 //BA.debugLineNum = 128;BA.debugLine="Timer1.Enabled = True 'don't forget to enable it";
b4r_main::_timer1->setEnabled(Common_True);
 //BA.debugLineNum = 133;BA.debugLine="End Sub";
B4R::StackMemory::cp = cp;
}
void b4r_main::_astream_error(){
const UInt cp = B4R::StackMemory::cp;
 //BA.debugLineNum = 291;BA.debugLine="Sub AStream_Error ()";
 //BA.debugLineNum = 292;BA.debugLine="Log(\"error\")";
B4R::Common::LogHelper(1,102,F("error"));
 //BA.debugLineNum = 293;BA.debugLine="End Sub";
B4R::StackMemory::cp = cp;
}
void b4r_main::_astream_newdata(B4R::Array* _buffer){
const UInt cp = B4R::StackMemory::cp;
B4R::Object be_ann146_4;
 //BA.debugLineNum = 287;BA.debugLine="Sub Astream_NewData (Buffer() As Byte)";
 //BA.debugLineNum = 288;BA.debugLine="Log(\"Received: \", Buffer)";
B4R::Common::LogHelper(2,102,F("Received: "),100,be_ann146_4.wrapPointer(_buffer));
 //BA.debugLineNum = 289;BA.debugLine="End Sub";
B4R::StackMemory::cp = cp;
}
bool b4r_main::_broakerrelaysstausupdate(UInt _status){
const UInt cp = B4R::StackMemory::cp;
B4R::B4RString be_ann154_5;
 //BA.debugLineNum = 297;BA.debugLine="Private Sub BroakerRelaysStausUpdate (Status As UI";
 //BA.debugLineNum = 299;BA.debugLine="RS(0) = Bit.LowByte(Status)";
((Byte*)b4r_main::_rs->getData((UInt) (0)))[B4R::Array::staticIndex] = BitClass_LowByte(_status);
 //BA.debugLineNum = 300;BA.debugLine="Log(\"RS \", RS(0))";
B4R::Common::LogHelper(2,102,F("RS "),1,((Byte*)b4r_main::_rs->getData((UInt) (0)))[B4R::Array::staticIndex]);
 //BA.debugLineNum = 301;BA.debugLine="Return MQTT.Publish(\"Relay_Status\" , RS)";
B4R::StackMemory::cp = cp;
bool res3 = b4r_main::_mqtt->Publish(be_ann154_5.wrap("Relay_Status"),b4r_main::_rs);
if (true) return res3;
 //BA.debugLineNum = 303;BA.debugLine="End Sub";
B4R::StackMemory::cp = cp;
return false;
}
void b4r_main::_clearallreg(){
const UInt cp = B4R::StackMemory::cp;
 //BA.debugLineNum = 306;BA.debugLine="Private Sub ClearAllReg()";
 //BA.debugLineNum = 308;BA.debugLine="For i = 0 To Relays -1";
{
const int step1 = 1;
const int limit1 = (Byte) (b4r_main::_relays-1);
b4r_main::_i = (Byte) (0) ;
for (;b4r_main::_i <= limit1 ;b4r_main::_i = ((Byte)(0 + b4r_main::_i + step1))  ) {
 //BA.debugLineNum = 309;BA.debugLine="R(i).DigitalWrite(True)";
((B4R::Pin**)b4r_main::_r->getData((UInt) (b4r_main::_i)))[B4R::Array::staticIndex]->DigitalWrite(Common_True);
 }
};
 //BA.debugLineNum = 312;BA.debugLine="RStatus = 0xff				'default condition";
b4r_main::_rstatus = (UInt) (0xff);
 //BA.debugLineNum = 323;BA.debugLine="End Sub";
B4R::StackMemory::cp = cp;
}
void b4r_main::_mqtt_disconnected(){
const UInt cp = B4R::StackMemory::cp;
 //BA.debugLineNum = 279;BA.debugLine="Sub MQTT_Disconnected ()";
 //BA.debugLineNum = 281;BA.debugLine="MQTT.Close";
b4r_main::_mqtt->Close();
 //BA.debugLineNum = 282;BA.debugLine="MQTTconnected = False";
b4r_main::_mqttconnected = Common_False;
 //BA.debugLineNum = 283;BA.debugLine="MQTTError = False";
b4r_main::_mqtterror = Common_False;
 //BA.debugLineNum = 285;BA.debugLine="End Sub";
B4R::StackMemory::cp = cp;
}
void b4r_main::_mqtt_messagearrived(B4R::B4RString* _topic,B4R::Array* _payload){
const UInt cp = B4R::StackMemory::cp;
B4R::Object be_ann113_8;
UInt _relaynewstatus = 0;
bool _newrelaystatus = false;
B4R::Object be_ann117_2;
B4R::Object be_ann118_1;
B4R::Object be_ann136_1;
 //BA.debugLineNum = 234;BA.debugLine="Sub MQTT_MessageArrived (Topic As String, Payload(";
 //BA.debugLineNum = 235;BA.debugLine="Log(\"Topic = \", Topic, \" and Payload = \", Payload";
B4R::Common::LogHelper(4,102,F("Topic = "),101,_topic->data,102,F(" and Payload = "),100,be_ann113_8.wrapPointer(_payload));
 //BA.debugLineNum = 238;BA.debugLine="Dim RelayNewStatus As UInt = BC.StringFromBytes(P";
_relaynewstatus = (UInt)(atof(b4r_main::_bc->StringFromBytes(_payload)->data));
 //BA.debugLineNum = 239;BA.debugLine="Log(\"RelayNewStatus \",RelayNewStatus)";
B4R::Common::LogHelper(2,102,F("RelayNewStatus "),4,_relaynewstatus);
 //BA.debugLineNum = 244;BA.debugLine="Dim NewRelayStatus As Boolean";
_newrelaystatus = false;
 //BA.debugLineNum = 245;BA.debugLine="Select Case Topic";
switch (B4R::BR::switchObjectToInt(3,be_ann117_2.wrapPointer(_topic->data),be_ann118_1.wrapPointer("Relay_Set"),be_ann136_1.wrapPointer("RelayStatusRequest"))) {
case 0: {
 //BA.debugLineNum = 248;BA.debugLine="RSet = Bit.Xor (RelayNewStatus, RStatus) 'find";
b4r_main::_rset = BitClass_Xor(_relaynewstatus,b4r_main::_rstatus);
 //BA.debugLineNum = 251;BA.debugLine="RStatus = RelayNewStatus				 'save request for";
b4r_main::_rstatus = _relaynewstatus;
 //BA.debugLineNum = 253;BA.debugLine="If RSet <> 0 Then				         'some bi";
if (b4r_main::_rset!=0) { 
 //BA.debugLineNum = 254;BA.debugLine="For i = 0 To (Relays - 1)";
{
const int step10 = 1;
const int limit10 = (Byte) ((b4r_main::_relays-1));
b4r_main::_i = (Byte) (0) ;
for (;b4r_main::_i <= limit10 ;b4r_main::_i = ((Byte)(0 + b4r_main::_i + step10))  ) {
 //BA.debugLineNum = 256;BA.debugLine="If Bit.Get(RSet,i) <> 0 Then";
if (BitClass_Get((Byte) (b4r_main::_rset),b4r_main::_i)!=0) { 
 //BA.debugLineNum = 258;BA.debugLine="If Bit.Get(RStatus, i) <> 0 Then";
if (BitClass_Get((Byte) (b4r_main::_rstatus),b4r_main::_i)!=0) { 
 //BA.debugLineNum = 259;BA.debugLine="NewRelayStatus = True";
_newrelaystatus = Common_True;
 }else {
 //BA.debugLineNum = 261;BA.debugLine="NewRelayStatus = False";
_newrelaystatus = Common_False;
 };
 //BA.debugLineNum = 263;BA.debugLine="R(i).DigitalWrite(NewRelayStatus)";
((B4R::Pin**)b4r_main::_r->getData((UInt) (b4r_main::_i)))[B4R::Array::staticIndex]->DigitalWrite(_newrelaystatus);
 };
 }
};
 //BA.debugLineNum = 266;BA.debugLine="BroakerRelaysStausUpdate (RStatus)";
_broakerrelaysstausupdate(b4r_main::_rstatus);
 };
 //BA.debugLineNum = 268;BA.debugLine="Log(\"Rset \", RSet)";
B4R::Common::LogHelper(2,102,F("Rset "),4,b4r_main::_rset);
 //BA.debugLineNum = 269;BA.debugLine="Log(\"RStatus \", RStatus)";
B4R::Common::LogHelper(2,102,F("RStatus "),4,b4r_main::_rstatus);
 break; }
case 1: {
 //BA.debugLineNum = 272;BA.debugLine="BroakerRelaysStausUpdate (RStatus)";
_broakerrelaysstausupdate(b4r_main::_rstatus);
 break; }
}
;
 //BA.debugLineNum = 276;BA.debugLine="End Sub";
B4R::StackMemory::cp = cp;
}

void b4r_main::initializeProcessGlobals() {
     B4R::StackMemory::buffer = (byte*)malloc(STACK_BUFFER_SIZE);
     b4r_main::_process_globals();

   
}
void b4r_main::_process_globals(){
const UInt cp = B4R::StackMemory::cp;
 //BA.debugLineNum = 19;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 25;BA.debugLine="Public Serial1 As Serial";
b4r_main::_serial1 = &be_gann1_3;
 //BA.debugLineNum = 27;BA.debugLine="Private AStream As AsyncStreams";
b4r_main::_astream = &be_gann2_3;
 //BA.debugLineNum = 28;BA.debugLine="Private WiFi As ESP8266WiFi";
b4r_main::_wifi = &be_gann3_3;
 //BA.debugLineNum = 29;BA.debugLine="Private WiFiStr As WiFiSocket";
b4r_main::_wifistr = &be_gann4_3;
 //BA.debugLineNum = 30;BA.debugLine="Private MQTT As MqttClient";
b4r_main::_mqtt = &be_gann5_3;
 //BA.debugLineNum = 31;BA.debugLine="Private MQTTOpt As MqttConnectOptions";
b4r_main::_mqttopt = &be_gann6_3;
 //BA.debugLineNum = 32;BA.debugLine="Private MQTTUser As String = \"Tiziano\"";
b4r_main::_mqttuser = be_gann7_5.wrap("Tiziano");
 //BA.debugLineNum = 33;BA.debugLine="Private MQTTPassword As String = \"Deodato\"";
b4r_main::_mqttpassword = be_gann8_5.wrap("Deodato");
 //BA.debugLineNum = 34;BA.debugLine="Private MQTTHostName As String = \"192.168.1.4\"";
b4r_main::_mqtthostname = be_gann9_5.wrap("192.168.1.4");
 //BA.debugLineNum = 35;BA.debugLine="Private MQTTPort As Int = 1883";
b4r_main::_mqttport = 1883;
 //BA.debugLineNum = 37;BA.debugLine="Private WiFiconnected  As Boolean = False";
b4r_main::_wificonnected = Common_False;
 //BA.debugLineNum = 38;BA.debugLine="Private MQTTconnected  As Boolean = False";
b4r_main::_mqttconnected = Common_False;
 //BA.debugLineNum = 39;BA.debugLine="Private MQTTError As Boolean = False";
b4r_main::_mqtterror = Common_False;
 //BA.debugLineNum = 41;BA.debugLine="Private WiFi_SSID As String = \"FRITZ!Box 7530 BS_";
b4r_main::_wifi_ssid = be_gann14_5.wrap("FRITZ!Box 7530 BS_EXT");
 //BA.debugLineNum = 42;BA.debugLine="Private WiFi_PW As String = \"Berbatim$0\"";
b4r_main::_wifi_pw = be_gann15_5.wrap("Berbatim$0");
 //BA.debugLineNum = 46;BA.debugLine="Private ESPin As LolinPins";
b4r_main::_espin = &be_gann16_3;
 //BA.debugLineNum = 48;BA.debugLine="Private Relays As Int = 8";
b4r_main::_relays = 8;
 //BA.debugLineNum = 51;BA.debugLine="Private R(8) As Pin";
b4r_main::_r =be_gann18_4e2.wrapObjects((void**)be_gann18_4e3,be_gann18_4e1,8, sizeof(B4R::Pin));
 //BA.debugLineNum = 53;BA.debugLine="Private Relays As Int = 8";
b4r_main::_relays = 8;
 //BA.debugLineNum = 56;BA.debugLine="Private BC As ByteConverter";
b4r_main::_bc = &be_gann20_3;
 //BA.debugLineNum = 59;BA.debugLine="Private Timer1, Timer2 As Timer";
b4r_main::_timer1 = &be_gann21_3;
b4r_main::_timer2 = &be_gann21_7;
 //BA.debugLineNum = 61;BA.debugLine="Private TimerD As Int = 0";
b4r_main::_timerd = 0;
 //BA.debugLineNum = 62;BA.debugLine="Private const RetryD As Int = 5";
b4r_main::_retryd = 5;
 //BA.debugLineNum = 68;BA.debugLine="Private conn_stat As Byte = 0           ' Conn";
b4r_main::_conn_stat = (Byte) (0);
 //BA.debugLineNum = 77;BA.debugLine="Private lastStatus As ULong = 0 			'counter in ex";
b4r_main::_laststatus = (ULong) (0);
 //BA.debugLineNum = 78;BA.debugLine="Private lastTask As ULong = 0               'coun";
b4r_main::_lasttask = (ULong) (0);
 //BA.debugLineNum = 80;BA.debugLine="Public RStatus, RSet As UInt";
b4r_main::_rstatus = 0;
b4r_main::_rset = 0;
 //BA.debugLineNum = 81;BA.debugLine="Private i As Byte";
b4r_main::_i = 0;
 //BA.debugLineNum = 82;BA.debugLine="Private RS(1) As Byte";
b4r_main::_rs =be_gann29_4e2.wrap(be_gann29_4e1,1);
 //BA.debugLineNum = 87;BA.debugLine="End Sub";
}
void b4r_main::_timer1_tick(){
const UInt cp = B4R::StackMemory::cp;
B4R::B4RString* _clientid = B4R::B4RString::EMPTY;
B4R::B4RString be_ann90_12;
B4R::B4RString be_ann91_12;
 //BA.debugLineNum = 142;BA.debugLine="Private Sub Timer1_Tick";
 //BA.debugLineNum = 145;BA.debugLine="If TimerD > 0 Then";
if (b4r_main::_timerd>0) { 
 //BA.debugLineNum = 146;BA.debugLine="TimerD = TimerD -1";
b4r_main::_timerd = (Int) (b4r_main::_timerd-1);
 //BA.debugLineNum = 147;BA.debugLine="Log (\"wait \",TimerD)";
B4R::Common::LogHelper(2,102,F("wait "),3,b4r_main::_timerd);
 //BA.debugLineNum = 148;BA.debugLine="Return";
B4R::StackMemory::cp = cp;
if (true) return ;
 };
 //BA.debugLineNum = 150;BA.debugLine="WiFiconnected = WiFi.IsConnected";
b4r_main::_wificonnected = b4r_main::_wifi->getIsConnected();
 //BA.debugLineNum = 153;BA.debugLine="If Not(WiFiconnected) Then conn_stat = 0";
if (Common_Not(b4r_main::_wificonnected)) { 
b4r_main::_conn_stat = (Byte) (0);};
 //BA.debugLineNum = 154;BA.debugLine="If WiFiconnected And Not(MQTTconnected) And (conn";
if (b4r_main::_wificonnected && Common_Not(b4r_main::_mqttconnected) && (b4r_main::_conn_stat>2)) { 
b4r_main::_conn_stat = (Byte) (2);};
 //BA.debugLineNum = 155;BA.debugLine="If WiFiconnected And MQTTconnected And (conn_stat";
if (b4r_main::_wificonnected && b4r_main::_mqttconnected && (b4r_main::_conn_stat!=4)) { 
b4r_main::_conn_stat = (Byte) (3);};
 //BA.debugLineNum = 158;BA.debugLine="Select conn_stat";
switch ((Int) (b4r_main::_conn_stat)) {
case 0: {
 //BA.debugLineNum = 161;BA.debugLine="Log (\"MQTT and WiFi down: start WiFi \", conn_sta";
B4R::Common::LogHelper(2,102,F("MQTT and WiFi down: start WiFi "),1,b4r_main::_conn_stat);
 //BA.debugLineNum = 162;BA.debugLine="WiFi.disconnect()";
b4r_main::_wifi->Disconnect();
 //BA.debugLineNum = 163;BA.debugLine="Delay(100)";
Common_Delay((ULong) (100));
 //BA.debugLineNum = 164;BA.debugLine="If WiFi.Connect2(WiFi_SSID, WiFi_PW) Then";
if (b4r_main::_wifi->Connect2(b4r_main::_wifi_ssid,b4r_main::_wifi_pw)) { 
 //BA.debugLineNum = 165;BA.debugLine="conn_stat = 1";
b4r_main::_conn_stat = (Byte) (1);
 }else {
 //BA.debugLineNum = 167;BA.debugLine="TimerD = RetryD";
b4r_main::_timerd = b4r_main::_retryd;
 };
 break; }
case 1: {
 //BA.debugLineNum = 170;BA.debugLine="If WiFiconnected Then";
if (b4r_main::_wificonnected) { 
 //BA.debugLineNum = 171;BA.debugLine="conn_stat = 2";
b4r_main::_conn_stat = (Byte) (2);
 //BA.debugLineNum = 172;BA.debugLine="Log (\"WiFi start\")";
B4R::Common::LogHelper(1,102,F("WiFi start"));
 }else {
 //BA.debugLineNum = 174;BA.debugLine="conn_stat = 0";
b4r_main::_conn_stat = (Byte) (0);
 };
 //BA.debugLineNum = 176;BA.debugLine="TimerD = RetryD			'wait few seconds";
b4r_main::_timerd = b4r_main::_retryd;
 break; }
case 2: {
 //BA.debugLineNum = 178;BA.debugLine="Log (\"WiFi up, MQTT down: start MQTT \", conn_sta";
B4R::Common::LogHelper(2,102,F("WiFi up, MQTT down: start MQTT "),1,b4r_main::_conn_stat);
 //BA.debugLineNum = 180;BA.debugLine="Dim ClientId As String = Rnd(0, 999999999) 'crea";
_clientid = B4R::B4RString::fromNumber((Long)(Common_Rnd((Long) (0),(Long) (999999999))));
 //BA.debugLineNum = 181;BA.debugLine="MQTT.Initialize2(WiFiStr.stream, MQTTHostName, M";
b4r_main::_mqtt->Initialize2(b4r_main::_wifistr->getStream(),b4r_main::_mqtthostname,(UInt) (b4r_main::_mqttport),_clientid,_mqtt_messagearrived,_mqtt_disconnected);
 //BA.debugLineNum = 182;BA.debugLine="MQTTOpt.Initialize(MQTTUser, MQTTPassword)";
b4r_main::_mqttopt->Initialize(b4r_main::_mqttuser,b4r_main::_mqttpassword);
 //BA.debugLineNum = 183;BA.debugLine="MQTTconnected = MQTT.Connect2(MQTTOpt)";
b4r_main::_mqttconnected = b4r_main::_mqtt->Connect2(b4r_main::_mqttopt);
 //BA.debugLineNum = 184;BA.debugLine="If MQTTconnected Then";
if (b4r_main::_mqttconnected) { 
 //BA.debugLineNum = 185;BA.debugLine="conn_stat = 3";
b4r_main::_conn_stat = (Byte) (3);
 }else {
 //BA.debugLineNum = 187;BA.debugLine="conn_stat = 0  'if MQTT do not start, is better";
b4r_main::_conn_stat = (Byte) (0);
 //BA.debugLineNum = 188;BA.debugLine="TimerD = RetryD	'wait few second before retry";
b4r_main::_timerd = b4r_main::_retryd;
 };
 break; }
case 3: {
 //BA.debugLineNum = 191;BA.debugLine="Log (\"WiFi and MQTT up: make MQTT configuration";
B4R::Common::LogHelper(2,102,F("WiFi and MQTT up: make MQTT configuration "),1,b4r_main::_conn_stat);
 //BA.debugLineNum = 197;BA.debugLine="MQTTError = MQTTError Or Not(MQTT.Subscribe(\"Rel";
b4r_main::_mqtterror = b4r_main::_mqtterror || Common_Not(b4r_main::_mqtt->Subscribe(be_ann90_12.wrap("Relay_Set"),(Byte) (0)));
 //BA.debugLineNum = 198;BA.debugLine="MQTTError = MQTTError Or Not(MQTT.Subscribe(\"Re";
b4r_main::_mqtterror = b4r_main::_mqtterror || Common_Not(b4r_main::_mqtt->Subscribe(be_ann91_12.wrap("RelayStatusRequest"),(Byte) (0)));
 //BA.debugLineNum = 199;BA.debugLine="If MQTTError Then";
if (b4r_main::_mqtterror) { 
 //BA.debugLineNum = 200;BA.debugLine="Log (\"MQTT subscription error\")";
B4R::Common::LogHelper(1,102,F("MQTT subscription error"));
 //BA.debugLineNum = 201;BA.debugLine="MQTT_Disconnected";
_mqtt_disconnected();
 //BA.debugLineNum = 202;BA.debugLine="conn_stat = 2";
b4r_main::_conn_stat = (Byte) (2);
 //BA.debugLineNum = 203;BA.debugLine="TimerD = RetryD	'wait few second before retry";
b4r_main::_timerd = b4r_main::_retryd;
 }else {
 //BA.debugLineNum = 205;BA.debugLine="conn_stat = 4";
b4r_main::_conn_stat = (Byte) (4);
 //BA.debugLineNum = 206;BA.debugLine="BroakerRelaysStausUpdate (RStatus)";
_broakerrelaysstausupdate(b4r_main::_rstatus);
 };
 break; }
}
;
 //BA.debugLineNum = 212;BA.debugLine="If (conn_stat = 4) Then";
if ((b4r_main::_conn_stat==4)) { 
 //BA.debugLineNum = 213;BA.debugLine="If (Millis() - lastStatus > 10000) Then";
if ((Common_Millis()-b4r_main::_laststatus>10000)) { 
 //BA.debugLineNum = 214;BA.debugLine="Log(\"Running\")";
B4R::Common::LogHelper(1,102,F("Running"));
 //BA.debugLineNum = 217;BA.debugLine="lastStatus = Millis()";
b4r_main::_laststatus = Common_Millis();
 };
 };
 //BA.debugLineNum = 226;BA.debugLine="If (Millis() - lastTask > 1000) Then";
if ((Common_Millis()-b4r_main::_lasttask>1000)) { 
 //BA.debugLineNum = 228;BA.debugLine="lastTask = Millis()";
b4r_main::_lasttask = Common_Millis();
 };
 //BA.debugLineNum = 232;BA.debugLine="End Sub";
B4R::StackMemory::cp = cp;
}
