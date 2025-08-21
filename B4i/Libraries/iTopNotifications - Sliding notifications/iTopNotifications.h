
#import <Foundation/Foundation.h>
#import "iCore.h"

/**
 * Wrapper for LNRSimpleNotifications.
 *Shows a sliding notification. The user can tap on the notification to dismiss it.
 */
//~dependson: LNRSimpleNotifications.framework.swift.3
//~version: 1.00
//~shortname: TopNotificationsManager
//~ObjectWrapper: NSObject*
//~event: Click
@interface iTopNotifications : B4IObjectWrapper
- (void)Initialize:(B4I *)bi :(NSString *)EventName;
/**
 * Shows a notification.
 *Title - Notification title.
 *Body - Notification body.
 *DurationMs - Notification duration in milliseconds. Pass -1000 to create a notification that is only dismissed with a click.
 */
- (void)ShowNotification:(NSString *)Title :(NSString *)Body :(int)DurationMs;
/**
 * Sets the notifications position. True = Top, False = Bottom.
 */
- (void)SetPosition: (BOOL) Top;
/**
 * Gets or sets the notifications icon.
 */
@property (nonatomic) B4IBitmap *Icon;
/**
 * Gets or sets the body font.
 */
@property (nonatomic) B4IFontWrapper *BodyFont;
/**
 * Gets or sets the title font.
 */
@property (nonatomic) B4IFontWrapper *TitleFont;
/**
 * Gets or sets the background color.
 */
@property (nonatomic) int BackgroundColor;
/**
 * Gets or sets the body text color.
 */
@property (nonatomic) int BodyTextColor;
/**
 * Gets or sets the title text color.
 */
@property (nonatomic) int TitleTextColor;
@end
