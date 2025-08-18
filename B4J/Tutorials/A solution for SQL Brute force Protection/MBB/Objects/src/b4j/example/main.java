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
            frm.initWithStage(ba, stage, 600, 300);
            ba.raiseEvent(null, "appstart", frm, (String[])getParameters().getRaw().toArray(new String[0]));
        } catch (Throwable t) {
            BA.printException(t, true);
            System.exit(1);
        }
    }
public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static anywheresoftware.b4j.objects.Form _mainform = null;
public static anywheresoftware.b4a.objects.Timer _timer1 = null;
public static anywheresoftware.b4j.objects.Shell _shl = null;
public static String _errsource = "";
public static String _errdate = "";
public static String _errdesc = "";
public static long _rulecount = 0L;
public static anywheresoftware.b4j.objects.LabelWrapper _label1 = null;
public static anywheresoftware.b4j.objects.LabelWrapper _label2 = null;
public static boolean  _application_error(anywheresoftware.b4a.objects.B4AException _error,String _stacktrace) throws Exception{
 //BA.debugLineNum = 179;BA.debugLine="Sub Application_Error (Error As Exception, StackTr";
 //BA.debugLineNum = 180;BA.debugLine="Return True";
if (true) return anywheresoftware.b4a.keywords.Common.True;
 //BA.debugLineNum = 181;BA.debugLine="End Sub";
return false;
}
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
 //BA.debugLineNum = 22;BA.debugLine="Sub AppStart (form1 As Form,Args() As String)";
 //BA.debugLineNum = 24;BA.debugLine="DateTime.TimeFormat = \"HH:mm:ss\"";
anywheresoftware.b4a.keywords.Common.DateTime.setTimeFormat("HH:mm:ss");
 //BA.debugLineNum = 25;BA.debugLine="DateTime.DateFormat = \"yyyy-MM-dd\"";
anywheresoftware.b4a.keywords.Common.DateTime.setDateFormat("yyyy-MM-dd");
 //BA.debugLineNum = 26;BA.debugLine="MainForm = form1";
_mainform = _form1;
 //BA.debugLineNum = 27;BA.debugLine="MainForm.RootPane.LoadLayout(\"a1\")";
_mainform.getRootPane().LoadLayout(ba,"a1");
 //BA.debugLineNum = 29;BA.debugLine="MainForm.Title=\"MBB for MySQL/MariaDB\"";
_mainform.setTitle("MBB for MySQL/MariaDB");
 //BA.debugLineNum = 30;BA.debugLine="MainForm.show";
_mainform.Show();
 //BA.debugLineNum = 33;BA.debugLine="shl.Initialize(\"sh1\",\"delpol.bat\", Null)";
_shl.Initialize("sh1","delpol.bat",(anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(anywheresoftware.b4a.keywords.Common.Null)));
 //BA.debugLineNum = 34;BA.debugLine="shl.WorkingDirectory = File.DirApp";
_shl.setWorkingDirectory(anywheresoftware.b4a.keywords.Common.File.getDirApp());
 //BA.debugLineNum = 35;BA.debugLine="shl.Run(-1)";
_shl.Run(ba,(long) (-1));
 //BA.debugLineNum = 38;BA.debugLine="timer1.Initialize(\"timers1\",1000)";
_timer1.Initialize(ba,"timers1",(long) (1000));
 //BA.debugLineNum = 39;BA.debugLine="timer1.Enabled=True";
_timer1.setEnabled(anywheresoftware.b4a.keywords.Common.True);
 //BA.debugLineNum = 42;BA.debugLine="End Sub";
return "";
}
public static String  _blockip(String _ip) throws Exception{
 //BA.debugLineNum = 106;BA.debugLine="Sub blockip(ip As String)";
 //BA.debugLineNum = 111;BA.debugLine="shl.Initialize(\"shl\", \"netsh\", _      Array As St";
_shl.Initialize("shl","netsh",anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{"advfirewall","firewall","add","rule","name="+BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr((int) (30)))+"MBB IP BLOCK"+BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr((int) (30))),"dir=in","interface=any","action=block","remoteip="+_ip+"/32"}));
 //BA.debugLineNum = 115;BA.debugLine="shl.Run(-1) 'set a timeout of 10 seconds";
