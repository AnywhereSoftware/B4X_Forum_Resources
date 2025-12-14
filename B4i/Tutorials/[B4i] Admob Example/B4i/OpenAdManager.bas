B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'v1.00
Sub Class_Globals
	Private IsLoadingAd As Boolean
	Private mAdUnitId As String
	Private OpenAd As NativeObject
	Private IsShowingAd As Boolean
	Private AdTime As Long
End Sub

Public Sub Initialize (AdUnitId As String)
	mAdUnitId = AdUnitId
	Dim n As NativeObject
	n.Initialize("B4IObjectWrapper").RunMethod("setBIAndEventName:::", _
		Array(Me, Me.As(NativeObject).GetField("bi"), "openad"))
	LoadAd
End Sub

Private Sub LoadAd
	If IsLoadingAd Or IsAdAvailable Then Return
	IsLoadingAd = True
	Dim request As NativeObject
	Log("loading open ad")
	request = request.Initialize("GADRequest").RunMethod("new", Null)
	Me.As(NativeObject).RunMethod("loadAd::", Array(mAdUnitId, request))
End Sub

Private Sub Load_Ad(Success As Boolean, Ad As Object)
	IsLoadingAd = False
	If Success Then
		Log("open ad load success")
		AdTime = DateTime.Now
		Dim delegate As NativeObject
		delegate = delegate.Initialize("B4IFullScreenContentDelegate").RunMethod("new", Null)
		delegate.SetField("target", Me)
		OpenAd = Ad
		OpenAd.SetField("fullScreenContentDelegate", delegate)
	Else
		Log("open ad load error: " & LastException)
		Sleep(5 * DateTime.TicksPerMinute)
		LoadAd
	End If
End Sub

Private Sub OpenAd_AdClosed
	IsShowingAd = False
	Log("open ad closed")
	Dim OpenAd As NativeObject 'reset
	Sleep(10000)
	LoadAd
End Sub

'Call when app moves to foreground
Public Sub ShowAdIfAvailable
	If IsAdAvailable = False Or IsShowingAd Then Return
	IsShowingAd = True
	OpenAd.RunMethod("presentFromRootViewController:", Array(Null))
End Sub

Public Sub IsAdAvailable As Boolean
	Return OpenAd.IsInitialized And AdTime + 4 * DateTime.TicksPerHour > DateTime.Now
End Sub

#IF OBJC
- (void) loadAd:(NSString*)unit :(GADRequest*)request {
	[GADAppOpenAd loadWithAdUnitID:unit
                         request:request
               completionHandler:^(GADAppOpenAd * _Nullable appOpenAd, NSError * _Nullable error) {
    if (error) {
		 [B4I shared].lastError = error;
		[self.bi raiseUIEvent:nil event:@"load_ad::" params:@[@(false), [NSNull null]]];
    } else {
		[self.bi raiseUIEvent:nil event:@"load_ad::" params:@[@(true), appOpenAd]];
	}
  }];
}
#End If