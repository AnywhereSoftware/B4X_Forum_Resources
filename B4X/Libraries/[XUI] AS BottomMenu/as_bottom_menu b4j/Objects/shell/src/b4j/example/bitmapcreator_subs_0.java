package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class bitmapcreator_subs_0 {


public static RemoteObject  _argbtopremultipliedcolor(RemoteObject __ref,RemoteObject _argb,RemoteObject _pm) throws Exception{
try {
		Debug.PushSubsStack("ARGBToPremultipliedColor (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,94);
if (RapidSub.canDelegate("argbtopremultipliedcolor")) { return __ref.runUserSub(false, "bitmapcreator","argbtopremultipliedcolor", __ref, _argb, _pm);}
RemoteObject _a = RemoteObject.createImmutable(0f);
Debug.locals.put("ARGB", _argb);
Debug.locals.put("PM", _pm);
 BA.debugLineNum = 94;BA.debugLine="Public Sub ARGBToPremultipliedColor (ARGB As ARGBC";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 95;BA.debugLine="Dim a As Float = ARGB.a / 255";
Debug.ShouldStop(1073741824);
_a = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_argb.getField(true,"a"),RemoteObject.createImmutable(255)}, "/",0, 0));Debug.locals.put("a", _a);Debug.locals.put("a", _a);
 BA.debugLineNum = 96;BA.debugLine="PM.a = ARGB.a";
Debug.ShouldStop(-2147483648);
_pm.setField ("a",_argb.getField(true,"a"));
 BA.debugLineNum = 97;BA.debugLine="PM.r = ARGB.r * a";
Debug.ShouldStop(1);
_pm.setField ("r",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_argb.getField(true,"r"),_a}, "*",0, 0)));
 BA.debugLineNum = 98;BA.debugLine="PM.g = ARGB.g * a";
Debug.ShouldStop(2);
_pm.setField ("g",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_argb.getField(true,"g"),_a}, "*",0, 0)));
 BA.debugLineNum = 99;BA.debugLine="PM.b = ARGB.b * a";
Debug.ShouldStop(4);
_pm.setField ("b",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_argb.getField(true,"b"),_a}, "*",0, 0)));
 BA.debugLineNum = 100;BA.debugLine="Return PM";
Debug.ShouldStop(8);
if (true) return _pm;
 BA.debugLineNum = 101;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _blendpixel(RemoteObject __ref,RemoteObject _source,RemoteObject _srcx,RemoteObject _srcy,RemoteObject _targetx,RemoteObject _targety) throws Exception{
try {
		Debug.PushSubsStack("BlendPixel (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,358);
if (RapidSub.canDelegate("blendpixel")) { return __ref.runUserSub(false, "bitmapcreator","blendpixel", __ref, _source, _srcx, _srcy, _targetx, _targety);}
RemoteObject _srcpm = RemoteObject.declareNull("b4j.example.bitmapcreator._premultipliedcolor");
RemoteObject _srcaf = RemoteObject.createImmutable(0f);
Debug.locals.put("Source", _source);
Debug.locals.put("SrcX", _srcx);
Debug.locals.put("SrcY", _srcy);
Debug.locals.put("TargetX", _targetx);
Debug.locals.put("TargetY", _targety);
 BA.debugLineNum = 358;BA.debugLine="Public Sub BlendPixel (Source As BitmapCreator, Sr";
Debug.ShouldStop(32);
 BA.debugLineNum = 359;BA.debugLine="Dim SrcPM As PremultipliedColor = Source.GetPremu";
Debug.ShouldStop(64);
_srcpm = _source.runClassMethod (b4j.example.bitmapcreator.class, "_getpremultipliedcolor",(Object)(_srcx),(Object)(_srcy),(Object)(__ref.getField(false,"_temppm2")));Debug.locals.put("SrcPM", _srcpm);Debug.locals.put("SrcPM", _srcpm);
 BA.debugLineNum = 360;BA.debugLine="If SrcPM.a <> UnsignedFF Then";
Debug.ShouldStop(128);
if (RemoteObject.solveBoolean("!",_srcpm.getField(true,"a"),BA.numberCast(double.class, __ref.getField(true,"_unsignedff")))) { 
 BA.debugLineNum = 361;BA.debugLine="If SrcPM.a = 0 Then Return";
Debug.ShouldStop(256);
if (RemoteObject.solveBoolean("=",_srcpm.getField(true,"a"),BA.numberCast(double.class, 0))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 362;BA.debugLine="SrcPM.a = Bit.And(0xff, SrcPM.a)";
Debug.ShouldStop(512);
_srcpm.setField ("a",bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(_srcpm.getField(true,"a"))));
 BA.debugLineNum = 363;BA.debugLine="GetPremultipliedColor(TargetX, TargetY, tempPM)";
Debug.ShouldStop(1024);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_getpremultipliedcolor",(Object)(_targetx),(Object)(_targety),(Object)(__ref.getField(false,"_temppm")));
 BA.debugLineNum = 364;BA.debugLine="Dim SrcAF As Float = 1 - (SrcPM.a / 255)";
Debug.ShouldStop(2048);
_srcaf = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),(RemoteObject.solve(new RemoteObject[] {_srcpm.getField(true,"a"),RemoteObject.createImmutable(255)}, "/",0, 0))}, "-",1, 0));Debug.locals.put("SrcAF", _srcaf);Debug.locals.put("SrcAF", _srcaf);
 BA.debugLineNum = 365;BA.debugLine="SrcPM.r =  Bit.And(0xff, SrcPM.r) + SrcAF *  Bit";
Debug.ShouldStop(4096);
_srcpm.setField ("r",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(_srcpm.getField(true,"r"))),_srcaf,bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(__ref.getField(false,"_temppm").getField(true,"r")))}, "+*",1, 0)));
 BA.debugLineNum = 366;BA.debugLine="SrcPM.g =  Bit.And(0xff, SrcPM.g) + SrcAF *  Bit";
Debug.ShouldStop(8192);
_srcpm.setField ("g",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(_srcpm.getField(true,"g"))),_srcaf,bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(__ref.getField(false,"_temppm").getField(true,"g")))}, "+*",1, 0)));
 BA.debugLineNum = 367;BA.debugLine="SrcPM.b =  Bit.And(0xff, SrcPM.b) + SrcAF *  Bit";
Debug.ShouldStop(16384);
_srcpm.setField ("b",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(_srcpm.getField(true,"b"))),_srcaf,bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(__ref.getField(false,"_temppm").getField(true,"b")))}, "+*",1, 0)));
 BA.debugLineNum = 368;BA.debugLine="SrcPM.a =  Bit.And(0xff, SrcPM.a) + SrcAF *  Bit";
Debug.ShouldStop(32768);
_srcpm.setField ("a",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(_srcpm.getField(true,"a"))),_srcaf,bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(__ref.getField(false,"_temppm").getField(true,"a")))}, "+*",1, 0)));
 };
 BA.debugLineNum = 370;BA.debugLine="SetPremultipliedColor(TargetX, TargetY, SrcPM)";
Debug.ShouldStop(131072);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_setpremultipliedcolor",(Object)(_targetx),(Object)(_targety),(Object)(_srcpm));
 BA.debugLineNum = 371;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Private mBuffer() As Byte";
bitmapcreator._mbuffer = RemoteObject.createNewArray ("byte", new int[] {0}, new Object[]{});__ref.setField("_mbuffer",bitmapcreator._mbuffer);
 //BA.debugLineNum = 4;BA.debugLine="Public mWidth, mHeight As Int";
bitmapcreator._mwidth = RemoteObject.createImmutable(0);__ref.setField("_mwidth",bitmapcreator._mwidth);
bitmapcreator._mheight = RemoteObject.createImmutable(0);__ref.setField("_mheight",bitmapcreator._mheight);
 //BA.debugLineNum = 5;BA.debugLine="Private ai, ri, gi, bi As Int";
bitmapcreator._ai = RemoteObject.createImmutable(0);__ref.setField("_ai",bitmapcreator._ai);
bitmapcreator._ri = RemoteObject.createImmutable(0);__ref.setField("_ri",bitmapcreator._ri);
bitmapcreator._gi = RemoteObject.createImmutable(0);__ref.setField("_gi",bitmapcreator._gi);
bitmapcreator._bi = RemoteObject.createImmutable(0);__ref.setField("_bi",bitmapcreator._bi);
 //BA.debugLineNum = 6;BA.debugLine="Type PremultipliedColor (a As Int, r As Int, g As";
;
 //BA.debugLineNum = 7;BA.debugLine="Type ARGBColor (a As Int, r As Int, g As Int, b A";
;
 //BA.debugLineNum = 8;BA.debugLine="Private tempARGB As ARGBColor";
bitmapcreator._tempargb = RemoteObject.createNew ("b4j.example.bitmapcreator._argbcolor");__ref.setField("_tempargb",bitmapcreator._tempargb);
 //BA.debugLineNum = 9;BA.debugLine="Private tempPM, tempPM2 As PremultipliedColor";
bitmapcreator._temppm = RemoteObject.createNew ("b4j.example.bitmapcreator._premultipliedcolor");__ref.setField("_temppm",bitmapcreator._temppm);
bitmapcreator._temppm2 = RemoteObject.createNew ("b4j.example.bitmapcreator._premultipliedcolor");__ref.setField("_temppm2",bitmapcreator._temppm2);
 //BA.debugLineNum = 13;BA.debugLine="Private WriteableImage As JavaObject";
bitmapcreator._writeableimage = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");__ref.setField("_writeableimage",bitmapcreator._writeableimage);
 //BA.debugLineNum = 15;BA.debugLine="Public TargetRect As B4XRect";
bitmapcreator._targetrect = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XCanvas.B4XRect");__ref.setField("_targetrect",bitmapcreator._targetrect);
 //BA.debugLineNum = 16;BA.debugLine="Private UnsignedFF As Int";
bitmapcreator._unsignedff = RemoteObject.createImmutable(0);__ref.setField("_unsignedff",bitmapcreator._unsignedff);
 //BA.debugLineNum = 17;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _colortoargb(RemoteObject __ref,RemoteObject _clr,RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("ColorToARGB (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,84);
if (RapidSub.canDelegate("colortoargb")) { return __ref.runUserSub(false, "bitmapcreator","colortoargb", __ref, _clr, _result);}
Debug.locals.put("Clr", _clr);
Debug.locals.put("Result", _result);
 BA.debugLineNum = 84;BA.debugLine="Public Sub ColorToARGB (Clr As Int, Result As ARGB";
Debug.ShouldStop(524288);
 BA.debugLineNum = 85;BA.debugLine="Result.a = Bit.And(0xff, Bit.ShiftRight(Clr, 24))";
Debug.ShouldStop(1048576);
_result.setField ("a",bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(bitmapcreator.__c.getField(false,"Bit").runMethod(true,"ShiftRight",(Object)(_clr),(Object)(BA.numberCast(int.class, 24))))));
 BA.debugLineNum = 86;BA.debugLine="Result.r = Bit.And(0xff, Bit.ShiftRight(Clr, 16))";
Debug.ShouldStop(2097152);
_result.setField ("r",bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(bitmapcreator.__c.getField(false,"Bit").runMethod(true,"ShiftRight",(Object)(_clr),(Object)(BA.numberCast(int.class, 16))))));
 BA.debugLineNum = 87;BA.debugLine="Result.g =  Bit.And(0xff, Bit.ShiftRight(Clr, 8))";
Debug.ShouldStop(4194304);
_result.setField ("g",bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(bitmapcreator.__c.getField(false,"Bit").runMethod(true,"ShiftRight",(Object)(_clr),(Object)(BA.numberCast(int.class, 8))))));
 BA.debugLineNum = 88;BA.debugLine="Result.b =  Bit.And(0xff, Clr)";
Debug.ShouldStop(8388608);
_result.setField ("b",bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(_clr)));
 BA.debugLineNum = 89;BA.debugLine="Return Result";
