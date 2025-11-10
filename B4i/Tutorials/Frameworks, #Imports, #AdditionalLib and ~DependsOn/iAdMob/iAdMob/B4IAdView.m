#import "iAdMob.h"



@interface B4IBannerDelegate:NSObject <GADBannerViewDelegate>

@end

@implementation B4IBannerDelegate
- (void)bannerViewDidReceiveAd:(nonnull GADBannerView *)bannerView {
    [B4IObjectWrapper raiseEvent:bannerView :@"_receivead" :nil];
}

- (void)bannerView:(nonnull GADBannerView *)bannerView
        didFailToReceiveAdWithError:(nonnull NSError *)error {
    [B4IObjectWrapper raiseEvent:bannerView :@"_failedtoreceivead:" :@[error.description]];
}

@end
@interface B4IFullScreenContentDelegate : NSObject<GADFullScreenContentDelegate>
@property (nonatomic) NSObject* target;
@end
@implementation B4IFullScreenContentDelegate {

}
/// Tells the delegate that an impression has been recorded for the ad.
- (void)adDidRecordImpression:(nonnull id<GADFullScreenPresentingAd>)ad {
}

/// Tells the delegate that a click has been recorded for the ad.
- (void)adDidRecordClick:(nonnull id<GADFullScreenPresentingAd>)ad {

}

/// Tells the delegate that the ad failed to present full screen content.
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad
didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {

}

/// Tells the delegate that the ad will present full screen content.
- (void)adWillPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    [B4IObjectWrapper raiseUIEvent:self.target :@"_adopened" :nil];
}

/// Tells the delegate that the ad will dismiss full screen content.
- (void)adWillDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {

}

/// Tells the delegate that the ad dismissed full screen content.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    [B4IObjectWrapper raiseUIEvent:self.target :@"_adclosed" :nil];
}
@end
@implementation B4IAdView
#define AD ((GADBannerView *) self.object)
+(Class)getClass {
    return [GADBannerView class];
}

- (NSObject *)SIZE_BANNER {
    return [NSValue valueWithBytes:&GADAdSizeBanner objCType:@encode(GADAdSize)];
}

- (NSObject *)SIZE_LARGE_BANNER {
    return [NSValue valueWithBytes:&GADAdSizeLargeBanner objCType:@encode(GADAdSize)];
}

- (NSObject *)SIZE_FULL_BANNER {
    return [NSValue valueWithBytes:&GADAdSizeFullBanner objCType:@encode(GADAdSize)];
}

- (NSObject *)SIZE_LEADERBOARD {
    return [NSValue valueWithBytes:&GADAdSizeLeaderboard objCType:@encode(GADAdSize)];
}

- (NSObject *)SIZE_SMART_BANNER_PORTRAIT {
    return [NSValue valueWithBytes:&kGADAdSizeSmartBannerPortrait objCType:@encode(GADAdSize)];
}

- (NSObject *)SIZE_SMART_BANNER_LANDSCAPE {
    return [NSValue valueWithBytes:&kGADAdSizeSmartBannerLandscape objCType:@encode(GADAdSize)];
}

- (void)Initialize:(B4I *)bi :(NSString *)EventName :(NSString *)AdUnit :(B4IPage *)Parent :(NSObject *)AdSize {
    GADAdSize size;
    [(NSValue *)AdSize getValue:&size];
    GADBannerView *v = [[GADBannerView alloc] initWithAdSize:size];
    v.adUnitID = AdUnit;
    v.rootViewController = Parent.object;
    self.object = v;
    [super innerInitialize:bi :EventName :true];
    B4IBannerDelegate *del = [B4IBannerDelegate new];
    v.delegate = del;
    [B4IObjectWrapper getMap:v][@"delegate"] = del;
}
- (void)LoadAd {
    GADRequest *req = [GADRequest request];
    [AD loadRequest:req];
}
- (void)SetTestDevices:(B4IList *)DeviceIds {
    [GADMobileAds sharedInstance].requestConfiguration.testDeviceIdentifiers = DeviceIds.object;
}
- (void)LoadAdWithBuilder:(B4IAdRequestBuilder *)Builder {
    [AD loadRequest:Builder.object];
}
@end

@implementation B4IAdInterstitial {
    NSString *adu;
    GADInterstitialAd *ad;
    BOOL ready;
    B4IFullScreenContentDelegate *delegate;
}

- (void)Initialize:(B4I*)bi :(NSString*)EventName :(NSString *)AdUnit {
    [B4IObjectWrapper setBIAndEventName:self :bi :EventName];
    adu = AdUnit;
    delegate = [B4IFullScreenContentDelegate new];
    delegate.target = self;
}


- (void)SetTestDevices:(B4IList *)DeviceIds {
    [GADMobileAds sharedInstance].requestConfiguration.testDeviceIdentifiers = DeviceIds.object;
}
- (void)RequestAd {
    B4IAdRequestBuilder *req = [B4IAdRequestBuilder new];
    req.Initialize;
    [self LoadAdWithBuilder:req];
}
- (void)LoadAdWithBuilder:(B4IAdRequestBuilder *)Builder {
    ready = false;
    [GADInterstitialAd loadWithAdUnitID:adu
                                request:Builder.object
                      completionHandler:^(GADInterstitialAd *ad, NSError *error) {
                       
                          if (error) {
                              [B4I shared].lastError = error;
                              [B4IObjectWrapper raiseUIEvent:self :@"_ready:" :@[@false]];
                              return;
                          }
                          self->ad = ad;
                          ready = true;
                          ad.fullScreenContentDelegate = delegate;
                          [B4IObjectWrapper raiseUIEvent:self :@"_ready:" :@[@true]];
                      }];
}
- (BOOL)IsReady {
    return ready;
}
- (void)Show:(B4IPage *)Parent {
    [ad presentFromRootViewController:Parent.object];
}
@end


