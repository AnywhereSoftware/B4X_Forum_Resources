###  Public variables, custom types, ... by LucaMs
### 12/19/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/158084/)

What I'm about to write would be more suitable for Erel's thread: [[B4X] "Code Smells" - common mistakes and other tips](https://www.b4x.com/android/forum/threads/b4x-code-smells-common-mistakes-and-other-tips.116651/), but it's just my opinion and I don't know if he agrees.  
  
I'll give you an example right away:  
  
![](https://www.b4x.com/android/forum/attachments/148824)  
  
clmn is a B4XTableColumn; what its InternalSortMode is? What values should I assign to it? (create constants, for this; better an Enum). There is no comment.  
  
The lack of a comment may not be due to the author's lack of time or laziness (the author is Erel ? He will kill me for this, or he will block me forever?), but to having used a public variable to which it is not possible to associate comment lines.  
  
It is also not possible to associate comments with the elements of a custom type.  
  
Also for this reason, it is preferable to create Properties ("special" public Subs) rather than public variables in your classes.  
For the same reason, it is preferable to create classes rather than custom types.  
  
The comments are useful to everyone, even to the author himself who, over time, will forget what a certain member of a class that he himself wrote is for.