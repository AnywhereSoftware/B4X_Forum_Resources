#import <Foundation/Foundation.h>
#import "iCore.h"
@import GoogleMobileAds;

@class B4IAdRequestBuilder;

//~version:1.70
//~dependson:AVFoundation.framework
//~dependson:AudioToolbox.framework
//~dependson:AdSupport.framework
//~dependson:CoreGraphics.framework
//~dependson:CoreTelephony.framework
//~dependson:EventKit.framework
//~dependson:EventKitUI.framework
//~dependson:MessageUI.framework
//~dependson:StoreKit.framework
//~dependson:SystemConfiguration.framework
//~dependson:CoreMedia.framework
//~dependson:GoogleMobileAds.framework.3
//~dependson:MediaPlayer.framework
//~dependson:SafariServices.framework
//~dependson:CoreBluetooth.framework
//~dependson:MobileCoreServices.framework
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
 * Note that AdMob does not server these ads directly. You need to use the mediation feature to add an ad network that supports this type of ads.
 */
//~shortname: RewardedVideoAd
//~objectwrapper: GADRewardBasedVideoAd*
//~event: ReceiveAd
//~event: FailedToReceiveAd (ErrorCode As String)
//~event: AdClosed
//~event: AdOpened
//~event: AdLeftApplication
//~event: Rewarded (Item As Object)
@interface B4IRewardedVideoAd : B4IObjectWrapper
//Returns True if there is an ad ready to be displayed.
@property (nonatomic, readonly) BOOL Ready;
- (void) Initialize:(B4I*)bi :(NSString *)EventName;
//Sends a request for an ad. The ReceiveAd event will be raised when an ad is available.
- (void) LoadAd:(NSString *)AdUnitId;
//Requests an ad configured with AdRequestBuilder. Note that test devices should be set in the builder.
- (void)LoadAdWithBuilder:(NSString *)AdUnitId :(B4IAdRequestBuilder *)Builder;

//Shows the video ad.
- (void) Show:(B4IPage *)Parent;
@end

//~shortname: ConsentManager
//~Event: InfoUpdated (Success As Boolean)
//~Event: FormResult (Success As Boolean, UserPrefersAdFreeOption As Boolean)
@interface B4IConsentManager : NSObject
@property (nonatomic, readonly) int STATE_PERSONALIZED;
@property (nonatomic, readonly) int STATE_NON_PERSONALIZED;
@property (nonatomic, readonly) int STATE_UNKNOWN;
@property (nonatomic) int ConsentState;
@property (nonatomic, readonly) BOOL IsRequestLocationInEeaOrUnknown;
- (void)Initialize:(B4I *)bi :(NSString *)EventName;
/**
 *Requests the current consent state. Raises the InfoUpdated event.
 */
- (void)RequestInfoUpdate:(B4IList *)PublishersIds;
//Logs the device id that can be used to set the debug geographic location.
- (void)LogDeviceIdForDebugging;
//Adds a test device. Call LogDeviceIdForDebugging to get the device id.
- (void)AddTestDevice:(NSString *)DeviceId;
//Set the geographic location of the test devices.
- (void)SetDebugGeography:(BOOL)InEea;
/**
 * Shows the consent form.
 *Page - The container page.
 *PrivacyURL - Link to your privacy policy.
 *PersonalizedOption - Whether to show the personalized ads option.
 *NonPersonalizedOption - Whether to show the non-personalized ads option.
 *AdFreeOption - Whether to show the ads free option.
 */
- (void)ShowConsentForm:(B4I *)bi :(B4IPage *)Page :(NSString *)PrivacyURL :(BOOL)PersonalizedOption :(BOOL)NonPersonalizedOption :(BOOL)AdFreeOption;
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