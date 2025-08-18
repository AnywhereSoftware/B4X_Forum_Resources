### [BANano] why you might need parseBool by Mashiane
### 06/26/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/132013/)

Ola  
  
I use a lot of parseInt and parseFloat when I code because even when I define the variables as Int, Double, Float etc, somewhere somehow mistakes happen, you find your app not working and then simply using parseInt and parseFloat helps you along. Its my safe method to ensure quality.  
  
So how did parseBool happen?  
  
Im creating a custom view, i set one of the properties to String, then later change my mind and make it bool because I want to just check it. So I would think  
  

```B4X
dim bHidden As Boolean  
bHidden = Props.GetDefault("Hidden", False)
```

  
  
would work for me?  
  
In my code I am doing a convertion to  
  

```B4X
x = not(bHidden)
```

  
  
I run my app, nothing happens, blank screen. I resave the layout. nothing happens. In my code I force Hidden to be False with Hidden = False, the apps works. Problem is, this is the default behavior.  
  
So I run GetType(bHidden) just after bHidden = Props(?), guess what, its a string with a capital False, the boolean one is smaller f, so my x = not(bHidden) will just never work!!! Phew  
  

```B4X
Sub parseBool(v As Object) As Boolean  
    If BANano.IsNull(v) Or BANano.IsUndefined(v) Then  
        v = False  
    End If  
    If GetType(v) = "string" Or GetType(v) = "object" Then  
        Dim s As String = v & ""  
        s = s.tolowercase  
        If s = "false" Then Return False  
        If S = "true" Then Return True  
    End If  
    Return v  
End Sub
```

  
  
So my updated code, that kills this bug on my webapp, is for example  
  

```B4X
bHidden = Props.GetDefault("Hidden", False)  
bHidden = BANanoShared.parseBool(bHidden)
```

  
  
Now everything is working like a charm.