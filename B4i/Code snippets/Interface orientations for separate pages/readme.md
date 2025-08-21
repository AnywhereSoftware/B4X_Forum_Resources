### Interface orientations for separate pages by Semen Matusovskiy
### 05/31/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/118445/)

Usage.  
1) Add pageOrientation module to your project.   
2) After each ShowPage call setInterfaceOrientations function. For example, pageOrientations.setInterfaceOrientations (Page2, "LandscapeLeft, LandscapeRight")  
3) If you want to ignore invalid orientation (let's say, in Page\_Resize event), check getCurrentInterfaceOrientation value.  
  
To disable animation during rotation, assign pageOrientations.isRotateAnimationEnabled = False.