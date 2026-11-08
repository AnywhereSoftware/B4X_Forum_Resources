B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10.5
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals

End Sub
Sub Globals
		Dim UnifiedNativeAd As UnifiedNativeAd
End Sub
Sub Activity_Create(FirstTime As Boolean)
		ProgressDialogShow2("Loading Ad...",False)
		CreateUnifiedNativeAd
End Sub
Sub Activity_Resume

End Sub
Sub Activity_Pause (UserClosed As Boolean)

End Sub


Sub CreateUnifiedNativeAd
		Dim VideoOptions As UnifiedNativeVideoOptions
			VideoOptions.setStartMuted(False)
		Dim AdOptions As UnifiedNativeAdOptions
			AdOptions.setAdChoicesPlacement(AdOptions.ADCHOICES_TOP_RIGHT).setVideoOptions(VideoOptions).setRequestMultipleImages(True)
			
		UnifiedNativeAd.Initialize("UnifiedNativeAd")
		UnifiedNativeAd.WithAdOptions(AdOptions)
		UnifiedNativeAd.Load("ca-app-pub-3940256099942544/2247696110")
End Sub
Sub UnifiedNativeAd_onAdLoaded
		ProgressDialogHide
		Log("UnifiedNativeAd_onAdLoaded")	
		Log("IsAdAboutApps: " & UnifiedNativeAd.AdData.IsAdAboutApps)

		
		' AdContainer
            Dim container As Panel
                container.Initialize("")
                Activity.addview(container,0,0,100%x,100%y)
                container.AddView(UnifiedNativeAd.AdView.build,0,0,container.Width,container.Height)
                container.Color = 0xffFAFAFA
	
			
		' Check If Has Icon Or Not
			If UnifiedNativeAd.AdData.HasIcon Then
	            Dim IconView As ImageView
	                IconView.Initialize("")
	                container.AddView(IconView,16dip,16dip,48dip,48dip)
	                IconView.Background = UnifiedNativeAd.AdData.Icon
	                UnifiedNativeAd.AdView.IconView = IconView						
			End If
	
		          
        ' Headline 
            Dim HeadlineView As Label
                HeadlineView.Initialize("")
                container.AddView(HeadlineView,16dip,16dip,container.Width - 32dip,30dip)
                HeadlineView.Text = UnifiedNativeAd.AdData.Headline
				HeadlineView.TextSize = 18
				HeadlineView.TextColor = Colors.Black
                UnifiedNativeAd.AdView.HeadlineView = HeadlineView
				
				' Fix Dimen If Has Icon
				If UnifiedNativeAd.AdData.HasIcon Then
					HeadlineView.Left = IconView.Left + IconView.Width + 16dip
					HeadlineView.Width = container.Width - HeadlineView.Left - 16dip
				End If
				

        ' Advertiser
            Dim AdvertiserView As Label
                AdvertiserView.Initialize("")
                container.AddView(AdvertiserView,HeadlineView.Left,HeadlineView.Top + HeadlineView.Height,HeadlineView.Width,20dip)
                AdvertiserView.Text = UnifiedNativeAd.AdData.Advertiser
				AdvertiserView.TextSize = 16
				AdvertiserView.TextColor = Colors.Black
                UnifiedNativeAd.AdView.AdvertiserView = AdvertiserView
				If AdvertiserView.Text.Trim.Length = 0 Then AdvertiserView.Height = 0

		  
		' Call To Action
            Dim cta As Button 
                cta.Initialize("")
                container.AddView(cta,16dip,container.Height - 48dip - 16dip,container.Width - 32dip,48dip)
                cta.Text = UnifiedNativeAd.AdData.CallToAction
				cta.Color = 0xff1976D2
				cta.TextColor = Colors.White
				cta.TextSize = 18
				cta.Gravity = Gravity.CENTER
				cta.Typeface = Typeface.DEFAULT_BOLD
                UnifiedNativeAd.AdView.CallToActionView = cta 
		  
        '  Body
            Dim BodyView As Label
                BodyView.Initialize("")
                container.AddView(BodyView,16dip,AdvertiserView.Top + AdvertiserView.Height + 32dip,container.Width - 32dip,50dip)
                BodyView.Text = UnifiedNativeAd.AdData.Body
				BodyView.TextSize = 16
				BodyView.TextColor = 0x99000000
                UnifiedNativeAd.AdView.BodyView = BodyView
				
						  
		'MediaView
            Dim mediaView As MediaView
                mediaView.Initialize("")
                container.AddView(mediaView,16dip,BodyView.Top + BodyView.Height + 16dip,container.Width - 32dip,200dip)
                mediaView.Height = mediaView.Width / UnifiedNativeAd.AdData.MediaContent.AspectRatio
				mediaView.Left = (container.Width - mediaView.Width) /2
                UnifiedNativeAd.AdView.MediaView = mediaView
  
			
			
		' Set As NativeAd At *** Final ***
			UnifiedNativeAd.setAsNativeAd
End Sub
Sub UnifiedNativeAd_onAdFailedToLoad(ErrorCode As Int)
		ProgressDialogHide
		Log($"UnifiedNativeAd_onAdFailedToLoad, ErrorCode: ${ErrorCode}"$)
End Sub
Sub UnifiedNativeAd_onAdOpened
		Log("UnifiedNativeAd_onAdOpened")
End Sub
Sub UnifiedNativeAd_onAdLeftApplication
		Log("UnifiedNativeAd_onAdLeftApplication")
End Sub
Sub UnifiedNativeAd_onAdClosed
		Log("UnifiedNativeAd_onAdClosed")
End Sub
