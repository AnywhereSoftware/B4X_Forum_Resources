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
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim AdSize As JavaObject
	Dim width As Int = 100%x / GetDeviceLayoutValues.Scale
	Dim res As AdSize
	res.Native = AdSize.InitializeStatic("com.google.android.gms.ads.AdSize").RunMethod("getCurrentOrientationAnchoredAdaptiveBannerAdSize", Array(ctxt, width))
	Dim jo As JavaObject = res.Native
	res.Width = jo.RunMethod("getWidthInPixels", Array(ctxt))
	res.Height = jo.RunMethod("getHeightInPixels", Array(ctxt))
	Return res
End Sub