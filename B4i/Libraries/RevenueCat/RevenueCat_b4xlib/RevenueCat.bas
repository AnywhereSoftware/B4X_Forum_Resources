B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-Improvements
	-Remove is_restore from CreatePurchase
		-The parameter is Deprecated
	-Add class RevenueCatPurchaseHelper - Takes care of almost everything
		-Saving and restoring user tokens
		-Checking Purchasing status
		-Restore
		-Messageboxes
V1.02
	-BugFixes
#End IF

Sub Class_Globals
	
	Type RevenueCat_Subscription(Error As RevenueCat_Error,ProductIdentifier As String,ExpiresDate As Long,OwnershipType As String,Store As String,isSandbox As Boolean,GracePeriodExpiresDate As Long,OriginalPurchaseDate As Long,BillingIssuesDetectedAt As Long,RefundedAt As Long,StoreTransactionId As String,UnsubscribeDetectedAt As Long,AutoResumeDate As Long,PurchaseDate As Long,PeriodType As String)
	Type RevenueCat_Error(Success As Boolean,ErrorMessage As String)
	Private m_API_KEY As String = ""
	Private m_AppUserId As String
	Private m_lst_ProductIdentifier As List
End Sub

'Initializes the object. You can add parameters to this method if needed.
'<code>RevCat.Initialize("RevenueCatAPIKey",RevCatUserId,Array As String("all_access_1_year","all_access_1_month"))</code>
Public Sub Initialize(API_KEY As String,AppUserId As String,lst_ProductIdentifier As List)
	m_API_KEY = API_KEY
	m_AppUserId = AppUserId
	m_lst_ProductIdentifier = lst_ProductIdentifier
End Sub

'Gets the latest Customer Info for the customer with the given App User ID, or creates a new customer if it doesn't exist.
'https://www.revenuecat.com/docs/api-v1#tag/customers/operation/subscribers
Public Sub GetCustomer As ResumableSub
	
	Dim Error As RevenueCat_Error
	Error.Initialize
	
	Dim ActiveSubscription As RevenueCat_Subscription
	Dim Subscription As RevenueCat_Subscription
	Subscription.Initialize
	
	Dim J As HttpJob
	J.Initialize("CreateUserORGetUserInfo", Me)
	J.Download("https://api.revenuecat.com/v1/subscribers/" & m_AppUserId)
	'SharedCode.MeuPerfil.UIDFirebase is the user id that will be created at revenuecat to identify the user.
    
	J.GetRequest.SetHeader("Accept","application/json")

	#If B4I
	J.GetRequest.SetHeader("X-Platform","ios")
	#Else If B4A
	J.GetRequest.SetHeader("X-Platform","android")
	#Else If B4J
	
	#End If

	#If RELEASE
	J.GetRequest.SetHeader("X-Is-Sandbox",False)
	#Else
	J.GetRequest.SetHeader("X-Is-Sandbox",True)
	#End If

	J.GetRequest.SetHeader("Content-Type","application/json")
	J.GetRequest.SetHeader("Authorization","Bearer " & m_API_KEY)
	'Main.ptrc    revenue cat key
    
    
	Wait For (J) JobDone(j As HttpJob)
    
	Error.Success = True
	
	If J.Success Then
		Log(J.GetString)

		Dim js As JSONParser
		js.Initialize(J.GetString)
		Dim Map1 As Map = js.NextObject

		Dim subscriber As Map = Map1.Get("subscriber")

		If subscriber.Size > 0 Then
    
			Dim subscriptions As Map = subscriber.Get("subscriptions")
			If subscriptions.Size > 0 Then

				Dim LatestExpiration As Long = 0 ' Zum Speichern des spätesten Ablaufdatums
        
				For Each Key As String In subscriptions.Keys
            
					For Each ProductIdentifier As String In m_lst_ProductIdentifier
                
						If Key = ProductIdentifier Then

							Dim SubscriptionMap As Map = subscriptions.Get(Key)
                    
							Dim ExpirationDate As Long = ParseUTCstring(SubscriptionMap.Get("expires_date"))
                    
							' Prüfen, ob das Abo noch aktiv ist
							If ExpirationDate > DateTime.Now Then
                        
								' Falls dies das späteste Ablaufdatum ist, als aktives Abo speichern
								If ExpirationDate > LatestExpiration Then
									LatestExpiration = ExpirationDate
                            
									Subscription.ProductIdentifier = Key
									Subscription.ExpiresDate = ExpirationDate
									Subscription.OwnershipType = SubscriptionMap.Get("ownership_type")
									Subscription.Store = SubscriptionMap.Get("store")
									Subscription.isSandbox = SubscriptionMap.Get("is_sandbox")
									Subscription.GracePeriodExpiresDate = ParseUTCstring(SubscriptionMap.Get("grace_period_expires_date"))
									Subscription.OriginalPurchaseDate = ParseUTCstring(SubscriptionMap.Get("original_purchase_date"))
									Subscription.BillingIssuesDetectedAt = ParseUTCstring(SubscriptionMap.Get("billing_issues_detected_at"))
									Subscription.RefundedAt = ParseUTCstring(SubscriptionMap.Get("refunded_at"))
									Subscription.UnsubscribeDetectedAt = ParseUTCstring(SubscriptionMap.Get("unsubscribe_detected_at"))
									Subscription.AutoResumeDate = ParseUTCstring(SubscriptionMap.Get("auto_resume_date"))
									Subscription.PurchaseDate = ParseUTCstring(SubscriptionMap.Get("purchase_date"))
									Subscription.StoreTransactionId = SubscriptionMap.Get("store_transaction_id")
									Subscription.PeriodType = SubscriptionMap.Get("period_type")
                            
									ActiveSubscription = Subscription
								End If
							End If

						End If
                
					Next
            
				Next
        
				' Falls ein aktives Abo gefunden wurde:
				If ActiveSubscription.IsInitialized Then
					'Log("Aktives Abo: " & ActiveSubscription.ProductIdentifier & " bis " & DateTime.Date(ActiveSubscription.ExpiresDate))
				Else
					'Log("Kein aktives Abo gefunden.")
					ActiveSubscription.Initialize
				End If

			End If
		Else
			'Log("Keine Abonnements gefunden.")
		End If

	Else
		'no subscriptions
		Log(J.ErrorMessage)
		Error.ErrorMessage = J.ErrorMessage
	End If
        
	j.Release

	If ActiveSubscription.IsInitialized = False Then ActiveSubscription.Initialize

	ActiveSubscription.Error = Error
	Return ActiveSubscription

