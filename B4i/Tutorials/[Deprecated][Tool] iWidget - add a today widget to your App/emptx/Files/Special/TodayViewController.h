//
//  TodayViewController.h
//  TestToday
//
//  Created by Behrens on 22.04.18.
//  Copyright © 2018 Behrens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController
-(int)OpenURL:(NSString*) Url;
-(int)GetLargest;
-(void)SetLargest:(int)M;
-(float)GetMaxW: (int)Mode;
-(float)GetMaxH: (int)Mode;
-(int)GetActive;
-(void)SetPrefSize: (float)W :(float)H;
@end
