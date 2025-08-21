### Adafruit Motor Shield - Microstepping by Mark Read
### 07/24/2020
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/120529/)

This is not really a tutorial, just a small piece of information regarding the microstepping.  
  
With respect to the library from Erel: <https://www.b4x.com/android/forum/threads/radafruitmotorshield-v2.69089/>  
  
Microstepping is set in the ".h" file, as default, to 16 steps. If you wish to change this, edit the file "Adafruit\_MotorShield.h" and change the value on line 26. Values of 8 or 16 are allowed.  
  

```B4X
/******************************************************************  
 This is the library for the Adafruit Motor Shield V2 for Arduino.   
 It supports DC motors & Stepper motors with microstepping as well  
 as stacking-support. It is *not* compatible with the V1 library!  
  
 It will only work with https://www.adafruit.com/products/1483  
   
 Adafruit invests time and resources providing this open  
 source code, please support Adafruit and open-source hardware  
 by purchasing products from Adafruit!  
   
 Written by Limor Fried/Ladyada for Adafruit Industries.  
 BSD license, check license.txt for more information.  
 All text above must be included in any redistribution.  
 ******************************************************************/  
  
#ifndef _Adafruit_MotorShield_h_  
#define _Adafruit_MotorShield_h_  
  
#include <inttypes.h>  
#include <Wire.h>  
#include "Adafruit_MS_PWMServoDriver.h"  
  
//#define MOTORDEBUG  
  
#define MICROSTEPS 16         // 8 or 16   <== CHANGE THIS
```

  
  
The file can be found, when you download the library, in the directory "rAdafruitMotorShieldV2"  
  
Compared to the style "stepper.STYLE\_SINGLE" or "stepper.STYLE\_DOUBLE", the movement is very smooth.   
  
\*\*\* Also don't forget, the step command blocks the main thread \*\*\*