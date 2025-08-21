### Burn bootloader to ATMega328P-PU with an Arduino Uno by hatzisn
### 03/23/2020
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/115286/)

This is by 99% a tutorial and by 1% a question. The file in the link contains some notes for me I devised from a lot of tutorials on how to burn a bootloader to a ATMEGA328P-PU wired on a breadboard. See also the tutorial "Shrink your Arduino project to the minimum".  
  
In order to understand the tutorial you will have to replace the "Non Working Arduino" with the ATMEGA328P-PU Circuit (2nd page/3d picture) and connect the proper pins 10,11,12,13 of the Working Arduino (with 1,17,18,19 pins respectively of the ATMEGA328P-PU microcontroller - in 2nd page/2nd picture). Thus from the 2nd page/3d picture you will have to remove the connection of Pin 1 of microcontroller to the Vcc through the resistor and connect it to Pin 10 of the Arduino Uno (please someone verify this last sentence and let me know).  
  
My question is the following: In 1st Page/2nd picture the grey cable that connects the Gnd with RESET in the working Arduino is a single cable or it is connected through something. It was not clear in the tutorial and in fact it was not mentioned at all. Does anyone have this required knowledge to make this tutorial a 100% tutorial.  
  
Please verify the Green sentence and answer the orange one.  
  
<https://www.dropbox.com/s/94izfx0yy2wyqtl/Burn%20Arduino%20Bootloader%20to%20ATMEGA328P.pdf?dl=0>  
  
Thanks in advance