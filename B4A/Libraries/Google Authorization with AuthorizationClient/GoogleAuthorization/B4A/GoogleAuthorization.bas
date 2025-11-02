B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	Private  AuthorizationClient As JavaObject
	Private xui As XUI
	Private ion As Object
	Type AuthorizationResult (ResolutionNeeded As Boolean, Token As String, Error As String, Success As Boolean, Result As JavaObject)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	Dim context As JavaObject
	context.InitializeContext
	AuthorizationClient =  AuthorizationClient.InitializeStatic("com/google/android/gms/auth/api/identity/Identity".Replace("/",".")) _
		.RunMethod("getAuthorizationClient", Array(context))
End Sub

'Tries to authorize the user. Doesn't show any UI.
Public Sub AuthorizeMaybeAutomatic (Scopes As List) As ResumableSub
	Dim AuthorizationRequest As JavaObject
	Dim ScoresConverted As List = B4XCollections.CreateList(Null)
	For Each s As String In Scopes
		Dim scope As JavaObject
		scope.InitializeNewInstance("com/google/android/gms/common/api/Scope".Replace("/", "."), Array(s))
		ScoresConverted.Add(scope)
	Next
	AuthorizationRequest = AuthorizationRequest.InitializeNewInstance("com.google.android.gms.auth.api.identity.AuthorizationRequest$Builder", Null) _
		.RunMethodJO("setRequestedScopes", Array(ScoresConverted)).RunMethod("build", Null)
	Dim task As JavaObject = AuthorizationClient.RunMethod("authorize", Array(AuthorizationRequest))
	Do While task.RunMethod("isComplete", Null).As(Boolean) = False
		Sleep(50)
	Loop
	If task.RunMethod("isSuccessful", Null) Then
		Dim AuthorizationResult As JavaObject = task.RunMethod("getResult", Null)
		If AuthorizationResult.RunMethod("hasResolution", Null).As(Boolean) Then
			Return CreateAuthorizationResult(True, "", "", True, AuthorizationResult)
		Else
			Return CreateAuthorizationResult(False, AuthorizationResult.RunMethod("getAccessToken", Null), "", True, AuthorizationResult)
		End If
	Else
		Return CreateAuthorizationResult(False, "", task.RunMethod("getException", Null), False, Null)
	End If
End Sub

'Starts the autorization flow, after AuthorizeMaybeAutomatic returned a result with ResolutionNeeded = True.
Public Sub AuthorizeRequestAccess(Result As AuthorizationResult) As ResumableSub
	Dim IntentSender As JavaObject = Result.Result.RunMethodJO("getPendingIntent", Null) _
				.RunMethod("getIntentSender", Null)
	StartIntentSenderForResult(IntentSender)
	Wait For ion_Event(MethodName As String, Args() As Object)
	Try
		Dim Result2 As JavaObject = AuthorizationClient.RunMethod("getAuthorizationResultFromIntent", Array(Args(1)))
		Return CreateAuthorizationResult(False, Result2.RunMethod("getAccessToken", Null), "", True, Result2)
	Catch
		Log(LastException)
		Return CreateAuthorizationResult(False, "", LastException, False, Null)
	End Try
End Sub

Private Sub StartIntentSenderForResult(IntentSender As Object)
	Dim jo As JavaObject = GetBA
	ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)
	Dim RequestCode As Int = Me.As(JavaObject).RunMethod("getRequestCode", Array(ion))
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	ctxt.RunMethod("startIntentSenderForResult", Array(IntentSender, RequestCode, Null, 0, 0, 0, Null))
End Sub

Private Sub GetBA As Object
	Dim jo As JavaObject = Me
	Return jo.RunMethod("getBA", Null)
End Sub

'Clears a cached token. Returnes True if operation was successful.
'Requires com.google.android.gms:play-services-auth v21.4.0+ 
Public Sub ClearToken(Token As String) As ResumableSub
	Dim ClearTokenRequest As JavaObject
	ClearTokenRequest = ClearTokenRequest.InitializeStatic("com/google/android/gms/auth/api/identity/ClearTokenRequest".Replace("/", ".")) _
		.RunMethodJO("builder", Null) _
		.RunMethodJO("setToken", Array(Token)).RunMethod("build", Null)
	Dim task As JavaObject = AuthorizationClient.RunMethod("clearToken", Array(ClearTokenRequest))
	Do While task.RunMethod("isComplete", Null).As(Boolean) = False
		Sleep(50)
	Loop
	Return task.RunMethod("isSuccessful", Null).As(Boolean)
End Sub




#if Java
//https://www.b4x.com/android/forum/threads/java-guide-using-onactivityresult.7297/#content
public int getRequestCode(anywheresoftware.b4a.IOnActivityResult ion) {
	try {
		BA ba = getBA();
         ba.startActivityForResult(ion, null); //<-- passing null instead of an intent
      } catch (NullPointerException npe) {
         //required...
      }
      BA.SharedProcessBA sba = ba.sharedProcessBA;
      try {
         java.lang.reflect.Field f = BA.SharedProcessBA.class.getDeclaredField("onActivityResultCode");
         f.setAccessible(true);
         int requestCode = f.getInt(sba) - 1;
		 return requestCode;
      } catch (Exception e) {
         throw new RuntimeException(e);
      }
}
#End If

Private Sub CreateAuthorizationResult (ResolutionNeeded As Boolean, Token As String, Error As String, Success As Boolean, Result As JavaObject) As AuthorizationResult
	Dim t1 As AuthorizationResult
	t1.Initialize
	t1.ResolutionNeeded = ResolutionNeeded
	t1.Token = Token
	t1.Error = Error
	t1.Success = Success
	t1.Result = Result
	Return t1
End Sub