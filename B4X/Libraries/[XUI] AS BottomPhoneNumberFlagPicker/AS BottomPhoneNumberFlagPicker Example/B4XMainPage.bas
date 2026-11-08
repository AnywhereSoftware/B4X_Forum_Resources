B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private BottomPhoneNumberFlagPicker As AS_BottomPhoneNumberFlagPicker

End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS BottomPhoneNumberFlagPicker Example")
	
End Sub

Private Sub OpenDark
	
	BottomPhoneNumberFlagPicker.Initialize(Me,"BottomPhoneNumberFlagPicker",Root)
	
	BottomPhoneNumberFlagPicker.Color = xui.Color_ARGB(255,32, 33, 37)
	BottomPhoneNumberFlagPicker.TextColor = xui.Color_White
	
	BottomPhoneNumberFlagPicker.SelectItem2("+49")
	
	BottomPhoneNumberFlagPicker.ShowPicker
	
End Sub

Private Sub OpenLight
	
	BottomPhoneNumberFlagPicker.Initialize(Me,"BottomPhoneNumberFlagPicker",Root)
	
	BottomPhoneNumberFlagPicker.Color = xui.Color_White
	BottomPhoneNumberFlagPicker.TextColor = xui.Color_Black
	
	BottomPhoneNumberFlagPicker.SelectItem(GetCountry)
	
	BottomPhoneNumberFlagPicker.ShowPicker
	
End Sub

Private Sub BottomPhoneNumberFlagPicker_ConfirmButtonClicked (Item As AS_BottomPhoneNumberFlagPicker_Item)
	
	xui.MsgboxAsync(Item.FlagEmoji & " " & Item.DialCode,Item.Name)
	
End Sub

#If B4I
Private Sub GetCountry As String
	Dim no As NativeObject
	Dim s As String  = no.Initialize("NSLocale") _
        .RunMethod("currentLocale", Null).RunMethod("objectForKey:", Array("kCFLocaleCountryCodeKey")).AsString
	Return s
End Sub
#Else If B4A
Private Sub GetCountry As String
	Dim r As Reflector
	r.Target = r.RunStaticMethod("java.util.Locale", "getDefault", Null, Null)
	Return r.RunMethod("getCountry")
End Sub
#End If

#If B4J
Private Sub xlbl_OpenDark_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenDark_Click
#End If
	OpenDark
End Sub

#If B4J
Private Sub xlbl_OpenLight_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenLight_Click
#End If
	OpenLight
End Sub