_shl.Run(ba,(long) (-1));
 //BA.debugLineNum = 117;BA.debugLine="End Sub";
return "";
}
public static String  _blockipsec(String _ip,int _rule) throws Exception{
String _r = "";
 //BA.debugLineNum = 143;BA.debugLine="Sub blockipsec(ip As String, rule As Int)";
 //BA.debugLineNum = 147;BA.debugLine="Dim r As String";
_r = "";
 //BA.debugLineNum = 148;BA.debugLine="r=rule";
_r = BA.NumberToString(_rule);
 //BA.debugLineNum = 151;BA.debugLine="shl.Initialize(\"sh1\", \"blockip.bat\", Array As Str";
_shl.Initialize("sh1","blockip.bat",anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{_r.trim(),_ip.trim()}));
 //BA.debugLineNum = 152;BA.debugLine="shl.WorkingDirectory = File.DirApp";
_shl.setWorkingDirectory(anywheresoftware.b4a.keywords.Common.File.getDirApp());
 //BA.debugLineNum = 154;BA.debugLine="shl.Run(10000)";
_shl.Run(ba,(long) (10000));
 //BA.debugLineNum = 157;BA.debugLine="End Sub";
return "";
}
public static String  _checkandblock(String _ip) throws Exception{
String _whatip = "";
anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper _stream = null;
String _logstring = "";
byte[] _data = null;
 //BA.debugLineNum = 119;BA.debugLine="Sub checkandblock(ip As String)";
 //BA.debugLineNum = 121;BA.debugLine="Dim whatip As String=getip(ip)";
_whatip = _getip(_ip);
 //BA.debugLineNum = 124;BA.debugLine="Dim stream As OutputStream = File.OpenOutput(File";
_stream = new anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper();
_stream = anywheresoftware.b4a.keywords.Common.File.OpenOutput(anywheresoftware.b4a.keywords.Common.File.getDirApp(),"accessdenied.log",anywheresoftware.b4a.keywords.Common.True);
 //BA.debugLineNum = 125;BA.debugLine="Dim LogString As String";
_logstring = "";
 //BA.debugLineNum = 126;BA.debugLine="LogString = DateTime.Date(DateTime.Now) & \" | \" &";
_logstring = anywheresoftware.b4a.keywords.Common.DateTime.Date(anywheresoftware.b4a.keywords.Common.DateTime.getNow())+" | "+anywheresoftware.b4a.keywords.Common.DateTime.Time(anywheresoftware.b4a.keywords.Common.DateTime.getNow())+" | "+_whatip+" | "+_errdesc.replace(BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr((int) (13)))," ")+BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr((int) (13)))+BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr((int) (10)));
 //BA.debugLineNum = 127;BA.debugLine="Dim Data() As Byte";
_data = new byte[(int) (0)];
;
 //BA.debugLineNum = 128;BA.debugLine="Data = LogString.GetBytes(\"UTF8\")";
_data = _logstring.getBytes("UTF8");
 //BA.debugLineNum = 129;BA.debugLine="stream.WriteBytes(Data,0,Data.Length)";
_stream.WriteBytes(_data,(int) (0),_data.length);
 //BA.debugLineNum = 130;BA.debugLine="stream.Close";
_stream.Close();
 //BA.debugLineNum = 132;BA.debugLine="If IsNumber(whatip.Replace(\".\",\"\"))=True Then";
