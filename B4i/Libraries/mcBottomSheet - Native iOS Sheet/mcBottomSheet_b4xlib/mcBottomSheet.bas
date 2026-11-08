B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.51
@EndOfDesignText@
Sub Class_Globals
	Private mContentPanel As B4XView
End Sub

'Initialize the BottomSheet with a View
Public Sub initSheet(ContentPanel As B4XView)
	mContentPanel = ContentPanel
End Sub



#REGION V4

#if OBJC
// Global variable to keep reference to the bottom sheet
static UIViewController *gBottomSheetVC;

- (void) showBottomSheetWithView:(UIView *)contentView halfHeight:(BOOL)halfHeight {
    // Create the UIViewController that will be presented as a bottom sheet
    UIViewController *bottomSheetVC = [[UIViewController alloc] init];
    bottomSheetVC.view.backgroundColor = [UIColor whiteColor];
    
    // Store reference to the bottom sheet
    gBottomSheetVC = bottomSheetVC;
    
    // Add contentView to the bottom sheet
    contentView.frame = bottomSheetVC.view.bounds;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [bottomSheetVC.view addSubview:contentView];
    
    // Configure the presentation controller for bottom sheet style
    bottomSheetVC.modalPresentationStyle = UIModalPresentationPageSheet;
    
    if (@available(iOS 15.0, *)) {
        if (bottomSheetVC.sheetPresentationController) {
            if (halfHeight) {
                bottomSheetVC.sheetPresentationController.detents = @[
                    [UISheetPresentationControllerDetent mediumDetent]
                ];
            } else {
                bottomSheetVC.sheetPresentationController.detents = @[
                    [UISheetPresentationControllerDetent largeDetent]
                ];
            }
            bottomSheetVC.sheetPresentationController.prefersGrabberVisible = YES;
            bottomSheetVC.sheetPresentationController.preferredCornerRadius = 20.0;
        }
    }
    
    // Get the root view controller and present the bottom sheet
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:bottomSheetVC animated:YES completion:nil];
}

- (void) dismissBottomSheet {
    if (gBottomSheetVC != nil) {
        [gBottomSheetVC dismissViewControllerAnimated:YES completion:nil];
        gBottomSheetVC = nil;
    }
}

- (void) updateBottomSheetHeight:(BOOL)halfHeight {
    if (gBottomSheetVC != nil) {
        if (@available(iOS 15.0, *)) {
            if (gBottomSheetVC.sheetPresentationController) {
                if (halfHeight) {
                    gBottomSheetVC.sheetPresentationController.detents = @[
                        [UISheetPresentationControllerDetent mediumDetent]
                    ];
                } else {
                    gBottomSheetVC.sheetPresentationController.detents = @[
                        [UISheetPresentationControllerDetent largeDetent]
                    ];
                }
                // No need for explicit animation - detent changes are automatically animated
            }
        }
    }
}
#End If

'B4i wrapper methods v4

'Show the bottom sheet at half height (medium detent)
Public Sub ShowHalf
	Dim no As NativeObject = Me
	Dim contentNativeView As NativeObject = mContentPanel
	no.RunMethod("showBottomSheetWithView:halfHeight:", Array(contentNativeView, True))
End Sub

'Show the bottom sheet at full height (large detent)
Public Sub ShowFull
	Dim no As NativeObject = Me
	Dim contentNativeView As NativeObject = mContentPanel
	no.RunMethod("showBottomSheetWithView:halfHeight:", Array(contentNativeView, False))
End Sub

'Dismiss the bottom sheet
Public Sub Dismiss
	Dim no As NativeObject = Me
	no.RunMethod("dismissBottomSheet", Null)
End Sub

'Update the bottom sheet height (True for half, False for full)
Public Sub UpdateHeight(HalfHeight As Boolean)
	Dim no As NativeObject = Me
	no.RunMethod("updateBottomSheetHeight:", Array(HalfHeight))
End Sub

'Example usage in your B4XPage:
'
'Sub B4XPage_Created (Root1 As B4XView)
'    'Create your content panel
'    Dim pnlContent As Panel
'    pnlContent.Initialize("")
'    
'    'Add components to pnlContent
'    Dim lblTitle As Label
'    lblTitle.Initialize("")
'    pnlContent.AddView(lblTitle, 10dip, 10dip, 100%x - 20dip, 40dip)
'    lblTitle.Text = "Bottom Sheet Title"
'    lblTitle.TextSize = 18
'    
'    'Add a close button
'    Dim btnClose As Button
'    btnClose.Initialize("btnClose")
'    pnlContent.AddView(btnClose, (100%x - 100dip) / 2, 80%y - 60dip, 100dip, 40dip)
'    btnClose.Text = "Close"
'    
'    'Initialize the bottom sheet
'    Dim bs As BottomSheet
'    bs.Initialize(pnlContent)
'End Sub
'
'Sub btnClose_Click
'    bs.Dismiss
'End Sub
'
'Sub ShowBottomSheet
'    bs.ShowHalf 'or bs.ShowFull
'End Sub


#End Region