### Label Justification Mode by mismail
### 05/29/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/131180/)

Ok, Good morning to all. It's a small tiny snippet that frustrated me for many years and VOILA today morning I found, so simply the solution that was so simple and silly.  
So, decided to share to rescue developers' lives.  
To justify text within the label just use the Reflector library and one line of code:  
 [ReflectorObject].Target = [LabelView]  
 [ReflectorObject].RunMethod2("setJustificationMode", 1, "java.lang.int")  
  
That's it. So silly not?