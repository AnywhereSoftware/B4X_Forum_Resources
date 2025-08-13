B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.86
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private mwAdInterstitial2 As InterstitialAd
End Sub

'You can add more parameters here.
Public Sub Initialize
	mwAdInterstitial2.Initialize("mwadi2","ca-app-pub-3940256099942544/1033173712")  'TEST AD UNIT
	
	mwAdInterstitial2.LoadAd

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("LayAdmob2")
	
End Sub

Sub mwadi2_AdFailedToLoad (ErrorMessage As String)
	Log("mwadi2 AdFailedToLoad: " & Utils.GetErrorCodeAd(ErrorMessage))
End Sub

Sub mwadi2_AdClosed
	Log("mwadi2 AdClosed")
	mwAdInterstitial2.LoadAd 'prepare a new ad
End Sub

Sub mwadi2_AdLoaded
	Log("mwadi2 Adloaded")
End Sub

Sub mwadi2_ReceiveAd
	Log("mwadi2 ReceiveAd")
	ToastMessageShow("Interstitial Received", False) 'show only in the example
End Sub

Sub mwadi2_AdScreenDismissed
	Log("mwadi2 AdScreenDismissed")
End Sub

Sub Button1_Click
	If (mwAdInterstitial2.IsInitialized) And (mwAdInterstitial2.Ready) Then
		mwAdInterstitial2.Show
	End If
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.