Debug.ShouldStop(16777216);
if (true) return _result;
 BA.debugLineNum = 90;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _copypixel(RemoteObject __ref,RemoteObject _source,RemoteObject _srcx,RemoteObject _srcy,RemoteObject _targetx,RemoteObject _targety) throws Exception{
try {
		Debug.PushSubsStack("CopyPixel (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,341);
if (RapidSub.canDelegate("copypixel")) { return __ref.runUserSub(false, "bitmapcreator","copypixel", __ref, _source, _srcx, _srcy, _targetx, _targety);}
RemoteObject _sourcecp = RemoteObject.createImmutable(0);
RemoteObject _targetcp = RemoteObject.createImmutable(0);
Debug.locals.put("Source", _source);
Debug.locals.put("SrcX", _srcx);
Debug.locals.put("SrcY", _srcy);
Debug.locals.put("TargetX", _targetx);
Debug.locals.put("TargetY", _targety);
 BA.debugLineNum = 341;BA.debugLine="Public Sub CopyPixel (Source As BitmapCreator, Src";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 342;BA.debugLine="Dim SourceCP As Int = SrcX * 4 + SrcY * Source.mW";
Debug.ShouldStop(2097152);
_sourcecp = RemoteObject.solve(new RemoteObject[] {_srcx,RemoteObject.createImmutable(4),_srcy,_source.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "*+**",1, 1);Debug.locals.put("SourceCP", _sourcecp);Debug.locals.put("SourceCP", _sourcecp);
 BA.debugLineNum = 343;BA.debugLine="Dim TargetCP As Int = TargetX * 4 + TargetY * mWi";
Debug.ShouldStop(4194304);
_targetcp = RemoteObject.solve(new RemoteObject[] {_targetx,RemoteObject.createImmutable(4),_targety,__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "*+**",1, 1);Debug.locals.put("TargetCP", _targetcp);Debug.locals.put("TargetCP", _targetcp);
 BA.debugLineNum = 350;BA.debugLine="mBuffer(TargetCP) = Source.mBuffer(SourceCP)";
Debug.ShouldStop(536870912);
__ref.getField(false,"_mbuffer").setArrayElement (_source.getField(false,"_mbuffer").getArrayElement(true,_sourcecp),_targetcp);
 BA.debugLineNum = 351;BA.debugLine="mBuffer(TargetCP + 1) = Source.mBuffer(SourceCP +";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_mbuffer").setArrayElement (_source.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_sourcecp,RemoteObject.createImmutable(1)}, "+",1, 1)),RemoteObject.solve(new RemoteObject[] {_targetcp,RemoteObject.createImmutable(1)}, "+",1, 1));
 BA.debugLineNum = 352;BA.debugLine="mBuffer(TargetCP + 2) = Source.mBuffer(SourceCP +";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_mbuffer").setArrayElement (_source.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_sourcecp,RemoteObject.createImmutable(2)}, "+",1, 1)),RemoteObject.solve(new RemoteObject[] {_targetcp,RemoteObject.createImmutable(2)}, "+",1, 1));
 BA.debugLineNum = 353;BA.debugLine="mBuffer(TargetCP + 3) = Source.mBuffer(SourceCP +";
Debug.ShouldStop(1);
__ref.getField(false,"_mbuffer").setArrayElement (_source.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_sourcecp,RemoteObject.createImmutable(3)}, "+",1, 1)),RemoteObject.solve(new RemoteObject[] {_targetcp,RemoteObject.createImmutable(3)}, "+",1, 1));
 BA.debugLineNum = 355;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _copypixelsfrombitmap(RemoteObject __ref,RemoteObject _sourcebitmap) throws Exception{
try {
		Debug.PushSubsStack("CopyPixelsFromBitmap (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,49);
if (RapidSub.canDelegate("copypixelsfrombitmap")) { return __ref.runUserSub(false, "bitmapcreator","copypixelsfrombitmap", __ref, _sourcebitmap);}
RemoteObject _jo = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _reader = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _pixelformat = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
Debug.locals.put("SourceBitmap", _sourcebitmap);
 BA.debugLineNum = 49;BA.debugLine="Public Sub CopyPixelsFromBitmap (SourceBitmap As B";
Debug.ShouldStop(65536);
 BA.debugLineNum = 50;BA.debugLine="If SourceBitmap.Width <> mWidth Or SourceBitmap.H";
Debug.ShouldStop(131072);
if (RemoteObject.solveBoolean("!",_sourcebitmap.runMethod(true,"getWidth"),BA.numberCast(double.class, __ref.getField(true,"_mwidth"))) || RemoteObject.solveBoolean("!",_sourcebitmap.runMethod(true,"getHeight"),BA.numberCast(double.class, __ref.getField(true,"_mheight")))) { 
 BA.debugLineNum = 51;BA.debugLine="SourceBitmap = SourceBitmap.Resize(mWidth, mHeig";
Debug.ShouldStop(262144);
_sourcebitmap = _sourcebitmap.runMethod(false,"Resize",(Object)(__ref.getField(true,"_mwidth")),(Object)(__ref.getField(true,"_mheight")),(Object)(bitmapcreator.__c.getField(true,"False")));Debug.locals.put("SourceBitmap", _sourcebitmap);
 };
 BA.debugLineNum = 64;BA.debugLine="Dim jo As JavaObject = SourceBitmap";
Debug.ShouldStop(-2147483648);
_jo = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_jo.setObject(_sourcebitmap.getObject());Debug.locals.put("jo", _jo);
 BA.debugLineNum = 65;BA.debugLine="Dim reader As JavaObject = jo.RunMethod(\"getPixel";
Debug.ShouldStop(1);
_reader = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_reader.setObject(_jo.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getPixelReader")),(Object)((bitmapcreator.__c.getField(false,"Null")))));Debug.locals.put("reader", _reader);
 BA.debugLineNum = 66;BA.debugLine="Dim PixelFormat As JavaObject";
Debug.ShouldStop(2);
_pixelformat = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("PixelFormat", _pixelformat);
 BA.debugLineNum = 67;BA.debugLine="PixelFormat.InitializeStatic(\"javafx.scene.image.";
Debug.ShouldStop(4);
_pixelformat.runVoidMethod ("InitializeStatic",(Object)(RemoteObject.createImmutable("javafx.scene.image.PixelFormat")));
 BA.debugLineNum = 68;BA.debugLine="reader.RunMethod(\"getPixels\", Array(0, 0, mWidth,";
Debug.ShouldStop(8);
_reader.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("getPixels")),(Object)(RemoteObject.createNewArray("Object",new int[] {8},new Object[] {RemoteObject.createImmutable((0)),RemoteObject.createImmutable((0)),(__ref.getField(true,"_mwidth")),(__ref.getField(true,"_mheight")),_pixelformat.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getByteBgraPreInstance")),(Object)((bitmapcreator.__c.getField(false,"Null")))),(__ref.getField(false,"_mbuffer")),RemoteObject.createImmutable((0)),(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "*",0, 1))})));
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
public static RemoteObject  _drawbitmap(RemoteObject __ref,RemoteObject _bmp,RemoteObject _targetrect1,RemoteObject _skipblending) throws Exception{
try {
		Debug.PushSubsStack("DrawBitmap (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,273);
if (RapidSub.canDelegate("drawbitmap")) { return __ref.runUserSub(false, "bitmapcreator","drawbitmap", __ref, _bmp, _targetrect1, _skipblending);}
RemoteObject _src = RemoteObject.declareNull("b4j.example.bitmapcreator");
RemoteObject _srcrect = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XCanvas.B4XRect");
Debug.locals.put("Bmp", _bmp);
Debug.locals.put("TargetRect1", _targetrect1);
Debug.locals.put("SkipBlending", _skipblending);
 BA.debugLineNum = 273;BA.debugLine="Public Sub DrawBitmap (Bmp As B4XBitmap, TargetRec";
Debug.ShouldStop(65536);
 BA.debugLineNum = 274;BA.debugLine="If Bmp.Width <> TargetRect1.Width Or Bmp.Height <";
Debug.ShouldStop(131072);
if (RemoteObject.solveBoolean("!",_bmp.runMethod(true,"getWidth"),BA.numberCast(double.class, _targetrect1.runMethod(true,"getWidth"))) || RemoteObject.solveBoolean("!",_bmp.runMethod(true,"getHeight"),BA.numberCast(double.class, _targetrect1.runMethod(true,"getHeight")))) { 
 BA.debugLineNum = 275;BA.debugLine="Bmp = Bmp.Resize(TargetRect1.Width, TargetRect1.";
Debug.ShouldStop(262144);
_bmp = _bmp.runMethod(false,"Resize",(Object)(BA.numberCast(int.class, _targetrect1.runMethod(true,"getWidth"))),(Object)(BA.numberCast(int.class, _targetrect1.runMethod(true,"getHeight"))),(Object)(bitmapcreator.__c.getField(true,"False")));Debug.locals.put("Bmp", _bmp);
 };
 BA.debugLineNum = 277;BA.debugLine="Dim Src As BitmapCreator";
Debug.ShouldStop(1048576);
_src = RemoteObject.createNew ("b4j.example.bitmapcreator");Debug.locals.put("Src", _src);
 BA.debugLineNum = 278;BA.debugLine="Src.Initialize(Bmp.Width, Bmp.Height)";
Debug.ShouldStop(2097152);
_src.runClassMethod (b4j.example.bitmapcreator.class, "_initialize",__ref.getField(false, "ba"),(Object)(BA.numberCast(int.class, _bmp.runMethod(true,"getWidth"))),(Object)(BA.numberCast(int.class, _bmp.runMethod(true,"getHeight"))));
 BA.debugLineNum = 279;BA.debugLine="Src.CopyPixelsFromBitmap(Bmp)";
Debug.ShouldStop(4194304);
_src.runClassMethod (b4j.example.bitmapcreator.class, "_copypixelsfrombitmap",(Object)(_bmp));
 BA.debugLineNum = 280;BA.debugLine="Dim SrcRect As B4XRect";
Debug.ShouldStop(8388608);
_srcrect = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XCanvas.B4XRect");Debug.locals.put("SrcRect", _srcrect);
 BA.debugLineNum = 281;BA.debugLine="SrcRect.Initialize(0, 0, Src.mWidth, Src.mHeight)";
Debug.ShouldStop(16777216);
_srcrect.runVoidMethod ("Initialize",(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, _src.getField(true,"_mwidth"))),(Object)(BA.numberCast(float.class, _src.getField(true,"_mheight"))));
 BA.debugLineNum = 282;BA.debugLine="DrawBitmapCreator(Src, SrcRect, TargetRect1.Left,";
Debug.ShouldStop(33554432);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_drawbitmapcreator",(Object)(_src),(Object)(_srcrect),(Object)(BA.numberCast(int.class, _targetrect1.runMethod(true,"getLeft"))),(Object)(BA.numberCast(int.class, _targetrect1.runMethod(true,"getTop"))),(Object)(_skipblending));
 BA.debugLineNum = 283;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _drawbitmapcreator(RemoteObject __ref,RemoteObject _source,RemoteObject _srcrect,RemoteObject _targetx,RemoteObject _targety,RemoteObject _skipblending) throws Exception{
try {
		Debug.PushSubsStack("DrawBitmapCreator (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,290);
if (RapidSub.canDelegate("drawbitmapcreator")) { return __ref.runUserSub(false, "bitmapcreator","drawbitmapcreator", __ref, _source, _srcrect, _targetx, _targety, _skipblending);}
RemoteObject _deltax = RemoteObject.createImmutable(0);
RemoteObject _deltay = RemoteObject.createImmutable(0);
RemoteObject _srctop = RemoteObject.createImmutable(0);
RemoteObject _srcleft = RemoteObject.createImmutable(0);
int _y = 0;
int _x = 0;
Debug.locals.put("Source", _source);
Debug.locals.put("SrcRect", _srcrect);
Debug.locals.put("TargetX", _targetx);
Debug.locals.put("TargetY", _targety);
Debug.locals.put("SkipBlending", _skipblending);
 BA.debugLineNum = 290;BA.debugLine="Public Sub DrawBitmapCreator (Source As BitmapCrea";
Debug.ShouldStop(2);
 BA.debugLineNum = 291;BA.debugLine="If TargetY >= mHeight Or TargetX >= mWidth Then R";
Debug.ShouldStop(4);
if (RemoteObject.solveBoolean("g",_targety,BA.numberCast(double.class, __ref.getField(true,"_mheight"))) || RemoteObject.solveBoolean("g",_targetx,BA.numberCast(double.class, __ref.getField(true,"_mwidth")))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 292;BA.debugLine="TargetX = Max(0, TargetX)";
Debug.ShouldStop(8);
_targetx = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, _targetx))));Debug.locals.put("TargetX", _targetx);
 BA.debugLineNum = 293;BA.debugLine="TargetY = Max(0, TargetY)";
Debug.ShouldStop(16);
_targety = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, _targety))));Debug.locals.put("TargetY", _targety);
 BA.debugLineNum = 294;BA.debugLine="Dim DeltaX As Int = Min(mWidth - 1 - TargetX, Min";
Debug.ShouldStop(32);
_deltax = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(1),_targetx}, "--",2, 1))),(Object)(bitmapcreator.__c.runMethod(true,"Min",(Object)(RemoteObject.solve(new RemoteObject[] {_srcrect.runMethod(true,"getWidth"),RemoteObject.createImmutable(1)}, "-",1, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {_source.getField(true,"_mwidth"),RemoteObject.createImmutable(1),_srcrect.runMethod(true,"getLeft")}, "--",2, 0))))));Debug.locals.put("DeltaX", _deltax);Debug.locals.put("DeltaX", _deltax);
 BA.debugLineNum = 295;BA.debugLine="Dim DeltaY As Int = Min(mHeight - 1 - TargetY, Mi";
Debug.ShouldStop(64);
_deltay = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mheight"),RemoteObject.createImmutable(1),_targety}, "--",2, 1))),(Object)(bitmapcreator.__c.runMethod(true,"Min",(Object)(RemoteObject.solve(new RemoteObject[] {_srcrect.runMethod(true,"getHeight"),RemoteObject.createImmutable(1)}, "-",1, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {_source.getField(true,"_mheight"),RemoteObject.createImmutable(1),_srcrect.runMethod(true,"getTop")}, "--",2, 0))))));Debug.locals.put("DeltaY", _deltay);Debug.locals.put("DeltaY", _deltay);
 BA.debugLineNum = 296;BA.debugLine="Dim SrcTop As Int = SrcRect.Top";
Debug.ShouldStop(128);
_srctop = BA.numberCast(int.class, _srcrect.runMethod(true,"getTop"));Debug.locals.put("SrcTop", _srctop);Debug.locals.put("SrcTop", _srctop);
 BA.debugLineNum = 297;BA.debugLine="Dim SrcLeft As Int = SrcRect.Left";
Debug.ShouldStop(256);
_srcleft = BA.numberCast(int.class, _srcrect.runMethod(true,"getLeft"));Debug.locals.put("SrcLeft", _srcleft);Debug.locals.put("SrcLeft", _srcleft);
 BA.debugLineNum = 298;BA.debugLine="If SkipBlending Then";
Debug.ShouldStop(512);
if (_skipblending.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 300;BA.debugLine="For y = TargetY To TargetY + DeltaY";
Debug.ShouldStop(2048);
{
final int step9 = 1;
final int limit9 = RemoteObject.solve(new RemoteObject[] {_targety,_deltay}, "+",1, 1).<Integer>get().intValue();
_y = _targety.<Integer>get().intValue() ;
for (;(step9 > 0 && _y <= limit9) || (step9 < 0 && _y >= limit9) ;_y = ((int)(0 + _y + step9))  ) {
Debug.locals.put("y", _y);
 BA.debugLineNum = 301;BA.debugLine="Bit.ArrayCopy(Source.mBuffer, SrcLeft * 4 + (y";
Debug.ShouldStop(4096);
bitmapcreator.__c.getField(false,"Bit").runVoidMethod ("ArrayCopy",(Object)((_source.getField(false,"_mbuffer"))),(Object)(RemoteObject.solve(new RemoteObject[] {_srcleft,RemoteObject.createImmutable(4),(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_y),_targety,_srctop}, "-+",2, 1)),RemoteObject.createImmutable(4),_source.getField(true,"_mwidth")}, "*+**",1, 1)),(Object)((__ref.getField(false,"_mbuffer"))),(Object)(RemoteObject.solve(new RemoteObject[] {_targetx,RemoteObject.createImmutable(4),RemoteObject.createImmutable(_y),RemoteObject.createImmutable(4),__ref.getField(true,"_mwidth")}, "*+**",1, 1)),(Object)(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_deltax,RemoteObject.createImmutable(1)}, "+",1, 1)),RemoteObject.createImmutable(4)}, "*",0, 1)));
 }
}Debug.locals.put("y", _y);
;
 }else {
 BA.debugLineNum = 305;BA.debugLine="For x = TargetX To TargetX + DeltaX";
Debug.ShouldStop(65536);
{
final int step13 = 1;
final int limit13 = RemoteObject.solve(new RemoteObject[] {_targetx,_deltax}, "+",1, 1).<Integer>get().intValue();
_x = _targetx.<Integer>get().intValue() ;
for (;(step13 > 0 && _x <= limit13) || (step13 < 0 && _x >= limit13) ;_x = ((int)(0 + _x + step13))  ) {
Debug.locals.put("x", _x);
 BA.debugLineNum = 306;BA.debugLine="For y = TargetY To TargetY + DeltaY";
Debug.ShouldStop(131072);
{
final int step14 = 1;
final int limit14 = RemoteObject.solve(new RemoteObject[] {_targety,_deltay}, "+",1, 1).<Integer>get().intValue();
_y = _targety.<Integer>get().intValue() ;
for (;(step14 > 0 && _y <= limit14) || (step14 < 0 && _y >= limit14) ;_y = ((int)(0 + _y + step14))  ) {
Debug.locals.put("y", _y);
 BA.debugLineNum = 332;BA.debugLine="BlendPixel(Source, x - TargetX + SrcRect.Left,";
Debug.ShouldStop(2048);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_blendpixel",(Object)(_source),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_x),_targetx,_srcrect.runMethod(true,"getLeft")}, "-+",2, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_y),_targety,_srcrect.runMethod(true,"getTop")}, "-+",2, 0))),(Object)(BA.numberCast(int.class, _x)),(Object)(BA.numberCast(int.class, _y)));
 }
}Debug.locals.put("y", _y);
;
 }
}Debug.locals.put("x", _x);
;
 };
 BA.debugLineNum = 338;BA.debugLine="End Sub";
