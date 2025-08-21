### Lottie (Render After Effects Animations Natively) by Biswajit
### 05/11/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/117621/)

This is a wrapper for this [Github project](https://github.com/airbnb/lottie-ios/tree/lottie/objectiveC).  
[Click here](https://www.b4x.com/android/forum/threads/lotti.76087/#content) for the B4A wrapper by [USER=42649]@DonManfred[/USER]  
[Here](https://lottiefiles.com/featured) you can find free Lottie animations. Remember to download as Lottie JSON.  
  
**iLottie  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 1  

- **iLottie**

- **Events:**

- **AnimationFinished** (Completed As Boolean)

- **Fields:**

- **AnimationView** As View
- **ASPECT\_FILL\_CONTENT** As Int
- **ASPECT\_FIT\_CONTENT** As Int
- **SCALE\_FILL\_CONTENT** As Int

- **Functions:**

- **AnimationFromFile** (dir As String, filename As String)
*Loads an animation from a specific file path. WARNING Do not use a web URL for file path.*- **AnimationFromJSONString** (JSONString As String)
*Creates an animation from the deserialized JSON String*- **AnimationFromURL** (url As String)
*Loads animation asynchronously from the specified URL*- **Initialize** (Event As String, callback As Object)
*Initialize the library*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Pause**
*Stops the animation at the current frame. The completion block will be called.*- **Play**
*Plays the animation from its current position To the end of the animation.  
The animation will start from its current position.  
If loopAnimation Is YES the animation will Loop from beginning To end indefinitely.  
 If loopAnimation Is NO the animation will Stop And the completion block will be called.*- **PlayFromToFrame** (FromFrame As Int, ToFrame As Int)
*Plays the animation from specific frame To a specific frame.  
The animation will start from its current position.  
If loopAnimation Is YES the animation will Loop start frame To end frame indefinitely.  
 If loopAnimation Is NO the animation will Stop And the completion block will be called.*- **PlayFromToProgress** (FromProgress As Float, ToProgress As Float)
*Plays the animation from specific progress To a specific progress (0 to 1)  
The animation will start from its current position.  
If loopAnimation Is YES the animation will Loop from the startProgress To the endProgress indefinitely  
 If loopAnimation Is NO the animation will Stop And the completion block will be called.*- **PlayToFrame** (ToFrame As Int)
*Plays the animation from its current position To a specific frame.  
The animation will start from its current position.  
If loopAnimation Is YES the animation will Loop from beginning To ToFrame indefinitely.  
 If loopAnimation Is NO the animation will Stop And the completion block will be called.*- **Stop**
*Stops the animation and rewinds to the beginning. The completion block will be called.*
- **Properties:**

- **AnimationDuration** As Float [read only]
*Read only of the duration in seconds of the animation at speed of 1*- **AnimationFrame** As Int
*Sets progress of animation to a specific frame. If the animation is playing it will stop and the completion block will be called.*- **AnimationProgress** As Float
*Sets a progress from 0 - 1 of the animation.  
If the animation is playing it will stop and the completion block will be called.  
The current progress of the animation in absolute time.  
 e.g. a value of 0.75 always represents the same point in the animation, regardless of positive Or negative speed.*- **AnimationSpeed** As Float
*Sets the speed of the animation. Accepts a negative value for reversing animation.*- **AutoReverseAnimation** As Boolean
*The animation will play forward and then backwards if loopAnimation is also TRUE*- **CacheEnable** As Boolean
*Enables or disables caching of the backing animation model. Defaults to TRUE*- **ContentMode** As Int
*Set the content mode to one of the CONTENT constant.*- **IsAnimationPlaying** As Boolean [read only]
*Flag is YES when the animation is playing*- **LoopAnimation** As Boolean
*Tells the animation to loop indefinitely. Defaults is False.*
**Installation:**  

1. Copy XML file to B4I additional library folder.
2. Its recommended to download the framework file directly from the safari of your mac.
3. Copy .framework, .h and .a files to Libs folder of the local build server

**Note:** Set the animation before attaching the view to a parent view.