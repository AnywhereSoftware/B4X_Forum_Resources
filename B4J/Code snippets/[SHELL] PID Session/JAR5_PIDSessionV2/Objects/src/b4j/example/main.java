package b4j.example;


import anywheresoftware.b4a.BA;

public class main extends javafx.application.Application{
public static main mostCurrent = new main();

public static BA ba;
static {
		ba = new  anywheresoftware.b4j.objects.FxBA("b4j.example", "b4j.example.main", null);
		ba.loadHtSubs(main.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "b4j.example.main", ba);
		}
	}
    public static Class<?> getObject() {
		return main.class;
	}

 
    public static void main(String[] args) {
    	launch(args);
    }
    public void start (javafx.stage.Stage stage) {
        try {
            if (!false)
                System.setProperty("prism.lcdtext", "false");
            anywheresoftware.b4j.objects.FxBA.application = this;
		    anywheresoftware.b4a.keywords.Common.setDensity(javafx.stage.Screen.getPrimary().getDpi());
            anywheresoftware.b4a.keywords.Common.LogDebug("Program started.");
            initializeProcessGlobals();
            anywheresoftware.b4j.objects.Form frm = new anywheresoftware.b4j.objects.Form();
            frm.initWithStage(ba, stage, 600, 600);
            ba.raiseEvent(null, "appstart", frm, (String[])getParameters().getRaw().toArray(new String[0]));
        } catch (Throwable t) {
            BA.printException(t, true);
            System.exit(1);
        }
    }
