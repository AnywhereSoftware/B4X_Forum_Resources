#import <Foundation/Foundation.h>
#import <iCore/iCore.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <UserMessagingPlatform/UserMessagingPlatform.h>
@class B4IAdRequestBuilder;

//~version:10.00
//~dependson:AVFoundation.framework
//~dependson:AudioToolbox.framework
//~dependson:AdSupport.framework
//~dependson:CoreGraphics.framework
//~dependson:EventKit.framework
//~dependson:EventKitUI.framework
//~dependson:MessageUI.framework
//~dependson:StoreKit.framework
//~dependson:SystemConfiguration.framework
//~dependson:CoreMedia.framework
//~dependson:MediaPlayer.framework
//~dependson:SafariServices.framework
//~dependson:CoreBluetooth.framework
//~dependson:MobileCoreServices.framework
//~dependson:Firebase/GoogleMobileAds.xcframework.swift_placeholder.3
//~dependsOn:Firebase/UserMessagingPlatform.xcframework.3
//~shortname:AdView
//~objectwrapper:GADBannerView*
//~event:ReceiveAd
//~event:FailedToReceiveAd (ErrorCode As String)
@interface B4IAdView : B4IViewWrapper
//iPhone ad size (320x50)
@property (nonatomic, readonly) NSObject *SIZE_BANNER;
//Taller version of the standard banner (320x100)
@property (nonatomic, readonly) NSObject *SIZE_LARGE_BANNER;
//iPad ad size (468x60)
@property (nonatomic, readonly) NSObject *SIZE_FULL_BANNER;
//iPad ad size (728x90)
@property (nonatomic, readonly) NSObject *SIZE_LEADERBOARD;
@property (nonatomic, readonly) NSObject *SIZE_SMART_BANNER_PORTRAIT;
@property (nonatomic, readonly) NSObject *SIZE_SMART_BANNER_LANDSCAPE;
- (void)Initialize:(B4I *)bi :(NSString *)EventName :(NSString *)AdUnit :(B4IPage *)Parent :(NSObject *)AdSize;
//Requests an ad from AdMob.
- (void)LoadAd;
//Sets the test devices. Check the logs for the current device id.
- (void)SetTestDevices:(B4IList *)DeviceIds;
//Requests an ad configured with AdRequestBuilder. Note that test devices should be set in the builder.
- (void)LoadAdWithBuilder:(B4IAdRequestBuilder *)Builder;
@end
/**
* This object allows you to show interstitial ads (full screen ads).
* You need to request an ad by calling RequestAd and then wait for the Ready event.
* If the Success parameter is true then you can call Show to show the full screen ad.
* Note that you can show it whenever you like.
*/
//~shortname:InterstitialAd
//~Event:Ready (Success As Boolean)
//~event: AdClosed
//~event: AdOpened
@interface B4IAdInterstitial:NSObject
/**
* Initializes the interstitial ad manager.
*/
- (void)Initialize:(B4I *)bi :(NSString *)EventName :(NSString *)AdUnit;

/**
* Sets the test devices. You can see the device id in the logs.
*/
- (void)SetTestDevices:(B4IList *)DeviceIds;

/**
* Requests an interstitial ad. The Ready event will later be raised.
*/
- (void)RequestAd;

//Requests an ad configured with AdRequestBuilder. Note that test devices should be set in the builder.
- (void)LoadAdWithBuilder:(B4IAdRequestBuilder *)Builder;

//Returns true if there is an interstitial ad ready to be shown.
- (BOOL)IsReady;
//Shows the ad.
- (void)Show:(B4IPage *)Parent;
@end

/**
 * A video ad where the user is rewarded if it is fully watched. The Rewarded event will be raised in that case.
 */
//~shortname: RewardedVideoAd
//~event: ReceiveAd
//~event: FailedToReceiveAd (ErrorCode As String)
//~event: AdClosed
//~event: AdOpened
//~event: Rewarded (Item As Object)
@interface B4IRewardedVideoAd : NSObject
//Returns True if there is an ad ready to be shown.
@property (nonatomic, readonly) BOOL Ready;
- (void) Initialize:(B4I*)bi :(NSString *)EventName;
//Sends a request for an ad. The ReceiveAd event will be raised when an ad is available.
- (void) LoadAd:(NSString *)AdUnitId;
//Requests an ad configured with AdRequestBuilder. Note that test devices should be set in the builder.
- (void)LoadAdWithBuilder:(NSString *)AdUnitId :(B4IAdRequestBuilder *)Builder;
//Shows the video ad.
- (void) Show:(B4IPage *)Parent;
@end


//~objectwrapper: GADRequest*
//~shortname: AdRequestBuilder
@interface B4IAdRequestBuilder : B4IObjectWrapper
- (B4IAdRequestBuilder *)Initialize;
//Don't use. Does not do anything.
- (B4IAdRequestBuilder *)AddTestDevice:(NSString *)DeviceId;
//Requests non-personalized ads.
- (B4IAdRequestBuilder *)NonPersonalizedAds;
@end
//~shortname: GoogleMobileAds
@interface B4IGoogleMobileAds : NSObject
/**
*Prepares the mobile ads sdk. Should be called after the consent is available (if a consent is needed).
 */
- (void)Start;
//Returns the sdk version.
@property (nonatomic, readonly) NSString* Version;
@end
//~shortname: UMPConsentInformation
//~objectwrapper: UMPConsentInformation*
//~Event: Update (Success As Boolean)
@interface B4IConsentInformation : B4IObjectWrapper
//Returns true if the app is allowed to request ads.
@property (nonatomic, readonly) BOOL CanRequestAds;
- (void)Initialize:(B4I*)bi :(NSString *)EventName;
//Resets the consent state. Should only be used for debugging.
- (void)Reset;
//Checks the current state and requests consent if needed.
//Parent - B4XPages.GetNativeParent(Me) in B4XPages
- (void)UpdateAndRequestIfNeeded: (B4IPage*)Parent;
//Checks the current state and requests consent if needed. Allows overriding the geographic location.
//Parent - parent page.
//TestDevices - Array or list with the ids of the test devices. The id is logged when calling UpdateAndRequestIfNeeded.
//InEEA - True = inside EEA, False = outside EEA.
- (void)UpdateAndRequestIfNeededDebug: (B4IPage*)Parent :(B4IList*)TestDevices :(BOOL)InEEA;
//ALlows calling the method with native UMPRequestParameters.
- (void)UpdateAndRequestIfNeededNative:(B4IPage*)Parent :(NSObject*)Parameters;
@end
