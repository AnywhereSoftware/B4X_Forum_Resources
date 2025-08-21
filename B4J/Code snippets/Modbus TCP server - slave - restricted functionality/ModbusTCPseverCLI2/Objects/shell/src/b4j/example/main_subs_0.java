package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _application_error(RemoteObject _error,RemoteObject _stacktrace) throws Exception{
try {
		Debug.PushSubsStack("Application_Error (main) ","main",0,main.ba,main.mostCurrent,232);
if (RapidSub.canDelegate("application_error")) { return b4j.example.main.remoteMe.runUserSub(false, "main","application_error", _error, _stacktrace);}
Debug.locals.put("Error", _error);
Debug.locals.put("StackTrace", _stacktrace);
 BA.debugLineNum = 232;BA.debugLine="Sub Application_Error (Error As Exception, StackTr";
Debug.ShouldStop(128);
 BA.debugLineNum = 233;BA.debugLine="Return True";
Debug.ShouldStop(256);
if (true) return main.__c.getField(true,"True");
 BA.debugLineNum = 234;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _appstart(RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,40);
if (RapidSub.canDelegate("appstart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","appstart", _args);}
Debug.locals.put("Args", _args);
 BA.debugLineNum = 40;BA.debugLine="Sub AppStart (Args() As String)";
Debug.ShouldStop(128);
 BA.debugLineNum = 42;BA.debugLine="Server.Initialize(502, \"Server\")";
Debug.ShouldStop(512);
main._server.runVoidMethod ("Initialize",main.ba,(Object)(BA.numberCast(int.class, 502)),(Object)(RemoteObject.createImmutable("Server")));
 BA.debugLineNum = 43;BA.debugLine="Server.Listen";
Debug.ShouldStop(1024);
main._server.runVoidMethod ("Listen");
 BA.debugLineNum = 44;BA.debugLine="Log(\"MyIp = \" & Server.GetMyIP)";
Debug.ShouldStop(2048);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.concat(RemoteObject.createImmutable("MyIp = "),main._server.runMethod(true,"GetMyIP"))));
 BA.debugLineNum = 48;BA.debugLine="HoldReg(0) = 123";
Debug.ShouldStop(32768);
main._holdreg.setArrayElement (BA.numberCast(short.class, 123),BA.numberCast(int.class, 0));
 BA.debugLineNum = 49;BA.debugLine="HoldReg(1) = 111";
Debug.ShouldStop(65536);
main._holdreg.setArrayElement (BA.numberCast(short.class, 111),BA.numberCast(int.class, 1));
 BA.debugLineNum = 50;BA.debugLine="HoldReg(2) = 222";
Debug.ShouldStop(131072);
main._holdreg.setArrayElement (BA.numberCast(short.class, 222),BA.numberCast(int.class, 2));
 BA.debugLineNum = 51;BA.debugLine="HoldReg(3) = 333";
Debug.ShouldStop(262144);
main._holdreg.setArrayElement (BA.numberCast(short.class, 333),BA.numberCast(int.class, 3));
 BA.debugLineNum = 52;BA.debugLine="HoldReg(4) = 444";
Debug.ShouldStop(524288);
main._holdreg.setArrayElement (BA.numberCast(short.class, 444),BA.numberCast(int.class, 4));
 BA.debugLineNum = 53;BA.debugLine="HoldReg(5) = 555";
Debug.ShouldStop(1048576);
main._holdreg.setArrayElement (BA.numberCast(short.class, 555),BA.numberCast(int.class, 5));
 BA.debugLineNum = 54;BA.debugLine="HoldReg(200) = 888";
Debug.ShouldStop(2097152);
main._holdreg.setArrayElement (BA.numberCast(short.class, 888),BA.numberCast(int.class, 200));
 BA.debugLineNum = 58;BA.debugLine="StartMessageLoop";
