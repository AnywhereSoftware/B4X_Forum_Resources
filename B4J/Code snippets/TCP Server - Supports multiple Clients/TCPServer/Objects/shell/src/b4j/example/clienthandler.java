
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class clienthandler {
    public static RemoteObject myClass;
	public clienthandler() {
	}
    public static PCBA staticBA = new PCBA(null, clienthandler.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _fx = RemoteObject.declareNull("anywheresoftware.b4j.objects.JFX");
public static RemoteObject _clientsocket = RemoteObject.declareNull("anywheresoftware.b4a.objects.SocketWrapper");
public static RemoteObject _ast = RemoteObject.declareNull("anywheresoftware.b4a.randomaccessfile.AsyncStreams");
public static RemoteObject _id = RemoteObject.createImmutable("");
public static b4j.example.main _main = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"AST",_ref.getField(false, "_ast"),"ClientSocket",_ref.getField(false, "_clientsocket"),"fx",_ref.getField(false, "_fx"),"ID",_ref.getField(false, "_id")};
}
}