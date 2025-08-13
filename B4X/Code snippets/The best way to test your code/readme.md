###  The best way to test your code by Brian Michael
### 06/15/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/161667/)

Hello, this post is more of an advice or guide for new developers.  
Here I come to give you a brief demonstration of how you should structure your projects.  
  
While it is true that B4X give us an approximate log of what the error is, it is often difficult for us to determine where it is located, or from which function exactly the error is executed.  
That's why I'm here to share this way of organizing your project logs.  
  
  
First of all, it is good to create a variable in each of your modules that indicates the name of your module.  
Ex.  

```B4X
Sub Process_Globals  
Public Const MODULE_NAME as String = "Custom"  
End Sub
```

  
  
Then have the same format for all your functions:  
Ex.  

```B4X
Public Sub Math(n1 as Long, n2 as Long) as Long  
Try  
  
'Declare the name of the function in a variable internal to the function and show the values that your function is receiving.  
'Ex.  
Dim FUNCTION_NAME as String = $"Math(${n1},${n2})"$  
  
'YOUR CODE  
'< / >  
  
Catch  
'Here you log your result with this format:  
Log($"[${MODULE_NAME}]: | ${FUNCTION_NAME} | ${LastExeption}"$  
End Try  
End Sub
```

  
  
This way you will have better possibilities to debug your code when having a large project with many modules and lines of code.  
  
  
In the end you will have a result like:   
  
> **[Custom]: | Math(1,A) | Your Code is not working.**