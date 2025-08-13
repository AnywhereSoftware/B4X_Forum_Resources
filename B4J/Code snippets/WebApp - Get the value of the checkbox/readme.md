### WebApp - Get the value of the checkbox by hatzisn
### 11/10/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/144043/)

Good morning everyone,  
  
I was trying to get the value of a checkbox in a WebApp and I was not able with the methods described in some threads. This is because no matter if I was checking it there was no attribute checked in the tag of the checkbox. Googling it I found that the correct method in JQuery is the following:  
  

```B4X
    Dim feat As Future = chkokupdated.RunMethodWithResult("is", Array(":checked"))  
    If feat.Value.As(String) = "true" Then  
  
    End if
```