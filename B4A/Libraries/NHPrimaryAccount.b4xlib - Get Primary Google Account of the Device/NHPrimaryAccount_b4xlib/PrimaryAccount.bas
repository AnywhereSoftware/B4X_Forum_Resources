B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub


'<code>
''Add the following permissions in the manifest
''AddPermission("android.permission.GET_ACCOUNTS")
''AddPermission("android.permission.READ_CONTACTS")
''----------------------------------------------------
''Add the following runtime permissions
''rp.CheckAndRequest(rp.PERMISSION_GET_ACCOUNTS)
''rp.CheckAndRequest(rp.PERMISSION_READ_CONTACTS)
''----------------------------------------------------
'Sub Class_Globals
'	Private Root As B4XView
'	Private xui As XUI
'	#if b4a
'	Private rp As RuntimePermissions
'	#End if
'	Private bOkToGetPrimaryAccount As Boolean = False
'	Private prac As PrimaryAccount
'End Sub
'
'Public Sub Initialize
''	B4XPages.GetManager.LogEvents = True
'End Sub
'
''This event will be called once, before the page becomes visible.
'Private Sub B4XPage_Created (Root1 As B4XView)
'	Root = Root1
'	Root.LoadLayout("MainPage")
'
'	prac.Initialize
'	
'	#if b4a
'	Dim bOk1 As Boolean = False
'	Dim bOk2 As Boolean = False
'	
'	If rp.Check(rp.PERMISSION_READ_CONTACTS) = False Then
'		wait for (xui.Msgbox2Async(Translate("This app requires your primary Google Accound. In order to access it, the permissions to get accounts and read contacts is needed. Please give these permissions to the app."), Translate("Notification"), Translate("Ok"), "", "", xui.LoadBitmap(File.DirAssets, "sign-alert-icon.png"))) MsgBox_Result(iRet As Int)
'	End If
'	
'	rp.CheckAndRequest(rp.PERMISSION_GET_ACCOUNTS)
'	wait for B4XPage_PermissionResult (Permission As String, Result As Boolean)
'	bOk1 = Result
'	
'	If bOk1 Then
'		rp.CheckAndRequest(rp.PERMISSION_READ_CONTACTS)
'		wait for B4XPage_PermissionResult (Permission As String, Result As Boolean)
'		bOk2 = Result
'		If bOk2 Then
'			Log(prac.GetPrimaryAccount)
'		End If
'	End If
'	
'	
'	#End If
'End Sub
'
'Private Sub Translate(sWhatToTranslate As String) As String
'	'TODO: Implement Translation through Localizator
'	Return sWhatToTranslate
'End Sub
'
''You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
'
'Private Sub Button1_Click
'	xui.MsgboxAsync("Hello world!", "B4X")
'End Sub
'</code>
Public Sub Instructions
	
End Sub

Public Sub GetPrimaryAccount As String
	
	Dim sRet As String

	Dim j As JavaObject = Me
	Dim ctx As JavaObject
	ctx.InitializeContext
	'j.InitializeContext
	sRet = j.RunMethod("getEmailID", Array As Object(ctx))

	Return sRet

End Sub



#If JAVA

import android.content.Context;
import android.accounts.AccountManager;
import android.accounts.Account;


public String getEmailID(Object objcntx) {
    Context context = (Context) objcntx;
    AccountManager accountManager = AccountManager.get(context);
    Account account = getAccount(accountManager);
    if (account == null) {
        return null;
    } else {
        return account.name;
    }
};

public Account getAccount(AccountManager accountManager) {
    Account[] accounts = accountManager.getAccountsByType("com.google");
    Account account;
    if (accounts.length > 0) {
        account = accounts[0];
//      account = accounts[accounts.length-1]; ‘για τον τελευταίο=πρώτος μπήκε
    } else {
        account = null;
    }
    return account;
};

#End If
