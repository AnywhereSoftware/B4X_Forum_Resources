package b4j.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.debug.*;

public class bitmapcreator extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.ShellBA("b4j.example", "b4j.example.bitmapcreator", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.bitmapcreator.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 
    public void  innerInitializeHelper(anywheresoftware.b4a.BA _ba) throws Exception{
        innerInitialize(_ba);
    }
    public Object callSub(String sub, Object sender, Object[] args) throws Exception {
        return BA.SubDelegator.SubNotFound;
    }
public static class _premultipliedcolor{
public boolean IsInitialized;
public int a;
public int r;
public int g;
public int b;
public void Initialize() {
IsInitialized = true;
a = 0;
r = 0;
g = 0;
b = 0;
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public static class _argbcolor{
public boolean IsInitialized;
public int a;
public int r;
public int g;
public int b;
public void Initialize() {
IsInitialized = true;
a = 0;
r = 0;
g = 0;
b = 0;
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public anywheresoftware.b4a.keywords.Common __c = null;
public byte[] _mbuffer = null;
public int _mwidth = 0;
public int _mheight = 0;
public int _ai = 0;
public int _ri = 0;
public int _gi = 0;
public int _bi = 0;
public b4j.example.bitmapcreator._argbcolor _tempargb = null;
public b4j.example.bitmapcreator._premultipliedcolor _temppm = null;
public b4j.example.bitmapcreator._premultipliedcolor _temppm2 = null;
public anywheresoftware.b4j.object.JavaObject _writeableimage = null;
public anywheresoftware.b4j.objects.B4XCanvas.B4XRect _targetrect = null;
public int _unsignedff = 0;
public b4j.example.main _main = null;
public String  _initialize(b4j.example.bitmapcreator __ref,anywheresoftware.b4a.BA _ba,int _width,int _height) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "initialize"))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_width,_height}));}
byte _b = (byte)0;
RDebugUtils.currentLine=3473408;
 //BA.debugLineNum = 3473408;BA.debugLine="Public Sub Initialize (Width As Int, Height As Int";
RDebugUtils.currentLine=3473409;
 //BA.debugLineNum = 3473409;BA.debugLine="Dim b As Byte = 0xff";
_b = (byte) (0xff);
RDebugUtils.currentLine=3473410;
 //BA.debugLineNum = 3473410;BA.debugLine="UnsignedFF = b";
__ref._unsignedff = (int) (_b);
RDebugUtils.currentLine=3473411;
 //BA.debugLineNum = 3473411;BA.debugLine="mWidth = Width";
__ref._mwidth = _width;
RDebugUtils.currentLine=3473412;
 //BA.debugLineNum = 3473412;BA.debugLine="mHeight = Height";
__ref._mheight = _height;
RDebugUtils.currentLine=3473413;
 //BA.debugLineNum = 3473413;BA.debugLine="Dim mBuffer(mWidth * mHeight * 4) As Byte";
_mbuffer = new byte[(int) (__ref._mwidth*__ref._mheight*4)];
;
RDebugUtils.currentLine=3473420;
 //BA.debugLineNum = 3473420;BA.debugLine="ai = 3";
__ref._ai = (int) (3);
RDebugUtils.currentLine=3473421;
 //BA.debugLineNum = 3473421;BA.debugLine="ri = 2";
__ref._ri = (int) (2);
RDebugUtils.currentLine=3473422;
 //BA.debugLineNum = 3473422;BA.debugLine="gi = 1";
__ref._gi = (int) (1);
RDebugUtils.currentLine=3473423;
 //BA.debugLineNum = 3473423;BA.debugLine="bi = 0";
__ref._bi = (int) (0);
RDebugUtils.currentLine=3473426;
 //BA.debugLineNum = 3473426;BA.debugLine="TargetRect.Initialize(0, 0, mWidth, mHeight)";
__ref._targetrect.Initialize((float) (0),(float) (0),(float) (__ref._mwidth),(float) (__ref._mheight));
RDebugUtils.currentLine=3473427;
 //BA.debugLineNum = 3473427;BA.debugLine="End Sub";
return "";
}
public String  _copypixelsfrombitmap(b4j.example.bitmapcreator __ref,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _sourcebitmap) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "copypixelsfrombitmap"))
	 {return ((String) Debug.delegate(ba, "copypixelsfrombitmap", new Object[] {_sourcebitmap}));}
anywheresoftware.b4j.object.JavaObject _jo = null;
anywheresoftware.b4j.object.JavaObject _reader = null;
anywheresoftware.b4j.object.JavaObject _pixelformat = null;
RDebugUtils.currentLine=3604480;
 //BA.debugLineNum = 3604480;BA.debugLine="Public Sub CopyPixelsFromBitmap (SourceBitmap As B";
RDebugUtils.currentLine=3604481;
 //BA.debugLineNum = 3604481;BA.debugLine="If SourceBitmap.Width <> mWidth Or SourceBitmap.H";
if (_sourcebitmap.getWidth()!=__ref._mwidth || _sourcebitmap.getHeight()!=__ref._mheight) { 
RDebugUtils.currentLine=3604482;
 //BA.debugLineNum = 3604482;BA.debugLine="SourceBitmap = SourceBitmap.Resize(mWidth, mHeig";
_sourcebitmap = _sourcebitmap.Resize(__ref._mwidth,__ref._mheight,__c.False);
 };
RDebugUtils.currentLine=3604495;
 //BA.debugLineNum = 3604495;BA.debugLine="Dim jo As JavaObject = SourceBitmap";
_jo = new anywheresoftware.b4j.object.JavaObject();
_jo.setObject((java.lang.Object)(_sourcebitmap.getObject()));
RDebugUtils.currentLine=3604496;
 //BA.debugLineNum = 3604496;BA.debugLine="Dim reader As JavaObject = jo.RunMethod(\"getPixel";
_reader = new anywheresoftware.b4j.object.JavaObject();
_reader.setObject((java.lang.Object)(_jo.RunMethod("getPixelReader",(Object[])(__c.Null))));
RDebugUtils.currentLine=3604497;
 //BA.debugLineNum = 3604497;BA.debugLine="Dim PixelFormat As JavaObject";
_pixelformat = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=3604498;
 //BA.debugLineNum = 3604498;BA.debugLine="PixelFormat.InitializeStatic(\"javafx.scene.image.";
_pixelformat.InitializeStatic("javafx.scene.image.PixelFormat");
RDebugUtils.currentLine=3604499;
 //BA.debugLineNum = 3604499;BA.debugLine="reader.RunMethod(\"getPixels\", Array(0, 0, mWidth,";
_reader.RunMethod("getPixels",new Object[]{(Object)(0),(Object)(0),(Object)(__ref._mwidth),(Object)(__ref._mheight),_pixelformat.RunMethod("getByteBgraPreInstance",(Object[])(__c.Null)),(Object)(__ref._mbuffer),(Object)(0),(Object)(__ref._mwidth*4)});
RDebugUtils.currentLine=3604505;
 //BA.debugLineNum = 3604505;BA.debugLine="End Sub";
return "";
}
public b4j.example.bitmapcreator._argbcolor  _colortoargb(b4j.example.bitmapcreator __ref,int _clr,b4j.example.bitmapcreator._argbcolor _result) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "colortoargb"))
	 {return ((b4j.example.bitmapcreator._argbcolor) Debug.delegate(ba, "colortoargb", new Object[] {_clr,_result}));}
RDebugUtils.currentLine=3735552;
 //BA.debugLineNum = 3735552;BA.debugLine="Public Sub ColorToARGB (Clr As Int, Result As ARGB";
RDebugUtils.currentLine=3735553;
 //BA.debugLineNum = 3735553;BA.debugLine="Result.a = Bit.And(0xff, Bit.ShiftRight(Clr, 24))";
_result.a = __c.Bit.And((int) (0xff),__c.Bit.ShiftRight(_clr,(int) (24)));
RDebugUtils.currentLine=3735554;
 //BA.debugLineNum = 3735554;BA.debugLine="Result.r = Bit.And(0xff, Bit.ShiftRight(Clr, 16))";
_result.r = __c.Bit.And((int) (0xff),__c.Bit.ShiftRight(_clr,(int) (16)));
RDebugUtils.currentLine=3735555;
 //BA.debugLineNum = 3735555;BA.debugLine="Result.g =  Bit.And(0xff, Bit.ShiftRight(Clr, 8))";
_result.g = __c.Bit.And((int) (0xff),__c.Bit.ShiftRight(_clr,(int) (8)));
RDebugUtils.currentLine=3735556;
 //BA.debugLineNum = 3735556;BA.debugLine="Result.b =  Bit.And(0xff, Clr)";
_result.b = __c.Bit.And((int) (0xff),_clr);
RDebugUtils.currentLine=3735557;
 //BA.debugLineNum = 3735557;BA.debugLine="Return Result";
if (true) return _result;
RDebugUtils.currentLine=3735558;
 //BA.debugLineNum = 3735558;BA.debugLine="End Sub";
return null;
}
public b4j.example.bitmapcreator._argbcolor  _getargb(b4j.example.bitmapcreator __ref,int _x,int _y,b4j.example.bitmapcreator._argbcolor _result) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "getargb"))
	 {return ((b4j.example.bitmapcreator._argbcolor) Debug.delegate(ba, "getargb", new Object[] {_x,_y,_result}));}
int _cp = 0;
float _af = 0f;
RDebugUtils.currentLine=4194304;
 //BA.debugLineNum = 4194304;BA.debugLine="Public Sub GetARGB (x As Int, y As Int, Result As";
RDebugUtils.currentLine=4194305;
 //BA.debugLineNum = 4194305;BA.debugLine="Dim cp As Int = x * 4 + y * mWidth * 4";
_cp = (int) (_x*4+_y*__ref._mwidth*4);
RDebugUtils.currentLine=4194313;
 //BA.debugLineNum = 4194313;BA.debugLine="Result.a = Bit.And(0xff, mBuffer(cp + ai))";
_result.a = __c.Bit.And((int) (0xff),(int) (__ref._mbuffer[(int) (_cp+__ref._ai)]));
RDebugUtils.currentLine=4194314;
 //BA.debugLineNum = 4194314;BA.debugLine="Dim af As Float = Result.a / 255";
_af = (float) (_result.a/(double)255);
RDebugUtils.currentLine=4194315;
 //BA.debugLineNum = 4194315;BA.debugLine="Result.r = Bit.And(0xff, mBuffer(cp + ri)) / af";
_result.r = (int) (__c.Bit.And((int) (0xff),(int) (__ref._mbuffer[(int) (_cp+__ref._ri)]))/(double)_af);
RDebugUtils.currentLine=4194316;
 //BA.debugLineNum = 4194316;BA.debugLine="Result.g = Bit.And(0xff, mBuffer(cp + gi)) / af";
