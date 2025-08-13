#import <Foundation/Foundation.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "iCore.h"

@class B4IFirebaseUser;


//~dependson:AddressBook.framework
//~dependson:SystemConfiguration.framework
//~dependson: SafariServices.framework
//~dependson: GoogleSignIn.framework.3
//~dependson: GTMSessionFetcher.framework.3
//~dependson: FirebaseAuth.framework.3
//~dependson: GoogleToolboxForMac.framework.3

//~version: 2.00
//~Shortname: FirebaseAuth
//~Event: SignedIn (User As FirebaseUser)
//~Event: TokenAvailable (User As FirebaseUser, Success As Boolean, TokenId As String)
@interface iFirebaseAuth : NSObject<GIDSignInDelegate, GIDSignInUIDelegate>
@property (nonatomic, readonly) B4IFirebaseUser *CurrentUser;
//Initializes the object.
- (void)Initialize:(B4I *)bi :(NSString *)EventName;
//Should be called from Application_OpenURL. Returns True if the url was handled.
- (BOOL)OpenUrl:(NSString *)Url :(NSObject *)Data :(NSString *)SourceApplication;
/**
 * Signs in using Google.
 *Page - The current page.
 */
- (void)SignInWithGoogle:(UIViewController *)Page;
/**
 * Signs out from Firebase and Google.
 */
- (void)SignOutFromGoogle;
/**
 * Retrieves the token id. This token can be sent to your backend server. The server can use it to verify the user.
 *The TokenAvailable event will be raised.
 *User - The signed in user.
 *ForceRefresh - Whether to force Firebase to refresh the token.
 */
- (void)GetUserTokenId:(B4IFirebaseUser *)User :(BOOL)ForceRefresh;
@end
//~Shortname: FirebaseUser
//~ObjectWrapper: FIRUser*
@interface B4IFirebaseUser : B4IObjectWrapper
@property (nonatomic, readonly)NSString *Email;
@property (nonatomic, readonly)NSString *DisplayName;
@property (nonatomic, readonly)NSString *PhotoUrl;
@property (nonatomic, readonly)NSString *Uid;
@end

