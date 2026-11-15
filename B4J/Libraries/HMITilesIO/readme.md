### HMITilesIO by rwblinn
### 11/10/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171863/)

**HMITilesIO**  
An Open-Source HMI (Human-Machine Interface) Tile Library for Small IIoT (Industrial Internet of Things) Dashboards  
  

---

  
  
**Overview  
  
HMITilesIO** brings structured, industry-inspired high-performance HMI design principles directly into the B4X ecosystem.  
It combines highly optimized vector graphics with native input tracking for microcontrollers and IIoT applications.  
  

---

  
  
**Technical Engineering Challenges**  
  
Developing a single CustomView codebase that renders identically and handles real-time user inputs seamlessly across different platform engines presented several complex development challenges:  

- **Cross-Platform Touch Parity (B4J vs. B4A):** Mobile Android WebViews do not expose mouse and drag clicks the same way desktop environments do. To solve continuous slider tracking without lagging the interface or losing events, the library utilizes a transparent native **B4XView Panel overlay**. This layer intercepts multi-state finger movements natively and maps physical pixel ratios directly to internal grid units.
- **Dynamic JavaScript & Style Execution:** Achieving high-frequency visual updates requires direct interaction with embedded assets. The framework uses native Android WebKit asynchronous execution loops (evaluateJavascript) through **JavaObject**, bypassing heavy URL reloading schemes. This allows real-time modifications of vector colors, labels, and drop shadows without screen flickering.
- **Strict SVG Matrix Constraints:** To build an easily arranged dashboard grid, every asset is restricted to a mandatory, non-resizable **120x120px bounding box layout**. Overcoming sub-pixel font clipping on high-DPI screens required implementing custom typography properties (such as removing absolute baselines) and ensuring all borders scale perfectly to the component edge.

---

  
  
**Design Goals**  

- [LEFT]Lightweight tiles rendering completely offline-safe, self-contained SVG graphics.[/LEFT]
- [LEFT]Seamless dual-platform operation across desktop and mobile devices.[/LEFT]
- [LEFT]Hardware-isolated native touch event tracking to ensure zero interface input lag.[/LEFT]

---

  
  
**Platform Support**  
  
[TABLE width="100%"]  
[TR]  
[td]**Platform**[/td][td]**Status**[/td][td]**Notes**[/td]  
[/TR]  
[TR]  
[td]B4J[/td][td]✅ Supported[/td][td]Primary target (full-screen desktop HMIs)[/td]  
[/TR]  
[TR]  
[td]B4A[/td][td]✅ Supported[/td][td]Full mobile support (Phone/Tablet field controllers)[/td]  
[/TR]  
[TR]  
[td]B4i[/td][td]❌ Not Supported[/td][td]iOS deployment is not currently planned[/td]  
[/TR]  
[/TABLE]  
  

---

  
  
**HMITilesIO Overview**  
  
