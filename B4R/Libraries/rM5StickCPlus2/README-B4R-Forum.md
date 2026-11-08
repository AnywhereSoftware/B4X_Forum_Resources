[B]B4R Library rM5StickCPlus2[/B]
[HR][/HR]

[B]Brief[/B]
[B]rM5StickPlus2[/B] is an open-source library for the [B]M5 StickC-Plus2[/B].

This library
[LIST]
[*]is partially wrapped from the [URL='https://github.com/m5stack']M5Stack libraries[/URL] (MIT license) M5Unified, M5GFX.
[*]is enhanced with custom functions & constants covering LCD control, Buttons (A Big in the middle, B Small top left, C Small bottom right Power) event, Battery management. 
[*]has been developed to display text and dedicated graphics (like battery state icon) only.
[*]does not support following device features IMU, speaker, buzzer, MIC, IR emitter.
[/LIST]
[HR][/HR]

[B]Development Info[/B]
[LIST]
[*]Written in C++ - Arduino IDE 2.3.6, Arduino CLI 1.2.2 and the B4Rh2xml tool.
[*]Arduino IDE Library dependencies: M5Unified 0.2.10, M5GFX 0.2.15.
[*]Tested with
[LIST]
[*]Hardware - M5 StickC-Plus2.
[*]Software - B4R 4.00 (64-bit).
[/LIST]
[/LIST]
[HR][/HR]

[B]M5 StickC-Plus2 Features[/B]
[LIST]
[*]Microcontroller: ESP32-PICO-V3-02 240MHz dual core,support wifi,2 MB SPI PSRAM,8 MB SPI flash.
[*]Power Input: 5V @ 500mA.
[*]Ports: USB Type-C, GROVE(I2C+I/0+UART).
[*]Display: 1.14-inch Colorful TFT LCD screen, resolution 135 x 240 pixels, driver ST7789v2.
[*]Battery: built-in 200mAh @ 3.7V LiPo battery, rechargeable via USB Type-C port.
[*]Buttons: Button A (BtnA), Button B (BtnB), Button Power (BtnPWR).
[*]IMU: Integrated MPU6886 6-axis IMU for motion detection and orientation sensing.
[*]LED: Green LED (non-programmable) (sleep status indicator).
[*]Red LED: (same control pin GPIO19 as infrared transmitter tube).
[*]Buzzer: built-in buzzer.
[*]MIC: SPM1423.
[*]RTC: BM8563.
[*]PIN ports: GPIO0, GPIOG25/GPIO36, GPIO26, GPIO32, GPIO33.
[*]Antenna 	2.4G 3D Antenna.
[/LIST]
[HR][/HR]

[B]Wiring & Test Setup[/B]

[HR][/HR]

[B]Files[/B]
The [I]rM5StickCPlus2-NNN.zip[/I] archive contains the library and sample projects.
[HR][/HR]

[B]Install[/B]
Copy the [I]rM5StickCPlus2[/I] library folder from the archive into your B4R [B]Additional Libraries[/B] folder, keeping the folder structure intact.
[HR][/HR]

[B]Wiring[/B]
[U]Sensor = Arduino[/U]
[CODE]
SEN0466 = Arduino UNO / ESP32
VCC = 3V3 / 3V3
GND = GND / GND
D/T SDA = A4 / GPIO21 (Green) - Data / Transmit
C/R SCL = A5 / GPIO22 (Blue) - Clock / Receive
[/CODE]
[U]I2C Address[/U]
Sensor default address: 0x74 (Ensure SEL dip switch set to 0).
[HR][/HR]

[B]Function Overview[/B]
[B]Core Initialization[/B]
[LIST]
[*]Initialize() — basic device setup (M5 core + power module, LCD clear)
[*]InitializeWithButtonEvent(SubVoidByte) — optional button event registration with poller (BtnA, BtnB, BtnPWR)
[*]InitializeWithRTC(Timezone As String) — setup with RTC and NTP sync (clears display)
[/LIST]

[B]Display / Text[/B]
[LIST]
[*]Clear() — clears the display
[*]ClearArea(x, y, w, h) — clears rectangular area
[*]ClearTextArea(x, y, B4RString, textSize) — clears background for a text area
[*]SetBrightness(byte) — set backlight brightness (0–255)
[*]SetRotation(int) / getRotation() — sets/gets LCD rotation (0–3)
[*]SetCursor(x, y) — sets text cursor
[*]SetTextSize(size) — sets font size (1–7)
[*]SetTextColor(color) — sets text color (RGB565)
[*]Print(B4RString*) — prints text at current cursor
[*]PrintCentered(xCenter, y, B4RString, textSize, textColor) — prints centered text
[*]PrintNum(float) — prints float with 2 decimals
[*]PrintNumDecimals(float, decimals) — prints float with specified decimals
[*]SetTextAt(x, y, B4RString, textSize, textColor) — prints text at coordinates
[*]GetTextLengthInPixel(B4RString) — returns pixel width of text
[*]GetFontWidth() / GetFontHeight() — returns font metrics
[/LIST]

