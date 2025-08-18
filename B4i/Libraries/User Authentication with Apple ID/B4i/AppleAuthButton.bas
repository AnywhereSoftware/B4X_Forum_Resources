B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
'version 1.00
#Event: AuthResult (Name As String, Email As String)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public btn As B4XView
	Private dele_gate As Object 'ignore
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Dim NativeButton As NativeObject
	btn = NativeButton.Initialize("ASAuthorizationAppleIDButton").RunMethod("new", Null)
	Dim no As NativeObject = Me
	no.RunMethod("SetButton:", Array(btn))
	mBase.AddView(btn, 0, 0, mBase.Width, mBase.Height)
	dele_gate = no.Initialize("AuthorizationDelegate").RunMethod("new", Null)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	btn.SetLayoutAnimated(0, 0, 0, Width, Height)
End Sub

Private Sub Auth_Result(Success As Boolean, Result As Object)
	If Success Then
		Dim no As NativeObject = Result
		Dim credential As NativeObject = no.GetField("credential")
		If GetType(credential) = "ASAuthorizationAppleIDCredential" Then
			Dim email, name As String
			If credential.GetField("email").IsInitialized Then
				Dim formatter As NativeObject
				name = formatter.Initialize("NSPersonNameComponentsFormatter").RunMethod("localizedStringFromPersonNameComponents:style:options:", _
					Array(credential.GetField("fullName"), 0, 0)).AsString
				email = credential.GetField("email").AsString
				Log(email)
				Log(name)
				CallSub3(mCallBack, mEventName & "_AuthResult", name, email)
			End If
		Else
			Log("Unexpected type: " & GetType(credential))
		End If
	End If
End Sub


#if OBJC
#import <AuthenticationServices/AuthenticationServices.h>
- (void) SetButton:(ASAuthorizationAppleIDButton*)btn {
	 [btn addTarget:self action:@selector(handleAuthorizationAppleIDButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}
- (void) handleAuthorizationAppleIDButtonPress:(UIButton *) sender {
	ASAuthorizationAppleIDProvider* provider = [ASAuthorizationAppleIDProvider new];
	ASAuthorizationAppleIDRequest* req = [provider createRequest];
	req.requestedScopes = @[ASAuthorizationScopeEmail, ASAuthorizationScopeFullName];
	ASAuthorizationController* controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:
		@[req]];
	controller.delegate = self._dele_gate;
	controller.presentationContextProvider = self._dele_gate;
	[self._dele_gate setValue:self.bi forKey:@"bi"];
	controller.performRequests;
}
@end
@interface AuthorizationDelegate : NSObject<ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>
@property (nonatomic) B4I* bi;
@end
@implementation AuthorizationDelegate
- (void)authorizationController:(ASAuthorizationController *)controller 
   didCompleteWithAuthorization:(ASAuthorization *)authorization {
   [self.bi raiseUIEvent:nil event:@"auth_result::" params:@[@(true), authorization]];
  }
 - (void)authorizationController:(ASAuthorizationController *)controller 
           didCompleteWithError:(NSError *)error {
	 NSLog(@"error: %@", error);
	 [self.bi raiseUIEvent:nil event:@"auth_result::" params:@[@(false), [NSNull null]]];
}
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller  {
	NSLog(@"presentationAnchorForAuthorizationController");
	return UIApplication.sharedApplication.keyWindow;
}
#End If