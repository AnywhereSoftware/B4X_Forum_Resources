### [B4x] xFFT  Class and b4xlib by klaus
### 03/31/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/78797/)

This class performs [Fast Fourier Transformations](https://en.wikipedia.org/wiki/Fast_Fourier_transform) forward and inverse.  
  
The class has been updated to a B4XLibrary.  
**The name hase changed from FFT to xFFT**, you need to change it in the declaration if you update from the previous code module to the b4xlib.  
The class is exactly the same for B4A, B4i and B4J.  
  
A [FFT library](https://www.b4x.com/android/forum/threads/fft-fast-fourier-transform-library.6989/#content) already exists, but only for B4A.  
  
A Fast Fourier Transformation transforms a signal from its original domain (mostly the time domain) into its representation in the frequency domain.  
  
The number N of samples in the original domain must be a power of 2?  
Examples: 256, 1024, 2048, 4096 etc.  
  
In theory, the source signal must have a real and an imaginary part.  
In time signals the imaginary samples are all 0, this is treated internally in the class, no need to transmit them.  
The result of an FFT is two signals real and imaginary.  
Which can also be represented by magnitude and phase.  
  
In concrete applications, the magnitude of the frequency signal is mostly used, therefore the Forward method returns the Magnitude.  
The phase, real and imaginary signals can be accessed as properties.  
  
Attached files:  
*xFFTDemo.zip* contains three demo programs, one for each platform, these programs use the xFFT.b4xlib  
*xFFT.b4xlib* the B4X Library file  
*xFFT.bas* the Class file  
*FFT\_Record.zip* a concrete B4A project explained below.  
x*FFT.xml* the xml help file, it is only needed for the [B4X Help Viewer](https://www.b4x.com/android/forum/threads/b4x-help-viewer.46969/) if you use it.  
Don't copy this file to the AdditionalLibraries\B4X folder.  
Copy it in the AdditionalLibraries\B4XlibXMLFiles folder, again, only if you use the [B4X Help Viewer](https://www.b4x.com/android/forum/threads/b4x-help-viewer.46969/).  
  
  
**Methods:**  
  
[FONT=Courier New]Forward(Real() As Double) As Double() [/FONT]performs a FFT calculation  
Real = an array of N Doubles representing the Real time signal.  
Returns the Magnitude of the frequency domain N/2 + 1 samples.  
  
[FONT=Courier New]Inverse(Real() As Double, Imag() As Double) As Double()[/FONT] performs an inverse FFT calculation  
Real = an array of N/2 + 1 Doubles representing the real part of the frequency signal.  
Imag = an array of N/2 + 1 Doubles representing the imaginary part of the frequency signal.  
Returns the inverse frequency real signal, N samples.  
  
**Properties:**  
  
Magnitude = magnitude of the frequency signal N/2 + 1 samples, read only.  
  
Phase = phase of the frequency signal N/2 + 1 samples, read only.  
  
Real = real part of the frequency signal N/2 + 1 samples, read only.  
  
Imag = imaginary part of the frequency signal N/2 + 1 samples, read only.  
  
ModeDegrees = True (default), the phase signal is in degrees otherwise in radians.  
  
[Window](https://en.wikipedia.org/wiki/Window_function) = NONE or Hann, applies no window or a Hann window.  
  
  
**Demo programs:**  
  
Attached a demo project for each product B4A, B4i and B4J, they use the xFFT.b4xlib.  
  
The program can:  
  
Calculate different input signals.  
  
Calculate forward and inverse FFTs.  
  
Display the different signals.  
  
Apply a [Window](https://en.wikipedia.org/wiki/Window_function).  
  
![](https://www.b4x.com/android/forum/attachments/55071)  
  
![](https://www.b4x.com/android/forum/attachments/55072)  
  
  
For Android phones and iPhones tap on the chart to show the menu.  
  
On Android and iOS tablets and in the B4J project the menu is always visible.  
  
  
![](https://www.b4x.com/android/forum/attachments/55073)  
  
  
**Concrete B4A application: FFT\_Record**  
  
The program reads the microphone signal.  
  
  
![](https://www.b4x.com/android/forum/attachments/55074)  
  
![](https://www.b4x.com/android/forum/attachments/55075)  
  
  
![](https://www.b4x.com/android/forum/attachments/55076) Start stop the reading  
  
![](https://www.b4x.com/android/forum/attachments/55077) Switch between Time and FFT  
  
![](https://www.b4x.com/android/forum/attachments/55078) Generate a sound composed of three frequencies: 500, 1000 and 2000  
  
![](https://www.b4x.com/android/forum/attachments/55079) Change the scale up and down  
  
![](https://www.b4x.com/android/forum/attachments/55080) Display the signal values when moving the finger over the diagram.