Debug.ShouldStop(131072);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fillgradient(RemoteObject __ref,RemoteObject _gradcolors,RemoteObject _rect,RemoteObject _orientation) throws Exception{
try {
		Debug.PushSubsStack("FillGradient (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,377);
if (RapidSub.canDelegate("fillgradient")) { return __ref.runUserSub(false, "bitmapcreator","fillgradient", __ref, _gradcolors, _rect, _orientation);}
RemoteObject _sinl = RemoteObject.createImmutable(0f);
RemoteObject _starty = RemoteObject.createImmutable(0);
RemoteObject _endy = RemoteObject.createImmutable(0);
RemoteObject _ox = RemoteObject.createImmutable(0f);
RemoteObject _deltaox = RemoteObject.createImmutable(0f);
RemoteObject _axislength = RemoteObject.createImmutable(0);
RemoteObject _topbottom = RemoteObject.createImmutable(false);
RemoteObject _oppositecolors = RemoteObject.createImmutable(false);
RemoteObject _tr_bl = RemoteObject.createImmutable(false);
RemoteObject _rectangle = RemoteObject.createImmutable(false);
RemoteObject _numberofparts = RemoteObject.createImmutable(0);
RemoteObject _dfix = null;
RemoteObject _dfixdivsinl = null;
RemoteObject _alpha = RemoteObject.createImmutable(0f);
RemoteObject _tanl = RemoteObject.createImmutable(0f);
RemoteObject _rgbcolor = null;
int _i = 0;
RemoteObject _a = RemoteObject.createImmutable(0);
RemoteObject _endmax = RemoteObject.createImmutable(0);
RemoteObject _startmin = RemoteObject.createImmutable(0);
RemoteObject _clrfrom = RemoteObject.declareNull("b4j.example.bitmapcreator._argbcolor");
RemoteObject _clrto = RemoteObject.declareNull("b4j.example.bitmapcreator._argbcolor");
RemoteObject _argb = RemoteObject.declareNull("b4j.example.bitmapcreator._argbcolor");
RemoteObject _tstartx = RemoteObject.createImmutable(0);
RemoteObject _tendx = RemoteObject.createImmutable(0);
RemoteObject _tstep = RemoteObject.createImmutable(0);
RemoteObject _cx = RemoteObject.createImmutable(0);
RemoteObject _cy = RemoteObject.createImmutable(0);
RemoteObject _xfix = RemoteObject.createImmutable(0f);
RemoteObject _yfix = RemoteObject.createImmutable(0f);
int _part = 0;
int _r = 0;
RemoteObject _dd = RemoteObject.createImmutable(0f);
int _x = 0;
int _y = 0;
RemoteObject _endx = RemoteObject.createImmutable(0);
RemoteObject _d = RemoteObject.createImmutable(0f);
RemoteObject _startx = RemoteObject.createImmutable(0);
RemoteObject _dddelta = RemoteObject.createImmutable(0f);
Debug.locals.put("GradColors", _gradcolors);
Debug.locals.put("Rect", _rect);
Debug.locals.put("Orientation", _orientation);
 BA.debugLineNum = 377;BA.debugLine="Public Sub FillGradient (GradColors() As Int, Rect";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 378;BA.debugLine="If Rect.Width <= 1 Or Rect.Height <= 1 Or Rect.Le";
Debug.ShouldStop(33554432);
if (RemoteObject.solveBoolean("k",_rect.runMethod(true,"getWidth"),BA.numberCast(double.class, 1)) || RemoteObject.solveBoolean("k",_rect.runMethod(true,"getHeight"),BA.numberCast(double.class, 1)) || RemoteObject.solveBoolean("g",_rect.runMethod(true,"getLeft"),BA.numberCast(double.class, __ref.getField(true,"_mwidth"))) || RemoteObject.solveBoolean("g",_rect.runMethod(true,"getTop"),BA.numberCast(double.class, __ref.getField(true,"_mheight")))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 379;BA.debugLine="If GradColors.Length = 1 Then";
Debug.ShouldStop(67108864);
if (RemoteObject.solveBoolean("=",_gradcolors.getField(true,"length"),BA.numberCast(double.class, 1))) { 
 BA.debugLineNum = 380;BA.debugLine="FillRect(GradColors(0), Rect)";
Debug.ShouldStop(134217728);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_fillrect",(Object)(_gradcolors.getArrayElement(true,BA.numberCast(int.class, 0))),(Object)(_rect));
 BA.debugLineNum = 381;BA.debugLine="Return";
Debug.ShouldStop(268435456);
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 383;BA.debugLine="Dim SinL As Float";
Debug.ShouldStop(1073741824);
_sinl = RemoteObject.createImmutable(0f);Debug.locals.put("SinL", _sinl);
 BA.debugLineNum = 384;BA.debugLine="Dim StartY As Int = Max(Rect.Top, 0)";
Debug.ShouldStop(-2147483648);
_starty = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, _rect.runMethod(true,"getTop"))),(Object)(BA.numberCast(double.class, 0))));Debug.locals.put("StartY", _starty);Debug.locals.put("StartY", _starty);
 BA.debugLineNum = 385;BA.debugLine="Dim EndY As Int = Min(Rect.Bottom - 1, mHeight -";
Debug.ShouldStop(1);
_endy = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Min",(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getBottom"),RemoteObject.createImmutable(1)}, "-",1, 0)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mheight"),RemoteObject.createImmutable(1)}, "-",1, 1)))));Debug.locals.put("EndY", _endy);Debug.locals.put("EndY", _endy);
 BA.debugLineNum = 386;BA.debugLine="Dim ox, deltaox As Float";
Debug.ShouldStop(2);
_ox = RemoteObject.createImmutable(0f);Debug.locals.put("ox", _ox);
_deltaox = RemoteObject.createImmutable(0f);Debug.locals.put("deltaox", _deltaox);
 BA.debugLineNum = 387;BA.debugLine="Dim AxisLength As Int";
Debug.ShouldStop(4);
_axislength = RemoteObject.createImmutable(0);Debug.locals.put("AxisLength", _axislength);
 BA.debugLineNum = 388;BA.debugLine="Dim TopBottom As Boolean";
Debug.ShouldStop(8);
_topbottom = RemoteObject.createImmutable(false);Debug.locals.put("TopBottom", _topbottom);
 BA.debugLineNum = 389;BA.debugLine="Dim OppositeColors As Boolean";
Debug.ShouldStop(16);
_oppositecolors = RemoteObject.createImmutable(false);Debug.locals.put("OppositeColors", _oppositecolors);
 BA.debugLineNum = 390;BA.debugLine="Dim TR_BL As Boolean";
Debug.ShouldStop(32);
_tr_bl = RemoteObject.createImmutable(false);Debug.locals.put("TR_BL", _tr_bl);
 BA.debugLineNum = 391;BA.debugLine="Dim Rectangle As Boolean";
Debug.ShouldStop(64);
_rectangle = RemoteObject.createImmutable(false);Debug.locals.put("Rectangle", _rectangle);
 BA.debugLineNum = 392;BA.debugLine="Dim NumberOfParts As Int = GradColors.Length - 1";
Debug.ShouldStop(128);
_numberofparts = RemoteObject.solve(new RemoteObject[] {_gradcolors.getField(true,"length"),RemoteObject.createImmutable(1)}, "-",1, 1);Debug.locals.put("NumberOfParts", _numberofparts);Debug.locals.put("NumberOfParts", _numberofparts);
 BA.debugLineNum = 393;BA.debugLine="Dim DFix(NumberOfParts + 1) As Float";
Debug.ShouldStop(256);
_dfix = RemoteObject.createNewArray ("float", new int[] {RemoteObject.solve(new RemoteObject[] {_numberofparts,RemoteObject.createImmutable(1)}, "+",1, 1).<Integer>get().intValue()}, new Object[]{});Debug.locals.put("DFix", _dfix);
 BA.debugLineNum = 394;BA.debugLine="Dim DFixDivSinL(NumberOfParts + 1) As Float";
Debug.ShouldStop(512);
_dfixdivsinl = RemoteObject.createNewArray ("float", new int[] {RemoteObject.solve(new RemoteObject[] {_numberofparts,RemoteObject.createImmutable(1)}, "+",1, 1).<Integer>get().intValue()}, new Object[]{});Debug.locals.put("DFixDivSinL", _dfixdivsinl);
 BA.debugLineNum = 395;BA.debugLine="Select Orientation";
Debug.ShouldStop(1024);
switch (BA.switchObjectToInt(_orientation,BA.ObjectToString("TL_BR"),BA.ObjectToString("BR_TL"),BA.ObjectToString("TR_BL"),BA.ObjectToString("BL_TR"),BA.ObjectToString("LEFT_RIGHT"),BA.ObjectToString("RIGHT_LEFT"),BA.ObjectToString("TOP_BOTTOM"),BA.ObjectToString("BOTTOM_TOP"),BA.ObjectToString("RECTANGLE"))) {
case 0: 
case 1: 
case 2: 
case 3: {
 BA.debugLineNum = 397;BA.debugLine="Dim alpha As Float = ATanD(Rect.Width / Rect.He";
Debug.ShouldStop(4096);
_alpha = BA.numberCast(float.class, bitmapcreator.__c.runMethod(true,"ATanD",(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getWidth"),_rect.runMethod(true,"getHeight")}, "/",0, 0))));Debug.locals.put("alpha", _alpha);Debug.locals.put("alpha", _alpha);
 BA.debugLineNum = 398;BA.debugLine="SinL = SinD(alpha)";
Debug.ShouldStop(8192);
_sinl = BA.numberCast(float.class, bitmapcreator.__c.runMethod(true,"SinD",(Object)(BA.numberCast(double.class, _alpha))));Debug.locals.put("SinL", _sinl);
 BA.debugLineNum = 399;BA.debugLine="AxisLength = Sqrt(Power(Rect.Width, 2) + Power(";
Debug.ShouldStop(16384);
_axislength = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Sqrt",(Object)(RemoteObject.solve(new RemoteObject[] {bitmapcreator.__c.runMethod(true,"Power",(Object)(BA.numberCast(double.class, _rect.runMethod(true,"getWidth"))),(Object)(BA.numberCast(double.class, 2))),bitmapcreator.__c.runMethod(true,"Power",(Object)(BA.numberCast(double.class, _rect.runMethod(true,"getHeight"))),(Object)(BA.numberCast(double.class, 2)))}, "+",1, 0))));Debug.locals.put("AxisLength", _axislength);
 BA.debugLineNum = 400;BA.debugLine="Dim TanL As Float = TanD(alpha)";
Debug.ShouldStop(32768);
_tanl = BA.numberCast(float.class, bitmapcreator.__c.runMethod(true,"TanD",(Object)(BA.numberCast(double.class, _alpha))));Debug.locals.put("TanL", _tanl);Debug.locals.put("TanL", _tanl);
 BA.debugLineNum = 401;BA.debugLine="deltaox = 1 / TanL";
Debug.ShouldStop(65536);
_deltaox = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_tanl}, "/",0, 0));Debug.locals.put("deltaox", _deltaox);
 BA.debugLineNum = 402;BA.debugLine="ox = (StartY - Rect.Top) / TanL";
Debug.ShouldStop(131072);
_ox = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_starty,_rect.runMethod(true,"getTop")}, "-",1, 0)),_tanl}, "/",0, 0));Debug.locals.put("ox", _ox);
 BA.debugLineNum = 403;BA.debugLine="OppositeColors = Orientation = \"BR_TL\" Or Orien";
Debug.ShouldStop(262144);
_oppositecolors = BA.ObjectToBoolean(RemoteObject.solveBoolean("=",_orientation,BA.ObjectToString("BR_TL")) || RemoteObject.solveBoolean("=",_orientation,BA.ObjectToString("BL_TR")));Debug.locals.put("OppositeColors", _oppositecolors);
 BA.debugLineNum = 404;BA.debugLine="TR_BL = Orientation = \"TR_BL\" Or Orientation =";
Debug.ShouldStop(524288);
_tr_bl = BA.ObjectToBoolean(RemoteObject.solveBoolean("=",_orientation,BA.ObjectToString("TR_BL")) || RemoteObject.solveBoolean("=",_orientation,BA.ObjectToString("BL_TR")));Debug.locals.put("TR_BL", _tr_bl);
 break; }
case 4: 
case 5: {
 BA.debugLineNum = 406;BA.debugLine="AxisLength = Rect.Width";
Debug.ShouldStop(2097152);
_axislength = BA.numberCast(int.class, _rect.runMethod(true,"getWidth"));Debug.locals.put("AxisLength", _axislength);
 BA.debugLineNum = 407;BA.debugLine="deltaox = 0";
Debug.ShouldStop(4194304);
_deltaox = BA.numberCast(float.class, 0);Debug.locals.put("deltaox", _deltaox);
 BA.debugLineNum = 408;BA.debugLine="SinL = 1";
Debug.ShouldStop(8388608);
_sinl = BA.numberCast(float.class, 1);Debug.locals.put("SinL", _sinl);
 BA.debugLineNum = 409;BA.debugLine="OppositeColors = Orientation = \"RIGHT_LEFT\"";
Debug.ShouldStop(16777216);
_oppositecolors = BA.ObjectToBoolean(RemoteObject.solveBoolean("=",_orientation,BA.ObjectToString("RIGHT_LEFT")));Debug.locals.put("OppositeColors", _oppositecolors);
 break; }
