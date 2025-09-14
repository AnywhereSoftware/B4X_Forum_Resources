B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Custom View class
#Event: Loaded

'V1.1
'	Added change font size
'	Added hide line numbes
'	Fixed issue in CodeMirror library where it was not possible to select text with the mouse.
'		'CodeMirror Library patched as per - https://github.com/codemirror/CodeMirror/issues/5733
'
'V1.2
'	changed HTML template For better loading And consistency.
'	Implemented encodebase64 For text transfer
'	now a proper wrapper, all required calls are in the CodeEditorWrapper
'	improved syntax highlighting
'
'V1.3
'	Added most of the available languages
'	Added b4x.js to the proper structure within CodeMirror mode folder and Meta.js
'	Added new code module to Map App Names to mime types
'	Added and implemented autoLoad addon to select language by MimeType
'	Changes to the CodeMirror library - requires downloading new version
'
'V1.4
'	Added doc.clearHistory to setCode to stop undo removing the new code
'	Added #javacompilerpath to ide parameter words.
'	requires download of codemirrorlib


Sub Class_Globals
	Private fx As JFX
	Private XUI As XUI
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As Pane
	Private WebView1 As WebView
	Public WebE As WebEngine
	Private JS As jScriptEngine
	Type B4xCallsType(module As Object, EventName As String)
	Private B4xCalls As Map
	
	'Wrapper variables
	Private CurrentStyle, MimeType As String
	Private mCodeMirrorPath As String
	Private mFontSize As Int = 12
	Private mFontUnit As String = "pt"
	Private mShowLineNumbers As String = "true"
	Private Loaded As Boolean
	Private mWidth As Int
	Private mHeight As Int
	Private Code As String
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
End Sub

Public Sub DesignerCreateView (Base As Pane, Lbl As Label, Props As Map)
	mBase = Base
	'Initial Values
	mWidth = mBase.Width
	mHeight = mBase.Height

'	mBase.AddNode(WebView1,0,0,mBase.PrefWidth,mBase.PrefHeight)
	mBase.LoadLayout("codeeditorwrapper")
	WebE = WebEngine_Static.New(WebView1)
	
	WebE.SetOnAlert(Me,"JSAlert")
	WebE.SetOnError(Me,"JSError")
	
	B4xCalls.Initialize
	RegisterB4XCall("JsLog",Me,"Js_Log")
	WebE.AddWorkerListener(Me,"LoadProgress")
End Sub

Private Sub LoadProgress_Event (NewState As String)
	
	If NewState  = "SUCCEEDED" Then
		Log("Page LOADED")
		'Setup the javascript interface
		Set_Bridge
		Loaded = True
		Dim Su As StringUtils
		ExecuteScript($"setCode("${Su.EncodeBase64(Code.GetBytes("UTF8"))}");"$)
		ExecuteScript($"changeType("${MimeType}")"$)
		SetSize(mWidth + 10, mHeight + 10)
		CallSub(mCallBack,mEventName & "_Loaded")
	End If
End Sub


Private Sub Base_Resize (Width As Double, Height As Double)
	SetSize(Width,Height)
End Sub

Public Sub GetBase As Pane
	Return mBase
End Sub

'###############################################################################
#Region JS interface subs
'###############################################################################

'Register a Javascript callback and map it to the required B4xSub
Sub RegisterB4XCall(CallName As String,Module As Object,EventName As String)
	Dim B4xCall As B4xCallsType
	B4xCall.Initialize
	B4xCall.Module = Module
	B4xCall.EventName = EventName
	B4xCalls.Put(CallName,B4xCall)
End Sub

'Call a registered sub with no parameters
Sub CallB4x(CallName As String) As Object															'Ignore
	Dim B4xCall As B4xCallsType = B4xCalls.Get(CallName)
	If B4xCall = Null Then
		Log("B4xCall " & CallName & " not registered")
		Return Null
	End If
	If SubExists(B4xCall.Module,B4xCall.EventName) Then
		Return CallSub(B4xCall.Module,B4xCall.EventName)
	Else
		Log("Sub " & B4xCall.EventName & " Not found")
		Return Null
	End If
End Sub

'Call a registered sub with 1 parameter
Sub CallB4x2(CallName As String, Param1 As Object) As Object										'ignore
	Dim B4xCall As B4xCallsType = B4xCalls.Get(CallName)
'	Log(B4xCall)
	If B4xCall = Null Then
		Log("B4xCall " & CallName & " not registered")
		Return Null
	End If
	If SubExists(B4xCall.Module,B4xCall.EventName) Then
		Return CallSub2(B4xCall.Module,B4xCall.EventName,Param1)
	Else
		Log("Sub " & B4xCall.EventName & " Not found")
		Return Null
	End If
	
