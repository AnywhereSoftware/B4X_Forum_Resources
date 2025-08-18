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
	Private stc As StripeClass
	Private sessionHTML As String
		
	Private Root As B4XView
	Private xui As XUI
	Private wvApple As WebView
End Sub

Public Sub Initialize
	Private	StripeAPIKey,	StripeOtherKey As String
	
	#if B4a
		#if RELEASE  'LIVE
			StripeAPIKey = GetValueFromManifest("stripeLIVEAPIkey")
			StripeOtherKey = GetValueFromManifest("stripeLIVEOtherkey")
		#else  ' TEST
			StripeAPIKey = GetValueFromManifest("stripetestAPIkey")
			StripeOtherKey = GetValueFromManifest("stripetestOtherkey")
		#End If
	#else if B4i
		#if StoreRelease
			StripeAPIKey    = "pk_LIVE_XXXX"
			StripeOtherKey  = "sk_LIVE_XXXX"
	
		#else
			StripeAPIKey    = "pk_test_XXXX"
			StripeOtherKey  = "sk_test_XXXX"
		#end if	
	#End If
	stc.Initialize(StripeAPIKey,StripeOtherKey)

	sessionHTML = $"
	<!DOCTYPE html>
<html>
  <head>
    <title>Buy cool new product</title>
    <link rel="stylesheet" href="https://stripe.digitwellsolutions.com/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://js.stripe.com/v3/"></script>

    <script src="https://polyfill.io/v3/polyfill.min.js?version=3.52.1&features=fetch"></script>
    <script type="text/javascript">
    var stripe = Stripe("!!PRIVATEKEY!!");
    function dosession()
    {
		stripe.redirectToCheckout({ sessionId: "!!SESSIONID!!" });
    }
    </script>

  </head>
  <body>
      <script type="text/javascript">
	  dosession();
	  </script>
  </body>
</html>
	"$
	
	sessionHTML = sessionHTML.Replace("!!PRIVATEKEY!!",StripeAPIKey)
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	wait for (DoSession) complete (id As String)
	
	If (id.Length > 0) Then
		ShowPage(id)
	End If
End Sub

#if B4a
private Sub EventName_PageFinished (Url As String)
	Private success As String = "unknown"
#else if b4i	
Sub wvApple_PageFinished (Success As Boolean, Url As String)
#end if
	Log($"Page Finished is ${Success} on page ${Url}"$)
End Sub

Sub wvApple_OverrideUrl (Url As String) As Boolean
	Log($"Override ? (${Url})"$)
	If (Url.Contains("cancel.html")) Then
		wvApple.Visible = False
		xui.MsgboxAsync("Cancelling. Do something ","Hi")
		'handle cancelling here
	else if (Url.contains("success.html")) Then
		wvApple.Visible = False
		xui.MsgboxAsync("Success! Do something ","Hi")
		'Handle success here 
	End If	
	Return False
End Sub

Sub wvApple_JSComplete (Success As Boolean, Result As String)
	Log($"JS Complete is ${Success} result is ${Result}"$)
End Sub

private Sub DoSession As ResumableSub
	
	Private str As String = ""
	Private chmp As Map = CreateMap()
	
	chmp.Put("cancel_url","https://cancel.html")
	chmp.Put("success_url","https://success.html")
	chmp.Put("mode","payment")
	chmp.Put("payment_method_types[0]","card")
	
	Private lineitems As Map = CreateMap()
	
	'This is all hardcoded, you will need to change this for your own product information.
	
	Private price_data As Map = CreateMap()
	price_data.Put("currency","GBP")
	
	Private product_data As Map = CreateMap()
	
	product_data.Put("name","my product to sell")
	product_data.Put("description","Describe the product to sell")
	price_data.Put("product_data",product_data)
	price_data.Put("unit_amount",1000)
	
	
	lineitems.Put("price_data",price_data)
	lineitems.Put("quantity",1)
	chmp.Put("line_items[0]",lineitems)
	
	stc.CreateACheckoutSession(Me,chmp)
	wait for STC_CreateCheckoutSession(retn As Map)
	Private succ As Boolean = retn.GetDefault("success",False)
	If (succ) Then
		Private data As Map = retn.GetDefault("data",CreateMap())
'		Log($"Checkout Session id = ${data.GetDefault("id","no ID")}"$)
		str = data.GetDefault("id","")
	Else
		Log($"return failure - ${retn}"$)
	End If
	Return str
End Sub

private Sub ShowPage(id As String)
	
	Private localhtml As String = sessionHTML.Replace("!!SESSIONID!!",id)
	
'	Log($"Local html= ${localhtml}"$)
	wvApple.LoadHtml(localhtml)
End Sub

#if B4a
public Sub GetValueFromManifest(key As String) As String
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim ApplicationInfo As JavaObject = ctxt.RunMethodJO("getPackageManager", Null).RunMethod("getApplicationInfo", _
       Array(Application.PackageName, 0x00000080))
	Dim bundle As JavaObject = ApplicationInfo.GetField("metaData")
	Return bundle.RunMethod("getString", Array(key))
End Sub
#end if	

