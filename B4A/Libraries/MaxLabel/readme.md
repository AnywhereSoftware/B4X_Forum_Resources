### MaxLabel by Jerryk
### 11/29/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/164253/)

I have modified a custom view [AutoTextSizeLabel](https://www.b4x.com/android/forum/threads/custom-view-autotextsizelabel.30642/) where the font size is maximized either in height or width.  
Now it takes into account both borders and padingns. It is packaged in the b4xlib library.  
  
  
![](https://www.b4x.com/android/forum/attachments/158847)  
  
**MaxLabel  
Author: Jerryk  
Version: 1.30  
  
Methods:**  

- **Text** As String

Sets or gets text of Label.  

- **Base** As Label

All Label methods are available through Base (e.g. Maxlabel.Base.TextColor, Maxlabel.Base.Top, etc.)  
  
**Properties:**  

- **PreferHeight** As Boolean

Fill height is preferred. In case of long text it will be displayed on multiple lines.  

- **MaxSize** As Int

Set maximixed size of font. 0 - no limit  

- **SingleLine** As Boolean

When using the SingleLine property, use "overwritten". This is because it needs to be read for calculations, but in the original it is writeonly.  
————–  
  
**Vesion 1.1**   
added Tag property  
**Vesion 1.11**  
fixed error when Background is not ColorDrawable or not set  
**Vesion 1.20**  
added PreferHight property  
**Vesion 1.30**  
added MaxSize property  
**Vesion 1.31**  
fixed error when read new addded property