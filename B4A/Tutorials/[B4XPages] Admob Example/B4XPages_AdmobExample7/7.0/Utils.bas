B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'https://www.b4x.com/android/forum/threads/custom-transitions-between-activities.15065/#content
'requires Reflection library

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
End Sub

Sub GetErrorCodeAd(ErrorCode As String) As String
	Dim str_error As String
	Select ErrorCode
		Case 0
			str_error = "INTERNAL_ERROR"  'Something happened internally; for instance, an invalid response was received from the ad server.
		Case 1
			str_error = "INVALID_REQUEST" 'The ad request was invalid; for instance, the ad unit ID was incorrect.
		Case 2
			str_error = "NETWORK_ERROR"   'The ad request was unsuccessful due to network connectivity.
		Case 3
			str_error = "NO_FILL"         'The ad request was successful, but no ad was returned due to lack of ad inventory
	End Select
	
	Return ErrorCode & " - " & str_error
End Sub

'Adaptive Banners
Sub GetAdaptiveAdSize As AdSize
	Log("GetAdaptiveAdSize")
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim AdSize As JavaObject
	Dim width As Int = 100%x / GetDeviceLayoutValues.Scale
	
	Dim res As AdSize
	res.Native = AdSize.InitializeStatic("com.google.android.gms.ads.AdSize").RunMethod("getCurrentOrientationAnchoredAdaptiveBannerAdSize", Array(ctxt, width))
	
	Dim jo As JavaObject = res.Native
	LogColor(res.Native, Colors.Cyan)
	res.Width = jo.RunMethod("getWidthInPixels", Array(ctxt))
	res.Height = jo.RunMethod("getHeightInPixels", Array(ctxt))
'	LogColor(res.Height, Colors.Green)
		
	Return res
End Sub

'Inline Adaptive Banners
Sub GetInlineAdaptiveAdSize As AdInlineSize
	LogColor("GetInlineAdaptiveAdSize", Colors.Green)
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	
	Dim InSize As JavaObject
	Dim adWidth As Int = 100%x / GetDeviceLayoutValues.Scale
	LogColor(adWidth, Colors.Magenta)
	
	' Define a altura máxima do banner
	Dim maxHeight As Int = 15%y '/ GetDeviceLayoutValues.Scale	' Ajuste conforme necessário
	LogColor("Max Height: " & maxHeight, Colors.Magenta)
	
	'Use os métodos estáticos apropriados na classe de tamanho do anúncio,
	'como AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(Context context, int width),
	'para receber um objeto de tamanho de anúncio adaptativo inline para a orientação escolhida.
	
'	getCurrentOrientationInlineAdaptiveBannerAdSize(Context context, int width)
'	Returns an AdSize with the given width And a height that Is always 0.
		
	Dim res As AdInlineSize
	res.Inline = InSize.InitializeStatic("com.google.android.gms.ads.AdSize").RunMethod("getInlineAdaptiveBannerAdSize", Array(adWidth, maxHeight))
       
	LogColor(InSize, Colors.Yellow)
	Log(res.Inline)
	
	Dim jo As JavaObject = res.Inline
	LogColor(jo, Colors.Green)
	res.Width = jo.RunMethod("getWidthInPixels", Array(ctxt))
	LogColor(res.Width, Colors.Green)
	res.Height = jo.RunMethod("getHeightInPixels", Array(ctxt))
	LogColor(res.Height, Colors.Cyan)
	
	Return res
End Sub

Sub GetAutoHeightBannerSize As AdInlineSize
	LogColor("GetAutoHeightBannerSize", Colors.Blue)

	Dim ctxt As JavaObject
	ctxt.InitializeContext

	Dim AdSizeJO As JavaObject
	AdSizeJO.InitializeNewInstance("com.google.android.gms.ads.AdSize", Array(-1, -2)) ' FULL_WIDTH, AUTO_HEIGHT

	Dim res As AdInlineSize
	res.Initialize
	res.Inline = AdSizeJO

	res.Width = AdSizeJO.RunMethod("getWidthInPixels", Array(ctxt))
	res.Height = AdSizeJO.RunMethod("getHeightInPixels", Array(ctxt))

	LogColor("AutoHeight Width (px): " & res.Width, Colors.Green)
	LogColor("AutoHeight Height (px): " & res.Height, Colors.Cyan)

	Return res
End Sub
