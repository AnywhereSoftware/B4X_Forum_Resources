### [Tool]LCD Char maker by rwblinn
### 03/10/2020
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/67908/)

Hi,  
  
LCD Char Maker Tool.  
  
![](https://www.b4x.com/android/forum/attachments/89745)  
  
**Functionality**  

- Create custom LCD character with 5 pixel horizontal (cols), 8 pixel vertical (rows).
Each row is represented by a byte with 5 bits.- Save / open the character to / from a textfile located in the application folder.
- Import 8 bytes array string in format 0xNN,0xNN… where NN is HEX value.
- Create B4R Inline C code (binary string) with copy to clipboard option.
- Create B4J code (hex string) with copy to clipboard option.
- Added few example chars in the project objects folder.

**Download** the B4J source code [here](https://github.com/rwbl/lcd-custom-char-maker).  
  
**Notes**  

- Tool based on the LCD Char Maker tool I wrote for [TinkerForge](http://www.tinkerforge.com/en).
- Tool supports LCD display connected to Raspberry Pi - using HEX strings (B4J)
- In below screenshot can also write shorter:
Dim degreec(8) As Byte = Array As Byte(…)
**Change Log**  
20200121 v2.00  
20170227: v1.65 (see Post #4)  
20170226: v1.5 (see Post #3)  
20160614: v1.0 (see Post #1)