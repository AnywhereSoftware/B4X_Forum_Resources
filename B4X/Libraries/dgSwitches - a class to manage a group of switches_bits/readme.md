###  dgSwitches - a class to manage a group of switches/bits by udg
### 04/28/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/147650/)

**Foreword**  
Erel included in the B4xCollections lib a very efficient class to manage an unspecified number of bits: [B4xBitSet](https://www.b4x.com/android/forum/threads/b4x-b4xcollections-more-collections.101071/#content)  
So why dgSwitches?  
Well, it all started with an hour of spare time before lunch. The goal was to write a quick and dirty class to group the few subs I generally use when manipulating bits in order to manage config parameters, options and the likes in my apps.  
I can't recall a single time when I needed more than 16 switches, but now with dgSwitches we could use up to 64 of them!  
  
The initial expected hour quickly became two hours (than almost three when arranging a demo and writing this post). Anyway, we now have a class that does many things more than initially planned.  
The only missing point was…testing. Everything should work as is, but use it with some initial caution and report back any bugs (and, obviously, new ideas on how to improve/expand the class itself).  
  
**Using dgSwitches**  
Look at the demo; everything is covered.  
The basic concept is that the 64 switches/bits are internally stored in a single variable of type LONG.  
We can work on single bits, multiple bits, group of bits, all the bits at once.  
There are methods to set bits by a numeric value, by a string of 0s and 1s, by a list/array.  
We can read current state of the switches (bits) using numeric values or strings.  
  
When working with group of switches, we divide them in "banks" (yes, like the DIP switches on electronic boards). Depending on the type of the numeric variable we want to use, we can have from 1 bank (64bits as a LONG) to 8 banks (each 8 bits as BYTEs).  
Just remember that banks are ordered 0 (rightmost) to 7 (leftmost). The same applies for bits.  
So, to have a visual representation for better clarity, we have:  
bank7 - bank 6 - bank 5 .. bank0 (when using byte-wide banks)  
bank3 - bank2 - bank1 - bank0 (when using short-wide banks)  
bank1 - bank0 (when using int-wide banks)  
bank0 (when using long-wide bank)  
For bits, it's the same concept:  
bit63-bit62-bit61-bit60…..bit0 (when looking at them as part of a LONG var)  
bit31-bit30…bit0 (each of the two INTs)  
bit15-bit14..bit0 (each of the 4 SHORTs)  
bit7-bit6…bit0 (each of the 8 BYTEs)  
  
**Note**: I kept separate methods to set/unset a bit because it seemed to me that code using them could be more readable than code using a single method with an additonal boolean parameter for setting/unsetting.  
  
**Update**: I uploaded a new zip file (no changes in code) since the original one was of little use…sorry, everybody.  
**Update2**: just added the class by itself so you don't need to download the demo project