@implementation B4IRewardedVideoAd {
    GADRewardedAd *ad;
    B4IFullScreenContentDelegate* delegate;
    BOOL ready;
}

- (BOOL)Ready {
    return self->ready;
}

- (void)Initialize:(B4I *)bi :(NSString *)EventName {
    [B4IObjectWrapper setBIAndEventName:self :bi :EventName];
    self->delegate = [B4IFullScreenContentDelegate new];
    delegate.target = self;
}

- (void)LoadAd:(NSString *)AdUnitId {
    B4IAdRequestBuilder *req = [B4IAdRequestBuilder new];
    [req Initialize];
    [self LoadAdWithBuilder:AdUnitId :req];
}
- (void)LoadAdWithBuilder:(NSString *)AdUnitId :(B4IAdRequestBuilder *)Builder {
    [GADRewardedAd
            loadWithAdUnitID:AdUnitId
                     request:Builder.object
           completionHandler:^(GADRewardedAd *ad, NSError *error) {
               if (error) {
                   [B4IObjectWrapper raiseUIEvent:self :@"_failedtoreceivead:" :@[error.description]];
                   return;
               }
                self->ad = ad;
                self->ready = true;
                ad.fullScreenContentDelegate = self->delegate;
               [B4IObjectWrapper raiseUIEvent:self :@"_receivead" :nil];
           }];
}

- (void)Show:(B4IPage *)Parent {
    GADRewardedAd* myad = self->ad;
    self->ready = false;
    [myad presentFromRootViewController:Parent.object
              userDidEarnRewardHandler:^{
                  GADAdReward *reward =
                        myad.adReward;
                  [B4IObjectWrapper raiseUIEvent:self :@"_rewarded:" :@[reward]];
              }];
}

@end

@implementation B4IAdRequestBuilder
#define REQ ((GADRequest *) self.object)
+(Class)getClass {
    return [GADRequest class];
}
- (B4IAdRequestBuilder *)Initialize {
    self.object = [GADRequest request];
    return self;
}
- (B4IAdRequestBuilder *)AddTestDevice:(NSString *)DeviceId {

    return self;
}
- (B4IAdRequestBuilder *)NonPersonalizedAds {
    GADExtras *extras = [[GADExtras alloc] init];
    extras.additionalParameters = @{@"npa": @"1"};
    [REQ registerAdNetworkExtras:extras];
    return self;
}

@end
@implementation B4IGoogleMobileAds
- (void) Start {
    [GADMobileAds.sharedInstance startWithCompletionHandler:nil];
}
- (NSString *)Version {
    return GADGetStringFromVersionNumber(GADMobileAds.sharedInstance.versionNumber);
}
@end
@implementation B4IConsentInformation
#define CON ((UMPConsentInformation*)self.object)
+(Class)getClass {
    return [UMPConsentInformation class];
}
- (void)Initialize:(B4I *)bi :(NSString *)EventName {
    self.object = UMPConsentInformation.sharedInstance;
    [B4IObjectWrapper setBIAndEventName:CON :bi :EventName];
}
- (void)Reset {
    CON.reset;
}
- (void)UpdateAndRequestIfNeeded: (B4IPage*)Parent{
    [self UpdateAndRequestIfNeededNative:Parent :[UMPRequestParameters new]];
}
- (void)UpdateAndRequestIfNeededNative:(B4IPage*)Parent :(NSObject*)Parameters {
    [CON requestConsentInfoUpdateWithParameters:(UMPRequestParameters*) Parameters completionHandler:^(NSError *_Nullable requestConsentError) {
        if (requestConsentError != nil) {
            [B4I shared].lastError = requestConsentError;
            [B4IObjectWrapper raiseUIEvent:CON :@"_update:" :@[@false]];
            return;
        }
        [UMPConsentForm loadAndPresentIfRequiredFromViewController:Parent.object
                        completionHandler:^(NSError *loadAndPresentError) {
                          if (loadAndPresentError) {
                              [B4I shared].lastError = requestConsentError;
                              [B4IObjectWrapper raiseUIEvent:CON :@"_update:" :@[@false]];
                            return;
                          }
                    [B4IObjectWrapper raiseUIEvent:CON :@"_update:" :@[@true]];
        }];
        
    }
    ];
}
- (void)UpdateAndRequestIfNeededDebug: (B4IPage*)Parent :(B4IList*)TestDevices :(BOOL)InEEA{
    UMPRequestParameters *parameters = [[UMPRequestParameters alloc] init];
    UMPDebugSettings *debugSettings = [[UMPDebugSettings alloc] init];
    if (TestDevices != nil)
        debugSettings.testDeviceIdentifiers = TestDevices.object;
    debugSettings.geography = InEEA ? UMPDebugGeographyEEA : UMPDebugGeographyOther;
    parameters.debugSettings = debugSettings;
    NSLog(@"Test mode!");
    [self UpdateAndRequestIfNeededNative:Parent :parameters];
    
}

- (BOOL)CanRequestAds {
    return CON.canRequestAds;
}
@end
