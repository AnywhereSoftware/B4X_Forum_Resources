### [server] FirebaseServer - backend verification for signed in users by Erel
### 02/14/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/68672/)

Users can sign in to your B4A or B4i apps using Google or Facebook with the FirebaseAuth libraries.  
  
FirebaseServer completes the puzzle with server side verification of the user. This means that the signed in user gets a token id (long string) from Firebase services by calling **FirebaseAuth.GetUserTokenId**. The client sends the token id to the server.  
The server verifies the token using this library.  
  
![](https://www.b4x.com/android/forum/attachments/139273)  
  
Once verified we know for sure that the request was sent from our app and we know the identity of the signed in user.  
  
**Configuration**  
  
Follow these instructions: <https://firebase.google.com/docs/server/setup#add_firebase_to_your_app>  
Copy the json file to the Files tab.  
  
Simple example:  

```B4X
Sub Process_Globals  
   Private fs As FirebaseServer  
End Sub  
  
Sub AppStart (Args() As String)  
   fs.Initialize("fs", File.OpenInput(File.DirAssets, "B4A-Test1-1878011f6afe.json"))  
   fs.VerifyToken("eyJhbGciOiJSUzI1NiIsImtpZCI6IjE1ZWE4ZDBkMDI1ZDExNGFiNzU0MmQ2OT…")  
   StartMessageLoop  
End Sub  
  
Sub fs_TokenVerified (TokenId As String, Success As Boolean, Token As FirebaseToken)  
   If Success Then  
     Log(Token.DisplayName)  
     Log(Token.Email)  
     Log(Token.Uid)  
   End If  
End Sub
```

  
  
Library: [www.b4x.com/b4j/files/jFirebaseServer.zip](https://www.b4x.com/b4j/files/jFirebaseServer.zip)