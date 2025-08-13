B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private GPPurchases1 As GPPurchases
	Private LICENSE_KEY As String = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqt9Is4LyBX0dIXPEerR6fvbFGy0e/oyrXbcDDQ+Xfq2O+r+dv6F5AINrTesFDZ4csW1q16TXTptHQ1WoyS/1g9VOPwlJ+ZrVpuGQ2ezanSFrrNSa71smJWKi6D3sXnaMiYfopsxP0bwge37YoeeI18cYN/eeW+uzYRTvh6MpyEmjalHUGCsH6GY6D5D2tqaWJSE14rgAkzwulVhpwWjwNb0RYdCmoAKJPTRSQLPoUlnrvx9TSq5CnMM09IIUR9xbkkHrPBv72+Xzp546ytE1rFT/f/T9+cVpfrxCHJ8zi1FEG86+7TQeOpb527vn2pbVFv/xOVq9M9W2cpdSa+SY/wIDAQAB"
	Private lSKU_inapp As List
	Private lSKU_subs As List
	Public skutype As String 
	Public sku As String 
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("lPurchases")
	
	lSKU_inapp.Initialize
	lSKU_subs.Initialize
	GPPurchases1.Init(LICENSE_KEY)
End Sub

Private Sub B4XPage_Appear
	Select Case skutype
		Case "ALL"   'to show all skus to purchase
			lSKU_inapp.Clear
			lSKU_inapp.Add("pro.gpbtest2")
			lSKU_inapp.Add("pro.gpbtest3")
			lSKU_subs.Clear
			lSKU_subs.Add("silver.gpbtest")
			lSKU_subs.Add("gold.gpbtest")
		Case "INAPP"   'to show only one inapp sku to purchase
			lSKU_inapp.Clear
			lSKU_inapp.Add(sku)
		Case "SUBS"   'to show only one subs sku to purchase
			lSKU_subs.Clear
			lSKU_subs.Add(sku)
	End Select

	GPPurchases1.SetSku(skutype, lSKU_inapp, lSKU_subs)
	GPPurchases1.ShowSku
End Sub

Private Sub GPPurchases1_PurchaseCompleted(p As Purchase)
	Log("purchased")
	SetUserEntitlement(p.Sku, True)
End Sub

Private Sub GPPurchases1_PurchaseError(Result As BillingResult)
	xui.MsgboxAsync(GPPurchases1.ErrorText(Result.ResponseCode), "")
End Sub

Private Sub GPPurchases1_BillingError(error As Int)
	Select Case error
		Case GPPurchases1.CODE_NO_INAPP
			xui.MsgboxAsync("They are no products to buy", "")
		Case GPPurchases1.CODE_NO_SUBSCRIPTION
			xui.MsgboxAsync("They are no products to subscribe", "")
		Case Else
			xui.MsgboxAsync(GPPurchases1.ErrorText(error), "Error")
	End Select
End Sub

Public Sub ConsumeProduct(pstype As String, psku As String)
	If Not(GPPurchases1.IsInitialized) Then
		GPPurchases1.Initialize(Me, "GPPurchases1")
		GPPurchases1.Init(LICENSE_KEY)
	End If
	Wait For(GPPurchases1.ConsumeProduct(pstype, psku)) Complete (Result1 As BillingResult)
	If Result1.IsSuccess Then
		Log("consumed")
		SetUserEntitlement(psku, False)
	Else
		xui.MsgboxAsync(GPPurchases1.ErrorText(Result1.ResponseCode), "")
	End If
End Sub

Sub SetUserEntitlement(psku As String, perm As Boolean)
	Select Case psku
		Case "pro.gpbtest2"
'			set permissions true or false
		Case "pro.gpbtest3"
'			set permissions true or false
		Case "silver.gpbtest"
'			set permissions true or false
		Case "gold.gpbtest"
'			set permissions true or false
	End Select
End Sub