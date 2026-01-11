### HMITiles by rwblinn
### 01/09/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/169774/)

**HMITiles** - an Open-Source HMI Tile Library for Industrial Dashboards  
  

---

  
  
**Overview  
HMITiles** is an open-source **HMI** (Human Machine Interface) tile library written in **B4X**, following widely accepted industrial HMI principles.  
  
It provides reusable, professional-grade HMI tiles for:  

- Industrial dashboards
- SCADA (Supervisory Control and Data Acquisition) front-ends
- Machine and process HMIs

The focus of this library is **clarity, consistency, and disciplined HMI design** — not visual effects or UI decoration.  
  

---

  
  
**Design Goals**  

- Based on widely accepted industrial HMI principles
- Alarm-first color discipline
- Clear and consistent state handling
- Touch-friendly layouts
- No animations or visual noise
- Minimal configuration required

**Implemented tiles**  

- Buttons (including ON/OFF logic)
- Numeric and text readouts
- Sensor tiles
- Clocks and time displays
- Event and message viewers
- Sliders and setpoints
- Image tiles
- RGB indicators
- Layout and helper components

All tiles share an unified styling and state model.  
  

---

  
  
![](https://www.b4x.com/android/forum/attachments/169154)  
  

---

  
  
**Files**  
HMITiles-NNN.zip archive contains the library and sample projects.  
  

---

  
  
**Install**  
From the zip archive, copy the file HMITiles.b4xlib to the B4J additional libraries folder.  
For some of the examples addition libraries are required. See folder Libs.  
  

---

  
  
**Examples**  
The folder examples has several examples organised by B4A & B4J.  
To mention  

- B4A & B4J Overview - All HMI tiles at a glance. The slider changes selected tiles.
- B4J-WaterTankSimulator - Simulate live data with HMI setpoint & trend tiles.
- B4J-ArduinoLED - Control onboard Arduino LED via serial line (sending/receiving single byte), Arduino firmware B4R.
- B4A-ESP32BLEED - Control ESP32 connected LED via BLE (UART), ESP32 firmware B4R.
- B4A Ble - Several Ble client & scanner examples (using the new BleCentral.b4xlib).
- HomeKit32 - Real example controlling the [HomeKit32](http://www.b4x.com/android/forum/threads/homekit32-modular-smart-home-kit.169728/).

The Libs folder contains additional B4A & B4R libraries required for some of the examples.  
  

---

  
  
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

  
  

---

  
  
**To-Do**  

- Additional GetStarted examples.
- FarmKit32 - Control the FarmKit32. Similar to HomeKit32 but then using the Keyestudio Smart Farm Kit KS0567 ([docs.keyestudio.com/projects/KS0567/en/latest/wiki/index.html](http://docs.keyestudio.com/projects/KS0567/en/latest/wiki/index.html)).

---

  
  
**License**  
MIT - see LICENSE.