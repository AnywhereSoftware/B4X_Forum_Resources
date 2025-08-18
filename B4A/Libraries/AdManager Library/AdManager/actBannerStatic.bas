B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10.5
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
End Sub

Sub Globals
	Private AdManager1 As AdManager
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'***************************************************************************************************************
	'***************************************************************************************************************
	'
	'   CHECK MANIFEST - you should replace "ca-app-pub-3940256099942544~3347511713" in manifest with your APP ID
	'
	'***************************************************************************************************************
	'***************************************************************************************************************
	Activity.Title = "Banner (Static) Example"
	AdManager1.Initialize("AdManager1")

	Activity.AddView(AdManager1, 100%x/2-160dip, 0, 320dip, 100dip)
	AdManager1.LoadPersonalized("/6499/example/banner", AdManager1.ADSIZE_LARGE_BANNER)   ' You can use Consent dialog from AdMob library to determine if user is in EEA zone or not.
	'AdManager1.LoadNonPersonalized("/6499/example/banner", AdManager1.ADSIZE_BANNER)

End Sub

Sub Activity_Resume
	AdManager1.Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	AdManager1.Pause
End Sub

Sub AdManager1_AdClicked
	Log("AdClicked - event fire") ' I didn't see this event fire
End Sub

Sub AdManager1_AdClosed
	Log("AdClosed - event fire")
End Sub

Sub AdManager1_AdFailedToLoad (Error As String)
	Log("AdFailedToLoad: " & Error)
End Sub

Sub AdManager1_AdImpression
	Log("AdImpression - event fire")
End Sub

Sub AdManager1_AdLeftApplication
	Log("AdLeftApplication - event fire")
End Sub

Sub AdManager1_AdLoaded
	Log("AdLoaded - event fire")
End Sub