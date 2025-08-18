package b4j.example;


import anywheresoftware.b4a.BA;

public class b4xpassword extends Object{
public static b4xpassword mostCurrent = new b4xpassword();

public static BA ba;
static {
		ba = new  anywheresoftware.b4j.objects.FxBA("b4j.example", "b4j.example.b4xpassword", null);
		ba.loadHtSubs(b4xpassword.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "b4j.example.b4xpassword", ba);
		}
	}
    public static Class<?> getObject() {
		return b4xpassword.class;
	}

 public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static int _randy = 0;
public static int _randchar1 = 0;
public static int _randchar2 = 0;
public static int _randchar3 = 0;
public static int _randchar4 = 0;
public static int _randchar5 = 0;
public static String[] _passstr = null;
public static String _mypass = "";
public static b4j.example.main _main = null;
public static String  _process_globals() throws Exception{
 //BA.debugLineNum = 12;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 13;BA.debugLine="Private fx As JFX";
_fx = new anywheresoftware.b4j.objects.JFX();
 //BA.debugLineNum = 15;BA.debugLine="Private Randy As Int";
_randy = 0;
 //BA.debugLineNum = 16;BA.debugLine="Private RandChar1, RandChar2 , RandChar3, RandCha";
_randchar1 = 0;
_randchar2 = 0;
_randchar3 = 0;
_randchar4 = 0;
_randchar5 = 0;
 //BA.debugLineNum = 17;BA.debugLine="Private PassStr(5000) As String";
_passstr = new String[(int) (5000)];
java.util.Arrays.fill(_passstr,"");
 //BA.debugLineNum = 18;BA.debugLine="Private MyPass As String";
_mypass = "";
 //BA.debugLineNum = 20;BA.debugLine="End Sub";
return "";
}
public static String  _randomize_password(int _passmin,int _passmax) throws Exception{
int _passlgt = 0;
int _i = 0;
 //BA.debugLineNum = 26;BA.debugLine="Public Sub Randomize_Password(PassMin As Int, Pass";
 //BA.debugLineNum = 29;BA.debugLine="MyPass = \"\"";
_mypass = "";
 //BA.debugLineNum = 31;BA.debugLine="Dim Randy As Int";
_randy = 0;
 //BA.debugLineNum = 32;BA.debugLine="Dim PassLgt As Int = Rnd(PassMin, PassMax + 1)";
_passlgt = anywheresoftware.b4a.keywords.Common.Rnd(_passmin,(int) (_passmax+1));
 //BA.debugLineNum = 35;BA.debugLine="For i = 1 To PassLgt";
{
final int step4 = 1;
final int limit4 = _passlgt;
_i = (int) (1) ;
for (;_i <= limit4 ;_i = _i + step4 ) {
 //BA.debugLineNum = 37;BA.debugLine="Randy = Rnd(1, 6)";
_randy = anywheresoftware.b4a.keywords.Common.Rnd((int) (1),(int) (6));
 //BA.debugLineNum = 39;BA.debugLine="If Randy = 1 Then RandChar1 = Rnd(49, 58)";
if (_randy==1) { 
_randchar1 = anywheresoftware.b4a.keywords.Common.Rnd((int) (49),(int) (58));};
 //BA.debugLineNum = 40;BA.debugLine="If Randy = 2 Then RandChar2 = Rnd(69, 91)";
if (_randy==2) { 
_randchar2 = anywheresoftware.b4a.keywords.Common.Rnd((int) (69),(int) (91));};
 //BA.debugLineNum = 41;BA.debugLine="If Randy = 3 Then RandChar3 = Rnd(97, 123)";
if (_randy==3) { 
_randchar3 = anywheresoftware.b4a.keywords.Common.Rnd((int) (97),(int) (123));};
 //BA.debugLineNum = 42;BA.debugLine="If Randy = 4 Then RandChar4 = 45 ' -";
if (_randy==4) { 
_randchar4 = (int) (45);};
 //BA.debugLineNum = 43;BA.debugLine="If Randy = 5 Then RandChar5 = 33 ' !";
if (_randy==5) { 
_randchar5 = (int) (33);};
 //BA.debugLineNum = 45;BA.debugLine="If Randy = 1 Then PassStr(i) = Chr(RandChar1)";
if (_randy==1) { 
_passstr[_i] = BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr(_randchar1));};
 //BA.debugLineNum = 46;BA.debugLine="If Randy = 2 Then PassStr(i) = Chr(RandChar2)";
if (_randy==2) { 
_passstr[_i] = BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr(_randchar2));};
 //BA.debugLineNum = 47;BA.debugLine="If Randy = 3 Then PassStr(i) = Chr(RandChar3)";
if (_randy==3) { 
_passstr[_i] = BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr(_randchar3));};
 //BA.debugLineNum = 48;BA.debugLine="If Randy = 4 Then PassStr(i) = Chr(RandChar4)";
if (_randy==4) { 
_passstr[_i] = BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr(_randchar4));};
 //BA.debugLineNum = 49;BA.debugLine="If Randy = 5 Then PassStr(i) = Chr(RandChar5)";
if (_randy==5) { 
_passstr[_i] = BA.ObjectToString(anywheresoftware.b4a.keywords.Common.Chr(_randchar5));};
 //BA.debugLineNum = 52;BA.debugLine="MyPass = MyPass & PassStr(i)";
_mypass = _mypass+_passstr[_i];
 }
};
 //BA.debugLineNum = 57;BA.debugLine="Return MyPass";
if (true) return _mypass;
 //BA.debugLineNum = 59;BA.debugLine="End Sub";
return "";
}
}
