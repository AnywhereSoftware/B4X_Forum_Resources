### ESP32-RMT-puls B4R Library (Pre-release) by tonigau
### 08/04/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168081/)

[HEADING=2]**ESP32RMTpuls B4R Library (Pre-release)**[/HEADING]  
  
This is a *B4R library* for generating TX pulse signals using the *RMT module of the ESP32*.  
It is currently in *pre-release*, due to limited testing across different *IDF versions* and *ESP32 SoC variants*.  
  
The library is primarily intended for *one-shot pulse generation*, but with additional features such as *PWM*, *GPIO routing*, *sync channels*, and *inversion*, it can also produce more complex signals like *repeating pulse bursts* and *complementary PWM*.  
All signal generation is handled by hardware, resulting in *minimal CPU usage*.  
  
Using GPIO matrix routing, you can dynamically *attach or detach multiple GPIO pins to a single RMT TX channel* at runtime. With the help of a B4R timer, PWM outputs can be switched to various pins to create *sequential output patterns*.  
  

---

  
[HEADING=2]**Compatibility**[/HEADING]  
The library has been developed and tested using *IDF v5.3.2* with the *ESP32-S3*, and minimally tested with the *ESP32*.  
Some features may not work correctly due to differences in *IDF versions*, *SoC capabilities*, or simply due to developer oversight.  
While the library includes some *SoC variant checks*, there may still be *unhandled macros or API differences*.  
  
Please report any issues you encounter or suggestions for improvement.  
  

---

  
Usage instructions are included in the *attached help document*.