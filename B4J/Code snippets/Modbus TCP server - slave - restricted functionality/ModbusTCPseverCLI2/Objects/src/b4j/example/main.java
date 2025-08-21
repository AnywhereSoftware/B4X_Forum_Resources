package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;

public class main extends Object{
public static main mostCurrent = new main();

public static BA ba;
static {
		ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.main", null);
		ba.loadHtSubs(main.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			anywheresoftware.b4a.shell.ShellBA.delegateBA = new anywheresoftware.b4a.StandardBA("b4j.example", null, null);
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "b4j.example.main", ba);
		}
	}
    public static Class<?> getObject() {
		return main.class;
	}

 
    public static void main(String[] args) throws Exception{
        try {
            anywheresoftware.b4a.keywords.Common.LogDebug("Program started.");
            initializeProcessGlobals();
            ba.raiseEvent(null, "appstart", (Object)args);
        } catch (Throwable t) {
			BA.printException(t, true);
		
        } finally {
            anywheresoftware.b4a.keywords.Common.LogDebug("Program terminated (StartMessageLoop was not called).");
        }
    }


private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4a.randomaccessfile.AsyncStreams _astreams = null;
public static anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper _server = null;
public static anywheresoftware.b4a.objects.SocketWrapper _socket1 = null;
public static byte _slaveaddress = (byte)0;
public static short[] _holdreg = null;
public static byte[] _rxtransident = null;
public static byte[] _rxprotocolident = null;
public static byte[] _rxlength = null;
public static byte _rxunitidentifier = (byte)0;
public static byte _rxfunctioncode = (byte)0;
public static byte[] _rxfirstaddresregister = null;
public static byte[] _rxrange = null;
public static short _requestfirstaddresreg = (short)0;
public static short _requestrangereg = (short)0;
public static boolean  _application_error(anywheresoftware.b4a.objects.B4AException _error,String _stacktrace) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "application_error"))
	 {return ((Boolean) Debug.delegate(ba, "application_error", new Object[] {_error,_stacktrace}));}
RDebugUtils.currentLine=524288;
 //BA.debugLineNum = 524288;BA.debugLine="Sub Application_Error (Error As Exception, StackTr";
RDebugUtils.currentLine=524289;
 //BA.debugLineNum = 524289;BA.debugLine="Return True";
if (true) return anywheresoftware.b4a.keywords.Common.True;
RDebugUtils.currentLine=524290;
 //BA.debugLineNum = 524290;BA.debugLine="End Sub";
return false;
}
public static String  _appstart(String[] _args) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "appstart"))
	 {return ((String) Debug.delegate(ba, "appstart", new Object[] {_args}));}
RDebugUtils.currentLine=65536;
 //BA.debugLineNum = 65536;BA.debugLine="Sub AppStart (Args() As String)";
RDebugUtils.currentLine=65538;
 //BA.debugLineNum = 65538;BA.debugLine="Server.Initialize(502, \"Server\")";
_server.Initialize(ba,(int) (502),"Server");
RDebugUtils.currentLine=65539;
 //BA.debugLineNum = 65539;BA.debugLine="Server.Listen";
_server.Listen();
RDebugUtils.currentLine=65540;
 //BA.debugLineNum = 65540;BA.debugLine="Log(\"MyIp = \" & Server.GetMyIP)";
anywheresoftware.b4a.keywords.Common.Log("MyIp = "+_server.GetMyIP());
RDebugUtils.currentLine=65544;
 //BA.debugLineNum = 65544;BA.debugLine="HoldReg(0) = 123";
_holdreg[(int) (0)] = (short) (123);
RDebugUtils.currentLine=65545;
 //BA.debugLineNum = 65545;BA.debugLine="HoldReg(1) = 111";
_holdreg[(int) (1)] = (short) (111);
RDebugUtils.currentLine=65546;
 //BA.debugLineNum = 65546;BA.debugLine="HoldReg(2) = 222";
_holdreg[(int) (2)] = (short) (222);
RDebugUtils.currentLine=65547;
 //BA.debugLineNum = 65547;BA.debugLine="HoldReg(3) = 333";
_holdreg[(int) (3)] = (short) (333);
RDebugUtils.currentLine=65548;
 //BA.debugLineNum = 65548;BA.debugLine="HoldReg(4) = 444";
