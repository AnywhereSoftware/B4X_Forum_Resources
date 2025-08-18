###  send string msg from WebView js 2 B4J - and from B4J to WebView javascript by a6000000
### 10/17/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/123547/)

![](https://www.b4x.com/android/forum/attachments/101626)  
  
download zip :  
<http://www.mediafire.com/file/i5oudy5ila1d8al/30js2B4J2js.zip/file>  
  
  
  
// JSBridge, executejavascript, setBridge(WebEngine we), we.executeScript("window"), class Bridge, javafx.scene.web.WebEngine  
  
  

```B4X
 '  B4J  !  
#Region  Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
' wvtest30  js2B4J2js  
' https://www.b4x.com/android/forum/threads/making-upcalls-from-javascript-to-javafx.51794/post-771868  
' https://www.b4x.com/android/forum/threads/b4j-jscriptengine-jsbridge-js-webviev-to-b4j-to-js-working-example.123516/post-771874  
' http://www.mediafire.com/file/q3x4mabuxhp8981/8_B4J2jsBRIDGE.zip/file  
' see https://www.b4x.com/android/forum/threads/jscriptengine.35781/  
' see https://www.b4x.com/android/forum/threads/making-upcalls-from-javascript-to-javafx.51794/#post-374183  
  
' lib  
' JavaObject 2.06, JCore 7.51, jFX 8.30  
  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
  
    Dim wv As WebView  
    Dim we, wvjo As JavaObject  
  
    'wv js to B4J  
    Private TextArea1 As TextArea  
    Private Button1 As Button  
    Public htmname As String = "wv30.html"  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("1") 'Load the layout file.  
    MainForm.Show  
  
    we = asJO(wv).RunMethod("getEngine",Null)  
    asJO(Me).RunMethod("setBridge",Array(we))  
  
    wv.LoadUrl("file:///../B4X/" & htmname)  'c:/B4X/wv30.html  
    Wait For wv_PageFinished (Url As String)  
End Sub  
  
Sub asJO(o As JavaObject) As JavaObject  
    Return o  
End Sub  
  
Sub teststr(s As String)  
    Log("teststr " & s)  
    TextArea1.Text = s  
End Sub  
  
Sub testint(ii As Int)  
    Log("testint " & ii)  
    TextArea1.Text = ii  
End Sub  
  
'B4J2wv  
Sub ExecuteJavaScript (wv2 As WebView, script As String) As Object  
    Dim jo As JavaObject = wv2  
    Return jo.RunMethodJO("getEngine", Null).RunMethod("executeScript", Array(script))  
End Sub  
  
Sub Button1_Click  
    Dim jstr As String = TextArea1.Text  
    jstr = "B4J2wv("""  &  jstr  & """)"  
    Log(jstr)  
    ExecuteJavaScript(wv, jstr)  
End Sub  
'B4J2wv end  
  
  
#if java  
import netscape.javascript.JSObject;  
import javafx.scene.web.WebEngine;  
import java.lang.RuntimeException;  
import java.lang.IllegalAccessException;  
import java.lang.reflect.InvocationTargetException;  
  
import java.lang.Enum;  
import java.lang.reflect.Method;  
import javafx.application.Platform;  
  
  
public static class Bridge{  
    public void link(String sub) {  
        try{  
            Class<?> c = Class.forName("b4j.wvtest21.main");  
            final Method m = c.getDeclaredMethod("_" + sub.toLowerCase());  
            final Object dummy = null;  
            Platform.runLater(new Runnable(){  
                public void run(){  
                    try{  
                        m.invoke(dummy);  
                    }catch (IllegalAccessException e){  
                        System.out.println(e);  
                    }catch (InvocationTargetException ite){  
                        System.out.println(ite);  
                    }  
                }  
            });  
        } catch (Exception e){  
            System.out.println(e);  
        }  
    }  
    public void link2(String sub,Object arg) {   // for call with  1 param  
        boolean isInt = false;  
        int ti = 0;  
        try{  
            Class<?> c = Class.forName("b4j.wvtest21.main");  
            Class<?> ac = arg.getClass();  
            /*  
                    Sub Subname(s As String)  
                        Log(s)  
                    End Sub  
              forum change line: Then it will call the sub with an Object parameter is Sub subname(ob As Object)  
                Class<?> ac = Object.class;  
                    Sub Subname(ob As Object)  
                        Log(ob)  
                    End Sub  
            */  
            if (arg instanceof java.lang.Integer){  
                ac = int.class;  
            }  
            final Method m = c.getDeclaredMethod("_" + sub.toLowerCase(),ac);  
            final Object dummy = null;  
            final Object xarg = arg;  
            Platform.runLater(new Runnable(){  
                public void run(){  
                    try{  
                        m.invoke(dummy,xarg);  
                    }catch (IllegalAccessException e){  
                        System.out.println(e);  
                    }catch (InvocationTargetException ite){  
                    }  
                }  
            });  
        } catch (Exception e){  
            System.out.println(e);  
        }  
    }  
  
}  
public static void setBridge(WebEngine we){  
    JSObject jsobj = (JSObject) we.executeScript("window");  
    Bridge b = new Bridge();  
    jsobj.setMember("b4j", b);  
}  
#end if  
  
  
#Region designer 1.bjl  
#If txttxt  
  
    WebView: wv  
  
     ——  
  
    Label1:"in B4J"  
    TextArea1:" ", Button1: "send to WebView"  
  
#End If  
#End Region  
  
  
#Region show content of  'c:/B4X/wv30.html  
#If txtxt  
  
<!doctype html><html lang="en-US">  
<head>  
<script type="text/javascript">  
    // B4JSub2jsWV  
    function B4J2wv(message){  
        document.getElementById("inputField").value = message;  
    }  
    // jsWV2B4JSub  
    function wv2B4J(){  
       var msg = document.getElementById("inputField").value;  
       b4j.link2('teststr',msg)  
    }  
    function wvInt2B4J(){  
       var msg = document.getElementById("inputInt").value;  
       msg = parseInt(0 + msg)  
       b4j.link2('testint',  msg )  
    }  
</script>  
<style>  
    .tit {  
        color:#b69221;  
        font-size:300%;  
        margin-top:-11px;  
    }  
    body {  
       background-color:#fbd7bd;  
    }  
</style></head>  
<body>  
<center><h1 class="tit">in WebView </h1></center>  
    <input id="inputField"  type="text" value="">  
    <input onClick="wv2B4J()"  type="button" value="send str to B4J"/>  
    <br>  
    <input id="inputInt"  type="text" value="">  
    <input onClick="wvInt2B4J()"  type="button" value="send int to B4J"/>  
    <!–input id="inputFieldtest"  type="text" value="test">  
    <br><button Type="button" onClick="myfunction()">Click myfunc</button–>  
</body></html>  
  
  
#End If  
#End Region
```