_result.g = (int) (__c.Bit.And((int) (0xff),(int) (__ref._mbuffer[(int) (_cp+__ref._gi)]))/(double)_af);
RDebugUtils.currentLine=4194317;
 //BA.debugLineNum = 4194317;BA.debugLine="Result.b = Bit.And(0xff, mBuffer(cp + bi)) / af";
_result.b = (int) (__c.Bit.And((int) (0xff),(int) (__ref._mbuffer[(int) (_cp+__ref._bi)]))/(double)_af);
RDebugUtils.currentLine=4194320;
 //BA.debugLineNum = 4194320;BA.debugLine="Return Result";
if (true) return _result;
RDebugUtils.currentLine=4194321;
 //BA.debugLineNum = 4194321;BA.debugLine="End Sub";
return null;
}
public String  _setargb(b4j.example.bitmapcreator __ref,int _x,int _y,b4j.example.bitmapcreator._argbcolor _argb) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "setargb"))
	 {return ((String) Debug.delegate(ba, "setargb", new Object[] {_x,_y,_argb}));}
RDebugUtils.currentLine=3932160;
 //BA.debugLineNum = 3932160;BA.debugLine="Public Sub SetARGB(x As Int, y As Int, ARGB As ARG";
RDebugUtils.currentLine=3932161;
 //BA.debugLineNum = 3932161;BA.debugLine="SetPremultipliedColor(x, y, ARGBToPremultipliedCo";
__ref._setpremultipliedcolor(null,_x,_y,__ref._argbtopremultipliedcolor(null,_argb,__ref._temppm));
RDebugUtils.currentLine=3932162;
 //BA.debugLineNum = 3932162;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper  _getbitmap(b4j.example.bitmapcreator __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "getbitmap"))
	 {return ((anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) Debug.delegate(ba, "getbitmap", null));}
anywheresoftware.b4j.object.JavaObject _writer = null;
anywheresoftware.b4j.object.JavaObject _pixelformat = null;
RDebugUtils.currentLine=4325376;
 //BA.debugLineNum = 4325376;BA.debugLine="Public Sub getBitmap As B4XBitmap";
RDebugUtils.currentLine=4325388;
 //BA.debugLineNum = 4325388;BA.debugLine="If WriteableImage.IsInitialized = False Then";
if (__ref._writeableimage.IsInitialized()==__c.False) { 
RDebugUtils.currentLine=4325389;
 //BA.debugLineNum = 4325389;BA.debugLine="WriteableImage.InitializeNewInstance(\"javafx.sce";
__ref._writeableimage.InitializeNewInstance("javafx.scene.image.WritableImage",new Object[]{(Object)(__ref._mwidth),(Object)(__ref._mheight)});
 };
RDebugUtils.currentLine=4325391;
 //BA.debugLineNum = 4325391;BA.debugLine="Dim writer As JavaObject = WriteableImage.RunMeth";
_writer = new anywheresoftware.b4j.object.JavaObject();
_writer.setObject((java.lang.Object)(__ref._writeableimage.RunMethod("getPixelWriter",(Object[])(__c.Null))));
RDebugUtils.currentLine=4325392;
 //BA.debugLineNum = 4325392;BA.debugLine="Dim PixelFormat As JavaObject";
_pixelformat = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=4325393;
 //BA.debugLineNum = 4325393;BA.debugLine="PixelFormat.InitializeStatic(\"javafx.scene.image.";
_pixelformat.InitializeStatic("javafx.scene.image.PixelFormat");
RDebugUtils.currentLine=4325394;
 //BA.debugLineNum = 4325394;BA.debugLine="writer.RunMethod(\"setPixels\", Array(0, 0, mWidth,";
_writer.RunMethod("setPixels",new Object[]{(Object)(0),(Object)(0),(Object)(__ref._mwidth),(Object)(__ref._mheight),_pixelformat.RunMethod("getByteBgraPreInstance",(Object[])(__c.Null)),(Object)(__ref._mbuffer),(Object)(0),(Object)(__ref._mwidth*4)});
RDebugUtils.currentLine=4325396;
 //BA.debugLineNum = 4325396;BA.debugLine="Return WriteableImage";
if (true) return (anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._writeableimage.getObject()));
RDebugUtils.currentLine=4325402;
 //BA.debugLineNum = 4325402;BA.debugLine="End Sub";
return null;
}
public b4j.example.bitmapcreator._premultipliedcolor  _argbtopremultipliedcolor(b4j.example.bitmapcreator __ref,b4j.example.bitmapcreator._argbcolor _argb,b4j.example.bitmapcreator._premultipliedcolor _pm) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "argbtopremultipliedcolor"))
	 {return ((b4j.example.bitmapcreator._premultipliedcolor) Debug.delegate(ba, "argbtopremultipliedcolor", new Object[] {_argb,_pm}));}
float _a = 0f;
RDebugUtils.currentLine=3801088;
 //BA.debugLineNum = 3801088;BA.debugLine="Public Sub ARGBToPremultipliedColor (ARGB As ARGBC";
RDebugUtils.currentLine=3801089;
 //BA.debugLineNum = 3801089;BA.debugLine="Dim a As Float = ARGB.a / 255";
_a = (float) (_argb.a/(double)255);
RDebugUtils.currentLine=3801090;
 //BA.debugLineNum = 3801090;BA.debugLine="PM.a = ARGB.a";
_pm.a = _argb.a;
RDebugUtils.currentLine=3801091;
 //BA.debugLineNum = 3801091;BA.debugLine="PM.r = ARGB.r * a";
_pm.r = (int) (_argb.r*_a);
RDebugUtils.currentLine=3801092;
 //BA.debugLineNum = 3801092;BA.debugLine="PM.g = ARGB.g * a";
_pm.g = (int) (_argb.g*_a);
RDebugUtils.currentLine=3801093;
 //BA.debugLineNum = 3801093;BA.debugLine="PM.b = ARGB.b * a";
_pm.b = (int) (_argb.b*_a);
RDebugUtils.currentLine=3801094;
 //BA.debugLineNum = 3801094;BA.debugLine="Return PM";
if (true) return _pm;
RDebugUtils.currentLine=3801095;
 //BA.debugLineNum = 3801095;BA.debugLine="End Sub";
return null;
}
public String  _blendpixel(b4j.example.bitmapcreator __ref,b4j.example.bitmapcreator _source,int _srcx,int _srcy,int _targetx,int _targety) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "blendpixel"))
	 {return ((String) Debug.delegate(ba, "blendpixel", new Object[] {_source,_srcx,_srcy,_targetx,_targety}));}
b4j.example.bitmapcreator._premultipliedcolor _srcpm = null;
float _srcaf = 0f;
RDebugUtils.currentLine=4653056;
 //BA.debugLineNum = 4653056;BA.debugLine="Public Sub BlendPixel (Source As BitmapCreator, Sr";
RDebugUtils.currentLine=4653057;
 //BA.debugLineNum = 4653057;BA.debugLine="Dim SrcPM As PremultipliedColor = Source.GetPremu";
_srcpm = _source._getpremultipliedcolor(null,_srcx,_srcy,__ref._temppm2);
RDebugUtils.currentLine=4653058;
 //BA.debugLineNum = 4653058;BA.debugLine="If SrcPM.a <> UnsignedFF Then";
if (_srcpm.a!=__ref._unsignedff) { 
RDebugUtils.currentLine=4653059;
 //BA.debugLineNum = 4653059;BA.debugLine="If SrcPM.a = 0 Then Return";
if (_srcpm.a==0) { 
if (true) return "";};
RDebugUtils.currentLine=4653060;
 //BA.debugLineNum = 4653060;BA.debugLine="SrcPM.a = Bit.And(0xff, SrcPM.a)";
_srcpm.a = __c.Bit.And((int) (0xff),_srcpm.a);
RDebugUtils.currentLine=4653061;
 //BA.debugLineNum = 4653061;BA.debugLine="GetPremultipliedColor(TargetX, TargetY, tempPM)";
__ref._getpremultipliedcolor(null,_targetx,_targety,__ref._temppm);
RDebugUtils.currentLine=4653062;
 //BA.debugLineNum = 4653062;BA.debugLine="Dim SrcAF As Float = 1 - (SrcPM.a / 255)";
_srcaf = (float) (1-(_srcpm.a/(double)255));
RDebugUtils.currentLine=4653063;
 //BA.debugLineNum = 4653063;BA.debugLine="SrcPM.r =  Bit.And(0xff, SrcPM.r) + SrcAF *  Bit";
_srcpm.r = (int) (__c.Bit.And((int) (0xff),_srcpm.r)+_srcaf*__c.Bit.And((int) (0xff),__ref._temppm.r));
RDebugUtils.currentLine=4653064;
 //BA.debugLineNum = 4653064;BA.debugLine="SrcPM.g =  Bit.And(0xff, SrcPM.g) + SrcAF *  Bit";
_srcpm.g = (int) (__c.Bit.And((int) (0xff),_srcpm.g)+_srcaf*__c.Bit.And((int) (0xff),__ref._temppm.g));
RDebugUtils.currentLine=4653065;
 //BA.debugLineNum = 4653065;BA.debugLine="SrcPM.b =  Bit.And(0xff, SrcPM.b) + SrcAF *  Bit";
_srcpm.b = (int) (__c.Bit.And((int) (0xff),_srcpm.b)+_srcaf*__c.Bit.And((int) (0xff),__ref._temppm.b));
RDebugUtils.currentLine=4653066;
 //BA.debugLineNum = 4653066;BA.debugLine="SrcPM.a =  Bit.And(0xff, SrcPM.a) + SrcAF *  Bit";
_srcpm.a = (int) (__c.Bit.And((int) (0xff),_srcpm.a)+_srcaf*__c.Bit.And((int) (0xff),__ref._temppm.a));
 };
RDebugUtils.currentLine=4653068;
 //BA.debugLineNum = 4653068;BA.debugLine="SetPremultipliedColor(TargetX, TargetY, SrcPM)";
__ref._setpremultipliedcolor(null,_targetx,_targety,_srcpm);
RDebugUtils.currentLine=4653069;
 //BA.debugLineNum = 4653069;BA.debugLine="End Sub";
return "";
}
public b4j.example.bitmapcreator._premultipliedcolor  _getpremultipliedcolor(b4j.example.bitmapcreator __ref,int _x,int _y,b4j.example.bitmapcreator._premultipliedcolor _result) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "getpremultipliedcolor"))
	 {return ((b4j.example.bitmapcreator._premultipliedcolor) Debug.delegate(ba, "getpremultipliedcolor", new Object[] {_x,_y,_result}));}
int _cp = 0;
RDebugUtils.currentLine=4063232;
 //BA.debugLineNum = 4063232;BA.debugLine="Private Sub GetPremultipliedColor (x As Int, y As";
RDebugUtils.currentLine=4063233;
 //BA.debugLineNum = 4063233;BA.debugLine="Dim cp As Int = x * 4 + y * mWidth * 4";
