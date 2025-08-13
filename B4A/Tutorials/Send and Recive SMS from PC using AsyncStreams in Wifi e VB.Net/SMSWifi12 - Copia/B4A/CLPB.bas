B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
Private Sub Class_Globals
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

Public Sub GetText As String
	Dim r As Reflector
	Dim jo As JavaObject
	'jo.InitializeStatic(Application.PackageName & ".clpb.nhmyclipboard")
	jo = Me
	Dim sOk As String
	sOk = jo.RunMethod("GetTextFromClipboard", Array As Object(r.GetContext))
	Return sOk
End Sub


Public Sub SetText(txt As String) As Boolean
	Dim r As Reflector
	Dim jo As JavaObject
	jo = Me
	Dim bOk As Boolean
	bOk = jo.RunMethod("SetTextToClipboard", Array As Object(txt, r.GetContext))
	Return bOk
End Sub


Public Sub ClipboardHasText As Boolean
	Dim jo As JavaObject
	Dim r As Reflector
	jo = Me
	Dim bOk As Boolean
	bOk = jo.RunMethod("HasTextCopied", Array As Object(r.GetContext))
	Return bOk
End Sub


#IF JAVA

import android.content.ClipboardManager;
import android.content.ClipData;
import android.content.ClipDescription;
import android.content.Context; 

public Boolean SetTextToClipboard(Object objtxt, Object mObjContext) {
	try{
		String txt = (String) objtxt;
		Context mContext = (Context) mObjContext;
		ClipboardManager myClipboard = (ClipboardManager) mContext.getSystemService("clipboard"); 
		ClipData myClip;
		myClip = ClipData.newPlainText("text", txt);
		myClipboard.setPrimaryClip(myClip);
		return true;
	}	
	catch(Exception ex){
		return false;
	}
};

public String GetTextFromClipboard(Object mObjContext) {
	Context mContext = (Context) mObjContext;
	ClipboardManager myClipboard = (ClipboardManager) mContext.getSystemService("clipboard"); 
	ClipData myClip = myClipboard.getPrimaryClip();
	ClipData.Item item = myClip.getItemAt(0);
	String txt = item.getText().toString();
	return txt;
};


public Boolean HasTextCopied(Object mObjContext) {
Context mContext = (Context) mObjContext;
ClipboardManager myClipboard = (ClipboardManager) mContext.getSystemService("clipboard");
if (!(myClipboard.hasPrimaryClip())) {
	return false;
} else if (!(myClipboard.getPrimaryClipDescription().hasMimeType("text/plain"))) {
	return false;
} else {
	return true;
}
};

#End If

