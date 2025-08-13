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
public static anywheresoftware.b4j.objects.JFX _vvvvvvvv0 = null;
public static anywheresoftware.b4j.objects.Form _vvvvvvv3 = null;
public static anywheresoftware.b4j.objects.FileChooserWrapper _vvvvvvvv1 = null;
public static String _v5 = "";
public static String _vvvvvvv5 = "";
public static anywheresoftware.b4j.object.JavaObject _vvvvvvv2 = null;
public static b4j.example.processbypid _vvvvvvv4 = null;
public static anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _tfhost = null;
public static anywheresoftware.b4j.objects.LabelWrapper _lbldiscovering = null;
public static anywheresoftware.b4j.objects.ListViewWrapper _lvdevices = null;
public static anywheresoftware.b4j.objects.ButtonWrapper _btndiscover = null;
public static anywheresoftware.b4j.objects.TextInputControlWrapper.TextAreaWrapper _taapkfullfilename = null;
public static anywheresoftware.b4j.objects.ButtonWrapper _btninstall = null;
public static anywheresoftware.b4j.objects.ButtonWrapper _btnexitapp = null;
public static anywheresoftware.b4j.objects.ButtonWrapper _btnchoosefileapp = null;
public static String _vv5 = "";
public static b4j.example.keyvaluestore _vvvvvvv6 = null;
public static b4j.example.callsubutils _v6 = null;
public static b4j.example.autodiscover _vvvvvvvv5 = null;
public static int _vvvvvvvv6 = 0;
public static int _vvvvvvvv3 = 0;
public static com.stevel05.draganddrop.draganddrop _vvvvvvv7 = null;
public static com.stevel05.draganddrop.transfermode _vv6 = null;
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
anywheresoftware.b4j.objects.ImageViewWrapper.ImageWrapper _img = null;
anywheresoftware.b4a.objects.SocketWrapper.UDPSocket _udpsocket = null;
boolean _ef = false;
String _arg = "";
 //BA.debugLineNum = 47;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
 //BA.debugLineNum = 48;BA.debugLine="MainForm = Form1";
_vvvvvvv3 = _form1;
 //BA.debugLineNum = 49;BA.debugLine="MainForm.RootPane.LoadLayout(\"main\") 'Load the la";
_vvvvvvv3.getRootPane().LoadLayout(ba,"main");
 //BA.debugLineNum = 50;BA.debugLine="MainForm.Title = \"MultiB4ABridge - B4J\"";
_vvvvvvv3.setTitle("MultiB4ABridge - B4J");
 //BA.debugLineNum = 52;BA.debugLine="MainForm.Stylesheets.Add(File.GetUri(File.DirAsse";
_vvvvvvv3.getStylesheets().Add((Object)(anywheresoftware.b4a.keywords.Common.File.GetUri(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"style1_mainform_dark.css")));
 //BA.debugLineNum = 54;BA.debugLine="Dim Img As Image";
_img = new anywheresoftware.b4j.objects.ImageViewWrapper.ImageWrapper();
 //BA.debugLineNum = 55;BA.debugLine="Img.InitializeSample(File.DirAssets,\"icon.png\",32";
_img.InitializeSample(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"icon.png",32,32);
 //BA.debugLineNum = 56;BA.debugLine="MainForm.Icon = Img";
_vvvvvvv3.setIcon((javafx.scene.image.Image)(_img.getObject()));
 //BA.debugLineNum = 58;BA.debugLine="MainForm.Show";
_vvvvvvv3.Show();
 //BA.debugLineNum = 60;BA.debugLine="processBy.Initialize";
_vvvvvvv4._initialize /*String*/ (ba);
 //BA.debugLineNum = 61;BA.debugLine="btnExitApp.RequestFocus";
_btnexitapp.RequestFocus();
 //BA.debugLineNum = 63;BA.debugLine="jo.InitializeStatic(\"java.lang.management.Managem";
_vvvvvvv2.InitializeStatic("java.lang.management.ManagementFactory");
 //BA.debugLineNum = 64;BA.debugLine="PID = jo.RunMethodJO(\"getRuntimeMXBean\",Null).Run";
_vvvvvvv5 = BA.ObjectToString(_vvvvvvv2.RunMethodJO("getRuntimeMXBean",(Object[])(anywheresoftware.b4a.keywords.Common.Null)).RunMethod("getName",(Object[])(anywheresoftware.b4a.keywords.Common.Null)));
 //BA.debugLineNum = 65;BA.debugLine="PID = PID.SubString2(0,PID.IndexOf(\"@\"))";
