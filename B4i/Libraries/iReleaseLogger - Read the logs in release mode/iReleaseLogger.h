

#import <Foundation/Foundation.h>
#import "iCore.h"
//~shortname:ReleaseLogger
//~version:1.00
@interface B4IReleaseLogger : NSObject<B4ILogger>

- (void)Initialize:(B4I *)bi :(NSString *)DesktopAddress :(int)Port;
@end
