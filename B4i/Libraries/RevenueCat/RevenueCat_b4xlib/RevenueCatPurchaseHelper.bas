B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@


Sub Class_Globals
	Private xui As XUI
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private inAppPurchase As Store
	Private p As Phone
	
	Private m_RevCat As RevenueCat
	Private m_API_KEY As String = ""
	Private m_isExpired As Boolean = False
	
	Private m_ProductIndentififer() As String
	Private m_MapProducts As Map
	
	Private m_RestoreErrorTitle As String
	Private m_RestoreErrorDescription As String
	Private m_RestoreSuccessTitle As String
	Private m_RestoreSuccessDescription As String
	Private m_ProVersionExpired As String
	Private m_ProVersionExpiredTitle As String
	Private m_PurchaseErrorTitle As String
	Private m_PurchaseErrorDescription As String
	Private m_PurchaseSuccessTitle As String
	Private m_PurchaseSuccessDescription As String

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object, EventName As String,RevenueCatAPIKey As String)
	mEventName = EventName
	mCallBack = Callback
	m_MapProducts.Initialize
	inAppPurchase.Initialize("inAppPurchase")
	m_API_KEY = RevenueCatAPIKey
	
	m_RestoreErrorTitle = "Restore failed"
	m_RestoreErrorDescription = "No purchases found To restore."
	m_RestoreSuccessTitle = "Recovery successful"
	m_RestoreSuccessDescription = "Your purchases have been successfully restored"
	m_ProVersionExpired = "The Pro version has been canceled Or Not renewed, you are now using the basic version."
	m_ProVersionExpiredTitle = "Pro Version expired"
	m_PurchaseErrorTitle = "Purchase Failed"
	m_PurchaseErrorDescription = "Purchase was cancelled."
	m_PurchaseSuccessTitle = "You are now ready to go"
	m_PurchaseSuccessDescription = "Your purchase was successful."
	
End Sub

'Returns a list of ProductInformation
Public Sub GetProductsInformation(ProductIndentififer() As String) As ResumableSub
	
	inAppPurchase.RequestProductsInformation(ProductIndentififer)
	wait for inAppPurchase_InformationAvailable (Success As Boolean, Products As List)
	
	m_MapProducts.Initialize
	
	If Success = False Then
		Dim Products As List
		Products.Initialize
	Else
		For Each Product As ProductInformation In Products
			m_MapProducts.Put(Product.ProductIdentifier,Product)
		Next
	End If
	
	Return Products
	
End Sub

#Region Methods

Private Sub GetUserId As String
	Dim UserId As String = p.KeyChainGet("RevenueCat_UserId")
	If UserId = "" Then
		UserId = GUID
		p.KeyChainPut("RevenueCat_UserId",UserId)
	End If
	Return UserId
End Sub

Public Sub CheckPurchases As ResumableSub
	
	#If Simulator
	If Main.HasPremium Then
		Return True
		'xui.messagebox
	End If
	#End If
	
	If m_RevCat.IsInitialized = False Then m_RevCat.Initialize(m_API_KEY,GetUserId,m_ProductIndentififer)

	If p.KeyChainGet("RevenueCat_SubscriptionExpiresDate") = "" Or p.KeyChainGet("RevenueCat_SubscriptionExpiresDate").As(Long) < DateTime.Now Then
		
		Wait For (m_RevCat.GetCustomer) complete (Subscription As RevenueCat_Subscription)
		
		If Subscription.Error.Success And Subscription.ExpiresDate > DateTime.Now Then
			p.KeyChainPut("RevenueCat_SubscriptionExpiresDate",Subscription.ExpiresDate)
		End If
		
	End If
	
	Log(DateUtils.TicksToString(p.KeyChainGet("RevenueCat_SubscriptionExpiresDate").As(Long)))
	Main.HasPremium = p.KeyChainGet("RevenueCat_SubscriptionExpiresDate").As(Long) > DateTime.Now
	
	If Main.HasPremium = False And p.KeyChainGet("RevenueCat_SubscriptionExpiresDate") <> "" Then
		p.KeyChainPut("RevenueCat_SubscriptionExpiresDate","") 'Reset
		m_isExpired = True
	End If
	
	Return True
	
End Sub

Public Sub RequestPayment(ProductIdentifier As String) As ResumableSub
	
	If m_RevCat.IsInitialized = False Then m_RevCat.Initialize(m_API_KEY,GetUserId,m_ProductIndentififer)
	
	inAppPurchase.RequestPayment(ProductIdentifier)
	Wait For inAppPurchase_PurchaseCompleted (Success As Boolean, Product As Purchase)
	
	m_RevCat.GetCustomer
	Product.Tag = m_MapProducts
	Wait For (m_RevCat.CreatePurchase(Product.ProductIdentifier,Product)) complete (Subscription As RevenueCat_Subscription)

	If Subscription.Error.Success Then
		
		p.KeyChainPut("RevenueCat_SubscriptionExpiresDate",Subscription.ExpiresDate)
		
	End If
	
	If Success Then
		
		Dim sf As Object = xui.MsgboxAsync(m_PurchaseSuccessDescription,m_PurchaseSuccessTitle)
		Wait For (sf) Msgbox_Result (Result As Int)

		Return True

	Else
		xui.MsgboxAsync(m_PurchaseErrorDescription,m_PurchaseErrorTitle)
		Return False
	End If
	