Debug.ShouldStop(33554432);
main.__c.runVoidMethod ("StartMessageLoop",main.ba);
 BA.debugLineNum = 60;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _astreams_error() throws Exception{
try {
		Debug.PushSubsStack("AStreams_Error (main) ","main",0,main.ba,main.mostCurrent,219);
if (RapidSub.canDelegate("astreams_error")) { return b4j.example.main.remoteMe.runUserSub(false, "main","astreams_error");}
 BA.debugLineNum = 219;BA.debugLine="Sub AStreams_Error";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 220;BA.debugLine="Log(LastException.Message)";
Debug.ShouldStop(134217728);
main.__c.runVoidMethod ("Log",(Object)(main.__c.runMethod(false,"LastException",main.ba).runMethod(true,"getMessage")));
 BA.debugLineNum = 221;BA.debugLine="Log(\"AStreams_Error\")";
Debug.ShouldStop(268435456);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("AStreams_Error")));
 BA.debugLineNum = 222;BA.debugLine="End Sub";
Debug.ShouldStop(536870912);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _astreams_newdata(RemoteObject _buffer) throws Exception{
try {
		Debug.PushSubsStack("AStreams_NewData (main) ","main",0,main.ba,main.mostCurrent,76);
if (RapidSub.canDelegate("astreams_newdata")) { return b4j.example.main.remoteMe.runUserSub(false, "main","astreams_newdata", _buffer);}
Debug.locals.put("Buffer", _buffer);
 BA.debugLineNum = 76;BA.debugLine="Sub AStreams_NewData (Buffer() As Byte)";
Debug.ShouldStop(2048);
 BA.debugLineNum = 78;BA.debugLine="ProcessRequest(Buffer)";
Debug.ShouldStop(8192);
_processrequest(_buffer);
 BA.debugLineNum = 80;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _astreams_terminated() throws Exception{
try {
		Debug.PushSubsStack("AStreams_Terminated (main) ","main",0,main.ba,main.mostCurrent,224);
if (RapidSub.canDelegate("astreams_terminated")) { return b4j.example.main.remoteMe.runUserSub(false, "main","astreams_terminated");}
 BA.debugLineNum = 224;BA.debugLine="Sub AStreams_Terminated";
Debug.ShouldStop(-2147483648);
 BA.debugLineNum = 225;BA.debugLine="Log(\"AStreams_Terminated\")";
Debug.ShouldStop(1);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("AStreams_Terminated")));
 BA.debugLineNum = 228;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _bytetoshort(RemoteObject _bytearray) throws Exception{
try {
		Debug.PushSubsStack("ByteToShort (main) ","main",0,main.ba,main.mostCurrent,237);
if (RapidSub.canDelegate("bytetoshort")) { return b4j.example.main.remoteMe.runUserSub(false, "main","bytetoshort", _bytearray);}
RemoteObject _bc = RemoteObject.declareNull("anywheresoftware.b4a.agraham.byteconverter.ByteConverter");
RemoteObject _i = RemoteObject.createImmutable((short)0);
Debug.locals.put("ByteArray", _bytearray);
 BA.debugLineNum = 237;BA.debugLine="Sub ByteToShort(ByteArray() As Byte) As Short";
Debug.ShouldStop(4096);
 BA.debugLineNum = 239;BA.debugLine="Dim bc As ByteConverter";
Debug.ShouldStop(16384);
_bc = RemoteObject.createNew ("anywheresoftware.b4a.agraham.byteconverter.ByteConverter");Debug.locals.put("bc", _bc);
 BA.debugLineNum = 240;BA.debugLine="bc.LittleEndian = True";
Debug.ShouldStop(32768);
_bc.runMethod(true,"setLittleEndian",main.__c.getField(true,"True"));
 BA.debugLineNum = 241;BA.debugLine="Dim i As Short = bc.shortsFromBytes(ByteArray)(0)";
Debug.ShouldStop(65536);
_i = _bc.runMethod(false,"ShortsFromBytes",(Object)(_bytearray)).getArrayElement(true,BA.numberCast(int.class, 0));Debug.locals.put("i", _i);Debug.locals.put("i", _i);
 BA.debugLineNum = 243;BA.debugLine="Return  i";
Debug.ShouldStop(262144);
if (true) return _i;
 BA.debugLineNum = 245;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable((short)0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("b4j.example.main");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 17;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 18;BA.debugLine="Dim AStreams As AsyncStreams";
main._astreams = RemoteObject.createNew ("anywheresoftware.b4a.randomaccessfile.AsyncStreams");
 //BA.debugLineNum = 19;BA.debugLine="Dim Server As ServerSocket";
main._server = RemoteObject.createNew ("anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper");
 //BA.debugLineNum = 20;BA.debugLine="Dim Socket1 As Socket";
main._socket1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.SocketWrapper");
 //BA.debugLineNum = 22;BA.debugLine="Dim slaveAddress As Byte = 1 'Slave address";
main._slaveaddress = BA.numberCast(byte.class, 1);
 //BA.debugLineNum = 23;BA.debugLine="Dim HoldReg(201) As Short 'Array with holding reg";
main._holdreg = RemoteObject.createNewArray ("short", new int[] {201}, new Object[]{});
 //BA.debugLineNum = 25;BA.debugLine="Dim RxTransIdent(2) As Byte '2byte array";
main._rxtransident = RemoteObject.createNewArray ("byte", new int[] {2}, new Object[]{});
 //BA.debugLineNum = 26;BA.debugLine="Dim RxProtocolIdent(2) As Byte '2 byte array";
main._rxprotocolident = RemoteObject.createNewArray ("byte", new int[] {2}, new Object[]{});
 //BA.debugLineNum = 27;BA.debugLine="Dim RxLength(2) As Byte 'Length of the message, c";
main._rxlength = RemoteObject.createNewArray ("byte", new int[] {2}, new Object[]{});
 //BA.debugLineNum = 28;BA.debugLine="Dim RxUnitIdentifier As Byte";
main._rxunitidentifier = RemoteObject.createImmutable((byte)0);
 //BA.debugLineNum = 29;BA.debugLine="Dim RxFunctionCode As Byte";
main._rxfunctioncode = RemoteObject.createImmutable((byte)0);
 //BA.debugLineNum = 30;BA.debugLine="Dim RxFirstAddresRegister(2) As Byte 'First adres";
main._rxfirstaddresregister = RemoteObject.createNewArray ("byte", new int[] {2}, new Object[]{});
 //BA.debugLineNum = 31;BA.debugLine="Dim RxRange(2) As Byte 'The number of required re";
main._rxrange = RemoteObject.createNewArray ("byte", new int[] {2}, new Object[]{});
 //BA.debugLineNum = 33;BA.debugLine="Dim RequestFirstAddresReg As Short";
main._requestfirstaddresreg = RemoteObject.createImmutable((short)0);
 //BA.debugLineNum = 34;BA.debugLine="Dim RequestRangeReg As Short";
main._requestrangereg = RemoteObject.createImmutable((short)0);
 //BA.debugLineNum = 38;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _processrequest(RemoteObject _buffer2) throws Exception{
try {
		Debug.PushSubsStack("ProcessRequest (main) ","main",0,main.ba,main.mostCurrent,82);
if (RapidSub.canDelegate("processrequest")) { return b4j.example.main.remoteMe.runUserSub(false, "main","processrequest", _buffer2);}
RemoteObject _arraysize = RemoteObject.createImmutable((short)0);
RemoteObject _txbuffer = null;
RemoteObject _bmem = null;
RemoteObject _bmem2 = null;
RemoteObject _holdregasbytearr = null;
int _i = 0;
Debug.locals.put("Buffer2", _buffer2);
 BA.debugLineNum = 82;BA.debugLine="Sub ProcessRequest(Buffer2() As Byte)";
Debug.ShouldStop(131072);
 BA.debugLineNum = 83;BA.debugLine="Try";
Debug.ShouldStop(262144);
try { BA.debugLineNum = 86;BA.debugLine="If Buffer2.Length = 12 Then";
Debug.ShouldStop(2097152);
if (RemoteObject.solveBoolean("=",_buffer2.getField(true,"length"),BA.numberCast(double.class, 12))) { 
 BA.debugLineNum = 89;BA.debugLine="RxTransIdent(0) = Buffer2(0)";
Debug.ShouldStop(16777216);
main._rxtransident.setArrayElement (_buffer2.getArrayElement(true,BA.numberCast(int.class, 0)),BA.numberCast(int.class, 0));
 BA.debugLineNum = 90;BA.debugLine="RxTransIdent(1)= Buffer2(1)";
Debug.ShouldStop(33554432);
main._rxtransident.setArrayElement (_buffer2.getArrayElement(true,BA.numberCast(int.class, 1)),BA.numberCast(int.class, 1));
 BA.debugLineNum = 91;BA.debugLine="RxProtocolIdent(0)= Buffer2(2)";
Debug.ShouldStop(67108864);
main._rxprotocolident.setArrayElement (_buffer2.getArrayElement(true,BA.numberCast(int.class, 2)),BA.numberCast(int.class, 0));
 BA.debugLineNum = 92;BA.debugLine="RxProtocolIdent(1)= Buffer2(3)";
Debug.ShouldStop(134217728);
main._rxprotocolident.setArrayElement (_buffer2.getArrayElement(true,BA.numberCast(int.class, 3)),BA.numberCast(int.class, 1));
 BA.debugLineNum = 93;BA.debugLine="RxLength(0)= Buffer2(4)";
Debug.ShouldStop(268435456);
main._rxlength.setArrayElement (_buffer2.getArrayElement(true,BA.numberCast(int.class, 4)),BA.numberCast(int.class, 0));
 BA.debugLineNum = 94;BA.debugLine="RxLength(1)= Buffer2(5)";
Debug.ShouldStop(536870912);
main._rxlength.setArrayElement (_buffer2.getArrayElement(true,BA.numberCast(int.class, 5)),BA.numberCast(int.class, 1));
 BA.debugLineNum = 95;BA.debugLine="RxUnitIdentifier= Buffer2(6)";
Debug.ShouldStop(1073741824);
main._rxunitidentifier = _buffer2.getArrayElement(true,BA.numberCast(int.class, 6));
 BA.debugLineNum = 96;BA.debugLine="RxFunctionCode= Buffer2(7)";
Debug.ShouldStop(-2147483648);
main._rxfunctioncode = _buffer2.getArrayElement(true,BA.numberCast(int.class, 7));
 BA.debugLineNum = 97;BA.debugLine="RxFirstAddresRegister(0) =  Buffer2(9) '! Byte s";
Debug.ShouldStop(1);
main._rxfirstaddresregister.setArrayElement (_buffer2.getArrayElement(true,BA.numberCast(int.class, 9)),BA.numberCast(int.class, 0));
 BA.debugLineNum = 98;BA.debugLine="RxFirstAddresRegister(1)= Buffer2(8)";
Debug.ShouldStop(2);
main._rxfirstaddresregister.setArrayElement (_buffer2.getArrayElement(true,BA.numberCast(int.class, 8)),BA.numberCast(int.class, 1));
 BA.debugLineNum = 99;BA.debugLine="RxRange(0) = Buffer2(11)'! Byte swapping";
Debug.ShouldStop(4);
main._rxrange.setArrayElement (_buffer2.getArrayElement(true,BA.numberCast(int.class, 11)),BA.numberCast(int.class, 0));
 BA.debugLineNum = 100;BA.debugLine="RxRange(1) = Buffer2(10)";
Debug.ShouldStop(8);
main._rxrange.setArrayElement (_buffer2.getArrayElement(true,BA.numberCast(int.class, 10)),BA.numberCast(int.class, 1));
 };
 BA.debugLineNum = 105;BA.debugLine="If RxProtocolIdent(0) <> 0 Or RxProtocolIdent(1)";
Debug.ShouldStop(256);
if (RemoteObject.solveBoolean("!",main._rxprotocolident.getArrayElement(true,BA.numberCast(int.class, 0)),BA.numberCast(double.class, 0)) || RemoteObject.solveBoolean("!",main._rxprotocolident.getArrayElement(true,BA.numberCast(int.class, 1)),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 106;BA.debugLine="Log( \"Illegal Protocol Identifier\")";
Debug.ShouldStop(512);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Illegal Protocol Identifier")));
 BA.debugLineNum = 107;BA.debugLine="Return 'exit sub";
Debug.ShouldStop(1024);
Debug.CheckDeviceExceptions();if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 111;BA.debugLine="If RxLength(0) <> 0 Or RxLength(1) <> 6 Then";
Debug.ShouldStop(16384);
if (RemoteObject.solveBoolean("!",main._rxlength.getArrayElement(true,BA.numberCast(int.class, 0)),BA.numberCast(double.class, 0)) || RemoteObject.solveBoolean("!",main._rxlength.getArrayElement(true,BA.numberCast(int.class, 1)),BA.numberCast(double.class, 6))) { 
 BA.debugLineNum = 112;BA.debugLine="Log( \"Illegal Length\")";
Debug.ShouldStop(32768);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Illegal Length")));
 BA.debugLineNum = 113;BA.debugLine="Return'exit sub";
Debug.ShouldStop(65536);
Debug.CheckDeviceExceptions();if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 117;BA.debugLine="If RxFunctionCode <> 3  Then		'Only holding regi";
Debug.ShouldStop(1048576);
if (RemoteObject.solveBoolean("!",main._rxfunctioncode,BA.numberCast(double.class, 3))) { 
 BA.debugLineNum = 118;BA.debugLine="Log( \"Illegal Function Code\")";
Debug.ShouldStop(2097152);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Illegal Function Code")));
 BA.debugLineNum = 119;BA.debugLine="Return'exit sub";
Debug.ShouldStop(4194304);
Debug.CheckDeviceExceptions();if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 123;BA.debugLine="If RxUnitIdentifier <> slaveAddress  Then";
Debug.ShouldStop(67108864);
if (RemoteObject.solveBoolean("!",main._rxunitidentifier,BA.numberCast(double.class, main._slaveaddress))) { 
 BA.debugLineNum = 124;BA.debugLine="Log( \"Illegal Unique Identifier - or Slave Addr";
Debug.ShouldStop(134217728);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Illegal Unique Identifier - or Slave Address Code")));
 BA.debugLineNum = 125;BA.debugLine="Return'exit sub";
Debug.ShouldStop(268435456);
Debug.CheckDeviceExceptions();if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 131;BA.debugLine="RequestFirstAddresReg =  ByteToShort(RxFirstAddr";
Debug.ShouldStop(4);
main._requestfirstaddresreg = _bytetoshort(main._rxfirstaddresregister);
 BA.debugLineNum = 132;BA.debugLine="RequestRangeReg = ByteToShort(RxRange)";
Debug.ShouldStop(8);
main._requestrangereg = _bytetoshort(main._rxrange);
 BA.debugLineNum = 135;BA.debugLine="If RequestFirstAddresReg > 201 Then";
Debug.ShouldStop(64);
if (RemoteObject.solveBoolean(">",main._requestfirstaddresreg,BA.numberCast(double.class, 201))) { 
 BA.debugLineNum = 136;BA.debugLine="Log( \"Illegal adress requested\")";
Debug.ShouldStop(128);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Illegal adress requested")));
 BA.debugLineNum = 137;BA.debugLine="Return'exit sub";
Debug.ShouldStop(256);
Debug.CheckDeviceExceptions();if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 141;BA.debugLine="If (RequestFirstAddresReg + RequestRangeReg) > 2";
Debug.ShouldStop(4096);
if (RemoteObject.solveBoolean(">",(RemoteObject.solve(new RemoteObject[] {main._requestfirstaddresreg,main._requestrangereg}, "+",1, 1)),BA.numberCast(double.class, 201))) { 
 BA.debugLineNum = 142;BA.debugLine="Log( \"Requested range out of buffer size\")";
Debug.ShouldStop(8192);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Requested range out of buffer size")));
 BA.debugLineNum = 143;BA.debugLine="Return'exit sub";
Debug.ShouldStop(16384);
Debug.CheckDeviceExceptions();if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 152;BA.debugLine="Dim ArraySize As Short";
Debug.ShouldStop(8388608);
_arraysize = RemoteObject.createImmutable((short)0);Debug.locals.put("ArraySize", _arraysize);
 BA.debugLineNum = 153;BA.debugLine="ArraySize = 9 + (RequestRangeReg * 2)";
Debug.ShouldStop(16777216);
_arraysize = BA.numberCast(short.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(9),(RemoteObject.solve(new RemoteObject[] {main._requestrangereg,RemoteObject.createImmutable(2)}, "*",0, 1))}, "+",1, 1));Debug.locals.put("ArraySize", _arraysize);
 BA.debugLineNum = 157;BA.debugLine="Dim  TxBuffer (ArraySize)   As Byte";
Debug.ShouldStop(268435456);
_txbuffer = RemoteObject.createNewArray ("byte", new int[] {(int) (0 + _arraysize.<Short>get().shortValue())}, new Object[]{});Debug.locals.put("TxBuffer", _txbuffer);
 BA.debugLineNum = 160;BA.debugLine="TxBuffer(0) = RxTransIdent(0)";
Debug.ShouldStop(-2147483648);
_txbuffer.setArrayElement (main._rxtransident.getArrayElement(true,BA.numberCast(int.class, 0)),BA.numberCast(int.class, 0));
 BA.debugLineNum = 161;BA.debugLine="TxBuffer(1) = RxTransIdent(1)";
Debug.ShouldStop(1);
_txbuffer.setArrayElement (main._rxtransident.getArrayElement(true,BA.numberCast(int.class, 1)),BA.numberCast(int.class, 1));
 BA.debugLineNum = 163;BA.debugLine="TxBuffer(2) = 0";
Debug.ShouldStop(4);
_txbuffer.setArrayElement (BA.numberCast(byte.class, 0),BA.numberCast(int.class, 2));
 BA.debugLineNum = 164;BA.debugLine="TxBuffer(3) = 0";
Debug.ShouldStop(8);
_txbuffer.setArrayElement (BA.numberCast(byte.class, 0),BA.numberCast(int.class, 3));
 BA.debugLineNum = 167;BA.debugLine="Dim bmem(2) As Byte = ShortToByte(RequestRangeRe";
Debug.ShouldStop(64);
_bmem = _shorttobyte(BA.numberCast(short.class, RemoteObject.solve(new RemoteObject[] {main._requestrangereg,RemoteObject.createImmutable(2),RemoteObject.createImmutable(3)}, "*+",1, 1)));Debug.locals.put("bmem", _bmem);Debug.locals.put("bmem", _bmem);
 BA.debugLineNum = 168;BA.debugLine="TxBuffer(4) = bmem(1)";
Debug.ShouldStop(128);
_txbuffer.setArrayElement (_bmem.getArrayElement(true,BA.numberCast(int.class, 1)),BA.numberCast(int.class, 4));
 BA.debugLineNum = 169;BA.debugLine="TxBuffer(5) = bmem(0)";
Debug.ShouldStop(256);
_txbuffer.setArrayElement (_bmem.getArrayElement(true,BA.numberCast(int.class, 0)),BA.numberCast(int.class, 5));
 BA.debugLineNum = 172;BA.debugLine="TxBuffer(6) = slaveAddress";
Debug.ShouldStop(2048);
_txbuffer.setArrayElement (main._slaveaddress,BA.numberCast(int.class, 6));
 BA.debugLineNum = 175;BA.debugLine="TxBuffer(7) = 3";
Debug.ShouldStop(16384);
_txbuffer.setArrayElement (BA.numberCast(byte.class, 3),BA.numberCast(int.class, 7));
 BA.debugLineNum = 179;BA.debugLine="Dim bmem2(2) As Byte = ShortToByte((RequestRange";
Debug.ShouldStop(262144);
_bmem2 = _shorttobyte(BA.numberCast(short.class, (RemoteObject.solve(new RemoteObject[] {main._requestrangereg,RemoteObject.createImmutable(2)}, "*",0, 1))));Debug.locals.put("bmem2", _bmem2);Debug.locals.put("bmem2", _bmem2);
 BA.debugLineNum = 180;BA.debugLine="TxBuffer(8) = bmem2(0)";
Debug.ShouldStop(524288);
_txbuffer.setArrayElement (_bmem2.getArrayElement(true,BA.numberCast(int.class, 0)),BA.numberCast(int.class, 8));
 BA.debugLineNum = 185;BA.debugLine="Dim HoldRegAsByteArr(2) As Byte";
Debug.ShouldStop(16777216);
_holdregasbytearr = RemoteObject.createNewArray ("byte", new int[] {2}, new Object[]{});Debug.locals.put("HoldRegAsByteArr", _holdregasbytearr);
 BA.debugLineNum = 186;BA.debugLine="For i = 0 To (RequestRangeReg-1) Step 1";
Debug.ShouldStop(33554432);
{
final int step57 = 1;
final int limit57 = (RemoteObject.solve(new RemoteObject[] {main._requestrangereg,RemoteObject.createImmutable(1)}, "-",1, 1)).<Integer>get().intValue();
_i = 0 ;
for (;(step57 > 0 && _i <= limit57) || (step57 < 0 && _i >= limit57) ;_i = ((int)(0 + _i + step57))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 188;BA.debugLine="HoldRegAsByteArr =ShortToByte(HoldReg((RequestF";
Debug.ShouldStop(134217728);
_holdregasbytearr = _shorttobyte(main._holdreg.getArrayElement(true,RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {main._requestfirstaddresreg,RemoteObject.createImmutable(1)}, "-",1, 1)),RemoteObject.createImmutable(_i),RemoteObject.createImmutable(1)}, "++",2, 1)));Debug.locals.put("HoldRegAsByteArr", _holdregasbytearr);
 BA.debugLineNum = 190;BA.debugLine="TxBuffer(9+(i*2)) = HoldRegAsByteArr(1) '!Swap";
Debug.ShouldStop(536870912);
_txbuffer.setArrayElement (_holdregasbytearr.getArrayElement(true,BA.numberCast(int.class, 1)),RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(9),(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_i),RemoteObject.createImmutable(2)}, "*",0, 1))}, "+",1, 1));
 BA.debugLineNum = 191;BA.debugLine="TxBuffer(10+(i*2)) = HoldRegAsByteArr(0)";
Debug.ShouldStop(1073741824);
_txbuffer.setArrayElement (_holdregasbytearr.getArrayElement(true,BA.numberCast(int.class, 0)),RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(10),(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_i),RemoteObject.createImmutable(2)}, "*",0, 1))}, "+",1, 1));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 197;BA.debugLine="SendResponse(TxBuffer)";
Debug.ShouldStop(16);
_sendresponse(_txbuffer);
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e64) {
			BA.rdebugUtils.runVoidMethod("setLastException",main.ba, e64.toString()); BA.debugLineNum = 201;BA.debugLine="Log(LastException)";
Debug.ShouldStop(256);
main.__c.runVoidMethod ("Log",(Object)(BA.ObjectToString(main.__c.runMethod(false,"LastException",main.ba))));
 };
 BA.debugLineNum = 204;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _sendresponse(RemoteObject _sendbuffer) throws Exception{
try {
		Debug.PushSubsStack("SendResponse (main) ","main",0,main.ba,main.mostCurrent,206);
if (RapidSub.canDelegate("sendresponse")) { return b4j.example.main.remoteMe.runUserSub(false, "main","sendresponse", _sendbuffer);}
RemoteObject _buffer = null;
Debug.locals.put("SendBuffer", _sendbuffer);
 BA.debugLineNum = 206;BA.debugLine="Sub SendResponse(SendBuffer ()As Byte)";
Debug.ShouldStop(8192);
 BA.debugLineNum = 208;BA.debugLine="If AStreams.IsInitialized = False Then Return";
Debug.ShouldStop(32768);
if (RemoteObject.solveBoolean("=",main._astreams.runMethod(true,"IsInitialized"),main.__c.getField(true,"False"))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 210;BA.debugLine="Dim buffer() As Byte";
Debug.ShouldStop(131072);
_buffer = RemoteObject.createNewArray ("byte", new int[] {0}, new Object[]{});Debug.locals.put("buffer", _buffer);
 BA.debugLineNum = 211;BA.debugLine="buffer = SendBuffer'myText.GetBytes(\"UTF8\")";
Debug.ShouldStop(262144);
_buffer = _sendbuffer;Debug.locals.put("buffer", _buffer);
 BA.debugLineNum = 212;BA.debugLine="AStreams.Write(buffer)";
Debug.ShouldStop(524288);
main._astreams.runVoidMethod ("Write",(Object)(_buffer));
 BA.debugLineNum = 214;BA.debugLine="Log(\"Sending response\" )";
Debug.ShouldStop(2097152);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Sending response")));
 BA.debugLineNum = 217;BA.debugLine="End Sub";
Debug.ShouldStop(16777216);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _server_newconnection(RemoteObject _successful,RemoteObject _newsocket) throws Exception{
try {
		Debug.PushSubsStack("Server_NewConnection (main) ","main",0,main.ba,main.mostCurrent,63);
if (RapidSub.canDelegate("server_newconnection")) { return b4j.example.main.remoteMe.runUserSub(false, "main","server_newconnection", _successful, _newsocket);}
Debug.locals.put("Successful", _successful);
Debug.locals.put("NewSocket", _newsocket);
 BA.debugLineNum = 63;BA.debugLine="Sub Server_NewConnection (Successful As Boolean, N";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 64;BA.debugLine="If Successful Then";
Debug.ShouldStop(-2147483648);
if (_successful.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 65;BA.debugLine="Log(\"Connected\" )";
Debug.ShouldStop(1);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Connected")));
 BA.debugLineNum = 66;BA.debugLine="Socket1 = NewSocket";
Debug.ShouldStop(2);
main._socket1 = _newsocket;
 BA.debugLineNum = 68;BA.debugLine="AStreams.Initialize(Socket1.InputStream, Socket1";
Debug.ShouldStop(8);
main._astreams.runVoidMethod ("Initialize",main.ba,(Object)(main._socket1.runMethod(false,"getInputStream")),(Object)(main._socket1.runMethod(false,"getOutputStream")),(Object)(RemoteObject.createImmutable("AStreams")));
 }else {
 BA.debugLineNum = 71;BA.debugLine="Log(LastException.Message)";
Debug.ShouldStop(64);
main.__c.runVoidMethod ("Log",(Object)(main.__c.runMethod(false,"LastException",main.ba).runMethod(true,"getMessage")));
 };
 BA.debugLineNum = 73;BA.debugLine="Server.Listen";
Debug.ShouldStop(256);
main._server.runVoidMethod ("Listen");
 BA.debugLineNum = 74;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _shorttobyte(RemoteObject _shortvalue) throws Exception{
try {
		Debug.PushSubsStack("ShortToByte (main) ","main",0,main.ba,main.mostCurrent,247);
if (RapidSub.canDelegate("shorttobyte")) { return b4j.example.main.remoteMe.runUserSub(false, "main","shorttobyte", _shortvalue);}
RemoteObject _bc = RemoteObject.declareNull("anywheresoftware.b4a.agraham.byteconverter.ByteConverter");
RemoteObject _b = null;
Debug.locals.put("ShortValue", _shortvalue);
 BA.debugLineNum = 247;BA.debugLine="Sub ShortToByte(ShortValue As Short) As Byte()";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 249;BA.debugLine="Dim bc As ByteConverter";
Debug.ShouldStop(16777216);
_bc = RemoteObject.createNew ("anywheresoftware.b4a.agraham.byteconverter.ByteConverter");Debug.locals.put("bc", _bc);
 BA.debugLineNum = 250;BA.debugLine="bc.LittleEndian = True";
Debug.ShouldStop(33554432);
_bc.runMethod(true,"setLittleEndian",main.__c.getField(true,"True"));
 BA.debugLineNum = 251;BA.debugLine="Dim b() As Byte = bc.ShortsToBytes(Array As Short";
Debug.ShouldStop(67108864);
_b = _bc.runMethod(false,"ShortsToBytes",(Object)(RemoteObject.createNewArray("short",new int[] {1},new Object[] {_shortvalue})));Debug.locals.put("b", _b);Debug.locals.put("b", _b);
 BA.debugLineNum = 253;BA.debugLine="Return b";
Debug.ShouldStop(268435456);
if (true) return _b;
 BA.debugLineNum = 255;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}