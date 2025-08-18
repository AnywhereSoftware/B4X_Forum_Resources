### xCLV with Navigation Buttons by epiCode
### 09/06/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/134036/)

Hi Everyone,  
I'm sharing a modified xCLV to display navigation button to scroll up or down to bottom.  
![](https://www.b4x.com/android/forum/attachments/118754)  
  
**It is based on v1.72 shared by [USER=1]@Erel[/USER] here ->** [**Original Lib Thread**](https://www.b4x.com/android/forum/threads/roundslider-min-max-values.114838/)  
  
Please note that it is **not** recommended by Erel to use .bas for xCLV,  
 since other libs depend on it, so I'm sharing a jar version. Will share source code if anyone needs.  
Use this at your own risk :)  
I've tested it for B4A only - please leave a feedback if you use it for B4J / B4i  
  
**Installation:**  
Unpack libs to your additional folder >> run jetifier >> add in your project and use  
  
  
**Usage:**  
Same as xCLV  
Buttons will vanish in few seconds and show up after scrollchanged event automatically  
Buttons will also show only the direction in which it is possible to move  
It uses 'pressed color' for its color (accessible from designer)  
  
It can be disabled/enabled by following code or from designer  

```B4X
xCLV1.showNavButtons(Visible as boolean)
```

  
  
cheers !!