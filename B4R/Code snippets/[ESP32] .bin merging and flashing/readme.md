### [ESP32] .bin merging and flashing by peacemaker
### 08/23/2024
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/149181/)

**It's all was for old B4R versions supporting only Arduino 1.x. For Arduino 2.x - see posts below.**  
  
Merging 3 .bin files from B4R Object\bin folder into a single firmware file "merged-flash.bin":  
![](https://www.b4x.com/android/forum/attachments/143963)  
Flashing "merged-flash.bin" file into the board via COM-port and esptool.exe:  
![](https://www.b4x.com/android/forum/attachments/143964)  
Merging:  
> esptool.py v4.5.1  
> Wrote 0x115300 bytes to file ..\Objects\bin\merged-flash.bin, ready to flash to offset 0x0  
> Completed. Exit code: 0

  
Forgotten to plug USB-cable from the board:  
> esptool.py v4.5.1  
> Found 0 serial ports  
> A fatal error occurred: Could not connect to an Espressif device on any of the 0 available serial ports.  
> Completed. Exit code: 2

  
Flashing: do not forget  

1. disconnect log of B4R from COM-port
2. set the flash-mode by the board buttons (usually holding BOOT press and release EN and next release BOOT) of ESP32 module just after the IDE link clicked !

> esptool.py v4.5.1  
> Found 1 serial ports  
> Serial port COM6  
> Connecting….  
> Chip is ESP32-D0WDQ6 (revision v1.0)  
> Features: WiFi, BT, Dual Core, 240MHz, VRef calibration in efuse, Coding Scheme None  
> Crystal is 40MHz  
> MAC: 08:3a:f2:a7:8e:ac  
> Uploading stub…  
> Running stub…  
> Stub running…  
> Changing baud rate to 921600  
> Changed.  
> Configuring flash size…  
> Flash will be erased from 0x00000000 to 0x00115fff…  
> Compressed 1135360 bytes to 691197…  
> Writing at 0x00000000… (2 %)  
> Writing at 0x0001293e… (4 %)  
> Writing at 0x0001d2a0… (6 %)  
> Writing at 0x00028e11… (9 %)  
> Writing at 0x0003753f… (11 %)  
> Writing at 0x0003cbef… (13 %)  
> Writing at 0x00042574… (16 %)  
> Writing at 0x00047b99… (18 %)  
> Writing at 0x0004d0ea… (20 %)  
> Writing at 0x00052591… (23 %)  
> Writing at 0x00057e00… (25 %)  
> Writing at 0x0005d29c… (27 %)  
> Writing at 0x000624f0… (30 %)  
> Writing at 0x00068905… (32 %)  
> Writing at 0x0006e1b6… (34 %)  
> Writing at 0x00073eb4… (37 %)  
> Writing at 0x00079697… (39 %)  
> Writing at 0x0007f399… (41 %)  
> Writing at 0x00085000… (44 %)  
> Writing at 0x0008a7c0… (46 %)  
> Writing at 0x0008fee3… (48 %)  
> Writing at 0x00095475… (51 %)  
> Writing at 0x0009ab7f… (53 %)  
> Writing at 0x000a089b… (55 %)  
> Writing at 0x000a6422… (58 %)  
> Writing at 0x000ad188… (60 %)  
> Writing at 0x000b3064… (62 %)  
> Writing at 0x000b8970… (65 %)  
> Writing at 0x000be494… (67 %)  
> Writing at 0x000c3928… (69 %)  
> Writing at 0x000c9190… (72 %)  
> Writing at 0x000cee30… (74 %)  
> Writing at 0x000d4bd8… (76 %)  
> Writing at 0x000daf88… (79 %)  
> Writing at 0x000e0b32… (81 %)  
> Writing at 0x000e6490… (83 %)  
> Writing at 0x000ebe54… (86 %)  
> Writing at 0x000f2744… (88 %)  
> Writing at 0x000fb045… (90 %)  
> Writing at 0x00102f8b… (93 %)  
> Writing at 0x001091f5… (95 %)  
> Writing at 0x0010e69e… (97 %)  
> Writing at 0x00114150… (100 %)  
> Wrote 1135360 bytes (691197 compressed) at 0x00000000 in 10.5 seconds (effective 863.3 kbit/s)…  
> Hash of data verified.  
> Leaving…  
> Hard resetting via RTS pin…  
> Completed. Exit code: 0

  
Commands for B4R IDE:  

```B4X
'Ctrl + click to merge binaries into merged-flash.bin: ide://run?file=%USERPROFILE%\AppData\Local\Arduino15\packages\esp32\tools\esptool_py\4.5.1\esptool.exe&args=–chip&args=ESP32&args=merge_bin&args=-o&args=..\Objects\bin\merged-flash.bin&args=–flash_mode&args=dio&args=–flash_size&args=4MB&args=0x1000&args=..\Objects\bin\src.ino.bootloader.bin&args=0x8000&args=..\Objects\bin\src.ino.partitions.bin&args=0x10000&args=..\Objects\bin\src.ino.bin  
'Ctrl + click to flash into ESP32 board: ide://run?file=%USERPROFILE%\AppData\Local\Arduino15\packages\esp32\tools\esptool_py\4.5.1\esptool.exe&args=–chip&args=ESP32&args=–baud&args=921600&args=write_flash&args=0x0&args=..\Objects\bin\merged-flash.bin
```

  
where "%USERPROFILE%….." is your path to "[esptool.exe](https://docs.espressif.com/projects/esptool/en/latest/esp32/esptool/basic-commands.html#merge-binaries-for-flashing-merge-bin)" installed in Arduino IDE v.1.x.  
  
These 2 links are useful for re-flashing the board if the B4R sketch was already compiled.