public static anywheresoftware.b4a.keywords.Common __c = null;
public static b4j.example.main._session1 _v5 = null;
public static b4j.example.main._session2 _v6 = null;
public static b4j.example.processbypid _v7 = null;
public static String _v0 = "";
public static String[] _vv1 = null;
public static anywheresoftware.b4a.objects.collections.Map _vv2 = null;
public static anywheresoftware.b4j.object.JavaObject _vv3 = null;
public static anywheresoftware.b4j.objects.Shell _vvv2 = null;
public static String _vv4 = "";
public static class _session1{
public boolean IsInitialized;
public String ApplicationName;
public String WindowTitle;
public boolean Unknown;
public void Initialize() {
IsInitialized = true;
ApplicationName = "";
WindowTitle = "";
Unknown = false;
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public static class _session2{
public boolean IsInitialized;
public String ImageName;
public String PID;
public String WindowTitle;
public void Initialize() {
IsInitialized = true;
ImageName = "";
PID = "";
WindowTitle = "";
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
 //BA.debugLineNum = 30;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
 //BA.debugLineNum = 32;BA.debugLine="processBy.Initialize(File.DirApp, \"PID@Session.tx";
_v7._initialize /*String*/ (ba,anywheresoftware.b4a.keywords.Common.File.getDirApp(),"PID@Session.txt");
 //BA.debugLineNum = 33;BA.debugLine="BySession.Initialize";
_v6.Initialize();
 //BA.debugLineNum = 34;BA.debugLine="ByUnknown.Initialize";
_v5.Initialize();
 //BA.debugLineNum = 35;BA.debugLine="ByUnknown.ApplicationName = \"notepad++.exe\" 	'Ent";
_v5.ApplicationName /*String*/  = "notepad++.exe";
 //BA.debugLineNum = 36;BA.debugLine="ByUnknown.WindowTitle = \"note 1 - notepad++\"	'Ent";
_v5.WindowTitle /*String*/  = "note 1 - notepad++";
 //BA.debugLineNum = 37;BA.debugLine="ByUnknown.Unknown = True";
_v5.Unknown /*boolean*/  = anywheresoftware.b4a.keywords.Common.True;
 //BA.debugLineNum = 40;BA.debugLine="jo.InitializeStatic(\"java.lang.management.Managem";
_vv3.InitializeStatic("java.lang.management.ManagementFactory");
 //BA.debugLineNum = 41;BA.debugLine="PID = jo.RunMethodJO(\"getRuntimeMXBean\",Null).Run";
_v0 = BA.ObjectToString(_vv3.RunMethodJO("getRuntimeMXBean",(Object[])(anywheresoftware.b4a.keywords.Common.Null)).RunMethod("getName",(Object[])(anywheresoftware.b4a.keywords.Common.Null)));
 //BA.debugLineNum = 42;BA.debugLine="PID = PID.SubString2(0,PID.IndexOf(\"@\"))";
_v0 = _v0.substring((int) (0),_v0.indexOf("@"));
 //BA.debugLineNum = 44;BA.debugLine="componentsMap.Initialize";
_vv2.Initialize();
 //BA.debugLineNum = 45;BA.debugLine="js.Initialize(\"js\", \"tasklist.exe\", Array As Stri";
_vvv2.Initialize("js","tasklist.exe",anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{"/v"}));
 //BA.debugLineNum = 46;BA.debugLine="js.Run(60000)";
_vvv2.Run(ba,(long) (60000));
 //BA.debugLineNum = 47;BA.debugLine="End Sub";
return "";
}
public static void  _js_processcompleted(boolean _success,int _exitcode,String _stdout,String _stderr) throws Exception{
ResumableSub_js_ProcessCompleted rsub = new ResumableSub_js_ProcessCompleted(null,_success,_exitcode,_stdout,_stderr);
rsub.resume(ba, null);
}
public static class ResumableSub_js_ProcessCompleted extends BA.ResumableSub {
public ResumableSub_js_ProcessCompleted(b4j.example.main parent,boolean _success,int _exitcode,String _stdout,String _stderr) {
this.parent = parent;
this._success = _success;
this._exitcode = _exitcode;
this._stdout = _stdout;
this._stderr = _stderr;
}
b4j.example.main parent;
boolean _success;
int _exitcode;
String _stdout;
String _stderr;
anywheresoftware.b4j.objects.JFX _xui = null;
int _i = 0;
String _key = "";
int _l = 0;
String _chars = "";
boolean _resultkill = false;
boolean _resultsession = false;
int step5;
int limit5;
anywheresoftware.b4a.BA.IterableList group16;
int index16;
int groupLen16;

@Override
public void resume(BA ba, Object[] result) throws Exception{

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
 //BA.debugLineNum = 50;BA.debugLine="Dim xui As JFX";
_xui = new anywheresoftware.b4j.objects.JFX();
 //BA.debugLineNum = 51;BA.debugLine="If Success Then";
if (true) break;

case 1:
//if
this.state = 59;
if (_success) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
 //BA.debugLineNum = 53;BA.debugLine="components = Regex.Split(CRLF, StdOut)";
parent._vv1 = anywheresoftware.b4a.keywords.Common.Regex.Split(anywheresoftware.b4a.keywords.Common.CRLF,_stdout);
 //BA.debugLineNum = 55;BA.debugLine="If components.Length > 0 Then";
if (true) break;

case 4:
//if
this.state = 58;
if (parent._vv1.length>0) { 
this.state = 6;
}if (true) break;

case 6:
//C
this.state = 7;
 //BA.debugLineNum = 56;BA.debugLine="For i = 3 To components.Length - 1";
if (true) break;

case 7:
//for
this.state = 57;
step5 = 1;
limit5 = (int) (parent._vv1.length-1);
_i = (int) (3) ;
this.state = 70;
if (true) break;

case 70:
//C
this.state = 57;
if ((step5 > 0 && _i <= limit5) || (step5 < 0 && _i >= limit5)) this.state = 9;
if (true) break;

case 71:
//C
this.state = 70;
_i = ((int)(0 + _i + step5)) ;
if (true) break;

case 9:
//C
this.state = 10;
 //BA.debugLineNum = 57;BA.debugLine="componentsMap.Clear";
parent._vv2.Clear();
 //BA.debugLineNum = 58;BA.debugLine="componentsMap.Put(\"ImageName\", components(i).S";
parent._vv2.Put((Object)("ImageName"),(Object)(parent._vv1[_i].substring((int) (0),(int) (25))));
 //BA.debugLineNum = 59;BA.debugLine="componentsMap.Put(\"PID\", components(i).SubStri";
parent._vv2.Put((Object)("PID"),(Object)(parent._vv1[_i].substring((int) (26),(int) (34))));
 //BA.debugLineNum = 60;BA.debugLine="componentsMap.Put(\"SessionName\", components(i)";
parent._vv2.Put((Object)("SessionName"),(Object)(parent._vv1[_i].substring((int) (35),(int) (51))));
 //BA.debugLineNum = 61;BA.debugLine="componentsMap.Put(\"Session#\", components(i).Su";
parent._vv2.Put((Object)("Session#"),(Object)(parent._vv1[_i].substring((int) (52),(int) (63))));
 //BA.debugLineNum = 62;BA.debugLine="componentsMap.Put(\"MemUsage\", components(i).Su";
parent._vv2.Put((Object)("MemUsage"),(Object)(parent._vv1[_i].substring((int) (64),(int) (76))));
 //BA.debugLineNum = 63;BA.debugLine="componentsMap.Put(\"Status\", components(i).SubS";
parent._vv2.Put((Object)("Status"),(Object)(parent._vv1[_i].substring((int) (77),(int) (92))));
 //BA.debugLineNum = 64;BA.debugLine="componentsMap.Put(\"UserName\", components(i).Su";
parent._vv2.Put((Object)("UserName"),(Object)(parent._vv1[_i].substring((int) (93),(int) (143))));
 //BA.debugLineNum = 65;BA.debugLine="componentsMap.Put(\"CPUTime\", components(i).Sub";
parent._vv2.Put((Object)("CPUTime"),(Object)(parent._vv1[_i].substring((int) (144),(int) (156))));
 //BA.debugLineNum = 66;BA.debugLine="componentsMap.Put(\"WindowTitle\", components(i)";
parent._vv2.Put((Object)("WindowTitle"),(Object)(parent._vv1[_i].substring((int) (157),(int) (229))));
 //BA.debugLineNum = 70;BA.debugLine="For Each Key As String In componentsMap.Keys";
if (true) break;

case 10:
//for
this.state = 49;
group16 = parent._vv2.Keys();
index16 = 0;
groupLen16 = group16.getSize();
this.state = 72;
if (true) break;

case 72:
//C
this.state = 49;
if (index16 < groupLen16) {
this.state = 12;
_key = BA.ObjectToString(group16.Get(index16));}
if (true) break;

case 73:
//C
this.state = 72;
index16++;
if (true) break;

case 12:
//C
this.state = 13;
 //BA.debugLineNum = 71;BA.debugLine="Dim L As Int";
_l = 0;
 //BA.debugLineNum = 72;BA.debugLine="Dim chars As String = Chr(32)";
_chars = BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr((int) (32)));
 //BA.debugLineNum = 73;BA.debugLine="If Key.Contains(\"ImageName\") Or Key.Contains(";
if (true) break;

case 13:
//if
this.state = 48;
if (_key.contains("ImageName") || _key.contains("SessionName") || _key.contains("Status") || _key.contains("UserName") || _key.contains("WindowTitle")) { 
this.state = 15;
}else if(_key.contains("MemUsage")) { 
this.state = 39;
}else {
this.state = 41;
}if (true) break;

case 15:
//C
this.state = 16;
 //BA.debugLineNum = 74;BA.debugLine="Value = componentsMap.Get(Key)";
parent._vv4 = BA.ObjectToString(parent._vv2.Get((Object)(_key)));
 //BA.debugLineNum = 75;BA.debugLine="Do While True";
if (true) break;

case 16:
//do while
this.state = 37;
while (anywheresoftware.b4a.keywords.Common.True) {
this.state = 18;
if (true) break;
}
if (true) break;

case 18:
//C
this.state = 19;
 //BA.debugLineNum = 76;BA.debugLine="L = Value.LastIndexOf(chars)";
_l = parent._vv4.lastIndexOf(_chars);
 //BA.debugLineNum = 77;BA.debugLine="If L > 0 Then";
if (true) break;

case 19:
//if
this.state = 36;
if (_l>0) { 
this.state = 21;
}else {
this.state = 23;
}if (true) break;

case 21:
//C
this.state = 36;
 //BA.debugLineNum = 78;BA.debugLine="Value = Value.SubString2(0,L) 'After passi";
parent._vv4 = parent._vv4.substring((int) (0),_l);
 if (true) break;

case 23:
//C
this.state = 24;
 //BA.debugLineNum = 80;BA.debugLine="If Key.Contains(\"ImageName\") Then BySessio";
if (true) break;

case 24:
//if
this.state = 29;
if (_key.contains("ImageName")) { 
this.state = 26;
;}if (true) break;

case 26:
//C
this.state = 29;
parent._v6.ImageName /*String*/  = parent._vv4;
if (true) break;

case 29:
//C
this.state = 30;
;
 //BA.debugLineNum = 81;BA.debugLine="If Key.Contains(\"WindowTitle\") Then BySess";
if (true) break;

case 30:
//if
this.state = 35;
if (_key.contains("WindowTitle")) { 
this.state = 32;
;}if (true) break;

case 32:
//C
this.state = 35;
parent._v6.WindowTitle /*String*/  = parent._vv4;
if (true) break;

case 35:
//C
this.state = 36;
;
 //BA.debugLineNum = 82;BA.debugLine="Exit";
this.state = 37;
if (true) break;
 if (true) break;

case 36:
//C
this.state = 16;
;
 if (true) break;

case 37:
//C
this.state = 48;
;
 if (true) break;

case 39:
//C
this.state = 48;
 //BA.debugLineNum = 86;BA.debugLine="Value = componentsMap.Get(Key)";
parent._vv4 = BA.ObjectToString(parent._vv2.Get((Object)(_key)));
 //BA.debugLineNum = 87;BA.debugLine="Value = Value.Replace(\"�\",\".\").Replace(chars";
parent._vv4 = parent._vv4.replace("�",".").replace(_chars,"")+" K";
 if (true) break;

case 41:
//C
this.state = 42;
 //BA.debugLineNum = 89;BA.debugLine="Value = componentsMap.Get(Key)";
parent._vv4 = BA.ObjectToString(parent._vv2.Get((Object)(_key)));
 //BA.debugLineNum = 90;BA.debugLine="Value = Value.Replace(chars,\"\")";
parent._vv4 = parent._vv4.replace(_chars,"");
 //BA.debugLineNum = 91;BA.debugLine="If Key.Contains(\"PID\") Then BySession.PID =";
if (true) break;

case 42:
//if
this.state = 47;
if (_key.contains("PID")) { 
this.state = 44;
;}if (true) break;

case 44:
//C
this.state = 47;
parent._v6.PID /*String*/  = parent._vv4;
if (true) break;

case 47:
//C
this.state = 48;
;
 if (true) break;

case 48:
//C
this.state = 73;
;
 if (true) break;
if (true) break;
;
 //BA.debugLineNum = 96;BA.debugLine="If ByUnknown.ApplicationName.ToLowerCase.Conta";

case 49:
//if
this.state = 56;
if (parent._v5.ApplicationName /*String*/ .toLowerCase().contains(parent._v6.ImageName /*String*/ .toLowerCase())==anywheresoftware.b4a.keywords.Common.True || parent._v5.WindowTitle /*String*/ .toLowerCase().contains(parent._v6.WindowTitle /*String*/ .toLowerCase())==anywheresoftware.b4a.keywords.Common.True) { 
this.state = 51;
}if (true) break;

case 51:
//C
this.state = 52;
 //BA.debugLineNum = 98;BA.debugLine="Wait For (processBy.KillByPID(BySession.PID))";
anywheresoftware.b4a.keywords.Common.WaitFor("complete", ba, this, parent._v7._vv5 /*anywheresoftware.b4a.keywords.Common.ResumableSubWrapper*/ (parent._v6.PID /*String*/ ));
this.state = 74;
return;
case 74:
//C
this.state = 52;
_resultkill = (boolean) result[0];
;
 //BA.debugLineNum = 99;BA.debugLine="ByUnknown.Unknown = False";
parent._v5.Unknown /*boolean*/  = anywheresoftware.b4a.keywords.Common.False;
 //BA.debugLineNum = 100;BA.debugLine="If resultKill = True Then";
if (true) break;

case 52:
//if
this.state = 55;
if (_resultkill==anywheresoftware.b4a.keywords.Common.True) { 
this.state = 54;
}if (true) break;

case 54:
//C
this.state = 55;
 //BA.debugLineNum = 101;BA.debugLine="Log(\"Kill : \" & BySession.ImageName)";
anywheresoftware.b4a.keywords.Common.LogImpl("3131124","Kill : "+parent._v6.ImageName /*String*/ ,0);
 if (true) break;

case 55:
//C
this.state = 56;
;
 if (true) break;

case 56:
//C
this.state = 71;
;
 if (true) break;
if (true) break;

case 57:
//C
this.state = 58;
;
 if (true) break;

case 58:
//C
this.state = 59;
;
 if (true) break;

case 59:
//C
this.state = 60;
;
 //BA.debugLineNum = 109;BA.debugLine="Wait For (processBy.KillByPID(PID)) Complete (res";
anywheresoftware.b4a.keywords.Common.WaitFor("complete", ba, this, parent._v7._vv5 /*anywheresoftware.b4a.keywords.Common.ResumableSubWrapper*/ (parent._v0));
this.state = 75;
return;
case 75:
//C
this.state = 60;
_resultsession = (boolean) result[0];
;
 //BA.debugLineNum = 110;BA.debugLine="If resultSession = True Then";
if (true) break;

case 60:
//if
this.state = 69;
if (_resultsession==anywheresoftware.b4a.keywords.Common.True) { 
this.state = 62;
}if (true) break;

case 62:
//C
this.state = 63;
 //BA.debugLineNum = 111;BA.debugLine="If ByUnknown.Unknown = True Then Log(\"The progra";
if (true) break;

case 63:
//if
this.state = 68;
if (parent._v5.Unknown /*boolean*/ ==anywheresoftware.b4a.keywords.Common.True) { 
this.state = 65;
;}if (true) break;

case 65:
//C
this.state = 68;
anywheresoftware.b4a.keywords.Common.LogImpl("3131134","The program requires the parameters - AppName[ or ]AppTitle.",0);
if (true) break;

case 68:
//C
this.state = 69;
;
 //BA.debugLineNum = 112;BA.debugLine="Log(\"Kill: Session\")";
anywheresoftware.b4a.keywords.Common.LogImpl("3131135","Kill: Session",0);
 if (true) break;

case 69:
//C
this.state = -1;
;
 //BA.debugLineNum = 114;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public static void  _complete(boolean _resultkill) throws Exception{
}

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main._process_globals();
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}

private static byte[][] bb;

public static String vvv13(final byte[] _b, final int i) throws Exception {
Runnable r = new Runnable() {
{

int value = i / 3 + 148992;
if (bb == null) {
		
                    bb = new byte[3][];
					bb[0] = BA.packageName.getBytes("UTF8");
                    bb[1] = "/.,mndqw".getBytes("UTF8");			
        }
        bb[2] = new byte[] {
                    (byte) (value >>> 24),
						(byte) (value >>> 16),
						(byte) (value >>> 8),
						(byte) value};
				try {
					for (int __b = 0;__b < (2 + 1);__b ++) {
						for (int b = 0;b<_b.length;b++) {
							_b[b] ^= bb[__b][b % bb[__b].length];
						}
					}

				} catch (Exception e) {
					throw new RuntimeException(e);
				}
                

            
}
public void run() {
}
};
return new String(_b, "UTF8");
}
public static String  _process_globals() throws Exception{
 //BA.debugLineNum = 13;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 14;BA.debugLine="Type session1 (ApplicationName As String, WindowT";
;
 //BA.debugLineNum = 15;BA.debugLine="Type session2 (ImageName As String, PID As String";
;
 //BA.debugLineNum = 17;BA.debugLine="Dim ByUnknown As session1";
_v5 = new b4j.example.main._session1();
 //BA.debugLineNum = 18;BA.debugLine="Dim BySession As session2";
_v6 = new b4j.example.main._session2();
 //BA.debugLineNum = 20;BA.debugLine="Dim processBy As ProcessByPID";
_v7 = new b4j.example.processbypid();
 //BA.debugLineNum = 21;BA.debugLine="Dim PID As String";
_v0 = "";
 //BA.debugLineNum = 23;BA.debugLine="Dim components() As String";
_vv1 = new String[(int) (0)];
java.util.Arrays.fill(_vv1,"");
 //BA.debugLineNum = 24;BA.debugLine="Dim componentsMap As Map";
_vv2 = new anywheresoftware.b4a.objects.collections.Map();
 //BA.debugLineNum = 25;BA.debugLine="Dim jo As JavaObject";
_vv3 = new anywheresoftware.b4j.object.JavaObject();
 //BA.debugLineNum = 26;BA.debugLine="Private js  As Shell";
_vvv2 = new anywheresoftware.b4j.objects.Shell();
 //BA.debugLineNum = 27;BA.debugLine="Dim Value As String";
_vv4 = "";
 //BA.debugLineNum = 28;BA.debugLine="End Sub";
return "";
}
}
