### Intent Skype Call by MarcoRome
### 03/29/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/73396/)

With this intent you can call in direct mode user into Skype:  
  

```B4X
Dim skypeId As String = "devil-app"  
Dim collegati As String = "skype:" & skypeId & "?call"  
Dim skype As Intent  
skype.Initialize(skype.ACTION_VIEW, collegati)  
skype.SetComponent("com.skype.raider")  
StartActivity(skype)
```