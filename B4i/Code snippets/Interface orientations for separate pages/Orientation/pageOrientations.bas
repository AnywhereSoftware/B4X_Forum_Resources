B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.5
@EndOfDesignText@
'Code module
#IgnoreWarnings : 9, 11, 12

Sub Process_Globals
	
	Private Const UIDeviceOrientationUnknown                                    As Int = 0
	Private Const UIDeviceOrientationPortrait                                   As Int = 1
	Private Const UIDeviceOrientationPortraitUpsideDown                         As Int = 2
	Private Const UIDeviceOrientationLandscapeLeft                              As Int = 3
	Private Const UIDeviceOrientationLandscapeRight                             As Int = 4
	Private Const UIDeviceOrientationFaceUp                                     As Int = 5
	Private Const UIDeviceOrientationFaceDown                                   As Int = 6
	
	Private Const UIInterfaceOrientationUnknown                                 As Int = UIDeviceOrientationUnknown
	Private Const UIInterfaceOrientationPortrait                                As Int = UIDeviceOrientationPortrait
	Private Const UIInterfaceOrientationPortraitUpsideDown                      As Int = UIDeviceOrientationPortraitUpsideDown
	Private Const UIInterfaceOrientationLandscapeLeft                           As Int = UIDeviceOrientationLandscapeRight
	Private Const UIInterfaceOrientationLandscapeRight                          As Int = UIDeviceOrientationLandscapeLeft

	Private Const UIInterfaceOrientationMaskPortrait                            As Int = 2
	Private Const UIInterfaceOrientationMaskPortraitUpsideDown                  As Int = 4
	Private Const UIInterfaceOrientationMaskLandscapeLeft                       As Int = 16
	Private Const UIInterfaceOrientationMaskLandscapeRight                      As Int = 8
	
	'----------------------------------------------------------------------------------------------------------------------------------------
	
	Public  isRotateAnimationEnabled                                            As Boolean

	'----------------------------------------------------------------------------------------------------------------------------------------

	Private applicationInstance                                                 As Application	
	Private booleanIgnore                                                       As Boolean
	Private floatOSVersion                                                      As Float
	Private intApplicationInterfaceOrientations                                 As Int
	Private intCurrentDeviceOrientation                                         As Int		
	Private pageCurrent                                                         As Page
	
End Sub