End Sub

'Call a registered sub with 2 parameters
Sub CallB4x3(CallName As String,Param1 As Object,Param2 As Object) As Object						'ignore
	Dim B4xCall As B4xCallsType = B4xCalls.Get(CallName)
	If B4xCall = Null Then
		Log("B4xCall " & CallName & " not registered")
		Return Null
	End If
	If SubExists(B4xCall.Module,B4xCall.EventName) Then
		Return CallSub3(B4xCall.Module,B4xCall.EventName,Param1,Param2)
	Else
		Log("Sub " & B4xCall.EventName & " Not found")
		Return Null
	End If
End Sub

'Capture Javascript events
Private Sub JSAlert_Event(Args() As Object)
	Dim Msg As String
	If GetType(Args(0)) = "javafx.scene.web.WebErrorEvent" Then
		Msg = AsJO(Args(0)).RunMethod("getMessage",Null)
	Else
		Msg = AsJO(Args(0)).RunMethod("getData",Null)
	End If
'	If Msg = "done" Then RunJS("alert(window.b4j)")
	Log("JSALERT : **************************************************************")
	Log("JSALERT : " & Msg)
	Log("JSALERT : **************************************************************")
'	If Msg = "done" Then Log(getHTMLText)
End Sub

Private Sub JSError_Event(Args() As Object)
	Dim Msg As String
	If GetType(Args(0)) = "javafx.scene.web.WebErrorEvent" Then
		Msg = ASJO(Args(0)).RunMethod("getMessage",Null)
	Else
		Msg = ASJO(Args(0)).RunMethod("getData",Null)
	End If
	Log("JSError : **************************************************************")
	Log("JSError : " & Msg)
	Log("JSError : **************************************************************")
End Sub

'Receiving calls from JS console.log
Private Sub Js_Log(text As Object)
	Log("JScl: " & text)
End Sub

'Call java code to setup the JS Bridge
Private Sub Set_Bridge
	Dim MeJo As JavaObject = Me
	MeJo.RunMethod("setBridge",Array(WebE.GetObject))
End Sub

#End Region JS Interface subs


#Region Wrapper Subs

Private Sub ASJO(JO As JavaObject) As JavaObject
	Return JO
End Sub

Public Sub setCodeMirrorPath(CMP As String)
	mCodeMirrorPath = CMP
End Sub

Public Sub Load(URL As String)
	Loaded = False
	WebE.Load(URL)
End Sub

'get the current code
Public Sub GetCode As String
	Return ExecuteScript("editor.getValue();")
End Sub

Public Sub GetSelectedCode As String
	Return ExecuteScript("editor.getSelection();")
End Sub

Public Sub SetSize(Width As Double, Height As Double)
	mWidth = Width - 10
	mHeight = Height - 10
	If Loaded = False Then Return
	ExecuteScript($"editor.setSize(${mWidth},${mHeight})"$)
End Sub

public Sub SetFontSize(FontSize As Int, FontUnit As String)
	mFontSize = FontSize
	mFontUnit = FontUnit
	If Loaded = False Then Return
	ExecuteScript($"editor.getWrapperElement().style["font-size"] = ${mFontSize}+"${mFontUnit}";editor.refresh();"$)
End Sub

Public Sub ShowLineNos(ShowLineNumbers As Boolean)
	Dim Show As String = "false"
	If ShowLineNumbers Then Show = "true"
	mShowLineNumbers = Show
	If Loaded = False Then Return
	ExecuteScript($"editor.setOption("lineNumbers", ${Show});"$)
End Sub

Public Sub Setstyle(Style As String)
	CurrentStyle = Style
	MimeType = CEW_Utils.getMimeType(CurrentStyle)
	If Loaded Then ExecuteScript($"changeType("${MimeType}")"$)
End Sub

Public Sub SetCode(NewCode As String)
	Code = NewCode
	'Delete the HTML for the last style used.
	If File.Exists(XUI.DefaultFolder,$"WCE-${CurrentStyle}.HTML"$) Then
		File.Delete(XUI.DefaultFolder,$"WCE-${CurrentStyle}.HTML"$)
	End If
	UpdatePage
End Sub

private Sub UpdatePage
	CreateEditingTemplateFile
	Loaded = False
	Load(File.GetUri(XUI.DefaultFolder,$"WCE-${CurrentStyle}.HTML"$))
