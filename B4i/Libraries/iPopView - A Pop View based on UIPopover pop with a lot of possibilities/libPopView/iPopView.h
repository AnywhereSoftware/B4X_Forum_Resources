#import <Foundation/Foundation.h>
#import "iCore.h"

@class B4I;
//~shortname:iPopView
//~event:onInitialized(EventName As String)
//~event:NewPopview(Title as String)
//~event:onDismiss(Title as String)
//~version:1.00
//~author:Alberto Iglesias (alberto@visualnet.inf.br)

@interface iPopView : NSObject

//Enable/Disable Debug mode from Library
@property (nonatomic, readwrite)BOOL DebugMode;

//Author of this Library
@property (nonatomic, readonly)NSString *Author;

//Library Version
@property (nonatomic, readonly)NSString *Version;

//Initializes the object.
-(void)Initialize:(B4I*)bi :(NSString *)EventName;

//Show the Menu with point in a View
//-(void)ShowPopView:(B4I*)bi :(B4IViewController *)Page :(NSString *)Title :(Boolean)WithBorder :(double)Width :(double)Height :(double)Transparency :(NSString *)PopColor :(B4IPanelView *)view;

//Show the Menu with point in a coordinates x,y
-(void)ShowPop:(B4I*)bi :(B4IViewController *)Page :(NSString *)Title :(Boolean)WithBorder :(double)Width :(double)Height :(double)Transparency :(NSString *)PopColor :(int)X :(int)Y :(NSString *)Direction;

//Dismiss the menu
-(void)Dismiss;

//License Email
@property (nonatomic, readwrite)NSString *LicenseEmail;

//License Key
@property (nonatomic, readwrite)NSString *LicenseKey;

//Show License
-(void)LicenseShow;

@end