_holdreg[(int) (4)] = (short) (444);
RDebugUtils.currentLine=65549;
 //BA.debugLineNum = 65549;BA.debugLine="HoldReg(5) = 555";
_holdreg[(int) (5)] = (short) (555);
RDebugUtils.currentLine=65550;
 //BA.debugLineNum = 65550;BA.debugLine="HoldReg(200) = 888";
_holdreg[(int) (200)] = (short) (888);
RDebugUtils.currentLine=65554;
 //BA.debugLineNum = 65554;BA.debugLine="StartMessageLoop";
anywheresoftware.b4a.keywords.Common.StartMessageLoop(ba);
RDebugUtils.currentLine=65556;
 //BA.debugLineNum = 65556;BA.debugLine="End Sub";
return "";
}
public static String  _astreams_error() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "astreams_error"))
	 {return ((String) Debug.delegate(ba, "astreams_error", null));}
RDebugUtils.currentLine=393216;
 //BA.debugLineNum = 393216;BA.debugLine="Sub AStreams_Error";
RDebugUtils.currentLine=393217;
 //BA.debugLineNum = 393217;BA.debugLine="Log(LastException.Message)";
anywheresoftware.b4a.keywords.Common.Log(anywheresoftware.b4a.keywords.Common.LastException(ba).getMessage());
RDebugUtils.currentLine=393218;
 //BA.debugLineNum = 393218;BA.debugLine="Log(\"AStreams_Error\")";
anywheresoftware.b4a.keywords.Common.Log("AStreams_Error");
RDebugUtils.currentLine=393219;
 //BA.debugLineNum = 393219;BA.debugLine="End Sub";
return "";
}
public static String  _astreams_newdata(byte[] _buffer) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "astreams_newdata"))
	 {return ((String) Debug.delegate(ba, "astreams_newdata", new Object[] {_buffer}));}
RDebugUtils.currentLine=196608;
 //BA.debugLineNum = 196608;BA.debugLine="Sub AStreams_NewData (Buffer() As Byte)";
RDebugUtils.currentLine=196610;
 //BA.debugLineNum = 196610;BA.debugLine="ProcessRequest(Buffer)";
_processrequest(_buffer);
RDebugUtils.currentLine=196612;
 //BA.debugLineNum = 196612;BA.debugLine="End Sub";
return "";
}
public static String  _processrequest(byte[] _buffer2) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "processrequest"))
	 {return ((String) Debug.delegate(ba, "processrequest", new Object[] {_buffer2}));}
short _arraysize = (short)0;
byte[] _txbuffer = null;
byte[] _bmem = null;
byte[] _bmem2 = null;
byte[] _holdregasbytearr = null;
int _i = 0;
RDebugUtils.currentLine=262144;
 //BA.debugLineNum = 262144;BA.debugLine="Sub ProcessRequest(Buffer2() As Byte)";
RDebugUtils.currentLine=262145;
 //BA.debugLineNum = 262145;BA.debugLine="Try";
