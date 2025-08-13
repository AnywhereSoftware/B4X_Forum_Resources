//
//  TodayViewController.m
//  TestToday
//
//  Created by Behrens on 22.04.18.
//  Copyright © 2018 Behrens. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "b4i_todaywidget.h"
#import "b4i_widgetcontext.h"
@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController{
	b4i_todaywidget* TW;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	TW = [b4i_todaywidget new];
	[TW _process_globals];
	B4IPanelWrapper* RP = [B4IPanelWrapper new];
	[RP Initialize:TW.bi :@"RootPanel"];
	self.view = RP.object;
	[TW._widgetcontext _process_globals];
	[TW._widgetcontext _setnative:self];
	[TW _widget_start:RP];
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[TW _widget_appear];
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode 
                         withMaximumSize:(CGSize)maxSize{		 
	[TW _widget_displaymodechanged:activeDisplayMode:maxSize.width:maxSize.height];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler([TW _widget_performupdate]);
}

-(int)OpenURL:(NSString*) Url{
	NSURL *u = [NSURL URLWithString:Url];
	__block int s;
    [self.extensionContext openURL:u completionHandler:^(BOOL success) {
        if (!success){
			s = -1;
		}
    }];
	
	return s;
}

-(int)GetLargest{
	return self.extensionContext.widgetLargestAvailableDisplayMode;
}

-(void)SetLargest:(int)M{
	self.extensionContext.widgetLargestAvailableDisplayMode = M;
}

-(float)GetMaxW: (int)Mode{
	return [self.extensionContext widgetMaximumSizeForDisplayMode:Mode].width;
}

-(float)GetMaxH: (int)Mode{
	return [self.extensionContext widgetMaximumSizeForDisplayMode:Mode].height;
}

-(int)GetActive{
	return self.extensionContext.widgetActiveDisplayMode;
}

-(void)SetPrefSize: (float)W :(float)H{
	self.preferredContentSize = CGSizeMake(W,H);
}
@end