End Sub

'Public Sub GetCustomer2 As ResumableSub
'	
'	Dim Error As RevenueCat_Error
'	Error.Initialize
'	
'	Dim Subscription As RevenueCat_Subscription
'	Subscription.Initialize
'	
'	Dim J As HttpJob
'	J.Initialize("CreateUserORGetUserInfo", Me)
'	J.Download("https://api.revenuecat.com/v1/subscribers/" & m_AppUserId)
'	'SharedCode.MeuPerfil.UIDFirebase is the user id that will be created at revenuecat to identify the user.
'    
'	J.GetRequest.SetHeader("Accept","application/json")
'
'	#If B4I
'	J.GetRequest.SetHeader("X-Platform","ios")
'	#Else If B4A
'	J.GetRequest.SetHeader("X-Platform","android")
'	#Else If B4J
'	
'	#End If
'
'	#If RELEASE
'	J.GetRequest.SetHeader("X-Is-Sandbox",False)
'	#Else
'	J.GetRequest.SetHeader("X-Is-Sandbox",True)
'	#End If
'
'	J.GetRequest.SetHeader("Content-Type","application/json")
'	J.GetRequest.SetHeader("Authorization","Bearer " & m_API_KEY)
'	'Main.ptrc    revenue cat key
'    
'    
'	Wait For (J) JobDone(j As HttpJob)
'    
'	Error.Success = True
'	
'	If J.Success Then
'		Log(J.GetString)
'
'		Dim js As JSONParser
'		js.Initialize(J.GetString)
'		Dim Map1 As Map = js.NextObject
'        
'		Dim subscriber As Map = Map1.Get("subscriber")
'        
'		If subscriber.Size>0 Then
'            
'			Dim subscriptions As Map = subscriber.Get("subscriptions")
'			If subscriptions.Size>0 Then
'
'				For Each Key As String In subscriptions.Keys
'					
'					For Each ProductIdentifier As String In m_lst_ProductIdentifier
'						
'						If Key = ProductIdentifier Then
'			
'							Dim SubscriptionMap As Map = subscriptions.Get(Key)
'			
'							Subscription.ProductIdentifier = Key
'							Subscription.ExpiresDate = ParseUTCstring(SubscriptionMap.Get("expires_date")) 'ParseDateTime(SubscriptionMap.Get("expires_date"))
'							Subscription.OwnershipType = SubscriptionMap.Get("ownership_type")
'							Subscription.Store = SubscriptionMap.Get("store")
'							Subscription.isSandbox = SubscriptionMap.Get("is_sandbox")
'							Subscription.GracePeriodExpiresDate = ParseUTCstring(SubscriptionMap.Get("grace_period_expires_date"))
'							Subscription.OriginalPurchaseDate = ParseUTCstring(SubscriptionMap.Get("original_purchase_date"))
'							Subscription.BillingIssuesDetectedAt = ParseUTCstring(SubscriptionMap.Get("billing_issues_detected_at"))
'							Subscription.RefundedAt = ParseUTCstring(SubscriptionMap.Get("refunded_at"))
'							Subscription.UnsubscribeDetectedAt = ParseUTCstring(SubscriptionMap.Get("unsubscribe_detected_at"))
'							Subscription.AutoResumeDate = ParseUTCstring(SubscriptionMap.Get("auto_resume_date"))
'							Subscription.PurchaseDate = ParseUTCstring(SubscriptionMap.Get("purchase_date"))
'							Subscription.StoreTransactionId = SubscriptionMap.Get("store_transaction_id")
'							Subscription.PeriodType = SubscriptionMap.Get("period_type")
'							If Subscription.ExpiresDate > DateTime.Now Then	Exit 'This subscription is active
'							
'						End If
'						
'					Next
'					
'				Next
'				
'			End If
'		Else
'			'no subscriptions
'            
'		End If
'	Else
'		'no subscriptions
'		Log(J.ErrorMessage)
'		Error.ErrorMessage = J.ErrorMessage
'	End If
'        
'	j.Release
'
'	Subscription.Error = Error
'	Return Subscription
'
'End Sub