[B]UI / Layout Helpers[/B]
[LIST]
[*]SetHeader(B4RString, textSize, alignment, fgColor, bgColor, clear) — displays header
[*]SetFooter(B4RString, textSize, alignment, fgColor, bgColor, clear) — displays footer
[*]SetHorLine(y, color, thickness) — draws horizontal line
[*]StartWrite() / EndWrite() — begin/end LCD batch writes
[*]GetWidth() / GetHeight() — LCD dimensions
[*]GetCenterX() / GetCenterY() — LCD center coordinates
[*]IsPortrait() — returns true if portrait mode
[/LIST]

[B]Buttons / Events[/B]
[LIST]
[*]ButtonA_Pressed() — true if Button A pressed
[*]ButtonB_Pressed() — true if Button B pressed
[*]Event: KeyPressed(Key As Byte) — event fired for BtnA, BtnB, BtnPWR (when InitializeWithButtonEvent used)
[/LIST]

[B]Power / Battery[/B]
[LIST]
[*]BatteryLevel() — returns battery level in %
[*]BatteryVoltage() — returns battery voltage in mV
[*]IsBatteryLow() — true if voltage below low threshold
[*]IsBatteryCritical() — true if voltage below critical threshold
[*]BatteryCheck(thresholdMv, delayMs) — battery health check, optionally triggers shutdown
[*]DrawBattery(voltage, showPercent) — draws battery icon with optional percentage
[*]SetLed(state) — set power LED on/off
[*]PowerOff() — powers off the device
[/LIST]

[B]RTC / Time[/B]
[LIST]
[*]RTC_IsEnabled() — returns true if RTC enabled
[*]RTC_SetDateTime(year, month, day, hour, minute, second) — set full RTC date/time
[*]RTC_SetDate(year, month, day) — set date
[*]RTC_SetTime(hour, minute, second) — set time
[*]RTC_UpdateDateTime() — refresh internal date/time vars from RTC
[*]RTC_Date() / RTC_Month() / RTC_Year() — get date parts
[*]RTC_Hour() / RTC_Minute() / RTC_Second() — get time parts
[*]RTC_DayOfWeek() — get day of week (0–6)
[*]RTC_GetTimeString() — returns formatted time "HH:MM:SS"
[*]RTC_GetDateString() — returns formatted date "DD/MM/YYYY"
[*]RTC_SetDateTimeFromNTP(Timezone As String) — obtain date/time from NTP and update RTC
[/LIST]

[B]Constants[/B]
[LIST]
[*]M5_LCD_WIDTH / M5_LCD_HEIGHT — LCD pixel dimensions
[*]M5_ROTATION_PORTRAIT / LANDSCAPE / PORTRAIT_INV / LANDSCAPE_INV — rotation constants
[*]UI_TEXTSIZE_MIN / UI_TEXTSIZE_MAX / UI_TEXTSIZE_DEFAULT — text size constants
[*]UI_ALIGN_LEFT / UI_ALIGN_CENTER / UI_ALIGN_RIGHT — alignment constants
[*]COLOR_... — predefined color constants (TFT_ compatible)
[*]M5_BUTTON_A / M5_BUTTON_B / M5_BUTTON_PWR — button IDs (aliases: BTN_A, BTN_B, BTN_PWR)
[*]M5_ON / M5_OFF — on/off constants
[*]M5_BATTERY_FULL / MID / LOW / CRITICAL — battery thresholds (mV)
[*]RM5STICKCPLUS2_VERSION — library version constant
[/LIST]

[B]Examples[/B]
[LIST]
[*]HelloWorld - Print the string Hello World and more (see below Basic Example).
[*]Buttons - Test the buttons A (big button), B (top left), PWR (bottom right).
[*]BatteryCheck - Check the battery level and if below threshold, shut the M5StickCPlus2 down.
[*]RTC - Real Time Clock test with time set manually and display showing time & date updated every second via timer.
[*]RTCNTP - Real Time Clock test with time set from NTP server and display showing time & date updated every second.
[*]COSensor - Reads CO gas concentration, VO voltage, and on-board temperature from a CO-sensor.
[*]COSensorHomeAssistant - Reads CO gas concentration, VO voltage, and on-board temperature from a CO-sensor connected to the M5StickCPlus2 and publish to Home Assistant (HA).
[/LIST]

[B]Basic Example[/B]
[CODE=b4x]
Sub Process_Globals
	Public Serial1 As Serial
	Private m5 As M5StickCPlus2
End Sub

