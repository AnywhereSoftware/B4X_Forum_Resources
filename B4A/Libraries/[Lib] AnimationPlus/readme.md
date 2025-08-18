### [Lib] AnimationPlus by Informatix
### 11/03/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/21313/)

Hello everybody,  
  
Here's my new baby. The AnimationPlus library extends the Animation library by adding:  

- the [interpolators](http://developer.android.com/reference/android/view/animation/Interpolator.html) (Bounce, Accelerate, Overshoot, Cycle, etc.)
- two parameters:
*PersistAfter* (boolean): if True, the animation does not revert to its initial state
*StartOffset* (long): delay before the animation really starts- AnimationSet (animations on the same view are played together)
- four new Drawables:
*AnimationDrawable*: image-by-image animation
*ClipDrawable*: drawable with automatic clipping (ideal for progress bars)
*LayerDrawable*: multi-layer drawable
*TransitionDrawable*: cross-fade between two drawables- for translation animations:
*PauseTranslation/ResumeTranslation/IsPaused*: new functions to pause/resume the animation
*AnimationRepeat*: new event
List of [properties and methods](http://www.b4x.com/android/forum/threads/lib-animationplus.21313/page-2#post-126666)  
  
If you want a library with more possibilities, and easy to use, give a try to [NineOldAndroids](https://www.b4x.com/android/forum/threads/nineoldandroids.44393/).  
  
[Examples : https://drive.google.com/file/d/0B-kneWWcCy7PUTNERGJIamlzSjA/view?usp=sharing&resourcekey=0-LK97oJs9aV-UHK4CWY0utw](https://drive.google.com/file/d/0B-kneWWcCy7PUTNERGJIamlzSjA/view?usp=sharing&resourcekey=0-LK97oJs9aV-UHK4CWY0utw)