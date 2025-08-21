package b4j.example;


import anywheresoftware.b4a.BA;

public class metro extends Object{
public static metro mostCurrent = new metro();

public static BA ba;
static {
		ba = new  anywheresoftware.b4j.objects.FxBA("b4j.example", "b4j.example.metro", null);
		ba.loadHtSubs(metro.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "b4j.example.metro", ba);
		}
	}
    public static Class<?> getObject() {
		return metro.class;
	}

 public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static b4j.example.main _main = null;
public static String  _applytheme(anywheresoftware.b4j.objects.Form _form,String _theme) throws Exception{
 //BA.debugLineNum = 6;BA.debugLine="Public Sub ApplyTheme(form As Form,Theme As String";
 //BA.debugLineNum = 7;BA.debugLine="form.Stylesheets.Add(File.GetUri(File.DirAssets,\"";
_form.getStylesheets().Add((Object)(anywheresoftware.b4a.keywords.Common.File.GetUri(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"base.css")));
 //BA.debugLineNum = 8;BA.debugLine="form.Stylesheets.Add(File.GetUri(File.DirAssets,\"";
_form.getStylesheets().Add((Object)(anywheresoftware.b4a.keywords.Common.File.GetUri(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"base_extras.css")));
 //BA.debugLineNum = 9;BA.debugLine="form.Stylesheets.Add(File.GetUri(File.DirAssets,\"";
_form.getStylesheets().Add((Object)(anywheresoftware.b4a.keywords.Common.File.GetUri(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"base_other_libraries.css")));
 //BA.debugLineNum = 10;BA.debugLine="form.Stylesheets.Add(File.GetUri(File.DirAssets,\"";
_form.getStylesheets().Add((Object)(anywheresoftware.b4a.keywords.Common.File.GetUri(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"panes.css")));
 //BA.debugLineNum = 11;BA.debugLine="If Theme = \"Dark\" Then";
if ((_theme).equals("Dark")) { 
 //BA.debugLineNum = 12;BA.debugLine="form.Stylesheets.Add(File.GetUri(File.DirAssets,";
_form.getStylesheets().Add((Object)(anywheresoftware.b4a.keywords.Common.File.GetUri(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"dark_theme.css")));
 }else {
 //BA.debugLineNum = 14;BA.debugLine="form.Stylesheets.Add(File.GetUri(File.DirAssets,";
_form.getStylesheets().Add((Object)(anywheresoftware.b4a.keywords.Common.File.GetUri(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"light_theme.css")));
 };
 //BA.debugLineNum = 16;BA.debugLine="End Sub";
return "";
}
public static String  _process_globals() throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Private fx As JFX";
_fx = new anywheresoftware.b4j.objects.JFX();
 //BA.debugLineNum = 4;BA.debugLine="End Sub";
return "";
}
}
