
#import <Foundation/Foundation.h>
#import "iCore.h"
#import <CoreLocation/CoreLocation.h>

@class B4I;
//~shortname:LocationManager
//~event:LocationChanged (Location1 As Location)
//~event:AuthorizationStatusChanged (Status As int)
//~event:LocationError
//~event:HeadingChanged (MagneticHeading As Double, TrueHeading As Double)
//~event:AllowCalibration As Boolean
//~version:1.00
//~dependsOn:CoreLocation.framework
@interface B4ILocationManager : NSObject<CLLocationManagerDelegate>
//Authorization status was not yet set.
@property (nonatomic, readonly)int AUTHORIZATION_NOT_DETERMINED;
//Application is not authorized and user is restricted from changing its state (parental control for example).
@property (nonatomic, readonly)int AUTHORIZATION_RESTRICTED;
//Location services are disabled or the user denied access for this application.
@property (nonatomic, readonly)int AUTHORIZATION_DENIED;
//Returns true if location services are enabled.
@property (nonatomic, readonly)BOOL LocationServicesEnabled;
//Returns true if your app is authorized to access the location services.
@property (nonatomic, readonly)BOOL IsAuthorized;
/**
* Gets the current authorization status. The value will be one of the four AUTHORIZATION constants.
*/
@property (nonatomic, readonly)int AuthorizationStatus;
//Initializes the object. The AuthorizationStatusChanged will be raised with the current status.
- (void)Initialize:(B4I *)bi :(NSString *)EventName;

/**
* Starts listening for the LocationChanged event.
* If the authorization status is not yet determined then the user will be asked to approve it.
* If location services are disabled then the user will be asked to enable location services.
* The LocationChanged event will be raised with the last known location after this call and then when the location changes.
* MinimumDistance - The minimum distance measured in meters, that will cause the LocationChanged event to fire. Pass 0 to receive all updates.
*/
- (void)Start:(double)MinimumDistance;

/**
* Starts listening for the HeadingChanged event.
*/
- (void)StartHeading;

/**
* Stops listening for the LocationChanged event.
*/
- (void)Stop;

/**
* Stops listening for the HeadingChanged event.
*/
- (void)StopHeading;
@end
//~shortName:Location
//~ObjectWrapper:CLLocation*
@interface B4ILocationWrapper : B4IObjectWrapper
//Altitude measured in meters. Only valid if VerticalAccuracy is non-negative.
@property (nonatomic, readonly) double Altitude;
//Horizontal accuracy measured in meters. Negative value means that Latitude and Longitude are invalid.
@property (nonatomic, readonly) double Accuracy;
//Vertical accuracy measured in meters. Negative value means that the altitude is invalid.
@property (nonatomic, readonly) double VerticalAccuracy;
//Latitude coordinate. Valid if Accuracy property is non-negative.
@property (nonatomic, readonly) double Latitude;
//Longitude coordinate. Valid if Accuracy property is non-negative.
@property (nonatomic, readonly) double Longitude;
//Speed measured in meters per second. Only valid if value is non-negative.
@property (nonatomic, readonly) double Speed;
//Bearing angle (degrees). Only valid if value is non-negative.
@property (nonatomic, readonly) double Bearing;
//Location time stamp.
@property (nonatomic, readonly)long long Time;

//Creates a new Location object that can be used for distance calculations.
- (void)Initialize2:(double)Latitude :(double)Longitude;
//Calculates the distance in meters between the two locations.
- (double)DistanceTo:(B4ILocationWrapper *)TargetLocation;
@end