' Returns: current interface orientations (if valid) or 0 (if invalid)
Public Sub setInterfaceOrientations (pageVisible As Page, stringOrientations As String) As Int

	Dim intFinalPosition                                                        As Int
	Dim intLengthOfString                                                       As Int
	Dim intStartPosition                                                        As Int
	Dim listOrientations                                                        As List
	Dim nativeObjectInstance                                                    As NativeObject
	Dim nativeObjectMe                                                          As NativeObject
	Dim nativeObjectPage                                                        As NativeObject
	Dim stringOrientation                                                       As String

	pageCurrent = pageVisible
	
	If floatOSVersion = 0 Then
		floatOSVersion = applicationInstance.OSVersion
		intApplicationInterfaceOrientations = nativeObjectInstance.Initialize ("UIApplication").GetField ("sharedApplication").RunMethod ("supportedInterfaceOrientationsForWindow:", Array (getUIWindow)).AsNumber
		intCurrentDeviceOrientation = nativeObjectInstance.Initialize ("UIDevice").GetField ("currentDevice").GetField ("orientation").AsNumber
		If (intCurrentDeviceOrientation < UIDeviceOrientationPortrait) Or (intCurrentDeviceOrientation > UIDeviceOrientationLandscapeRight) Then intCurrentDeviceOrientation = UIDeviceOrientationUnknown
		nativeObjectMe = Me
		nativeObjectMe.RunMethod ("beginGeneratingDeviceOrientationNotifications", Null)
		isRotateAnimationEnabled = True
	End If

	intLengthOfString = stringOrientations.Length
	intStartPosition = 0
	listOrientations.Initialize
	listOrientations.Add (Null)
	Do While (intStartPosition < intLengthOfString)
		intFinalPosition = stringOrientations.IndexOf2 (",", intStartPosition)
		If intFinalPosition < 0 Then intFinalPosition = intLengthOfString
		stringOrientation = stringOrientations.SubString2 (intStartPosition, intFinalPosition).Trim
		Select Case stringOrientation
			Case "Portrait"
				If Bit.And (intApplicationInterfaceOrientations, UIInterfaceOrientationMaskPortrait)           <> 0 Then listOrientations.Add (UIInterfaceOrientationPortrait)
			Case "PortraitUpsideDown"
				If Bit.And (intApplicationInterfaceOrientations, UIInterfaceOrientationMaskPortraitUpsideDown) <> 0 Then listOrientations.Add (UIInterfaceOrientationPortraitUpsideDown)
			Case "LandscapeLeft"
				If Bit.And (intApplicationInterfaceOrientations, UIInterfaceOrientationMaskLandscapeLeft)      <> 0 Then listOrientations.Add (UIInterfaceOrientationLandscapeLeft)
			Case "LandscapeRight"
				If Bit.And (intApplicationInterfaceOrientations, UIInterfaceOrientationMaskLandscapeRight)     <> 0 Then listOrientations.Add (UIInterfaceOrientationLandscapeRight)
		End Select
		intStartPosition = intFinalPosition + 1
	Loop
	If listOrientations.Size = 1 Then
		If Bit.And (intApplicationInterfaceOrientations, UIInterfaceOrientationMaskPortrait)           <> 0 Then listOrientations.Add (UIInterfaceOrientationPortrait)
		If Bit.And (intApplicationInterfaceOrientations, UIInterfaceOrientationMaskPortraitUpsideDown) <> 0 Then listOrientations.Add (UIInterfaceOrientationPortraitUpsideDown)
		If Bit.And (intApplicationInterfaceOrientations, UIInterfaceOrientationMaskLandscapeLeft)      <> 0 Then listOrientations.Add (UIInterfaceOrientationLandscapeLeft)
		If Bit.And (intApplicationInterfaceOrientations, UIInterfaceOrientationMaskLandscapeRight)     <> 0 Then listOrientations.Add (UIInterfaceOrientationLandscapeRight)
	End If
	nativeObjectPage = pageVisible
	nativeObjectPage.SetField ("interfaceOrientations", listOrientations)
	
	Return checkInterfaceOrientation
				
End Sub

Private Sub checkInterfaceOrientation As Int

	Dim booleanAnimate                                                          As Boolean
	Dim intCurrentInterfaceOrientation                                          As Int	
	Dim intI                                                                    As Int
	Dim intJ                                                                    As Int
	Dim intK                                                                    As Int
	Dim intNewInterfaceOrientation                                              As Int
	Dim listOrientations                                                        As List	
	Dim nativeObjectDevice                                                      As NativeObject	
	Dim nativeObjectUIView                                                      As NativeObject
	Dim nativeObjectVisiblePage                                                 As NativeObject

	intCurrentInterfaceOrientation = getCurrentInterfaceOrientation

	nativeObjectVisiblePage = pageCurrent
	listOrientations = nativeObjectVisiblePage.GetField ("interfaceOrientations")
	If listOrientations.IsInitialized = False Then Return intCurrentInterfaceOrientation
	If listOrientations.Size < 2 Then Return intCurrentInterfaceOrientation
	For intI = 2 To listOrientations.Size
		If listOrientations.Get (intI - 1) = intCurrentInterfaceOrientation Then intJ = intI		
		If listOrientations.Get (intI - 1) = intCurrentDeviceOrientation Then intK = intI
	Next
	If intK > 0 Then
		intNewInterfaceOrientation = intCurrentDeviceOrientation					
	Else If intJ > 0 Then
		intNewInterfaceOrientation = intCurrentInterfaceOrientation
	Else	
	    intNewInterfaceOrientation = listOrientations.Get (1)
	End If
	
	listOrientations.Set (0, intNewInterfaceOrientation)
	nativeObjectVisiblePage.SetField ("interfaceOrientations", listOrientations)
	If intCurrentInterfaceOrientation = intNewInterfaceOrientation Then Return intCurrentInterfaceOrientation

	nativeObjectUIView.Initialize ("UIView")
	booleanAnimate = nativeObjectUIView.GetField ("areAnimationsEnabled").AsBoolean
	nativeObjectUIView.RunMethod ("setAnimationsEnabled:", Array (isRotateAnimationEnabled))
	booleanIgnore = True
	nativeObjectDevice.Initialize ("UIDevice").RunMethod ("currentDevice", Null).SetField ("orientation", 0)
	nativeObjectDevice.Initialize ("UIDevice").RunMethod ("currentDevice", Null).SetField ("orientation", intNewInterfaceOrientation)	
	nativeObjectDevice.Initialize ("UIDevice").RunMethod ("currentDevice", Null).SetField ("orientation", intCurrentDeviceOrientation)
	booleanIgnore = False
	nativeObjectUIView.RunMethod ("setAnimationsEnabled:", Array (booleanAnimate))			
	Return 0
	
