#import <UIKit/UIKit.h>

#import "iCore.h"

@interface B4IMyDelegate : B4IAppDelegate
	
@end

@implementation B4IMyDelegate {
void (^completeFetch)(UIBackgroundFetchResult);
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
	NSLog(@"performFetchWithCompletionHandler");
	self->completeFetch = completionHandler;
	B4I* bi = [self valueForKey:@"bi"];
	[bi raiseUIEvent:nil event:@"application_fetchdownload" params:nil];
}

- (void)completeFetch:(int)result {
    self->completeFetch((UIBackgroundFetchResult) result);
}
@end


int main(int argc, char * argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([B4IMyDelegate class]));
    }

}

