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
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("LayAdmob2")
	
	mwAdInterstitial2.Initialize("mwadi2","ca-app-pub-3940256099942544/1033173712")  'TEST AD UNIT

	#If B4i
	LogColor("mwAdInterstitial2.IsReady: " & mwAdInterstitial2.IsReady, xui.Color_Cyan)
	If mwAdInterstitial2.IsReady = False Then
		mwAdInterstitial2.RequestAd
	End If
    #End If
End Sub

Sub mwadi2_AdFailedToLoad (ErrorMessage As String)
	Log("mwadi2 AdFailedToLoad: " & ErrorMessage)
End Sub

Sub mwadi2_AdClosed
	Log("mwadi2 AdClosed")
End Sub

Sub mwadi2_AdLoaded
	Log("mwadi2 Adloaded")
End Sub

Sub mwadi2_ReceiveAd
	Log("mwadi2 ReceiveAd")
End Sub

Sub mwadi2_AdScreenDismissed
	Log("mwadi2 AdScreenDismissed")
End Sub

Sub Button1_Click	
	#If B4i
	If mwAdInterstitial2.IsReady Then mwAdInterstitial2.Show(B4XPages.GetNativeParent(Me))
	#End If
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.