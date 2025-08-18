### Avatar Generator by MilaDesign
### 04/15/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/139903/)

This library gives you avatar like Telegram.  
You can set color or use unique color based on your label.  
![](https://www.b4x.com/android/forum/attachments/127947)![](https://www.b4x.com/android/forum/attachments/127948)  
  
Sample Code:  

```B4X
Dim AG As AvatarGenerator  
AG.Initialize.AvatarSize(64).TextSizePercentage(50).Label(Name).ToCircle  
  
AG.Build 'To get bitmap  
AG.Build2 'To get bitmapdrawable
```

  
  
  
B4A Library:  
  
**AvatarGenerator  
Author:** MilaDesign  
**Version:** 1.50  
 **Methods:**  

- **Initialize**
- **AvatarSize**(Size As Int)
- **TextSizePercentage**(TextSize As Int)
- **Label**(Label As String)
- **BackgroundColor**(Color As Int)
- **Typeface**(Typeface As Typeface)
- **ToCircle**
- **ToSquare**
- **Build**
- **Build2**

 **Properties:**  

- **RANDOM** As Int