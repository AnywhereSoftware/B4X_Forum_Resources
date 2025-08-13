### Newton Fractals - all in B4J by Johan Schoeman
### 07/29/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/149302/)

USE THE B4J PROJECT IN POST #19 BELOW.  
  
I have converted [**this Github project**](https://github.com/gustavohb/newton-fractals) to a B4J project (a number of B4J classes in the B4J project to match the classes in the Github project). The project is just about 99% B4J but using a bit of JavaObject for "java.awt.Point" and "java.awt.Color". No other external libraries required.  
  
When the B4J project starts the default formula is z^6 -1. It takes a while to draw the fractal so just be patient until the fractal is displayed. You can also edit the formula in the text fields and then click on button "Generate". You can create some very nice looking fractals (code is in the B4J project so amend it to your liking - probably mostly in class NewtonFractal depending on what you want to accomplish).  
  
*There is however something strange (timing wise) that I cannot put my finger on and maybe someone can shed some light on it:  
1. When I run the B4J project for the first time it takes a "long" time to create the image (eg z^6 -1)  
2. Once the image has been rendered I edit/change the formula (eg to z^8 + 15z^4 - 16z^0 —>>> as per image below) without quitting the B4J project and click on Generate again - the image is rendered much FASTER than on the initial run of the B4J project  
3. If I then edit the formula to be the same as the startup formula (z^6 -1) without quitting the B4J project the image is also rendered much FASTER" than when the B4J project runs for the first time.  
  
Why this initial "SLOW" rendering?*  
  
  
  
![](https://www.b4x.com/android/forum/attachments/144161)  
  
![](https://www.b4x.com/android/forum/attachments/144163)  
  
![](https://www.b4x.com/android/forum/attachments/144164)  
  
![](https://www.b4x.com/android/forum/attachments/144167)  
  
![](https://www.b4x.com/android/forum/attachments/144168)  
  
![](https://www.b4x.com/android/forum/attachments/144170)  
  
![](https://www.b4x.com/android/forum/attachments/144171)  
  
![](https://www.b4x.com/android/forum/attachments/144172)  
  
![](https://www.b4x.com/android/forum/attachments/144173)  
  
![](https://www.b4x.com/android/forum/attachments/144174)  
  
![](https://www.b4x.com/android/forum/attachments/144175)  
  
![](https://www.b4x.com/android/forum/attachments/144176)