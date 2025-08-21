//
//  iAmir_ChartView.h
//  iAmir_ChartView
//
//  Created by AmirHossein Aghajari on 5/16/20.
//  Copyright © 2020 Amir Hossein Aghajari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iCore.h"
#import <UIKit/UIKit.h>

//~version:1.00
//~dependson:AVFoundation.framework
//~shortname:Amir_ChartView
//~objectwrapper:HCLineChartView*
@interface iAmir_ChartView : B4IViewWrapper
- (void)Initialize:(B4I *)bi;
- (void)Initialize2:(B4I *)bi : (CGRect) rect ;


/// Draws/redraws chart with current data and settings. Calling this method will call onDraw method
-(void)DrawChart;

/// Updates chart with new data
/// @param xElements Values for X axis.
/// @param yElements Values for Y axis.
-(void)UpdateChartWithXElements:(NSArray*)xElements yElements:(NSArray*)yElements;



// This property defines if chart background is transparent or not.
-(void) setChartTransparentBackground : (BOOL) value;

// This property defines if chart background has the gradient.
-(void) setChartGradient : (BOOL) value;

// This property defines the top color for background gradient. It is also the background color for the chart if chartGradient is set to NO.
-(void) setBackgroundGradientTopColor: (UIColor*) value ;

// This property defines the bottom color for background gradient.
-(void) setBackgroundGradientBottomColor: (UIColor*) value;

// This property defines if chart view should have rounded corners.
-(void) setChartWithRoundedCorners : (BOOL) value;

#pragma mark Title and Subtitle Settings

// This property defines chart title.
-(void) setChartTitle : (NSString*) value;

// This property defines chart title color.
-(void) setChartTitleColor : (UIColor*) value;

// This property defines font size for chart title.
-(void) setFontSizeForTitle : (double) value;

// This property defines if the chart has a subtitle.
-(void) setShowSubtitle : (BOOL) value;

// This property defines chart subtitle.
-(void) setChartSubTitle : (NSString*) value;

// This property defines font size for chart subtitle.
-(void) setFontSizeForSubTitle : (double) value;

// This property defines chart subtitle color.
-(void) setChartSubtitleColor : (UIColor*) value;

#pragma mark Chart Axis Settings

// This property defines chart axes color.
-(void) setChartAxisColor : (UIColor*) value;

// This property defines font size for chart axes.
-(void) setFontSizeForAxis : (double) value;

// This property defines if values on the X axis should be in currency format. It is useful in cases where we need to show exchange rate on chart
-(void) setShowXValueAsCurrency : (BOOL) value;

// TThis property defines currency code for the X axis. It is relevant if showXValueAsCurrency parameter is set to YES. If you don't define currency code or currency code is not valid, the chart will display your local currency code.
-(void) setXAxisCurrencyCode : (NSString*) value;

// This property defines if values on the Y axis should be in currency format. It is useful when we need to show exchange rate on the chart (if showXValueAsCurrency is also set to YES), or in any other case where we need to show Y values in currency format (price, saving, debt, surplus, deficit,...)
-(void) setShowYValueAsCurrency : (BOOL) value;

// This property defines currency code for the Y axis. It is relevant if showYValueAsCurrency parameter is set to YES. If you don't define currency code or currency code is not valid, the chart will display your local currency code.
-(void) setYAxisCurrencyCode : (NSString*) value;

// This property defines if values on X axis should be presented horizontally (vertically is default).
-(void) setHorizontalValuesOnXAxis : (BOOL) value;

// This property defines if values on this axis should have horizontal orientation (default orientation is vertical)
-(void) setDrawHorizontalLinesForYTicks : (BOOL) value;

#pragma mark Chart Line Settings

// This property defines chart line width.
-(void) setChartLineWidth : (float) value;

// This property defines chart line color.
-(void) setChartLineColor : (UIColor*) value;

// This property defines if chart points should have circles
-(void) setChartLineWithCircles : (BOOL) value;

// This property defines if the area under chart line should have gradient
-(void) setChartGradientUnderline : (BOOL) value;

// This property defines if bottom gradient color for the area under chart line is transparent.
-(void) setUnderLineChartGradientTopColor : (UIColor*) value;

// This property defines if bottom gradient color for the area under chart line is transparent.
-(void) setUnderLineChartGradientBottomColorIsTransparent : (BOOL) value;

