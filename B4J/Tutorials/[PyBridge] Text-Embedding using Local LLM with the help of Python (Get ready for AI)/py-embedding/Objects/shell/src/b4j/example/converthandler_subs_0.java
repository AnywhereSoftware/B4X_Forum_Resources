package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class converthandler_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _handle(RemoteObject __ref,RemoteObject _req,RemoteObject _resp) throws Exception{
try {
		Debug.PushSubsStack("Handle (converthandler) ","converthandler",3,__ref.getField(false, "ba"),__ref,8);
if (RapidSub.canDelegate("handle")) { return __ref.runUserSub(false, "converthandler","handle", __ref, _req, _resp);}
RemoteObject _query = RemoteObject.createImmutable("");
RemoteObject _html = RemoteObject.createImmutable("");
Debug.locals.put("req", _req);
Debug.locals.put("resp", _resp);
 BA.debugLineNum = 8;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
Debug.ShouldStop(128);
 BA.debugLineNum = 10;BA.debugLine="Dim query As String = req.GetParameter(\"text\")";
Debug.ShouldStop(512);
_query = _req.runMethod(true,"GetParameter",(Object)(RemoteObject.createImmutable("text")));Debug.locals.put("query", _query);Debug.locals.put("query", _query);
 BA.debugLineNum = 11;BA.debugLine="If query = Null Then query = \"\" ' Αν δεν υπάρχει,";
Debug.ShouldStop(1024);
if (RemoteObject.solveBoolean("n",_query)) { 
_query = BA.ObjectToString("");Debug.locals.put("query", _query);};
 BA.debugLineNum = 13;BA.debugLine="Dim html As String";
Debug.ShouldStop(4096);
_html = RemoteObject.createImmutable("");Debug.locals.put("html", _html);
 BA.debugLineNum = 15;BA.debugLine="html = $\"     <!DOCTYPE html>     <html>     <hea";
Debug.ShouldStop(16384);
_html = (RemoteObject.concat(RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("    <!DOCTYPE html>\n"),RemoteObject.createImmutable("    <html>\n"),RemoteObject.createImmutable("    <head>\n"),RemoteObject.createImmutable("        <meta charset=\"UTF-8\">\n"),RemoteObject.createImmutable("        <title>Text-Embedding</title>\n"),RemoteObject.createImmutable("        <style>\n"),RemoteObject.createImmutable("            body { font-family: 'Segoe UI', sans-serif; background: #121212; color: white; text-align: center; padding: 50px; }\n"),RemoteObject.createImmutable("            #res { margin-top: 20px; padding: 15px; background: #1e1e1e; border: 1px solid #333; word-wrap: break-word; font-family: monospace; font-size: 12px; color: #00ffcc; }\n"),RemoteObject.createImmutable("            input { padding: 10px; width: 300px; border-radius: 4px; border: none; }\n"),RemoteObject.createImmutable("            button { padding: 10px 20px; cursor: pointer; background: #007bff; color: white; border: none; border-radius: 4px; }\n"),RemoteObject.createImmutable("        </style>\n"),RemoteObject.createImmutable("    </head>\n"),RemoteObject.createImmutable("    <body>\n"),RemoteObject.createImmutable("        <h2>Convert Text to Text-Embedding...</h2>\n"),RemoteObject.createImmutable("        <input type=\"text\" id=\"query\" value=\""),converthandler.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_query))),RemoteObject.createImmutable("\" placeholder=\"Write something...\">\n"),RemoteObject.createImmutable("        <button onclick=\"sendQuery()\">Send</button>\n"),RemoteObject.createImmutable("        <div id=\"res\">Result will come here...</div>\n"),RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("        <script src=\"/b4j_ws.js\"></script>\n"),RemoteObject.createImmutable("		<script>\n"),RemoteObject.createImmutable("            var b4j_ws;\n"),RemoteObject.createImmutable("            b4j_connect(\"/ws_search\"); \n"),RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("            var checkConnection = setInterval(function() {\n"),RemoteObject.createImmutable("                // Το readyState 1 σημαίνει ότι η γραμμή είναι OPEN και έτοιμη\n"),RemoteObject.createImmutable("                if (typeof b4j_ws !== 'undefined' && b4j_ws.readyState === 1) {\n"),RemoteObject.createImmutable("                    clearInterval(checkConnection); // Σταματάμε το χρονόμετρο\n"),RemoteObject.createImmutable("                    \n"),RemoteObject.createImmutable("                    var txt = document.getElementById(\"query\").value;\n"),RemoteObject.createImmutable("                    if(txt !== \"\") {\n"),RemoteObject.createImmutable("                        sendQuery(); // Εκτέλεση αναζήτησης!\n"),RemoteObject.createImmutable("                    }\n"),RemoteObject.createImmutable("                }\n"),RemoteObject.createImmutable("            }, 100); // Κάνει έλεγχο κάθε 100 milliseconds (0.1 δευτερόλεπτο)\n"),RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("            function sendQuery() {\n"),RemoteObject.createImmutable("                var txt = document.getElementById(\"query\").value;\n"),RemoteObject.createImmutable("                if(txt) {\n"),RemoteObject.createImmutable("                    b4j_raiseEvent(\"get_vector\", {text: txt});\n"),RemoteObject.createImmutable("                    document.getElementById(\"res\").innerText = \"Processing in Python... Please wait.\";\n"),RemoteObject.createImmutable("                }\n"),RemoteObject.createImmutable("            }\n"),RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("            function receiveVector(data) {\n"),RemoteObject.createImmutable("                document.getElementById(\"res\").innerText = data;\n"),RemoteObject.createImmutable("            }\n"),RemoteObject.createImmutable("        </script>\n"),RemoteObject.createImmutable("    </body>\n"),RemoteObject.createImmutable("    </html>\n"),RemoteObject.createImmutable("    ")));Debug.locals.put("html", _html);
 BA.debugLineNum = 67;BA.debugLine="resp.ContentType = \"text/html\"";
Debug.ShouldStop(4);
_resp.runMethod(true,"setContentType",BA.ObjectToString("text/html"));
 BA.debugLineNum = 68;BA.debugLine="resp.CharacterEncoding = \"UTF-8\"";
Debug.ShouldStop(8);
_resp.runMethod(true,"setCharacterEncoding",BA.ObjectToString("UTF-8"));
 BA.debugLineNum = 69;BA.debugLine="resp.Write(html)";
Debug.ShouldStop(16);
_resp.runVoidMethod ("Write",(Object)(_html));
 BA.debugLineNum = 70;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (converthandler) ","converthandler",3,__ref.getField(false, "ba"),__ref,5);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "converthandler","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 5;BA.debugLine="Public Sub Initialize";
Debug.ShouldStop(16);
 BA.debugLineNum = 6;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}