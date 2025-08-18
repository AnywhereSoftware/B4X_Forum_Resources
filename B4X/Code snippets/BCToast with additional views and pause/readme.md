###  BCToast with additional views and pause. by MrKim
### 06/22/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/131865/)

I like BCToast but frequently for us they are used as an educational tool to tell the user what to do next or confirm that he has accomplished a task, etc.  
After you are more experienced you may not want to be "batting down" these messages any more so I can add a button or check box "Don't Show This Again".  
![](https://www.b4x.com/android/forum/attachments/115324)  
So I modified Erel's BCToast so you can add additional views - for me it is buttons but it can be anything.  
It also extends the length of time the message stays on the screen if you click/tap it.  
I deliberately did not write it as a drop in replacement since someone might want both.  
**If you are not passing a view just pass Null as the second parameter.**  
  
The attached zip contains the B4Xlib and a sample program.