// This property defines bottom gradient color for the area under chart line. This parameter is valid only if chart itself isn't transparent
-(void) setUnderLineChartGradientBottomColor : (UIColor*) value;

// This property defines if the distribution of values on X axis should be value based.
-(void) setIsValueChartWithRealXAxisDistribution : (BOOL) value;

#pragma mark Chart Data and Methods

// It is recommended to provide already sorted data before drawing the chart. If you don't have values for X axis sorted ascending, you can set this parameter to YES. In that case, provided values for X axis (xElements) will be sorted ascending, with the parallel sorting of paired values for Y axis (yElements). Sorting data could have a small impact on chart drawing performance.
-(void) setSortData : (BOOL) value;

// Array for storing values for the X axis. Only NSNumber and NSDate values are allowed.
-(void) setXElements : (NSMutableArray*) value;

// Array for storing values for the Y axis. Only NSNumber values are allowed.
-(void) setYElements : (NSMutableArray*) value;


@end

#ifndef Header_h
#define Header_h

/// This property defines chart type based on values on X asix. It is defined automatic.
typedef enum HCChartType
{
    chartWithNoDefinedValues,
    chartWithNumericalValues,
    chartWithDateValues,
    chartWithInvalidValues
} HCChartType;

/// This property defines if axis is horizontal (X axis) or vertical (Y axis)
typedef enum HCAxis
{
    xAxis,
    yAxis
} HCAxis;

/// This property defines chart style, i.e. if points in charts should be represented with simple dots (withoud circles) or with cirles
typedef enum HCChartStyle
{
    chartLineWithCircles,
    chartWithoutCircles
} HCChartStyle;


/// This property defines calendar type for the chart. It is used inside HCLineChartView library for displaying appropriate date / time values on X axis if values on X axis are represented as NSDate instances.
typedef enum HCCalendarType
{
    calendarWithYears,
    calendarWithMonths,
    calendarWithWeeks,
    calendarWithDays,
    calendarWithHours,
    calendarWithMinutes,
    calendarWithSeconds
} HCCalendarType;



#endif /* Header_h */

@class HCChartDrawer;

IB_DESIGNABLE
/// Custom UIView inside which we're drawing the chart.
@interface HCLineChartView : UIView
{
    ///This class is used for drawing all elements in HCLineChartView.
    HCChartDrawer* hcChartDrawer;
}

#pragma mark Chart Background Settings

/// This property defines if chart background is transparent or not.
@property IBInspectable BOOL chartTransparentBackground;

/// This property defines if chart background has the gradient.
@property IBInspectable BOOL chartGradient;

/// This property defines the top color for background gradient. It is also the background color for the chart if chartGradient is set to NO.
@property (retain, nonatomic) IBInspectable UIColor* backgroundGradientTopColor;

/// This property defines the bottom color for background gradient.
@property (retain, nonatomic) IBInspectable UIColor* backgroundGradientBottomColor;

/// This property defines if chart view should have rounded corners.
@property IBInspectable BOOL chartWithRoundedCorners;

#pragma mark Title and Subtitle Settings

/// This property defines chart title.
@property (retain, nonatomic) IBInspectable NSString* chartTitle;

/// This property defines chart title color.
@property (retain, nonatomic) IBInspectable UIColor* chartTitleColor;

/// This property defines font size for chart title.
@property IBInspectable double fontSizeForTitle;

/// This property defines if the chart has a subtitle.
@property IBInspectable BOOL showSubtitle;

/// This property defines chart subtitle.
@property (retain, nonatomic) IBInspectable NSString* chartSubTitle;

/// This property defines font size for chart subtitle.
@property IBInspectable double fontSizeForSubTitle;

/// This property defines chart subtitle color.
@property (retain, nonatomic) IBInspectable UIColor* chartSubtitleColor;

#pragma mark Chart Axis Settings

/// This property defines chart axes color.
@property (retain, nonatomic) IBInspectable UIColor* chartAxisColor;

/// This property defines font size for chart axes.
@property IBInspectable double fontSizeForAxis;

/// This property defines if values on the X axis should be in currency format. It is useful in cases where we need to show exchange rate on chart
@property IBInspectable BOOL showXValueAsCurrency;

/// TThis property defines currency code for the X axis. It is relevant if showXValueAsCurrency parameter is set to YES. If you don't define currency code or currency code is not valid, the chart will display your local currency code.
@property (retain, nonatomic) IBInspectable NSString* xAxisCurrencyCode;

