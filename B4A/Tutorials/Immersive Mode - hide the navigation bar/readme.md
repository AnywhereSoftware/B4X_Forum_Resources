### Immersive Mode - hide the navigation bar by Erel
### 01/05/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/90882/)

Immersive mode means full screen mode where the navigation bar is also hidden.  
  
The user can bring back the bars by swiping near the edges.  
  
The required steps are:  
  
1. Call setSystemUiVisibility with the immersive flags. This is done in Activity\_WindowFocusChanged.  
2. Get the full display size and set the activity to that size.  
3. Load the layout  
  
Depends on JavaObject and Phone libraries.  
  
Example is attached.