case 6: 
case 7: {
 BA.debugLineNum = 411;BA.debugLine="AxisLength = Rect.Height";
Debug.ShouldStop(67108864);
_axislength = BA.numberCast(int.class, _rect.runMethod(true,"getHeight"));Debug.locals.put("AxisLength", _axislength);
 BA.debugLineNum = 412;BA.debugLine="SinL = 0";
Debug.ShouldStop(134217728);
_sinl = BA.numberCast(float.class, 0);Debug.locals.put("SinL", _sinl);
 BA.debugLineNum = 413;BA.debugLine="ox = 0";
Debug.ShouldStop(268435456);
_ox = BA.numberCast(float.class, 0);Debug.locals.put("ox", _ox);
 BA.debugLineNum = 414;BA.debugLine="TopBottom = True";
Debug.ShouldStop(536870912);
_topbottom = bitmapcreator.__c.getField(true,"True");Debug.locals.put("TopBottom", _topbottom);
 BA.debugLineNum = 415;BA.debugLine="OppositeColors = Orientation = \"BOTTOM_TOP\"";
Debug.ShouldStop(1073741824);
_oppositecolors = BA.ObjectToBoolean(RemoteObject.solveBoolean("=",_orientation,BA.ObjectToString("BOTTOM_TOP")));Debug.locals.put("OppositeColors", _oppositecolors);
 break; }
case 8: {
 BA.debugLineNum = 417;BA.debugLine="AxisLength = Max(Rect.Width, Rect.Height) / 2";
Debug.ShouldStop(1);
_axislength = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {bitmapcreator.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, _rect.runMethod(true,"getWidth"))),(Object)(BA.numberCast(double.class, _rect.runMethod(true,"getHeight")))),RemoteObject.createImmutable(2)}, "/",0, 0));Debug.locals.put("AxisLength", _axislength);
 BA.debugLineNum = 418;BA.debugLine="Rectangle = True";
Debug.ShouldStop(2);
_rectangle = bitmapcreator.__c.getField(true,"True");Debug.locals.put("Rectangle", _rectangle);
 break; }
default: {
 BA.debugLineNum = 420;BA.debugLine="Log(\"Invalid orientation: \" & Orientation)";
Debug.ShouldStop(8);
bitmapcreator.__c.runVoidMethod ("Log",(Object)(RemoteObject.concat(RemoteObject.createImmutable("Invalid orientation: "),_orientation)));
 break; }
}
;
 BA.debugLineNum = 423;BA.debugLine="Dim RGBColor(GradColors.Length) As ARGBColor";
Debug.ShouldStop(64);
_rgbcolor = RemoteObject.createNewArray ("b4j.example.bitmapcreator._argbcolor", new int[] {_gradcolors.getField(true,"length").<Integer>get().intValue()}, new Object[]{});Debug.locals.put("RGBColor", _rgbcolor);
 BA.debugLineNum = 424;BA.debugLine="For i = 0 To GradColors.Length - 1";
Debug.ShouldStop(128);
{
final int step46 = 1;
final int limit46 = RemoteObject.solve(new RemoteObject[] {_gradcolors.getField(true,"length"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step46 > 0 && _i <= limit46) || (step46 < 0 && _i >= limit46) ;_i = ((int)(0 + _i + step46))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 425;BA.debugLine="Dim a As Int = i";
Debug.ShouldStop(256);
_a = BA.numberCast(int.class, _i);Debug.locals.put("a", _a);Debug.locals.put("a", _a);
 BA.debugLineNum = 426;BA.debugLine="If OppositeColors Then a = GradColors.Length - 1";
Debug.ShouldStop(512);
if (_oppositecolors.<Boolean>get().booleanValue()) { 
_a = RemoteObject.solve(new RemoteObject[] {_gradcolors.getField(true,"length"),RemoteObject.createImmutable(1),RemoteObject.createImmutable(_i)}, "--",2, 1);Debug.locals.put("a", _a);};
 BA.debugLineNum = 427;BA.debugLine="ColorToARGB(GradColors(a), RGBColor(i))";
Debug.ShouldStop(1024);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_colortoargb",(Object)(_gradcolors.getArrayElement(true,_a)),(Object)(_rgbcolor.getArrayElement(false,BA.numberCast(int.class, _i))));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 430;BA.debugLine="For i = 0 To NumberOfParts";
Debug.ShouldStop(8192);
{
final int step51 = 1;
final int limit51 = _numberofparts.<Integer>get().intValue();
_i = 0 ;
for (;(step51 > 0 && _i <= limit51) || (step51 < 0 && _i >= limit51) ;_i = ((int)(0 + _i + step51))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 431;BA.debugLine="DFix(i) = i / NumberOfParts * AxisLength";
Debug.ShouldStop(16384);
_dfix.setArrayElement (BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_i),_numberofparts,_axislength}, "/*",0, 0)),BA.numberCast(int.class, _i));
 BA.debugLineNum = 432;BA.debugLine="DFixDivSinL(i) = DFix(i) / SinL";
Debug.ShouldStop(32768);
_dfixdivsinl.setArrayElement (BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_dfix.getArrayElement(true,BA.numberCast(int.class, _i)),_sinl}, "/",0, 0)),BA.numberCast(int.class, _i));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 434;BA.debugLine="Dim EndMax As Int = Min(mWidth - 1, Rect.Right -";
Debug.ShouldStop(131072);
_endmax = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(1)}, "-",1, 1))),(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getRight"),RemoteObject.createImmutable(1)}, "-",1, 0))));Debug.locals.put("EndMax", _endmax);Debug.locals.put("EndMax", _endmax);
 BA.debugLineNum = 435;BA.debugLine="Dim StartMin As Int = Max(Rect.Left, 0)";
Debug.ShouldStop(262144);
_startmin = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, _rect.runMethod(true,"getLeft"))),(Object)(BA.numberCast(double.class, 0))));Debug.locals.put("StartMin", _startmin);Debug.locals.put("StartMin", _startmin);
 BA.debugLineNum = 436;BA.debugLine="Dim ClrFrom, ClrTo As ARGBColor";
Debug.ShouldStop(524288);
_clrfrom = RemoteObject.createNew ("b4j.example.bitmapcreator._argbcolor");Debug.locals.put("ClrFrom", _clrfrom);
_clrto = RemoteObject.createNew ("b4j.example.bitmapcreator._argbcolor");Debug.locals.put("ClrTo", _clrto);
 BA.debugLineNum = 437;BA.debugLine="Dim argb As ARGBColor";
Debug.ShouldStop(1048576);
_argb = RemoteObject.createNew ("b4j.example.bitmapcreator._argbcolor");Debug.locals.put("argb", _argb);
 BA.debugLineNum = 438;BA.debugLine="Dim tStartX, tEndX, tStep = 1 As Int";
Debug.ShouldStop(2097152);
_tstartx = RemoteObject.createImmutable(0);Debug.locals.put("tStartX", _tstartx);
_tendx = RemoteObject.createImmutable(0);Debug.locals.put("tEndX", _tendx);
_tstep = BA.numberCast(int.class, 1);Debug.locals.put("tStep", _tstep);Debug.locals.put("tStep", _tstep);
 BA.debugLineNum = 439;BA.debugLine="If Rectangle Then";
Debug.ShouldStop(4194304);
if (_rectangle.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 440;BA.debugLine="Dim cx As Int = Rect.CenterX";
Debug.ShouldStop(8388608);
_cx = BA.numberCast(int.class, _rect.runMethod(true,"getCenterX"));Debug.locals.put("cx", _cx);Debug.locals.put("cx", _cx);
 BA.debugLineNum = 441;BA.debugLine="Dim cy As Int = Rect.CenterY";
Debug.ShouldStop(16777216);
_cy = BA.numberCast(int.class, _rect.runMethod(true,"getCenterY"));Debug.locals.put("cy", _cy);Debug.locals.put("cy", _cy);
 BA.debugLineNum = 442;BA.debugLine="Dim XFix = Min(1, Rect.Width / Rect.Height), YFi";
Debug.ShouldStop(33554432);
_xfix = BA.numberCast(float.class, bitmapcreator.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, 1)),(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getWidth"),_rect.runMethod(true,"getHeight")}, "/",0, 0))));Debug.locals.put("XFix", _xfix);Debug.locals.put("XFix", _xfix);
_yfix = BA.numberCast(float.class, bitmapcreator.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, 1)),(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getHeight"),_rect.runMethod(true,"getWidth")}, "/",0, 0))));Debug.locals.put("YFix", _yfix);Debug.locals.put("YFix", _yfix);
 BA.debugLineNum = 443;BA.debugLine="For part = 0 To NumberOfParts - 1";
Debug.ShouldStop(67108864);
{
final int step64 = 1;
final int limit64 = RemoteObject.solve(new RemoteObject[] {_numberofparts,RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_part = 0 ;
for (;(step64 > 0 && _part <= limit64) || (step64 < 0 && _part >= limit64) ;_part = ((int)(0 + _part + step64))  ) {
Debug.locals.put("part", _part);
 BA.debugLineNum = 444;BA.debugLine="ClrFrom = RGBColor(part)";
Debug.ShouldStop(134217728);
_clrfrom = _rgbcolor.getArrayElement(false,BA.numberCast(int.class, _part));Debug.locals.put("ClrFrom", _clrfrom);
 BA.debugLineNum = 445;BA.debugLine="ClrTo = RGBColor(part + 1)";
Debug.ShouldStop(268435456);
_clrto = _rgbcolor.getArrayElement(false,RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_part),RemoteObject.createImmutable(1)}, "+",1, 1));Debug.locals.put("ClrTo", _clrto);
 BA.debugLineNum = 446;BA.debugLine="For r = part / NumberOfParts * AxisLength To (p";
Debug.ShouldStop(536870912);
{
final int step67 = 1;
final int limit67 = (int) (0 + RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_part),RemoteObject.createImmutable(1)}, "+",1, 1)),_numberofparts,_axislength}, "/*",0, 0).<Double>get().doubleValue());
_r = (int) (0 + RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_part),_numberofparts,_axislength}, "/*",0, 0).<Double>get().doubleValue()) ;
for (;(step67 > 0 && _r <= limit67) || (step67 < 0 && _r >= limit67) ;_r = ((int)(0 + _r + step67))  ) {
Debug.locals.put("r", _r);
 BA.debugLineNum = 447;BA.debugLine="Dim dd As Float = (r - DFix(part)) / (AxisLeng";
Debug.ShouldStop(1073741824);
_dd = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_r),_dfix.getArrayElement(true,BA.numberCast(int.class, _part))}, "-",1, 0)),(RemoteObject.solve(new RemoteObject[] {_axislength,_numberofparts}, "/",0, 0))}, "/",0, 0));Debug.locals.put("dd", _dd);Debug.locals.put("dd", _dd);
 BA.debugLineNum = 448;BA.debugLine="For x = -r To r";
