### [web]JSON Web Token (auth0/java-jwt) by aeric
### 08/05/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/142125/)

You can use this class to generate [**JSON Web Token (JWT)**](https://jwt.io/) for use in Web API B4J Server.  
This code is using JavaObject from Java JWT github project (<https://github.com/auth0/java-jwt>) by Auth0.  
I only add support for HMAC algorithms. If you want, you can modify this code to support RSA and ECDSA algorithms.  
Example attached.  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
#AdditionalJar: java-jwt-4.0.0  
#AdditionalJar: jackson-core-2.13.3  
#AdditionalJar: jackson-databind-2.13.3  
#AdditionalJar: jackson-annotations-2.13.3  
  
Sub Process_Globals  
    Dim jwt1 As JSONWebToken  
    Dim jwt2 As JSONWebToken  
End Sub  
  
Sub AppStart (Args() As String)  
    ' Generate a token  
    Dim secret1 As String = "secret"  
    jwt1.Initialize("HMAC256", secret1, False)  
    If jwt1.IsInitialized Then  
        Dim generatedToken As String = CreateAndSignToken  
        Log( generatedToken )  
        Dim parts() As String  
        parts = Regex.Split("\.", generatedToken)  
        For Each part As String In parts  
            Log( part )  
        Next  
    End If  
    
    ' Verify the token  
    Dim secret2 As String = "secret" ' secret2 should be same as secret1 otherwise verification will failed  
    jwt2.Initialize("HMAC256", secret2, False)  
    VerifyAndGetClaims(generatedToken)  
    
    StartMessageLoop  
End Sub  
  
Sub CreateAndSignToken As String  
    jwt1.withIssuer("Computerise")  
    jwt1.withClaim(CreateMap("user": "Aeric", "isAdmin": True))  
    jwt1.withExpiresAt(DateTime.Now + 180000)  
    jwt1.Sign  
    Return jwt1.Token  
End Sub  
  
Sub VerifyAndGetClaims (Token As String)  
    jwt2.Token = Token  
    jwt2.Verify  
    If jwt2.Verified Then  
        Dim ExpDate As String = jwt2.exp  
        Log( ExpDate )  
    
        Dim claims As Object = jwt2.claims  
        Log( claims )  
    
        Dim issuer As Object = jwt2.getClaimByKey("iss")  
        Log( issuer )  
        
        Dim isAdmin As Object = jwt2.getClaimByKey("isAdmin")  
        Log( isAdmin )  
    Else  
        LogError( jwt2.Error )  
    End If  
End Sub
```

  
  

```B4X
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
```

  
  
Download Additional Jars:  
<https://repo1.maven.org/maven2/com/auth0/java-jwt/4.0.0/java-jwt-4.0.0.jar>  
<https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.13.3/jackson-core-2.13.3.jar>  
<https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.13.3/jackson-databind-2.13.3.jar>  
<https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.13.3/jackson-annotations-2.13.3.jar>