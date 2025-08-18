###  Three state Boolean. Or: Is this Boolean variable initialized? by LucaMs
### 09/17/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/122471/)

***This is a very special snippet, in the sense that I await an approval from Erel or a suggestion on how to do better*** ?  
  
I "need" to use a Boolean variable but not only to check if it is True or False, even if one of these two values has ever been set, that is, that the variable has been initialized.  
  
Unfortunately, a Boolean variable is initialized by default with False; the ideal would be Undefined or similar, instead.  
  
I could use an Object instead of a Boolean, but that too would cause "problems" (you could mistakenly set it with values of any type).  
  
So I think I'll use this:  

```B4X
Type tBoolean(Initialized As Boolean, Value As Boolean)
```

  
  
(and all this very long Snippet ends here ?)  
  
Better (see [USER=97072]@OliverA[/USER]'s post below and [post #4](https://www.b4x.com/android/forum/threads/b4x-three-state-boolean-or-is-this-boolean-variable-initialized.122471/post-765250)):  

```B4X
Type tBoolean(IsTrue As Boolean)
```

  
  
   
  
  
Please, don't mark this post with too many "Like"s ?