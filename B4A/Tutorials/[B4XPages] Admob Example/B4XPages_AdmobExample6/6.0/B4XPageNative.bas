B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.86
@EndOfDesignText@
'Links to check:
'https://www.b4x.com/android/forum/threads/native-ads-unified-with-mediaview.100350/#content
'https://www.b4x.com/android/forum/threads/any-news-about-native-ads-advanced.88100/#content

'This was based in the class:
'- FirebaseAdmob Native Ad Class
'https://www.b4x.com/android/forum/threads/firebaseadmob-native-ad-class.107423/#post-671894

Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Dim nuad As mwFirebaseAdmobNative
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	'Native Ads Advanced
	'https://developers.google.com/admob/android/native/advanced
	
	'Ad Unit : ca-app-pub-3940256099942544/2247696110 = Native Advanced TEST
	'Ad Unit : ca-app-pub-3940256099942544/1044960115 = Native Advanced with Video TEST
	
	Dim testing = True As Boolean
	nuad.Initialize(Me,"ca-app-pub-3940256099942544/2247696110",10dip,10dip,100%X-20dip,150dip,Root,testing)
	nuad.LoadNativeAd	
End Sub

Sub nativead_ReceiveAd
	LogColor("Native Ad Received",Colors.green)
End Sub
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.