_vvvvvvv5 = _vvvvvvv5.substring((int) (0),_vvvvvvv5.indexOf("@"));
 //BA.debugLineNum = 68;BA.debugLine="Dim udpsocket As UDPSocket";
_udpsocket = new anywheresoftware.b4a.objects.SocketWrapper.UDPSocket();
 //BA.debugLineNum = 69;BA.debugLine="udpsocket.Initialize(\"udpsocket\", 0, 8192)";
_udpsocket.Initialize(ba,"udpsocket",(int) (0),(int) (8192));
 //BA.debugLineNum = 70;BA.debugLine="mHost = udpsocket.GetBroadcastAddress";
_vv5 = _udpsocket.GetBroadcastAddress();
 //BA.debugLineNum = 71;BA.debugLine="udpsocket.Close";
_udpsocket.Close();
 //BA.debugLineNum = 74;BA.debugLine="Private eF As Boolean = File.Exists(File.DirApp,";
_ef = anywheresoftware.b4a.keywords.Common.File.Exists(anywheresoftware.b4a.keywords.Common.File.getDirApp(),"Settings.kvs2");
 //BA.debugLineNum = 75;BA.debugLine="kvs.Initialize(File.DirApp, \"Settings.kvs2\")";
_vvvvvvv6._initialize /*String*/ (ba,anywheresoftware.b4a.keywords.Common.File.getDirApp(),"Settings.kvs2");
 //BA.debugLineNum = 76;BA.debugLine="If eF = False Then";
if (_ef==anywheresoftware.b4a.keywords.Common.False) { 
 //BA.debugLineNum = 77;BA.debugLine="kvs.PutEncrypted(\"APKFullFileName\",\"\",x)";
_vvvvvvv6._vvvvvv1 /*String*/ ("APKFullFileName",(Object)(""),_v5);
 //BA.debugLineNum = 78;BA.debugLine="kvs.PutEncrypted(\"Host\", mHost,x)";
_vvvvvvv6._vvvvvv1 /*String*/ ("Host",(Object)(_vv5),_v5);
 //BA.debugLineNum = 79;BA.debugLine="kvs.PutEncrypted(\"Path\", File.DirApp, x)";
_vvvvvvv6._vvvvvv1 /*String*/ ("Path",(Object)(anywheresoftware.b4a.keywords.Common.File.getDirApp()),_v5);
 };
 //BA.debugLineNum = 81;BA.debugLine="taAPKFullFileName.Text = kvs.GetEncrypted(\"APKFul";
_taapkfullfilename.setText(BA.ObjectToString(_vvvvvvv6._vvvvv5 /*Object*/ ("APKFullFileName",_v5)));
 //BA.debugLineNum = 82;BA.debugLine="tfHost.Text = kvs.GetEncrypted(\"Host\",x)";
_tfhost.setText(BA.ObjectToString(_vvvvvvv6._vvvvv5 /*Object*/ ("Host",_v5)));
 //BA.debugLineNum = 86;BA.debugLine="If Args.Length > 0 Then";
if (_args.length>0) { 
 //BA.debugLineNum = 87;BA.debugLine="For Each arg As String In Args";
{
final String[] group28 = _args;
final int groupLen28 = group28.length
;int index28 = 0;
;
for (; index28 < groupLen28;index28++){
_arg = group28[index28];
 //BA.debugLineNum = 88;BA.debugLine="If IsNumber(arg.SubString2(0,1)) = True And arg";
if (anywheresoftware.b4a.keywords.Common.IsNumber(_arg.substring((int) (0),(int) (1)))==anywheresoftware.b4a.keywords.Common.True && _arg.indexOf(".")>-1) { 
 //BA.debugLineNum = 89;BA.debugLine="tfHost.Text = arg";
_tfhost.setText(_arg);
 }else {
 //BA.debugLineNum = 91;BA.debugLine="taAPKFullFileName.Text = arg";
_taapkfullfilename.setText(_arg);
 };
 }
};
 }else {
 };
 //BA.debugLineNum = 100;BA.debugLine="DragDrop.Initialize(Me)";
_vvvvvvv7._initialize(ba,main.getObject());
 //BA.debugLineNum = 101;BA.debugLine="DragDrop.MakeDragTarget(taAPKFullFileName, \"taAPK";
_vvvvvvv7._makedragtarget((anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper(), (javafx.scene.Node)(_taapkfullfilename.getObject())),"taAPKFullFileName");
 //BA.debugLineNum = 103;BA.debugLine="csu.Initialize";
_v6._initialize /*String*/ (ba);
 //BA.debugLineNum = 104;BA.debugLine="DiscoverTask";
_vvvvvvv0();
 //BA.debugLineNum = 105;BA.debugLine="End Sub";