Debug.ShouldStop(-2147483648);
{
final int step69 = 1;
final int limit69 = _r;
_x = (int) (0 + -(double) (0 + _r)) ;
for (;(step69 > 0 && _x <= limit69) || (step69 < 0 && _x >= limit69) ;_x = ((int)(0 + _x + step69))  ) {
Debug.locals.put("x", _x);
 BA.debugLineNum = 449;BA.debugLine="argb.a = ClrFrom.a + dd * (ClrTo.a - ClrFrom.";
Debug.ShouldStop(1);
_argb.setField ("a",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_clrfrom.getField(true,"a"),_dd,(RemoteObject.solve(new RemoteObject[] {_clrto.getField(true,"a"),_clrfrom.getField(true,"a")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 450;BA.debugLine="argb.r = ClrFrom.r + dd * (ClrTo.r - ClrFrom.";
Debug.ShouldStop(2);
_argb.setField ("r",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_clrfrom.getField(true,"r"),_dd,(RemoteObject.solve(new RemoteObject[] {_clrto.getField(true,"r"),_clrfrom.getField(true,"r")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 451;BA.debugLine="argb.g = ClrFrom.g + dd * (ClrTo.g - ClrFrom.";
Debug.ShouldStop(4);
_argb.setField ("g",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_clrfrom.getField(true,"g"),_dd,(RemoteObject.solve(new RemoteObject[] {_clrto.getField(true,"g"),_clrfrom.getField(true,"g")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 452;BA.debugLine="argb.b = ClrFrom.b + dd * (ClrTo.b - ClrFrom.";
Debug.ShouldStop(8);
_argb.setField ("b",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_clrfrom.getField(true,"b"),_dd,(RemoteObject.solve(new RemoteObject[] {_clrto.getField(true,"b"),_clrfrom.getField(true,"b")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 453;BA.debugLine="ARGBToPremultipliedColor(argb, tempPM)";
Debug.ShouldStop(16);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_argbtopremultipliedcolor",(Object)(_argb),(Object)(__ref.getField(false,"_temppm")));
 BA.debugLineNum = 454;BA.debugLine="SetPremultipliedColor(cx + x * XFix, cy - r *";
Debug.ShouldStop(32);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_setpremultipliedcolor",(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_cx,RemoteObject.createImmutable(_x),_xfix}, "+*",1, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_cy,RemoteObject.createImmutable(_r),_yfix}, "-*",1, 0))),(Object)(__ref.getField(false,"_temppm")));
 BA.debugLineNum = 455;BA.debugLine="SetPremultipliedColor(cx + x * XFix, cy + r *";
Debug.ShouldStop(64);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_setpremultipliedcolor",(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_cx,RemoteObject.createImmutable(_x),_xfix}, "+*",1, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_cy,RemoteObject.createImmutable(_r),_yfix}, "+*",1, 0))),(Object)(__ref.getField(false,"_temppm")));
 BA.debugLineNum = 456;BA.debugLine="SetPremultipliedColor(cx - r * XFix, cy + x *";
Debug.ShouldStop(128);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_setpremultipliedcolor",(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_cx,RemoteObject.createImmutable(_r),_xfix}, "-*",1, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_cy,RemoteObject.createImmutable(_x),_yfix}, "+*",1, 0))),(Object)(__ref.getField(false,"_temppm")));
 BA.debugLineNum = 457;BA.debugLine="SetPremultipliedColor(cx + r * XFix, cy + x *";
Debug.ShouldStop(256);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_setpremultipliedcolor",(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_cx,RemoteObject.createImmutable(_r),_xfix}, "+*",1, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_cy,RemoteObject.createImmutable(_x),_yfix}, "+*",1, 0))),(Object)(__ref.getField(false,"_temppm")));
 }
}Debug.locals.put("x", _x);
;
 }
}Debug.locals.put("r", _r);
;
 }
}Debug.locals.put("part", _part);
;
 }else {
 BA.debugLineNum = 462;BA.debugLine="For y = StartY To EndY";
Debug.ShouldStop(8192);
{
final int step83 = 1;
final int limit83 = _endy.<Integer>get().intValue();
_y = _starty.<Integer>get().intValue() ;
for (;(step83 > 0 && _y <= limit83) || (step83 < 0 && _y >= limit83) ;_y = ((int)(0 + _y + step83))  ) {
Debug.locals.put("y", _y);
 BA.debugLineNum = 463;BA.debugLine="Dim EndX As Int = Rect.Left - ox - 1";
Debug.ShouldStop(16384);
_endx = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getLeft"),_ox,RemoteObject.createImmutable(1)}, "--",2, 0));Debug.locals.put("EndX", _endx);Debug.locals.put("EndX", _endx);
 BA.debugLineNum = 464;BA.debugLine="For part = 0 To NumberOfParts - 1";
Debug.ShouldStop(32768);
{
final int step85 = 1;
final int limit85 = RemoteObject.solve(new RemoteObject[] {_numberofparts,RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_part = 0 ;
for (;(step85 > 0 && _part <= limit85) || (step85 < 0 && _part >= limit85) ;_part = ((int)(0 + _part + step85))  ) {
Debug.locals.put("part", _part);
 BA.debugLineNum = 465;BA.debugLine="ClrFrom = RGBColor(part)";
Debug.ShouldStop(65536);
_clrfrom = _rgbcolor.getArrayElement(false,BA.numberCast(int.class, _part));Debug.locals.put("ClrFrom", _clrfrom);
 BA.debugLineNum = 466;BA.debugLine="ClrTo = RGBColor(part + 1)";
Debug.ShouldStop(131072);
_clrto = _rgbcolor.getArrayElement(false,RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_part),RemoteObject.createImmutable(1)}, "+",1, 1));Debug.locals.put("ClrTo", _clrto);
 BA.debugLineNum = 467;BA.debugLine="If TopBottom Then";
Debug.ShouldStop(262144);
if (_topbottom.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 468;BA.debugLine="Dim d As Float = y - Rect.Top";
Debug.ShouldStop(524288);
_d = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_y),_rect.runMethod(true,"getTop")}, "-",1, 0));Debug.locals.put("d", _d);Debug.locals.put("d", _d);
 BA.debugLineNum = 469;BA.debugLine="Dim dd As Float = (d - DFix(part)) / (AxisLen";
Debug.ShouldStop(1048576);
_dd = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_d,_dfix.getArrayElement(true,BA.numberCast(int.class, _part))}, "-",1, 0)),(RemoteObject.solve(new RemoteObject[] {_axislength,_numberofparts}, "/",0, 0))}, "/",0, 0));Debug.locals.put("dd", _dd);Debug.locals.put("dd", _dd);
 BA.debugLineNum = 470;BA.debugLine="If dd < 0 Or dd > 1 Then";
Debug.ShouldStop(2097152);
if (RemoteObject.solveBoolean("<",_dd,BA.numberCast(double.class, 0)) || RemoteObject.solveBoolean(">",_dd,BA.numberCast(double.class, 1))) { 
 BA.debugLineNum = 471;BA.debugLine="Continue";
Debug.ShouldStop(4194304);
if (true) continue;
 };
 BA.debugLineNum = 473;BA.debugLine="Dim tStartX As Int = StartMin";
Debug.ShouldStop(16777216);
_tstartx = _startmin;Debug.locals.put("tStartX", _tstartx);Debug.locals.put("tStartX", _tstartx);
 BA.debugLineNum = 474;BA.debugLine="Dim tEndX As Int = EndMax";
Debug.ShouldStop(33554432);
_tendx = _endmax;Debug.locals.put("tEndX", _tendx);Debug.locals.put("tEndX", _tendx);
 }else {
 BA.debugLineNum = 476;BA.debugLine="Dim StartX As Int = Max(StartMin, EndX + 1)";
Debug.ShouldStop(134217728);
_startx = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, _startmin)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_endx,RemoteObject.createImmutable(1)}, "+",1, 1)))));Debug.locals.put("StartX", _startx);Debug.locals.put("StartX", _startx);
 BA.debugLineNum = 477;BA.debugLine="Dim EndX As Int = Min(Rect.Left + DFixDivSinL";
Debug.ShouldStop(268435456);
_endx = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Min",(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getLeft"),_dfixdivsinl.getArrayElement(true,RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_part),RemoteObject.createImmutable(1)}, "+",1, 1)),_ox}, "+-",2, 0)),(Object)(BA.numberCast(double.class, _endmax))));Debug.locals.put("EndX", _endx);Debug.locals.put("EndX", _endx);
 BA.debugLineNum = 478;BA.debugLine="Dim d As Float = SinL * (StartX - Rect.Left +";
Debug.ShouldStop(536870912);
_d = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_sinl,(RemoteObject.solve(new RemoteObject[] {_startx,_rect.runMethod(true,"getLeft"),_ox}, "-+",2, 0))}, "*",0, 0));Debug.locals.put("d", _d);Debug.locals.put("d", _d);
 BA.debugLineNum = 479;BA.debugLine="Dim ddDelta As Float = SinL / (AxisLength / N";
Debug.ShouldStop(1073741824);
_dddelta = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_sinl,(RemoteObject.solve(new RemoteObject[] {_axislength,_numberofparts}, "/",0, 0))}, "/",0, 0));Debug.locals.put("ddDelta", _dddelta);Debug.locals.put("ddDelta", _dddelta);
 BA.debugLineNum = 480;BA.debugLine="Dim dd As Float = (d - DFix(part)) / (AxisLen";
Debug.ShouldStop(-2147483648);
_dd = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_d,_dfix.getArrayElement(true,BA.numberCast(int.class, _part))}, "-",1, 0)),(RemoteObject.solve(new RemoteObject[] {_axislength,_numberofparts}, "/",0, 0))}, "/",0, 0));Debug.locals.put("dd", _dd);Debug.locals.put("dd", _dd);
 BA.debugLineNum = 481;BA.debugLine="If TR_BL Then";
Debug.ShouldStop(1);
if (_tr_bl.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 482;BA.debugLine="tStartX = Rect.Right - 1 - (StartX - Rect.Le";
Debug.ShouldStop(2);
_tstartx = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getRight"),RemoteObject.createImmutable(1),(RemoteObject.solve(new RemoteObject[] {_startx,_rect.runMethod(true,"getLeft")}, "-",1, 0))}, "--",2, 0));Debug.locals.put("tStartX", _tstartx);
 BA.debugLineNum = 483;BA.debugLine="tEndX = Rect.Right - 1 - (EndX - Rect.Left)";
Debug.ShouldStop(4);
_tendx = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getRight"),RemoteObject.createImmutable(1),(RemoteObject.solve(new RemoteObject[] {_endx,_rect.runMethod(true,"getLeft")}, "-",1, 0))}, "--",2, 0));Debug.locals.put("tEndX", _tendx);
 BA.debugLineNum = 484;BA.debugLine="tStep = -1";
Debug.ShouldStop(8);
_tstep = BA.numberCast(int.class, -(double) (0 + 1));Debug.locals.put("tStep", _tstep);
 }else {
 BA.debugLineNum = 486;BA.debugLine="tStartX = StartX";
Debug.ShouldStop(32);
_tstartx = _startx;Debug.locals.put("tStartX", _tstartx);
 BA.debugLineNum = 487;BA.debugLine="tEndX = EndX";
Debug.ShouldStop(64);
_tendx = _endx;Debug.locals.put("tEndX", _tendx);
 };
 };
 BA.debugLineNum = 490;BA.debugLine="For	x = tStartX To tEndX Step tStep";
