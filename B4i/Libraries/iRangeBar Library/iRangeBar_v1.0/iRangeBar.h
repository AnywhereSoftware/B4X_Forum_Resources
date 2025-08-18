//
//  iRangeBar.h
//  iRangeBar
//
//  Created by Walter Flores on 1/29/20.
//  Copyright © 2020 Walter Flores. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iCore.h"

@class B4I;
//~version:1.00
//~shortname:iRangeBar
//~event:SliderValueChanged (leftValue As Double, rightValue As Double)
//~DesignerProperty: key: minValue, DisplayName: Minimum Value, FieldType: Float, DefaultValue: 0
//~DesignerProperty: key: maxValue, DisplayName: Maximum Value, FieldType: Float, DefaultValue: 1
//~DesignerProperty: key: mimumDistance, DisplayName: Minimum Distance Value, FieldType: Float, DefaultValue: 0.2
//~ObjectWrapper:UIView*

@interface iRangeBar : B4IViewWrapper <B4IDesignerCustomView>
- (void)DesignerCreateView:(B4IPanelWrapper *)base :(B4ILabelWrapper *)lw :(B4IMap *)props;
@property (nonatomic, readonly)B4IViewWrapper *BaseView;
@property (nonatomic)NSString *Text;


 //Sets the Minimum and Maximum Value
- (void)setMinValue:(double)minValue :(double)maxValue;

 //Sets the Left and Right Values
- (void)setLeftValue:(double)leftValue :(double)rightValue;

 //Sets the Minimum Distance between left and right value
- (void)setMinimumDistance:(double)minimumDistance;

 //Sets the background Image for the RangeBar
- (void)assigntrackImage:(UIImage *)trackimage;

 //Sets the Range Image
- (void)assignrangeImage:(UIImage *)rangeimage;

 //Sets the Left Thumb image
- (void)assignleftThumb:(UIImage *)thumbimage;

 //Seets the Right Thumb image
- (void)assignrightThumb:(UIImage *)thumbimage;

@property (nonatomic, assign, readonly) double minimumValue;
@property (nonatomic, assign, readonly) double maximumValue;

@property (nonatomic, assign, readonly) double leftValue;
@property (nonatomic, assign, readonly) double rightValue;

@property (nonatomic, readonly) UIView *leftThumbView;
@property (nonatomic, readonly) UIView *rightThumbView;

//@property (nonatomic, assign) float minimumDistance;

@property (nonatomic) BOOL pushable;
@property (nonatomic) BOOL disableOverlapping;
@property (nonatomic) BOOL sendInstantUpdates;

// Images
@property (nonatomic, readwrite) UIImage *trackImage;
@property (nonatomic) UIImage *rangeImage;

@property (nonatomic) UIImage *leftThumbImage;
@property (nonatomic) UIImage *rightThumbImage;

@end
