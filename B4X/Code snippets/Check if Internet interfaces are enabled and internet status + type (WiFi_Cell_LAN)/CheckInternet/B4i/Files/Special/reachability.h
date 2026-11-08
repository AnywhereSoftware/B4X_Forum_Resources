#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

typedef NS_ENUM(NSInteger, NetworkStatus) {
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableViaWWAN
};

@interface Reachability : NSObject

+ (instancetype)reachabilityForInternetConnection;
- (NetworkStatus)currentReachabilityStatus;

@end
