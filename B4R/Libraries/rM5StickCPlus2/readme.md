### rM5StickCPlus2 by rwblinn
### 10/23/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/169078/)

**B4R Library rM5StickCPlus2**  

---

  
  
**Brief  
rM5StickPlus2** is an open-source library for the **M5 StickC-Plus2**.  
  
This library  

- has been developed for M5 StickC-Plus devices with dedicated functionality to be integrated in author's Smart Home, like Solar Battery Monitor, CO-Sensor Living Room, Quick Info Display, but also to be used in other creations.
- is partially wrapped from the [M5Stack libraries](https://github.com/m5stack) (MIT license) M5Unified, M5GFX.
- is enhanced with custom functions & constants covering LCD control, Buttons (A Big in the middle, B Small top left, C Small bottom right Power) event, Battery management.
- has been developed to display text and dedicated graphics (like battery state icon) only.
- does not support following device features IMU, speaker, buzzer, MIC, IR emitter.
- **is in an early stage - not all functions tested; functions might change.**

---

  
  
**Development Info**  

- Written in C++ - Arduino IDE 2.3.6, Arduino CLI 1.2.2 and the B4Rh2xml tool.
- Arduino IDE Library dependencies:

- M5Unified 0.2.10, M5GFX 0.2.15.

- B4R Additional libraries used in the examples (download from this forum):

- rESP8266WiFi 1.60, rDFRobot\_MultiGasSensor 1.00, rConvert 1.40.

- Tested with

- Hardware - M5 StickC-Plus, M5 StickC-Plus2.
- Software - B4R 4.00 (64-bit).

---

  
  
**M5 StickC-Plus2 Features**  

- Micro-controller: ESP32-PICO-V3-02 240MHz dual core,support WiFi,2 MB SPI PSRAM,8 MB SPI flash.
- Power Input: 5V @ 500mA.
- Ports: USB Type-C, GROVE (I2C + I/0 + UART).
- Display: 1.14-inch Colorful TFT LCD screen, resolution 135 x 240 pixels, driver ST7789v2.
- Battery: built-in 200mAh @ 3.7V LiPo battery, rechargeable via USB Type-C port.
- Buttons: Button A (BtnA), Button B (BtnB), Button Power (BtnPWR).
- IMU: Integrated MPU6886 6-axis IMU for motion detection and orientation sensing.
- LED: Green LED (non-programmable) (sleep status indicator).
- RED LED: (same control pin GPIO19 as infrared transmitter tube).
- Buzzer: built-in buzzer, MIC: SPM1423, RTC: BM8563.
- PIN ports: GPIO0, GPIOG25/GPIO36, GPIO26, GPIO32, GPIO33.
- Antenna: 2.4G 3D Antenna.

---

  
  
**Screenshots from some of the examples**  
  
![](https://www.b4x.com/android/forum/attachments/167914)  

---

  
  
**Files**  
The *rM5StickCPlus2-NNN.zip* archive contains the library and sample projects.  

---

  
  
**Install**  
Copy the *rM5StickCPlus2* library folder from the archive into your B4R **Additional Libraries** folder, keeping the folder structure intact.  

---

  
  
**Wiring**  
See examples.  

---

  
  
**Function Overview (one-liners)**  

- Initialize - Initializes the M5 core and power module.
- InitializeWithButtonEvent - Initializes the M5 core and power module with button event.
- InitializeWithRTC - Initializes the RTC, M5 core and power module.
- Clear - Clears the LCD screen using the default background color.
- ClearColor - Clears the LCD screen and sets a new color.
- ClearArea - Clears a rectangular area with the current background color.
- ClearTextArea - Clears a rectangular area with the current background color.
- SetBrightness - Sets the backlight brightness in the range 0-255.
- SetCursor - Sets the text cursor position.
- SetTextSize - Sets the text size multiplier (only affects bitmap fonts).
- SetTextColor - Sets the text color for all subsequent prints.
- Print - Prints a string at the current cursor position.
- PrintCentered - Prints text centered at (xCenter, y) with optional background.
- PrintNum - Prints a floating-point number with 2 decimal places.
- PrintNumDecimals - Prints a floating-point number with the given decimal places.
- SetTextAt - Prints a string at a specific screen position.
- GetTextLengthInPixel - Gets the length of a string in pixels.
- SetHeader - Displays a header text at the top of the screen, with optional background clearing.
- SetFooter - Displays a footer text at the bottom of the screen, with optional background clearing.
- SetHorLine - Draws a horizontal line at the specified Y position.
- UpdateFontMetrics - Updates the current font metrics.
- GetFontWidth - Gets the approximate width of the current font in pixels.
- GetFontHeight - Gets the height of the current font in pixels.
- SetFreeFont - Sets the free font (ignores SetTextSize and has a fixed scale).
- SetTextFont - Sets the current text font (1–4) and scaling factor.
- SetDigitFont - Sets a large numeric font (6–8) optimized for displaying digits.
- SetFontDefault - Resets the LCD to the default font.
- DrawRect - Draws a rectangle.
- FillRect - Draws a filled rectangle.
- DrawRoundRect - Draws a rectangle with rounded corners.
- FillRoundRect - Draws a filled rectangle with rounded corners.
- DrawCircle - Draws a circle.
- FillCircle - Draws a filled circle.
- DrawLine - Draws a line between two points.
- StartWrite - Starts writing to the LCD.
- EndWrite - Ends writing to the LCD.
- GetWidth - Gets the width of the LCD.
- GetHeight - Gets the height of the LCD.
- GetCenterX - Gets the center X position of the LCD.
- GetCenterY - Gets the center Y position of the LCD.
- IsPortrait - Checks if the display is in portrait mode.
- ButtonA\_Pressed - Checks whether Button A is currently pressed.
- ButtonB\_Pressed - Checks whether Button B is currently pressed.
- BatteryLevel - Returns the battery charge level.
- BatteryVoltage - Returns the current battery voltage.
- IsBatteryLow - Checks whether the battery is considered low.
- IsBatteryCritical - Checks whether the battery is considered critical.
- BatteryCheck - Performs battery health check and optionally powers off if voltage too low.
- DrawBattery - Draws a small battery icon at top right with optional percentage and tiny outlined battery level bar.
- SetLed - Sets the state of the power LED.
- PowerOff - Powers the device off.
- RTC\_IsEnabled - Checks if the RTC is enabled.
- RTC\_SetDateTime - Sets the RTC date and time.
- RTC\_SetDate - Sets the RTC date.
- RTC\_SetTime - Sets the RTC time.
- RTC\_UpdateDateTime - Updates internal date and time variables from the RTC.
- RTC\_Date - Gets the current date (1–31).
- RTC\_Month - Gets the current month (1–12).
- RTC\_Year - Gets the current year (2000 + NNN).
- RTC\_Hour - Gets the current hour (0–23).
- RTC\_Minute - Gets the current minute (0–59).
- RTC\_Second - Gets the current second (0–59).
- RTC\_DayOfWeek - Gets the current day of week (0–6).
- RTC\_GetTimeString - Gets the current time as formatted string.
- RTC\_GetDateString - Gets the current date as formatted string.
- RTC\_SetDateTimeFromNTP - Gets the date and time from the NTP server and sets the class vars.
- DrawIconBattery - Draws a battery icon with level indicator.
- DrawIconWiFi - Draws a Wi-Fi signal icon.
- DrawIconSolar - Draws a simple solar icon.
- DrawIconGrid - Draws a grid (power) icon.
- DrawIconTemp - Draws a temperature icon.

---

  
  
**Examples**  

- Basic - Print the string Hello World and more (see below Basic Example).
- Buttons - Test the buttons A (big button), B (top left), PWR (bottom right).
- BatteryCheck - Check the battery level and if below threshold, shut the M5StickCPlus2 down.
- RTC - Real Time Clock test with time set manually and display showing time & date updated every second via timer.
- RTCNTP - Real Time Clock test with time set from NTP server and display showing time & date updated every second.
- COSensor - Reads CO gas concentration, VO voltage, and on-board temperature from a CO-sensor.
- COSensorHomeAssistant - Reads CO gas concentration, VO voltage, and on-board temperature from a CO-sensor connected to the M5StickCPlus2 and publish to Home Assistant (HA).
- PowerPanelHomeAssistant - Sent in regular interval (60s) a HTTP GET request to the Home Assistant (HA) server, parse the response containing solar data and display.
- Fonts - Show some of the built-in fonts.
- Icons - Show icon examples.

---

  
  
**Basic Example**  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Private m5 As M5StickCPlus2  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("[Main.AppStart]")  
  
    ' Init the device  
    m5.Initialize  
    Log("[Main.AppStart] M5 initialized.")  
   
    ' Show the red led beside the button power  
    m5.SetLed(True)  
   
    ' Display mode landscape (power supply right)  
    m5.Rotation = m5.M5_ROTATION_LANDSCAPE  
    Log("[Main.AppStart] Rotation portrait=", m5.IsPortrait)  
  
    m5.SetHeader("Basic Demo", 2, m5.UI_ALIGN_CENTER, m5.COLOR_GREEN, m5.COLOR_BLACK, True)  
    m5.SetHorLine((m5.GetFontHeight * 2), m5.COLOR_WHITE, 2)  
  
    ' LCD Display  
    Log("[Main.AppStart] LCD width/height=", m5.GetWidth,"/",m5.GetHeight)  
    ' [Main.AppStart] LCD width/height=240/135  
   
    Log("[Main.AppStart] LCD center x/y=", m5.GetCenterX, "/", m5.GetCenterY)  
    ' [Main.AppStart] LCD center x/y=120/67  
   
    ' Text size 1 (default)  
    Log("[Main.AppStart] Textsize 1 width/height=", m5.GetFontWidth, "/", m5.GetFontHeight)  
    ' [Main.AppStart] Textsize 3 width/height=18/24  
   
    ' Text size 3  
    m5.SetTextSize(3)  
    Log("[Main.AppStart] Textsize 3 width/height=", m5.GetFontWidth, "/", m5.GetFontHeight)  
    ' [Main.AppStart] Textsize 3 width/height=18/24  
  
    m5.SetTextColor(m5.COLOR_WHITE)  
    m5.SetTextAt(20, 50, "Hello World", 3, m5.COLOR_WHITE)  
   
    ' Text length for text size 3 (font width 18) and text hello world (11 characters)  
    Log("[Main.AppStart] Textsize 3 'Hello World' length=", m5.GetTextLengthInPixel("Hello World"))  
    ' [Main.AppStart] Textsize 3 'Hello World' length=198  
    ' 198 = 11 characters * font width 18  
   
    ' Set text centered X at lcd bottom  
    m5.SetHorLine(m5.GetHeight - (m5.GetFontHeight * 1), m5.COLOR_WHITE, 1)  
    m5.SetFooter("rStickCPlus2", 1, m5.UI_ALIGN_CENTER, m5.COLOR_GREEN, m5.COLOR_RED, True)  
End Sub
```

  

---

  
  
**To Do**  

- Improve example PanelPanelHomeAssistant and publish as B4R Creation (also on GitHub). Place the device on the Solar Battery as Indicator.

---

  
  
**Credits**  

- M5 for the M5Stack Open Source libraries ([here](http://github.com/m5stack)).

---

  
  
**Disclaimer**  

- This project is developed for personal use only.
- All examples and code are provided as-is and should be used at your own risk.
- Any guidance provided as-is, without any guarantee or liability for errors, omissions, or wrong configurations.
- Always test thoroughly and exercise caution when connecting hardware components.

---

  
  
**Licenses**  

- M5 Libraries: MIT License. Copyright © 2021 M5Stack.
- rM5StickCPlus2: MIT License (see LICENSE file).