if (anywheresoftware.b4a.keywords.Common.IsNumber(_whatip.replace(".",""))==anywheresoftware.b4a.keywords.Common.True) { 
 //BA.debugLineNum = 133;BA.debugLine="rulecount=rulecount+1";
_rulecount = (long) (_rulecount+1);
 //BA.debugLineNum = 134;BA.debugLine="Label2.Text = rulecount";
_label2.setText(BA.NumberToString(_rulecount));
 //BA.debugLineNum = 135;BA.debugLine="blockipsec(whatip.Trim,rulecount)";
_blockipsec(_whatip.trim(),(int) (_rulecount));
 };
 //BA.debugLineNum = 138;BA.debugLine="whatip=Null";
_whatip = BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Null);
 //BA.debugLineNum = 139;BA.debugLine="ip=Null";
_ip = BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Null);
 //BA.debugLineNum = 141;BA.debugLine="End Sub";
return "";
}
public static String  _deleterule(int _rule) throws Exception{
String _r = "";
 //BA.debugLineNum = 159;BA.debugLine="Sub deleterule(rule As Int)";
 //BA.debugLineNum = 160;BA.debugLine="Dim r As String";
_r = "";
 //BA.debugLineNum = 161;BA.debugLine="r=rule";
_r = BA.NumberToString(_rule);
 //BA.debugLineNum = 162;BA.debugLine="shl.Initialize(\"shl\", \"delrule.bat\", _      Array";
_shl.Initialize("shl","delrule.bat",anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{_r.trim()}));
 //BA.debugLineNum = 164;BA.debugLine="shl.Run(10000)";
_shl.Run(ba,(long) (10000));
 //BA.debugLineNum = 165;BA.debugLine="End Sub";
return "";
}
public static String  _getip(String _ip) throws Exception{
String _newip = "";
 //BA.debugLineNum = 94;BA.debugLine="Sub getip(ip As String) As String";
 //BA.debugLineNum = 95;BA.debugLine="shl.Initialize(\"sh1\",\"ping1.bat\",Array As String(";
_shl.Initialize("sh1","ping1.bat",anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{_ip}));
 //BA.debugLineNum = 96;BA.debugLine="shl.WorkingDirectory = File.DirApp";
_shl.setWorkingDirectory(anywheresoftware.b4a.keywords.Common.File.getDirApp());
 //BA.debugLineNum = 97;BA.debugLine="shl.Run(10000)";
_shl.Run(ba,(long) (10000));
 //BA.debugLineNum = 98;BA.debugLine="Dim newip As String=File.ReadString(File.DirApp,\"";
_newip = anywheresoftware.b4a.keywords.Common.File.ReadString(anywheresoftware.b4a.keywords.Common.File.getDirApp(),"ip.txt");
 //BA.debugLineNum = 99;BA.debugLine="If newip.indexof(\"[\")>1 Then";
if (_newip.indexOf("[")>1) { 
 //BA.debugLineNum = 100;BA.debugLine="Return newip.SubString2(newip.indexof(\"[\")+1,new";
if (true) return _newip.substring((int) (_newip.indexOf("[")+1),_newip.indexOf("]"));
 }else {
 //BA.debugLineNum = 102;BA.debugLine="Return ip";
if (true) return _ip;
 };
 //BA.debugLineNum = 104;BA.debugLine="End Sub";
