### HMITiles by rwblinn
### 12/17/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/169774/)

**Purpose  
HMITiles** is an ISA-101 inspired HMI tile library written in B4X.  
It provides reusable, professional-grade HMI tiles for industrial dashboards,  
SCADA front-ends, and machine HMIs.  
  
The primary target platform is B4J in full-screen mode.  
Most tiles work on B4A (not all tiles supported).  
B4i is currently not supported.  
  
The goal of this library is not visual effects, but operator safety,  
clarity, and consistency according to ISA-101 guidelines.  
  
**Key Features**  
• ISA-101 compliant defaults  
• Unified styling and state model  
• Alarm-first color discipline  
• Touch-friendly layouts  
• No animations or visual noise  
• Minimal configuration required  
  
**Implemented tiles**  
Buttons, readouts, sensors, clocks, event viewers, sliders,  
image tiles, RGB indicators, and layout helpers.  
  
**Screenshots**  
  
![](https://www.b4x.com/android/forum/attachments/168925)  
**Files**  
HMITiles.zip archive contains the library and sample project.  
  
**Install**  
From the zip archive, copy the file HMITiles.b4xlib to the B4J additional libraries folder.  
  
**Examples**  

- Overview - Example to start with all HMI tiles.
- HomeKit32 - Real example controlling the [HomeKit32](http://www.b4x.com/android/forum/threads/homekit32-modular-smart-home-kit.169728/).

  
**Basic Example**  
HMITiles are standard B4X CustomViews and can be placed in the Designer.  
Example: simple ON / OFF HMITile  

```B4X
Sub Class_Globals  
    Private HMITileButtonOnOff As HMITileButton  
    …  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    …  
    ' OnOff Button  
    HMITileButtonOnOff.State = False  
    …  
  
Private Sub HMITileButtonOnOff_Click  
    HMITileButtonOnOff.SetState(HMITileButtonOnOff.State)  
    HMITileButtonOnOff.StateText = IIf(HMITileButtonOnOff.State, "ON", "OFF")  
    Log($"[HMITileButtonOnOff] state=${HMITileButtonOnOff.State}"$)  
End Sub
```

  
  
**To-Do**  

- Additional HMITiles: HMITileGauge, BarGraph/TrendMini, HMITileStateIndicator, HMITileFormHeader, HMITileMenuButton, HMITileSeparator.
- FarmKit32 - Control the FarmKit32. Similar to HomeKit32 but then using the Keyestudio Smart Farm Kit [KS0567](http://docs.keyestudio.com/projects/KS0567/en/latest/wiki/index.html).

**Licence**  
MIT - see LICENSE.