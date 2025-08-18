B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10.7
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private xui As XUI 'ignore
	Private nad As mwNative
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	'Activity.LoadLayout("Layout1")
	nad.Initialize(Activity, Me)
	nad.LoadNativeAd("NativeAd2", "ca-app-pub-3940256099942544/1044960115")
	'ca-app-pub-3940256099942544/2247696110  'Native Advanced TEST
	'ca-app-pub-3940256099942544/1044960115 Native Advanced with Video TEST
End Sub

Sub Activity_Resume
	
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Sub NativeAd2_FailedToReceiveAd (ErrorCode As String)
	Log("NativeAd2_FailedToReceiveAd: " & ErrorCode)
End Sub

Sub NativeAd2_AdOpened
	Log("NativeAd2_AdOpened")
End Sub

Sub NativeAd2_ReceiveAd
	LogColor("NativeAd2_ReceiveAd", Colors.Magenta)
End Sub
