### B4x pages GetStartingIntent by Michael2150
### 07/21/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/120416/)

When you're trying to get the starting intent of the activity from a B4xPage class object, add this sub to the activity you want to get the Intent from:  
  

```B4X
Public Sub GetStartingIntent as Intent  
    return Activity.GetStartingIntent  
End Sub
```

  
  
And when you need to get it in the B4xPage call it with:   
  

```B4X
Dim obj as Object = CallSub(Activity,"GetStartingIntent")  
Dim i as Intent = obj
```