_cp = (int) (_x*4+_y*__ref._mwidth*4);
RDebugUtils.currentLine=4063240;
 //BA.debugLineNum = 4063240;BA.debugLine="Result.r = mBuffer(cp + ri)";
_result.r = (int) (__ref._mbuffer[(int) (_cp+__ref._ri)]);
RDebugUtils.currentLine=4063241;
 //BA.debugLineNum = 4063241;BA.debugLine="Result.g = mBuffer(cp + gi)";
_result.g = (int) (__ref._mbuffer[(int) (_cp+__ref._gi)]);
RDebugUtils.currentLine=4063242;
 //BA.debugLineNum = 4063242;BA.debugLine="Result.b = mBuffer(cp + bi)";
_result.b = (int) (__ref._mbuffer[(int) (_cp+__ref._bi)]);
RDebugUtils.currentLine=4063243;
 //BA.debugLineNum = 4063243;BA.debugLine="Result.a = mBuffer(cp + ai)";
_result.a = (int) (__ref._mbuffer[(int) (_cp+__ref._ai)]);
RDebugUtils.currentLine=4063245;
 //BA.debugLineNum = 4063245;BA.debugLine="Return Result";
if (true) return _result;
RDebugUtils.currentLine=4063246;
 //BA.debugLineNum = 4063246;BA.debugLine="End Sub";
return null;
}
public String  _setpremultipliedcolor(b4j.example.bitmapcreator __ref,int _x,int _y,b4j.example.bitmapcreator._premultipliedcolor _premultiplied) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "setpremultipliedcolor"))
	 {return ((String) Debug.delegate(ba, "setpremultipliedcolor", new Object[] {_x,_y,_premultiplied}));}
int _cp = 0;
RDebugUtils.currentLine=3997696;
 //BA.debugLineNum = 3997696;BA.debugLine="Private Sub SetPremultipliedColor (x As Int, y As";
RDebugUtils.currentLine=3997697;
 //BA.debugLineNum = 3997697;BA.debugLine="Dim cp As Int = x * 4 + y * mWidth * 4";
_cp = (int) (_x*4+_y*__ref._mwidth*4);
RDebugUtils.currentLine=3997704;
 //BA.debugLineNum = 3997704;BA.debugLine="mBuffer(cp + ri) = Premultiplied.r";
__ref._mbuffer[(int) (_cp+__ref._ri)] = (byte) (_premultiplied.r);
RDebugUtils.currentLine=3997705;
 //BA.debugLineNum = 3997705;BA.debugLine="mBuffer(cp + gi) = Premultiplied.g";
__ref._mbuffer[(int) (_cp+__ref._gi)] = (byte) (_premultiplied.g);
RDebugUtils.currentLine=3997706;
 //BA.debugLineNum = 3997706;BA.debugLine="mBuffer(cp + bi) = Premultiplied.b";
__ref._mbuffer[(int) (_cp+__ref._bi)] = (byte) (_premultiplied.b);
RDebugUtils.currentLine=3997707;
 //BA.debugLineNum = 3997707;BA.debugLine="mBuffer(cp + ai) = Premultiplied.a";
__ref._mbuffer[(int) (_cp+__ref._ai)] = (byte) (_premultiplied.a);
RDebugUtils.currentLine=3997710;
 //BA.debugLineNum = 3997710;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.example.bitmapcreator __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
RDebugUtils.currentLine=3407872;
 //BA.debugLineNum = 3407872;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=3407873;
 //BA.debugLineNum = 3407873;BA.debugLine="Private mBuffer() As Byte";
_mbuffer = new byte[(int) (0)];
;
RDebugUtils.currentLine=3407874;
 //BA.debugLineNum = 3407874;BA.debugLine="Public mWidth, mHeight As Int";
_mwidth = 0;
_mheight = 0;
RDebugUtils.currentLine=3407875;
 //BA.debugLineNum = 3407875;BA.debugLine="Private ai, ri, gi, bi As Int";
_ai = 0;
_ri = 0;
_gi = 0;
_bi = 0;
RDebugUtils.currentLine=3407876;
 //BA.debugLineNum = 3407876;BA.debugLine="Type PremultipliedColor (a As Int, r As Int, g As";
;
RDebugUtils.currentLine=3407877;
 //BA.debugLineNum = 3407877;BA.debugLine="Type ARGBColor (a As Int, r As Int, g As Int, b A";
;
RDebugUtils.currentLine=3407878;
 //BA.debugLineNum = 3407878;BA.debugLine="Private tempARGB As ARGBColor";
_tempargb = new b4j.example.bitmapcreator._argbcolor();
RDebugUtils.currentLine=3407879;
 //BA.debugLineNum = 3407879;BA.debugLine="Private tempPM, tempPM2 As PremultipliedColor";
_temppm = new b4j.example.bitmapcreator._premultipliedcolor();
_temppm2 = new b4j.example.bitmapcreator._premultipliedcolor();
RDebugUtils.currentLine=3407883;
 //BA.debugLineNum = 3407883;BA.debugLine="Private WriteableImage As JavaObject";
_writeableimage = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=3407885;
 //BA.debugLineNum = 3407885;BA.debugLine="Public TargetRect As B4XRect";
_targetrect = new anywheresoftware.b4j.objects.B4XCanvas.B4XRect();
RDebugUtils.currentLine=3407886;
 //BA.debugLineNum = 3407886;BA.debugLine="Private UnsignedFF As Int";
_unsignedff = 0;
RDebugUtils.currentLine=3407887;
 //BA.debugLineNum = 3407887;BA.debugLine="End Sub";
return "";
}
public String  _copypixel(b4j.example.bitmapcreator __ref,b4j.example.bitmapcreator _source,int _srcx,int _srcy,int _targetx,int _targety) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "copypixel"))
	 {return ((String) Debug.delegate(ba, "copypixel", new Object[] {_source,_srcx,_srcy,_targetx,_targety}));}
int _sourcecp = 0;
int _targetcp = 0;
RDebugUtils.currentLine=4587520;
 //BA.debugLineNum = 4587520;BA.debugLine="Public Sub CopyPixel (Source As BitmapCreator, Src";
RDebugUtils.currentLine=4587521;
 //BA.debugLineNum = 4587521;BA.debugLine="Dim SourceCP As Int = SrcX * 4 + SrcY * Source.mW";
_sourcecp = (int) (_srcx*4+_srcy*_source._mwidth*4);
RDebugUtils.currentLine=4587522;
 //BA.debugLineNum = 4587522;BA.debugLine="Dim TargetCP As Int = TargetX * 4 + TargetY * mWi";
_targetcp = (int) (_targetx*4+_targety*__ref._mwidth*4);
RDebugUtils.currentLine=4587529;
 //BA.debugLineNum = 4587529;BA.debugLine="mBuffer(TargetCP) = Source.mBuffer(SourceCP)";
__ref._mbuffer[_targetcp] = _source._mbuffer[_sourcecp];
RDebugUtils.currentLine=4587530;
 //BA.debugLineNum = 4587530;BA.debugLine="mBuffer(TargetCP + 1) = Source.mBuffer(SourceCP +";
__ref._mbuffer[(int) (_targetcp+1)] = _source._mbuffer[(int) (_sourcecp+1)];
RDebugUtils.currentLine=4587531;
 //BA.debugLineNum = 4587531;BA.debugLine="mBuffer(TargetCP + 2) = Source.mBuffer(SourceCP +";
__ref._mbuffer[(int) (_targetcp+2)] = _source._mbuffer[(int) (_sourcecp+2)];
RDebugUtils.currentLine=4587532;
 //BA.debugLineNum = 4587532;BA.debugLine="mBuffer(TargetCP + 3) = Source.mBuffer(SourceCP +";
__ref._mbuffer[(int) (_targetcp+3)] = _source._mbuffer[(int) (_sourcecp+3)];
RDebugUtils.currentLine=4587534;
 //BA.debugLineNum = 4587534;BA.debugLine="End Sub";
return "";
}
public String  _drawbitmap(b4j.example.bitmapcreator __ref,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _bmp,anywheresoftware.b4j.objects.B4XCanvas.B4XRect _targetrect1,boolean _skipblending) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "drawbitmap"))
	 {return ((String) Debug.delegate(ba, "drawbitmap", new Object[] {_bmp,_targetrect1,_skipblending}));}
b4j.example.bitmapcreator _src = null;
anywheresoftware.b4j.objects.B4XCanvas.B4XRect _srcrect = null;
RDebugUtils.currentLine=4456448;
 //BA.debugLineNum = 4456448;BA.debugLine="Public Sub DrawBitmap (Bmp As B4XBitmap, TargetRec";
RDebugUtils.currentLine=4456449;
 //BA.debugLineNum = 4456449;BA.debugLine="If Bmp.Width <> TargetRect1.Width Or Bmp.Height <";
if (_bmp.getWidth()!=_targetrect1.getWidth() || _bmp.getHeight()!=_targetrect1.getHeight()) { 
RDebugUtils.currentLine=4456450;
 //BA.debugLineNum = 4456450;BA.debugLine="Bmp = Bmp.Resize(TargetRect1.Width, TargetRect1.";
_bmp = _bmp.Resize((int) (_targetrect1.getWidth()),(int) (_targetrect1.getHeight()),__c.False);
 };
RDebugUtils.currentLine=4456452;
 //BA.debugLineNum = 4456452;BA.debugLine="Dim Src As BitmapCreator";
_src = new b4j.example.bitmapcreator();
RDebugUtils.currentLine=4456453;
 //BA.debugLineNum = 4456453;BA.debugLine="Src.Initialize(Bmp.Width, Bmp.Height)";
_src._initialize(null,ba,(int) (_bmp.getWidth()),(int) (_bmp.getHeight()));
RDebugUtils.currentLine=4456454;
 //BA.debugLineNum = 4456454;BA.debugLine="Src.CopyPixelsFromBitmap(Bmp)";
_src._copypixelsfrombitmap(null,_bmp);
RDebugUtils.currentLine=4456455;
 //BA.debugLineNum = 4456455;BA.debugLine="Dim SrcRect As B4XRect";
_srcrect = new anywheresoftware.b4j.objects.B4XCanvas.B4XRect();
RDebugUtils.currentLine=4456456;
 //BA.debugLineNum = 4456456;BA.debugLine="SrcRect.Initialize(0, 0, Src.mWidth, Src.mHeight)";
_srcrect.Initialize((float) (0),(float) (0),(float) (_src._mwidth),(float) (_src._mheight));
RDebugUtils.currentLine=4456457;
 //BA.debugLineNum = 4456457;BA.debugLine="DrawBitmapCreator(Src, SrcRect, TargetRect1.Left,";
__ref._drawbitmapcreator(null,_src,_srcrect,(int) (_targetrect1.getLeft()),(int) (_targetrect1.getTop()),_skipblending);
RDebugUtils.currentLine=4456458;
 //BA.debugLineNum = 4456458;BA.debugLine="End Sub";
