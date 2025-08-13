B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
'version: 1.00
#Event: Complete (Success As Boolean, ErrorMessage As String)

Sub Class_Globals
	Private ctxt As JavaObject
	Private Manager As JavaObject
	Private Handler As JavaObject
	Private Executor As Object
	Private mTarget As Object
	Private mEventName As String
End Sub

Public Sub Initialize (Target As Object, EventName As String)
	mTarget = Target
	mEventName = EventName
	ctxt.InitializeContext
	Manager = Manager.InitializeStatic("androidx.biometric.BiometricManager").RunMethod("from", Array(ctxt))
	Handler.InitializeNewInstance("android.os.Handler", Null)
	Executor = Handler.CreateEvent("java.util.concurrent.Executor", "Executor", Null)
End Sub

Private Sub Executor_Event (MethodName As String, Args() As Object) As Object
	If MethodName = "execute" Then
		Handler.RunMethod("post", Array(Args(0)))
	End If
	Return Null
End Sub

Public Sub CanAuthenticate As String
	Dim v As Int = Manager.RunMethod("canAuthenticate", Null)
	Select v
		Case 1
			Return "UNAVAILABLE"
		Case 11
			Return "NONE_ENROLLED"
		Case 12
			Return "NO_HARDWARE"
		Case 0
			Return "SUCCESS"
		Case Else
			Return "UNKNOWN"
	End Select
End Sub

Public Sub Show (Msg As String)
	Dim PromptInfoBuilder As JavaObject
	PromptInfoBuilder.InitializeNewInstance("androidx.biometric.BiometricPrompt$PromptInfo$Builder", Null)
	PromptInfoBuilder.RunMethod("setTitle", Array(Msg))
	PromptInfoBuilder.RunMethod("setNegativeButtonText", Array("Cancel"))
	Dim Ev As JavaObject
	Ev.InitializeNewInstance(Application.PackageName & ".biometricmanager.BiometricPromptAuthentication", Array(Me))
	Dim Prompt As JavaObject
	Prompt.InitializeNewInstance("androidx.biometric.BiometricPrompt", Array(ctxt, Executor, Ev))
	Prompt.RunMethod("authenticate", Array(PromptInfoBuilder.RunMethod("build", Null)))
	
End Sub

Private Sub Auth_Complete (Success As Boolean, ErrorCode As Int, ErrorMessage As String)
	
	CallSubDelayed3(mTarget, mEventName & "_complete", Success, ErrorMessage)
End Sub


#if java

import androidx.biometric.*;
public static class BiometricPromptAuthentication extends BiometricPrompt.AuthenticationCallback {
	private BA ba;
	public BiometricPromptAuthentication(B4AClass parent) {
		ba = parent.getBA();
	}
	@Override
	public void onAuthenticationError(int errorCode, CharSequence errString) {
		super.onAuthenticationError(errorCode, errString);
		 ba.raiseEventFromUI(this, "auth_complete", false, errorCode, errString);
	}

	@Override
	public void onAuthenticationSucceeded(BiometricPrompt.AuthenticationResult result) {
		super.onAuthenticationSucceeded(result);
		 ba.raiseEventFromUI(this, "auth_complete", true, 0, "");
	}

	@Override
	public void onAuthenticationFailed() {
		super.onAuthenticationFailed();
	}
}
#end if