try {RDebugUtils.currentLine=262148;
 //BA.debugLineNum = 262148;BA.debugLine="If Buffer2.Length = 12 Then";
if (_buffer2.length==12) { 
RDebugUtils.currentLine=262151;
 //BA.debugLineNum = 262151;BA.debugLine="RxTransIdent(0) = Buffer2(0)";
_rxtransident[(int) (0)] = _buffer2[(int) (0)];
RDebugUtils.currentLine=262152;
 //BA.debugLineNum = 262152;BA.debugLine="RxTransIdent(1)= Buffer2(1)";
_rxtransident[(int) (1)] = _buffer2[(int) (1)];
RDebugUtils.currentLine=262153;
 //BA.debugLineNum = 262153;BA.debugLine="RxProtocolIdent(0)= Buffer2(2)";
_rxprotocolident[(int) (0)] = _buffer2[(int) (2)];
RDebugUtils.currentLine=262154;
 //BA.debugLineNum = 262154;BA.debugLine="RxProtocolIdent(1)= Buffer2(3)";
_rxprotocolident[(int) (1)] = _buffer2[(int) (3)];
RDebugUtils.currentLine=262155;
 //BA.debugLineNum = 262155;BA.debugLine="RxLength(0)= Buffer2(4)";
_rxlength[(int) (0)] = _buffer2[(int) (4)];
RDebugUtils.currentLine=262156;
 //BA.debugLineNum = 262156;BA.debugLine="RxLength(1)= Buffer2(5)";
_rxlength[(int) (1)] = _buffer2[(int) (5)];
RDebugUtils.currentLine=262157;
 //BA.debugLineNum = 262157;BA.debugLine="RxUnitIdentifier= Buffer2(6)";
_rxunitidentifier = _buffer2[(int) (6)];
RDebugUtils.currentLine=262158;
 //BA.debugLineNum = 262158;BA.debugLine="RxFunctionCode= Buffer2(7)";
_rxfunctioncode = _buffer2[(int) (7)];
RDebugUtils.currentLine=262159;
 //BA.debugLineNum = 262159;BA.debugLine="RxFirstAddresRegister(0) =  Buffer2(9) '! Byte s";
_rxfirstaddresregister[(int) (0)] = _buffer2[(int) (9)];
RDebugUtils.currentLine=262160;
 //BA.debugLineNum = 262160;BA.debugLine="RxFirstAddresRegister(1)= Buffer2(8)";
_rxfirstaddresregister[(int) (1)] = _buffer2[(int) (8)];
RDebugUtils.currentLine=262161;
 //BA.debugLineNum = 262161;BA.debugLine="RxRange(0) = Buffer2(11)'! Byte swapping";
_rxrange[(int) (0)] = _buffer2[(int) (11)];
RDebugUtils.currentLine=262162;
 //BA.debugLineNum = 262162;BA.debugLine="RxRange(1) = Buffer2(10)";
_rxrange[(int) (1)] = _buffer2[(int) (10)];
 };
RDebugUtils.currentLine=262167;
 //BA.debugLineNum = 262167;BA.debugLine="If RxProtocolIdent(0) <> 0 Or RxProtocolIdent(1)";
if (_rxprotocolident[(int) (0)]!=0 || _rxprotocolident[(int) (1)]!=0) { 
RDebugUtils.currentLine=262168;
 //BA.debugLineNum = 262168;BA.debugLine="Log( \"Illegal Protocol Identifier\")";
anywheresoftware.b4a.keywords.Common.Log("Illegal Protocol Identifier");
RDebugUtils.currentLine=262169;
 //BA.debugLineNum = 262169;BA.debugLine="Return 'exit sub";
if (true) return "";
 };
RDebugUtils.currentLine=262173;
 //BA.debugLineNum = 262173;BA.debugLine="If RxLength(0) <> 0 Or RxLength(1) <> 6 Then";
if (_rxlength[(int) (0)]!=0 || _rxlength[(int) (1)]!=6) { 
RDebugUtils.currentLine=262174;
 //BA.debugLineNum = 262174;BA.debugLine="Log( \"Illegal Length\")";
anywheresoftware.b4a.keywords.Common.Log("Illegal Length");
RDebugUtils.currentLine=262175;
 //BA.debugLineNum = 262175;BA.debugLine="Return'exit sub";
if (true) return "";
 };
RDebugUtils.currentLine=262179;
 //BA.debugLineNum = 262179;BA.debugLine="If RxFunctionCode <> 3  Then		'Only holding regi";
if (_rxfunctioncode!=3) { 
RDebugUtils.currentLine=262180;
 //BA.debugLineNum = 262180;BA.debugLine="Log( \"Illegal Function Code\")";
anywheresoftware.b4a.keywords.Common.Log("Illegal Function Code");
RDebugUtils.currentLine=262181;
 //BA.debugLineNum = 262181;BA.debugLine="Return'exit sub";
if (true) return "";
 };
RDebugUtils.currentLine=262185;
 //BA.debugLineNum = 262185;BA.debugLine="If RxUnitIdentifier <> slaveAddress  Then";
if (_rxunitidentifier!=_slaveaddress) { 
RDebugUtils.currentLine=262186;
 //BA.debugLineNum = 262186;BA.debugLine="Log( \"Illegal Unique Identifier - or Slave Addr";
anywheresoftware.b4a.keywords.Common.Log("Illegal Unique Identifier - or Slave Address Code");
RDebugUtils.currentLine=262187;
 //BA.debugLineNum = 262187;BA.debugLine="Return'exit sub";
if (true) return "";
 };
RDebugUtils.currentLine=262193;
 //BA.debugLineNum = 262193;BA.debugLine="RequestFirstAddresReg =  ByteToShort(RxFirstAddr";
_requestfirstaddresreg = _bytetoshort(_rxfirstaddresregister);
RDebugUtils.currentLine=262194;
 //BA.debugLineNum = 262194;BA.debugLine="RequestRangeReg = ByteToShort(RxRange)";
_requestrangereg = _bytetoshort(_rxrange);
RDebugUtils.currentLine=262197;
 //BA.debugLineNum = 262197;BA.debugLine="If RequestFirstAddresReg > 201 Then";
if (_requestfirstaddresreg>201) { 
RDebugUtils.currentLine=262198;
 //BA.debugLineNum = 262198;BA.debugLine="Log( \"Illegal adress requested\")";
anywheresoftware.b4a.keywords.Common.Log("Illegal adress requested");
RDebugUtils.currentLine=262199;
 //BA.debugLineNum = 262199;BA.debugLine="Return'exit sub";
if (true) return "";
 };
RDebugUtils.currentLine=262203;
 //BA.debugLineNum = 262203;BA.debugLine="If (RequestFirstAddresReg + RequestRangeReg) > 2";
if ((_requestfirstaddresreg+_requestrangereg)>201) { 
RDebugUtils.currentLine=262204;
 //BA.debugLineNum = 262204;BA.debugLine="Log( \"Requested range out of buffer size\")";
anywheresoftware.b4a.keywords.Common.Log("Requested range out of buffer size");
RDebugUtils.currentLine=262205;
 //BA.debugLineNum = 262205;BA.debugLine="Return'exit sub";
if (true) return "";
 };
RDebugUtils.currentLine=262214;
 //BA.debugLineNum = 262214;BA.debugLine="Dim ArraySize As Short";
_arraysize = (short)0;
RDebugUtils.currentLine=262215;
 //BA.debugLineNum = 262215;BA.debugLine="ArraySize = 9 + (RequestRangeReg * 2)";
_arraysize = (short) (9+(_requestrangereg*2));
RDebugUtils.currentLine=262219;
 //BA.debugLineNum = 262219;BA.debugLine="Dim  TxBuffer (ArraySize)   As Byte";
_txbuffer = new byte[(int) (_arraysize)];
;
RDebugUtils.currentLine=262222;
 //BA.debugLineNum = 262222;BA.debugLine="TxBuffer(0) = RxTransIdent(0)";
_txbuffer[(int) (0)] = _rxtransident[(int) (0)];
RDebugUtils.currentLine=262223;
 //BA.debugLineNum = 262223;BA.debugLine="TxBuffer(1) = RxTransIdent(1)";
_txbuffer[(int) (1)] = _rxtransident[(int) (1)];
RDebugUtils.currentLine=262225;
 //BA.debugLineNum = 262225;BA.debugLine="TxBuffer(2) = 0";
_txbuffer[(int) (2)] = (byte) (0);
RDebugUtils.currentLine=262226;
 //BA.debugLineNum = 262226;BA.debugLine="TxBuffer(3) = 0";
_txbuffer[(int) (3)] = (byte) (0);
RDebugUtils.currentLine=262229;
 //BA.debugLineNum = 262229;BA.debugLine="Dim bmem(2) As Byte = ShortToByte(RequestRangeRe";
_bmem = _shorttobyte((short) (_requestrangereg*2+3));
RDebugUtils.currentLine=262230;
 //BA.debugLineNum = 262230;BA.debugLine="TxBuffer(4) = bmem(1)";
_txbuffer[(int) (4)] = _bmem[(int) (1)];
RDebugUtils.currentLine=262231;
 //BA.debugLineNum = 262231;BA.debugLine="TxBuffer(5) = bmem(0)";
_txbuffer[(int) (5)] = _bmem[(int) (0)];
RDebugUtils.currentLine=262234;
 //BA.debugLineNum = 262234;BA.debugLine="TxBuffer(6) = slaveAddress";
_txbuffer[(int) (6)] = _slaveaddress;
RDebugUtils.currentLine=262237;
 //BA.debugLineNum = 262237;BA.debugLine="TxBuffer(7) = 3";
_txbuffer[(int) (7)] = (byte) (3);
RDebugUtils.currentLine=262241;
 //BA.debugLineNum = 262241;BA.debugLine="Dim bmem2(2) As Byte = ShortToByte((RequestRange";
_bmem2 = _shorttobyte((short) ((_requestrangereg*2)));
RDebugUtils.currentLine=262242;
 //BA.debugLineNum = 262242;BA.debugLine="TxBuffer(8) = bmem2(0)";
_txbuffer[(int) (8)] = _bmem2[(int) (0)];
RDebugUtils.currentLine=262247;
 //BA.debugLineNum = 262247;BA.debugLine="Dim HoldRegAsByteArr(2) As Byte";
_holdregasbytearr = new byte[(int) (2)];
;
RDebugUtils.currentLine=262248;
 //BA.debugLineNum = 262248;BA.debugLine="For i = 0 To (RequestRangeReg-1) Step 1";
{
final int step57 = 1;
final int limit57 = (int) ((_requestrangereg-1));
_i = (int) (0) ;
for (;_i <= limit57 ;_i = _i + step57 ) {
RDebugUtils.currentLine=262250;
 //BA.debugLineNum = 262250;BA.debugLine="HoldRegAsByteArr =ShortToByte(HoldReg((RequestF";
_holdregasbytearr = _shorttobyte(_holdreg[(int) ((_requestfirstaddresreg-1)+_i+1)]);
RDebugUtils.currentLine=262252;
 //BA.debugLineNum = 262252;BA.debugLine="TxBuffer(9+(i*2)) = HoldRegAsByteArr(1) '!Swap";
_txbuffer[(int) (9+(_i*2))] = _holdregasbytearr[(int) (1)];
RDebugUtils.currentLine=262253;
 //BA.debugLineNum = 262253;BA.debugLine="TxBuffer(10+(i*2)) = HoldRegAsByteArr(0)";
_txbuffer[(int) (10+(_i*2))] = _holdregasbytearr[(int) (0)];
 }
};
RDebugUtils.currentLine=262259;
 //BA.debugLineNum = 262259;BA.debugLine="SendResponse(TxBuffer)";
_sendresponse(_txbuffer);
 } 
       catch (Exception e64) {
			ba.setLastException(e64);RDebugUtils.currentLine=262263;
 //BA.debugLineNum = 262263;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.Log(BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)));
 };
