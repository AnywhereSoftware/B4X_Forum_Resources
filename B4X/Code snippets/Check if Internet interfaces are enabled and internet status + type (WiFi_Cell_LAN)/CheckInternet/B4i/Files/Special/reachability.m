#import "Reachability.h"

@implementation Reachability {
    SCNetworkReachabilityRef _reachabilityRef;
}

+ (instancetype)reachabilityForInternetConnection {
    return [self reachabilityWithHostname:"google.com"];
}

+ (instancetype)reachabilityWithHostname:(const char *)hostname {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, hostname);
    Reachability *returnValue = NULL;
    if (reachability != NULL) {
        returnValue = [[self alloc] init];
        if (returnValue != NULL) {
            returnValue->_reachabilityRef = reachability;
        } else {
            CFRelease(reachability);
        }
    }
    return returnValue;
}

- (NetworkStatus)currentReachabilityStatus {
    NetworkStatus returnValue = NotReachable;
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags)) {
        returnValue = [self networkStatusForFlags:flags];
    }
    return returnValue;
}

- (NetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags {
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
        return NotReachable;
    }

    NetworkStatus returnValue = NotReachable;
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
        returnValue = ReachableViaWiFi;
    }
    
    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0) ||
         (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)) {
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0) {
            returnValue = ReachableViaWiFi;
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
        returnValue = ReachableViaWWAN;
    }
    
    return returnValue;
}

- (void)dealloc {
    if (_reachabilityRef != NULL) {
        CFRelease(_reachabilityRef);
    }
}

@end
