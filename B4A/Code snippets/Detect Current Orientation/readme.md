### Detect Current Orientation by DawningTruth
### 09/22/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/109833/)

With reference to this thread:  
  
<https://www.b4x.com/android/forum/threads/detect-current-orientation.109829/>  
  
This sub will assist you to determine the current orientation of your activity.  
  
I noticed that the solutions to this one on the forum are quite complicated or resource intensive. Here is a Sub you can use, which is very simple and uses minimal resources. Hope it helps :) someone.  
  

```B4X
Sub DetermineCurrentScreenOrientation As String  
   
    Dim orientation As String  
   
    If Activity.Height > Activity.Width Then  
        orientation = "portrait"  
    Else  
        orientation = "landscape"  
    End If  
   
    Return orientation  
   
End Sub
```