return "";
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
}public static String  _process_globals() throws Exception{
 //BA.debugLineNum = 9;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 10;BA.debugLine="Private fx As JFX";
_fx = new anywheresoftware.b4j.objects.JFX();
 //BA.debugLineNum = 11;BA.debugLine="Private MainForm As Form";
_mainform = new anywheresoftware.b4j.objects.Form();
 //BA.debugLineNum = 12;BA.debugLine="Public timer1 As Timer";
_timer1 = new anywheresoftware.b4a.objects.Timer();
 //BA.debugLineNum = 13;BA.debugLine="Dim shl As Shell";
_shl = new anywheresoftware.b4j.objects.Shell();
 //BA.debugLineNum = 14;BA.debugLine="Dim errsource As String";
_errsource = "";
 //BA.debugLineNum = 15;BA.debugLine="Dim errdate As String";
_errdate = "";
 //BA.debugLineNum = 16;BA.debugLine="Dim errdesc As String";
_errdesc = "";
 //BA.debugLineNum = 17;BA.debugLine="Dim rulecount As Long";
_rulecount = 0L;
 //BA.debugLineNum = 18;BA.debugLine="Private Label1 As Label";
_label1 = new anywheresoftware.b4j.objects.LabelWrapper();
 //BA.debugLineNum = 19;BA.debugLine="Private Label2 As Label";
_label2 = new anywheresoftware.b4j.objects.LabelWrapper();
 //BA.debugLineNum = 20;BA.debugLine="End Sub";
return "";
}
public static String  _shl_processcompleted(boolean _success,int _exitcode,String _stdout,String _stderr) throws Exception{
 //BA.debugLineNum = 168;BA.debugLine="Sub shl_ProcessCompleted (Success As Boolean, Exit";
 //BA.debugLineNum = 169;BA.debugLine="If Success And ExitCode = 0 Then";
if (_success && _exitcode==0) { 
 //BA.debugLineNum = 170;BA.debugLine="Log(\"Success\")";
anywheresoftware.b4a.keywords.Common.Log("Success");
 //BA.debugLineNum = 171;BA.debugLine="Log(StdOut)";
anywheresoftware.b4a.keywords.Common.Log(_stdout);
 }else {
 //BA.debugLineNum = 173;BA.debugLine="Log(\"Error: \" & StdErr)";
anywheresoftware.b4a.keywords.Common.Log("Error: "+_stderr);
 };
 //BA.debugLineNum = 175;BA.debugLine="ExitApplication";
anywheresoftware.b4a.keywords.Common.ExitApplication();
 //BA.debugLineNum = 176;BA.debugLine="End Sub";
return "";
}
public static String  _timers1_tick() throws Exception{
anywheresoftware.b4a.objects.streams.File.InputStreamWrapper _inp = null;
int _b = 0;
byte[] _my_buf = null;
String _data = "";
String _data2 = "";
String _checkip = "";
 //BA.debugLineNum = 44;BA.debugLine="Sub timers1_tick";
 //BA.debugLineNum = 45;BA.debugLine="timer1.Enabled=False";
_timer1.setEnabled(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 49;BA.debugLine="shl.Initialize(\"sh1\",\"apperr.bat\", Null)";
_shl.Initialize("sh1","apperr.bat",(anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(anywheresoftware.b4a.keywords.Common.Null)));
 //BA.debugLineNum = 50;BA.debugLine="shl.WorkingDirectory = File.DirApp";
_shl.setWorkingDirectory(anywheresoftware.b4a.keywords.Common.File.getDirApp());
 //BA.debugLineNum = 51;BA.debugLine="shl.Run(-1)";
_shl.Run(ba,(long) (-1));
 //BA.debugLineNum = 53;BA.debugLine="Dim inp As InputStream";
_inp = new anywheresoftware.b4a.objects.streams.File.InputStreamWrapper();
 //BA.debugLineNum = 54;BA.debugLine="inp = File.OpenInput(File.DirApp,\"apperr.txt\")";
_inp = anywheresoftware.b4a.keywords.Common.File.OpenInput(anywheresoftware.b4a.keywords.Common.File.getDirApp(),"apperr.txt");
 //BA.debugLineNum = 55;BA.debugLine="Dim b As Int";
_b = 0;
 //BA.debugLineNum = 56;BA.debugLine="Dim my_buf(inp.BytesAvailable) As Byte";
_my_buf = new byte[_inp.BytesAvailable()];
;
 //BA.debugLineNum = 57;BA.debugLine="b = inp.ReadBytes(my_buf,0,inp.BytesAvailable)";
_b = _inp.ReadBytes(_my_buf,(int) (0),_inp.BytesAvailable());
 //BA.debugLineNum = 58;BA.debugLine="inp.Close";
_inp.Close();
 //BA.debugLineNum = 59;BA.debugLine="Dim data As String = BytesToString(my_buf,0,b,\"cp";
_data = anywheresoftware.b4a.keywords.Common.BytesToString(_my_buf,(int) (0),_b,"cp1253");
 //BA.debugLineNum = 61;BA.debugLine="Dim inp As InputStream";
_inp = new anywheresoftware.b4a.objects.streams.File.InputStreamWrapper();
 //BA.debugLineNum = 62;BA.debugLine="inp = File.OpenInput(File.DirApp,\"apperr.bak\")";
_inp = anywheresoftware.b4a.keywords.Common.File.OpenInput(anywheresoftware.b4a.keywords.Common.File.getDirApp(),"apperr.bak");
 //BA.debugLineNum = 63;BA.debugLine="Dim b As Int";
_b = 0;
 //BA.debugLineNum = 64;BA.debugLine="Dim my_buf(inp.BytesAvailable) As Byte";
_my_buf = new byte[_inp.BytesAvailable()];
;
 //BA.debugLineNum = 65;BA.debugLine="b = inp.ReadBytes(my_buf,0,inp.BytesAvailable)";
_b = _inp.ReadBytes(_my_buf,(int) (0),_inp.BytesAvailable());
 //BA.debugLineNum = 66;BA.debugLine="inp.Close";
_inp.Close();
 //BA.debugLineNum = 67;BA.debugLine="Dim data2 As String = BytesToString(my_buf,0,b,\"c";
_data2 = anywheresoftware.b4a.keywords.Common.BytesToString(_my_buf,(int) (0),_b,"cp1253");
 //BA.debugLineNum = 69;BA.debugLine="If data<>data2 Then";
if ((_data).equals(_data2) == false) { 
 //BA.debugLineNum = 71;BA.debugLine="errdate=data.SubString2(data.IndexOf(\"Date:\")+5,d";
_errdate = _data.substring((int) (_data.indexOf("Date:")+5),_data.indexOf(anywheresoftware.b4a.keywords.Common.CRLF,(int) (_data.indexOf("Date:")+5))).trim();
 //BA.debugLineNum = 72;BA.debugLine="errsource=data.SubString2(data.IndexOf(\"Source:\")";
_errsource = _data.substring((int) (_data.indexOf("Source:")+7),_data.indexOf(anywheresoftware.b4a.keywords.Common.CRLF,(int) (_data.indexOf("Source:")+7))).trim();
 //BA.debugLineNum = 73;BA.debugLine="errdesc=data.SubString(data.LastIndexOf(\"Descript";
_errdesc = _data.substring((int) (_data.lastIndexOf("Description:")+12)).trim();
 //BA.debugLineNum = 76;BA.debugLine="Log(errdate)";
anywheresoftware.b4a.keywords.Common.Log(_errdate);
 //BA.debugLineNum = 77;BA.debugLine="Log(errsource)";
anywheresoftware.b4a.keywords.Common.Log(_errsource);
 //BA.debugLineNum = 78;BA.debugLine="Log(errdesc)";
anywheresoftware.b4a.keywords.Common.Log(_errdesc);
 //BA.debugLineNum = 79;BA.debugLine="If errsource=\"MySQL\" Then";
if ((_errsource).equals("MySQL")) { 
 //BA.debugLineNum = 80;BA.debugLine="If errdesc.StartsWith(\"Access denied for user\")=T";
if (_errdesc.startsWith("Access denied for user")==anywheresoftware.b4a.keywords.Common.True) { 
 //BA.debugLineNum = 81;BA.debugLine="Dim checkip As String=errdesc.SubString2(errdesc";
_checkip = _errdesc.substring((int) (_errdesc.indexOf("@'")+2),_errdesc.lastIndexOf("'"));
 //BA.debugLineNum = 82;BA.debugLine="checkandblock(checkip.trim)";
_checkandblock(_checkip.trim());
 };
 };
 };
 //BA.debugLineNum = 90;BA.debugLine="timer1.Enabled=True";
_timer1.setEnabled(anywheresoftware.b4a.keywords.Common.True);
 //BA.debugLineNum = 92;BA.debugLine="End Sub";
return "";
}
}
