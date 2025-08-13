### How to write a Tutorial/Snippets/ShareYourCreations by Cableguy
### 01/14/2024
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/158621/)

Hi guys,  
  
I know I am not the most prolific B4R user, but I'm proud to have been the first to post on the "Share Your Creations" of this sub-Forum.  
The mentioned sub-Forums have become more and more cluttered with "here's some code, figure out the rest" kind of posts, from uncommented code, to even code with "un-meaningful" variable names, being by the fact that they're only meaningful in the Author's Language, or simply because they so decided.  
B4R is a special type of sub-Forum, since it combines custom Hardware with tailored Software.  
The simple fact that the same code can be compiled targeting different boards, like the micro, mini, ESP8266, ESP32, etc, presents in itself an amazing challenge… Cross-referencing Pin Outs!  
So, I begun thinking how this important info could be incorporated into our projects….  
It will require some extra work, but even to the Author, it will be time saving, when returning to the project after a few months…  
So… what about this?  

```B4X
' CHIP : ESP32S DEV MODULE  
'*************************************************************************************************************************  
'*                           ________________________                      ______________________                        *  
'*                           |                      |                      |                    |                        *  
'*                         –|   EN          GPIO-23|–                    |  SSD1306 OLED LCD  |                        *  
'*                         –|GPIO-36        GPIO-22|– SCL                |                    |                        *  
'*                         –|GPIO-39        GPIO-01|–                    |                    |                        *  
'*                         –|GPIO-34        GPIO-03|–                    |                    |                        *  
'*                         –|GPIO-35        GPIO-21|– SDA                |____________________|                        *  
'*                         –|GPIO-32        GPIO-19|–                      |     |     |     |                         *  
'*                         –|GPIO-33        GPIO-18|– SWITCH              VCC   GND   SCL   SDA                        *  
'*                         –|GPIO-25        GPIO-05|–                                                                  *  
'*                         –|GPIO-26        GPIO-17|–                           ___                                    *  
'*                         –|GPIO-27        GPIO-16|–                     0—-*   *—-0                              *  
'*                         –|GPIO-14        GPIO-04|–                  SWITCH          GND                             *  
'*                         –|GPIO-12        GPIO-02|–                                                                  *  
'*                         –|GPIO-13        GPIO-15|– Relay#1             ____________________________                 *  
'*                      GND–|   GND         GND    |– GND                 |                          |                 *  
'*                      VCC–|   VIN  _______3V3    |–                     |   2X Relay Module        |                 *  
'*                           |________| USB |_______|                       |                          |                 *  
'*                                                                          |__________________________|                 *  
'*                                                                            |        |       |     |                   *  
'*                                                                         Relay#1  Relay#2   VCC   GND                  *  
'*                                                                                                                       *  
'*                                                                                                                       *  
'*                                                                                                                       *  
'*                                                                                                                       *  
'*                                                                                                                       *  
'*************************************************************************************************************************
```

  
  
In This example, a project I am currently working on, I have an ESP32S Dev Module, a Push-Button, a SSD1306 Oled LCD and a 2xRelay Module.  
The simple fact that if I so decide to connect the ESP32 to any Wifi Network will require me to use the ESP8266wifi library, would completely puzzle me in a few moths if I returned to this project for some reason. Another puzzle would then be, if it was indeed an ESP8266, then the Pin refs would be wrong, except for the SCL pin (4)??? which I can't yet make any sense of it.  
So… This will surely help me, and I hope it will help others create better Tutorials, that even Them will understand months after!