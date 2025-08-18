### [BANano] [SOLVED] What is the right way to use BANano.WaitFor? by Mashiane
### 02/04/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/127285/)

Ola  
  
This post here bears reference, <https://www.b4x.com/android/forum/threads/banano-resumeable-sub-sort-of.100500/#content>  
  
I am wondering…  
  
1. Can one define a ???Wait method that can have a BANanoPromise inside it or even a BANanoFetch inside it ? for example.  
  

```B4X
public Sub GetFBTokenWait(resolve As Object)  
    Dim stoken As String = ""  
    Dim tThen As Object  
    Dim tErr As Map  
    Dim token As BANanoPromise = firebase.messaging.getToken  
    token.Then(tThen)  
    stoken = tThen  
    token.Else(tErr)  
    stoken = ""  
    token.End  
    banano.Resolve(stoken)  
End Sub
```

  
  
Update: This is transpiled to  
  

```B4X
// [461] public Sub GetFBTokenWait(resolve As Object)   
this.getfbtokenwait=async function(_resolve) {  
if (_B==null) _B=this;  
var _m,_tthen,_terr,_token;  
// [462]  Dim m As Map = CreateMap()   
_m={};  
// [463]  Dim tThen As Object   
_tthen={};  
// [464]  Dim tErr As Map   
_terr={};  
// [465]  Dim token As BANanoPromise = firebase.messaging.getToken   
_token=_B._firebase._messaging.gettoken();  
// [466]  token.Then(tThen)   
_token.then(function(_tthen) {  
// [467]  Log(tThen)   
console.log(_tthen);  
// [468]  m.Put( {220} , tThen)   
_m["token"]=_tthen;  
// [469]  token.Else(tErr)   
}).catch(function(_terr) {  
// [470]  m.Put( {221} , {222} )   
_m["token"]="";  
// [471]  token.End   
});  
// [472]  banano.Resolve(m)   
_resolve(_m);  
// End Sub  
};
```

  
  
  
And then call it like this?  
  

```B4X
Dim fbToken As String = ""  
banano.WaitFor(fbToken, Me, "getfbtokenwait", Null)  
Log("Wait response: " & fbToken)
```

  
  
Update: This is being transpiled to:  
  

```B4X
// [377]  Dim fbTokenResult As Map   
_fbtokenresult={};  
// [378]  banano.WaitFor(fbTokenResult, Me, {193} , Null)   
_fbtokenresult=await new Promise(function(resolve) {_B[("getfbtokenwait").toLowerCase()](resolve)});  
// [379]  Log( {194} & fbTokenResult)   
console.log("Wait response: "+_fbtokenresult);
```

  
  
Whilst in debug mode I am getting a blank response, in release mode Im getting…  
  

```B4X
Uncaught (in promise) ReferenceError: _resolve is not defined
```

  
  
I'm sure i'm doing something wrong somewhere and could use some green lights on this.  
  
Thanks