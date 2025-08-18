### [B4x] Display 2 dialogs by stevel05
### 11/06/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/124284/)

Description:  
A while ago there was a thread discussing how to show 2 dialogs at the same time (one over the other) which I couldn't find. The solution there (as far as I remember) was to modify the B4xDialog code inline with B4xPreferenceDialog, so that two dialogs could co-exist.  
  
I needed this functionality recently and came up with another solution. Provided that the second dialog needs to be no larger than the first, it is possible to initialize the second dialog on the base pane of the first. I have used this method for a while and haven't come across any problems with it.  
  
So when you need a second dialog over the first:  
  

```B4X
Dim Dialog2 As B4XDialog  
Dialog2.Initialize(Dialog.Base)  
Dialog2.Title = "Dialog2"  
Wait For (Dialog2.Show("This is Dialog2","Done","","")) Complete (Resp As Int)
```

  
  
I hope this is useful.  
  
Edit: original thread is here : <https://www.b4x.com/android/forum/threads/b4x-solved-2-instances-of-b4xdialog-in-the-same-activity-show-the-2nd-above-the-1st.113085/post-705230>  
  
Tags: B4xDialog display 2 two