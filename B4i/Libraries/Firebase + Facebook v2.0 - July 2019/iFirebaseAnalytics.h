
#import <Foundation/Foundation.h>
#import "iCore.h"
//~version: 2.00
//~Shortname: FirebaseAnalytics
//~dependson: FIRAnalyticsConnector.framework.3
//~dependson: FirebaseAnalytics.framework.3
//~dependson: FirebaseCore.framework.3
//~dependson: FirebaseCoreDiagnostics.framework.3
//~dependson: FirebaseInstanceID.framework.3
//~dependson: GoogleAppMeasurement.framework.3
//~dependson: GoogleUtilities.framework.3
//~dependson: nanopb.framework.3
@interface iFirebaseAnalytics : NSObject
//Initializes the object. You should initialize it before using any other Firebase service.
- (void)Initialize;
/**
 * Sends an event to the analytics service.
 *EventName - Event name.
 *Parameters - Map of parameters. Pass Null if not needed.
 */
- (void)SendEvent:(NSString *)EventName :(B4IMap *)Parameters;
@end