[TABLE width="100%"]  
[TR]  
[td]**Tile Type**[/td][td]**Brief Description**[/td][td]**Primary IoT / HMI Use Case**[/td]  
[/TR]  
[TR]  
[td]**Alarm**[/td][td]Alarm Tile - An annunciation component utilizing subtle outer border-stroke color signaling to isolate critical process alerts while preserving dashboard grid visual aesthetics.[/td][td]Discrete output: Status indicator, adhoc warnings.[/td]  
[/TR]  
[TR]  
[td]**BatteryIndicator**[/td][td]Battery Indicator: Smart, low-footprint charge level layout displaying a responsive 4-segment vertical vector cell. Automatically transitions through visibility and warning color profiles based on raw 0-100% capacity data blocks.[/td][td]Power Supply Monitoring: Live tracking for remote battery nodes, solar charging configurations, UPS backup cells, or low-power ESP32/Pico field telemetry loops.[/td]  
[/TR]  
[TR]  
[td]**Button**[/td][td]Push Button: Multi-layered bezel with high-contrast borders and an offset shadow to give it strong physical depth.[/td][td]Discrete Input: Momentary engine starts, manual horn triggers, or tactile latch reset commands.[/td]  
[/TR]  
[TR]  
[td]**ByteStatus**[/td][td]Byte Bit Matrix: An 8-bit digital register status word display mapping a raw byte (0-255) into a high-visibility 2x4 diagnostic grid matrix with real-time hexadecimal footer logging.[/td][td]Discrete Output: Real-time CAN-Bus frame analysis, GPIO expander debugging, or low-level register tracking.[/td]  
[/TR]  
[TR]  
[td]**Compass**[/td][td]Compass: A simplified 360° directional tracking tool mapping singular degree vector variables straight to a sleek orientation wedge arrow layout.[/td][td]Process Lifecycles: Environmental weather wind tracking, factory ventilation flow vectors, automated guided vehicle (AGV) travel heading, or material mixer rotational paths.[/td]  
[/TR]  
[TR]  
[td]**DualReadOut**[/td][td]Dual Read Out: High-density, twin-column telemetry layout with independent value nodes and dedicated unit frames for dense cluster environments (e.g., "23 °C" | "68 %").[/td][td]Dual Sensor Arrays: Simultaneous localized parameter tracking (Temperature/Humidity, Voltage/Current, or dual-zone status updates).[/td]  
[/TR]  
[TR]  
[td]**Gauge**[/td][td]180° Gauge: Beautiful, perfectly mapped left-to-right neon tracking arc.[/td][td]Analog Readout: High-visibility analog readouts like Engine RPM, Vehicle Speed, or active Pump Pressure.[/td]  
[/TR]  
[TR]  
[td]**Horizon**[/td][td]Horizon: An avionics-grade flight attitude indicator translating combined pitch and roll vector metrics seamlessly onto a high-visibility, responsive gauge matrix layout.[/td][td]Basically bit-of-fun showing what can be done with SVG images.[/td]  
[/TR]  
[TR]  
[td]**IconIndicator**[/td][td]Icon Indicator: High-visibility visual alert interface rendering a scalable 48x48px vector symbol frame. Dynamically handles inline status updates (e.g., "OK", "WARNING", "ERROR", "INFO") using low-latency embedded strings.[/td][td]System Health Diagnostics: State-machine fault monitoring, critical hardware overrides, connection status flags, or process validation warnings.[/td]  
[/TR]  
[TR]  
[td]**IOPanel**[/td][td]IO Panel: Up-to 8 rectangles to set multiple states ON / OFF.[/td][td]Discrete Input: Multi-relay smart home control, zone lighting management, or individual valve line triggers.[/td]  
[/TR]  
[TR]  
[td]**LEDPanel**[/td][td]LED Panel: Flat, flush pilot light embedded smoothly into the dashboard surface.[/td][td]Discrete Output: Passive system notifications such as Overheat Alerts, Connectivity Pings, or Safe Run indicators.[/td]  
[/TR]  
[TR]  
[td]**LoadingIndicator**[/td][td]An progress layout component utilizing sub-pixel balanced vector geometries and strict layout symmetry to track active processes without adding visual distraction to the HMI grid matrix.[/td][td]Discrete Output: Indicator for task-in-progress.[/td]  
[/TR]  
[TR]  
[td]**MultiState**[/td][td]Multi State: Up-to 8 rectangles to set a single state ON / OFF.[/td][td]Discrete Input: Interlocked control patterns like Fan Speeds (Low/Med/High) or Machine Mode options.[/td]  
[/TR]  
[TR]  
[td]**ReadOut**[/td][td]Read Out: Crisp telemetry display that cleanly outputs dynamic process numbers or operational status string values (e.g., "23.5 °C", "1013 hPa", "RUNNING").[/td][td]Analog Readout: Environmental sensor arrays (DHT22/BME280) or text-based state machines.[/td]  
[/TR]  
[TR]  
[td]**QuadReadOut**[/td][td]An ultra-high-density 2x2 variable monitoring component featuring dynamic grid geometry handling. Automatically hides unused quadrants and layout axis lines when strings are null, keeping high-performance light themes perfectly clear of empty artifact paths.[/td][td]Digital Output: Monitor state up-to 4 sensors.[/td]  
[/TR]  
[TR]  
[td]**Selector**[/td][td]Selector: Select an item from list of items via touch.[/td][td]Analog Control: Changing dynamic setpoint parameters or choosing target device profiles on the fly.[/td]  
[/TR]  
[TR]  
[td]**SevenSegment**[/td][td]7-Segment Display: 40px zero-padded local font that is completely visually centered to display 1-4 digits.[/td][td]Analog Readout: Authentic dashboard instrumentation readouts like active Transmission Gear or Digital Odometers.[/td]  
[/TR]  
[TR]  
[td]**SignalStrength**[/td][td]Signal Strength: Robust infrastructure diagnostics tile displaying an ascending 4-bar vector staircase. Features built-in string parsing that auto-detects and processes raw whole percentages ("50%"), decimal ratios (".50"), or negative RSSI dBm telemetry ("-65").[/td][td]Network Node Health: Live link tracking for localized Wi-Fi access points, remote cellular modems, or low-power ESP32/Pico mesh field nodes.[/td]  
[/TR]  
[TR]  
[td]**Slider**[/td][td]Technical Slider: Symmetrical control groove rail with flawless cursor mapping.[/td][td]Analog Control: Continuous range modulation, such as adjusting LED Dimmer Levels or Motor Throttle bounds.[/td]  
[/TR]  
[TR]  
[td]**Spinner**[/td][td]Spinner: High-precision directional increment control featuring clear high-contrast tactile action touch targets for exact setpoint calibration.[/td][td]Analog Control: Fine-tuning targeted temperature settings or adjusting calibration offset parameters step-by-step.[/td]  
[/TR]  
[TR]  
[td]**Switch**[/td][td]Rocker Switch: Crisp, tactile 3D effect with clear status symbols.[/td][td]Discrete Input: Main system Power Toggles, isolated battery disconnects, or Cruise Control activation.[/td]  
[/TR]  
[TR]  
[td]**TiltGauge**[/td][td]TiltGauge: A specialized quadrant-type gauge designed specifically for angular positions, tilt monitoring, incline tracking, or physical gate/valve status visualization (sweeping a tight 90° arc from vertical to horizontal).[/td][td]Process Lifecycles: Angular opening sequences for flap or sluice gates, heavy equipment boom-angle lifting phases, physical safety barrier deployment stages, or liquid flow diverting valve states.[/td]  
[/TR]  
[TR]  
[td]**Timer**[/td][td]Timer: Production-cycle tracking interface rendering a sharp monospace duration string. Features an active vector progress ring that automatically scales and alters color profiles based on fractional runtime datasets ("CurrentSeconds;TotalSeconds").[/td][td]Process Lifecycles: Countdown metrics for valve flushing operations, automated irrigation windows, thermal dwell intervals, or hardware watchdog tracking loops.[/td]  
[/TR]  
[TR]  
[td]**TrendChart**[/td][td]TrendChart: Precise, low-overhead graph tile displaying live trend profiles. Features trend data as sparkline, automatic Min/Max scale labeling and an integrated X/Y reference grid layout designed for compact historical overview.[/td][td]Historical Tracking: Real-time trending datasets (e.g., "10;20;30;25;20;0") for observing thermal gradients, pressure stability profiles, or voltage load patterns over time.[/td]  
[/TR]  
[TR]  
[td]**VerticalMeter**[/td][td]Vertical Meter: Simplified scale column with an aligned reference tracking arrow.[/td][td]Analog Readout: Linear volumetric calculations like Fuel Tank Capacity, Water Levels, or Battery Charge (SoC).[/td]  
[/TR]  
[TR]  
[td]**WatchdogTile**[/td][td]WatchdogTile: A rugged, instrumentation-bezel telemetry health monitor displaying real-time node latency diagnostics and connection safety timeouts.[/td][td]Process Lifecycles: MQTT broker heartbeat checks, remote field-transmitter polling loops, server network latency tracking, or hardware watchdog trip states.[/td]  
[/TR]  
[/TABLE]  

