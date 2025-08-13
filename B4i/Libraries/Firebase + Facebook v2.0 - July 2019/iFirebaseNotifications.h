#import <Foundation/Foundation.h>

@class B4I;

//~version: 2.00
//~dependson: FirebaseMessaging.framework.3
//~dependson: Protobuf.framework.3
//~Shortname: FirebaseMessaging
//~Event: FCMConnected
@interface iFirebaseNotifications : NSObject
//Initializes the object.
- (void)Initialize:(B4I *)bi :(NSString *)EventName;
//Subscribes to a topic. Should be called from the FCMConnected event.
- (void)SubscribeToTopic:(NSString *)Topic;
//Unsubscribes from a topic. Should be called from the FCMConnected event.
- (void)UnsubscribeFromTopic:(NSString *)Topic;
//Connectes to the FCM service. Should be called from Application_Active event.
- (void)FCMConnect;
//Disconnects from the FCM service. Should be called from Application_Background event.
- (void)FCMDisconnect;
@end
