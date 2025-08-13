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
	Private AS_PremiumSummary1 As AS_PremiumSummary
	Private isDarkMode As Boolean = False
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Premium Summary Example")
	
	ThemeChanged
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	'Fill List
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_AppLogo(IIf(isDarkMode,xui.LoadBitmap(File.DirAssets,"AppIcon_Light.png"),xui.LoadBitmap(File.DirAssets,"AppIcon_Dark.png")),70dip,70dip))
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Placeholder(15dip))
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Title("iTube Pro","CENTER",xui.CreateDefaultBoldFont(35)))
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Placeholder(20dip))
	
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Title("Premium features" & ":","LEFT",xui.CreateDefaultBoldFont(25)))

	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Feature_1("Feature #1","Prioritize tasks with different markers or colors to direct the focus.", AS_PremiumSummary1.FontToBitmap(Chr(0xE645),True,30,xui.Color_White)))
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Feature_1("Feature #2","Create as many groups as you like.", AS_PremiumSummary1.FontToBitmap(Chr(0xF09C),False,30,xui.Color_White)))
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Feature_1("Feature #3","Simply archive groups when a project is finished instead of deleting it.", AS_PremiumSummary1.FontToBitmap(Chr(0xE149),True,30,xui.Color_White)))
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Feature_1("Feature #4","Add URLs  to be able to open it directly without having to open the task.", AS_PremiumSummary1.FontToBitmap(Chr(0xE250),True,30,xui.Color_White)))
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Feature_1("Feature #5","Add prices to a task.", AS_PremiumSummary1.FontToBitmap(Chr(0xE8CC),True,30,xui.Color_White)))


	'BottomSheet
	AS_PremiumSummary1.AddItemToBottomSheet(AS_PremiumSummary1.Add_PaidOption("all_access_1_month","Monthly","2,99 €","2,99 €",True))
	AS_PremiumSummary1.AddItemToBottomSheet(AS_PremiumSummary1.Add_PaidOption("all_access_1_year","Yearly","24,99 €","24,99 €",False))
	
	AS_PremiumSummary1.AddItemToBottomSheet(AS_PremiumSummary1.Add_PurchaseButton("Continue"))
	
	AS_PremiumSummary1.AddItemToBottomSheet(AS_PremiumSummary1.Add_ClickableText("Terms","Restore Purchases","Privacy"))

	'Resizing
	AS_PremiumSummary1.mBase.SetLayoutAnimated(250,0,0,Root.Width,Root.Height)
	AS_PremiumSummary1.Base_Resize(AS_PremiumSummary1.mBase.Width,AS_PremiumSummary1.mBase.Height)
	
	'Create the view with items
	AS_PremiumSummary1.Create
	B4XPage_Resize(Root.Width,Root.Height)
	
	#If B4I
	AS_PremiumSummary1.BottomOffset = B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom 'Set a custom bottom offset for the items in the bottom sheet
	#Else
	AS_PremiumSummary1.BottomOffset = 0dip 'Set a custom bottom offset for the items in the bottom sheet
	#End If
	
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	AS_PremiumSummary1.mBase.SetLayoutAnimated(250,0,0,Root.Width,Root.Height)
	AS_PremiumSummary1.Base_Resize(AS_PremiumSummary1.mBase.Width,AS_PremiumSummary1.mBase.Height)
End Sub

Private Sub AS_PremiumSummary1_ClickableTextClick(Button As String)
	Select Button
		Case "Left"
			Log("Left Button clicked")
			isDarkMode = False
			ThemeChanged
		Case "Middle"
			Log("Middle Button clicked")
		Case "Right"
			Log("Right Button clicked")
			isDarkMode = True
			ThemeChanged
	End Select
End Sub

Private Sub AS_PremiumSummary1_PaidOptionClicked(Index As Int,PaidOption As AS_PremiumSummary_PaidOption)
	Select PaidOption.Name
		Case "all_access_1_year"
			AS_PremiumSummary1.PurchaseButtonText = PaidOption.PriceValue & "/ " & "Year"
		Case "all_access_1_month"
			AS_PremiumSummary1.PurchaseButtonText = PaidOption.PriceValue & "/ " & "Month"
	End Select
End Sub

Private Sub AS_PremiumSummary1_CloseButtonClicked
	Log("CloseButtonClicked")
End Sub

Private Sub AS_PremiumSummary1_PurchaseButtonClick(ProductIdentifier As String)
	Log("Purchase Button Clicked")
End Sub

Public Sub ThemeChanged
	
	isDarkMode = B4XPages.MainPage.isDarkMode
	If Root.IsInitialized = False Then Return
	
	Dim BackgroundColor As Int

	If isDarkMode Then
		BackgroundColor = xui.Color_ARGB(255,19, 20, 22)
	Else
		BackgroundColor = xui.Color_White
	End If

	Root.Color = BackgroundColor
	
	If isDarkMode Then
		Dim Theme_Dark As AS_PremiumSummary_Theme = AS_PremiumSummary1.Theme_Dark
'		Theme_Dark.AppColor = xui.Color_ARGB(255,45, 136, 121)
'		Theme_Dark.AppTextColor = xui.Color_White
		AS_PremiumSummary1.Theme = Theme_Dark
		AS_PremiumSummary1.AppLogo = xui.LoadBitmap(File.DirAssets,"AppIcon_Light.png")
	Else
		Dim Theme_Light As AS_PremiumSummary_Theme = AS_PremiumSummary1.Theme_Light
'		Theme_Light.AppColor = xui.Color_ARGB(255,45, 136, 121)
'		Theme_Dark.AppTextColor = xui.Color_White
		AS_PremiumSummary1.Theme = Theme_Light
		AS_PremiumSummary1.AppLogo = xui.LoadBitmap(File.DirAssets,"AppIcon_Dark.png")
	End If
	
	#If B4A
	If AS_PremiumSummary1.isCreated Then Sleep(400)
	SetStatusNavigationBarColor(Root,BackgroundColor,AS_PremiumSummary1.BottomBackgroundColor,IIf(isDarkMode,False,True))
	#End If
	
End Sub


#If B4A
Public Sub SetStatusNavigationBarColor(RootPanel As B4XView,TopBarColor As Int,BottomBarColor As Int,DarkText As Boolean)
	Dim p As Phone
	If p.SdkVersion >= 21 Then
		Dim jo As JavaObject
		jo.InitializeContext
		Dim window As JavaObject = jo.RunMethodJO("getWindow", Null)
		window.RunMethod("addFlags", Array (0x80000000))
		window.RunMethod("clearFlags", Array (0x04000000))
		window.RunMethod("setStatusBarColor", Array(TopBarColor))
		window.RunMethod("setNavigationBarColor", Array(BottomBarColor))
	End If
	If p.SdkVersion >= 23 Then
		jo = RootPanel
		If DarkText Then
			jo.RunMethod("setSystemUiVisibility",Array(8192+16))
		Else
			jo.RunMethod("setSystemUiVisibility",Array(0x00000010))
		End If
	End If
End Sub
#End If