Private Sub AppStart
	Serial1.Initialize(115200)
	Log("[Main.AppStart]")

	' Init the device
	m5.Initialize
	Log("[Main.AppStart][I] M5 initialized.")
	
	' Show the red led beside the button power
	m5.SetLed(True)
	
	' Display mode landscape (power supply right)
	m5.Rotation = m5.M5_ROTATION_LANDSCAPE
	Log("[Main.AppStart][I] Rotation portrait=", m5.IsPortrait)

	m5.SetHeader("Basic Demo", 2, m5.UI_ALIGN_CENTER, m5.COLOR_GREEN, m5.COLOR_BLACK, True)
	m5.SetHorLine((m5.GetFontHeight * 2), m5.COLOR_WHITE, 2)

	' LCD Display
	Log("[Main.AppStart][I] LCD width/height=", m5.GetWidth,"/",m5.GetHeight)
	' [Main.AppStart][I] LCD width/height=240/135
	
	Log("[Main.AppStart][I] LCD center x/y=", m5.GetCenterX, "/", m5.GetCenterY)
	' [Main.AppStart][I] LCD center x/y=120/67
	
	' Text size 1 (default)
	Log("[Main.AppStart][I] Textsize 1 width/height=", m5.GetFontWidth, "/", m5.GetFontHeight)
	' [Main.AppStart][I] Textsize 3 width/height=18/24
	
	' Text size 3
	m5.SetTextSize(3)
	Log("[Main.AppStart][I] Textsize 3 width/height=", m5.GetFontWidth, "/", m5.GetFontHeight)
	' [Main.AppStart][I] Textsize 3 width/height=18/24

	m5.SetTextColor(m5.COLOR_WHITE)
	m5.SetTextAt(20, 50, "Hello World", 3, m5.COLOR_WHITE)
	
	' Text length for text size 3 (font width 18) and text hello world (11 characters)
	Log("[Main.AppStart][I] Textsize 3 'Hello World' length=", m5.GetTextLengthInPixel("Hello World"))
	' [Main.AppStart][I] Textsize 3 'Hello World' length=198
	' 198 = 11 characters * font width 18
	
	' Set text centered X at lcd bottom
	m5.SetHorLine(m5.GetHeight - (m5.GetFontHeight * 1), m5.COLOR_WHITE, 1)	
	m5.SetFooter("rStickCPlus2", 1, m5.UI_ALIGN_CENTER, m5.COLOR_GREEN, m5.COLOR_RED, True)
End Sub
[/CODE]
[HR][/HR]

[B]ToDo[/B]
[LIST]
[*]Test with hardware M5 StickC-Plus2.
[*]Enhance graphics.
[*]Develop examples [Home Assistant Workbook Experiments](https://github.com/rwbl/Home-Assistant-Workbook-Experiments).
[/LIST]
[HR][/HR]

[B]Credits[/B]
M5 for the libraries.

[B]Disclaimer[/B]
[LIST]
[*]This project is developed for personal use only.
[*]All examples and code are provided as-is and should be used [B]at your own risk[/B].
[*]Any guidance provided as-is, without any guarantee or liability for errors, omissions, or wrong configurations.
[*]Always test thoroughly and exercise caution when connecting hardware components.
[/LIST]

[B]Licenses[/B]
[LIST]
[*]M5 Libraries: MIT License. Copyright (c) 2021 M5Stack.
[*]rM5StickCPlus2: MIT License (see LICENSE file).
[/LIST]

[B]Additional Information[/B]
[B]Pin Mapping ESP32-PICO-V3-02[/B]
**Red LED & IR Emitter | Button A | Button B | Buzzer**
```
Red LED & IR Emitter = GPIO19
Button A = GPIO37
Button B = GPIO39
Button C (PWR) = GPIO35
Buzzer = GPIO2
```

**Color TFT Display (Driver IC: ST7789V2, Resolution: 135 × 240)**
```
TFT_MOSI = GPIO15 	
TFT_CLK = GPIO13 	
TFT_DC = GPIO14
TFT_RST = GPIO12
TFT_CS = GPIO5
TFT_BL = GPIO27
```

**Microphone MIC (SPM1423)**
```
CLK = GPIO0	
DATA = GPIO34
```

**6-Axis IMU (MPU6886) & RTC BM8563**
```
IMU MPU6886: SCL = GPIO22, SDA = GPIO21
BM8563: SCL = GPIO22, SDA = GPIO21
IR Emitter = TX
Red LED = TX
```

[B]RTC with NTP[/B]
The NTP sync has to be done prior initializing the M5 (because the M5 reinits the RTC after M5.begin).
In the example, the NTP timezone is set to `CET-1CEST,M3.5.0,M10.5.0/3`. See timezone [list](http://github.com/nayarsystems/posix_tz_db/blob/master/zones.csv).
