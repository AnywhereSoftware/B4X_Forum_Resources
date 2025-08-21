### BCColorPicker - nice color picker by Erel
### 03/02/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/114368/)

![](https://www.b4x.com/basic4android/images/K1EiGqbdWu.gif)  
(this is an animated gif, it looks better in real use)  
  
This is a powerful color picker, based on XUI Views B4XColorTemplate. It is a B4J control, though it should be simple to port it to B4A and B4i.  
Note that it uses the new CLVSelections class: <https://www.b4x.com/android/forum/threads/b4x-clvselections-extended-selection-modes-for-xcustomlistview.114364/#post-714398>  
  
Usage is simple, add with the designer and handle the ColorSet event.  
  
Depends on: XUI Views and ByteConverter  
  
Note that it runs better in release mode due to the many TextChanged event that are raised internally.  
  
**Updates:**  
v1.02 - Bug fixes and improvements