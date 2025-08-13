B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
'version 1.01
Sub Class_Globals
	Type DocumentScanResult (Success As Boolean, ImageUris As List, PdfUri As String)
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
End Sub

'OutputPdf - whether to generate a PDF document
Public Sub Scan (OutputPdf As Boolean) As ResumableSub
	Dim options As JavaObject
	options.InitializeNewInstance("com/google/mlkit/vision/documentscanner/GmsDocumentScannerOptions$Builder".Replace("/", "."), Null)
	options.RunMethod("setResultFormats", Array(101, IIf(OutputPdf, Array As Int(102), Array As Int())))
	options = options.RunMethod("build", Null)
	Dim scanner As JavaObject
	scanner = scanner.InitializeStatic("com/google/mlkit/vision/documentscanner/GmsDocumentScanning".Replace("/", ".")).RunMethod("getClient", Array(options))
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim IntentSender As Object = scanner.RunMethodJO("getStartScanIntent", Array(ctxt)).RunMethod("getResult", Null)
	Me.as(JavaObject).RunMethod("sendIntentSenderForResult", Array(ctxt, IntentSender))
	Wait For Result_Arrived(Intent1 As Object)
	Dim ScanResult As DocumentScanResult
	ScanResult.Initialize
	ScanResult.ImageUris.Initialize
	If Intent1 = Null Then
		ScanResult.Success = False
	Else
		ScanResult.Success = True
		Dim Result As JavaObject
		Result = Result.InitializeStatic("com/google/mlkit/vision/documentscanner/GmsDocumentScanningResult".Replace("/", ".")).RunMethod("fromActivityResultIntent", Array(Intent1))
		Dim pages As List = Result.RunMethod("getPages", Null)
		For Each page As JavaObject In pages
			ScanResult.ImageUris.Add(page.RunMethodJO("getImageUri", Null).RunMethod("toString", Null))
		Next
		If OutputPdf Then
			Dim PDF As JavaObject = Result.RunMethod("getPdf", Null)
			ScanResult.PdfUri = PDF.RunMethodJO("getUri", Null).RunMethod("toString", Null)
		End If
	End If
	Return ScanResult
End Sub

#if java
import com.google.mlkit.vision.documentscanner.*;
import android.app.*;
import android.content.*;
import java.lang.reflect.*;
private anywheresoftware.b4a.IOnActivityResult ion;
public void sendIntentSenderForResult(Activity activity, IntentSender intentSender) throws Exception{
	BA ba = getBA();
	Object self = this;
	ion = new anywheresoftware.b4a.IOnActivityResult() {

                @Override
                public void ResultArrived(int resultCode, android.content.Intent intent) {
                   ba.raiseEvent(self, "result_arrived", intent);
                }
            };
	try {
         ba.startActivityForResult(ion, null); //<-- passing null instead of an intent
      } catch (NullPointerException npe) {
         //required...
      }
      BA.SharedProcessBA sba = ba.sharedProcessBA;
      try {
         Field f = BA.SharedProcessBA.class.getDeclaredField("onActivityResultCode");
         f.setAccessible(true);
         int requestCode = f.getInt(sba) - 1;
		 activity.startIntentSenderForResult(intentSender, requestCode, null, 0, 0, 0);
      } catch (Exception e) {
         throw new RuntimeException(e);
      }
	
}
#End If