Debug.ShouldStop(512);
{
final int step111 = _tstep.<Integer>get().intValue();
final int limit111 = _tendx.<Integer>get().intValue();
_x = _tstartx.<Integer>get().intValue() ;
for (;(step111 > 0 && _x <= limit111) || (step111 < 0 && _x >= limit111) ;_x = ((int)(0 + _x + step111))  ) {
Debug.locals.put("x", _x);
 BA.debugLineNum = 491;BA.debugLine="argb.a = ClrFrom.a + dd * (ClrTo.a - ClrFrom.";
Debug.ShouldStop(1024);
_argb.setField ("a",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_clrfrom.getField(true,"a"),_dd,(RemoteObject.solve(new RemoteObject[] {_clrto.getField(true,"a"),_clrfrom.getField(true,"a")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 492;BA.debugLine="argb.r = ClrFrom.r + dd * (ClrTo.r - ClrFrom.";
Debug.ShouldStop(2048);
_argb.setField ("r",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_clrfrom.getField(true,"r"),_dd,(RemoteObject.solve(new RemoteObject[] {_clrto.getField(true,"r"),_clrfrom.getField(true,"r")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 493;BA.debugLine="argb.g = ClrFrom.g + dd * (ClrTo.g - ClrFrom.";
Debug.ShouldStop(4096);
_argb.setField ("g",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_clrfrom.getField(true,"g"),_dd,(RemoteObject.solve(new RemoteObject[] {_clrto.getField(true,"g"),_clrfrom.getField(true,"g")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 494;BA.debugLine="argb.b = ClrFrom.b + dd * (ClrTo.b - ClrFrom.";
Debug.ShouldStop(8192);
_argb.setField ("b",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_clrfrom.getField(true,"b"),_dd,(RemoteObject.solve(new RemoteObject[] {_clrto.getField(true,"b"),_clrfrom.getField(true,"b")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 495;BA.debugLine="SetARGB(x, y, argb)";
Debug.ShouldStop(16384);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_setargb",(Object)(BA.numberCast(int.class, _x)),(Object)(BA.numberCast(int.class, _y)),(Object)(_argb));
 BA.debugLineNum = 496;BA.debugLine="dd = dd + ddDelta";
Debug.ShouldStop(32768);
_dd = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_dd,_dddelta}, "+",1, 0));Debug.locals.put("dd", _dd);
 }
}Debug.locals.put("x", _x);
;
 }
}Debug.locals.put("part", _part);
;
 BA.debugLineNum = 499;BA.debugLine="ox = ox + deltaox";
Debug.ShouldStop(262144);
_ox = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_ox,_deltaox}, "+",1, 0));Debug.locals.put("ox", _ox);
 }
}Debug.locals.put("y", _y);
;
 };
 BA.debugLineNum = 503;BA.debugLine="End Sub";
Debug.ShouldStop(4194304);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fillradialgradient(RemoteObject __ref,RemoteObject _gradcolors,RemoteObject _rect) throws Exception{
try {
		Debug.PushSubsStack("FillRadialGradient (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,506);
if (RapidSub.canDelegate("fillradialgradient")) { return __ref.runUserSub(false, "bitmapcreator","fillradialgradient", __ref, _gradcolors, _rect);}
RemoteObject _rgbcolor = null;
int _i = 0;
RemoteObject _maxdistance = RemoteObject.createImmutable(0);
RemoteObject _distancetocolor = null;
RemoteObject _currentcolorindex = RemoteObject.createImmutable(0);
RemoteObject _lengthofeachcolor = RemoteObject.createImmutable(0);
RemoteObject _c = RemoteObject.createImmutable(0);
RemoteObject _l = RemoteObject.createImmutable(0f);
RemoteObject _cx = RemoteObject.createImmutable(0);
RemoteObject _cy = RemoteObject.createImmutable(0);
int _x = 0;
RemoteObject _dx = RemoteObject.createImmutable(0);
int _y = 0;
RemoteObject _distance = RemoteObject.createImmutable(0);
Debug.locals.put("GradColors", _gradcolors);
Debug.locals.put("Rect", _rect);
 BA.debugLineNum = 506;BA.debugLine="Public Sub FillRadialGradient (GradColors() As Int";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 507;BA.debugLine="Dim RGBColor(GradColors.Length) As ARGBColor";
Debug.ShouldStop(67108864);
_rgbcolor = RemoteObject.createNewArray ("b4j.example.bitmapcreator._argbcolor", new int[] {_gradcolors.getField(true,"length").<Integer>get().intValue()}, new Object[]{});Debug.locals.put("RGBColor", _rgbcolor);
 BA.debugLineNum = 508;BA.debugLine="For i = 0 To GradColors.Length - 1";
Debug.ShouldStop(134217728);
{
final int step2 = 1;
final int limit2 = RemoteObject.solve(new RemoteObject[] {_gradcolors.getField(true,"length"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step2 > 0 && _i <= limit2) || (step2 < 0 && _i >= limit2) ;_i = ((int)(0 + _i + step2))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 509;BA.debugLine="ColorToARGB(GradColors(i), RGBColor(i))";
Debug.ShouldStop(268435456);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_colortoargb",(Object)(_gradcolors.getArrayElement(true,BA.numberCast(int.class, _i))),(Object)(_rgbcolor.getArrayElement(false,BA.numberCast(int.class, _i))));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 511;BA.debugLine="Dim MaxDistance As Int = Ceil(Sqrt(Power(Rect.Wid";
Debug.ShouldStop(1073741824);
_maxdistance = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Ceil",(Object)(bitmapcreator.__c.runMethod(true,"Sqrt",(Object)(RemoteObject.solve(new RemoteObject[] {bitmapcreator.__c.runMethod(true,"Power",(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0)),(Object)(BA.numberCast(double.class, 2))),bitmapcreator.__c.runMethod(true,"Power",(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)),(Object)(BA.numberCast(double.class, 2)))}, "+",1, 0))))));Debug.locals.put("MaxDistance", _maxdistance);Debug.locals.put("MaxDistance", _maxdistance);
 BA.debugLineNum = 512;BA.debugLine="Dim DistanceToColor(MaxDistance) As ARGBColor";
Debug.ShouldStop(-2147483648);
_distancetocolor = RemoteObject.createNewArray ("b4j.example.bitmapcreator._argbcolor", new int[] {_maxdistance.<Integer>get().intValue()}, new Object[]{});Debug.locals.put("DistanceToColor", _distancetocolor);
 BA.debugLineNum = 513;BA.debugLine="Dim CurrentColorIndex As Int";
Debug.ShouldStop(1);
_currentcolorindex = RemoteObject.createImmutable(0);Debug.locals.put("CurrentColorIndex", _currentcolorindex);
 BA.debugLineNum = 514;BA.debugLine="Dim LengthOfEachColor As Int = Ceil(MaxDistance /";
Debug.ShouldStop(2);
_lengthofeachcolor = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Ceil",(Object)(RemoteObject.solve(new RemoteObject[] {_maxdistance,(RemoteObject.solve(new RemoteObject[] {_gradcolors.getField(true,"length"),RemoteObject.createImmutable(1)}, "-",1, 1))}, "/",0, 0))));Debug.locals.put("LengthOfEachColor", _lengthofeachcolor);Debug.locals.put("LengthOfEachColor", _lengthofeachcolor);
 BA.debugLineNum = 515;BA.debugLine="Dim c As Int";
Debug.ShouldStop(4);
_c = RemoteObject.createImmutable(0);Debug.locals.put("c", _c);
 BA.debugLineNum = 516;BA.debugLine="For i = 0 To MaxDistance - 1";
Debug.ShouldStop(8);
{
final int step10 = 1;
final int limit10 = RemoteObject.solve(new RemoteObject[] {_maxdistance,RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step10 > 0 && _i <= limit10) || (step10 < 0 && _i >= limit10) ;_i = ((int)(0 + _i + step10))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 517;BA.debugLine="Dim l As Float = CurrentColorIndex / LengthOfEac";
Debug.ShouldStop(16);
_l = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_currentcolorindex,_lengthofeachcolor}, "/",0, 0));Debug.locals.put("l", _l);Debug.locals.put("l", _l);
 BA.debugLineNum = 518;BA.debugLine="DistanceToColor(i).a = RGBColor(c).a + l * (RGBC";
Debug.ShouldStop(32);
_distancetocolor.getArrayElement(false,BA.numberCast(int.class, _i)).setField ("a",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_rgbcolor.getArrayElement(false,_c).getField(true,"a"),_l,(RemoteObject.solve(new RemoteObject[] {_rgbcolor.getArrayElement(false,RemoteObject.solve(new RemoteObject[] {_c,RemoteObject.createImmutable(1)}, "+",1, 1)).getField(true,"a"),_rgbcolor.getArrayElement(false,_c).getField(true,"a")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 519;BA.debugLine="DistanceToColor(i).r = RGBColor(c).r + l * (RGBC";
Debug.ShouldStop(64);
_distancetocolor.getArrayElement(false,BA.numberCast(int.class, _i)).setField ("r",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_rgbcolor.getArrayElement(false,_c).getField(true,"r"),_l,(RemoteObject.solve(new RemoteObject[] {_rgbcolor.getArrayElement(false,RemoteObject.solve(new RemoteObject[] {_c,RemoteObject.createImmutable(1)}, "+",1, 1)).getField(true,"r"),_rgbcolor.getArrayElement(false,_c).getField(true,"r")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 520;BA.debugLine="DistanceToColor(i).g = RGBColor(c).g + l * (RGBC";
Debug.ShouldStop(128);
_distancetocolor.getArrayElement(false,BA.numberCast(int.class, _i)).setField ("g",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_rgbcolor.getArrayElement(false,_c).getField(true,"g"),_l,(RemoteObject.solve(new RemoteObject[] {_rgbcolor.getArrayElement(false,RemoteObject.solve(new RemoteObject[] {_c,RemoteObject.createImmutable(1)}, "+",1, 1)).getField(true,"g"),_rgbcolor.getArrayElement(false,_c).getField(true,"g")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 521;BA.debugLine="DistanceToColor(i).b = RGBColor(c).b + l * (RGBC";
Debug.ShouldStop(256);
_distancetocolor.getArrayElement(false,BA.numberCast(int.class, _i)).setField ("b",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_rgbcolor.getArrayElement(false,_c).getField(true,"b"),_l,(RemoteObject.solve(new RemoteObject[] {_rgbcolor.getArrayElement(false,RemoteObject.solve(new RemoteObject[] {_c,RemoteObject.createImmutable(1)}, "+",1, 1)).getField(true,"b"),_rgbcolor.getArrayElement(false,_c).getField(true,"b")}, "-",1, 1))}, "+*",1, 0)));
 BA.debugLineNum = 522;BA.debugLine="CurrentColorIndex = CurrentColorIndex + 1";
Debug.ShouldStop(512);
_currentcolorindex = RemoteObject.solve(new RemoteObject[] {_currentcolorindex,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("CurrentColorIndex", _currentcolorindex);
 BA.debugLineNum = 523;BA.debugLine="If CurrentColorIndex = LengthOfEachColor Then";
Debug.ShouldStop(1024);
if (RemoteObject.solveBoolean("=",_currentcolorindex,BA.numberCast(double.class, _lengthofeachcolor))) { 
 BA.debugLineNum = 524;BA.debugLine="CurrentColorIndex = 0";
Debug.ShouldStop(2048);
_currentcolorindex = BA.numberCast(int.class, 0);Debug.locals.put("CurrentColorIndex", _currentcolorindex);
 BA.debugLineNum = 525;BA.debugLine="c = c + 1";
Debug.ShouldStop(4096);
_c = RemoteObject.solve(new RemoteObject[] {_c,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("c", _c);
 };
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 528;BA.debugLine="Dim cx As Int = Rect.CenterX";
Debug.ShouldStop(32768);
_cx = BA.numberCast(int.class, _rect.runMethod(true,"getCenterX"));Debug.locals.put("cx", _cx);Debug.locals.put("cx", _cx);
 BA.debugLineNum = 529;BA.debugLine="Dim cy As Int = Rect.CenterY";
Debug.ShouldStop(65536);
_cy = BA.numberCast(int.class, _rect.runMethod(true,"getCenterY"));Debug.locals.put("cy", _cy);Debug.locals.put("cy", _cy);
 BA.debugLineNum = 530;BA.debugLine="For x = Max(0, Rect.Left) To Min(mWidth - 1, Rect";
Debug.ShouldStop(131072);
{
final int step24 = 1;
final int limit24 = (int) (0 + bitmapcreator.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(1)}, "-",1, 1))),(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getRight"),RemoteObject.createImmutable(1)}, "-",1, 0))).<Double>get().doubleValue());
_x = (int) (0 + bitmapcreator.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, _rect.runMethod(true,"getLeft")))).<Double>get().doubleValue()) ;
for (;(step24 > 0 && _x <= limit24) || (step24 < 0 && _x >= limit24) ;_x = ((int)(0 + _x + step24))  ) {
Debug.locals.put("x", _x);
 BA.debugLineNum = 531;BA.debugLine="Dim dx As Int = Power(x - cx, 2)";
Debug.ShouldStop(262144);
_dx = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Power",(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_x),_cx}, "-",1, 1))),(Object)(BA.numberCast(double.class, 2))));Debug.locals.put("dx", _dx);Debug.locals.put("dx", _dx);
 BA.debugLineNum = 532;BA.debugLine="For y = Max(0, Rect.Top) To Min(mHeight - 1, Rec";
Debug.ShouldStop(524288);
{
final int step26 = 1;
final int limit26 = (int) (0 + bitmapcreator.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mheight"),RemoteObject.createImmutable(1)}, "-",1, 1))),(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getBottom"),RemoteObject.createImmutable(1)}, "-",1, 0))).<Double>get().doubleValue());
_y = (int) (0 + bitmapcreator.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, _rect.runMethod(true,"getTop")))).<Double>get().doubleValue()) ;
for (;(step26 > 0 && _y <= limit26) || (step26 < 0 && _y >= limit26) ;_y = ((int)(0 + _y + step26))  ) {
Debug.locals.put("y", _y);
 BA.debugLineNum = 533;BA.debugLine="Dim distance As Int = Sqrt(dx + Power(y - cy, 2";
Debug.ShouldStop(1048576);
_distance = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Sqrt",(Object)(RemoteObject.solve(new RemoteObject[] {_dx,bitmapcreator.__c.runMethod(true,"Power",(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_y),_cy}, "-",1, 1))),(Object)(BA.numberCast(double.class, 2)))}, "+",1, 0))));Debug.locals.put("distance", _distance);Debug.locals.put("distance", _distance);
 BA.debugLineNum = 534;BA.debugLine="SetARGB(x, y, DistanceToColor(distance))";
Debug.ShouldStop(2097152);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_setargb",(Object)(BA.numberCast(int.class, _x)),(Object)(BA.numberCast(int.class, _y)),(Object)(_distancetocolor.getArrayElement(false,_distance)));
 }
}Debug.locals.put("y", _y);
;
 }
}Debug.locals.put("x", _x);
;
 BA.debugLineNum = 537;BA.debugLine="End Sub";
Debug.ShouldStop(16777216);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fillrect(RemoteObject __ref,RemoteObject _color,RemoteObject _rect) throws Exception{
try {
		Debug.PushSubsStack("FillRect (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,251);
if (RapidSub.canDelegate("fillrect")) { return __ref.runUserSub(false, "bitmapcreator","fillrect", __ref, _color, _rect);}
RemoteObject _startx = RemoteObject.createImmutable(0);
RemoteObject _endx = RemoteObject.createImmutable(0);
RemoteObject _starty = RemoteObject.createImmutable(0);
RemoteObject _endy = RemoteObject.createImmutable(0);
RemoteObject _cp = RemoteObject.createImmutable(0);
RemoteObject _b = null;
int _x = 0;
int _y = 0;
Debug.locals.put("Color", _color);
Debug.locals.put("Rect", _rect);
 BA.debugLineNum = 251;BA.debugLine="Public Sub FillRect (Color As Int, Rect As B4XRect";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 252;BA.debugLine="Dim StartX As Int = Max(0, Rect.Left)";
Debug.ShouldStop(134217728);
_startx = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, _rect.runMethod(true,"getLeft")))));Debug.locals.put("StartX", _startx);Debug.locals.put("StartX", _startx);
 BA.debugLineNum = 253;BA.debugLine="Dim EndX As Int = Min(mWidth - 1, Rect.Right - 1)";
Debug.ShouldStop(268435456);
_endx = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(1)}, "-",1, 1))),(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getRight"),RemoteObject.createImmutable(1)}, "-",1, 0))));Debug.locals.put("EndX", _endx);Debug.locals.put("EndX", _endx);
 BA.debugLineNum = 254;BA.debugLine="Dim StartY As Int = Max(0, Rect.Top)";
Debug.ShouldStop(536870912);
_starty = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, _rect.runMethod(true,"getTop")))));Debug.locals.put("StartY", _starty);Debug.locals.put("StartY", _starty);
 BA.debugLineNum = 255;BA.debugLine="Dim EndY As Int = Min(mHeight - 1, Rect.Bottom -";
Debug.ShouldStop(1073741824);
_endy = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mheight"),RemoteObject.createImmutable(1)}, "-",1, 1))),(Object)(RemoteObject.solve(new RemoteObject[] {_rect.runMethod(true,"getBottom"),RemoteObject.createImmutable(1)}, "-",1, 0))));Debug.locals.put("EndY", _endy);Debug.locals.put("EndY", _endy);
 BA.debugLineNum = 256;BA.debugLine="If EndX < StartX Or EndY < StartY Then Return";
Debug.ShouldStop(-2147483648);
if (RemoteObject.solveBoolean("<",_endx,BA.numberCast(double.class, _startx)) || RemoteObject.solveBoolean("<",_endy,BA.numberCast(double.class, _starty))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 257;BA.debugLine="SetColor(StartX, StartY, Color)";
Debug.ShouldStop(1);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_setcolor",(Object)(_startx),(Object)(_starty),(Object)(_color));
 BA.debugLineNum = 258;BA.debugLine="Dim cp As Int = StartX * 4 + StartY * mWidth * 4";
Debug.ShouldStop(2);
_cp = RemoteObject.solve(new RemoteObject[] {_startx,RemoteObject.createImmutable(4),_starty,__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "*+**",1, 1);Debug.locals.put("cp", _cp);Debug.locals.put("cp", _cp);
 BA.debugLineNum = 259;BA.debugLine="Dim b((EndX - StartX + 1) * 4) As Byte";
Debug.ShouldStop(4);
_b = RemoteObject.createNewArray ("byte", new int[] {RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_endx,_startx,RemoteObject.createImmutable(1)}, "-+",2, 1)),RemoteObject.createImmutable(4)}, "*",0, 1).<Integer>get().intValue()}, new Object[]{});Debug.locals.put("b", _b);
 BA.debugLineNum = 260;BA.debugLine="For x = 0 To b.Length - 4 Step 4";
Debug.ShouldStop(8);
{
final int step9 = 4;
final int limit9 = RemoteObject.solve(new RemoteObject[] {_b.getField(true,"length"),RemoteObject.createImmutable(4)}, "-",1, 1).<Integer>get().intValue();
_x = 0 ;
for (;(step9 > 0 && _x <= limit9) || (step9 < 0 && _x >= limit9) ;_x = ((int)(0 + _x + step9))  ) {
Debug.locals.put("x", _x);
 BA.debugLineNum = 261;BA.debugLine="b(x) = mBuffer(cp)";
Debug.ShouldStop(16);
_b.setArrayElement (__ref.getField(false,"_mbuffer").getArrayElement(true,_cp),BA.numberCast(int.class, _x));
 BA.debugLineNum = 262;BA.debugLine="b(x + 1) = mBuffer(cp + 1)";
Debug.ShouldStop(32);
_b.setArrayElement (__ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,RemoteObject.createImmutable(1)}, "+",1, 1)),RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_x),RemoteObject.createImmutable(1)}, "+",1, 1));
 BA.debugLineNum = 263;BA.debugLine="b(x + 2) = mBuffer(cp + 2)";
Debug.ShouldStop(64);
_b.setArrayElement (__ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,RemoteObject.createImmutable(2)}, "+",1, 1)),RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_x),RemoteObject.createImmutable(2)}, "+",1, 1));
 BA.debugLineNum = 264;BA.debugLine="b(x + 3) = mBuffer(cp + 3)";
