### fire animation immediately by christoforos tsagas
### 03/10/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/146686/)

object starting position left upper corner of screen  
how to make it so that after the animation animated object stays still and immediately animates again moving first from left to right start of screen to end and after the ending position immediately move from top to bottom   
  
  
  
Sub Globals  
 'These global variables will be redeclared each time the activity is created.  
 Private label As Label  
   
 Private Button2 As Button  
End Sub  
  
Sub Activity\_Create(FirstTime As Boolean)  
 Activity.LoadLayout("Layout")  
  
End Sub  
  
Sub Activity\_Resume  
  
End Sub  
  
Sub Activity\_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub Button2\_Click  
 Dim anim As Animation  
 anim.InitializeTranslate("TranslationX", 0, Activity.Width - label.Width,0,100)  
 anim.Duration = 1000   
 label.Tag = anim   
 anim.Start(label)   
End Sub