End Sub

'Replace the {code} tag with the actual code we want to edit.
'Private Sub applyEditingTemplate(Code As String) As String
'	Return EditingTemplate.Replace("{code}",Code) & CRLF
'End Sub


'Write the template to the application folder (easier than writing to temp while debugging).
Private Sub CreateEditingTemplateFile
	Dim Template As String = EditingTemplate
	File.WriteString(XUI.DefaultFolder,$"WCE-${CurrentStyle}.HTML"$,Template)
End Sub

'Create an HTML file from the template with the links to the specified language mode.
Private Sub EditingTemplate As String


	Dim CSSFileURI As String = $"${mCodeMirrorPath}/lib/codemirror.css"$
	Dim CodeFileURI As String = $"${mCodeMirrorPath}/lib/codemirror.js"$
	Dim AddonPath As String =  $"${mCodeMirrorPath}/addon/mode/loadmode.js"$
	Dim MetaPath As String =  $"${mCodeMirrorPath}/mode/meta.js"$
	Dim ModeURL As String =   $"${mCodeMirrorPath}/mode/%N/%N.js"$

	Return $"
<!doctype html
<html>
  <head>
   <link rel="stylesheet" href="${CSSFileURI}" />
   <link rel="stylesheet" href="wrapper.css" />
   <script src="${CodeFileURI}"></script>
   <script src="${AddonPath}"></script>
   <script src="${MetaPath}"></script>
   <script src="wrapper.js"></script>
   <style>
   		body{
   			overflow:hidden;
   		}
   		.CodeMirror{
			width: ${mWidth}px;
			height: ${mHeight}px;
			font-size: ${mFontSize}${mFontUnit};
		}
   </style>
  </head>
 <body>
 </body>
   <script>
   	var doc;
   	CodeMirror.modeURL = "${ModeURL}";
    var editor = CodeMirror(document.body, {
        lineNumbers: ${mShowLineNumbers},
        matchBrackets: true,
		indentUnit: 4
      });
	  //Set event For callback To B4j when the Code changes
	  editor.on('change',function(cm, change){
		  	callB4j("codechanged",change.text);
			//console.log("call commented");
	  });
	  function setCode(Code){
		editor.setValue(atob(Code));
		doc = editor.getDoc();
		doc.clearHistory();
	  }
	  
	function changeType(val){
		var mode,spec,m;
		if (m = /.+\.([^.]+)$/.exec(val)) {
	    	var info = CodeMirror.findModeByExtension(m[1]);
	    	if (info) {
	      		mode = info.mode;
	      		spec = info.mime;
	    	}
  		} else if (/\//.test(val)) {
    		var info = CodeMirror.findModeByMIME(val);
    		if (info) {
      		mode = info.mode;
      		spec = val;
    	}
  	} else {
    	mode = spec = val;
  	}
  	if (mode) {
    	editor.setOption("mode", spec);
    	CodeMirror.autoLoadMode(editor, mode);
  	} else {
    	console.log("Could not find a mode corresponding to " + val);
  	}
  }
	  
    </script>

</html>"$
End Sub

#End Region Wrapper Subs

'###############################################################################
#Region JS Functions
'###############################################################################

Public Sub SetJSVar(VarName As String, Content As Object)
	JS.evalString($"var ${VarName} = ${Content}"$)
End Sub

Public Sub ExecuteScript(Script As String) As Object
	Return WebE.ExecuteScript(Script)
End Sub
'###############################################################################
#End Region JS Functions

#Region java
'Java
#if java
import netscape.javascript.JSObject;
import javafx.scene.web.WebEngine;
import anywheresoftware.b4a.BA.RaisesSynchronousEvents;

//Needs to be a global variable otherwise it appears to be garbage collected.
Bridge b;

public class Bridge{
    public Object callB4j(String sub,String funct) { // for call with no parameters
		return ba.raiseEvent2(this, false,sub.toLowerCase(),true, funct);
	}
    public Object callB4j2(String sub,String funct, Object arg) { // for call with  1 param
		return ba.raiseEvent2(this, false, sub.toLowerCase() , true, funct, arg);
	}
	public Object callB4j3(String sub, String funct,Object arg1, Object arg2) { // for call with  2 params
		return ba.raiseEvent2(this, false,sub.toLowerCase() ,true, funct,arg1 ,arg2);
	}
}
public void setBridge(WebEngine we) {
	
	JSObject jsobj = (JSObject) we.executeScript("window");
	b = new Bridge();
	jsobj.setMember("b4j", b);
	
	}
#end if

#End Region java