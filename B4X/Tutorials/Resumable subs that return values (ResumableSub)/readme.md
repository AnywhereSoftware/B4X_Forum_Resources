###  Resumable subs that return values (ResumableSub) by Erel
### 08/25/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/82670/)

Remember that that a call to Sleep or Wait For in a resumable sub [causes the code flow to return to the parent](https://www.b4x.com/android/forum/threads/78601).  
  
Example:  

```B4X
Sub Button1_Click  
Sum(1, 2)  
Log("after sum")  
End Sub  
  
Sub Sum(a As Int, b As Int)  
Sleep(100) 'this will cause the code flow to return to the parent  
Log(a + b)  
End Sub
```

  
Output:  
> after sum  
> 3

  
This is the reason why it is not possible to simply return a value.  
  
**Solution**  
  
Resumable subs can return a new type named ResumableSub. Other subs can use this value to wait for the sub to complete and get the desired return value.  

```B4X
Sub Button1_Click  
   Wait For(Sum(1, 2)) Complete (Result As Int)  
   Log("result: " & Result)  
   Log("after sum")  
End Sub  
  
Sub Sum(a As Int, b As Int) As ResumableSub  
   Sleep(100)  
   Log(a + b)  
   Return a + b  
End Sub
```

  
  
Output:  
> 3  
> result: 3  
> after sum

  
The above Button1\_Click code is equivalent to:  

```B4X
Sub Button1_Click  
   Dim rs As ResumableSub = Sum(1, 2)  
   Wait For(rs) Complete (Result As Int)  
   Log("result: " & Result)  
   Log("after sum")  
End Sub
```

  
  
The steps required are:  
  
1. Add *As ResumableSub* to the resumable sub signature.  
2. Call Return with the value you like to return.  
3. In the calling sub, call the resumable sub with Wait For (<sub here>) Complete (Result As <matching type>)  
  
Notes & Tips  
  
- If you don't need to return a value but still want to wait for the resumable sub to complete then return Null from the resumable sub and set the type in the calling sub to Object.  
- Multiple subs can safely call the resumable sub. The complete event will reach the correct parent.  
- You can wait for resumable subs in other modules (in B4A it is relevant for classes only).  
- The Result parameter name can be changed.