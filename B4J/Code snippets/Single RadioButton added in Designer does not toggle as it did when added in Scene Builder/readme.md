### Single RadioButton added in Designer does not toggle as it did when added in Scene Builder by bdunkleysmith
### 07/26/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/167942/)

This started off as a question and I felt like a newby as it was doing my head in, but I solved the problem and thought I'd share it.  
  
I have used single RadioButtons in my projects since I began using B4J many years ago when using Scene Builder was the norm. The single RadioButton would toggle on/off on being clicked and I would use the RadioButton.Selected property to control the application according to my need. These applications continue to work as expected.  
  
However recently I wanted to update an application for which I'd created the layout in Designer, by adding a single RadioButton. To my astonishment I found the RadioButton would not toggle - once selected, it could not be deselected.  
  
Why the different behavior and how to achieve the desired toggling behaviour of a single RadioButton added to a Designer generated layout?  
  
As per this [reference](https://openjfx.io/javadoc/12/javafx.controls/javafx/scene/control/RadioButton.html) "A RadioButton that is not in a ToggleGroup can be selected and unselected" - the functionality I desire. I assume Designer automatically assigns a RadioButton to a ToggleGroup, whereas by default Scene Builder does not and it has to be assigned to a ToggleGroup manually where the functionality of a group of RadioButtons is desired. The solution therefore is to set ToggleGroup property to Null for the RadioButton added via Designer.   
  
Using this [post](https://www.b4x.com/android/forum/threads/slradiobutton-position-radio-button-around-text.75682/) by [USER=9800]@stevel05[/USER] as a reference I implemented this code:  
  

```B4X
'Remove ToggleGroup assigned to this Radiobutton  
Public Sub removeToggleGroup (RB As RadioButton)  
    Dim RBJO As JavaObject = RB  
    RBJO.RunMethod("setToggleGroup",Array(Null))  
End Sub
```

  
  
and so for each single RadioButton in the layout I call:  
  

```B4X
Private RadioButton1 As RadioButton  
  
removeToggleGroup(RadioButton1)
```

  
  
Perhaps this is "well known", but I couldn't find anything while searching the Forum and I can't see how the ToggleGroup property of a RadioButton can be edited in Designer.  
  
Incidentally, ChatGPT kept telling me that I should use a CheckBox rather than a RadioButton because that has my desired functionality, but for consistency of appearance with my previous applications, I'd rather use RadioButtons.