End Sub

Public Sub RestorePurchases As ResumableSub

	inAppPurchase.RestoreTransactions
	Wait For inAppPurchase_TransactionsRestored (Success As Boolean)

	If Success Then
		Wait For (CheckPurchases) complete (Success As Boolean)
	
		Dim p As Phone
		If Main.HasPremium = False And p.KeyChainGet("RevenueCat_SubscriptionExpiresDate") <> "" Then
			p.KeyChainPut("RevenueCat_SubscriptionExpiresDate","") 'Reset
			m_isExpired = True
			xui.MsgboxAsync(m_ProVersionExpired,m_ProVersionExpiredTitle)
		Else if Main.HasPremium Then
			xui.MsgboxAsync(m_RestoreSuccessTitle,m_RestoreSuccessDescription)
			Return True
		Else
			xui.MsgboxAsync(m_RestoreErrorTitle,m_RestoreErrorDescription)
		End If
	Else
		xui.MsgboxAsync(m_RestoreErrorTitle,m_RestoreErrorDescription)
	End If
	Return False
End Sub

#End Region

#Region Properties

Public Sub getisExpired As Boolean
	Return m_isExpired
End Sub

Public Sub getRestoreErrorTitle As String
	Return m_RestoreErrorTitle
End Sub

Public Sub setRestoreErrorTitle(RestoreErrorTitle As String)
	m_RestoreErrorTitle = RestoreErrorTitle
End Sub

Public Sub getRestoreErrorDescription As String
	Return m_RestoreErrorDescription
End Sub

Public Sub setRestoreErrorDescription(RestoreErrorDescription As String)
	m_RestoreErrorDescription = RestoreErrorDescription
End Sub

Public Sub getRestoreSuccessTitle As String
	Return m_RestoreSuccessTitle
End Sub

Public Sub setRestoreSuccessTitle(RestoreSuccessTitle As String)
	m_RestoreSuccessTitle = RestoreSuccessTitle
End Sub

Public Sub getRestoreSuccessDescription As String
	Return m_RestoreSuccessDescription
End Sub

Public Sub setRestoreSuccessDescription(RestoreSuccessDescription As String)
	m_RestoreSuccessDescription = RestoreSuccessDescription
End Sub

Public Sub getProVersionExpired As String
	Return m_ProVersionExpired
End Sub

Public Sub setProVersionExpired(ProVersionExpired As String)
	m_ProVersionExpired = ProVersionExpired
End Sub

Public Sub getProVersionExpiredTitle As String
	Return m_ProVersionExpiredTitle
End Sub

Public Sub setProVersionExpiredTitle(ProVersionExpiredTitle As String)
	m_ProVersionExpiredTitle = ProVersionExpiredTitle
End Sub

Public Sub getPurchaseErrorTitle As String
	Return m_PurchaseErrorTitle
End Sub

Public Sub setPurchaseErrorTitle(PurchaseErrorTitle As String)
	m_PurchaseErrorTitle = PurchaseErrorTitle
End Sub

Public Sub getPurchaseErrorDescription As String
	Return m_PurchaseErrorDescription
End Sub

Public Sub setPurchaseErrorDescription(PurchaseErrorDescription As String)
	m_PurchaseErrorDescription = PurchaseErrorDescription
End Sub

Public Sub getPurchaseSuccessTitle As String
	Return m_PurchaseSuccessTitle
End Sub

Public Sub setPurchaseSuccessTitle(PurchaseSuccessTitle As String)
	m_PurchaseSuccessTitle = PurchaseSuccessTitle
End Sub

Public Sub getPurchaseSuccessDescription As String
	Return m_PurchaseSuccessDescription
End Sub

Public Sub setPurchaseSuccessDescription(PurchaseSuccessDescription As String)
	m_PurchaseSuccessDescription = PurchaseSuccessDescription
End Sub


Public Sub getProductIndentififer As String()
	Return m_ProductIndentififer
End Sub

Public Sub setProductIndentififer(ProductIndentififer() As String)
	m_ProductIndentififer = ProductIndentififer
End Sub

#End Region

#Region Functions

Public Sub GUID As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each stp As Int In Array(8, 4, 4, 4, 12)
		If sb.Length > 0 Then sb.Append("-")
		For n = 1 To stp
			Dim c As Int = Rnd(0, 16)
			If c < 10 Then c = c + 48 Else c = c + 55
			sb.Append(Chr(c))
		Next
	Next
	Return sb.ToString
End Sub

#End Region