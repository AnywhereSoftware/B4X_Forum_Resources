package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class converthandler extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.converthandler", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.converthandler.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 
    public void  innerInitializeHelper(anywheresoftware.b4a.BA _ba) throws Exception{
        innerInitialize(_ba);
    }
    public Object callSub(String sub, Object sender, Object[] args) throws Exception {
        return BA.SubDelegator.SubNotFound;
    }
public anywheresoftware.b4a.keywords.Common __c = null;
public b4j.example.main _main = null;
public b4j.example.b4xcollections _b4xcollections = null;
public String  _class_globals(b4j.example.converthandler __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="converthandler";
RDebugUtils.currentLine=17039360;
 //BA.debugLineNum = 17039360;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=17039361;
 //BA.debugLineNum = 17039361;BA.debugLine="End Sub";
return "";
}
public String  _handle(b4j.example.converthandler __ref,anywheresoftware.b4j.object.JServlet.ServletRequestWrapper _req,anywheresoftware.b4j.object.JServlet.ServletResponseWrapper _resp) throws Exception{
__ref = this;
RDebugUtils.currentModule="converthandler";
if (Debug.shouldDelegate(ba, "handle", false))
	 {return ((String) Debug.delegate(ba, "handle", new Object[] {_req,_resp}));}
String _query = "";
String _html = "";
RDebugUtils.currentLine=17170432;
 //BA.debugLineNum = 17170432;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
RDebugUtils.currentLine=17170434;
 //BA.debugLineNum = 17170434;BA.debugLine="Dim query As String = req.GetParameter(\"text\")";
_query = _req.GetParameter("text");
RDebugUtils.currentLine=17170435;
 //BA.debugLineNum = 17170435;BA.debugLine="If query = Null Then query = \"\" ' Αν δεν υπάρχει,";
if (_query== null) { 
_query = "";};
RDebugUtils.currentLine=17170437;
 //BA.debugLineNum = 17170437;BA.debugLine="Dim html As String";
_html = "";
RDebugUtils.currentLine=17170439;
 //BA.debugLineNum = 17170439;BA.debugLine="html = $\"     <!DOCTYPE html>     <html>     <hea";
_html = ("\n"+"    <!DOCTYPE html>\n"+"    <html>\n"+"    <head>\n"+"        <meta charset=\"UTF-8\">\n"+"        <title>Text-Embedding</title>\n"+"        <style>\n"+"            body { font-family: 'Segoe UI', sans-serif; background: #121212; color: white; text-align: center; padding: 50px; }\n"+"            #res { margin-top: 20px; padding: 15px; background: #1e1e1e; border: 1px solid #333; word-wrap: break-word; font-family: monospace; font-size: 12px; color: #00ffcc; }\n"+"            input { padding: 10px; width: 300px; border-radius: 4px; border: none; }\n"+"            button { padding: 10px 20px; cursor: pointer; background: #007bff; color: white; border: none; border-radius: 4px; }\n"+"        </style>\n"+"    </head>\n"+"    <body>\n"+"        <h2>Convert Text to Text-Embedding...</h2>\n"+"        <input type=\"text\" id=\"query\" value=\""+__c.SmartStringFormatter("",(Object)(_query))+"\" placeholder=\"Write something...\">\n"+"        <button onclick=\"sendQuery()\">Send</button>\n"+"        <div id=\"res\">Result will come here...</div>\n"+"\n"+"        <script src=\"/b4j_ws.js\"></script>\n"+"		<script>\n"+"            var b4j_ws;\n"+"            b4j_connect(\"/ws_search\"); \n"+"\n"+"            var checkConnection = setInterval(function() {\n"+"                // Το readyState 1 σημαίνει ότι η γραμμή είναι OPEN και έτοιμη\n"+"                if (typeof b4j_ws !== 'undefined' && b4j_ws.readyState === 1) {\n"+"                    clearInterval(checkConnection); // Σταματάμε το χρονόμετρο\n"+"                    \n"+"                    var txt = document.getElementById(\"query\").value;\n"+"                    if(txt !== \"\") {\n"+"                        sendQuery(); // Εκτέλεση αναζήτησης!\n"+"                    }\n"+"                }\n"+"            }, 100); // Κάνει έλεγχο κάθε 100 milliseconds (0.1 δευτερόλεπτο)\n"+"\n"+"            function sendQuery() {\n"+"                var txt = document.getElementById(\"query\").value;\n"+"                if(txt) {\n"+"                    b4j_raiseEvent(\"get_vector\", {text: txt});\n"+"                    document.getElementById(\"res\").innerText = \"Processing in Python... Please wait.\";\n"+"                }\n"+"            }\n"+"\n"+"            function receiveVector(data) {\n"+"                document.getElementById(\"res\").innerText = data;\n"+"            }\n"+"        </script>\n"+"    </body>\n"+"    </html>\n"+"    ");
RDebugUtils.currentLine=17170491;
 //BA.debugLineNum = 17170491;BA.debugLine="resp.ContentType = \"text/html\"";
_resp.setContentType("text/html");
RDebugUtils.currentLine=17170492;
 //BA.debugLineNum = 17170492;BA.debugLine="resp.CharacterEncoding = \"UTF-8\"";
_resp.setCharacterEncoding("UTF-8");
RDebugUtils.currentLine=17170493;
 //BA.debugLineNum = 17170493;BA.debugLine="resp.Write(html)";
_resp.Write(_html);
RDebugUtils.currentLine=17170494;
 //BA.debugLineNum = 17170494;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4j.example.converthandler __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="converthandler";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=17104896;
 //BA.debugLineNum = 17104896;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=17104897;
 //BA.debugLineNum = 17104897;BA.debugLine="End Sub";
return "";
}
}