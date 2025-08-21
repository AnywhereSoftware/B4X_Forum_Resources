###  SELECT - don't waste tags by LucaMs
### 10/28/2019
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/110875/)

**[A simple suggestion, not addressed to "experts"]**  
  
I am almost certain that some members, having to identify which view triggered an event, use the tags.  
  
For example:  
  
You have a kind of menu, which is composed of 3 ImageViews:  
  
Dim ivPictures As ImageView  
Dim ivTexts As ImageView  
Dim ivOther As ImageView  
  
which event name is unique, "MenuItem".  
  
One way (quite common, I've read) is to use the tags of those Imageviews.  
You set their tags by Designer:  
  
ivPictures.Tag set to "Pictures"  
ivTexts.Tag set to "Texts"  
ivOther.Tag set to "Other"  
  
Then, in your code you have:  

```B4X
Sub MenuItem_Click  
   Dim IV As ImageView = Sender  
   Select IV.Tag  
      Case "Pictures"  
         '…  
      Case "Texts"  
         '…  
      Case "Other"  
         '…  
    End Select
```

  
  
This way you "waste" the tag property and also, if you will change something, you have to change the source code AND the tags by Designer.  
  
You can much more simply compare the objects, the views:  

```B4X
Sub MenuItem_Click  
   Select Sender  
      Case ivPictures  
         '…  
      Case ivTexts  
         '…  
      Case ivOther  
         '…  
   End Select
```

  
  
  
The same can be applied to groups of views of any kind, obviously, like buttons, for example.