B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#Region VERSIONS 
'	2.0.0.	01/28/2025
#End Region

Sub Class_Globals
	#IF B4J
		Private fx As JFX
	#ELSE IF B4I
		Private iClipboard As Clipboard
		#Else If B4A
	Dim fp As FileProvider
	#End If
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	#IF B4A
	fp.Initialize
	#End If
End Sub

Public Sub setText(Text As String)
	#IF B4A
		Dim r As Reflector
		Dim jo As JavaObject
		jo = Me
		jo.RunMethod("SetTextToClipboard", Array As Object(Text, r.GetContext))
	#ELSE IF B4J
		fx.Clipboard.SetString(Text)
	#ELSE IF B4I
		iClipboard.StringItem = Text
	#End If
End Sub

Public Sub getText As String
	#IF B4A
		Dim r As Reflector
		Dim jo As JavaObject
		jo = Me
		Return jo.RunMethod("GetTextFromClipboard", Array As Object(r.GetContext))
	#ELSE IF B4J
		Return IIf(fx.Clipboard.HasString, fx.Clipboard.GetString, "")
	#ELSE IF B4I
		Return iClipboard.StringItem
	#End If
End Sub

Public Sub setImage(Img As B4XBitmap)
	#If B4I
	iClipboard.ImageItem = Img
	#Else If B4J
	Dim bitmap As Image = Img
	fx.Clipboard.SetImage(bitmap)
	#Else
	CopyImageToClipboard(Img)
	#End If
End Sub
Public Sub getImage As B4XBitmap
	#If B4I
	Return iClipboard.ImageItem
	#Else if B4J
	Return fx.Clipboard.GetImage
	#Else
	
	Return GetImageFromClipboard
	#End If
End Sub
Public Sub hasImage As Boolean
	#If B4I
	Return (iClipboard.ImageItem.IsInitialized And iClipboard.ImageItem <> Null)
	#Else if B4J
	Return fx.Clipboard.HasImage
	#Else
	
	Dim bmp As B4XBitmap = getImage
	Return (bmp.IsInitialized And bmp <> Null)
	
	#End If
End Sub

#IF B4A
	Public Sub HasText As Boolean
	Dim jo As JavaObject
	Dim r As Reflector
	jo = Me
	Dim bOk As Boolean
	bOk = jo.RunMethod("HasTextCopied", Array As Object(r.GetContext))
	Return bOk
End Sub
#ELSE IF B4j
	Public Sub HasText As Boolean
		Return fx.Clipboard.HasString
	End Sub
#End If

#IF B4A

Private Sub CopyImageToClipboard(Img As B4XBitmap)

	Dim fileName As String = "clipboard_image.png"

	Dim out As OutputStream = File.OpenOutput(fp.SharedFolder, fileName, False)
	Img.WriteToStream(out, 100, "PNG")
	out.Close
    
	Dim uri As Object = fp.GetFileUri(fileName)
    
	Dim jo As JavaObject
	jo.InitializeContext
	Dim ClipData As JavaObject
	ClipData.InitializeStatic("android.content.ClipData")
	Dim clip As JavaObject = ClipData.RunMethod("newRawUri", Array("Image", uri))
    
	Dim clipboard As JavaObject = jo.RunMethod("getSystemService", Array("clipboard"))
	clipboard.RunMethod("setPrimaryClip", Array(clip))

End Sub


Private Sub GetImageFromClipboard As B4XBitmap
	Dim jo As JavaObject
	jo.InitializeContext
	Dim clipboard As JavaObject = jo.RunMethod("getSystemService", Array("clipboard"))
	Dim ClipData As JavaObject = clipboard.RunMethod("getPrimaryClip", Null)
    
	If ClipData.IsInitialized And ClipData.RunMethod("getItemCount", Null) > 0 Then
		Dim item As JavaObject = ClipData.RunMethod("getItemAt", Array(0))
		Dim uri As Object = item.RunMethod("getUri", Null)
        
		If uri <> Null Then     
			Dim bmp As B4XBitmap = LoadBitmap(fp.SharedFolder, "clipboard_image.png")
			Return bmp
		End If
	End If
    
	Return Null
End Sub



#IF JAVA

import android.content.ClipboardManager;
import android.content.ClipData;
import android.content.Context;
import android.content.ClipDescription;
import android.graphics.Bitmap;
import android.net.Uri;
import java.io.File;
import java.io.FileOutputStream;
import android.graphics.BitmapFactory;

public Boolean SetTextToClipboard(Object objtxt, Object mObjContext) {
    try {
        String txt = (String) objtxt;
        Context mContext = (Context) mObjContext;
        ClipboardManager myClipboard = (ClipboardManager) mContext.getSystemService(Context.CLIPBOARD_SERVICE);
        ClipData myClip;
        myClip = ClipData.newPlainText("text", txt);
        myClipboard.setPrimaryClip(myClip);
        return true;
    } catch (Exception ex) {
        return false;
    }
}

public String GetTextFromClipboard(Object mObjContext) {
    Context mContext = (Context) mObjContext;
    ClipboardManager myClipboard = (ClipboardManager) mContext.getSystemService(Context.CLIPBOARD_SERVICE);
    ClipData myClip = myClipboard.getPrimaryClip();
    ClipData.Item item = myClip.getItemAt(0);
    String txt = item.getText().toString();
    return txt;
}

public Boolean HasTextCopied(Object mObjContext) {
    Context mContext = (Context) mObjContext;
    ClipboardManager myClipboard = (ClipboardManager) mContext.getSystemService(Context.CLIPBOARD_SERVICE);
    if (!(myClipboard.hasPrimaryClip())) {
        return false;
    } else if (!(myClipboard.getPrimaryClipDescription().hasMimeType(ClipDescription.MIMETYPE_TEXT_PLAIN))) {
        return false;
    } else {
        return true;
    }
}

#End If
#End If

