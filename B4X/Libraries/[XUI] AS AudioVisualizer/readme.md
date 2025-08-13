###  [XUI] AS AudioVisualizer by Alexander Stolte
### 03/15/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/166144/)

This view is an audio visualizer that converts decibel values into simulated FFT data and renders one of three styles (spectrum, waveform, or filled wave) on a canvas. It features noise filtering, Gaussian normalization.  
  
The sample project works in B4A and B4I.  
You need this libs.  

- [xFFT](https://www.b4x.com/android/forum/threads/b4x-xfft-class-and-b4xlib.78797/)
- [AudioRecord](https://www.b4x.com/android/forum/threads/audiorecord-library.13993/#content) (B4A)

[MEDIA=youtube]wnPG9fB185Y[/MEDIA]  
  
**AS\_AudioVisualizer  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_AudioVisualizer**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String)
- **UpdateWithDB** (dBValue As Double)

- **Properties:**

- **BarColor** As Int
- **NoiseThreshold** As Double
*NoiseThreshold (0.01) filters out minor noise by setting any value below it to zero.  
 Default: 0.01*- **NumberOfBars** As Int
*Default: 32*- **RoundBars** As Boolean
*If True then the bars are round  
 Default: True*- **Sensitivity** As Double
*Sensitivity determines how pronounced the amplitude spike is.  
 Default: 1.0*- **VisualizationType** As String

**Changelog**  

- **1.00**

- Release

**Github:** [github.com/StolteX/AS\_AudioVisualizer](https://github.com/StolteX/AS_AudioVisualizer)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)