return "";
}
public String  _drawbitmapcreator(b4j.example.bitmapcreator __ref,b4j.example.bitmapcreator _source,anywheresoftware.b4j.objects.B4XCanvas.B4XRect _srcrect,int _targetx,int _targety,boolean _skipblending) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "drawbitmapcreator"))
	 {return ((String) Debug.delegate(ba, "drawbitmapcreator", new Object[] {_source,_srcrect,_targetx,_targety,_skipblending}));}
int _deltax = 0;
int _deltay = 0;
int _srctop = 0;
int _srcleft = 0;
int _y = 0;
int _x = 0;
RDebugUtils.currentLine=4521984;
 //BA.debugLineNum = 4521984;BA.debugLine="Public Sub DrawBitmapCreator (Source As BitmapCrea";
RDebugUtils.currentLine=4521985;
 //BA.debugLineNum = 4521985;BA.debugLine="If TargetY >= mHeight Or TargetX >= mWidth Then R";
if (_targety>=__ref._mheight || _targetx>=__ref._mwidth) { 
if (true) return "";};
RDebugUtils.currentLine=4521986;
 //BA.debugLineNum = 4521986;BA.debugLine="TargetX = Max(0, TargetX)";
_targetx = (int) (__c.Max(0,_targetx));
RDebugUtils.currentLine=4521987;
 //BA.debugLineNum = 4521987;BA.debugLine="TargetY = Max(0, TargetY)";
_targety = (int) (__c.Max(0,_targety));
RDebugUtils.currentLine=4521988;
 //BA.debugLineNum = 4521988;BA.debugLine="Dim DeltaX As Int = Min(mWidth - 1 - TargetX, Min";
_deltax = (int) (__c.Min(__ref._mwidth-1-_targetx,__c.Min(_srcrect.getWidth()-1,_source._mwidth-1-_srcrect.getLeft())));
RDebugUtils.currentLine=4521989;
 //BA.debugLineNum = 4521989;BA.debugLine="Dim DeltaY As Int = Min(mHeight - 1 - TargetY, Mi";
_deltay = (int) (__c.Min(__ref._mheight-1-_targety,__c.Min(_srcrect.getHeight()-1,_source._mheight-1-_srcrect.getTop())));
RDebugUtils.currentLine=4521990;
 //BA.debugLineNum = 4521990;BA.debugLine="Dim SrcTop As Int = SrcRect.Top";
_srctop = (int) (_srcrect.getTop());
RDebugUtils.currentLine=4521991;
 //BA.debugLineNum = 4521991;BA.debugLine="Dim SrcLeft As Int = SrcRect.Left";
_srcleft = (int) (_srcrect.getLeft());
RDebugUtils.currentLine=4521992;
 //BA.debugLineNum = 4521992;BA.debugLine="If SkipBlending Then";
if (_skipblending) { 
RDebugUtils.currentLine=4521994;
 //BA.debugLineNum = 4521994;BA.debugLine="For y = TargetY To TargetY + DeltaY";
{
final int step9 = 1;
final int limit9 = (int) (_targety+_deltay);
_y = _targety ;
for (;_y <= limit9 ;_y = _y + step9 ) {
RDebugUtils.currentLine=4521995;
 //BA.debugLineNum = 4521995;BA.debugLine="Bit.ArrayCopy(Source.mBuffer, SrcLeft * 4 + (y";
__c.Bit.ArrayCopy((Object)(_source._mbuffer),(int) (_srcleft*4+(_y-_targety+_srctop)*4*_source._mwidth),(Object)(__ref._mbuffer),(int) (_targetx*4+_y*4*__ref._mwidth),(int) ((_deltax+1)*4));
 }
};
 }else {
RDebugUtils.currentLine=4521999;
 //BA.debugLineNum = 4521999;BA.debugLine="For x = TargetX To TargetX + DeltaX";
{
final int step13 = 1;
final int limit13 = (int) (_targetx+_deltax);
_x = _targetx ;
for (;_x <= limit13 ;_x = _x + step13 ) {
RDebugUtils.currentLine=4522000;
 //BA.debugLineNum = 4522000;BA.debugLine="For y = TargetY To TargetY + DeltaY";
{
final int step14 = 1;
final int limit14 = (int) (_targety+_deltay);
_y = _targety ;
for (;_y <= limit14 ;_y = _y + step14 ) {
RDebugUtils.currentLine=4522026;
 //BA.debugLineNum = 4522026;BA.debugLine="BlendPixel(Source, x - TargetX + SrcRect.Left,";
__ref._blendpixel(null,_source,(int) (_x-_targetx+_srcrect.getLeft()),(int) (_y-_targety+_srcrect.getTop()),_x,_y);
 }
};
 }
};
 };
RDebugUtils.currentLine=4522032;
 //BA.debugLineNum = 4522032;BA.debugLine="End Sub";
return "";
}
public String  _fillgradient(b4j.example.bitmapcreator __ref,int[] _gradcolors,anywheresoftware.b4j.objects.B4XCanvas.B4XRect _rect,String _orientation) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "fillgradient"))
	 {return ((String) Debug.delegate(ba, "fillgradient", new Object[] {_gradcolors,_rect,_orientation}));}
float _sinl = 0f;
int _starty = 0;
int _endy = 0;
float _ox = 0f;
float _deltaox = 0f;
int _axislength = 0;
boolean _topbottom = false;
boolean _oppositecolors = false;
boolean _tr_bl = false;
boolean _rectangle = false;
int _numberofparts = 0;
float[] _dfix = null;
float[] _dfixdivsinl = null;
float _alpha = 0f;
float _tanl = 0f;
b4j.example.bitmapcreator._argbcolor[] _rgbcolor = null;
int _i = 0;
int _a = 0;
int _endmax = 0;
int _startmin = 0;
b4j.example.bitmapcreator._argbcolor _clrfrom = null;
b4j.example.bitmapcreator._argbcolor _clrto = null;
b4j.example.bitmapcreator._argbcolor _argb = null;
int _tstartx = 0;
int _tendx = 0;
int _tstep = 0;
int _cx = 0;
int _cy = 0;
float _xfix = 0f;
float _yfix = 0f;
int _part = 0;
int _r = 0;
float _dd = 0f;
int _x = 0;
int _y = 0;
int _endx = 0;
float _d = 0f;
int _startx = 0;
float _dddelta = 0f;
RDebugUtils.currentLine=4718592;
 //BA.debugLineNum = 4718592;BA.debugLine="Public Sub FillGradient (GradColors() As Int, Rect";
RDebugUtils.currentLine=4718593;
 //BA.debugLineNum = 4718593;BA.debugLine="If Rect.Width <= 1 Or Rect.Height <= 1 Or Rect.Le";
if (_rect.getWidth()<=1 || _rect.getHeight()<=1 || _rect.getLeft()>=__ref._mwidth || _rect.getTop()>=__ref._mheight) { 
if (true) return "";};
RDebugUtils.currentLine=4718594;
 //BA.debugLineNum = 4718594;BA.debugLine="If GradColors.Length = 1 Then";
