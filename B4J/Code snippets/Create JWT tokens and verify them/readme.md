### Create JWT tokens and verify them by Addo
### 01/31/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165370/)

hello everyone i was in need to create jwt tokens and verify them in my b4j server app so i created this class. it comes to my mind to share it  
it may be valuable to other fellow b4x member to achieve same goal.  
  
**Required libraries**  
[HEADING=2][[SIZE=4]Base64 and Encryption library by[/SIZE]](https://www.b4x.com/android/forum/threads/base64-and-encryption-library.6839/#content)[SIZE=4] [USER=448]@agraham[/USER] [/SIZE][/HEADING]  
[SIZE=4][**JSON Library by**](https://www.b4x.com/android/forum/threads/convert-collections-to-json-and-vice-versa.132678/) **[USER=1]@Erel[/USER]**   
  
**jStringutils library  
  
here is the code snippet.** [/SIZE]  
  

```B4X
Sub Process_Globals  
    Dim SECRET_KEY As String = "YourSecretkey123456" ' Your secret key - KEEP THIS SECRET!  Never expose it in client-side code.  
    Dim ALGORITHM As String = "HMACSHA256" ' The hashing algorithm used for the signature.  
End Sub  
  
' Creates a JWT (JSON Web Token) for a given username.  
Sub CreateJWT(username As String) As String  
    Dim header As Map  ' JWT header (contains algorithm and token type).  
    header.Initialize  
    header.Put("alg", "HS256") ' Algorithm used for signing (HMAC-SHA256).  
    header.Put("typ", "JWT") ' Type of token (JWT).  
  
    Dim payload As Map ' JWT payload (contains user information and other claims).  
    payload.Initialize  
    payload.Put("sub", username) ' Subject (usually the username).  
    payload.Put("iat", DateTime.Now) ' Issued at (timestamp when the token was created).  
    payload.Put("exp", DateTime.Now + (1000 * 60 * 60)) ' Expires in 1 hour (timestamp when the token expires).  
  
    Dim headerBase64 As String = B64_Encode(JsonStringify(header)) ' Base64 encode the header.  
    Dim payloadBase64 As String = B64_Encode(JsonStringify(payload)) ' Base64 encode the payload.  
    Dim signature As String = HMAC_SHA256(headerBase64 & "." & payloadBase64, SECRET_KEY) ' Calculate the signature.  
  
    Return headerBase64 & "." & payloadBase64 & "." & signature ' Return the complete JWT (header.payload.signature).  
End Sub  
  
' Verifies a JWT.  
Sub VerifyJWT(token As String) As Boolean  
    Try  
        Dim parts() As String = Regex.Split("\.", token) ' Split the token into its three parts.  
        If parts.Length <> 3 Then ' Check if the token has the correct format.  
            Log("Invalid token format")  
            Return False  
        End If  
  
        Dim headerBase64 As String = parts(0) ' Extract the header.  
        Dim payloadBase64 As String = parts(1) ' Extract the payload.  
        Dim signatureReceived As String = parts(2) ' Extract the received signature.  
  
        Dim signatureCalculated As String = HMAC_SHA256(headerBase64 & "." & payloadBase64, SECRET_KEY) ' Calculate the expected signature.  
  
        If signatureCalculated <> signatureReceived Then ' Compare the calculated signature with the received signature.  
            Log("Signature mismatch")  
            Return False  
        End If  
  
        ' Optionally verify expiry  
        Dim payloadJson As String = B64_Decode(payloadBase64) ' Decode the payload from Base64 to JSON.  
        Dim parser As JSONParser  
        parser.Initialize(payloadJson)  
        Dim payloadMap As Map = parser.NextObject ' Parse the JSON payload.  
  
        If payloadMap.ContainsKey("exp") Then ' Check if the payload contains an expiry time.  
            Dim expiryTime As Long = payloadMap.Get("exp") ' Get the expiry time.  
            If DateTime.Now > expiryTime Then ' Check if the token has expired.  
                Log("Token expired")  
                Return False  
            End If  
        End If  
  
        Log("Token is valid") ' Token is valid.  
        Return True  
  
    Catch ' Handle any errors during verification.  
        Log("Error verifying token: " & LastException.Message)  
        Return False  
    End Try  
End Sub  
  
' Converts a Map to a JSON string.  
Sub JsonStringify(map As Map) As String  
    Dim j As JSONGenerator  
    Dim json As String  
    j.Initialize(map)  
    json = j.ToString  
    Return json  
End Sub  
  
' Decodes a Base64 encoded string to a UTF8 string.  
Sub B64_Decode(text As String) As String  
    Dim Base64 As StringUtils  
    Try  
        Dim jsondataBytes() As Byte ' Store decoded bytes  
        jsondataBytes = Base64.DecodeBase64(text) ' Decode Base64 to bytes  
        Return BytesToString(jsondataBytes, 0, jsondataBytes.Length, "UTF8") ' Convert bytes to UTF8 string  
    Catch ' Handle Base64 decoding errors.  
        Log("Base64 Decode Error: " & LastException.Message)  
        Return "" ' Or handle the error as needed  
    End Try  
End Sub  
  
' Encodes a string to Base64 using UTF8 encoding.  
Sub B64_Encode(text As String) As String  
    Dim Base64 As StringUtils  
    Return Base64.EncodeBase64(text.GetBytes("UTF8")) ' Encode the string to Base64 using UTF8.  
End Sub  
  
' Calculates the HMAC-SHA256 signature.  
Sub HMAC_SHA256(data As String, key As String) As String  
    Dim hmac As Mac  
    Dim KG As KeyGenerator  
  
    KG.Initialize(ALGORITHM) ' Initialize the KeyGenerator with the algorithm.  
    KG.KeyFromBytes(key.GetBytes("UTF8")) ' Create a key from the secret key using UTF8 encoding.  
  
    hmac.Initialise(ALGORITHM, KG.Key) ' Initialize the Mac object with the algorithm and key.  
    hmac.Update(data.GetBytes("UTF8")) ' Update the Mac object with the data to be signed (using UTF8 encoding).  
    Dim Base64 As StringUtils  
    Return Base64.EncodeBase64(hmac.Sign) ' Calculate the signature and encode it to Base64.  
End Sub
```