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
	Private AS_Onboarding1 As AS_Onboarding
	Private isDarkMode As Boolean = True
	Private xlbl_DarkLightSwitch As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Onboarding Example")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	'******* 1. Page ************
	Dim OnboardingPage1 As AS_OnboardingPage = AS_Onboarding1.AddPage
	
	Dim OnboardingImage As B4XImageView = OnboardingPage1.AddImage(xui.LoadBitmap(File.DirAssets,"Image1.png"),300dip)
	OnboardingImage.mBackgroundColor = xui.Color_ARGB(255,32, 33, 37)
	OnboardingImage.Update
	
	OnboardingPage1.AddPlaceholder(20dip)
	OnboardingPage1.AddTitle("Test #1")
	OnboardingPage1.AddPlaceholder(20dip)
	OnboardingPage1.AddDescription("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")


	'******* 2. Page ************
	Dim OnboardingPage2 As AS_OnboardingPage = AS_Onboarding1.AddPage

	Dim OnboardingImage As B4XImageView = OnboardingPage2.AddImage(xui.LoadBitmap(File.DirAssets,"Image2.png"),300dip)
	OnboardingImage.mBackgroundColor = xui.Color_ARGB(255,32, 33, 37)
	OnboardingImage.Update

	OnboardingPage2.AddPlaceholder(20dip)
	OnboardingPage2.AddTitle("Test #2")
	OnboardingPage2.AddPlaceholder(20dip)
	OnboardingPage2.AddDescription("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.")


	'******* Last Page ************
	Dim OnboardingPage3 As AS_OnboardingPage = AS_Onboarding1.AddPage
	OnboardingPage3.Name = "LastPage"

	Dim OnboardingImage As B4XImageView = OnboardingPage3.AddImage(xui.LoadBitmap(File.DirAssets,"Image3.png"),300dip)
	OnboardingImage.mBackgroundColor = xui.Color_ARGB(255,32, 33, 37)
	OnboardingImage.Update

	OnboardingPage3.AddPlaceholder(20dip)
	OnboardingPage3.AddTitle("Last Page")
	OnboardingPage3.AddPlaceholder(20dip)
	OnboardingPage3.AddDescription("Lorem ipsum dolor sit amet")

	#If B4I
	AS_Onboarding1.BottomOffset = B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom 'Set a custom bottom offset for the items in the bottom sheet
	#Else
	AS_Onboarding1.BottomOffset = 0dip 'Set a custom bottom offset for the items in the bottom sheet
	#End If

	AS_Onboarding1.Create
	
End Sub

Private Sub AS_Onboarding1_ThemeChanging
	For Each Page As AS_OnboardingPage In AS_Onboarding1.Pages 'Each page
		For Each Item As AS_Onboarding_Item In Page.ItemList 'Each Item
			If Item.ItemType = AS_Onboarding1.ItemType_Image Then 'If it is a B4XImageView
				Dim OnboardingImage As B4XImageView = Item.View
				If isDarkMode Then
					OnboardingImage.mBackgroundColor = xui.Color_ARGB(255,32, 33, 37) 'Dark mode color
				Else
					OnboardingImage.mBackgroundColor = xui.Color_ARGB(255,233, 233, 233) 'Light mode color
				End If
				OnboardingImage.Update 'Update the B4XImageView
			End If
		Next
	Next
End Sub


#If B4J
Private Sub xlbl_DarkLightSwitch_MouseClicked (EventData As MouseEvent)
#Else
	Private Sub xlbl_DarkLightSwitch_Click
#End If
	If isDarkMode Then
		isDarkMode = False
		xlbl_DarkLightSwitch.Text = Chr(0xE3A8)
		AS_Onboarding1.Theme = AS_Onboarding1.Theme_Light
		Else
		isDarkMode = True
		xlbl_DarkLightSwitch.Text = Chr(0xE430)
		AS_Onboarding1.Theme = AS_Onboarding1.Theme_Dark
	End If
End Sub
