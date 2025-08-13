B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private AS_PremiumSummary1 As AS_PremiumSummary
	
	Private PurchaseHelper As RevenueCatPurchaseHelper
	
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("frm_premium")
	
	PurchaseHelper.Initialize(Me,"PurchaseHelper",Main.m_RevenuecatApiKey)
	PurchaseHelper.ProductIndentififer = Array As String("all_access_1_month_easyplate","all_access_1_year_easyplate")
	
	BuildSummary
	
End Sub

Private Sub BuildSummary
	
	AS_PremiumSummary1.ShowLoadingIndicator
	AS_PremiumSummary1.HideInfo
	AS_PremiumSummary1.Clear
	
	Wait For (PurchaseHelper.GetProductsInformation(PurchaseHelper.ProductIndentififer)) complete (lastPurchases As List) 'Get the subscription info from the App Store
	Dim Success As Boolean = lastPurchases.Size > 0
	
	If Success Then
		
		Dim First As Boolean = True
		For Each ProductInfo As ProductInformation In lastPurchases
			AS_PremiumSummary1.AddItemToBottomSheet(AS_PremiumSummary1.Add_PaidOption(ProductInfo.ProductIdentifier,ProductInfo.Title,ProductInfo.LocalizedPrice,ProductInfo.LocalizedPrice,First))
			First = False
		Next
		
	Else
		AS_PremiumSummary1.ShowInfo("No connection to the App Store","Could not connect to the App Store, please check your internet connection and try again.","Retry")
		Return
	End If
	
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Title("3Things Pro","CENTER",xui.CreateDefaultBoldFont(35)))
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Placeholder(20dip))
	
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Feature_1("Premium Feature 1","This is a nice Feature",AS_PremiumSummary1.FontToBitmap(Chr(0xE896),True,30,xui.Color_White)))
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Feature_1("Premium Feature 2","This is a nice Feature",AS_PremiumSummary1.FontToBitmap(Chr(0xE858),True,30,xui.Color_White)))
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Feature_1("Premium Feature 3","This is a nice Feature",AS_PremiumSummary1.FontToBitmap(Chr(0xE90D),True,30,xui.Color_White)))
	AS_PremiumSummary1.AddItemToList(AS_PremiumSummary1.Add_Feature_1("Premium Feature 4","This is a nice Feature",AS_PremiumSummary1.FontToBitmap(Chr(0xE88D),True,30,xui.Color_White)))
	
	
	AS_PremiumSummary1.AddItemToBottomSheet(AS_PremiumSummary1.Add_PurchaseButton("Subscribe now"))
	AS_PremiumSummary1.AddItemToBottomSheet(AS_PremiumSummary1.Add_ClickableText("Terms","Restore Purchases","Privacy"))
	
	Dim BottomGap As Float = 0dip
	#If B4I
	BottomGap = B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom
	#End If
	
	AS_PremiumSummary1.AddItemToBottomSheet(AS_PremiumSummary1.Add_Placeholder(BottomGap)) 'Safe Area
	
	'Resizing
	AS_PremiumSummary1.mBase.SetLayoutAnimated(250,0,0,Root.Width,Root.Height)
	AS_PremiumSummary1.Base_Resize(AS_PremiumSummary1.mBase.Width,AS_PremiumSummary1.mBase.Height)
	
	AS_PremiumSummary1.Create
	AS_PremiumSummary1.HideLoadingIndicator
	
End Sub

Private Sub AS_PremiumSummary1_PurchaseButtonClick(ProductIdentifier As String)
	
	Wait For (PurchaseHelper.RequestPayment(ProductIdentifier)) complete (Success As Boolean)
	
	If Success Then
		UnlockPremiumFunctions
	End If
	
End Sub

Private Sub AS_PremiumSummary1_ClickableTextClick(Button As String)
	Select Button
		Case "Left" 'Terms
			If Main.App.CanOpenURL("https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") Then
				Main.App.OpenURL("https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")
			End If
		Case "Middle" 'Restore
			RestorePurchases
		Case "Right" 'Privacy
			If Main.App.CanOpenURL("https://xxx.com/privacy") Then
				Main.App.OpenURL("https://xxx.com/privacy")
			End If
	End Select
End Sub

Public Sub RestorePurchases

	Wait For (PurchaseHelper.RestorePurchases) Complete (Success As Boolean)
	

	If Success Then
		UnlockPremiumFunctions
		Sleep(0)
		B4XPages.ClosePage(Me)
	End If
	
End Sub

Private Sub UnlockPremiumFunctions
	Main.HasPremium = True
	
	'Unlock the premium features here
	'If B4XPages.MainPage.p_Settings.isReady Then CallSub(B4XPages.MainPage.p_Settings,"UnlockPremium")
	'If B4XPages.MainPage.p_Taks.isReady Then CallSub(B4XPages.MainPage.p_Taks,"UnlockPremium")
	
End Sub

'If the user has selected a subscription, you can change the text here e.g. 10$/Year
Private Sub AS_PremiumSummary1_PaidOptionClicked(Index As Int,PaidOption As AS_PremiumSummary_PaidOption)
	Select PaidOption.Name
		Case "all_access_1_year_easyplate"
			AS_PremiumSummary1.PurchaseButtonText = PaidOption.PriceValue & "/ " & "Year"
		Case "all_access_1_month_easyplate"
			AS_PremiumSummary1.PurchaseButtonText = PaidOption.PriceValue & "/ " & "Month"
	End Select
End Sub

'The "x" button on top left
Private Sub AS_PremiumSummary1_CloseButtonClicked
	B4XPages.ClosePage(Me)
End Sub

'The Retry button with the info text: "No connection to the App Store"
Private Sub AS_PremiumSummary1_InfoButtonClicked
	BuildSummary
End Sub