/// This property defines if values on the Y axis should be in currency format. It is useful when we need to show exchange rate on the chart (if showXValueAsCurrency is also set to YES), or in any other case where we need to show Y values in currency format (price, saving, debt, surplus, deficit,...)
@property IBInspectable BOOL showYValueAsCurrency;

/// This property defines currency code for the Y axis. It is relevant if showYValueAsCurrency parameter is set to YES. If you don't define currency code or currency code is not valid, the chart will display your local currency code.
@property (retain, nonatomic) IBInspectable NSString* yAxisCurrencyCode;

/// This property defines if values on X axis should be presented horizontally (vertically is default).
@property IBInspectable BOOL horizontalValuesOnXAxis;

/// This property defines if values on this axis should have horizontal orientation (default orientation is vertical)
@property IBInspectable BOOL drawHorizontalLinesForYTicks;

#pragma mark Chart Line Settings

/// This property defines chart line width.
@property IBInspectable float chartLineWidth;

/// This property defines chart line color.
@property (retain, nonatomic) IBInspectable UIColor* chartLineColor;

/// This property defines if chart points should have circles
@property IBInspectable BOOL chartLineWithCircles;

/// This property defines if the area under chart line should have gradient
@property IBInspectable BOOL chartGradientUnderline;

/// This property defines if bottom gradient color for the area under chart line is transparent.
@property (retain, nonatomic) IBInspectable UIColor* underLineChartGradientTopColor;

/// This property defines if bottom gradient color for the area under chart line is transparent.
@property IBInspectable BOOL underLineChartGradientBottomColorIsTransparent;

/// This property defines bottom gradient color for the area under chart line. This parameter is valid only if chart itself isn't transparent
@property (retain, nonatomic) IBInspectable UIColor* underLineChartGradientBottomColor;

/// This property defines if the distribution of values on X axis should be value based.
@property IBInspectable BOOL isValueChartWithRealXAxisDistribution;

#pragma mark Chart Data and Methods

/// It is recommended to provide already sorted data before drawing the chart. If you don't have values for X axis sorted ascending, you can set this parameter to YES. In that case, provided values for X axis (xElements) will be sorted ascending, with the parallel sorting of paired values for Y axis (yElements). Sorting data could have a small impact on chart drawing performance.
@property IBInspectable BOOL sortData;

/// Array for storing values for the X axis. Only NSNumber and NSDate values are allowed.
@property (retain, nonatomic) NSMutableArray* xElements;

/// Array for storing values for the Y axis. Only NSNumber values are allowed.
@property (retain, nonatomic) NSMutableArray* yElements;

#pragma mark Drawing and Updating Methods

/// Draws/redraws chart with current data and settings. Calling this method will call onDraw method
-(void)drawChart;

/// Updates chart with new data
/// @param xElements Values for X axis.
/// @param yElements Values for Y axis.
-(void)updateChartWithXElements:(NSArray*)xElements yElements:(NSArray*)yElements;

@end


/// Helper class for storing single chart point / dot
@interface HCChartPoint : NSObject

/// This property defines X coordinate for chart point
@property double x;

/// This property defines Y coordinate for chart point
@property double y;

/// Contructor
/// @param x X coordinate for chart point
/// @param y Y coordinate for chart point
/// @return Class insntance
-(id)initWithX:(double)x andY:(double)y;

@end

@class HCTimeStep;

@interface HCChartDrawer : NSObject
{
    
#pragma mark Chart Coordinates
    /// This property defines minimal X coordinate on chart. It is calculated runtime.
    double minXCoordinateOnChart;
    
    /// This property defines maximal X coordinate on chart. It is calculated runtime.
    double maxXCoordinateOnChart;
    
    /// This property defines minimal Y coordinate on chart. It is calculated runtime.
    double minYCoordinateOnChart;
    
    /// This property defines maximal Y coordinate on chart. It is calculated runtime.
    double maxYCoordinateOnChart;
    
#pragma mark Represented Values on Chart
    
    /// This property defines minimal value for X axis on chart. It is calculated runtime.
    double minXValueOnChart;
    
    /// This property defines maximal value for X axis on chart. It is calculated runtime.
    double maxXValueOnChart;
    
    /// This property defines minimal value for Y axis on chart. It is calculated runtime.
    double minYValueOnChart;
    
    /// This property defines maximal value for Y axis on chart. It is calculated runtime.
    double maxYValueOnChart;
    