return "";
}
public static String  _autodiscover_found(String _devicename,String _deviceip) throws Exception{
 //BA.debugLineNum = 283;BA.debugLine="Public Sub AutoDiscover_Found (DeviceName As Strin";
 //BA.debugLineNum = 284;BA.debugLine="lvDevices.Items.Add($\"${DeviceIp} - ${DeviceName}";
_lvdevices.getItems().Add((Object)((""+anywheresoftware.b4a.keywords.Common.SmartStringFormatter("",(Object)(_deviceip))+" - "+anywheresoftware.b4a.keywords.Common.SmartStringFormatter("",(Object)(_devicename))+"")));
 //BA.debugLineNum = 285;BA.debugLine="End Sub";
return "";
}
public static String  _btnchoosefileapp_click() throws Exception{
String _fd = "";
int _endindex = 0;
String _isdirectory = "";
String _apkname = "";
 //BA.debugLineNum = 170;BA.debugLine="Sub btnChooseFileApp_Click";
 //BA.debugLineNum = 171;BA.debugLine="If taAPKFullFileName.Enabled = True Then";
if (_taapkfullfilename.getEnabled()==anywheresoftware.b4a.keywords.Common.True) { 
 //BA.debugLineNum = 172;BA.debugLine="fc.Initialize";
_vvvvvvvv1.Initialize();
 //BA.debugLineNum = 173;BA.debugLine="fc.Title = \"File Explorer\"";
_vvvvvvvv1.setTitle("File Explorer");
 //BA.debugLineNum = 174;BA.debugLine="Private fd As String = kvs.GetEncrypted(\"Path\",";
_fd = BA.ObjectToString(_vvvvvvv6._vvvvv5 /*Object*/ ("Path",_v5));
 //BA.debugLineNum = 175;BA.debugLine="If fd <> \"\" Then";
if ((_fd).equals("") == false) { 
 //BA.debugLineNum = 176;BA.debugLine="fc.InitialDirectory = fd";
_vvvvvvvv1.setInitialDirectory(_fd);
 }else {
 //BA.debugLineNum = 178;BA.debugLine="If taAPKFullFileName.Text <> \"\" Then";
if ((_taapkfullfilename.getText()).equals("") == false) { 
 //BA.debugLineNum = 179;BA.debugLine="Private endindex As Int = taAPKFullFileName.Te";
_endindex = _taapkfullfilename.getText().lastIndexOf("\\");
 //BA.debugLineNum = 180;BA.debugLine="If endindex > 0 Then";
if (_endindex>0) { 
 //BA.debugLineNum = 181;BA.debugLine="Private isDirectory As String = taAPKFullFile";
_isdirectory = _taapkfullfilename.getText().substring((int) (0),_endindex);
 //BA.debugLineNum = 182;BA.debugLine="If File.IsDirectory(isDirectory,\"\") Then";
if (anywheresoftware.b4a.keywords.Common.File.IsDirectory(_isdirectory,"")) { 
 //BA.debugLineNum = 183;BA.debugLine="fc.InitialDirectory = taAPKFullFileName.Text";
_vvvvvvvv1.setInitialDirectory(_taapkfullfilename.getText().substring((int) (0),_endindex));
 }else {
 //BA.debugLineNum = 185;BA.debugLine="fc.InitialDirectory = File.DirApp";
_vvvvvvvv1.setInitialDirectory(anywheresoftware.b4a.keywords.Common.File.getDirApp());
 };
 }else {
 //BA.debugLineNum = 188;BA.debugLine="fc.InitialDirectory = File.DirApp";
_vvvvvvvv1.setInitialDirectory(anywheresoftware.b4a.keywords.Common.File.getDirApp());
 };
 };
 };
 //BA.debugLineNum = 192;BA.debugLine="fc.SetExtensionFilter(\"APK-application\", Array A";
_vvvvvvvv1.SetExtensionFilter("APK-application",anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{"*.apk"}));
 //BA.debugLineNum = 193;BA.debugLine="Private apkname As String = fc.ShowOpen(MainForm";
_apkname = _vvvvvvvv1.ShowOpen(_vvvvvvv3);
 //BA.debugLineNum = 194;BA.debugLine="If apkname <> \"\" Then";
if ((_apkname).equals("") == false) { 
 //BA.debugLineNum = 195;BA.debugLine="kvs.PutEncrypted(\"Path\", fc.InitialDirectory, x";
_vvvvvvv6._vvvvvv1 /*String*/ ("Path",(Object)(_vvvvvvvv1.getInitialDirectory()),_v5);
 //BA.debugLineNum = 196;BA.debugLine="taAPKFullFileName.Text = apkname";
_taapkfullfilename.setText(_apkname);
 };
 };
 //BA.debugLineNum = 199;BA.debugLine="End Sub";
