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
	Dim AdViewInline As AdView
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
		
	AdViewAdaptive.Initialize2("adap", "ca-app-pub-3940256099942544/6300978111", size.Native)  'Fixed Size Banner
	Root.AddView(AdViewAdaptive, 0, 100%y - iheight, size.Width, iheight)
	AdViewAdaptive.LoadAd
	
'	Dim sizein As AdInlineSize = Utils.GetInlineAdaptiveAdSize
	Dim sizein As AdInlineSize = Utils.GetAutoHeightBannerSize
	
	Dim iheight2 As Int
	AdViewInline.Initialize2("adapin", "ca-app-pub-3940256099942544/9214589741", sizein.Inline)  'Adaptive Banner
'	iheight2 = 15%y
	iheight2 = sizein.Height
	LogColor(sizein.Height, xui.Color_Green)
	LogColor(sizein.Width, xui.Color_Green)
			
	CustomListView1.GetBase.Height = Root.height - iheight
	CustomListView1.sv.Height = Root.height - iheight
	
	For i = 0 To 100
		If i = 2 Then
			CustomListView1.Add(CreateItemAdmobInline(AdViewInline, sizein.Width, iheight2), $"Item #${i}"$)
		End If
		CustomListView1.AddTextItem("Text " & i, i)		
	Next
	
	AdViewInline.LoadAd
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub adap_ReceiveAd
	Log("AdViewAdaptive ReceiveAd")
End Sub

Sub adap_AdScreenDismissed
	Log("AdViewAdaptive AdScreenDismissed")
End Sub

Sub adapin_ReceiveAd
	Log("AdViewInlineAdaptive ReceiveAd")
	LogColor(AdViewInline.Height, xui.Color_Yellow)
	LogColor(AdViewInline.Width, xui.Color_Yellow)
End Sub

Sub adapin_AdScreenDismissed
	Log("AdViewInlineAdaptive AdScreenDismissed")
End Sub

Sub CreateItemAdmobInline(Ad As AdView, Width As Int, height As Int) As Panel
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, Width, height)
	
	p.AddView(Ad, 0, 0, Width, height)
	
	Return p
End Sub