---

  
  
**Screenshots**  
  
![](https://www.b4x.com/android/forum/attachments/174729)  

---

  
  
**Installation**  
  
 1. Download the attached release HMITilesIO.b4xlib.  
 2. Copy the file into the B4J Additional Libraries and/or B4A Additional Libraries folder.  
 3. Open a project in the IDE and check the box next to HMITilesIO in the Libraries Manager tab.  
  

---

  
  
**Examples Included**  

- Basic Layout: Easy-to-follow example demonstrating rendering configuration loops for every component type.

---

  
  
**Quick Start**  
HMITilesIO is a standard B4X CustomView and can be added directly via the Visual Designer.  
  
1. Configure the Visual Designer  

- Open the Visual Designer tool.
- Add a CustomView to your layout pane canvas.
- Set the Selected Type to: HMITilesIO
- Name the view object variable: TileIOSwitch
- Change the custom property drop-down Component Type to: Switch
- Set base dimensions to a fixed bounding square layout: 120 x 120 px

2. Implement the Control Logic  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private TileIOSwitch As HMITilesIO  
End Sub  
  
Public Sub Initialize  
    B4XPages.GetManager.LogEvents = True  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("mainpage")  
    ' Establish default visual startup state parameters smoothly  
    Sleep(100)  
    TileIOSwitch.State = False  
End Sub  
  
' Fires instantly when an operator touches the component area  
Private Sub TileIOSwitch_Click(State As Boolean, Value As String)  
    Log($"[TileIOSwitch_Click] State changed to: ${State}, Value: ${Value}"$)  
End Sub
```

  
  

---

  
  
**Versioning**  
  
This project does not follow strict semantic versioning. Updates are published iteratively when performance enhancements or feature additions become available.  
  

---

  
  
**Acknowledgments**  

- Anywhere Software for building the excellent cross-platform B4X development suite.
- The B4X Community Forum for sharing the invaluable feedback, solutions, and ideas that made this library possible.
- AI Collaboration: Built with the collaborative assistance of an AI coding partner, helping to optimize cross-platform event math, refine embedded SVG assets, and resolve mobile WebView rendering performance bottlenecks.

---

  
  
**Disclaimer & Project Scope**  
  
This library was created primarily to explore vector-based HMI layouts for personal use, education, and open sharing within the developer community.  
This is a hobby project and is provided entirely as-is.  
  
Intended Use  
This library is not intended for deployment in production-critical or high-risk safety industrial systems.  
  
Support Policy  
  
Issue tracking and bug submissions are not actively monitored or guaranteed.  
You are highly encouraged to fork, modify, and optimize the code to fit your custom field hardware parameters.  
  
**Warranty & Liability**  
  
This software is provided "as is", without warranty of any kind, express or implied. Use it at your own risk. For full legal terms, see the accompanying LICENSE file.  
  
**License**  
  
HMITilesIO – MIT License © 2026 Robert W. B. Linn  
See the LICENSE file in the root repository folder for detailed terms.  
  

---