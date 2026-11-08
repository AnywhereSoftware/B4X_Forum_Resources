B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private nad As mwNative
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root

	nad.Initialize(Root, Me)
	nad.LoadNativeAd("NativeAd2", "ca-app-pub-3940256099942544/1044960115")
	'ca-app-pub-3940256099942544/2247696110  'Native Advanced TEST
	'ca-app-pub-3940256099942544/1044960115 Native Advanced with Video TEST
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub NativeAd2_FailedToReceiveAd (ErrorCode As String)
	Log("NativeAd2_FailedToReceiveAd: " & ErrorCode)
End Sub

Sub NativeAd2_AdOpened
	Log("NativeAd2_AdOpened")
End Sub

Sub NativeAd2_ReceiveAd
	LogColor("NativeAd2_ReceiveAd", Colors.Magenta)
End Sub
