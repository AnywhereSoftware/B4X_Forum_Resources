B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private JWT As JavaObject
	Private ALG As JavaObject
	Private builder As JavaObject
	Private verifier As JavaObject
	Private m_Token As Object
	Private m_Initialized As Boolean
	Private m_Verified As Boolean
	Private m_Exception As String
End Sub

Public Sub Initialize (Algorithm As String, Secret As String, Base64Encode As Boolean)
	Private SupportedAlgorithms As List = Array As String("HMAC256", "HMAC384", "HMAC512")
	If SupportedAlgorithms.IndexOf(Algorithm) > -1 Then
		Algorithm = Algorithm.ToUpperCase
	Else
		Log("Algorithm not supported")
		Return
	End If
	If Base64Encode Then
		Dim su As StringUtils
		Secret = su.EncodeBase64(Secret.GetBytes("UTF8"))
		'Log ( Secret )
	End If
	Private AO As JavaObject
	AO.InitializeStatic("com.auth0.jwt.algorithms.Algorithm")
	ALG = AO.RunMethod(Algorithm, Array As String(Secret))
	
	JWT.InitializeStatic("com.auth0.jwt.JWT")
	builder = JWT.RunMethodJO("create", Null)
	verifier = JWT.RunMethodJO("require", Array(ALG)).RunMethodJO("build", Null)
	m_Initialized = True
End Sub

Public Sub IsInitialized As Boolean
	Return m_Initialized
End Sub

Public Sub withIssuer (Issuer As String)
	builder.RunMethodJO("withIssuer", Array(Issuer))
End Sub

Public Sub withClaim (claim As Map)
	For Each Key In claim.Keys
		builder.RunMethodJO("withClaim", Array(Key, claim.Get(Key)))
	Next
End Sub

Public Sub withExpiresAt (Date As Long)
	Dim NativeMe As JavaObject = Me
	Dim dt As Object = NativeMe.RunMethod("JavaDate", Array(Date))
	builder.RunMethodJO("withExpiresAt", Array(dt))
End Sub

Public Sub getToken As String
	Return m_Token
End Sub

Public Sub setToken (Token As String)
	m_Token = Token
End Sub

Public Sub Sign
	m_Token = builder.RunMethodJO("sign", Array(ALG))
End Sub

Public Sub Verify As JavaObject
	Try
		Dim jo As JavaObject
		jo = verifier.RunMethod("verify", Array(m_Token))
		m_Verified = True
	Catch
		'Log(LastException)
		m_Exception = LastException.Message
		m_Verified = False
	End Try
	Return jo
End Sub

Public Sub getVerified As Boolean
	Return m_Verified
End Sub

Public Sub getError As String
	Return m_Exception
End Sub

Public Sub exp As Object
	Try
		Return Verify.RunMethod("getExpiresAt", Null)
	Catch
		Log(LastException)
	End Try
	Return Null
End Sub

Public Sub claims As Object
	Try
		Return Verify.RunMethod("getClaims", Null)
	Catch
		Log(LastException)
	End Try
	Return Null
End Sub

Public Sub getClaimByKey (Key As String) As Object
	Try
		Return claims.As(Map).Get(Key)
	Catch
		Log(LastException)
	End Try
	Return Null
End Sub

#If Java
import java.util.Date;

public Date JavaDate(Long value)
{
	return new Date(value);
}
#End If