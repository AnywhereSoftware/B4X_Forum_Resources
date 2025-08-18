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
	
	Private btnCn As B4XView
	Private btnDe As B4XView
	Private btnEn As B4XView
	Private btnEs As B4XView
	Private btnFr As B4XView
	Private btnIt As B4XView
	Private btnJp As B4XView
	Private btnKo As B4XView
	Private btnNl As B4XView
	Private btnPt As B4XView
	Private btnRu As B4XView
	
	Private form As AdMobConsentFormMultilang
	
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Sub ShowForm(languageCode As String) 
	Log("ShowForm - LangCode: " & languageCode)
			
	Private appPolicy As String = "https://www.yourprivacypolicyURL.com"
	Private icon As B4XBitmap = xui.LoadBitmapResize(File.DirAssets, "Mahjong_dragon-chun.png", 50dip, 50dip, True)
	Private appName As String = "My_App"
	Private adsPublishersFilename As String = "ad_technology_provider_privacy_urls.csv" 'download it from your AdMob console and add to the Files folder
	
	Private langCode As String 	  = languageCode ' "en", "es", "fr",... 
	' To get this code at runtime you can use Erel's Localizator, or AHLocale library (by corwin42):
	'	Private ahl As AHLocale
	'	ahl.Initialize
	'	langeCode = ahl.Country.ToLowerCase	
				
	form.Initialize(Me, Root, "AdmobConsent", appName, langCode, icon, appPolicy, adsPublishersFilename, True)
	form.Show

End Sub

Sub AdMobConsent_Selection(Result As String)
	Log("AdMobConsent_Selection - Result: " & Result)
	
	Select Result
		
		Case form.PERSONALIZED
			'Starter.consent.ConsentState = Starter.consent.STATE_PERSONALIZED
			'...
								
		Case form.NON_PERSONALIZED
			'Starter.consent.ConsentState = Starter.consent.STATE_NON_PERSONALIZED
			'...
			
		Case form.PAY_FOR_ADS_FREE
			'Do what you need
			'...
			
	End Select		
	
End Sub

Private Sub btn_Click
 ' Event name 'btn' and tags are set in Designer
	Private btn As B4XView = Sender
	ShowForm(btn.Tag) 
End Sub