RDebugUtils.currentLine=262266;
 //BA.debugLineNum = 262266;BA.debugLine="End Sub";
return "";
}
public static String  _astreams_terminated() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "astreams_terminated"))
	 {return ((String) Debug.delegate(ba, "astreams_terminated", null));}
RDebugUtils.currentLine=458752;
 //BA.debugLineNum = 458752;BA.debugLine="Sub AStreams_Terminated";
RDebugUtils.currentLine=458753;
 //BA.debugLineNum = 458753;BA.debugLine="Log(\"AStreams_Terminated\")";
anywheresoftware.b4a.keywords.Common.Log("AStreams_Terminated");
RDebugUtils.currentLine=458756;
 //BA.debugLineNum = 458756;BA.debugLine="End Sub";
return "";
}
public static short  _bytetoshort(byte[] _bytearray) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "bytetoshort"))
	 {return ((Short) Debug.delegate(ba, "bytetoshort", new Object[] {_bytearray}));}
anywheresoftware.b4a.agraham.byteconverter.ByteConverter _bc = null;
short _i = (short)0;
RDebugUtils.currentLine=589824;
 //BA.debugLineNum = 589824;BA.debugLine="Sub ByteToShort(ByteArray() As Byte) As Short";
RDebugUtils.currentLine=589826;
 //BA.debugLineNum = 589826;BA.debugLine="Dim bc As ByteConverter";
