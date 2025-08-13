### TFT displays: TFT_ESPI (inline C) example by KMatle
### 02/12/2024
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/159169/)

Update:   
  
1. Init Display as a separate sub  
2. TFT\_ESPI as "global"   
3. Drawtext as a sub with parms  
4. Updated example   
  
  
Although there is a library and I appreciate the good work, I like to use raw code. Here is a small example to draw a text on the screen. Take a look at the examples in the Arduino SDK to see other methods, etc.  
  
The lib is from Bodmer and is "the swiss knife" for displays (supports almost any kind of display)  
  
As the library is too big to upload, just load it via the Arduino-SDK:  
![](https://www.b4x.com/android/forum/attachments/150625)  
  
Navigate to the libraries folder (Arduino!) and copy the whole folder to the B4R additional libs folder.  
  
**Important note: Edit the file TFT\_eSPI.h to match your display and pins** (it's ready to go with this nice board) for 15-20€). The board has an sd card reader, too. Got it for 13€ from china as some seller made me an offer via Ebay (came with full tracking and I wonder how much they make at all).  
![](https://www.b4x.com/android/forum/attachments/150627)  
  
  
<https://github.com/witnessmenow/ESP32-Cheap-Yellow-Display/blob/main/README.md>  
  
Library of Bodmer with the lib, examples, etc.: <https://github.com/Bodmer/TFT_eSPI>