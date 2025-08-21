### jTextFormatter by stevel05
### 05/25/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/76438/)

In Javafx Version 8u40 a TextFormatter was introduced. This allows access to text input **before** any of the keypressed events are fired. Pasted text is also captured.  
  
This makes it a lot easier to validate and format text input.  
  
This wrapper is based on the example here: <https://uwesander.de/?p=203>  
  
Documentation is here:  
<https://docs.oracle.com/javase/8/javafx/api/javafx/scene/control/TextFormatter.html>  
<https://docs.oracle.com/javase/8/javafx/api/javafx/scene/control/TextFormatter.Change.html>  
  
The proposed change to the text is passed to a callback sub, within which you can validate and amend the change (or entire text) as required, then return the amended change object, or Null to reject the change.  
  
Commented examples are in the attached project, which can be compiled to a library if required.  
  
294