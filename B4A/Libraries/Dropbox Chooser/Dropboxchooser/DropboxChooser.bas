Type=Class
Version=5.2
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
'Class module
'Dropbox Chooser Library - Documentation is at https://www.dropbox.com/developers/chooser#android
Sub Class_Globals
	Private Chooser As JavaObject
	Private mModule As Object
	Private mEventName As String
	Dim ResultType As ENumClass
	Public ion As Object
End Sub

'Initialize the Dropbox chooser - Module and Eventname for the callback methods, appkey as provided by dropbox when
'registering your app.
Public Sub Initialize(Module As Object,EventName As String,AppKey As String)
	mModule = Module
	mEventName = EventName
	Chooser.InitializeNewInstance("com.dropbox.chooser.android.DbxChooser",Array(AppKey))
	ResultType.Initialize("com.dropbox.chooser.android.DbxChooser.ResultType")
End Sub

'Show the Dropbox chooser, ShowType should be one of: preview, direct or content in line with the Link Types in the
'API documentation
Sub Show(ShowType As String)
	Dim RType As String
	Select ShowType.ToLowerCase
		Case "preview"
			RType = ResultType.ValueOf("PREVIEW_LINK")
		Case "direct"
			RType = ResultType.ValueOf("DIRECT_LINK")
		Case "content"
			RType = ResultType.ValueOf("FILE_CONTENT")
	End Select
	
	Dim NativeMe As JavaObject = Me
	Dim RequestCode As Int = NativeMe.RunMethod("setDummyIntent",Null)
	
	Dim Ctx As JavaObject
	Chooser.RunMethodJO("forResultType",Array(RType)).RunMethod("launch",Array(Ctx.InitializeContext,RequestCode))
End Sub

Private Sub DB_Result(Result As Object)
	Dim DCR As DropboxChooserResult
	DCR.Initialize(Result)
	If SubExists(mModule, mEventName & "_Result") Then
		CallSub2(mModule, mEventName & "_Result", DCR)
	End If
End Sub

Private Sub DB_Failed
	If SubExists(mModule, mEventName & "_Failed") Then
		CallSub(mModule, mEventName & "_Failed")
	End If
End Sub

#if java

import 	android.content.Intent;
import 	android.content.Context;
import java.lang.reflect.Field;
import anywheresoftware.b4a.IOnActivityResult;
import com.dropbox.chooser.android.DbxChooser;

//Interface for callback from start activity

public interface IOnActivityResult {
    void ResultArrived(int resultCode, Intent intent);
}

public anywheresoftware.b4a.IOnActivityResult ion;

//Workaround for registering a IOnActivityResult sent by a library from
//http://www.b4x.com/android/forum/threads/java-guide-using-onactivityresult.7297/#post-174874

public int setDummyIntent(){
	
	ion = new anywheresoftware.b4a.IOnActivityResult(){
		@SuppressWarnings("unchecked")
        @Override
		public void ResultArrived(int resultCode, Intent intent){
			if(resultCode  == -1){
				DbxChooser.Result result = new DbxChooser.Result(intent);
				ba.raiseEvent(this, "db_result",(Object) result);
			} else {
				ba.raiseEvent(this, "db_failed");
			}
		}
	};
	
	try {
	//-- passing null instead of an intent
         ba.startActivityForResult(ion, null); 
      } catch (NullPointerException npe) {
         //required...
      }
      BA.SharedProcessBA sba = ba.sharedProcessBA;
      try {
         Field f = BA.SharedProcessBA.class.getDeclaredField("onActivityResultCode");
         f.setAccessible(true);
         int requestCode = f.getInt(sba) - 1;
		 return requestCode;
         //requestCode holds the value that should be used to send the intent.
      } catch (Exception e) {
         throw new RuntimeException(e);
      }
	  
}


#end if