return "";
}
public static String  _btndiscover_click() throws Exception{
 //BA.debugLineNum = 109;BA.debugLine="Sub btnDiscover_Click";
 //BA.debugLineNum = 110;BA.debugLine="btnExitApp.RequestFocus";
_btnexitapp.RequestFocus();
 //BA.debugLineNum = 111;BA.debugLine="btnDiscover.Visible = False";
_btndiscover.setVisible(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 112;BA.debugLine="btnInstall.Visible = False";
_btninstall.setVisible(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 113;BA.debugLine="tfHost.Enabled = False";
_tfhost.setEnabled(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 114;BA.debugLine="taAPKFullFileName.Enabled = False";
_taapkfullfilename.setEnabled(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 115;BA.debugLine="lblDiscovering.Text = Chr(0xF211) & \"  Discoverin";
_lbldiscovering.setText(BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr(((int)0xf211)))+"  Discovering, please wait...");
 //BA.debugLineNum = 116;BA.debugLine="lvDevices.Items.Clear";
_lvdevices.getItems().Clear();
 //BA.debugLineNum = 117;BA.debugLine="DiscoverTask";
_vvvvvvv0();
 //BA.debugLineNum = 118;BA.debugLine="End Sub";
return "";
}
public static String  _btnexitapp_click() throws Exception{
 //BA.debugLineNum = 201;BA.debugLine="Sub btnExitApp_Click";
 //BA.debugLineNum = 202;BA.debugLine="MainForm.Close";
_vvvvvvv3.Close();
 //BA.debugLineNum = 203;BA.debugLine="End Sub";
return "";
}
public static String  _btninstall_click() throws Exception{
anywheresoftware.b4a.objects.collections.List _lsttargetips = null;
String _targetip = "";
String _item = "";
String _device = "";
 //BA.debugLineNum = 150;BA.debugLine="Sub btnInstall_Click";
 //BA.debugLineNum = 151;BA.debugLine="If taAPKFullFileName.Text <> \"\" And File.Exists(F";
if ((_taapkfullfilename.getText()).equals("") == false && anywheresoftware.b4a.keywords.Common.File.Exists(anywheresoftware.b4a.keywords.Common.File.GetFileParent(_taapkfullfilename.getText()),anywheresoftware.b4a.keywords.Common.File.GetName(_taapkfullfilename.getText()))) { 
 //BA.debugLineNum = 152;BA.debugLine="EnableViews(False)";
_vvvvvvvv2(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 153;BA.debugLine="btnInstall.Visible = False";
_btninstall.setVisible(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 154;BA.debugLine="Dim lstTargetIPs As List";
_lsttargetips = new anywheresoftware.b4a.objects.collections.List();
 //BA.debugLineNum = 155;BA.debugLine="lstTargetIPs.Initialize";
_lsttargetips.Initialize();
 //BA.debugLineNum = 156;BA.debugLine="Dim TargetIP As String";
_targetip = "";
 //BA.debugLineNum = 157;BA.debugLine="Dim Item As String";
_item = "";
 //BA.debugLineNum = 158;BA.debugLine="NumOfFileSent = 0";
_vvvvvvvv3 = (int) (0);
 //BA.debugLineNum = 159;BA.debugLine="For Each Device As String In lvDevices.GetSelect";
{
final anywheresoftware.b4a.BA.IterableList group9 = _lvdevices.GetSelectedIndices();
final int groupLen9 = group9.getSize()
;int index9 = 0;
;
for (; index9 < groupLen9;index9++){
_device = BA.ObjectToString(group9.Get(index9));
 //BA.debugLineNum = 160;BA.debugLine="Item = lvDevices.Items.Get(Device)";
_item = BA.ObjectToString(_lvdevices.getItems().Get((int)(Double.parseDouble(_device))));
 //BA.debugLineNum = 161;BA.debugLine="TargetIP = Regex.Split(\" - \", Item)(0).Trim";
_targetip = anywheresoftware.b4a.keywords.Common.Regex.Split(" - ",_item)[(int) (0)].trim();
 //BA.debugLineNum = 162;BA.debugLine="lstTargetIPs.Add(TargetIP)";
_lsttargetips.Add((Object)(_targetip));
 }
};
 //BA.debugLineNum = 164;BA.debugLine="Install(lstTargetIPs)";
_vvvvvvvv4(_lsttargetips);
 }else {
 //BA.debugLineNum = 166;BA.debugLine="CallSubDelayed(Me, \"btnChooseFileApp_Click\")";
anywheresoftware.b4a.keywords.Common.CallSubDelayed(ba,main.getObject(),"btnChooseFileApp_Click");
 };
 //BA.debugLineNum = 168;BA.debugLine="End Sub";
return "";
}
public static String  _client_connected(b4j.example.client _clnt) throws Exception{
 //BA.debugLineNum = 279;BA.debugLine="Public Sub Client_Connected(Clnt As Client)";
 //BA.debugLineNum = 280;BA.debugLine="Clnt.SendFile(taAPKFullFileName.Text)";
_clnt._vvv6 /*String*/ (_taapkfullfilename.getText());
 //BA.debugLineNum = 281;BA.debugLine="End Sub";
return "";
}
public static String  _vvvvvvv0() throws Exception{
 //BA.debugLineNum = 209;BA.debugLine="Private Sub DiscoverTask";
 //BA.debugLineNum = 210;BA.debugLine="EnableViews(False)";
_vvvvvvvv2(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 211;BA.debugLine="auto.Initialize(tfHost.Text)";
_vvvvvvvv5._initialize /*String*/ (ba,_tfhost.getText());
 //BA.debugLineNum = 212;BA.debugLine="auto.Start";
_vvvvvvvv5._v7 /*String*/ ();
 //BA.debugLineNum = 213;BA.debugLine="csu.CallSubPlus(Me, \"StopDiscover\", DiscoverTimeo";
_v6._vvv1 /*b4j.example.callsubutils._rundelayeddata*/ (main.getObject(),"StopDiscover",_vvvvvvvv6);
 //BA.debugLineNum = 214;BA.debugLine="End Sub";
return "";
}
public static String  _vvvvvvvv2(boolean _enable) throws Exception{
 //BA.debugLineNum = 268;BA.debugLine="Private Sub EnableViews(Enable As Boolean)";
 //BA.debugLineNum = 269;BA.debugLine="btnDiscover.Visible = Enable";
_btndiscover.setVisible(_enable);
 //BA.debugLineNum = 270;BA.debugLine="tfHost.Enabled = Enable";
_tfhost.setEnabled(_enable);
 //BA.debugLineNum = 271;BA.debugLine="taAPKFullFileName.Enabled = Enable";
_taapkfullfilename.setEnabled(_enable);
 //BA.debugLineNum = 272;BA.debugLine="EnablingInstallation";
_vvvvvvvv7();
 //BA.debugLineNum = 273;BA.debugLine="End Sub";
return "";
}
public static String  _vvvvvvvv7() throws Exception{
String _apkfullfilename = "";
String _item = "";
String _device = "";
String _dir = "";
String _filename = "";
int _p = 0;
 //BA.debugLineNum = 240;BA.debugLine="Private Sub EnablingInstallation";
 //BA.debugLineNum = 241;BA.debugLine="Dim APKFullFileName As String = taAPKFullFileName";
_apkfullfilename = _taapkfullfilename.getText();
 //BA.debugLineNum = 242;BA.debugLine="btnInstall.Visible = (lvDevices.GetSelectedIndice";
_btninstall.setVisible((_lvdevices.GetSelectedIndices().getSize()>0 && _apkfullfilename.length()>0 && _apkfullfilename.endsWith(".apk")));
 //BA.debugLineNum = 245;BA.debugLine="Dim Item As String";
_item = "";
 //BA.debugLineNum = 246;BA.debugLine="For Each Device As String In lvDevices.GetSelecte";
{
final anywheresoftware.b4a.BA.IterableList group4 = _lvdevices.GetSelectedIndices();
final int groupLen4 = group4.getSize()
;int index4 = 0;
;
for (; index4 < groupLen4;index4++){
_device = BA.ObjectToString(group4.Get(index4));
 //BA.debugLineNum = 247;BA.debugLine="Item = lvDevices.Items.Get(Device)";
_item = BA.ObjectToString(_lvdevices.getItems().Get((int)(Double.parseDouble(_device))));
 //BA.debugLineNum = 248;BA.debugLine="If Item.EndsWith(\"(not started)\") Then";
if (_item.endsWith("(not started)")) { 
 //BA.debugLineNum = 249;BA.debugLine="btnInstall.Enabled = False";
_btninstall.setEnabled(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 250;BA.debugLine="Return";
if (true) return "";
 };
 }
};
 //BA.debugLineNum = 255;BA.debugLine="Dim Dir, FileName As String";
_dir = "";
_filename = "";
 //BA.debugLineNum = 256;BA.debugLine="Dim p As Int = APKFullFileName.LastIndexOf(\"/\")";
_p = _apkfullfilename.lastIndexOf("/");
 //BA.debugLineNum = 257;BA.debugLine="If p <> - 1 Then";
if (_p!=-1) { 
 //BA.debugLineNum = 258;BA.debugLine="Dir = APKFullFileName.SubString2(0, p)";
_dir = _apkfullfilename.substring((int) (0),_p);
 //BA.debugLineNum = 259;BA.debugLine="FileName = APKFullFileName.SubString(p + 1)";
_filename = _apkfullfilename.substring((int) (_p+1));
 //BA.debugLineNum = 260;BA.debugLine="btnInstall.Visible = btnInstall.Visible And File";
_btninstall.setVisible(_btninstall.getVisible() && anywheresoftware.b4a.keywords.Common.File.Exists(_dir,_filename));
 //BA.debugLineNum = 261;BA.debugLine="btnInstall.Enabled = btnInstall.Visible";
_btninstall.setEnabled(_btninstall.getVisible());
 }else {
 //BA.debugLineNum = 263;BA.debugLine="btnInstall.Visible = False";
_btninstall.setVisible(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 264;BA.debugLine="Return";
if (true) return "";
 };
 //BA.debugLineNum = 266;BA.debugLine="End Sub";
return "";
}
public static String  _vvvvvvvv4(anywheresoftware.b4a.objects.collections.List _lsttargetips) throws Exception{
String _targetip = "";
b4j.example.client _clnt = null;
 //BA.debugLineNum = 233;BA.debugLine="Private Sub Install(lstTargetIPs As List)";
 //BA.debugLineNum = 234;BA.debugLine="For Each TargetIP As String In lstTargetIPs";
{
final anywheresoftware.b4a.BA.IterableList group1 = _lsttargetips;
final int groupLen1 = group1.getSize()
;int index1 = 0;
;
for (; index1 < groupLen1;index1++){
_targetip = BA.ObjectToString(group1.Get(index1));
 //BA.debugLineNum = 235;BA.debugLine="Dim clnt As Client";
_clnt = new b4j.example.client();
 //BA.debugLineNum = 236;BA.debugLine="clnt.Initialize(TargetIP)";
_clnt._initialize /*String*/ (ba,_targetip);
 }
};
 //BA.debugLineNum = 238;BA.debugLine="End Sub";
return "";
}
public static String  _lvdevices_selectedindexchanged(int _index) throws Exception{
 //BA.debugLineNum = 120;BA.debugLine="Sub lvDevices_SelectedIndexChanged(Index As Int)";
 //BA.debugLineNum = 122;BA.debugLine="EnablingInstallation";
_vvvvvvvv7();
 //BA.debugLineNum = 124;BA.debugLine="If btnInstall.Enabled = False Then";
if (_btninstall.getEnabled()==anywheresoftware.b4a.keywords.Common.False) { 
 //BA.debugLineNum = 126;BA.debugLine="btnDiscover.Visible = True";
_btndiscover.setVisible(anywheresoftware.b4a.keywords.Common.True);
 };
 //BA.debugLineNum = 128;BA.debugLine="End Sub";
return "";
}
public static void  _mainform_closed() throws Exception{
ResumableSub_MainForm_Closed rsub = new ResumableSub_MainForm_Closed(null);
rsub.resume(ba, null);
}
public static class ResumableSub_MainForm_Closed extends BA.ResumableSub {
public ResumableSub_MainForm_Closed(b4j.example.main parent) {
this.parent = parent;
}
b4j.example.main parent;
boolean _resultsession = false;

@Override
public void resume(BA ba, Object[] result) throws Exception{

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = -1;
 //BA.debugLineNum = 297;BA.debugLine="kvs.PutEncrypted(\"APKFullFileName\", taAPKFullFile";
parent._vvvvvvv6._vvvvvv1 /*String*/ ("APKFullFileName",(Object)(parent._taapkfullfilename.getText()),parent._v5);
 //BA.debugLineNum = 298;BA.debugLine="kvs.PutEncrypted(\"Host\", tfHost.Text,x)";
parent._vvvvvvv6._vvvvvv1 /*String*/ ("Host",(Object)(parent._tfhost.getText()),parent._v5);
 //BA.debugLineNum = 299;BA.debugLine="Wait For (processBy.KillByPID(PID)) Complete (res";
anywheresoftware.b4a.keywords.Common.WaitFor("complete", ba, this, parent._vvvvvvv4._vvvvvv6 /*anywheresoftware.b4a.keywords.Common.ResumableSubWrapper*/ (parent._vvvvvvv5));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_resultsession = (boolean) result[0];
;
 //BA.debugLineNum = 301;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public static void  _complete(boolean _resultsession) throws Exception{
}

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        com.stevel05.draganddrop.transfermode._process_globals();
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

int value = i / 2 + 540014;
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
 //BA.debugLineNum = 14;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 15;BA.debugLine="Private fx As JFX";
_vvvvvvvv0 = new anywheresoftware.b4j.objects.JFX();
 //BA.debugLineNum = 16;BA.debugLine="Private MainForm As Form";
_vvvvvvv3 = new anywheresoftware.b4j.objects.Form();
 //BA.debugLineNum = 17;BA.debugLine="Private fc As FileChooser";
_vvvvvvvv1 = new anywheresoftware.b4j.objects.FileChooserWrapper();
 //BA.debugLineNum = 20;BA.debugLine="Dim x As String = \"-10020CE15886\"";
_v5 = main.vvv13 (new byte[] {96,32,0,-88,57,39,37,-124,110,124,7,-20,108}, 422619);
 //BA.debugLineNum = 21;BA.debugLine="Private PID As String";
_vvvvvvv5 = "";
 //BA.debugLineNum = 22;BA.debugLine="Private jo As JavaObject";
_vvvvvvv2 = new anywheresoftware.b4j.object.JavaObject();
 //BA.debugLineNum = 23;BA.debugLine="Private processBy As ProcessByPID";
_vvvvvvv4 = new b4j.example.processbypid();
 //BA.debugLineNum = 27;BA.debugLine="Private tfHost As TextField";
_tfhost = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
 //BA.debugLineNum = 28;BA.debugLine="Private lblDiscovering As Label";
_lbldiscovering = new anywheresoftware.b4j.objects.LabelWrapper();
 //BA.debugLineNum = 29;BA.debugLine="Private lvDevices As ListView";
_lvdevices = new anywheresoftware.b4j.objects.ListViewWrapper();
 //BA.debugLineNum = 30;BA.debugLine="Private btnDiscover As Button";
_btndiscover = new anywheresoftware.b4j.objects.ButtonWrapper();
 //BA.debugLineNum = 31;BA.debugLine="Private taAPKFullFileName As TextArea";
_taapkfullfilename = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextAreaWrapper();
 //BA.debugLineNum = 32;BA.debugLine="Private btnInstall As Button";
_btninstall = new anywheresoftware.b4j.objects.ButtonWrapper();
 //BA.debugLineNum = 33;BA.debugLine="Private btnExitApp As Button";
_btnexitapp = new anywheresoftware.b4j.objects.ButtonWrapper();
 //BA.debugLineNum = 34;BA.debugLine="Private btnChooseFileApp As Button";
_btnchoosefileapp = new anywheresoftware.b4j.objects.ButtonWrapper();
 //BA.debugLineNum = 37;BA.debugLine="Private mHost As String";
_vv5 = "";
 //BA.debugLineNum = 38;BA.debugLine="Private kvs As KeyValueStore";
_vvvvvvv6 = new b4j.example.keyvaluestore();
 //BA.debugLineNum = 39;BA.debugLine="Public  csu As CallSubUtils";
_v6 = new b4j.example.callsubutils();
 //BA.debugLineNum = 40;BA.debugLine="Private auto As AutoDiscover";
_vvvvvvvv5 = new b4j.example.autodiscover();
 //BA.debugLineNum = 41;BA.debugLine="Private const DiscoverTimeout As Int = 7000";
_vvvvvvvv6 = (int) (7000);
 //BA.debugLineNum = 42;BA.debugLine="Private NumOfFileSent As Int";
_vvvvvvvv3 = 0;
 //BA.debugLineNum = 44;BA.debugLine="Private DragDrop As DragAndDrop";
_vvvvvvv7 = new com.stevel05.draganddrop.draganddrop();
 //BA.debugLineNum = 45;BA.debugLine="End Sub";
return "";
}
public static String  _sendcompleted(b4j.example.client _clnt) throws Exception{
 //BA.debugLineNum = 287;BA.debugLine="Public Sub SendCompleted(Clnt As Client)";
 //BA.debugLineNum = 288;BA.debugLine="NumOfFileSent = NumOfFileSent + 1";
_vvvvvvvv3 = (int) (_vvvvvvvv3+1);
 //BA.debugLineNum = 289;BA.debugLine="If NumOfFileSent = lvDevices.GetSelectedIndices.S";
if (_vvvvvvvv3==_lvdevices.GetSelectedIndices().getSize()) { 
 //BA.debugLineNum = 290;BA.debugLine="EnableViews(True)";
_vvvvvvvv2(anywheresoftware.b4a.keywords.Common.True);
 };
 //BA.debugLineNum = 292;BA.debugLine="End Sub";
return "";
}
public static String  _stopdiscover() throws Exception{
anywheresoftware.b4a.objects.collections.List _lstindices = null;
String _device = "";
int _i = 0;
 //BA.debugLineNum = 216;BA.debugLine="Private Sub StopDiscover";
 //BA.debugLineNum = 217;BA.debugLine="auto.Stop";
_vvvvvvvv5._v0 /*String*/ ();
 //BA.debugLineNum = 218;BA.debugLine="Dim lstIndices As List";
_lstindices = new anywheresoftware.b4a.objects.collections.List();
 //BA.debugLineNum = 219;BA.debugLine="lstIndices.Initialize";
_lstindices.Initialize();
 //BA.debugLineNum = 220;BA.debugLine="Dim Device As String";
_device = "";
 //BA.debugLineNum = 221;BA.debugLine="For i = 0 To lvDevices.Items.Size - 1";
{
final int step5 = 1;
final int limit5 = (int) (_lvdevices.getItems().getSize()-1);
_i = (int) (0) ;
for (;_i <= limit5 ;_i = _i + step5 ) {
 //BA.debugLineNum = 222;BA.debugLine="Device = lvDevices.Items.Get(i)";
_device = BA.ObjectToString(_lvdevices.getItems().Get(_i));
 //BA.debugLineNum = 223;BA.debugLine="If Not(Device.EndsWith(\"(not started)\")) Then";
if (anywheresoftware.b4a.keywords.Common.Not(_device.endsWith("(not started)"))) { 
 //BA.debugLineNum = 224;BA.debugLine="lstIndices.Add(i)";
_lstindices.Add((Object)(_i));
 };
 }
};
 //BA.debugLineNum = 227;BA.debugLine="lvDevices.SetSelectedIndices(lstIndices)";
_lvdevices.SetSelectedIndices(_lstindices);
 //BA.debugLineNum = 228;BA.debugLine="lblDiscovering.Text = \"\"";
_lbldiscovering.setText("");
 //BA.debugLineNum = 230;BA.debugLine="EnableViews(True)";
_vvvvvvvv2(anywheresoftware.b4a.keywords.Common.True);
 //BA.debugLineNum = 231;BA.debugLine="End Sub";
return "";
}
public static String  _taapkfullfilename_dragdropped(com.stevel05.draganddrop.dragevent _e) throws Exception{
String _uris = "";
String[] _arruris = null;
 //BA.debugLineNum = 140;BA.debugLine="Sub taAPKFullFileName_DragDropped(e As DragEvent)";
 //BA.debugLineNum = 141;BA.debugLine="Dim URIs As String";
_uris = "";
 //BA.debugLineNum = 142;BA.debugLine="URIs = e.GetDataObjectForId(\"text/uri-list\")";
_uris = BA.ObjectToString(_e._getdataobjectforid("text/uri-list"));
 //BA.debugLineNum = 143;BA.debugLine="Dim arrURIs() As String = Regex.Split(\"file:/\", U";
_arruris = anywheresoftware.b4a.keywords.Common.Regex.Split("file:/",_uris);
 //BA.debugLineNum = 144;BA.debugLine="If arrURIs.Length = 0 Then Return";
if (_arruris.length==0) { 
if (true) return "";};
 //BA.debugLineNum = 145;BA.debugLine="If arrURIs(1).EndsWith(\".apk\") Then";
if (_arruris[(int) (1)].endsWith(".apk")) { 
 //BA.debugLineNum = 146;BA.debugLine="taAPKFullFileName.Text = arrURIs(1)";
_taapkfullfilename.setText(_arruris[(int) (1)]);
 };
 //BA.debugLineNum = 148;BA.debugLine="End Sub";
return "";
}
public static String  _taapkfullfilename_dragover(com.stevel05.draganddrop.dragevent _e) throws Exception{
 //BA.debugLineNum = 134;BA.debugLine="Sub taAPKFullFileName_DragOver(e As DragEvent)";
 //BA.debugLineNum = 135;BA.debugLine="If e.GetDragboard.GetUrl.Length > 0 Then";
if (_e._getdragboard()._geturl().length()>0) { 
 //BA.debugLineNum = 136;BA.debugLine="e.AcceptTransferModes(TransferMode.COPY)";
_e._accepttransfermodes((Object[])(_vv6._copy));
 };
 //BA.debugLineNum = 138;BA.debugLine="End Sub";
return "";
}
public static String  _taapkfullfilename_textchanged(String _old,String _new) throws Exception{
 //BA.debugLineNum = 130;BA.debugLine="Sub taAPKFullFileName_TextChanged (Old As String,";
 //BA.debugLineNum = 131;BA.debugLine="EnablingInstallation";
_vvvvvvvv7();
 //BA.debugLineNum = 132;BA.debugLine="End Sub";
return "";
}
}
