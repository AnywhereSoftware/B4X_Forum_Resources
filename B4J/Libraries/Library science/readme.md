### Library science by MichalK73
### 10/06/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/134837/)

Hello.  
  
I would like to introduce you to the Science library. I wrote it in my free time and I will develop it with more branches of science. Maybe there are still a few hundred patterns left.  
  
The library at the moment has:  
1. constants - physical, chemical constants, etc. - 48 element  
2. EnergyConvert - energy converter between J,Hz,K,eV,u - 37 patterns  
3. Math - mathematical formulas - 38 patterns  
4. Physics - formulas related to physics divided into subcategories by prefix. - 75 patterns  
 - DYN\_ - dynamics  
 - ELE\_ - electricity  
 - KIN\_ - kinetics  
 - MAG\_ - magnetism  
 - WAV\_ - waves and vibrations  
 - TER\_ - thermodynamitics  
5. Engineering - templates for engineering (as of version 0.11)  
 - DURABULITY\_ - durability of materials - 17 patterns  
  
I tried to keep the calculations correct. To the PI constant I added PI50, is a constant PI to 50 decimal places. It can be useful for accurate calculations of large objects. Some formulas have already duplicated functions just for PI50. This is marked.  
I will not write everything here, I tried to describe the formulas, constants and input and output parameters quite clearly.  
Can be used for all B4X platforms: B4A,B4J,B4i.  
  

```B4X
    Log(Constans.AtomicMass)  
    Log(EnergyConvert.eVtoHz(1000.2))  
    Log(Math.ArcLengthWheel(120,45))  
    Log(Physics.DYN_DefinitionDensity(400.00, 23))  
    Log(Engineering.DURABULITY_AbsoluteDeformation(4,5.2))
```