_bc = new anywheresoftware.b4a.agraham.byteconverter.ByteConverter();
RDebugUtils.currentLine=589827;
 //BA.debugLineNum = 589827;BA.debugLine="bc.LittleEndian = True";
_bc.setLittleEndian(anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=589828;
 //BA.debugLineNum = 589828;BA.debugLine="Dim i As Short = bc.shortsFromBytes(ByteArray)(0)";
_i = _bc.ShortsFromBytes(_bytearray)[(int) (0)];
RDebugUtils.currentLine=589830;
 //BA.debugLineNum = 589830;BA.debugLine="Return  i";
if (true) return _i;
RDebugUtils.currentLine=589832;
 //BA.debugLineNum = 589832;BA.debugLine="End Sub";
return (short)0;
}
public static byte[]  _shorttobyte(short _shortvalue) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "shorttobyte"))
	 {return ((byte[]) Debug.delegate(ba, "shorttobyte", new Object[] {_shortvalue}));}
anywheresoftware.b4a.agraham.byteconverter.ByteConverter _bc = null;
byte[] _b = null;
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="Sub ShortToByte(ShortValue As Short) As Byte()";
RDebugUtils.currentLine=655362;
 //BA.debugLineNum = 655362;BA.debugLine="Dim bc As ByteConverter";
