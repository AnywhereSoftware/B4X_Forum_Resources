### New library for b4J: Firebase, Upload, Files, SQL, Thymeleaf,  Bytes, String, Security, Double by tummosoft
### 01/28/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/148068/)

Allow me to introduce you to the library that I am developing for use in our clients' web app projects.  
Currently, the library is still under development, but I will introduce a few small components first and will gradually update them in the future.  

- Part 1: Firebase Services class for jServer

**1- Below is the JavaScript code when the user clicks on the button to log in with their Facebook or Google account.**  
  

```B4X
 <script src="https://www.gstatic.com/firebasejs/8.0.0/firebase-app.js"></script>  
  <script src="https://www.gstatic.com/firebasejs/8.0.0/firebase-auth.js"></script>  
   
  <script>  
    var firebaseConfig = {  
      apiKey: "…",  
      authDomain: "…",  
      projectId: "…",  
      appId: "…"  
    };  
    firebase.initializeApp(firebaseConfig);  
  </script>  
   
  <script>  
   
function signInWithGoogle() {  
  var provider = new firebase.auth.GoogleAuthProvider();  
  firebase.auth().signInWithPopup(provider)  
    .then((result) => {  
      firebase.auth().currentUser.getIdToken(true).then(function(idToken) {  
          var token = idToken;  
          b4j_raiseEvent('event_register', {tk:token});  
      }).catch(function(error) {  
   
      });  
    })  
    .catch((error) => {  
   
    });  
}  
// Facebook sign-in function  
function signInWithFacebook() {  
  var provider = new firebase.auth.FacebookAuthProvider();  
  firebase.auth().signInWithPopup(provider)  
    .then((result) => {  
      firebase.auth().currentUser.getIdToken(true).then(function(idToken) {  
        var token = idToken;  
        b4j_raiseEvent('event_register', {tk:token});  
      }).catch(function(error) {  
   
      });  
    })  
    .catch((error) => {  
    });  
}  
  
  </script>
```

  
  
**2-Next, we will add the necessary libraries to the project.**  
  

```B4X
#AdditionalJar: commons-codec-1.3.jar  
#AdditionalJar: commons-compress-1.21.jar  
#AdditionalJar: commons-io-2.11.0.jar  
#AdditionalJar: commons-logging-1.1.1.jar  
#AdditionalJar: firebase-admin-9.2.0.jar  
#AdditionalJar: google-api-client-1.21.0.jar  
#AdditionalJar: google-http-client-1.19.0.jar  
#AdditionalJar: google-http-client-gson-1.21.0.jar  
#AdditionalJar: google-http-client-jackson2-1.19.0.jar  
#AdditionalJar: gson-2.6.2.jar  
#AdditionalJar: guava-jdk5-17.0.jar  
#AdditionalJar: httpclient-4.0.1.jar  
#AdditionalJar: httpcore-4.0.1.jar  
#AdditionalJar: google-oauth-client-1.21.0.jar  
#AdditionalJar: jackson-core-2.1.3.jar  
#AdditionalJar: javax.inject-1.jar  
#AdditionalJar: json-20160212.jar  
#AdditionalJar: jsr305-1.3.9.jar  
#AdditionalJar: xz-1.9.jar  
#AdditionalJar: snappy-0.4.jar  
#AdditionalJar: slf4j-api-1.7.36.jar  
#AdditionalJar: sisu-inject-plexus-1.4.2.jar  
#AdditionalJar: sisu-inject-bean-1.4.2.jar  
#AdditionalJar: api-common-2.12.0.jar  
#AdditionalJar: google-auth-library-oauth2-http-1.19.0  
#AdditionalJar: google-auth-library-credentials-1.19.0.jar  
#AdditionalJar: guava-23.2-jre
```

  
  
**3- When we receive the user token from Firebase, we will send the token to a socket server for verification.**  
  

```B4X
Sub event_register(variable As Map)  
    Log("CONNECTED")  
    Dim token As String = variable.Get("tk")  
   
    Log(token)  
    Dim firetoken As jFirebaseAuthWrapper  
    Dim auth As String = File.Combine(File.DirApp, "firebase.json")  
    firetoken.Initialize("firebaseauth", auth)  
    firetoken.verifyIdToken(token)  
End Sub  
  
Sub firebaseauth_tokenverified (Token As Map)  
    Log(Token.Get("getEmail"))  
    Log(Token.Get("getIssuer"))  
    Log(Token.Get("getName"))  
    Log(Token.Get("getPicture"))  
    Log(Token.Get("getTenantId"))  
    Log(Token.Get("getUid"))  
    Log(Token.Get("isEmailVerified"))  
    'https://thienvienphuocson-69b69-default-rtdb.asia-southeast1.firebasedatabase.app  
End Sub  
Sub event_register(variable As Map)  
    Log("CONNECTED")  
    Dim token As String = variable.Get("tk")  
   
    Log(token)  
    Dim firetoken As jFirebaseAuthWrapper  
    Dim auth As String = File.Combine(File.DirApp, "firebase.json")  
    firetoken.Initialize("firebaseauth", auth)  
    firetoken.verifyIdToken(token)  
End Sub  
  
Sub firebaseauth_tokenverified (Token As Map)  
    Log(Token.Get("getEmail"))  
    Log(Token.Get("getIssuer"))  
    Log(Token.Get("getName"))  
    Log(Token.Get("getPicture"))  
    Log(Token.Get("getTenantId"))  
    Log(Token.Get("getUid"))  
    Log(Token.Get("isEmailVerified"))  
    'https://thienvienphuocson-69b69-default-rtdb.asia-southeast1.firebasedatabase.app  
End Sub
```

  
  
\* Extend java library: [MEDIA=googledrive]1\_iLv\_vmAeHt9\_QI6Yiswj6nkrp5IhoGA[/MEDIA]  
\* Extend java library for jFileSupport, jByteSupport, jDoubleSupport, jFileSupport, jSecuritySupport:  
[MEDIA=googledrive]1LfFh1KWbz3lGbPMLGDRZqxjPE65\_SdM5[/MEDIA]  
  
**Source code here:** <https://github.com/tummosoft/jFileSupport>