if (_gradcolors.length==1) { 
RDebugUtils.currentLine=4718595;
 //BA.debugLineNum = 4718595;BA.debugLine="FillRect(GradColors(0), Rect)";
__ref._fillrect(null,_gradcolors[(int) (0)],_rect);
RDebugUtils.currentLine=4718596;
 //BA.debugLineNum = 4718596;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=4718598;
 //BA.debugLineNum = 4718598;BA.debugLine="Dim SinL As Float";
_sinl = 0f;
RDebugUtils.currentLine=4718599;
 //BA.debugLineNum = 4718599;BA.debugLine="Dim StartY As Int = Max(Rect.Top, 0)";
_starty = (int) (__c.Max(_rect.getTop(),0));
RDebugUtils.currentLine=4718600;
 //BA.debugLineNum = 4718600;BA.debugLine="Dim EndY As Int = Min(Rect.Bottom - 1, mHeight -";
_endy = (int) (__c.Min(_rect.getBottom()-1,__ref._mheight-1));
RDebugUtils.currentLine=4718601;
 //BA.debugLineNum = 4718601;BA.debugLine="Dim ox, deltaox As Float";
_ox = 0f;
_deltaox = 0f;
RDebugUtils.currentLine=4718602;
 //BA.debugLineNum = 4718602;BA.debugLine="Dim AxisLength As Int";
_axislength = 0;
RDebugUtils.currentLine=4718603;
 //BA.debugLineNum = 4718603;BA.debugLine="Dim TopBottom As Boolean";
_topbottom = false;
RDebugUtils.currentLine=4718604;
 //BA.debugLineNum = 4718604;BA.debugLine="Dim OppositeColors As Boolean";
_oppositecolors = false;
RDebugUtils.currentLine=4718605;
 //BA.debugLineNum = 4718605;BA.debugLine="Dim TR_BL As Boolean";
_tr_bl = false;
RDebugUtils.currentLine=4718606;
 //BA.debugLineNum = 4718606;BA.debugLine="Dim Rectangle As Boolean";
_rectangle = false;
RDebugUtils.currentLine=4718607;
 //BA.debugLineNum = 4718607;BA.debugLine="Dim NumberOfParts As Int = GradColors.Length - 1";
_numberofparts = (int) (_gradcolors.length-1);
RDebugUtils.currentLine=4718608;
 //BA.debugLineNum = 4718608;BA.debugLine="Dim DFix(NumberOfParts + 1) As Float";
_dfix = new float[(int) (_numberofparts+1)];
;
RDebugUtils.currentLine=4718609;
 //BA.debugLineNum = 4718609;BA.debugLine="Dim DFixDivSinL(NumberOfParts + 1) As Float";
_dfixdivsinl = new float[(int) (_numberofparts+1)];
;
RDebugUtils.currentLine=4718610;
 //BA.debugLineNum = 4718610;BA.debugLine="Select Orientation";
switch (BA.switchObjectToInt(_orientation,"TL_BR","BR_TL","TR_BL","BL_TR","LEFT_RIGHT","RIGHT_LEFT","TOP_BOTTOM","BOTTOM_TOP","RECTANGLE")) {
case 0: 
case 1: 
case 2: 
case 3: {
RDebugUtils.currentLine=4718612;
 //BA.debugLineNum = 4718612;BA.debugLine="Dim alpha As Float = ATanD(Rect.Width / Rect.He";
_alpha = (float) (__c.ATanD(_rect.getWidth()/(double)_rect.getHeight()));
RDebugUtils.currentLine=4718613;
 //BA.debugLineNum = 4718613;BA.debugLine="SinL = SinD(alpha)";
_sinl = (float) (__c.SinD(_alpha));
RDebugUtils.currentLine=4718614;
 //BA.debugLineNum = 4718614;BA.debugLine="AxisLength = Sqrt(Power(Rect.Width, 2) + Power(";
_axislength = (int) (__c.Sqrt(__c.Power(_rect.getWidth(),2)+__c.Power(_rect.getHeight(),2)));
RDebugUtils.currentLine=4718615;
 //BA.debugLineNum = 4718615;BA.debugLine="Dim TanL As Float = TanD(alpha)";
_tanl = (float) (__c.TanD(_alpha));
RDebugUtils.currentLine=4718616;
 //BA.debugLineNum = 4718616;BA.debugLine="deltaox = 1 / TanL";
_deltaox = (float) (1/(double)_tanl);
RDebugUtils.currentLine=4718617;
 //BA.debugLineNum = 4718617;BA.debugLine="ox = (StartY - Rect.Top) / TanL";
_ox = (float) ((_starty-_rect.getTop())/(double)_tanl);
RDebugUtils.currentLine=4718618;
 //BA.debugLineNum = 4718618;BA.debugLine="OppositeColors = Orientation = \"BR_TL\" Or Orien";
_oppositecolors = (_orientation).equals("BR_TL") || (_orientation).equals("BL_TR");
RDebugUtils.currentLine=4718619;
 //BA.debugLineNum = 4718619;BA.debugLine="TR_BL = Orientation = \"TR_BL\" Or Orientation =";
_tr_bl = (_orientation).equals("TR_BL") || (_orientation).equals("BL_TR");
 break; }
case 4: 
case 5: {
RDebugUtils.currentLine=4718621;
 //BA.debugLineNum = 4718621;BA.debugLine="AxisLength = Rect.Width";
_axislength = (int) (_rect.getWidth());
RDebugUtils.currentLine=4718622;
 //BA.debugLineNum = 4718622;BA.debugLine="deltaox = 0";
_deltaox = (float) (0);
RDebugUtils.currentLine=4718623;
 //BA.debugLineNum = 4718623;BA.debugLine="SinL = 1";
_sinl = (float) (1);
RDebugUtils.currentLine=4718624;
 //BA.debugLineNum = 4718624;BA.debugLine="OppositeColors = Orientation = \"RIGHT_LEFT\"";
_oppositecolors = (_orientation).equals("RIGHT_LEFT");
 break; }
case 6: 
case 7: {
RDebugUtils.currentLine=4718626;
 //BA.debugLineNum = 4718626;BA.debugLine="AxisLength = Rect.Height";
_axislength = (int) (_rect.getHeight());
RDebugUtils.currentLine=4718627;
 //BA.debugLineNum = 4718627;BA.debugLine="SinL = 0";
_sinl = (float) (0);
RDebugUtils.currentLine=4718628;
 //BA.debugLineNum = 4718628;BA.debugLine="ox = 0";
_ox = (float) (0);
RDebugUtils.currentLine=4718629;
 //BA.debugLineNum = 4718629;BA.debugLine="TopBottom = True";
_topbottom = __c.True;
RDebugUtils.currentLine=4718630;
 //BA.debugLineNum = 4718630;BA.debugLine="OppositeColors = Orientation = \"BOTTOM_TOP\"";
_oppositecolors = (_orientation).equals("BOTTOM_TOP");
 break; }
case 8: {
RDebugUtils.currentLine=4718632;
 //BA.debugLineNum = 4718632;BA.debugLine="AxisLength = Max(Rect.Width, Rect.Height) / 2";
_axislength = (int) (__c.Max(_rect.getWidth(),_rect.getHeight())/(double)2);
RDebugUtils.currentLine=4718633;
 //BA.debugLineNum = 4718633;BA.debugLine="Rectangle = True";
_rectangle = __c.True;
 break; }
default: {
RDebugUtils.currentLine=4718635;
 //BA.debugLineNum = 4718635;BA.debugLine="Log(\"Invalid orientation: \" & Orientation)";
__c.Log("Invalid orientation: "+_orientation);
 break; }
}
;
RDebugUtils.currentLine=4718638;
 //BA.debugLineNum = 4718638;BA.debugLine="Dim RGBColor(GradColors.Length) As ARGBColor";
_rgbcolor = new b4j.example.bitmapcreator._argbcolor[_gradcolors.length];
{
int d0 = _rgbcolor.length;
for (int i0 = 0;i0 < d0;i0++) {
_rgbcolor[i0] = new b4j.example.bitmapcreator._argbcolor();
}
}
;
RDebugUtils.currentLine=4718639;
 //BA.debugLineNum = 4718639;BA.debugLine="For i = 0 To GradColors.Length - 1";
{
final int step46 = 1;
final int limit46 = (int) (_gradcolors.length-1);
_i = (int) (0) ;
for (;_i <= limit46 ;_i = _i + step46 ) {
RDebugUtils.currentLine=4718640;
 //BA.debugLineNum = 4718640;BA.debugLine="Dim a As Int = i";
_a = _i;
RDebugUtils.currentLine=4718641;
 //BA.debugLineNum = 4718641;BA.debugLine="If OppositeColors Then a = GradColors.Length - 1";
if (_oppositecolors) { 
_a = (int) (_gradcolors.length-1-_i);};
RDebugUtils.currentLine=4718642;
 //BA.debugLineNum = 4718642;BA.debugLine="ColorToARGB(GradColors(a), RGBColor(i))";
__ref._colortoargb(null,_gradcolors[_a],_rgbcolor[_i]);
 }
};
RDebugUtils.currentLine=4718645;
 //BA.debugLineNum = 4718645;BA.debugLine="For i = 0 To NumberOfParts";
{
final int step51 = 1;
final int limit51 = _numberofparts;
_i = (int) (0) ;
for (;_i <= limit51 ;_i = _i + step51 ) {
RDebugUtils.currentLine=4718646;
 //BA.debugLineNum = 4718646;BA.debugLine="DFix(i) = i / NumberOfParts * AxisLength";
_dfix[_i] = (float) (_i/(double)_numberofparts*_axislength);
RDebugUtils.currentLine=4718647;
 //BA.debugLineNum = 4718647;BA.debugLine="DFixDivSinL(i) = DFix(i) / SinL";
_dfixdivsinl[_i] = (float) (_dfix[_i]/(double)_sinl);
 }
};
RDebugUtils.currentLine=4718649;
 //BA.debugLineNum = 4718649;BA.debugLine="Dim EndMax As Int = Min(mWidth - 1, Rect.Right -";
_endmax = (int) (__c.Min(__ref._mwidth-1,_rect.getRight()-1));
RDebugUtils.currentLine=4718650;
 //BA.debugLineNum = 4718650;BA.debugLine="Dim StartMin As Int = Max(Rect.Left, 0)";
_startmin = (int) (__c.Max(_rect.getLeft(),0));
RDebugUtils.currentLine=4718651;
 //BA.debugLineNum = 4718651;BA.debugLine="Dim ClrFrom, ClrTo As ARGBColor";
_clrfrom = new b4j.example.bitmapcreator._argbcolor();
_clrto = new b4j.example.bitmapcreator._argbcolor();
RDebugUtils.currentLine=4718652;
 //BA.debugLineNum = 4718652;BA.debugLine="Dim argb As ARGBColor";
_argb = new b4j.example.bitmapcreator._argbcolor();
RDebugUtils.currentLine=4718653;
 //BA.debugLineNum = 4718653;BA.debugLine="Dim tStartX, tEndX, tStep = 1 As Int";
_tstartx = 0;
_tendx = 0;
_tstep = (int) (1);
RDebugUtils.currentLine=4718654;
 //BA.debugLineNum = 4718654;BA.debugLine="If Rectangle Then";
if (_rectangle) { 
RDebugUtils.currentLine=4718655;
 //BA.debugLineNum = 4718655;BA.debugLine="Dim cx As Int = Rect.CenterX";
_cx = (int) (_rect.getCenterX());
RDebugUtils.currentLine=4718656;
 //BA.debugLineNum = 4718656;BA.debugLine="Dim cy As Int = Rect.CenterY";
_cy = (int) (_rect.getCenterY());
RDebugUtils.currentLine=4718657;
 //BA.debugLineNum = 4718657;BA.debugLine="Dim XFix = Min(1, Rect.Width / Rect.Height), YFi";
_xfix = (float) (__c.Min(1,_rect.getWidth()/(double)_rect.getHeight()));
_yfix = (float) (__c.Min(1,_rect.getHeight()/(double)_rect.getWidth()));
RDebugUtils.currentLine=4718658;
 //BA.debugLineNum = 4718658;BA.debugLine="For part = 0 To NumberOfParts - 1";
{
final int step64 = 1;
final int limit64 = (int) (_numberofparts-1);
_part = (int) (0) ;
for (;_part <= limit64 ;_part = _part + step64 ) {
RDebugUtils.currentLine=4718659;
 //BA.debugLineNum = 4718659;BA.debugLine="ClrFrom = RGBColor(part)";
_clrfrom = _rgbcolor[_part];
RDebugUtils.currentLine=4718660;
 //BA.debugLineNum = 4718660;BA.debugLine="ClrTo = RGBColor(part + 1)";
_clrto = _rgbcolor[(int) (_part+1)];
RDebugUtils.currentLine=4718661;
 //BA.debugLineNum = 4718661;BA.debugLine="For r = part / NumberOfParts * AxisLength To (p";
{
final int step67 = 1;
final int limit67 = (int) ((_part+1)/(double)_numberofparts*_axislength);
_r = (int) (_part/(double)_numberofparts*_axislength) ;
for (;_r <= limit67 ;_r = _r + step67 ) {
RDebugUtils.currentLine=4718662;
 //BA.debugLineNum = 4718662;BA.debugLine="Dim dd As Float = (r - DFix(part)) / (AxisLeng";
_dd = (float) ((_r-_dfix[_part])/(double)(_axislength/(double)_numberofparts));
RDebugUtils.currentLine=4718663;
 //BA.debugLineNum = 4718663;BA.debugLine="For x = -r To r";
{
final int step69 = 1;
final int limit69 = _r;
_x = (int) (-_r) ;
for (;_x <= limit69 ;_x = _x + step69 ) {
RDebugUtils.currentLine=4718664;
 //BA.debugLineNum = 4718664;BA.debugLine="argb.a = ClrFrom.a + dd * (ClrTo.a - ClrFrom.";
_argb.a = (int) (_clrfrom.a+_dd*(_clrto.a-_clrfrom.a));
RDebugUtils.currentLine=4718665;
 //BA.debugLineNum = 4718665;BA.debugLine="argb.r = ClrFrom.r + dd * (ClrTo.r - ClrFrom.";
_argb.r = (int) (_clrfrom.r+_dd*(_clrto.r-_clrfrom.r));
RDebugUtils.currentLine=4718666;
 //BA.debugLineNum = 4718666;BA.debugLine="argb.g = ClrFrom.g + dd * (ClrTo.g - ClrFrom.";
_argb.g = (int) (_clrfrom.g+_dd*(_clrto.g-_clrfrom.g));
RDebugUtils.currentLine=4718667;
 //BA.debugLineNum = 4718667;BA.debugLine="argb.b = ClrFrom.b + dd * (ClrTo.b - ClrFrom.";
_argb.b = (int) (_clrfrom.b+_dd*(_clrto.b-_clrfrom.b));
RDebugUtils.currentLine=4718668;
 //BA.debugLineNum = 4718668;BA.debugLine="ARGBToPremultipliedColor(argb, tempPM)";
__ref._argbtopremultipliedcolor(null,_argb,__ref._temppm);
RDebugUtils.currentLine=4718669;
 //BA.debugLineNum = 4718669;BA.debugLine="SetPremultipliedColor(cx + x * XFix, cy - r *";
__ref._setpremultipliedcolor(null,(int) (_cx+_x*_xfix),(int) (_cy-_r*_yfix),__ref._temppm);
RDebugUtils.currentLine=4718670;
 //BA.debugLineNum = 4718670;BA.debugLine="SetPremultipliedColor(cx + x * XFix, cy + r *";
__ref._setpremultipliedcolor(null,(int) (_cx+_x*_xfix),(int) (_cy+_r*_yfix),__ref._temppm);
RDebugUtils.currentLine=4718671;
 //BA.debugLineNum = 4718671;BA.debugLine="SetPremultipliedColor(cx - r * XFix, cy + x *";
__ref._setpremultipliedcolor(null,(int) (_cx-_r*_xfix),(int) (_cy+_x*_yfix),__ref._temppm);
RDebugUtils.currentLine=4718672;
 //BA.debugLineNum = 4718672;BA.debugLine="SetPremultipliedColor(cx + r * XFix, cy + x *";
__ref._setpremultipliedcolor(null,(int) (_cx+_r*_xfix),(int) (_cy+_x*_yfix),__ref._temppm);
 }
};
 }
};
 }
};
 }else {
RDebugUtils.currentLine=4718677;
 //BA.debugLineNum = 4718677;BA.debugLine="For y = StartY To EndY";
{
final int step83 = 1;
final int limit83 = _endy;
_y = _starty ;
for (;_y <= limit83 ;_y = _y + step83 ) {
RDebugUtils.currentLine=4718678;
 //BA.debugLineNum = 4718678;BA.debugLine="Dim EndX As Int = Rect.Left - ox - 1";
_endx = (int) (_rect.getLeft()-_ox-1);
RDebugUtils.currentLine=4718679;
 //BA.debugLineNum = 4718679;BA.debugLine="For part = 0 To NumberOfParts - 1";
{
final int step85 = 1;
final int limit85 = (int) (_numberofparts-1);
_part = (int) (0) ;
for (;_part <= limit85 ;_part = _part + step85 ) {
RDebugUtils.currentLine=4718680;
 //BA.debugLineNum = 4718680;BA.debugLine="ClrFrom = RGBColor(part)";
_clrfrom = _rgbcolor[_part];
RDebugUtils.currentLine=4718681;
 //BA.debugLineNum = 4718681;BA.debugLine="ClrTo = RGBColor(part + 1)";
_clrto = _rgbcolor[(int) (_part+1)];
RDebugUtils.currentLine=4718682;
 //BA.debugLineNum = 4718682;BA.debugLine="If TopBottom Then";
if (_topbottom) { 
RDebugUtils.currentLine=4718683;
 //BA.debugLineNum = 4718683;BA.debugLine="Dim d As Float = y - Rect.Top";
_d = (float) (_y-_rect.getTop());
RDebugUtils.currentLine=4718684;
 //BA.debugLineNum = 4718684;BA.debugLine="Dim dd As Float = (d - DFix(part)) / (AxisLen";
_dd = (float) ((_d-_dfix[_part])/(double)(_axislength/(double)_numberofparts));
RDebugUtils.currentLine=4718685;
 //BA.debugLineNum = 4718685;BA.debugLine="If dd < 0 Or dd > 1 Then";
if (_dd<0 || _dd>1) { 
RDebugUtils.currentLine=4718686;
 //BA.debugLineNum = 4718686;BA.debugLine="Continue";
if (true) continue;
 };
RDebugUtils.currentLine=4718688;
 //BA.debugLineNum = 4718688;BA.debugLine="Dim tStartX As Int = StartMin";
_tstartx = _startmin;
RDebugUtils.currentLine=4718689;
 //BA.debugLineNum = 4718689;BA.debugLine="Dim tEndX As Int = EndMax";
_tendx = _endmax;
 }else {
RDebugUtils.currentLine=4718691;
 //BA.debugLineNum = 4718691;BA.debugLine="Dim StartX As Int = Max(StartMin, EndX + 1)";
_startx = (int) (__c.Max(_startmin,_endx+1));
RDebugUtils.currentLine=4718692;
 //BA.debugLineNum = 4718692;BA.debugLine="Dim EndX As Int = Min(Rect.Left + DFixDivSinL";
_endx = (int) (__c.Min(_rect.getLeft()+_dfixdivsinl[(int) (_part+1)]-_ox,_endmax));
RDebugUtils.currentLine=4718693;
 //BA.debugLineNum = 4718693;BA.debugLine="Dim d As Float = SinL * (StartX - Rect.Left +";
_d = (float) (_sinl*(_startx-_rect.getLeft()+_ox));
RDebugUtils.currentLine=4718694;
 //BA.debugLineNum = 4718694;BA.debugLine="Dim ddDelta As Float = SinL / (AxisLength / N";
_dddelta = (float) (_sinl/(double)(_axislength/(double)_numberofparts));
RDebugUtils.currentLine=4718695;
 //BA.debugLineNum = 4718695;BA.debugLine="Dim dd As Float = (d - DFix(part)) / (AxisLen";
_dd = (float) ((_d-_dfix[_part])/(double)(_axislength/(double)_numberofparts));
RDebugUtils.currentLine=4718696;
 //BA.debugLineNum = 4718696;BA.debugLine="If TR_BL Then";
if (_tr_bl) { 
RDebugUtils.currentLine=4718697;
 //BA.debugLineNum = 4718697;BA.debugLine="tStartX = Rect.Right - 1 - (StartX - Rect.Le";
_tstartx = (int) (_rect.getRight()-1-(_startx-_rect.getLeft()));
RDebugUtils.currentLine=4718698;
 //BA.debugLineNum = 4718698;BA.debugLine="tEndX = Rect.Right - 1 - (EndX - Rect.Left)";
_tendx = (int) (_rect.getRight()-1-(_endx-_rect.getLeft()));
RDebugUtils.currentLine=4718699;
 //BA.debugLineNum = 4718699;BA.debugLine="tStep = -1";
_tstep = (int) (-1);
 }else {
RDebugUtils.currentLine=4718701;
 //BA.debugLineNum = 4718701;BA.debugLine="tStartX = StartX";
_tstartx = _startx;
RDebugUtils.currentLine=4718702;
 //BA.debugLineNum = 4718702;BA.debugLine="tEndX = EndX";
_tendx = _endx;
 };
 };
RDebugUtils.currentLine=4718705;
 //BA.debugLineNum = 4718705;BA.debugLine="For	x = tStartX To tEndX Step tStep";
{
final int step111 = _tstep;
final int limit111 = _tendx;
_x = _tstartx ;
for (;(step111 > 0 && _x <= limit111) || (step111 < 0 && _x >= limit111) ;_x = ((int)(0 + _x + step111))  ) {
RDebugUtils.currentLine=4718706;
 //BA.debugLineNum = 4718706;BA.debugLine="argb.a = ClrFrom.a + dd * (ClrTo.a - ClrFrom.";
_argb.a = (int) (_clrfrom.a+_dd*(_clrto.a-_clrfrom.a));
RDebugUtils.currentLine=4718707;
 //BA.debugLineNum = 4718707;BA.debugLine="argb.r = ClrFrom.r + dd * (ClrTo.r - ClrFrom.";
_argb.r = (int) (_clrfrom.r+_dd*(_clrto.r-_clrfrom.r));
RDebugUtils.currentLine=4718708;
 //BA.debugLineNum = 4718708;BA.debugLine="argb.g = ClrFrom.g + dd * (ClrTo.g - ClrFrom.";
_argb.g = (int) (_clrfrom.g+_dd*(_clrto.g-_clrfrom.g));
RDebugUtils.currentLine=4718709;
 //BA.debugLineNum = 4718709;BA.debugLine="argb.b = ClrFrom.b + dd * (ClrTo.b - ClrFrom.";
_argb.b = (int) (_clrfrom.b+_dd*(_clrto.b-_clrfrom.b));
RDebugUtils.currentLine=4718710;
 //BA.debugLineNum = 4718710;BA.debugLine="SetARGB(x, y, argb)";
__ref._setargb(null,_x,_y,_argb);
RDebugUtils.currentLine=4718711;
 //BA.debugLineNum = 4718711;BA.debugLine="dd = dd + ddDelta";
_dd = (float) (_dd+_dddelta);
 }
};
 }
};
RDebugUtils.currentLine=4718714;
 //BA.debugLineNum = 4718714;BA.debugLine="ox = ox + deltaox";
_ox = (float) (_ox+_deltaox);
 }
};
 };
RDebugUtils.currentLine=4718718;
 //BA.debugLineNum = 4718718;BA.debugLine="End Sub";
return "";
}
public String  _fillrect(b4j.example.bitmapcreator __ref,int _color,anywheresoftware.b4j.objects.B4XCanvas.B4XRect _rect) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "fillrect"))
	 {return ((String) Debug.delegate(ba, "fillrect", new Object[] {_color,_rect}));}