_bc = new anywheresoftware.b4a.agraham.byteconverter.ByteConverter();
RDebugUtils.currentLine=655363;
 //BA.debugLineNum = 655363;BA.debugLine="bc.LittleEndian = True";
_bc.setLittleEndian(anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=655364;
 //BA.debugLineNum = 655364;BA.debugLine="Dim b() As Byte = bc.ShortsToBytes(Array As Short";
_b = _bc.ShortsToBytes(new short[]{_shortvalue});
RDebugUtils.currentLine=655366;
 //BA.debugLineNum = 655366;BA.debugLine="Return b";
if (true) return _b;
RDebugUtils.currentLine=655368;
 //BA.debugLineNum = 655368;BA.debugLine="End Sub";
return null;
}
public static String  _sendresponse(byte[] _sendbuffer) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "sendresponse"))
	 {return ((String) Debug.delegate(ba, "sendresponse", new Object[] {_sendbuffer}));}
byte[] _buffer = null;
RDebugUtils.currentLine=327680;
 //BA.debugLineNum = 327680;BA.debugLine="Sub SendResponse(SendBuffer ()As Byte)";
RDebugUtils.currentLine=327682;
 //BA.debugLineNum = 327682;BA.debugLine="If AStreams.IsInitialized = False Then Return";
if (_astreams.IsInitialized()==anywheresoftware.b4a.keywords.Common.False) { 
if (true) return "";};
RDebugUtils.currentLine=327684;
 //BA.debugLineNum = 327684;BA.debugLine="Dim buffer() As Byte";
_buffer = new byte[(int) (0)];
;
RDebugUtils.currentLine=327685;
 //BA.debugLineNum = 327685;BA.debugLine="buffer = SendBuffer'myText.GetBytes(\"UTF8\")";
_buffer = _sendbuffer;
RDebugUtils.currentLine=327686;
 //BA.debugLineNum = 327686;BA.debugLine="AStreams.Write(buffer)";
_astreams.Write(_buffer);
RDebugUtils.currentLine=327688;
 //BA.debugLineNum = 327688;BA.debugLine="Log(\"Sending response\" )";
anywheresoftware.b4a.keywords.Common.Log("Sending response");
RDebugUtils.currentLine=327691;
 //BA.debugLineNum = 327691;BA.debugLine="End Sub";
return "";
}
public static String  _server_newconnection(boolean _successful,anywheresoftware.b4a.objects.SocketWrapper _newsocket) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "server_newconnection"))
	 {return ((String) Debug.delegate(ba, "server_newconnection", new Object[] {_successful,_newsocket}));}
RDebugUtils.currentLine=131072;
 //BA.debugLineNum = 131072;BA.debugLine="Sub Server_NewConnection (Successful As Boolean, N";
RDebugUtils.currentLine=131073;
 //BA.debugLineNum = 131073;BA.debugLine="If Successful Then";
if (_successful) { 
RDebugUtils.currentLine=131074;
 //BA.debugLineNum = 131074;BA.debugLine="Log(\"Connected\" )";
anywheresoftware.b4a.keywords.Common.Log("Connected");
RDebugUtils.currentLine=131075;
 //BA.debugLineNum = 131075;BA.debugLine="Socket1 = NewSocket";
_socket1 = _newsocket;
RDebugUtils.currentLine=131077;
 //BA.debugLineNum = 131077;BA.debugLine="AStreams.Initialize(Socket1.InputStream, Socket1";
_astreams.Initialize(ba,_socket1.getInputStream(),_socket1.getOutputStream(),"AStreams");
 }else {
RDebugUtils.currentLine=131080;
 //BA.debugLineNum = 131080;BA.debugLine="Log(LastException.Message)";
anywheresoftware.b4a.keywords.Common.Log(anywheresoftware.b4a.keywords.Common.LastException(ba).getMessage());
 };
RDebugUtils.currentLine=131082;
 //BA.debugLineNum = 131082;BA.debugLine="Server.Listen";
_server.Listen();
RDebugUtils.currentLine=131083;
 //BA.debugLineNum = 131083;BA.debugLine="End Sub";
return "";
}
}