'Records a purchase for a Customer from iOS, Android, or Stripe and will create a Customer if they don't already exist.
'https://www.revenuecat.com/docs/api-v1#tag/transactions/operation/receipts
'Product - In B4I the ProductInformation Object in B4A the Receipt Token
Public Sub CreatePurchase(ProductId As String,Product As Object) As ResumableSub
	
	Dim Error As RevenueCat_Error
	Error.Initialize
	
	Dim Subscription As RevenueCat_Subscription
	Subscription.Initialize
	
	#if b4a
	Dim req As String = ""
   Dim J As HttpJob
	'    J.Initialize("RegisterPurchaseRevenueCat", Me)
	'    Dim req As String = $"{
	'     "product_id": "${Sku}",
	'     "currency": "BRL",
	'     "is_restore": "false",
	'     "app_user_id": "${SharedCode.MeuPerfil.UIDFirebase}",
	'     "fetch_token": "${PurchaseToken}"
	'}"$
#End If
#if b4i

	Dim J As HttpJob
	J.Initialize("RegisterPurchaseRevenueCat", Me)
	
	Dim RequestMap As Map
	RequestMap.Initialize
	RequestMap.Put("product_id",ProductId)
	RequestMap.Put("app_user_id",m_AppUserId)
	RequestMap.Put("fetch_token",GetPurchaseToken(Product))
	
'	Try

'	Dim ThisPurchase As Purchase = Product
'	Dim PurchaseMap As Map
'	PurchaseMap.Initialize
'	If ThisPurchase.Tag Is Map Then
'		PurchaseMap = ThisPurchase.Tag
'	End If

'		If PurchaseMap.ContainsKey(ThisPurchase.ProductIdentifier) Then
'			Dim PriceCurrency() As String = GetPriceAndCurrencyISO3LetterCode(PurchaseMap.Get(ThisPurchase.ProductIdentifier).As(ProductInformation).LocalizedPrice)
'			If PriceCurrency(0) > 0 And PriceCurrency(1) <> "" Then
'				RequestMap.Put("price",PriceCurrency(0))
'				RequestMap.Put("currency",PriceCurrency(1))
'			End If
'		End If
'
'	Catch
'		Log(LastException)
'	End Try

	Dim jsonParser As JSONGenerator
	jsonParser.Initialize(RequestMap)

	'Log(jsonParser.ToPrettyString(2))
	
