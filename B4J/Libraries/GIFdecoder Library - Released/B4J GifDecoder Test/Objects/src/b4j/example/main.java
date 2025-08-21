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
            frm.initWithStage(ba, stage, 600, 400);
            ba.raiseEvent(null, "appstart", frm, (String[])getParameters().getRaw().toArray(new String[0]));
        } catch (Throwable t) {
            BA.printException(t, true);
            System.exit(1);
        }
    }
public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static anywheresoftware.b4j.objects.Form _mainform = null;
public static anywheresoftware.b4j.max123.gifdecoder.GifDecoder _gif = null;
public static anywheresoftware.b4j.objects.ImageViewWrapper _img1 = null;
public static void  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
ResumableSub_AppStart rsub = new ResumableSub_AppStart(null,_form1,_args);
rsub.resume(ba, null);
}
public static class ResumableSub_AppStart extends BA.ResumableSub {
public ResumableSub_AppStart(b4j.example.main parent,anywheresoftware.b4j.objects.Form _form1,String[] _args) {
this.parent = parent;
this._form1 = _form1;
this._args = _args;
}
b4j.example.main parent;
anywheresoftware.b4j.objects.Form _form1;
String[] _args;
int _i = 0;
int _d = 0;

@Override
public void resume(BA ba, Object[] result) throws Exception{

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
 //BA.debugLineNum = 15;BA.debugLine="MainForm = Form1";
parent._mainform = _form1;
 //BA.debugLineNum = 16;BA.debugLine="MainForm.Show";
parent._mainform.Show();
 //BA.debugLineNum = 17;BA.debugLine="MainForm.BackColor = fx.Colors.LightGray";
parent._mainform.setBackColor(parent._fx.Colors.LightGray);
 //BA.debugLineNum = 18;BA.debugLine="MainForm.Title = \"B4J GIFdecoder Test\"";
parent._mainform.setTitle("B4J GIFdecoder Test");
 //BA.debugLineNum = 21;BA.debugLine="gif.Load(File.DirAssets,\"stepper.gif\")";
parent._gif.Load(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"stepper.gif");
 //BA.debugLineNum = 24;BA.debugLine="Log (\"Number of Frames: \" & gif.NumberOfFrames)";
anywheresoftware.b4a.keywords.Common.Log("Number of Frames: "+BA.NumberToString(parent._gif.getNumberOfFrames()));
 //BA.debugLineNum = 25;BA.debugLine="Log (\"Width: \" & gif.Width)";
anywheresoftware.b4a.keywords.Common.Log("Width: "+BA.NumberToString(parent._gif.getWidth()));
 //BA.debugLineNum = 26;BA.debugLine="Log (\"Height: \" & gif.Height)";
anywheresoftware.b4a.keywords.Common.Log("Height: "+BA.NumberToString(parent._gif.getHeight()));
 //BA.debugLineNum = 27;BA.debugLine="Log (\"LoopCount: \" & gif.LoopCount)";
anywheresoftware.b4a.keywords.Common.Log("LoopCount: "+BA.NumberToString(parent._gif.getLoopCount()));
 //BA.debugLineNum = 29;BA.debugLine="img1.Initialize(\"img1\")";
parent._img1.Initialize(ba,"img1");
 //BA.debugLineNum = 30;BA.debugLine="MainForm.RootPane.AddNode(img1, 50, 50, gif.Width";
parent._mainform.getRootPane().AddNode((javafx.scene.Node)(parent._img1.getObject()),50,50,parent._gif.getWidth(),parent._gif.getHeight());
 //BA.debugLineNum = 32;BA.debugLine="Dim I As Int = 0";
_i = (int) (0);
 //BA.debugLineNum = 33;BA.debugLine="Do Until False";
if (true) break;

case 1:
//do until
this.state = 10;
while (!(anywheresoftware.b4a.keywords.Common.False)) {
this.state = 3;
if (true) break;
}
if (true) break;

case 3:
//C
this.state = 4;
 //BA.debugLineNum = 34;BA.debugLine="If I = gif.NumberOfFrames Then I = 0";
if (true) break;

case 4:
//if
this.state = 9;
if (_i==parent._gif.getNumberOfFrames()) { 
this.state = 6;
;}if (true) break;

case 6:
//C
this.state = 9;
_i = (int) (0);
if (true) break;

case 9:
//C
this.state = 1;
;
 //BA.debugLineNum = 35;BA.debugLine="img1.SetImage(gif.FrameImage(I))";
parent._img1.SetImage(parent._gif.FrameImage(_i));
 //BA.debugLineNum = 37;BA.debugLine="Dim D As Int = gif.FrameDelay(I)";
_d = parent._gif.FrameDelay(_i);
 //BA.debugLineNum = 39;BA.debugLine="Sleep(D)";
anywheresoftware.b4a.keywords.Common.Sleep(ba,this,_d);
this.state = 11;
return;
case 11:
//C
this.state = 1;
;
 //BA.debugLineNum = 40;BA.debugLine="I=I+1";
_i = (int) (_i+1);
 if (true) break;

case 10:
//C
this.state = -1;
;
 //BA.debugLineNum = 43;BA.debugLine="gif.DisposeAllFrames";
parent._gif.DisposeAllFrames();
 //BA.debugLineNum = 44;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
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
 //BA.debugLineNum = 6;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 7;BA.debugLine="Private fx As JFX";
_fx = new anywheresoftware.b4j.objects.JFX();
 //BA.debugLineNum = 8;BA.debugLine="Private MainForm As Form";
_mainform = new anywheresoftware.b4j.objects.Form();
 //BA.debugLineNum = 10;BA.debugLine="Dim gif As GifDecoder";
_gif = new anywheresoftware.b4j.max123.gifdecoder.GifDecoder();
 //BA.debugLineNum = 11;BA.debugLine="Private img1 As ImageView";
_img1 = new anywheresoftware.b4j.objects.ImageViewWrapper();
 //BA.debugLineNum = 12;BA.debugLine="End Sub";
return "";
}
}
