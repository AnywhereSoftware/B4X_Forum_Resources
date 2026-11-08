package b4j.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class client extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4j.objects.FxBA("b4j.example", "b4j.example.client", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.client.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 public anywheresoftware.b4a.keywords.Common __c = null;
public anywheresoftware.b4a.randomaccessfile.AsyncStreams _vvv7 = null;
public anywheresoftware.b4a.objects.SocketWrapper _vvv0 = null;
public int _vv1 = 0;
public int _vvvv1 = 0;
public String _vvvv2 = "";
public byte _vvvv3 = (byte)0;
public byte _apk_copy_start = (byte)0;
public byte _apk_packet = (byte)0;
public byte _apk_copy_close = (byte)0;
public byte _send_device_name = (byte)0;
public byte _apk_size = (byte)0;
public anywheresoftware.b4a.objects.Timer _vvvv4 = null;
public byte[] _vvvv5 = null;
public anywheresoftware.b4a.objects.streams.File.InputStreamWrapper _vvvv6 = null;
public boolean _vvvv7 = false;
public com.stevel05.draganddrop.transfermode _vv6 = null;
public b4j.example.main _main = null;
public String  _astream_error() throws Exception{
 //BA.debugLineNum = 97;BA.debugLine="Private Sub AStream_Error";
 //BA.debugLineNum = 99;BA.debugLine="End Sub";
return "";
}
public String  _astream_newdata(byte[] _buffer) throws Exception{
anywheresoftware.b4a.randomaccessfile.RandomAccessFile _raf = null;
 //BA.debugLineNum = 85;BA.debugLine="Private Sub AStream_NewData (Buffer() As Byte)";
 //BA.debugLineNum = 86;BA.debugLine="Dim raf As RandomAccessFile";
_raf = new anywheresoftware.b4a.randomaccessfile.RandomAccessFile();
 //BA.debugLineNum = 87;BA.debugLine="raf.Initialize3(Buffer, True)";
_raf.Initialize3(_buffer,__c.True);
 //BA.debugLineNum = 88;BA.debugLine="Select Buffer(0)";
switch (BA.switchObjectToInt(_buffer[(int) (0)],_vvvv3,_send_device_name)) {
case 0: {
 break; }
case 1: {
 //BA.debugLineNum = 93;BA.debugLine="Main.Client_Connected(Me)";
_main._client_connected /*String*/ ((b4j.example.client)(this));
 break; }
}
;
 //BA.debugLineNum = 95;BA.debugLine="End Sub";
return "";
}
public String  _astream_terminated() throws Exception{
 //BA.debugLineNum = 101;BA.debugLine="Private Sub AStream_Terminated";
 //BA.debugLineNum = 102;BA.debugLine="If allSent = False Then";
if (_vvvv7==__c.False) { 
 };
 //BA.debugLineNum = 105;BA.debugLine="End Sub";
return "";
}
public String  _class_globals() throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Private astream As AsyncStreams";
_vvv7 = new anywheresoftware.b4a.randomaccessfile.AsyncStreams();
 //BA.debugLineNum = 4;BA.debugLine="Private socket As Socket";
_vvv0 = new anywheresoftware.b4a.objects.SocketWrapper();
 //BA.debugLineNum = 5;BA.debugLine="Private const port As Int = 6789";
_vv1 = (int) (6789);
 //BA.debugLineNum = 6;BA.debugLine="Private attemptCounter As Int";
_vvvv1 = 0;
 //BA.debugLineNum = 7;BA.debugLine="Private mIP As String";
_vvvv2 = "";
 //BA.debugLineNum = 8;BA.debugLine="Private Const PING = 1, APK_COPY_START = 2, APK_P";
_vvvv3 = (byte) (1);
_apk_copy_start = (byte) (2);
_apk_packet = (byte) (3);
_apk_copy_close = (byte) (4);
_send_device_name = (byte) (5);
_apk_size = (byte) (14);
 //BA.debugLineNum = 10;BA.debugLine="Private SendTimer As Timer";
_vvvv4 = new anywheresoftware.b4a.objects.Timer();
 //BA.debugLineNum = 11;BA.debugLine="Private FileBuffer(81920) As Byte";
_vvvv5 = new byte[(int) (81920)];
;
 //BA.debugLineNum = 12;BA.debugLine="Private FileIn As InputStream";
_vvvv6 = new anywheresoftware.b4a.objects.streams.File.InputStreamWrapper();
 //BA.debugLineNum = 13;BA.debugLine="Private allSent As Boolean";
_vvvv7 = false;
 //BA.debugLineNum = 14;BA.debugLine="End Sub";
return "";
}
public String  _vvv5() throws Exception{
 //BA.debugLineNum = 23;BA.debugLine="Public Sub Close";
 //BA.debugLineNum = 24;BA.debugLine="socket.Close";
_vvv0.Close();
 //BA.debugLineNum = 25;BA.debugLine="astream.Close";
_vvv7.Close();
 //BA.debugLineNum = 26;BA.debugLine="End Sub";
return "";
}
public String  _initialize(anywheresoftware.b4a.BA _ba,String _ip) throws Exception{
innerInitialize(_ba);
 //BA.debugLineNum = 16;BA.debugLine="Public Sub Initialize (Ip As String)";
 //BA.debugLineNum = 17;BA.debugLine="mIP = Ip";
_vvvv2 = _ip;
 //BA.debugLineNum = 18;BA.debugLine="socket.Initialize(\"socket\")";
_vvv0.Initialize("socket");
 //BA.debugLineNum = 19;BA.debugLine="socket.Connect(mIP, port, 5000)";
_vvv0.Connect(ba,_vvvv2,_vv1,(int) (5000));
 //BA.debugLineNum = 20;BA.debugLine="SendTimer.Initialize(\"SendTimer\", 30)";
_vvvv4.Initialize(ba,"SendTimer",(long) (30));
 //BA.debugLineNum = 21;BA.debugLine="End Sub";
return "";
}
public String  _sendcompleted() throws Exception{
 //BA.debugLineNum = 67;BA.debugLine="Private Sub SendCompleted";
 //BA.debugLineNum = 69;BA.debugLine="Close";
_vvv5();
 //BA.debugLineNum = 70;BA.debugLine="Main.SendCompleted(Me)";
_main._sendcompleted /*String*/ ((b4j.example.client)(this));
 //BA.debugLineNum = 71;BA.debugLine="End Sub";
return "";
}
public String  _vvv6(String _f) throws Exception{
byte[] _size = null;
anywheresoftware.b4a.randomaccessfile.RandomAccessFile _raf = null;
 //BA.debugLineNum = 73;BA.debugLine="Public Sub SendFile (f As String)";
 //BA.debugLineNum = 74;BA.debugLine="Dim size(5) As Byte";
_size = new byte[(int) (5)];
;
 //BA.debugLineNum = 75;BA.debugLine="Dim raf As RandomAccessFile";
_raf = new anywheresoftware.b4a.randomaccessfile.RandomAccessFile();
 //BA.debugLineNum = 76;BA.debugLine="raf.Initialize3(size, True)";
_raf.Initialize3(_size,__c.True);
 //BA.debugLineNum = 77;BA.debugLine="raf.WriteByte(APK_SIZE, raf.CurrentPosition)";
_raf.WriteByte(_apk_size,_raf.CurrentPosition);
 //BA.debugLineNum = 78;BA.debugLine="raf.WriteInt(File.Size(f, \"\"), raf.CurrentPositio";
_raf.WriteInt((int) (__c.File.Size(_f,"")),_raf.CurrentPosition);
 //BA.debugLineNum = 79;BA.debugLine="astream.Write(size)";
_vvv7.Write(_size);
 //BA.debugLineNum = 80;BA.debugLine="astream.Write(Array As Byte(APK_COPY_START))";
_vvv7.Write(new byte[]{_apk_copy_start});
 //BA.debugLineNum = 81;BA.debugLine="FileIn = File.OpenInput(f, \"\")";
_vvvv6 = __c.File.OpenInput(_f,"");
 //BA.debugLineNum = 82;BA.debugLine="SendTimer.Enabled = True";
_vvvv4.setEnabled(__c.True);
 //BA.debugLineNum = 83;BA.debugLine="End Sub";
return "";
}
public String  _sendtimer_tick() throws Exception{
int _c = 0;
 //BA.debugLineNum = 44;BA.debugLine="Private Sub SendTimer_Tick";
 //BA.debugLineNum = 45;BA.debugLine="Try";
try { //BA.debugLineNum = 46;BA.debugLine="If allSent Then";
if (_vvvv7) { 
 //BA.debugLineNum = 47;BA.debugLine="If astream.OutputQueueSize = 0 Then";
if (_vvv7.getOutputQueueSize()==0) { 
 //BA.debugLineNum = 48;BA.debugLine="SendTimer.Enabled = False";
_vvvv4.setEnabled(__c.False);
 //BA.debugLineNum = 49;BA.debugLine="Main.csu.CallSubPlus(Me, \"SendCompleted\", 500)";
_main._v6 /*b4j.example.callsubutils*/ ._vvv1 /*b4j.example.callsubutils._rundelayeddata*/ (this,"SendCompleted",(int) (500));
 };
 //BA.debugLineNum = 51;BA.debugLine="Return";
if (true) return "";
 };
 //BA.debugLineNum = 53;BA.debugLine="If astream.OutputQueueSize > 50 Then Return";
if (_vvv7.getOutputQueueSize()>50) { 
if (true) return "";};
 //BA.debugLineNum = 54;BA.debugLine="Dim c As Int = FileIn.ReadBytes(FileBuffer, 1, F";
_c = _vvvv6.ReadBytes(_vvvv5,(int) (1),(int) (_vvvv5.length-1));
 //BA.debugLineNum = 55;BA.debugLine="If c <= 0 Then";
if (_c<=0) { 
 //BA.debugLineNum = 56;BA.debugLine="astream.Write(Array As Byte(APK_COPY_CLOSE))";
_vvv7.Write(new byte[]{_apk_copy_close});
 //BA.debugLineNum = 57;BA.debugLine="allSent = True";
_vvvv7 = __c.True;
 }else {
 //BA.debugLineNum = 59;BA.debugLine="FileBuffer(0) = APK_PACKET";
_vvvv5[(int) (0)] = _apk_packet;
 //BA.debugLineNum = 60;BA.debugLine="astream.Write2(FileBuffer, 0, c + 1)";
_vvv7.Write2(_vvvv5,(int) (0),(int) (_c+1));
 };
 } 
       catch (Exception e19) {
			ba.setLastException(e19); //BA.debugLineNum = 63;BA.debugLine="Close";
_vvv5();
 };
 //BA.debugLineNum = 65;BA.debugLine="End Sub";
return "";
}
public String  _socket_connected(boolean _successful) throws Exception{
 //BA.debugLineNum = 28;BA.debugLine="Private Sub socket_Connected (Successful As Boolea";
 //BA.debugLineNum = 29;BA.debugLine="If Successful = False Then";
if (_successful==__c.False) { 
 //BA.debugLineNum = 30;BA.debugLine="attemptCounter = attemptCounter  + 1";
_vvvv1 = (int) (_vvvv1+1);
 //BA.debugLineNum = 31;BA.debugLine="If attemptCounter = 1 Then";
if (_vvvv1==1) { 
 //BA.debugLineNum = 32;BA.debugLine="socket.Initialize(\"socket\")";
_vvv0.Initialize("socket");
 //BA.debugLineNum = 33;BA.debugLine="socket.Connect(mIP, port + 117, 5000)";
_vvv0.Connect(ba,_vvvv2,(int) (_vv1+117),(int) (5000));
 }else {
 //BA.debugLineNum = 36;BA.debugLine="ExitApplication2(1)";
__c.ExitApplication2((int) (1));
 };
 }else {
 //BA.debugLineNum = 39;BA.debugLine="astream.InitializePrefix(socket.InputStream, Fal";
_vvv7.InitializePrefix(ba,_vvv0.getInputStream(),__c.False,_vvv0.getOutputStream(),"astream");
 };
 //BA.debugLineNum = 42;BA.debugLine="End Sub";
return "";
}
public Object callSub(String sub, Object sender, Object[] args) throws Exception {
BA.senderHolder.set(sender);
if (BA.fastSubCompare(sub, "SENDCOMPLETED"))
	return _sendcompleted();
return BA.SubDelegator.SubNotFound;
}
}
