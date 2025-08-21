
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class bitmapcreator {
    public static RemoteObject myClass;
	public bitmapcreator() {
	}
    public static PCBA staticBA = new PCBA(null, bitmapcreator.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _mbuffer = null;
public static RemoteObject _mwidth = RemoteObject.createImmutable(0);
public static RemoteObject _mheight = RemoteObject.createImmutable(0);
public static RemoteObject _ai = RemoteObject.createImmutable(0);
public static RemoteObject _ri = RemoteObject.createImmutable(0);
public static RemoteObject _gi = RemoteObject.createImmutable(0);
public static RemoteObject _bi = RemoteObject.createImmutable(0);
public static RemoteObject _tempargb = RemoteObject.declareNull("b4j.example.bitmapcreator._argbcolor");
public static RemoteObject _temppm = RemoteObject.declareNull("b4j.example.bitmapcreator._premultipliedcolor");
public static RemoteObject _temppm2 = RemoteObject.declareNull("b4j.example.bitmapcreator._premultipliedcolor");
public static RemoteObject _writeableimage = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
public static RemoteObject _targetrect = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XCanvas.B4XRect");
public static RemoteObject _unsignedff = RemoteObject.createImmutable(0);
public static b4j.example.main _main = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"ai",_ref.getField(false, "_ai"),"bi",_ref.getField(false, "_bi"),"gi",_ref.getField(false, "_gi"),"mBuffer",_ref.getField(false, "_mbuffer"),"mHeight",_ref.getField(false, "_mheight"),"mWidth",_ref.getField(false, "_mwidth"),"ri",_ref.getField(false, "_ri"),"TargetRect",_ref.getField(false, "_targetrect"),"tempARGB",_ref.getField(false, "_tempargb"),"tempPM",_ref.getField(false, "_temppm"),"tempPM2",_ref.getField(false, "_temppm2"),"UnsignedFF",_ref.getField(false, "_unsignedff"),"WriteableImage",_ref.getField(false, "_writeableimage")};
}
}