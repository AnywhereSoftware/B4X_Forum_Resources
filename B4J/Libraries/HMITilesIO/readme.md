### HMITilesIO by rwblinn
### 08/23/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171863/)

**HMITilesIO**  
An Open-Source HMI Tile Library for Small Industrial Dashboards  
  
⚠️ Project Status: Work in Progress  
This library is actively being developed, refactored, and optimized. Features, properties, and core method signatures are subject to change as physical hardware integration tests expand.  
  

---

  
  
**Overview  
  
HMITilesIO** brings structured, industry-inspired high-performance HMI design principles directly into the B4X ecosystem.  
It combines highly optimized vector graphics with native input tracking for microcontrollers and IoT applications.  
  

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
  
[TABLE]  
[TR]  
[TD]**Platform**[/TD]  
[TD]**Status**[/TD]  
[TD]**Notes**[/TD]  
[/TR]  
[TR]  
[TD]B4J[/TD]  
[TD]✅ Supported[/TD]  
[TD]Primary target (full-screen desktop HMIs)[/TD]  
[/TR]  
[TR]  
[TD]B4A[/TD]  
[TD]✅ Supported[/TD]  
[TD]Full mobile support (Phone/Tablet field controllers)[/TD]  
[/TR]  
[TR]  
[TD]B4i[/TD]  
[TD]❌ Not Supported[/TD]  
[TD]iOS deployment is not currently planned[/TD]  
[/TR]  
[/TABLE]  
  

---

  
  
**HMITilesIO Overview**  
  
[TABLE]  
[TR]  
[TD]**Tile Type**[/TD]  
[TD]**Brief**[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]ByteStatus[/TD]  
[TD]Byte Bit Matrix: An 8-bit digital register status word display mapping a raw byte (0-255) into a high-visibility 2x4 diagnostic grid matrix with real-time hexadecimal footer logging.[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Gauge[/TD]  
[TD]180° Gauge: Beautiful, perfectly mapped left-to-right neon tracking arc.[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]LEDPanel[/TD]  
[TD]LED Panel: Deep, polished status lens with a realistic glare overlay.[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]ReadOut[/TD]  
[TD]Read Out: Crisp telemetry display that cleanly outputs dynamic process numbers or operational status string values (e.g., "23.5 °C", "1013 hPa", "RUNNING").[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]SevenSegment[/TD]  
[TD]7-Segment Display: 40px zero-padded local font that is completely visually centered.[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Spinner[/TD]  
[TD]Spinner: High-precision directional increment control featuring clear high-contrast tactile action touch targets for exact setpoint calibration.[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Slider[/TD]  
[TD]Technical Slider: Symmetrical control groove rail with flawless cursor mapping.[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Switch[/TD]  
[TD]Rocker Switch: Crisp, tactile 3D effect with clear status symbols.[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]VerticalMeter[/TD]  
[TD]Vertical Meter: Simplified scale column with an aligned reference tracking arrow.[/TD]  
[TD][/TD]  
[/TR]  
[/TABLE]  
  

---

  
  
**Screenshots**  
  
![](https://www.b4x.com/android/forum/attachments/173099)  

---

  
  
**Installation**  
  
 1. Download the latest release (HMITilesIO.b4xlib) from the libs folder.  
 2. Copy the file into your B4J Additional Libraries and/or B4A Additional Libraries folder.  
 3. Open your project in the IDE and check the box next to HMITilesIO in the Libraries Manager tab.  
  

---

  
  
**Examples Included**  
  
\* Basic Layout: Easy-to-follow example demonstrating rendering configuration loops for every component type.  
  

---

  
  
**Quick Start**  
HMITilesIO is a standard B4X CustomView and can be added directly via the Visual Designer.  
  
1. Configure the Visual Designer  
  

- Open the Visual Designer tool.
- Add a CustomView to your layout pane canvas.
- Set the Selected Type to: HMITilesIO
- Name the view object variable: TileIOSwitch
- Change the custom property drop-down Component Type to: Switch
- Set base dimensions to a fixed bounding square layout: 120 x 120

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
    Sleep(1)  
    TileIOSwitch.State = False  
End Sub  
  
' Fires instantly when an operator touches the component area  
Private Sub TileIOSwitch_Click(State As Boolean, Value As String)  
    TileIOSwitch.State = Not(State)  
    Log($"[TileIOSwitch_Click] state=${TileIOSwitch.state} value=${TileIOSwitch.value}"$)  
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