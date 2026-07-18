### [Web] JSON Web Token (auth0/java-jwt) by aeric
### 07/14/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/142125/)

GitHub: <https://github.com/pyhoon/jsonwebtoken-b4j>  
  
You can use this JSON Web Token (JWT) library in Pakai Server or B4J project.  
This library is wrapped from Java JWT github project (<https://github.com/auth0/java-jwt>) by Auth0 using JavaObject and jStringUtils.  
HMAC and RSA algorithms supported. If you want, you can modify the class to support other algorithms.  
  
Source code:  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
    #LibraryName: JsonWebToken  
    #LibraryVersion: 2.21  
    #LibraryAuthor: Aeric Poon  
    #AdditionalJar: java-jwt-4.5.2  
    #AdditionalJar: jackson-core-2.21.5  
    #AdditionalJar: jackson-databind-2.21.5  
    #AdditionalJar: jackson-annotations-2.21  
#End Region  
  
Sub Process_Globals  
    Dim jwt1 As JsonWebToken  
    Dim jwt2 As JsonWebToken  
End Sub  
  
Sub AppStart (Args() As String)  
    ConfigureToken  
End Sub  
  
#Region ConfigureJWTToken  
Public Sub ConfigureToken  
    ' Generate a token  
    Dim secret1 As String = "secret"  
    jwt1.Initialize("HMAC256", secret1, False)  
    Dim generatedToken As String = CreateAndSignToken  
    Log( generatedToken )  
    File.WriteString(File.DirApp, "token", generatedToken)  
    If jwt1.IsInitialized Then  
        Dim parts() As String  
        parts = Regex.Split("\.", generatedToken)  
        For Each part As String In parts  
            Log( part )  
        Next  
    End If  
   
      Dim readtoken As String = File.ReadString(File.DirApp, "token")  
    Log(readtoken)  
   
    ' Verify the token  
    Dim secret2 As String = "secret" ' secret2 should be same as secret1 otherwise verification will failed  
    jwt2.Initialize("HMAC256", secret2, False)  
    VerifyAndGetClaims(readtoken)  
End Sub  
#End Region  
  
Sub CreateAndSignToken As String  
    jwt1.Issuer = "Computerise"  
    jwt1.Claims = CreateMap("user": "Aeric", "isAdmin": True)  
    jwt1.ExpiresAt = DateTime.Now + 180000  
    jwt1.Sign  
    Return jwt1.Token  
End Sub  
  
Sub VerifyAndGetClaims (Token As String)  
    jwt2.Token = Token  
    jwt2.Verify  
    If jwt2.Verified Then  
        Dim ExpDate As String = jwt2.ExpiresAt  
        Log( ExpDate )  
   
        Dim claims As Object = jwt2.Claims  
        Log( claims )  
   
        Dim issuer As Object = jwt2.Issuer  
        Log( issuer )  
   
        Dim isAdmin As Object = jwt2.ReadClaim("isAdmin")  
        Log( isAdmin )  
    Else  
        LogError( jwt2.Error )  
    End If  
End Sub
```

  
  

```B4X
'Based on: https://github.com/auth0/java-jwt  
'Additional Libraries: JavaObject, jStringUtils  
Sub Class_Globals  
    Private SU                 As StringUtils  
    Private ALG             As JavaObject  
    Private JWT             As JavaObject  
    Private builder         As JavaObject  
    Private verifier         As JavaObject  
    Private decoded         As JavaObject  
    Private m_Issuer         As String  
    Private m_Claims         As Map  
    Private m_Token         As Object  
    Private m_Initialized     As Boolean  
    Private m_Verified         As Boolean  
    Private m_Exception     As String  
End Sub  
  
Public Sub Initialize (Algorithm As String, Secret As String, Base64Encode As Boolean)  
    Dim SupportedAlgorithms As List = Array As String("HMAC256", "HMAC384", "HMAC512", "RSA256", "RSA384", "RSA512")  
    If SupportedAlgorithms.IndexOf(Algorithm) > -1 Then  
        Algorithm = Algorithm.ToUpperCase  
    Else  
        m_Exception = "Algorithm not supported"  
        Return  
    End If  
    If Base64Encode Then  
        Secret = SU.EncodeBase64(Secret.GetBytes("UTF8"))  
    End If  
    Dim AO As JavaObject  
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
  
Public Sub getIssuer As String  
    Dim iss As String  
    Try  
        If m_Verified Then  
            iss = decoded.RunMethod("getIssuer", Null)  
        End If  
        m_Issuer = iss  
    Catch  
        m_Exception = LastException.Message  
        'Log(m_Exception)  
    End Try  
    Return m_Issuer  
End Sub  
  
Public Sub setIssuer (Issuer As String)  
    Try  
        builder.RunMethodJO("withIssuer", Array(Issuer))  
    Catch  
        m_Exception = LastException.Message  
        'Log(m_Exception)  
    End Try  
    m_Issuer = Issuer  
End Sub  
  
Public Sub getClaims As Map  
    Dim clm As Map  
    Try  
        If m_Verified Then  
            clm = decoded.RunMethod("getClaims", Null)  
        End If  
        m_Claims = clm  
    Catch  
        m_Exception = LastException.Message  
        'Log(m_Exception)  
    End Try  
    Return m_Claims  
End Sub  
  
Public Sub setClaims (Claims As Map)  
    For Each Key In Claims.Keys  
        builder.RunMethodJO("withClaim", Array(Key, Claims.Get(Key)))  
    Next  
    m_Claims = Claims  
End Sub  
  
Public Sub ReadClaim (Key As String) As Object  
    Return getClaims.Get(Key)  
End Sub  
  
Public Sub getNotBefore As Object  
    Return ReadClaim("nbf")  
End Sub  
  
Public Sub getExpiresAt As Object  
    Try  
        If m_Verified Then  
            Dim exp As Object = decoded.RunMethod("getExpiresAt", Null)  
        End If  
    Catch  
        m_Exception = LastException.Message  
        'Log(m_Exception)  
    End Try  
    Return exp  
End Sub  
  
Public Sub setIssuedAt (IssuedAt As Object)  
    Dim jo As JavaObject = Me  
    Dim dt As Object = jo.InitializeNewInstance("java.util.Date", Array(IssuedAt))  
    builder.RunMethodJO("withIssuedAt", Array(dt))  
End Sub  
  
Public Sub setExpiresAt (ExpiresAt As Object)  
    Dim jo As JavaObject = Me  
    Dim dt As Object = jo.InitializeNewInstance("java.util.Date", Array(ExpiresAt))  
    builder.RunMethodJO("withExpiresAt", Array(dt))  
End Sub  
  
Public Sub getToken As String  
    Return m_Token  
End Sub  
  
Public Sub setToken (Token As String)  
    m_Token = Token  
End Sub  
  
Public Sub Verify As JavaObject  
    Try  
        decoded = verifier.RunMethod("verify", Array(m_Token))  
        m_Verified = True  
    Catch  
        m_Exception = LastException.Message  
        m_Verified = False  
    End Try  
    Return decoded  
End Sub  
  
Public Sub getVerified As Boolean  
    Return m_Verified  
End Sub  
  
Public Sub getError As String  
    Return m_Exception  
End Sub  
  
Public Sub Sign  
    m_Token = builder.RunMethodJO("sign", Array(ALG))  
End Sub
```

  
  
Download Additional Jars:  
<https://repo1.maven.org/maven2/com/auth0/java-jwt/4.5.2/java-jwt-4.5.2.jar>  
<https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.21.5/jackson-core-2.21.5.jar>  
<https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.21.5/jackson-databind-2.21.5.jar>  
<https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.21/jackson-annotations-2.21.jar>  
  
[SPOILER="older version"]  
<https://repo1.maven.org/maven2/com/auth0/java-jwt/4.0.0/java-jwt-4.0.0.jar>  
<https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.13.3/jackson-core-2.13.3.jar>  
<https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.13.3/jackson-databind-2.13.3.jar>  
<https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.13.3/jackson-annotations-2.13.3.jar>  
[/SPOILER]