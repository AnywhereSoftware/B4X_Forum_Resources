//
//  iAdMob.h
//  iAdMob
//
//  Created by b4j on 9/29/14.
//  Copyright (c) 2014 Anywhere Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iCore.h"

//~version:1.00
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
//~dependson:GoogleAdMobAds
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
@end