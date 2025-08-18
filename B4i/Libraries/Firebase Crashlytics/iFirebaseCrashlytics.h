#import <Foundation/Foundation.h>
#import "iCore.h"
@import FirebaseCrashlytics;

//~dependson:FirebaseCrashlytics.framework.3
//~shortname:Crashlytics
//~version:2.0
//~author: Biswajit
//~event: HasUnsentReports

@interface iFirebaseCrashlytics : NSObject
/**
 *<b>Turn off automatic collection by adding a new key to your </b>
 *<code>#PlistExtra: <key>FirebaseCrashlyticsCollectionEnabled</key><false/></code>
 *Initializes the library inside the Application_Start function.
 *<b>You should initialize FirebaseAnalytics before initializing this library.</b>
 */
- (void)Initialize:(B4I *)bi :(NSString*)EventName;
/**
 *Cause a Test Crash
*/
- (void) TestCrash;
/**
 * Set user identifiers
*/
- (void) SetUserID:(NSString*) ID;
/**
 * Enable collection for select users by calling the Crashlytics data collection override at runtime. The override value persists across launches of your app so Crashlytics can automatically collect reports. To opt out of automatic crash reporting, pass false as the override value. When set to false, the new value does not apply until the next run of the app
 */
- (void) setCrashlyticsCollectionEnabled:(BOOL) enable;
/**
 * Check if automatically report collection is enabled or not
 */
- (BOOL) isCrashlyticsCollectionEnabled;
/**
 * Add custom log messages
 * NOTE: To avoid slowing down your app, Crashlytics limits logs to 64kB and deletes older log entries when a session's logs go over that limit.
 */
-(void) Log:(NSString*) msg;
/**
 * Detect when a crash happens during your app's last run.
 */
- (BOOL) didCrashDuringPreviousExecution;
/**
 * Check for unsent reports
 * You must set setCrashlyticsCollectionEnabled to false in order to use hasUnsentReports
 * If there is any unsent report the EventName_HasUnsentReports event will be raised
 */
- (void) checkForUnsentReports;
/**
 * Send unsent reports
 */
- (void) sendUnsentReports;
/**
 * Delect  unsent reports
 */
- (void) deleteUnsentReports;
@end