#End If
	J.PostString("https://api.revenuecat.com/v1/receipts", jsonParser.ToString)
	J.GetRequest.SetHeader("Authorization","Bearer " & m_API_KEY)
	J.GetRequest.SetHeader("Accept","application/json")
	#If RELEASE
	J.GetRequest.SetHeader("X-Is-Sandbox",False)
	#Else
	J.GetRequest.SetHeader("X-Is-Sandbox",True)
	#End If
	J.GetRequest.SetContentType("application/json")
    #if b4a
    J.GetRequest.SetHeader("X-Platform","android")
    #End If
    #if b4i
	J.GetRequest.SetHeader("X-Platform","ios")
    #End If
    
	Wait For (J) JobDone(j As HttpJob)
	
	Error.Success = J.Success
	
	If J.Success Then
		
		Log(J.GetString)
		
		Dim parser As JSONParser
		parser.Initialize(J.GetString)
		Dim jRoot As Map = parser.NextObject
		Dim subscriber As Map = jRoot.Get("subscriber")

		Dim subscriptions As Map = subscriber.Get("subscriptions")
	
		For Each Key As String In subscriptions.Keys
			If Key = ProductId Then
			
				Dim SubscriptionMap As Map = subscriptions.Get(Key)
			
				Subscription.ProductIdentifier = Key
				Subscription.ExpiresDate = ParseUTCstring(SubscriptionMap.Get("expires_date"))
				Subscription.OwnershipType = SubscriptionMap.Get("ownership_type")
				Subscription.Store = SubscriptionMap.Get("store")
				Subscription.isSandbox = SubscriptionMap.Get("is_sandbox")
				Subscription.GracePeriodExpiresDate = ParseUTCstring(SubscriptionMap.Get("grace_period_expires_date"))
				Subscription.OriginalPurchaseDate = ParseUTCstring(SubscriptionMap.Get("original_purchase_date"))
				Subscription.BillingIssuesDetectedAt = ParseUTCstring(SubscriptionMap.Get("billing_issues_detected_at"))
				Subscription.RefundedAt = ParseUTCstring(SubscriptionMap.Get("refunded_at"))
				Subscription.UnsubscribeDetectedAt = ParseUTCstring(SubscriptionMap.Get("unsubscribe_detected_at"))
				Subscription.AutoResumeDate = ParseUTCstring(SubscriptionMap.Get("auto_resume_date"))
				Subscription.PurchaseDate = ParseUTCstring(SubscriptionMap.Get("purchase_date"))
				Subscription.StoreTransactionId = SubscriptionMap.Get("store_transaction_id")
				Subscription.PeriodType = SubscriptionMap.Get("period_type")
			
			End If
		Next
		
	Else
		'handle errors
		Log(J.ErrorMessage)
		Error.ErrorMessage = J.ErrorMessage
	End If
    
	j.Release
	
	Subscription.Error = Error
	Return Subscription
End Sub

#If B4I
Private Sub GetPurchaseToken(Product As Purchase) As String
	Dim no As NativeObject = Product
	Dim receipt As NativeObject = no.GetField("transactionReceipt")
	If receipt.IsInitialized Then
		Dim b() As Byte = receipt.NSDataToArray(receipt)
		Dim stringu As StringUtils
		Return stringu.EncodeBase64(b)
	End If
	Return ""
End Sub

#End If

'Public Sub ParseResult(Json As String,TargetIdentifyer As String)
'	Dim parser As JSONParser
'	parser.Initialize(Json)
'	Dim jRoot As Map = parser.NextObject
'	Dim subscriber As Map = jRoot.Get("subscriber")
'
'	Dim subscriptions As Map = subscriber.Get("subscriptions")
'	
'	For Each key As String In subscriptions.Keys
'		If key = TargetIdentifyer Then
'			
'			Dim Subscription As Map = subscriptions.Get(key)
'					
'				Dim expires_date As Long = ParseDateTime(Subscription.Get("expires_date"))
'				Log(DateUtils.TicksToString(expires_date))		
'			
'		End If
'	Next
'	
'End Sub

Private Sub ParseUTCstring(utc As String) As Long
	If utc = "" Or utc = Null Or utc = "null" Then Return 0
	Dim df As String = DateTime.DateFormat
	Dim res As Long
	If utc.CharAt(10) = "T" Then
		'convert the second format to the first one.
		If utc.CharAt(19) = "." Then utc = utc.SubString2(0, 19) & "+0000"
		DateTime.DateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
	Else
		DateTime.DateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
	End If
	Try
		res = DateTime.DateParse(utc)
	Catch
		res = 0
		LogColor("Error parsing: " & utc, Colors.Red)
	End Try
	DateTime.DateFormat = df
	Return res
End Sub

#If B4I
Private Sub GetPriceAndCurrencyISO3LetterCode(LocalizedPrice As String) As String() 'Ignore
	Try
	
		Dim b2() As Byte = LocalizedPrice.GetBytes("UTF8")
		Dim iUesh As Int
		For ii = 0 To b2.Length - 2
			If b2(ii) = 0xc2 And b2(ii+1) = 0xa0 Then
				iUesh = ii
				Exit
			End If
		Next
		Dim sPriceNum As String = LocalizedPrice.SubString2(0, iUesh)
    
		Dim sPrice3Cur As String '= "EUR"
		Dim nativeMe As NativeObject = Me
		sPrice3Cur = nativeMe.RunMethod("get3LetCur", Null).AsString
'	LogColor(sPriceNum,0xff00ff00)
'	LogColor(sPrice3Cur,0xff00ff00)
		Return Array As String(sPriceNum.Replace(",","."), sPrice3Cur)
	
	Catch
		Log(LastException)
	End Try
	Return Array As String(0,"")
End Sub
#End If

#If OBJC
- (NSString*) get3LetCur {
   NSString *country3LetCur = [[NSLocale currentLocale] objectForKey: NSLocaleCurrencyCode];
   return country3LetCur;
}
#end if