int _startx = 0;
int _endx = 0;
int _starty = 0;
int _endy = 0;
int _cp = 0;
byte[] _b = null;
int _x = 0;
int _y = 0;
RDebugUtils.currentLine=4390912;
 //BA.debugLineNum = 4390912;BA.debugLine="Public Sub FillRect (Color As Int, Rect As B4XRect";
RDebugUtils.currentLine=4390913;
 //BA.debugLineNum = 4390913;BA.debugLine="Dim StartX As Int = Max(0, Rect.Left)";
_startx = (int) (__c.Max(0,_rect.getLeft()));
RDebugUtils.currentLine=4390914;
 //BA.debugLineNum = 4390914;BA.debugLine="Dim EndX As Int = Min(mWidth - 1, Rect.Right - 1)";
_endx = (int) (__c.Min(__ref._mwidth-1,_rect.getRight()-1));
RDebugUtils.currentLine=4390915;
 //BA.debugLineNum = 4390915;BA.debugLine="Dim StartY As Int = Max(0, Rect.Top)";
_starty = (int) (__c.Max(0,_rect.getTop()));
RDebugUtils.currentLine=4390916;
 //BA.debugLineNum = 4390916;BA.debugLine="Dim EndY As Int = Min(mHeight - 1, Rect.Bottom -";