    /// Helper attribute, i.e. current value for X axis during drawing values on X axis
    double currentValueX;
    
    /// Helper attribute, i.e. current value for Y axis during drawing values on Y axis
    double currentValueY;
    
    /// Decimal format for values on X axis (if values on X axis are numeric).
    NSString* decimalFormatX;
    
    /// Helper attribute, i.e. current position (X coordinate) for X axis during drawing values on X axis
    double currentPositionX;
    
    /// Helper attribute, which defines number of values on X axis which are bypassed when there are more values on X axis then there is possible to draw value for every of them on chart.
    double jumpOverX;
    
#pragma mark Chart Data Maximal and Minimal Values
    
    /// This property defines minimal value for values in X array. It is calculated runtime.
    double minXValue;
    
    /// This property defines maximal value for values in X array. It is calculated runtime.
    double maxXValue;
    
    /// This property defines minimal value for values in Y array. It is calculated runtime.
    double minYValue;
    
    /// This property defines maximal value for values in Y array. It is calculated runtime.
    double maxYValue;
    
#pragma mark Chart Dots
    
    /// Array with help dots, i.e. start dots for lines between circles if chart dots are represented with circles.
    NSMutableArray* startDots;
    
    /// Array with help dots, i.e. end dots for lines between circles if chart dots are represented with circles.
    NSMutableArray* endDots;
    
    /// Array with help dots, i.e. start dots for lines between circles if chart dots are not represented with circles.
    NSMutableArray* middleDots;
    
    /// Array with chart dots.
    NSMutableArray* chartDots;
    
    /// This property defines offset for drawing chart header or chart axis
    double offsetForAxisOrHeader;
    
    /// Reference to HCLineChartView instance where HCChartDrawer needs to draw the chart.
    HCLineChartView* hcLineChartView;
    
    /// HCLineChartView rect size, necessary for accurate drawing chart componente
    CGRect chartRect;
    
    /// This property defines X axis tick size if values on X axis are represented as numerical values. It is calculated runtime.
    double xAxisTick;
    
    /// This property defines X axis tick size if values on X axis are represented as date / time values. It is calculated runtime.
    HCTimeStep* xAxisDateTick;
    
    /// This property defines Y axis tick size. It is calculated runtime.
    double yAxisTick;
    
    /// This property defines space between ticks on X axis. It is calculated runtime.
    double xStep;
    
    /// This property defines space between ticks on Y axis. It is calculated runtime.
    double yStep;
    
    /// This property defines number of decimals places for values on X axis. It is calculated runtime.
    int numberOfXDecimals;
    
    /// This property defines number of decimals places for values on Y axis. It is calculated runtime.
    int numberOfYDecimals;
    
    /// This property defines Y coordinate of the top of the vertical (Y) axis. It is calculated runtime.
    double startVertical;
    
    /// This property defines Y coordinate of the bottom of the vertical (Y) axis. It is calculated runtime.
    double endVertical;
    
    /// This property defines value for the most top value on Y axis. It is calculated runtime.
    double startVerticalValue;
    
    /// This property defines value for the most bottom value on Y axis. It is calculated runtime.
    double endVerticalValue;
    
    /// This property defines value for the first value on X axis. It is calculated runtime.
    double startHorizontalValue;
    
    /// This property defines array for storing HCTimeStep instances, i.e. potential options for displaying values on X axis if values for X axis are represented as date / time values.
    NSArray<HCTimeStep*>* timeSteps;
    
    /// This property indicates that all values on horizontal (X) axis are equal.
    BOOL horizontalValuesAreAllEqual;
    
    /// This property indicates that all values on vertical (Y) axis are equal.
    BOOL verticalValuesAreAllEqual;
    
#pragma mark Chart Dimensions
    /// This property defines relative distance between chart and its borders
    double leftOrBottomOffsetProportional;
    
    /// This property defines chart point diameter if chart points are represented with circles
    double chartPointDiameter;
    
    
    /// This property defines corner radius for rounded rect if user selects to use chart with rounded corners.
    float chartCornerRadius;
    
    /// This property defines axis width
    double axisWidth;
    
    /// This property defines relative distance from axes to points
    double axisDistanceFromPointsProportionaly;
    
    /// This property defines proportional width of chart area (part of chart where the dots are presented) relative to chart view width. It is calculated runtime.
    double pointsRectProportionalWidth;
    
