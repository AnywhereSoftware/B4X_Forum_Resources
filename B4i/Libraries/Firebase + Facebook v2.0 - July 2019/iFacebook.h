
#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "iCore.h"
//~dependson: FBSDKCoreKit.framework.3
//~dependson: FBSDKLoginKit.framework.3
//~version: 2.00
//~shortname: FacebookSdk
@interface iFacebook : NSObject

/**
 * Initializes the object.
 *AppId - Facebook App ID.
 */
- (void)Initialize:(NSString *)AppID;
/**
 * Should be called from Application_OpenUrl. Returns True if the url was handled.
 */
- (BOOL)OpenUrl:(NSString *)Url :(NSObject *)Data :(NSString *)SourceApplication;
/**
 * Signs in using Facebook.
 */
- (void)SignIn;
/**
 * Signs out from Firebase and Facebook.
 */
- (void)SignOut;
@end
