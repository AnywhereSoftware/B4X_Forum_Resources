B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private CustomListView1 As CustomListView
	Dim AdViewAdaptive As AdView
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("laybannerclv")
	
	'ADAPTIVE BANNER
	'https://www.b4x.com/android/forum/threads/admob-adaptive-banners.111525/#content
	'https://developers.google.com/admob/android/banner/adaptive
	Dim size As AdSize = Utils.GetAdaptiveAdSize
	
	Dim iheight As Int
	iheight = size.Height
		
	AdViewAdaptive.Initialize2("adap", "ca-app-pub-3940256099942544/6300978111", size.Native)
	Root.AddView(AdViewAdaptive, 0, 100%y - iheight, size.Width, iheight)
	AdViewAdaptive.LoadAd
	
	CustomListView1.GetBase.Height = Root.height - iheight
	CustomListView1.sv.Height = Root.height - iheight
	
	For i = 0 To 100
		CustomListView1.AddTextItem("Text " & i, i)
	Next
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub adap_ReceiveAd
	Log("AdViewAdaptive ReceiveAd")
End Sub

Sub adap_AdScreenDismissed
	Log("AdViewAdaptive AdScreenDismissed")
End Sub