    /// This property defines proportional height of chart area (part of chart where the dots are presented) relative to chart view height. It is calculated runtime.
    double pointsRectProportionalHeight;
    
    /// This property defines relative distance between chart dots and top edge of the chart view. It is calculated runtime.
    double pointsRectTopProportionalDistance;
    
    /// efines relative distance between chart dots and left edge of the chart view. It is calculated runtime.
    double pointsRectLeftProportionalDistance;
    
    /// This property defines maximal text size for values on X axis. It is calculated runtime
    CGSize xAxisLabelTextSize;
    
    /// This property defines maximal text size for values on Y axis. It is calculated runtime
    CGSize yAxisLabelTextSize;
    
    /// Standard offset parameter for drawing chart axis
    double standardOffset;
    
#pragma mark Chart Settings
    
    /// This property defines chart calendar type, it is calculated runtime
    HCCalendarType calendarType;
    
    /// This property defines chart type. It is calculated runtime.
    HCChartType chartType;
    
    /// This property defines if dots in chart are represented as simple dots or with circles. This property is indirectly defined by user, by chartLineWithCircles parameter in HCLineChartView.
    HCChartStyle chartStyle;
    
#pragma mark Chart Data
    /// Used for storing number of values to be presented in chart.
    int numberOfElements;
}

/// Method for drawing chart inside linearChartView. This method, in fact, uses another methods for pre-drawing calulations and for drawing separate parts of chart, like chart background, title, subtitle, dots, axes,...
/// @param linearChartView Reference to the HCLineChartView instance. HCChartDrawer needs to draw chart inside this instance
/// @param rect Rect for HCLineChartView
-(void)drawChart:(HCLineChartView*)linearChartView inRect:(CGRect)rect;

@end

@interface HCChartDrawer (TitleAndSubtitle)

/// This method draws title and subtitle for the chart
-(void)drawTitleAndSubtitle;

@end

@interface HCChartDrawer (ChartLine)

/// Draws chart line
-(void)drawChartLine;

@end



@interface HCChartDrawer (General)

/// This method draws line from startPoint to endPoint with specified lineColor and lineWidth
/// @param startPoint Start point for drawing the line.
/// @param endPoint End point for drawing the line.
/// @param lineColor Line color.
/// @param lineWidth Line width.
-(void)drawLineFromPoint:(CGPoint)startPoint toPoint: (CGPoint) endPoint withColor:(UIColor*)lineColor andWidth:(double)lineWidth;


/// This method creates dashed line accross the chart (for example, when Y value is 0)
/// @param startPoint Start point for drawing the line.
/// @param endPoint End point for drawing the line.
-(void)drawDashedLineFromPoint:(CGPoint)startPoint toEndPoint:(CGPoint)endPoint;


/// This method draws rect with given background color
/// @param rect This property defines rect, i.e. position and size for desired rect.
/// @param backgroundColor This property defines background color for desired rect.
-(void)drawRect:(CGRect)rect withBackgroundColor:(UIColor*)backgroundColor;

/// Helper method for drawing rect with gradient
/// @param rect Given rect for drawing
/// @param colors Array of colors which make gradient
-(void)drawRect:(CGRect)rect withColors:(CGFloat*)colors;

/// This method generates attributes dictionary for desired font and some other settings
/// @param font This property defines font for desired text.
/// @param fontColor This property defines font color for desired text.
/// @param textAlignment This property defines text alignment for desired text.
/// @param lineBreakMode This property defines line break mode for desired text.
/// @return Generated font attributes for defined parameters
-(NSDictionary*)fontAttributesWithFont: (UIFont*)font fontColor:(UIColor*)fontColor textAlignment:(NSTextAlignment)textAlignment andLineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

@interface HCChartDrawer (CalculationAndPreparation)

/// Performs all calculations and preparations required for chart drawing
- (void)prepareChartForDrawing;

@end





/// Helper class for storing some information about tick size for date/time values if values on X axis are represented as date/time
@interface HCTimeStep : NSObject

/// This property defines time step, i.e. tick size in seconds.
/// For example, if time step is 3 hours, then multiplier is 3 * 60 * 60 = 10800
@property double multiplier;

/// This property defines number of basic time units which define a time step.
/// For example, if time step is 3 months, then multiplier is 3
@property int value;

/// This property defines time format, for example DD/MM/YYYY
@property (retain, nonatomic) NSString* timeFormat;

