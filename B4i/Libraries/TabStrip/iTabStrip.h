
#import <Foundation/Foundation.h>
#import "iCore.h"

@class B4I;
@class B4IList;

//~version: 1.00
//~shortname: TabStrip
//~Event: PageSelected (Position As Int)
//~objectwrapper: UIViewController*
//~DesignerProperty: Key: BarColor, DisplayName: Bar Color, FieldType: Color, DefaultValue: 0xFFFFA500, Description: Top bar color.
//~DesignerProperty: Key: SelectedBarColor, DisplayName: Selection Indicator Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the selection indicator.
@interface B4ITabStrip : B4IObjectWrapper <B4IDesignerCustomView>
- (void)DesignerCreateView:(B4IPanelWrapper *)base :(B4ILabelWrapper *)lw :(B4IMap *)props;
//Sets the list of pages.
- (void)SetPages:(B4IList *)Pages;
//Gets or sets the current page.
@property (nonatomic) int CurrentPage;
@end
