#import "iAdMob.h"
#import "GADBannerView.h"

@interface B4IBannerDelegate:NSObject <GADBannerViewDelegate>

@end

@implementation B4IBannerDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)view {
    [B4IObjectWrapper raiseEvent:view :@"_receivead" :nil];
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    [B4IObjectWrapper raiseEvent:view :@"_failedtoreceivead:" :@[error.description]];
}

@end

@implementation B4IAdView
#define AD ((GADBannerView *) self.object)
+(Class)getClass {
    return [GADBannerView class];
}

- (NSObject *)SIZE_BANNER {
    return [NSValue valueWithBytes:&kGADAdSizeBanner objCType:@encode(GADAdSize)];
}

- (NSObject *)SIZE_LARGE_BANNER {
    return [NSValue valueWithBytes:&kGADAdSizeLargeBanner objCType:@encode(GADAdSize)];
}

- (NSObject *)SIZE_FULL_BANNER {
    return [NSValue valueWithBytes:&kGADAdSizeFullBanner objCType:@encode(GADAdSize)];
}

- (NSObject *)SIZE_LEADERBOARD {
    return [NSValue valueWithBytes:&kGADAdSizeLeaderboard objCType:@encode(GADAdSize)];
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
    NSArray *arr = [B4IObjectWrapper getMap:AD][@"testDevices"];
    req.testDevices = arr;
    [AD loadRequest:req];
}
- (void)SetTestDevices:(B4IList *)DeviceIds {
    [B4IObjectWrapper getMap:AD][@"testDevices"] = DeviceIds.object;
}
@end