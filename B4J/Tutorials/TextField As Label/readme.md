### TextField As Label by stevel05
### 08/30/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/149913/)

This one was born out of frustration that in Javafx, you can't make a label's text selectable. This is a Textfield, that is styled as a label. with the added bonus that you can click the label to edit the text (which can be disabled) and would be useful to use in a data table or list where you may want to edit the field.  
  

![](https://www.b4x.com/android/forum/attachments/145366) ![](https://www.b4x.com/android/forum/attachments/145367) ![](https://www.b4x.com/android/forum/attachments/145368)

  
  
You can also make the TextfieldAsLabel focus traversable (or not) and match the left padding to a Textfield (left padding = 9) or a label (left padding = 0).  
  

![](https://www.b4x.com/android/forum/attachments/145365)

  
  
I have delegated the events for a Textfield, but not all of them from a label. They can easily be added if required.  
  
There is a small CSS file called textfieldlabel.css that is required and is in the project and the b4xlib. This should be added to the Stylesheets on a Form or a Pane in the appropriate place.  
  
There are no external dependencies.  
  
Enjoy.