_endy = (int) (__c.Min(__ref._mheight-1,_rect.getBottom()-1));
RDebugUtils.currentLine=4390917;
 //BA.debugLineNum = 4390917;BA.debugLine="If EndX < StartX Or EndY < StartY Then Return";
if (_endx<_startx || _endy<_starty) { 
if (true) return "";};
RDebugUtils.currentLine=4390918;
 //BA.debugLineNum = 4390918;BA.debugLine="SetColor(StartX, StartY, Color)";
__ref._setcolor(null,_startx,_starty,_color);
RDebugUtils.currentLine=4390919;
 //BA.debugLineNum = 4390919;BA.debugLine="Dim cp As Int = StartX * 4 + StartY * mWidth * 4";
_cp = (int) (_startx*4+_starty*__ref._mwidth*4);
RDebugUtils.currentLine=4390920;
 //BA.debugLineNum = 4390920;BA.debugLine="Dim b((EndX - StartX + 1) * 4) As Byte";
_b = new byte[(int) ((_endx-_startx+1)*4)];
;
RDebugUtils.currentLine=4390921;
 //BA.debugLineNum = 4390921;BA.debugLine="For x = 0 To b.Length - 4 Step 4";
{
final int step9 = 4;
final int limit9 = (int) (_b.length-4);
_x = (int) (0) ;
for (;_x <= limit9 ;_x = _x + step9 ) {
RDebugUtils.currentLine=4390922;
 //BA.debugLineNum = 4390922;BA.debugLine="b(x) = mBuffer(cp)";
_b[_x] = __ref._mbuffer[_cp];
RDebugUtils.currentLine=4390923;
 //BA.debugLineNum = 4390923;BA.debugLine="b(x + 1) = mBuffer(cp + 1)";
_b[(int) (_x+1)] = __ref._mbuffer[(int) (_cp+1)];
RDebugUtils.currentLine=4390924;
 //BA.debugLineNum = 4390924;BA.debugLine="b(x + 2) = mBuffer(cp + 2)";
_b[(int) (_x+2)] = __ref._mbuffer[(int) (_cp+2)];
RDebugUtils.currentLine=4390925;
 //BA.debugLineNum = 4390925;BA.debugLine="b(x + 3) = mBuffer(cp + 3)";
_b[(int) (_x+3)] = __ref._mbuffer[(int) (_cp+3)];
 }
};
RDebugUtils.currentLine=4390927;
 //BA.debugLineNum = 4390927;BA.debugLine="For y = StartY * mWidth * 4 To EndY * mWidth * 4";
{
final int step15 = (int) (__ref._mwidth*4);
final int limit15 = (int) (_endy*__ref._mwidth*4);
_y = (int) (_starty*__ref._mwidth*4) ;
for (;(step15 > 0 && _y <= limit15) || (step15 < 0 && _y >= limit15) ;_y = ((int)(0 + _y + step15))  ) {
RDebugUtils.currentLine=4390928;
 //BA.debugLineNum = 4390928;BA.debugLine="Bit.ArrayCopy(b, 0, mBuffer, y + StartX * 4, b.L";
__c.Bit.ArrayCopy((Object)(_b),(int) (0),(Object)(__ref._mbuffer),(int) (_y+_startx*4),_b.length);
 }
};
RDebugUtils.currentLine=4390930;
 //BA.debugLineNum = 4390930;BA.debugLine="End Sub";
return "";
}
public String  _fillradialgradient(b4j.example.bitmapcreator __ref,int[] _gradcolors,anywheresoftware.b4j.objects.B4XCanvas.B4XRect _rect) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "fillradialgradient"))
	 {return ((String) Debug.delegate(ba, "fillradialgradient", new Object[] {_gradcolors,_rect}));}
b4j.example.bitmapcreator._argbcolor[] _rgbcolor = null;
int _i = 0;
int _maxdistance = 0;
b4j.example.bitmapcreator._argbcolor[] _distancetocolor = null;
int _currentcolorindex = 0;
int _lengthofeachcolor = 0;
int _c = 0;
float _l = 0f;
int _cx = 0;
int _cy = 0;
int _x = 0;
int _dx = 0;
int _y = 0;
int _distance = 0;
RDebugUtils.currentLine=4784128;
 //BA.debugLineNum = 4784128;BA.debugLine="Public Sub FillRadialGradient (GradColors() As Int";
RDebugUtils.currentLine=4784129;
 //BA.debugLineNum = 4784129;BA.debugLine="Dim RGBColor(GradColors.Length) As ARGBColor";
_rgbcolor = new b4j.example.bitmapcreator._argbcolor[_gradcolors.length];
{
int d0 = _rgbcolor.length;
for (int i0 = 0;i0 < d0;i0++) {
_rgbcolor[i0] = new b4j.example.bitmapcreator._argbcolor();
}
}
;
RDebugUtils.currentLine=4784130;
 //BA.debugLineNum = 4784130;BA.debugLine="For i = 0 To GradColors.Length - 1";
{
final int step2 = 1;
final int limit2 = (int) (_gradcolors.length-1);
_i = (int) (0) ;
for (;_i <= limit2 ;_i = _i + step2 ) {
RDebugUtils.currentLine=4784131;
 //BA.debugLineNum = 4784131;BA.debugLine="ColorToARGB(GradColors(i), RGBColor(i))";
__ref._colortoargb(null,_gradcolors[_i],_rgbcolor[_i]);
 }
};
RDebugUtils.currentLine=4784133;
 //BA.debugLineNum = 4784133;BA.debugLine="Dim MaxDistance As Int = Ceil(Sqrt(Power(Rect.Wid";
_maxdistance = (int) (__c.Ceil(__c.Sqrt(__c.Power(_rect.getWidth()/(double)2,2)+__c.Power(_rect.getHeight()/(double)2,2))));
RDebugUtils.currentLine=4784134;
 //BA.debugLineNum = 4784134;BA.debugLine="Dim DistanceToColor(MaxDistance) As ARGBColor";
_distancetocolor = new b4j.example.bitmapcreator._argbcolor[_maxdistance];
{
int d0 = _distancetocolor.length;
for (int i0 = 0;i0 < d0;i0++) {
_distancetocolor[i0] = new b4j.example.bitmapcreator._argbcolor();
}
}
;
RDebugUtils.currentLine=4784135;
 //BA.debugLineNum = 4784135;BA.debugLine="Dim CurrentColorIndex As Int";
_currentcolorindex = 0;
RDebugUtils.currentLine=4784136;
 //BA.debugLineNum = 4784136;BA.debugLine="Dim LengthOfEachColor As Int = Ceil(MaxDistance /";
_lengthofeachcolor = (int) (__c.Ceil(_maxdistance/(double)(_gradcolors.length-1)));
RDebugUtils.currentLine=4784137;
 //BA.debugLineNum = 4784137;BA.debugLine="Dim c As Int";
_c = 0;
RDebugUtils.currentLine=4784138;
 //BA.debugLineNum = 4784138;BA.debugLine="For i = 0 To MaxDistance - 1";
{
final int step10 = 1;
final int limit10 = (int) (_maxdistance-1);
_i = (int) (0) ;
for (;_i <= limit10 ;_i = _i + step10 ) {
RDebugUtils.currentLine=4784139;
 //BA.debugLineNum = 4784139;BA.debugLine="Dim l As Float = CurrentColorIndex / LengthOfEac";
_l = (float) (_currentcolorindex/(double)_lengthofeachcolor);
RDebugUtils.currentLine=4784140;
 //BA.debugLineNum = 4784140;BA.debugLine="DistanceToColor(i).a = RGBColor(c).a + l * (RGBC";
_distancetocolor[_i].a = (int) (_rgbcolor[_c].a+_l*(_rgbcolor[(int) (_c+1)].a-_rgbcolor[_c].a));
RDebugUtils.currentLine=4784141;
 //BA.debugLineNum = 4784141;BA.debugLine="DistanceToColor(i).r = RGBColor(c).r + l * (RGBC";
_distancetocolor[_i].r = (int) (_rgbcolor[_c].r+_l*(_rgbcolor[(int) (_c+1)].r-_rgbcolor[_c].r));
RDebugUtils.currentLine=4784142;
 //BA.debugLineNum = 4784142;BA.debugLine="DistanceToColor(i).g = RGBColor(c).g + l * (RGBC";
_distancetocolor[_i].g = (int) (_rgbcolor[_c].g+_l*(_rgbcolor[(int) (_c+1)].g-_rgbcolor[_c].g));
RDebugUtils.currentLine=4784143;
 //BA.debugLineNum = 4784143;BA.debugLine="DistanceToColor(i).b = RGBColor(c).b + l * (RGBC";
_distancetocolor[_i].b = (int) (_rgbcolor[_c].b+_l*(_rgbcolor[(int) (_c+1)].b-_rgbcolor[_c].b));
RDebugUtils.currentLine=4784144;
 //BA.debugLineNum = 4784144;BA.debugLine="CurrentColorIndex = CurrentColorIndex + 1";
_currentcolorindex = (int) (_currentcolorindex+1);
RDebugUtils.currentLine=4784145;
 //BA.debugLineNum = 4784145;BA.debugLine="If CurrentColorIndex = LengthOfEachColor Then";
if (_currentcolorindex==_lengthofeachcolor) { 
RDebugUtils.currentLine=4784146;
 //BA.debugLineNum = 4784146;BA.debugLine="CurrentColorIndex = 0";
_currentcolorindex = (int) (0);
RDebugUtils.currentLine=4784147;
 //BA.debugLineNum = 4784147;BA.debugLine="c = c + 1";
_c = (int) (_c+1);
 };
 }
};
RDebugUtils.currentLine=4784150;
 //BA.debugLineNum = 4784150;BA.debugLine="Dim cx As Int = Rect.CenterX";
_cx = (int) (_rect.getCenterX());
RDebugUtils.currentLine=4784151;
 //BA.debugLineNum = 4784151;BA.debugLine="Dim cy As Int = Rect.CenterY";
_cy = (int) (_rect.getCenterY());
RDebugUtils.currentLine=4784152;
 //BA.debugLineNum = 4784152;BA.debugLine="For x = Max(0, Rect.Left) To Min(mWidth - 1, Rect";
{
final int step24 = 1;
final int limit24 = (int) (__c.Min(__ref._mwidth-1,_rect.getRight()-1));
_x = (int) (__c.Max(0,_rect.getLeft())) ;
for (;_x <= limit24 ;_x = _x + step24 ) {
RDebugUtils.currentLine=4784153;
 //BA.debugLineNum = 4784153;BA.debugLine="Dim dx As Int = Power(x - cx, 2)";
_dx = (int) (__c.Power(_x-_cx,2));
RDebugUtils.currentLine=4784154;
 //BA.debugLineNum = 4784154;BA.debugLine="For y = Max(0, Rect.Top) To Min(mHeight - 1, Rec";
{
final int step26 = 1;
final int limit26 = (int) (__c.Min(__ref._mheight-1,_rect.getBottom()-1));
_y = (int) (__c.Max(0,_rect.getTop())) ;
for (;_y <= limit26 ;_y = _y + step26 ) {
RDebugUtils.currentLine=4784155;
 //BA.debugLineNum = 4784155;BA.debugLine="Dim distance As Int = Sqrt(dx + Power(y - cy, 2";
_distance = (int) (__c.Sqrt(_dx+__c.Power(_y-_cy,2)));
RDebugUtils.currentLine=4784156;
 //BA.debugLineNum = 4784156;BA.debugLine="SetARGB(x, y, DistanceToColor(distance))";
__ref._setargb(null,_x,_y,_distancetocolor[_distance]);
 }
};
 }
};
RDebugUtils.currentLine=4784159;
 //BA.debugLineNum = 4784159;BA.debugLine="End Sub";
