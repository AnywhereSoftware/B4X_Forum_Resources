### Android View Animations Library by Pendrush
### 10/08/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/134920/)

Original library: <https://github.com/daimajia/AndroidViewAnimations>  
  
v1.10 - Added: PivotX, PivotY, RepeatMode (restart animation, reverse animation)  
  
  
![](https://www.b4x.com/android/forum/proxy.php?image=https%3A%2F%2Fcamo.githubusercontent.com%2Fc41223966bdfed2260dbbabbcbae648e5db542c6%2F687474703a2f2f7777332e73696e61696d672e636e2f6d773639302f3631306463303334677731656a37356d69327737376732306333306a623471722e676966&hash=6f3d793d108628f90b738a6d56b1c9c8)  
  
[HEADING=2]Effects[/HEADING]  
  
[HEADING=3]Attension[/HEADING]  
Flash, Pulse, RubberBand, Shake, Swing, Wobble, Bounce, Tada, StandUp, Wave  
  
[HEADING=3]Special[/HEADING]  
Hinge, RollIn, RollOut, Landing, TakingOff, DropOut  
  
[HEADING=3]Bounce[/HEADING]  
BounceIn, BounceInDown, BounceInLeft, BounceInRight, BounceInUp  
  
[HEADING=3]Fade[/HEADING]  
FadeIn, FadeInUp, FadeInDown, FadeInLeft, FadeInRight  
FadeOut, FadeOutDown, FadeOutLeft, FadeOutRight, FadeOutUp  
  
[HEADING=3]Flip[/HEADING]  
FlipInX, FlipOutX, FlipOutY  
  
[HEADING=3]Rotate[/HEADING]  
RotateIn, RotateInDownLeft, RotateInDownRight, RotateInUpLeft, RotateInUpRight  
RotateOut, RotateOutDownLeft, RotateOutDownRight, RotateOutUpLeft, RotateOutUpRight  
  
[HEADING=3]Slide[/HEADING]  
SlideInLeft, SlideInRight, SlideInUp, SlideInDown  
SlideOutLeft, SlideOutRight, SlideOutUp, SlideOutDown  
  
[HEADING=3]Zoom[/HEADING]  
ZoomIn, ZoomInDown, ZoomInLeft, ZoomInRight, ZoomInUp  
ZoomOut, ZoomOutDown, ZoomOutLeft, ZoomOutRight, ZoomOutUp  
  
  
> **AndroidViewAnimations  
>   
> Author:** Author: daimajia - B4a Wrapper: Pendrush  
> **Version:** 1.10  
>
> - **AndroidViewAnimations**
>
> - **Events:**
>
> - **AnimationCancel**
> - **AnimationEnd**
> - **AnimationStart**
>
> - **Fields:**
>
> - **INTERPOLATOR\_ACCELERATE** As Int
> - **INTERPOLATOR\_ACCELERATE\_DECELERATE** As Int
> - **INTERPOLATOR\_ANTICIPATE** As Int
> - **INTERPOLATOR\_ANTICIPATE\_OVERSHOOT** As Int
> - **INTERPOLATOR\_BOUNCE** As Int
> - **INTERPOLATOR\_DECELERATE** As Int
> - **INTERPOLATOR\_LINEAR** As Int
> - **REPEAT\_MODE\_RESTART** As Int
> - **REPEAT\_MODE\_REVERSE** As Int
> - **TECHNIQUES\_BOUNCE** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_BOUNCE\_IN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_BOUNCE\_IN\_DOWN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_BOUNCE\_IN\_LEFT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_BOUNCE\_IN\_RIGHT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_BOUNCE\_IN\_UP** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_DROPOUT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FADE\_IN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FADE\_IN\_DOWN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FADE\_IN\_LEFT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FADE\_IN\_RIGHT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FADE\_IN\_UP** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FADE\_OUT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FADE\_OUT\_DOWN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FADE\_OUT\_LEFT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FADE\_OUT\_RIGHT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FADE\_OUT\_UP** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FLASH** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FLIP\_IN\_X** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FLIP\_IN\_Y** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FLIP\_OUT\_X** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_FLIP\_OUT\_Y** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_HINGE** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_LANDING** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_PULSE** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROLL\_IN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROLL\_OUT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROTATE\_IN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROTATE\_IN\_DOWN\_LEFT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROTATE\_IN\_DOWN\_RIGHT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROTATE\_IN\_UP\_LEFT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROTATE\_IN\_UP\_RIGHT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROTATE\_OUT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROTATE\_OUT\_DOWN\_LEFT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROTATE\_OUT\_DOWN\_RIGHT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROTATE\_OUT\_UP\_LEFT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ROTATE\_OUT\_UP\_RIGHT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_RUBBER\_BAND** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_SHAKE** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_SLIDE\_IN\_DOWN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_SLIDE\_IN\_LEFT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_SLIDE\_IN\_RIGHT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_SLIDE\_IN\_UP** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_SLIDE\_OUT\_DOWN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_SLIDE\_OUT\_LEFT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_SLIDE\_OUT\_RIGHT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_SLIDE\_OUT\_UP** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_STAND\_UP** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_SWING** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_TADA** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_TAKING\_OFF** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_WAVE** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_WOBBLE** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ZOOM\_IN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ZOOM\_IN\_DOWN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ZOOM\_IN\_LEFT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ZOOM\_IN\_RIGHT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ZOOM\_IN\_UP** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ZOOM\_OUT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ZOOM\_OUT\_DOWN** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ZOOM\_OUT\_LEFT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ZOOM\_OUT\_RIGHT** As com.daimajia.androidanimations.library.Techniques
> - **TECHNIQUES\_ZOOM\_OUT\_UP** As com.daimajia.androidanimations.library.Techniques
>
> - **Functions:**
>
> - **Animate** (View As Object)
> *Start animation on specific view.*- **Initialize** (EventName As String)
> *Initialize library   
>  AndroidViewAnimations1.Interpolator = AndroidViewAnimations1.INTERPOLATOR\_ACCELERATE\_DECELERATE  
>  AndroidViewAnimations1.RepeatTimes = 3  
>  AndroidViewAnimations1.Duration = 1200  
>  AndroidViewAnimations1.Delay = 0  
>  AndroidViewAnimations1.RepeatMode = AndroidViewAnimations1.REPEAT\_MODE\_REVERSE  
>  AndroidViewAnimations1.PivotX = 500  
>  AndroidViewAnimations1.PivotY = -100  
>  AndroidViewAnimations1.Techniques = AndroidViewAnimations1.TECHNIQUES\_FLIP\_IN\_X  
>  AndroidViewAnimations1.Animate(Label1)*- **IsInitialized** As Boolean
> - **IsRunning** As Boolean
> *Check if animation is running.*- **IsStarted** As Boolean
> *Check if animation is started.*- **Stop** (Reset As Boolean)
> *Stop animation.  
>  If Reset is True, view will reset position, size, color, etc.  
>  You can use Stop(True) on event AnimationEnd to reset view after animation is finished.*
> - **Properties:**
>
> - **Delay** As Long [write only]
> *Set delay in milliseconds.*- **Duration** As Long [write only]
> *Set duration in milliseconds.*- **Interpolator** As Int [write only]
> *Set Interpolator  
>  Use one of INTERPOLATOR constants*- **PivotX** As Float [write only]
> *Set Pivot X.*- **PivotY** As Float [write only]
> *Set Pivot Y.*- **RepeatMode** As Int [write only]
> *Use one of REPEAT\_MODE constants  
>  REPEAT\_MODE\_RESTART = Restart animation.  
>  REPEAT\_MODE\_REVERSE = Reverse animation.*- **RepeatTimes** As Int [write only]
> *Specify the number of times the animation will be repeated.  
>  Set 0 for infinite loop.*- **Techniques** As com.daimajia.androidanimations.library.Techniques [write only]
> *Set animation techniques.  
>  Use one of TECHNIQUES constants.*