/// Boolean value which defines if alternative time format should be used. It is calculated runtime
@property BOOL useAlternativeTimeFormat;

/// This property defines alternative time format, for example DD/MM/YYYY HH:mm:ss. It is used in cases where we aren't sure which time format is best solution for given dates range and number of values. It is calculated runtime
@property (retain, nonatomic) NSString* alternativeTimeFormat;

/// This property defines calendar type, i.e. time unit. In other words, it defines if tick on X axis is represented in seconds, days, months, years,...
@property HCCalendarType calendarType;

/// This property defines referent, i.e. minimal range for using alternative time format. It is only valid if alternativeTimeFormat isn't nil.
@property int referentRangeForAlternativeText;

/// Creates and returns NSDateComponents instance required for calculation tick size and drawing values for X axis
/// @return NSDateComponents instance required for calculation tick size and drawing values for X axis
-(NSDateComponents*)dateComponent;

/// Constructor for HCTimeStep class.
/// @param multiplier Number of basic time units which define a time step
/// @param calendarType Calendar type, i.e. time unit
/// @param value Number of basic time units which define a time step
/// @return Class instance generated with given parameters
-(id)initWithTimeFormat:(NSString*)timeFormat withMultiplier:(double)multiplier calendarType:(HCCalendarType)calendarType value:(int)value;

/// Constructor for HCTimeStep class.
/// @param timeFormat Time format, for example DD/MM/YYYY
/// @param alternativeTimeFormat Alternative time format, for example DD/MM/YYYY HH:mm:ss
/// @param multiplier Number of basic time units which define a time step
/// @param calendarType Calendar type, i.e. time unit
/// @param value Number of basic time units which define a time step
/// @param referentRangeForAlternativeText Numerical value which indicates minimal range for using alternative time format
/// @return Class instance generated with given parameters
-(id)initWithTimeFormat:(NSString*)timeFormat alternativeTimeFormat:(NSString*)alternativeTimeFormat withMultiplier:(double)multiplier calendarType:(HCCalendarType)calendarType value:(int)value referentRangeForAlternativeText:(int)referentRangeForAlternativeText;


@end

@interface HCChartDrawer (Axis)

/// This method is used for preparation and drawing X and Y axis
-(void)drawBothAxises;

/// This method draws horizontal lines for Y ticks
-(void)drawHorizontalLinesForYTicks;


@end

@interface HCChartDrawer (Background)

/// Draws chart background
-(void)drawBackground;

@end


@interface HCChartDrawer (Text)

/// This method calculates text size based on given fontSize
/// @param text Text for which we need to calculate size
/// @param fontSize Font size for given text
/// @return Size of given text with given font size
- (CGSize)sizeOfText:(NSString *)text withFontSize:(double)fontSize;

/// This method generates string for given timestamp (dateWithTimeIntervalSince1970 value)
/// @param timestamp Timestamp which should be converted to Date and represented as text (NSString)
/// @return Generated string for given timestamp
- (NSString*)timeStringForValue:(double)timestamp;

/// This method generates string for given date and given format
/// @param date NSDate instance which should be converted to NSString
/// @param dateFormat Date format for presenting given NSDate instance as NSString.
/// @return Generated string for given NSDate instance
- (NSString*)timeStringForDate:(NSDate*)date withFormat:(NSString*)dateFormat;

/// This method draws text with predefined position and size (rect), attributes, offset and orientation (vertical or horizontal)
/// @param text Text to be drawn
/// @param rect Rect, i.e. position and size for drawing the text
/// @param attributes Text attributes (font, text color, alignment,...) for drawing the text
/// @param offset Position offset for drawing the text (used during drawing successive values on axis)
/// @param isVertical Boolean value which defines if text should be drawn as horizontal or vertical
- (void)drawText:(NSString*)text withRect:(CGRect)rect withAtributes:(NSDictionary*)attributes withOffset:(CGPoint)offset isVertical:(BOOL)isVertical;

/// Returns number as a currency string
/// @param value number which should be converted to string
/// @param numberOfDecimalPlaces Number of decimal places for currency string
/// @param currencyCode Currency code for value which shoud be presented as currency. If this parameter is not set, i.e., it is NULL, currency formatter will use local currency
/// @return Numerical value converted to string
-(NSString*)currencyStringForValue:(double)value numberOfDecimalPlaces:(int)numberOfDecimalPlaces currencyCode:(NSString*)currencyCode;

@end
