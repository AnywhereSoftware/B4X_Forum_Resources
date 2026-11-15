B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.31
@EndOfDesignText@

'This minimal demo keeps its CarPlay state in the native scene delegate below.
Sub Process_Globals
End Sub

'Verify that the native CarPlay class is included in the application.
Public Sub Prepare
    Dim NativeClass As NativeObject
    NativeClass.Initialize("ForumCarPlaySceneDelegate")
    Log("CarPlay demo: native class available")
End Sub

#If OBJC
@end

#import <CarPlay/CarPlay.h>

@interface ForumPhoneSceneDelegate : UIResponder <UIWindowSceneDelegate>
@property (nonatomic, strong) UIWindow *window;
@end

@implementation ForumPhoneSceneDelegate

// Attach the window created by B4i to the phone scene.
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)options {
    if (![scene isKindOfClass:[UIWindowScene class]]) return;
    B4IAppDelegate *delegate = (B4IAppDelegate *)UIApplication.sharedApplication.delegate;
    self.window = delegate.window;
    if (!self.window) {
        NSLog(@"CarPlay demo: B4i phone window is not available");
        return;
    }
    self.window.windowScene = (UIWindowScene *)scene;
    [self.window makeKeyAndVisible];
}
@end

@interface ForumCarPlaySceneDelegate : UIResponder <CPTemplateApplicationSceneDelegate>
@property (nonatomic, strong) CPInterfaceController *controller;
@property (nonatomic, strong) CPListTemplate *listTemplate;
@property (nonatomic) NSInteger tapCount;
- (void)showDemo:(CPInterfaceController *)controller;
- (void)releaseDemo;
@end

@implementation ForumCarPlaySceneDelegate

// Create a native CarPlay list with one interactive row.
- (void)showDemo:(CPInterfaceController *)controller {
    self.controller = controller;
    self.tapCount = 0;
    CPListItem *item = [[CPListItem alloc] initWithText:@"Hello from B4i" detailText:@"Tap this row"];
    __weak ForumCarPlaySceneDelegate *weakSelf = self;
    item.handler = ^(id<CPSelectableListItem> selectedItem, dispatch_block_t completion) {
        ForumCarPlaySceneDelegate *strongSelf = weakSelf;
        if (strongSelf && [selectedItem isKindOfClass:[CPListItem class]]) {
            strongSelf.tapCount += 1;
            [(CPListItem *)selectedItem setDetailText:[NSString stringWithFormat:@"Tapped %ld times", (long)strongSelf.tapCount]];
            NSLog(@"CarPlay demo: tap %ld", (long)strongSelf.tapCount);
        }
        completion();
    };
    CPListSection *section = [[CPListSection alloc] initWithItems:@[item]];
    self.listTemplate = [[CPListTemplate alloc] initWithTitle:@"B4i CarPlay Demo" sections:@[section]];
    [controller setRootTemplate:self.listTemplate animated:NO completion:^(BOOL success, NSError *error) {
        if (!success) NSLog(@"CarPlay demo: cannot show template: %@", error);
    }];
}

// Handle the connection for a non-navigation entitlement such as Driving Task.
- (void)templateApplicationScene:(CPTemplateApplicationScene *)scene didConnectInterfaceController:(CPInterfaceController *)controller {
    [self showDemo:controller];
}

// Handle the alternative callback if this test is signed with the Navigation entitlement.
- (void)templateApplicationScene:(CPTemplateApplicationScene *)scene didConnectInterfaceController:(CPInterfaceController *)controller toWindow:(CPWindow *)window {
    [self showDemo:controller];
}

// Release the demo interface when CarPlay disconnects.
- (void)releaseDemo {
    self.listTemplate = nil;
    self.controller = nil;
    NSLog(@"CarPlay demo: disconnected");
}

// Handle disconnection for non-navigation apps.
- (void)templateApplicationScene:(CPTemplateApplicationScene *)scene didDisconnectInterfaceController:(CPInterfaceController *)controller {
    [self releaseDemo];
}

// Handle disconnection for navigation apps.
- (void)templateApplicationScene:(CPTemplateApplicationScene *)scene didDisconnectInterfaceController:(CPInterfaceController *)controller fromWindow:(CPWindow *)window {
    [self releaseDemo];
}
#End If
