### [algorithm] Bresenham Line Algorithm. Linear interpolation. by max123
### 01/19/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/145218/)

Hi developers, Happy New Year !!!  
  
This is a new episode of my [algorithm] Code Snippets.  
<https://www.b4x.com/android/forum/threads/algorithm-first-post-map-a-value-from-one-range-to-another-range-the-simple-way.144391/>  
  
Today I want to show a very interesting algorithm that is used in various fields to calculate the points of a line between start and end point on the cartesian axis.  
  
This algorithm is widely used in various platforms to calculate linear interpolation between two points.  
  
I have found many libraries that make use of this algorithm, including libraries for drawing on screen, it is the basis of many Arduino libraries that handle TFTs, OLEDs and so on.  
  
It is also widely used to manage cartesian CNC machines movements, such as 3D printers, CNC milling machines, laser cutters, foam cutters, plasma cutters, etc… Almost all of these machines use stepper motors (with microsteps) to generate precise rotational movements which, coupled with worms or belts transfer rotary motion into linear motion. In some of these machines there are only 2 axes, X and Y movement, and linear interpolation is calculated on the two cartesian axes, in other machines there is an addictional Z axis which allows the three-dimensionality of the machined object, in this case 3 axes are interpolated at same time, for example it is completely legal to move to any 3D point and everything will be done by creating an imaginary line from the starting XYZ point to the end XYZ point and the machine will move the 3 axes simultaneously interpolating them. That said, there are more complex CNCs that use up to 5 axes of linear motion, even with rotational axis.  
  
The CNC topic is very vast and it is not my intention to go into it on this topic, instead I want to focus on the algorithm itself.  
  
I personally used this interesting algorithm to create a firmware that manage the movements of a CNC (3D printer) and to write various libraries for ESP8266, ESP32, Arduino of some TFTs that do not support the hardware drawing of a line by passing it start and end coordinates but need to draw point by point calculated by software side.  
  
This algorithm can be used to locate a specific point on a line at a known distance from its start or end.  
  
Today I want to show you this technique in a visual way, that is by **drawing lines point by point** on a Canvas **without using the Canvas.DrawLine function**, the same algorithm can then be used in other areas.  
  
Here ends my somewhat spartan explanation of what the Bresenham algorithm does…  
I attached a B4J project to be convenient, but this is adaptable to any platform.  
As you can see the code is very simple and easly adaptable to any platform and language.  
  
**Because I use this on many of my projects, and this is called sometime 500.000 and more times every second, so very intensive work, I need to optimize i****t's speed, in particular on B4X side I used Abs function that maybe slow down a bit. Just change some instructions here can do a difference. Please contribute to optimize it in speed to be as fast possible.**  
  
Have fun !!!