return "";
}
public String  _setcolor(b4j.example.bitmapcreator __ref,int _x,int _y,int _clr) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "setcolor"))
	 {return ((String) Debug.delegate(ba, "setcolor", new Object[] {_x,_y,_clr}));}
RDebugUtils.currentLine=3670016;
 //BA.debugLineNum = 3670016;BA.debugLine="Public Sub SetColor(x As Int, y As Int, Clr As Int";
RDebugUtils.currentLine=3670017;
 //BA.debugLineNum = 3670017;BA.debugLine="ColorToARGB(Clr, tempARGB)";
__ref._colortoargb(null,_clr,__ref._tempargb);
RDebugUtils.currentLine=3670018;
 //BA.debugLineNum = 3670018;BA.debugLine="SetARGB(x, y, tempARGB)";
__ref._setargb(null,_x,_y,__ref._tempargb);
RDebugUtils.currentLine=3670019;
 //BA.debugLineNum = 3670019;BA.debugLine="End Sub";
return "";
}
public byte[]  _getbuffer(b4j.example.bitmapcreator __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "getbuffer"))
	 {return ((byte[]) Debug.delegate(ba, "getbuffer", null));}
RDebugUtils.currentLine=3538944;
 //BA.debugLineNum = 3538944;BA.debugLine="Public Sub getBuffer() As Byte()";
RDebugUtils.currentLine=3538945;
 //BA.debugLineNum = 3538945;BA.debugLine="Return mBuffer";
if (true) return __ref._mbuffer;
RDebugUtils.currentLine=3538946;
 //BA.debugLineNum = 3538946;BA.debugLine="End Sub";
return null;
}
public int  _getcolor(b4j.example.bitmapcreator __ref,int _x,int _y) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "getcolor"))
	 {return ((Integer) Debug.delegate(ba, "getcolor", new Object[] {_x,_y}));}
RDebugUtils.currentLine=4128768;
 //BA.debugLineNum = 4128768;BA.debugLine="Public Sub GetColor (x As Int, y As Int) As Int";
RDebugUtils.currentLine=4128769;
 //BA.debugLineNum = 4128769;BA.debugLine="GetARGB(x, y, tempARGB)";
__ref._getargb(null,_x,_y,__ref._tempargb);
RDebugUtils.currentLine=4128770;
 //BA.debugLineNum = 4128770;BA.debugLine="Return Bit.ShiftLeft(tempARGB.a, 24) + Bit.ShiftL";
if (true) return (int) (__c.Bit.ShiftLeft(__ref._tempargb.a,(int) (24))+__c.Bit.ShiftLeft(__ref._tempargb.r,(int) (16))+__c.Bit.ShiftLeft(__ref._tempargb.g,(int) (8))+__ref._tempargb.b);
RDebugUtils.currentLine=4128771;
 //BA.debugLineNum = 4128771;BA.debugLine="End Sub";
return 0;
}
public boolean  _istransparent(b4j.example.bitmapcreator __ref,int _x,int _y) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "istransparent"))
	 {return ((Boolean) Debug.delegate(ba, "istransparent", new Object[] {_x,_y}));}
int _cp = 0;
RDebugUtils.currentLine=4259840;
 //BA.debugLineNum = 4259840;BA.debugLine="Public Sub IsTransparent(x As Int, y As Int) As Bo";
RDebugUtils.currentLine=4259841;
 //BA.debugLineNum = 4259841;BA.debugLine="Dim cp As Int = x * 4 + y * mWidth * 4";
_cp = (int) (_x*4+_y*__ref._mwidth*4);
RDebugUtils.currentLine=4259842;
 //BA.debugLineNum = 4259842;BA.debugLine="Return mBuffer(cp + ai) = 0";
if (true) return __ref._mbuffer[(int) (_cp+__ref._ai)]==0;
RDebugUtils.currentLine=4259843;
 //BA.debugLineNum = 4259843;BA.debugLine="End Sub";
return false;
}
public String  _sethsv(b4j.example.bitmapcreator __ref,int _x,int _y,int _alpha,int _h,float _s,float _v) throws Exception{
__ref = this;
RDebugUtils.currentModule="bitmapcreator";
if (Debug.shouldDelegate(ba, "sethsv"))
	 {return ((String) Debug.delegate(ba, "sethsv", new Object[] {_x,_y,_alpha,_h,_s,_v}));}
float _r = 0f;
float _g = 0f;
float _b = 0f;
int _hi = 0;
int _hbucket = 0;
float _f = 0f;
float _p = 0f;
float _q = 0f;
float _t = 0f;
RDebugUtils.currentLine=3866624;
 //BA.debugLineNum = 3866624;BA.debugLine="Public Sub SetHSV(x As Int, y As Int, alpha As Int";
RDebugUtils.currentLine=3866625;
 //BA.debugLineNum = 3866625;BA.debugLine="Dim r, g, b As Float";
_r = 0f;
_g = 0f;
_b = 0f;
RDebugUtils.currentLine=3866626;
 //BA.debugLineNum = 3866626;BA.debugLine="Dim hi As Int = Floor(h / 60)";
_hi = (int) (__c.Floor(_h/(double)60));
RDebugUtils.currentLine=3866627;
 //BA.debugLineNum = 3866627;BA.debugLine="Dim hbucket As Int =  hi Mod 6";
_hbucket = (int) (_hi%6);
RDebugUtils.currentLine=3866628;
 //BA.debugLineNum = 3866628;BA.debugLine="Dim f As Float = h / 60 - hi";
_f = (float) (_h/(double)60-_hi);
RDebugUtils.currentLine=3866629;
 //BA.debugLineNum = 3866629;BA.debugLine="Dim p As Float = v * (1 - s)";
_p = (float) (_v*(1-_s));
RDebugUtils.currentLine=3866630;
 //BA.debugLineNum = 3866630;BA.debugLine="Dim q As Float = v  * (1 - f * s)";
_q = (float) (_v*(1-_f*_s));
RDebugUtils.currentLine=3866631;
 //BA.debugLineNum = 3866631;BA.debugLine="Dim t As Float = v * (1 - (1 - f) * s)";
_t = (float) (_v*(1-(1-_f)*_s));
RDebugUtils.currentLine=3866632;
 //BA.debugLineNum = 3866632;BA.debugLine="Select hbucket";
switch (_hbucket) {
case 0: {
RDebugUtils.currentLine=3866634;
 //BA.debugLineNum = 3866634;BA.debugLine="r = v";
_r = _v;
RDebugUtils.currentLine=3866635;
 //BA.debugLineNum = 3866635;BA.debugLine="g = t";
_g = _t;
RDebugUtils.currentLine=3866636;
 //BA.debugLineNum = 3866636;BA.debugLine="b = p";
_b = _p;
 break; }
case 1: {
RDebugUtils.currentLine=3866638;
 //BA.debugLineNum = 3866638;BA.debugLine="r = q";
_r = _q;
RDebugUtils.currentLine=3866639;
 //BA.debugLineNum = 3866639;BA.debugLine="g = v";
_g = _v;
RDebugUtils.currentLine=3866640;
 //BA.debugLineNum = 3866640;BA.debugLine="b = p";
_b = _p;
 break; }
case 2: {
RDebugUtils.currentLine=3866642;
 //BA.debugLineNum = 3866642;BA.debugLine="r = p";
_r = _p;
RDebugUtils.currentLine=3866643;
 //BA.debugLineNum = 3866643;BA.debugLine="g = v";
_g = _v;
RDebugUtils.currentLine=3866644;
 //BA.debugLineNum = 3866644;BA.debugLine="b = t";
_b = _t;
 break; }
case 3: {
RDebugUtils.currentLine=3866646;
 //BA.debugLineNum = 3866646;BA.debugLine="r = p";
_r = _p;
RDebugUtils.currentLine=3866647;
 //BA.debugLineNum = 3866647;BA.debugLine="g = q";
_g = _q;
RDebugUtils.currentLine=3866648;
 //BA.debugLineNum = 3866648;BA.debugLine="b = v";
_b = _v;
 break; }
case 4: {
RDebugUtils.currentLine=3866650;
 //BA.debugLineNum = 3866650;BA.debugLine="r = t";
_r = _t;
RDebugUtils.currentLine=3866651;
 //BA.debugLineNum = 3866651;BA.debugLine="g = p";
_g = _p;
RDebugUtils.currentLine=3866652;
 //BA.debugLineNum = 3866652;BA.debugLine="b = v";
_b = _v;
 break; }
case 5: {
RDebugUtils.currentLine=3866654;
 //BA.debugLineNum = 3866654;BA.debugLine="r = v";
_r = _v;
RDebugUtils.currentLine=3866655;
 //BA.debugLineNum = 3866655;BA.debugLine="g = p";
_g = _p;
RDebugUtils.currentLine=3866656;
 //BA.debugLineNum = 3866656;BA.debugLine="b = q";
_b = _q;
 break; }
}
;
RDebugUtils.currentLine=3866658;
 //BA.debugLineNum = 3866658;BA.debugLine="tempARGB.a = alpha";
__ref._tempargb.a = _alpha;
RDebugUtils.currentLine=3866659;
 //BA.debugLineNum = 3866659;BA.debugLine="tempARGB.r = r * 255";
__ref._tempargb.r = (int) (_r*255);
RDebugUtils.currentLine=3866660;
 //BA.debugLineNum = 3866660;BA.debugLine="tempARGB.g = g * 255";
__ref._tempargb.g = (int) (_g*255);
RDebugUtils.currentLine=3866661;
 //BA.debugLineNum = 3866661;BA.debugLine="tempARGB.b = b * 255";
__ref._tempargb.b = (int) (_b*255);
RDebugUtils.currentLine=3866662;
 //BA.debugLineNum = 3866662;BA.debugLine="SetARGB(x, y, tempARGB)";
__ref._setargb(null,_x,_y,__ref._tempargb);
RDebugUtils.currentLine=3866663;
 //BA.debugLineNum = 3866663;BA.debugLine="End Sub";
return "";
}
}