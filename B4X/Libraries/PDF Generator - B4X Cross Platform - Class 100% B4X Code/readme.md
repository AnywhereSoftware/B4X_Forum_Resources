###  PDF Generator - B4X Cross Platform - Class 100% B4X Code by spsp
### 01/03/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/145181/)

Hi,  
  
This class cPDF.bas (version 0.6 - 2024-01-03) generate PDF File with limited fonctionnalities (but enough for me)  

- Add pages with different paper size (use constants or custom size)
- PDF standards font (Courier, Helvetica, Times, Symbol and Zapfdingbats), style (Normal, Bold, Italic, Underline and StrikeThrough), encoding cp1252
- draw text : single line of text at position x, y
- draw text flow with explicit and automatic CR at current x,y position with alignment (left, center, right, justify)
- Measure text (width and height)
- Measure multiline text (width and height)
- draw line
- draw rectangle
- draw images (only PNG, all format that can be loaded with xui.loadbitmap)
- use pdf commands directly
- save to file with/without compression

Source full commented, example for B4J and B4A, I don't use B4I (but should be OK)  
dependencies :  

- B4XCollections
- RandomAccessFile

  
Help welcome to add support for :  

- PNG image wih colorspace = 6
- JPG image
- loading font from file

  
![](https://www.b4x.com/android/forum/attachments/137882)  
![](https://www.b4x.com/android/forum/attachments/137554)  
![](https://www.b4x.com/android/forum/attachments/137555)  
![](https://www.b4x.com/android/forum/attachments/149227)  
  
  
  
spsp