### E-Paper (probably suitable for battery powered projects) by hatzisn
### 02/15/2022
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/138426/)

Here is a nice tutorial by the guy in DronebotWorkshop. What surprised me (and I did not know that) is that with e-paper you only have power consumption while writing to it and no more. Even if you disconnect completely the module from the project what ever you have written "on" it remains written. The fact though is that it communicates (in this video at least) with SPI which means power consumption for CS pin. If you set CS pin to low to reduce power consumption then I suppose the e-paper waits for data and I don't know what will happen (what you have written remains or not?). If it remains and no data is transmitted (clock not working obviously) then I am right and it is suitable for battery powered projects. As long as it has to do with the e-Paper's power you can control it with a MOSFET through one of the board's pins or you just put the board to sleep/deep sleep. Enjoy!  
  
[MEDIA=youtube]4onIqHClh2s[/MEDIA]