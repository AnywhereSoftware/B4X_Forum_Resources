###   AnimationClock – Display-synchronized animation timer for B4J and B4A by knutf
### 06/03/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171167/)

AnimationClock raises a Tick event once per display frame, providing the elapsed time since the previous frame in microseconds. On B4J it uses JavaFX AnimationTimer; on B4A it uses Android Choreographer. The event is always raised on the UI thread, so it is safe to update views directly in the handler.  
  
  
Works in both debug and release mode. Note that in debug mode the timing may not be fully synchronized with the display refresh.  
  
  
To run the demo project, place AnimationClock.b4xlib in your additional libraries folder and make sure AnimationClock is checked in the Libraries Manager.  
  
  
The b4xlib (single class) and a demo project are attached.