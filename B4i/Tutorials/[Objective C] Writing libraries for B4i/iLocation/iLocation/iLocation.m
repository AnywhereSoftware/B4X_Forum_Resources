//
//  iLocation.m
//  iLocation
//
//  Created by b4j on 9/16/14.
//  Copyright (c) 2014 Anywhere Software. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "iLocation.h"
#import "iCore.h"

@implementation B4ILocationManager {
    CLLocationManager *manager;
}

-(void)Initialize:(B4I*)bi :(NSString *)EventName {
    [B4IObjectWrapper setBIAndEventName:self :bi :EventName];
    manager = [CLLocationManager new];
    manager.delegate = self;
}
- (BOOL)LocationServicesEnabled {
    return [CLLocationManager locationServicesEnabled];
}

- (BOOL)IsAuthorized {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    return (status == kCLAuthorizationStatusAuthorized ||
            status == kCLAuthorizationStatusAuthorizedAlways ||
            status == kCLAuthorizationStatusAuthorizedWhenInUse);
}


- (int)AUTHORIZATION_NOT_DETERMINED {
    return kCLAuthorizationStatusNotDetermined;
}

- (int)AUTHORIZATION_RESTRICTED {
    return kCLAuthorizationStatusRestricted;
}

- (int)AUTHORIZATION_DENIED {
    return kCLAuthorizationStatusDenied;
}

- (int)AuthorizationStatus {
    return [CLLocationManager authorizationStatus];
}

- (void)Start:(double)MinimumDistance {
    if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        [manager requestWhenInUseAuthorization];
    manager.distanceFilter = MinimumDistance;
    [manager startUpdatingLocation];
}
- (void)StartHeading {
    [manager startUpdatingHeading];
}
- (void)Stop {
    [manager stopUpdatingLocation];
}
- (void)StopHeading {
    [manager stopUpdatingHeading];
}


- (void)locationManager:(CLLocationManager *)manager1 didUpdateLocations:(NSArray *)locations {
    if (locations != nil && locations.count > 0) {
        B4ILocationWrapper* lw = [B4ILocationWrapper new];
        lw.object = locations.lastObject;
        [B4IObjectWrapper raiseEvent:self :@"_locationchanged:" :@[lw]];
    }
}

- (void)locationManager:(CLLocationManager *)manager1 didUpdateHeading:(CLHeading *)newHeading {
    [B4IObjectWrapper raiseEvent:self :@"_headingchanged::" :@[@(newHeading.magneticHeading),
            @(newHeading.trueHeading)]];
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager1 {
    NSObject *res = [B4IObjectWrapper raiseEvent:self :@"_allowcalibration" :nil];
    if (res == nil)
        return false;
    return [(NSNumber *)res boolValue];
}

- (void)locationManager:(CLLocationManager *)manager1 didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [B4IObjectWrapper raiseEvent:self :@"_authorizationstatuschanged:" :@[@((int)status)]];
}

- (void)locationManager:(CLLocationManager *)manager1 didFailWithError:(NSError *)error {
    [B4I shared].lastError = error;
    [B4IObjectWrapper raiseEvent:self :@"_locationerror" :nil];

}


@end
@implementation B4ILocationWrapper
#define OBJ ((CLLocation *) self.object)
+(Class)getClass {
    return [CLLocation class];
}
- (void)Initialize2:(double)Latitude :(double)Longitude {
    self.object = [[CLLocation alloc] initWithLatitude:Latitude longitude:Longitude];
}

- (double)Altitude {
    return OBJ.altitude;
}

- (double)Accuracy {
    return OBJ.horizontalAccuracy;
}

- (double)VerticalAccuracy {
    return OBJ.verticalAccuracy;
}

- (double)Latitude {
    return OBJ.coordinate.latitude;
}

- (double)Longitude {
    return OBJ.coordinate.longitude;
}

- (double)Speed {
    return OBJ.speed;
}

- (double)Bearing {
    return OBJ.course;
}

- (long long int)Time {
    return [[[B4ICommon shared] DateTime] NSDateToTicks:OBJ.timestamp];
}
- (double)DistanceTo:(B4ILocationWrapper *)TargetLocation {
    return [OBJ distanceFromLocation:TargetLocation.object];
}

@end
