### How to calculate device's battery lifetime ? by peacemaker
### 03/10/2025
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/162289/)

<https://www.omnicalculator.com/other/battery-life>  
  
Say, device with tiniest MCU (needed just 2 mA current for work) powered by CR2032 battery (of 200 mAh capacity) and sleeping almost 5 mins (298 seconds of 300 with total consumption of just 1 microAmpere during sleep), but awaked just for 2 second work - should be OK during ~1.5 years.  
  
> Battery life = Capacity / Consumption × (1 - Discharge safety),

> Average consumption = (Consumption1 × Time1 + Consumption2 × Time2) / (Time1 + Time2),

> 200 / ((2 × 2 + 0.001 × 298) / 300) × (1 - 0.1) = 12564 hrs