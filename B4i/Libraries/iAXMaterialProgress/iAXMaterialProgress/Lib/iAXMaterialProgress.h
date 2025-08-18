//
//  iAXMaterialProgress.h
//  iAXMaterialProgress
//
//  Created by AmirHossein Aghajari on 10/16/20.
//  Copyright © 2020 Amir Hossein Aghajari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "iCore.h"

//~shortname:iAXMaterialProgress
//~ObjectWrapper:iAXMaterialProgress*
//~event:ProgressUpdated (Progress As Float)
//~version:1.01
//~dependsOn:Foundation.framework
@interface iAXMaterialProgressWrapper : B4IViewWrapper

//AmirHosseinAghajari | @KingAmir272 | @LCoders
-(void)Initialize:(B4I*_Nonnull)bi :(NSString *_Nonnull)EventName;

- (void) SetBarColor:(UIColor *_Nonnull)barColor;
- (UIColor*_Nullable) GetBarColor;
- (void) SetBarWidth:(int)barWidth;
- (int) GetBarWidth;
- (void) SetRimColor:(UIColor *_Nonnull)rimColor;
- (UIColor*_Nullable) GetRimColor;
- (void) SetRimWidth:(int)rimWidth;
- (int) GetRimWidth;
- (void) SetSpinSpeed:(float)spinSpeed;
- (float) GetSpinSpeed;
- (void) SetLinearProgress:(BOOL)linearProgres;
- (BOOL) GetLinearProgress;
- (int) GetCircleRadius;
- (void) SetCircleRadius : (int) circleRadius;


// Check if the wheel is currently spinning
- (BOOL) IsSpinning;

// Reset the count (in increment mode)
- (void) Reset;

// Turn off spin mode
- (void) Stop;

// Puts the view on spin mode
- (void) Start;

/**
 * Set the progress to a specific value,
 * the bar will be set instantly to that value
 *
 * the progress should be between 0 and 1
 */
- (void) SetInstantProgress : (float) progress;

/**
 * return the current progress between 0.0 and 1.0,
 * if the wheel is indeterminate, then the result is -1
 */
- (float) GetProgress;

/**
 * Set the progress to a specific value,
 * the bar will smoothly animate until that value
 *
 * the progress should be between 0 and 1
 */
- (void) SetProgress : (float) progress;

- (void) SetProgressSize : (int) w : (int) h;

@end

