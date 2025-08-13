### Resizing Text Control Custom View - Set text control size based on text - Non Latin Text fix by Andrew (Digitwell)
### 04/19/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/147506/)

There are many occasions when you need to have multiple labels which all size themselves to their contents and also align with each other with no space.  
  
The solution to this is to use MeasureMultiLineText within the StringUtils Library.  
  
To make this easy to use I created a CustomView, ResizingTextControl which you can add to a custom list view or other container and it will resize to its contents.  
  
and made this available to the community.  
  
<https://www.b4x.com/android/forum/threads/how-to-make-views-align-vertically-and-shrink-base-on-dynamic-text-content.133275/#post-935052>  
  
However, on Android, there is a subtle problem using this which occurs with certain fonts on certain phones. MeasureMultiLineText does not appear to work correctly and calculates the wrong size and the text appears clipped.  
  
![](https://www.b4x.com/android/forum/attachments/141328)  
  
[USER=11186]@KZero[/USER] found the solution.  
  
It seems that non latin text may not display correctly unless you set the SetFallbackLineSpacing to False.  
![](https://www.b4x.com/android/forum/attachments/141329)  
  
Doing this resolves the clipping problem.  
![](https://www.b4x.com/android/forum/attachments/141330)  
  
  
Attached is an updated version of the Custom View which incorporates the fix.  
  
You need Phone and Reflection to use on Android.  
  
Selecting the FLS TRUE or FALSE will set the FallBackLineSpacing to TRUE or FALSE and you can see the difference.