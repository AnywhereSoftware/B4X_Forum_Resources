B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
Private Sub Class_Globals
	
	
	Private sFacebook As String = "com.facebook.katana"
	Private sTwitter As String = "com.twitter.android"
	Private sViber As String = "com.viber.voip"
	Private sFacebookMessenger As String = "com.facebook.orca"
	Private sInstagram As String ="com.instagram.android"
	Private sWhatsapp As String = "com.whatsapp"
	Private sSkype As String = "com.skype.raider"
	Private sChooseChannel As String = "choose"
	Private prnt As Object
	Private callview As Object

	#if b4a
		Private jo As JavaObject
	#else if B4i
		Private avc As ActivityViewController
	#End If
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Parent As Object, CallingView As Object)
	prnt = Parent
	callview = CallingView
End Sub



Public Sub ShareMessage(Message As String, SocialChannelValueEmptyForB4i As String)
#if B4A

	Dim i As Intent
	
	jo = Me
	
	Try
		i = jo.RunMethod("intnt", Array As String(Message, SocialChannelValueEmptyForB4i))
		StartActivity(i)
	Catch
		Log(LastException)
		ToastMessageShow("The application you requested is not installed.", True)
	End Try
#else if B4i
	avc.Initialize("avc", Array As String(Message))
	Dim ph As Page
	ph = prnt
	avc.Show(ph, callview)
#End If	
End Sub

#if b4a


#If JAVA

import android.content.Intent;

public Intent intnt(String message, String applicationpackage){
	Intent i = new Intent(Intent.ACTION_SEND);
	i.setType("text/plain");
	i.putExtra(Intent.EXTRA_TEXT, message);
	if (applicationpackage=="choose"){
		return Intent.createChooser(i,"Share using");
	}else{
		i.setPackage(applicationpackage);
		return i;
	}
};

#End If



Public Sub getFacebook As String
	Return sFacebook
End Sub

Public Sub getTwitter As String
	Return sTwitter
End Sub

Public Sub getViber As String
	Return sViber
End Sub

Public Sub getFacebookMessenger As String
	Return sFacebookMessenger
End Sub

Public Sub getInstagram As String
	Return sInstagram
End Sub

Public Sub getWhatsApp As String
	Return sWhatsapp
End Sub

Public Sub getSkype As String
	Return sSkype
End Sub

#End If

Public Sub getChooseChannel As String
	Return sChooseChannel
End Sub