Debug.ShouldStop(128);
_b.setArrayElement (__ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,RemoteObject.createImmutable(3)}, "+",1, 1)),RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_x),RemoteObject.createImmutable(3)}, "+",1, 1));
 }
}Debug.locals.put("x", _x);
;
 BA.debugLineNum = 266;BA.debugLine="For y = StartY * mWidth * 4 To EndY * mWidth * 4";
Debug.ShouldStop(512);
{
final int step15 = RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "*",0, 1).<Integer>get().intValue();
final int limit15 = RemoteObject.solve(new RemoteObject[] {_endy,__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "**",0, 1).<Integer>get().intValue();
_y = RemoteObject.solve(new RemoteObject[] {_starty,__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "**",0, 1).<Integer>get().intValue() ;
for (;(step15 > 0 && _y <= limit15) || (step15 < 0 && _y >= limit15) ;_y = ((int)(0 + _y + step15))  ) {
Debug.locals.put("y", _y);
 BA.debugLineNum = 267;BA.debugLine="Bit.ArrayCopy(b, 0, mBuffer, y + StartX * 4, b.L";
Debug.ShouldStop(1024);
bitmapcreator.__c.getField(false,"Bit").runVoidMethod ("ArrayCopy",(Object)((_b)),(Object)(BA.numberCast(int.class, 0)),(Object)((__ref.getField(false,"_mbuffer"))),(Object)(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_y),_startx,RemoteObject.createImmutable(4)}, "+*",1, 1)),(Object)(_b.getField(true,"length")));
 }
}Debug.locals.put("y", _y);
;
 BA.debugLineNum = 269;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getargb(RemoteObject __ref,RemoteObject _x,RemoteObject _y,RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("GetARGB (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,193);
if (RapidSub.canDelegate("getargb")) { return __ref.runUserSub(false, "bitmapcreator","getargb", __ref, _x, _y, _result);}
RemoteObject _cp = RemoteObject.createImmutable(0);
RemoteObject _af = RemoteObject.createImmutable(0f);
Debug.locals.put("x", _x);
Debug.locals.put("y", _y);
Debug.locals.put("Result", _result);
 BA.debugLineNum = 193;BA.debugLine="Public Sub GetARGB (x As Int, y As Int, Result As";
Debug.ShouldStop(1);
 BA.debugLineNum = 194;BA.debugLine="Dim cp As Int = x * 4 + y * mWidth * 4";
Debug.ShouldStop(2);
_cp = RemoteObject.solve(new RemoteObject[] {_x,RemoteObject.createImmutable(4),_y,__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "*+**",1, 1);Debug.locals.put("cp", _cp);Debug.locals.put("cp", _cp);
 BA.debugLineNum = 202;BA.debugLine="Result.a = Bit.And(0xff, mBuffer(cp + ai))";
Debug.ShouldStop(512);
_result.setField ("a",bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(BA.numberCast(int.class, __ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_ai")}, "+",1, 1))))));
 BA.debugLineNum = 203;BA.debugLine="Dim af As Float = Result.a / 255";
Debug.ShouldStop(1024);
_af = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_result.getField(true,"a"),RemoteObject.createImmutable(255)}, "/",0, 0));Debug.locals.put("af", _af);Debug.locals.put("af", _af);
 BA.debugLineNum = 204;BA.debugLine="Result.r = Bit.And(0xff, mBuffer(cp + ri)) / af";
Debug.ShouldStop(2048);
_result.setField ("r",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(BA.numberCast(int.class, __ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_ri")}, "+",1, 1))))),_af}, "/",0, 0)));
 BA.debugLineNum = 205;BA.debugLine="Result.g = Bit.And(0xff, mBuffer(cp + gi)) / af";
Debug.ShouldStop(4096);
_result.setField ("g",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(BA.numberCast(int.class, __ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_gi")}, "+",1, 1))))),_af}, "/",0, 0)));
 BA.debugLineNum = 206;BA.debugLine="Result.b = Bit.And(0xff, mBuffer(cp + bi)) / af";
Debug.ShouldStop(8192);
_result.setField ("b",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {bitmapcreator.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0xff)),(Object)(BA.numberCast(int.class, __ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_bi")}, "+",1, 1))))),_af}, "/",0, 0)));
 BA.debugLineNum = 209;BA.debugLine="Return Result";
Debug.ShouldStop(65536);
if (true) return _result;
 BA.debugLineNum = 210;BA.debugLine="End Sub";
Debug.ShouldStop(131072);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getbitmap(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getBitmap (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,219);
if (RapidSub.canDelegate("getbitmap")) { return __ref.runUserSub(false, "bitmapcreator","getbitmap", __ref);}
RemoteObject _writer = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _pixelformat = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
 BA.debugLineNum = 219;BA.debugLine="Public Sub getBitmap As B4XBitmap";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 231;BA.debugLine="If WriteableImage.IsInitialized = False Then";
Debug.ShouldStop(64);
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_writeableimage").runMethod(true,"IsInitialized"),bitmapcreator.__c.getField(true,"False"))) { 
 BA.debugLineNum = 232;BA.debugLine="WriteableImage.InitializeNewInstance(\"javafx.sce";
Debug.ShouldStop(128);
__ref.getField(false,"_writeableimage").runVoidMethod ("InitializeNewInstance",(Object)(BA.ObjectToString("javafx.scene.image.WritableImage")),(Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {(__ref.getField(true,"_mwidth")),(__ref.getField(true,"_mheight"))})));
 };
 BA.debugLineNum = 234;BA.debugLine="Dim writer As JavaObject = WriteableImage.RunMeth";
Debug.ShouldStop(512);
_writer = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_writer.setObject(__ref.getField(false,"_writeableimage").runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getPixelWriter")),(Object)((bitmapcreator.__c.getField(false,"Null")))));Debug.locals.put("writer", _writer);
 BA.debugLineNum = 235;BA.debugLine="Dim PixelFormat As JavaObject";
Debug.ShouldStop(1024);
_pixelformat = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("PixelFormat", _pixelformat);
 BA.debugLineNum = 236;BA.debugLine="PixelFormat.InitializeStatic(\"javafx.scene.image.";
Debug.ShouldStop(2048);
_pixelformat.runVoidMethod ("InitializeStatic",(Object)(RemoteObject.createImmutable("javafx.scene.image.PixelFormat")));
 BA.debugLineNum = 237;BA.debugLine="writer.RunMethod(\"setPixels\", Array(0, 0, mWidth,";
Debug.ShouldStop(4096);
_writer.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("setPixels")),(Object)(RemoteObject.createNewArray("Object",new int[] {8},new Object[] {RemoteObject.createImmutable((0)),RemoteObject.createImmutable((0)),(__ref.getField(true,"_mwidth")),(__ref.getField(true,"_mheight")),_pixelformat.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getByteBgraPreInstance")),(Object)((bitmapcreator.__c.getField(false,"Null")))),(__ref.getField(false,"_mbuffer")),RemoteObject.createImmutable((0)),(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "*",0, 1))})));
 BA.debugLineNum = 239;BA.debugLine="Return WriteableImage";
Debug.ShouldStop(16384);
if (true) return RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_writeableimage").getObject());
 BA.debugLineNum = 245;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getbuffer(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getBuffer (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,43);
if (RapidSub.canDelegate("getbuffer")) { return __ref.runUserSub(false, "bitmapcreator","getbuffer", __ref);}
 BA.debugLineNum = 43;BA.debugLine="Public Sub getBuffer() As Byte()";
Debug.ShouldStop(1024);
 BA.debugLineNum = 44;BA.debugLine="Return mBuffer";
Debug.ShouldStop(2048);
if (true) return __ref.getField(false,"_mbuffer");
 BA.debugLineNum = 45;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getcolor(RemoteObject __ref,RemoteObject _x,RemoteObject _y) throws Exception{
try {
		Debug.PushSubsStack("GetColor (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,186);
if (RapidSub.canDelegate("getcolor")) { return __ref.runUserSub(false, "bitmapcreator","getcolor", __ref, _x, _y);}
Debug.locals.put("x", _x);
Debug.locals.put("y", _y);
 BA.debugLineNum = 186;BA.debugLine="Public Sub GetColor (x As Int, y As Int) As Int";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 187;BA.debugLine="GetARGB(x, y, tempARGB)";
Debug.ShouldStop(67108864);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_getargb",(Object)(_x),(Object)(_y),(Object)(__ref.getField(false,"_tempargb")));
 BA.debugLineNum = 188;BA.debugLine="Return Bit.ShiftLeft(tempARGB.a, 24) + Bit.ShiftL";
Debug.ShouldStop(134217728);
if (true) return RemoteObject.solve(new RemoteObject[] {bitmapcreator.__c.getField(false,"Bit").runMethod(true,"ShiftLeft",(Object)(__ref.getField(false,"_tempargb").getField(true,"a")),(Object)(BA.numberCast(int.class, 24))),bitmapcreator.__c.getField(false,"Bit").runMethod(true,"ShiftLeft",(Object)(__ref.getField(false,"_tempargb").getField(true,"r")),(Object)(BA.numberCast(int.class, 16))),bitmapcreator.__c.getField(false,"Bit").runMethod(true,"ShiftLeft",(Object)(__ref.getField(false,"_tempargb").getField(true,"g")),(Object)(BA.numberCast(int.class, 8))),__ref.getField(false,"_tempargb").getField(true,"b")}, "+++",3, 1);
 BA.debugLineNum = 189;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getpremultipliedcolor(RemoteObject __ref,RemoteObject _x,RemoteObject _y,RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("GetPremultipliedColor (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,169);
if (RapidSub.canDelegate("getpremultipliedcolor")) { return __ref.runUserSub(false, "bitmapcreator","getpremultipliedcolor", __ref, _x, _y, _result);}
RemoteObject _cp = RemoteObject.createImmutable(0);
Debug.locals.put("x", _x);
Debug.locals.put("y", _y);
Debug.locals.put("Result", _result);
 BA.debugLineNum = 169;BA.debugLine="Private Sub GetPremultipliedColor (x As Int, y As";
Debug.ShouldStop(256);
 BA.debugLineNum = 170;BA.debugLine="Dim cp As Int = x * 4 + y * mWidth * 4";
Debug.ShouldStop(512);
_cp = RemoteObject.solve(new RemoteObject[] {_x,RemoteObject.createImmutable(4),_y,__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "*+**",1, 1);Debug.locals.put("cp", _cp);Debug.locals.put("cp", _cp);
 BA.debugLineNum = 177;BA.debugLine="Result.r = mBuffer(cp + ri)";
Debug.ShouldStop(65536);
_result.setField ("r",BA.numberCast(int.class, __ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_ri")}, "+",1, 1))));
 BA.debugLineNum = 178;BA.debugLine="Result.g = mBuffer(cp + gi)";
Debug.ShouldStop(131072);
_result.setField ("g",BA.numberCast(int.class, __ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_gi")}, "+",1, 1))));
 BA.debugLineNum = 179;BA.debugLine="Result.b = mBuffer(cp + bi)";
Debug.ShouldStop(262144);
_result.setField ("b",BA.numberCast(int.class, __ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_bi")}, "+",1, 1))));
 BA.debugLineNum = 180;BA.debugLine="Result.a = mBuffer(cp + ai)";
Debug.ShouldStop(524288);
_result.setField ("a",BA.numberCast(int.class, __ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_ai")}, "+",1, 1))));
 BA.debugLineNum = 182;BA.debugLine="Return Result";
Debug.ShouldStop(2097152);
if (true) return _result;
 BA.debugLineNum = 183;BA.debugLine="End Sub";
Debug.ShouldStop(4194304);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _width,RemoteObject _height) throws Exception{
try {
		Debug.PushSubsStack("Initialize (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,21);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "bitmapcreator","initialize", __ref, _ba, _width, _height);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
RemoteObject _b = RemoteObject.createImmutable((byte)0);
Debug.locals.put("ba", _ba);
Debug.locals.put("Width", _width);
Debug.locals.put("Height", _height);
 BA.debugLineNum = 21;BA.debugLine="Public Sub Initialize (Width As Int, Height As Int";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 22;BA.debugLine="Dim b As Byte = 0xff";
Debug.ShouldStop(2097152);
_b = BA.numberCast(byte.class, 0xff);Debug.locals.put("b", _b);Debug.locals.put("b", _b);
 BA.debugLineNum = 23;BA.debugLine="UnsignedFF = b";
Debug.ShouldStop(4194304);
__ref.setField ("_unsignedff",BA.numberCast(int.class, _b));
 BA.debugLineNum = 24;BA.debugLine="mWidth = Width";
Debug.ShouldStop(8388608);
__ref.setField ("_mwidth",_width);
 BA.debugLineNum = 25;BA.debugLine="mHeight = Height";
Debug.ShouldStop(16777216);
__ref.setField ("_mheight",_height);
 BA.debugLineNum = 26;BA.debugLine="Dim mBuffer(mWidth * mHeight * 4) As Byte";
Debug.ShouldStop(33554432);
bitmapcreator._mbuffer = RemoteObject.createNewArray ("byte", new int[] {RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mwidth"),__ref.getField(true,"_mheight"),RemoteObject.createImmutable(4)}, "**",0, 1).<Integer>get().intValue()}, new Object[]{});__ref.setField("_mbuffer",bitmapcreator._mbuffer);
 BA.debugLineNum = 33;BA.debugLine="ai = 3";
Debug.ShouldStop(1);
__ref.setField ("_ai",BA.numberCast(int.class, 3));
 BA.debugLineNum = 34;BA.debugLine="ri = 2";
Debug.ShouldStop(2);
__ref.setField ("_ri",BA.numberCast(int.class, 2));
 BA.debugLineNum = 35;BA.debugLine="gi = 1";
Debug.ShouldStop(4);
__ref.setField ("_gi",BA.numberCast(int.class, 1));
 BA.debugLineNum = 36;BA.debugLine="bi = 0";
Debug.ShouldStop(8);
__ref.setField ("_bi",BA.numberCast(int.class, 0));
 BA.debugLineNum = 39;BA.debugLine="TargetRect.Initialize(0, 0, mWidth, mHeight)";
Debug.ShouldStop(64);
__ref.getField(false,"_targetrect").runVoidMethod ("Initialize",(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, __ref.getField(true,"_mwidth"))),(Object)(BA.numberCast(float.class, __ref.getField(true,"_mheight"))));
 BA.debugLineNum = 40;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _istransparent(RemoteObject __ref,RemoteObject _x,RemoteObject _y) throws Exception{
try {
		Debug.PushSubsStack("IsTransparent (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,213);
if (RapidSub.canDelegate("istransparent")) { return __ref.runUserSub(false, "bitmapcreator","istransparent", __ref, _x, _y);}
RemoteObject _cp = RemoteObject.createImmutable(0);
Debug.locals.put("x", _x);
Debug.locals.put("y", _y);
 BA.debugLineNum = 213;BA.debugLine="Public Sub IsTransparent(x As Int, y As Int) As Bo";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 214;BA.debugLine="Dim cp As Int = x * 4 + y * mWidth * 4";
Debug.ShouldStop(2097152);
_cp = RemoteObject.solve(new RemoteObject[] {_x,RemoteObject.createImmutable(4),_y,__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "*+**",1, 1);Debug.locals.put("cp", _cp);Debug.locals.put("cp", _cp);
 BA.debugLineNum = 215;BA.debugLine="Return mBuffer(cp + ai) = 0";
Debug.ShouldStop(4194304);
if (true) return BA.ObjectToBoolean(RemoteObject.solveBoolean("=",__ref.getField(false,"_mbuffer").getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_ai")}, "+",1, 1)),BA.numberCast(double.class, 0)));
 BA.debugLineNum = 216;BA.debugLine="End Sub";
Debug.ShouldStop(8388608);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setargb(RemoteObject __ref,RemoteObject _x,RemoteObject _y,RemoteObject _argb) throws Exception{
try {
		Debug.PushSubsStack("SetARGB (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,146);
if (RapidSub.canDelegate("setargb")) { return __ref.runUserSub(false, "bitmapcreator","setargb", __ref, _x, _y, _argb);}
Debug.locals.put("x", _x);
Debug.locals.put("y", _y);
Debug.locals.put("ARGB", _argb);
 BA.debugLineNum = 146;BA.debugLine="Public Sub SetARGB(x As Int, y As Int, ARGB As ARG";
Debug.ShouldStop(131072);
 BA.debugLineNum = 147;BA.debugLine="SetPremultipliedColor(x, y, ARGBToPremultipliedCo";
Debug.ShouldStop(262144);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_setpremultipliedcolor",(Object)(_x),(Object)(_y),(Object)(__ref.runClassMethod (b4j.example.bitmapcreator.class, "_argbtopremultipliedcolor",(Object)(_argb),(Object)(__ref.getField(false,"_temppm")))));
 BA.debugLineNum = 148;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setcolor(RemoteObject __ref,RemoteObject _x,RemoteObject _y,RemoteObject _clr) throws Exception{
try {
		Debug.PushSubsStack("SetColor (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,77);
if (RapidSub.canDelegate("setcolor")) { return __ref.runUserSub(false, "bitmapcreator","setcolor", __ref, _x, _y, _clr);}
Debug.locals.put("x", _x);
Debug.locals.put("y", _y);
Debug.locals.put("Clr", _clr);
 BA.debugLineNum = 77;BA.debugLine="Public Sub SetColor(x As Int, y As Int, Clr As Int";
Debug.ShouldStop(4096);
 BA.debugLineNum = 78;BA.debugLine="ColorToARGB(Clr, tempARGB)";
Debug.ShouldStop(8192);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_colortoargb",(Object)(_clr),(Object)(__ref.getField(false,"_tempargb")));
 BA.debugLineNum = 79;BA.debugLine="SetARGB(x, y, tempARGB)";
Debug.ShouldStop(16384);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_setargb",(Object)(_x),(Object)(_y),(Object)(__ref.getField(false,"_tempargb")));
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
public static RemoteObject  _sethsv(RemoteObject __ref,RemoteObject _x,RemoteObject _y,RemoteObject _alpha,RemoteObject _h,RemoteObject _s,RemoteObject _v) throws Exception{
try {
		Debug.PushSubsStack("SetHSV (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,104);
if (RapidSub.canDelegate("sethsv")) { return __ref.runUserSub(false, "bitmapcreator","sethsv", __ref, _x, _y, _alpha, _h, _s, _v);}
RemoteObject _r = RemoteObject.createImmutable(0f);
RemoteObject _g = RemoteObject.createImmutable(0f);
RemoteObject _b = RemoteObject.createImmutable(0f);
RemoteObject _hi = RemoteObject.createImmutable(0);
RemoteObject _hbucket = RemoteObject.createImmutable(0);
RemoteObject _f = RemoteObject.createImmutable(0f);
RemoteObject _p = RemoteObject.createImmutable(0f);
RemoteObject _q = RemoteObject.createImmutable(0f);
RemoteObject _t = RemoteObject.createImmutable(0f);
Debug.locals.put("x", _x);
Debug.locals.put("y", _y);
Debug.locals.put("alpha", _alpha);
Debug.locals.put("h", _h);
Debug.locals.put("s", _s);
Debug.locals.put("v", _v);
 BA.debugLineNum = 104;BA.debugLine="Public Sub SetHSV(x As Int, y As Int, alpha As Int";
Debug.ShouldStop(128);
 BA.debugLineNum = 105;BA.debugLine="Dim r, g, b As Float";
Debug.ShouldStop(256);
_r = RemoteObject.createImmutable(0f);Debug.locals.put("r", _r);
_g = RemoteObject.createImmutable(0f);Debug.locals.put("g", _g);
_b = RemoteObject.createImmutable(0f);Debug.locals.put("b", _b);
 BA.debugLineNum = 106;BA.debugLine="Dim hi As Int = Floor(h / 60)";
Debug.ShouldStop(512);
_hi = BA.numberCast(int.class, bitmapcreator.__c.runMethod(true,"Floor",(Object)(RemoteObject.solve(new RemoteObject[] {_h,RemoteObject.createImmutable(60)}, "/",0, 0))));Debug.locals.put("hi", _hi);Debug.locals.put("hi", _hi);
 BA.debugLineNum = 107;BA.debugLine="Dim hbucket As Int =  hi Mod 6";
Debug.ShouldStop(1024);
_hbucket = RemoteObject.solve(new RemoteObject[] {_hi,RemoteObject.createImmutable(6)}, "%",0, 1);Debug.locals.put("hbucket", _hbucket);Debug.locals.put("hbucket", _hbucket);
 BA.debugLineNum = 108;BA.debugLine="Dim f As Float = h / 60 - hi";
Debug.ShouldStop(2048);
_f = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_h,RemoteObject.createImmutable(60),_hi}, "/-",1, 0));Debug.locals.put("f", _f);Debug.locals.put("f", _f);
 BA.debugLineNum = 109;BA.debugLine="Dim p As Float = v * (1 - s)";
Debug.ShouldStop(4096);
_p = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_v,(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_s}, "-",1, 0))}, "*",0, 0));Debug.locals.put("p", _p);Debug.locals.put("p", _p);
 BA.debugLineNum = 110;BA.debugLine="Dim q As Float = v  * (1 - f * s)";
Debug.ShouldStop(8192);
_q = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_v,(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_f,_s}, "-*",1, 0))}, "*",0, 0));Debug.locals.put("q", _q);Debug.locals.put("q", _q);
 BA.debugLineNum = 111;BA.debugLine="Dim t As Float = v * (1 - (1 - f) * s)";
Debug.ShouldStop(16384);
_t = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_v,(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_f}, "-",1, 0)),_s}, "-*",1, 0))}, "*",0, 0));Debug.locals.put("t", _t);Debug.locals.put("t", _t);
 BA.debugLineNum = 112;BA.debugLine="Select hbucket";
Debug.ShouldStop(32768);
switch (BA.switchObjectToInt(_hbucket,BA.numberCast(int.class, 0),BA.numberCast(int.class, 1),BA.numberCast(int.class, 2),BA.numberCast(int.class, 3),BA.numberCast(int.class, 4),BA.numberCast(int.class, 5))) {
case 0: {
 BA.debugLineNum = 114;BA.debugLine="r = v";
Debug.ShouldStop(131072);
_r = _v;Debug.locals.put("r", _r);
 BA.debugLineNum = 115;BA.debugLine="g = t";
Debug.ShouldStop(262144);
_g = _t;Debug.locals.put("g", _g);
 BA.debugLineNum = 116;BA.debugLine="b = p";
Debug.ShouldStop(524288);
_b = _p;Debug.locals.put("b", _b);
 break; }
case 1: {
 BA.debugLineNum = 118;BA.debugLine="r = q";
Debug.ShouldStop(2097152);
_r = _q;Debug.locals.put("r", _r);
 BA.debugLineNum = 119;BA.debugLine="g = v";
Debug.ShouldStop(4194304);
_g = _v;Debug.locals.put("g", _g);
 BA.debugLineNum = 120;BA.debugLine="b = p";
Debug.ShouldStop(8388608);
_b = _p;Debug.locals.put("b", _b);
 break; }
case 2: {
 BA.debugLineNum = 122;BA.debugLine="r = p";
Debug.ShouldStop(33554432);
_r = _p;Debug.locals.put("r", _r);
 BA.debugLineNum = 123;BA.debugLine="g = v";
Debug.ShouldStop(67108864);
_g = _v;Debug.locals.put("g", _g);
 BA.debugLineNum = 124;BA.debugLine="b = t";
Debug.ShouldStop(134217728);
_b = _t;Debug.locals.put("b", _b);
 break; }
case 3: {
 BA.debugLineNum = 126;BA.debugLine="r = p";
Debug.ShouldStop(536870912);
_r = _p;Debug.locals.put("r", _r);
 BA.debugLineNum = 127;BA.debugLine="g = q";
Debug.ShouldStop(1073741824);
_g = _q;Debug.locals.put("g", _g);
 BA.debugLineNum = 128;BA.debugLine="b = v";
Debug.ShouldStop(-2147483648);
_b = _v;Debug.locals.put("b", _b);
 break; }
case 4: {
 BA.debugLineNum = 130;BA.debugLine="r = t";
Debug.ShouldStop(2);
_r = _t;Debug.locals.put("r", _r);
 BA.debugLineNum = 131;BA.debugLine="g = p";
Debug.ShouldStop(4);
_g = _p;Debug.locals.put("g", _g);
 BA.debugLineNum = 132;BA.debugLine="b = v";
Debug.ShouldStop(8);
_b = _v;Debug.locals.put("b", _b);
 break; }
case 5: {
 BA.debugLineNum = 134;BA.debugLine="r = v";
Debug.ShouldStop(32);
_r = _v;Debug.locals.put("r", _r);
 BA.debugLineNum = 135;BA.debugLine="g = p";
Debug.ShouldStop(64);
_g = _p;Debug.locals.put("g", _g);
 BA.debugLineNum = 136;BA.debugLine="b = q";
Debug.ShouldStop(128);
_b = _q;Debug.locals.put("b", _b);
 break; }
}
;
 BA.debugLineNum = 138;BA.debugLine="tempARGB.a = alpha";
Debug.ShouldStop(512);
__ref.getField(false,"_tempargb").setField ("a",_alpha);
 BA.debugLineNum = 139;BA.debugLine="tempARGB.r = r * 255";
Debug.ShouldStop(1024);
__ref.getField(false,"_tempargb").setField ("r",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_r,RemoteObject.createImmutable(255)}, "*",0, 0)));
 BA.debugLineNum = 140;BA.debugLine="tempARGB.g = g * 255";
Debug.ShouldStop(2048);
__ref.getField(false,"_tempargb").setField ("g",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_g,RemoteObject.createImmutable(255)}, "*",0, 0)));
 BA.debugLineNum = 141;BA.debugLine="tempARGB.b = b * 255";
Debug.ShouldStop(4096);
__ref.getField(false,"_tempargb").setField ("b",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_b,RemoteObject.createImmutable(255)}, "*",0, 0)));
 BA.debugLineNum = 142;BA.debugLine="SetARGB(x, y, tempARGB)";
Debug.ShouldStop(8192);
__ref.runClassMethod (b4j.example.bitmapcreator.class, "_setargb",(Object)(_x),(Object)(_y),(Object)(__ref.getField(false,"_tempargb")));
 BA.debugLineNum = 143;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setpremultipliedcolor(RemoteObject __ref,RemoteObject _x,RemoteObject _y,RemoteObject _premultiplied) throws Exception{
try {
		Debug.PushSubsStack("SetPremultipliedColor (bitmapcreator) ","bitmapcreator",2,__ref.getField(false, "ba"),__ref,151);
if (RapidSub.canDelegate("setpremultipliedcolor")) { return __ref.runUserSub(false, "bitmapcreator","setpremultipliedcolor", __ref, _x, _y, _premultiplied);}
RemoteObject _cp = RemoteObject.createImmutable(0);
Debug.locals.put("x", _x);
Debug.locals.put("y", _y);
Debug.locals.put("Premultiplied", _premultiplied);
 BA.debugLineNum = 151;BA.debugLine="Private Sub SetPremultipliedColor (x As Int, y As";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 152;BA.debugLine="Dim cp As Int = x * 4 + y * mWidth * 4";
Debug.ShouldStop(8388608);
_cp = RemoteObject.solve(new RemoteObject[] {_x,RemoteObject.createImmutable(4),_y,__ref.getField(true,"_mwidth"),RemoteObject.createImmutable(4)}, "*+**",1, 1);Debug.locals.put("cp", _cp);Debug.locals.put("cp", _cp);
 BA.debugLineNum = 159;BA.debugLine="mBuffer(cp + ri) = Premultiplied.r";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_mbuffer").setArrayElement (BA.numberCast(byte.class, _premultiplied.getField(true,"r")),RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_ri")}, "+",1, 1));
 BA.debugLineNum = 160;BA.debugLine="mBuffer(cp + gi) = Premultiplied.g";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_mbuffer").setArrayElement (BA.numberCast(byte.class, _premultiplied.getField(true,"g")),RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_gi")}, "+",1, 1));
 BA.debugLineNum = 161;BA.debugLine="mBuffer(cp + bi) = Premultiplied.b";
Debug.ShouldStop(1);
__ref.getField(false,"_mbuffer").setArrayElement (BA.numberCast(byte.class, _premultiplied.getField(true,"b")),RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_bi")}, "+",1, 1));
 BA.debugLineNum = 162;BA.debugLine="mBuffer(cp + ai) = Premultiplied.a";
Debug.ShouldStop(2);
__ref.getField(false,"_mbuffer").setArrayElement (BA.numberCast(byte.class, _premultiplied.getField(true,"a")),RemoteObject.solve(new RemoteObject[] {_cp,__ref.getField(true,"_ai")}, "+",1, 1));
 BA.debugLineNum = 165;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}