End Sub

Private Sub deviceOrientationChanged (objectNotification As Object)

	Dim intNewDeviceOrientation                                                 As Int
	Dim nativeObjectInstance                                                    As NativeObject
	
	If booleanIgnore Then Return
	
	intNewDeviceOrientation = nativeObjectInstance.Initialize ("UIDevice").GetField ("currentDevice").GetField ("orientation").AsNumber
	Select Case intNewDeviceOrientation
		Case UIDeviceOrientationPortrait, UIDeviceOrientationPortraitUpsideDown, UIDeviceOrientationLandscapeLeft, UIDeviceOrientationLandscapeRight			
			intCurrentDeviceOrientation = intNewDeviceOrientation			
			CallSubDelayed (Me, "CheckInterfaceOrientation")
	End Select	

End Sub

Private Sub getUIWindow () As NativeObject

	Dim listWindows                                                             As List
	Dim nativeObjectInstance                                                    As NativeObject
	
	If floatOSVersion >= 13 Then ' UIApplication.sharedApplication.windows.firstObject
		listWindows = nativeObjectInstance.Initialize ("UIApplication").GetField ("sharedApplication").GetField ("windows")
		Return listWindows.Get (0)
	Else ' UIApplication.sharedApplication.delegate.window
		Return nativeObjectInstance.Initialize ("UIApplication").GetField ("sharedApplication").GetField ("delegate").GetField ("window")
	End If

End Sub

Public Sub getCurrentInterfaceOrientation () As Int
	
	Dim nativeObjectInterfaceOrientation                                        As NativeObject
	
	If applicationInstance.OSVersion >= 13 Then
		Return getUIWindow.GetField ("windowScene").GetField ("interfaceOrientation").AsNumber ' <UIWindow>.windowScene.interfaceOrientation
	Else
		Return nativeObjectInterfaceOrientation.Initialize ("UIApplication").GetField ("sharedApplication").GetField ("statusBarOrientation").AsNumber
	End If

End Sub

#If OBJC

- (void) beginGeneratingDeviceOrientationNotifications 
    {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (_deviceorientationchanged:)
	    name: UIDeviceOrientationDidChangeNotification object: [UIDevice currentDevice]];
    }
@end

#import <objc/runtime.h>
@interface UIViewController (SM)
@property (nonatomic, readwrite, strong) NSArray * interfaceOrientations;
@end
@implementation UIViewController (SM)
- (NSArray *) interfaceOrientations { return objc_getAssociatedObject (self, @selector (interfaceOrientations)); }
- (void) setInterfaceOrientations: (NSArray *) value { objc_setAssociatedObject (self, @selector (interfaceOrientations), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

- (BOOL) shouldAutorotate
    {
	if ([self isKindOfClass: NSClassFromString (@"MMDrawerController")])
	    {
	    UINavigationController * navigationController = [self valueForKey: @"centerViewController"];	   
	    return [navigationController.visibleViewController shouldAutorotate];
	    };
	   
    if (self.interfaceOrientations == nil) { return false; };
	UIInterfaceOrientation interfaceOrientation;
	if (@available (iOS 13, *)) { interfaceOrientation = UIApplication.sharedApplication.windows.firstObject.windowScene.interfaceOrientation; }
	    else { interfaceOrientation = UIApplication.sharedApplication.statusBarOrientation; };    
	if (interfaceOrientation == [self.interfaceOrientations.firstObject longValue]) { return false; };	
	return true;
    }
@end

@interface UINavigationController (SM)
@end
@implementation UINavigationController (SM)
- (BOOL) shouldAutorotate { return [self.visibleViewController shouldAutorotate]; }
#End If
