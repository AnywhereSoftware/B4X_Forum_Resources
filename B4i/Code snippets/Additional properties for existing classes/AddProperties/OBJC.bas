B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.5
@EndOfDesignText@
'Code module

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.

End Sub

#If OBJC
@end
#import <objc/runtime.h>
@interface UIView (myApp)
@property (nonatomic, readwrite, strong) NSObject * myProperty1;
@property (nonatomic, readwrite, strong) NSObject * myProperty2;
@end
@implementation UIView (myApp)
- (NSObject *) myProperty1 { return objc_getAssociatedObject (self, @selector (myProperty1)); }
- (void) setMyProperty1: (NSObject *) value { objc_setAssociatedObject (self, @selector (myProperty1), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

- (NSObject *) myProperty2 { return objc_getAssociatedObject (self, @selector (myProperty2)); }
- (void) setMyProperty2: (NSObject *) value { objc_setAssociatedObject (self, @selector (myProperty2), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
#End If
