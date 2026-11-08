/**
 * @file        rM5StickCPlus2.h
 * @brief       B4R library for the device M5 StickC-Plus2.
 * @note		Uses the libraries:  
 * 				- M5Unified: https://github.com/m5stack/M5Unified  
 * 				- M5GFX: https://github.com/m5stack/M5GFX  
 * @note		Function names follow B4X standards and Arduino-library idioms.
 * @note		Following device features not supported: IMU, speaker, buzzer, MIC, IR emitter.
 * @note		Colors are defined as int and cast to (uint16_t).
 * @author      Robert W.B. Linn  
 * @date        2025-10-21
 * 				Ensure the version constant is also updated (at end of this header file)
 * @license     MIT © 2025 Robert W.B. Linn  
 */

#pragma once
// B4RDefines 
#include "B4RDefines.h"

// M5Unified & M5GFX installed in the Arduino IDE 
#include <M5Unified.h>

namespace B4R {
	
    //~Version: 0.40
	//~Event: KeyPressed (Key As String)
    //~shortname: M5StickCPlus2

	// Define the event parameter byte for the key numbers
	typedef void (*SubVoidByte)(Byte Key);
	
    /**
     * @class B4RM5StickCPlus2
     * @brief Wrapper class that exposes the M5Unified library for the M5 StickC-Plus2 to B4R.
	 * 
	 * Provides access to display, button, and power functionality of the M5StickC Plus2
	 * via simple B4R-compatible methods and constants.
     */
    class B4RM5StickCPlus2 {
        private:

			// =========================================================
			// --- LCD ---
			// =========================================================
		
			// Store the current display rotation
			Byte currentRotation;
		
			// =========================================================
			// --- Buttons ---
			// =========================================================
			
			// Pointer to the B4R event sub
			SubVoidByte KeyPressedSub;

			// Poller node for periodic update
			PollerNode pnode;

			// Static polling function listening to button press
			static void looper(void* b);

			// =========================================================
			// --- RTC ---
			// =========================================================
			Byte rtcDate;
			Byte rtcMonth;
			int rtcYear;
			Byte rtcHours;
			Byte rtcMinutes;
			Byte rtcSeconds;
			Byte rtcDayOfWeek;

			// =========================================================
			// --- Font metrics cache (for B4R-safe access) ---
			// =========================================================
			int currentFontWidth = 0;
			int currentFontHeight = 0;

        public:

			// =========================================================
			// --- Device ---
			// =========================================================

            /** 
			 * @brief Initializes the M5 core and power module.
			 *
			 * @note Performs display and power subsystem setup. Clears the display after initialization.
			 *
			 * @return True if initialization succeeded, False otherwise.
			 */
            void Initialize();

            /** 
			 * @brief Initializes the M5 core and power module with button event.
			 *
			 * @note Performs display and power subsystem setup. Clears the display after initialization.
			 * @note Enables to use the 3 buttons BtnA, BtnB, BtnPWR with event.
			 *
			 * @param String Callback method defined in the B4R code.
			 */
            void InitializeWithButtonEvent(SubVoidByte KeyPressedSub);

            /** 
			 * @brief Initializes the RTC, M5 core and power module.
			 *
			 * @note Performs NTP sync, display and power subsystem setup. Clears the display after initialization.
			 *
			 * @param String timezone Local timezone. See list of timezones github.com/nayarsystems/posix_tz_db/blob/master/zones.csv
			 * @note Europe/Berlin "CET-1CEST,M3.5.0,M10.5.0/3"
			 *
			 * @return True if initialization succeeded, False otherwise.
			 */
            bool InitializeWithRTC(B4RString* timezone);

            // =========================================================
			// --- Display ---
            // =========================================================

			/**
			 * @brief Clears the LCD screen using the default background color.
			 */
			void Clear();
			
			/**
			 * @brief Clears the LCD screen and sets a new color.
			 *
			 * @param int bgColor Background color
			 */
			void ClearColor(int bgColor);
			
			/**
			 * @brief Clears a rectangular area with the current background color
			 */
			void ClearArea(int x, int y, int w, int h);

			/**
			 * @brief Clears a rectangular area with the current background color
			 */
			void ClearTextArea(int x, int y, B4RString* text, int textSize);
			
			/**
			 * @brief Set the backlight brightness in the range 0-255.
			 *
			 * @param Byte Brightness value (0–255).
			 */
			void SetBrightness(Byte brightness);

			/**
			 * @brief Sets/gets the display rotation.
			 *
			 * @param rotation Rotation value (0–3). Use predefined constants (e.g., M5_ROTATION_LANDSCAPE).
			 */
			void setRotation(Byte rotation);
			Byte getRotation(void);
	
			/**
			 * @brief Sets the text cursor position.
			 * 
			 * @param x X-coordinate in pixels.
			 * @param y Y-coordinate in pixels.
			 */
			void SetCursor(int x, int y);

			/**
			 * @brief Sets the text size multiplier > only affects bitmap fonts.
			 * 
			 * @param size Float text size multiplier (1 = normal size).
			 */
			void SetTextSize(float size);

			/**
			 * @brief Sets the text color for all subsequent prints.
			 * 
			 * @param color TFT color constant (e.g., TFT_WHITE).
			 */
			void SetTextColor(int color);

			/**
			 * @brief Prints a string at the current cursor position.
			 * 
			 * @param text Pointer to a B4RString object containing the text to print.
			 */
			void Print(B4RString* text);

			/**
			 * Print text centered at (xCenter, y) with optional background.
			 * @param xCenter X center position
			 * @param y Y position
			 * @param text Text to print
			 * @param textSize Text size (1–7). If negative, keeps current size
			 * @param textColor Text color
			 * @param bgColor Optional background color. If negative, background is NOT drawn
			 */
			void PrintCentered(int xCenter, int y, B4RString* text, int textSize, int textColor, int bgColor);

			/**
			 * @brief Prints a floating-point number with 2 decimal places.
			 * 
			 * @param value Float value to print.
			 */
			void PrintNum(float value);

			/**
			 * @brief Prints a floating-point number with the given decimal places.
			 * 
			 * @param value Float value to print.
			 */
			void PrintNumDecimals(float value, Byte decimals);

			/**
			 * @brief Prints a string at a specific screen position.
			 * 
			 * @param x X-coordinate in pixels.
			 * @param y Y-coordinate in pixels.
			 * @param text Pointer to a B4RString object containing the text to print.
			 * @param textSize The text size (1–7 typical for the M5.Lcd). If negative (-1), current size is used.
			 * @param textColor The text color in RGB565 format.
			 */
			void SetTextAt(int x, int y, B4RString* text, int textSize, int textColor);

			/**
			 * @brief Get the length of a string in pixel.
			 * 
			 * @param text Pointer to a B4RString object containing the text to measure.
			 * 
			 * @note Example: text length in pixel for the text "Hello World" and text size 3.
			 * @note 198 = 11 characters * font width 18 pixel.
			 *
			 * @return int Length of the string in pixel.
			 */
			int GetTextLengthInPixel(B4RString* text);

			/**
			 * @brief Displays a header text at the top of the screen, with optional background clearing.
			 *
			 * @param text The text to display.
			 * @param int textSize The text size (1–7 typical for M5.Lcd).
			 * @param int alignment Text alignment: 0 = left, 1 = center, 2 = right.
			 * @param int fgColor Foreground (text) color in RGB565 format.
			 * @param int bgColor Background color in RGB565 format.
			 * @param bool clear The background is cleared when true.
			 */
			void SetHeader(B4RString* text, int textSize, int alignment, int fgColor, int bgColor, bool clear);
		
			/**
			 * @brief Displays a footer text at the bottom of the screen, with optional background clearing.
			 *
			 * @param text The text to display.
			 * @param int textSize The text size (1–7 typical for M5.Lcd).
			 * @param int alignment Text alignment: 0 = left, 1 = center, 2 = right.
			 * @param int fgColor Foreground (text) color in RGB565 format.
			 * @param int bgColor Background color in RGB565 format. If negative (-1), the background is not cleared.
			 * @param bool clear The background is cleared when true.
			 */
			void SetFooter(B4RString* text, int textSize, int alignment, int fgColor, int bgColor, bool clear);

			/**
			 * @brief Draws a horizontal line at the specified Y position.
			 *
			 * @param int y Y position in pixels.
			 * @param int color Line color in RGB565 format.
			 * @param int thickness Line thickness in pixels.
			 */
			void SetHorLine(int y, int color, int thickness);

            // =========================================================
			// --- FONTS ---
            // =========================================================
			/**
			 * Note: M5.Lcd.fontWidth() and M5.Lcd.fontHeight() only return nonzero values for certain built-in fonts — typically the monospaced bitmap fonts (1–4).
			 * For proportional or digit fonts (6–8) and FreeFonts, these fields are often not initialized by the font data, so fontWidth() can return 0.
			 * Works: FONT1–FONT4 (bitmap monospace fonts)
			 * Returns 0: FONT6–FONT8 and FreeFonts (since glyphs have variable widths)
             */

			/**
			 * @brief Updates the current font metrics.
			 * 
			 * @details
			 * Retrieves reliable width, height, and baseline metrics for the active font.
			 * Handles special cases where built-in digit or proportional fonts report
			 * width = 0 by using fallback measurement.
			 * 
			 * @note Should be called after changing the font or text size.
			 */
			void UpdateFontMetrics();

			/**
			 * @brief Get the approximate width of the current font in pixels.
			 *
			 * @details 
			 * For built-in bitmap fonts (ID 1–4), this returns the exact monospace character width.
			 * For proportional or digit fonts (ID 6–8) and FreeFonts, the internal width may be undefined
			 * and reported as 0. In that case, a fallback is used that measures the width of the digit '0'.
			 *
			 * @note 
			 * This function provides an approximate average character width. 
			 * Use `textWidth(const char*)` for accurate text length measurement.
			 *
			 * @return Average character width in pixels (never 0).
			 */
			int GetFontWidth();

			/**
			 * @brief Get the height of the current font in pixels.
			 *
			 * @details 
			 * For most built-in fonts, this returns the font’s nominal pixel height. 
			 * For proportional or FreeFonts, this value may vary depending on the glyph.
			 *
			 * @note 
			 * This value is usually correct even when `fontWidth()` returns 0.
			 *
			 * @return Font height in pixels.
			 */
			int GetFontHeight();

			/**
			 * @brief Sets the free font > ignores SetTextSize and has a fixed scale.
			 *
			 * @note FreeSansBold24pt7b, Large, Big numbers (e.g., battery %)
			 * @note FreeSansBold18pt7b, Medium, Headers
			 * @note FreeMono12pt7b, Small, Data labels
			 * @note Default, default , UI text
			 * 
			 * @param int id value (0–3). Use predefined constants (e.g., UI_FONT_MONO12).
			 */
			void SetFreeFont(int fontId);

			/**
			 * @brief Sets the current text font (1–4) and scaling factor.
			 *
			 * This method configures one of the standard built-in bitmap fonts (1–4)
			 * used for general UI text. Font 1 is the default small monospace font,
			 * while Font 4 provides a larger, more readable size for headings.
			 *
			 * @param fontId    Font ID in the range [1–4]. Values outside the range
			 *                  are clamped automatically to valid limits.
			 * @param textSize  Text scaling factor (zoom). Values outside the range
			 *                  [UI_TEXTSIZE_MIN–UI_TEXTSIZE_MAX] are clamped automatically.
			 *
			 * @note FreeFont is disabled internally before applying the new font.
			 * @see SetDigitFont
			 * @see SetFontDefault
			 */
			void SetTextFont(int fontId, float textSize);

			/**
			 * @brief Sets a large numeric font (6–8) optimized for displaying digits.
			 *
			 * This method configures one of the built-in large fonts (6–8) that are
			 * optimized for numeric displays such as voltages, temperatures, or
			 * other dashboards. These fonts typically support digits only (0–9)
			 * and are fixed-size (not scalable).
			 *
			 * FONT6 = Bold rounded numeric font, clean, modern look.
			 * FONT7 = 7-segment LED style, perfect for clock or power meters.
			 * FONT8 = Very large block digits, ideal for full-screen readings, Keep size 1 to display 4 digits.
			 *
			 * @param fontId  Font ID in the range [6–8]. Values outside the range
			 *                are clamped automatically to valid limits.
			 * @param textSize  Text scaling factor (zoom).
			 *                  Min value is 1.
			 *
			 * @note FreeFont is disabled internally before applying the new font.
			 * @see SetTextFont
			 * @see SetFontDefault
			 */
			void SetDigitFont(int fontId, float textSize);

			/**
			 * @brief Reset the LCD to the default font.
			 * 
			 * This disables any active FreeFont and sets the built-in FONT 1
			 * with default text size (1). Useful to return to a known state.
			 * 
			 * @note After calling this, any previously set FreeFont or custom
			 *       bitmap font is cleared.
			 */
			void SetFontDefault();

            // =========================================================
			// --- LCD Draw ---
            // =========================================================

            /** 
			 * @brief Drawing functions (self explain).
			 *
			 */
			void DrawRect      	( int x, int y, int w, int h, int color);
			void FillRect      	( int x, int y, int w, int h, int color);
			void DrawRoundRect 	( int x, int y, int w, int h, int r, int color);
			void FillRoundRect 	( int x, int y, int w, int h, int r, int color);
			void DrawCircle		( int x, int y, int r, int color);
			void FillCircle		( int x, int y, int r, int color);
			void DrawLine  		( int x0, int y0, int x1, int y1, int color);

            // =========================================================
			// --- LCD Display ---
            // =========================================================

			/**
			 * @brief Start or end writing to the LCD.
			 */
			void StartWrite();
			void EndWrite();

			/**
			 * @brief Get the width of the LCD.
			 *
			 * @return int Width in pixel of the LCD in pixel.
			 */
			int GetWidth();

			/**
			 * @brief Get the heigth of the LCD.
			 *
			 * @return int Height in pixel of the LCD in pixel.
			 */
			int GetHeight();

			/**
			 * @brief Get the center X position of the LCD.
			 *
			 * @return int Center X.
			 */
			int GetCenterX();

			/**
			 * @brief Get the center Y position of the LCD.
			 *
			 * @return int Center Y.
			 */
			int GetCenterY();

			/**
			 * @brief Checks if the display is in portrait mode.
			 *
			 * @return true Portrait mode else false Landscape mode.
			 */
			bool IsPortrait();

            // =========================================================
			// --- Buttons ---
            // =========================================================

			/**
			 * @brief Checks whether Button A is currently pressed.
			 * 
			 * @return True if Button A is pressed, False otherwise.
			 */
			bool ButtonA_Pressed();

			/**
			 * @brief Checks whether Button B is currently pressed.
			 * 
			 * @return True if Button B is pressed, False otherwise.
			 */
			bool ButtonB_Pressed();

            // =========================================================
			// --- Power / Battery ---
            // =========================================================

			/**
			 * @brief Returns the battery charge level.
			 * 
			 * @return int Battery level in percentage )0-100).
			 */
			int BatteryLevel();
			
			/**
			 * @brief Returns the current battery voltage.
			 * 
			 * @return float Battery voltage in millivolts (0-5000).
			 */
			float BatteryVoltage();
			
			/**
			 * @brief Checks whether the battery is considered low.
			 * 
			 * Compares current voltage against @ref M5_BATTERY_LOW.
			 * 
			 * @return True if battery voltage is below threshold.
			 */
			bool IsBatteryLow();

			/**
			 * @brief Checks whether the battery is considered critical.
			 * 
			 * Compares current voltage against @ref M5_BATTERY_CRITICAL.
			 * 
			 * @return True if battery voltage is below critical threshold.
			 */
			bool IsBatteryCritical();

			/**
			 * @brief Perform battery health check and optionally power off if voltage too low.
			 * 
			 * @param thresholdMv Minimum safe voltage (in mV). 
			 * @note Default uses M5_BATTERY_LOW constant.
			 * @param delayMs Optional delay before power off to display warning (default 3000 ms).
			 * 
			 * @return true if shutdown was triggered, false if battery is OK 
			 */
			bool BatteryCheck(float thresholdMv, Long delayMs);

			/**
			 * @brief Draw small battery icon at top right with optional percentage and tiny outlined battery level bar.
			 * @note Bar colors: Green full (greater 3.8 V), Yellow mid-level, Red for low (less 3.55 V)
			 * 
			 * @param int voltage Measure battery voltage in mV. 
			 * @param bool showPercent to display battery level in percentage 0-100%. 
			 */
			void DrawBattery(int voltage, bool showPercent);
	
			/**
			 * @brief Draw small battery icon with tiny outlined battery level bar.
			 * @note Bar colors: Green full (greater 3.8 V), Yellow mid-level, Red for low (less 3.55 V)
			 */
			//~hide
			void DrawBatteryIcon(int x, int y, float voltage);

			/**
			 * @brief Draw small battery at top right icon with tiny outlined battery level bar.
			 * @note Bar colors: Green full (greater 3.8 V), Yellow mid-level, Red for low (less 3.55 V)
			 */
			//~hide
			void DrawBatteryIconAuto(float voltage);

			/**
			 * @brief Draw small battery icon with percentage and tiny outlined battery level bar.
			 * 
			 * Bar colors: Green full (greater 3.8 V), Yellow mid-level, Red for low (less 3.55 V)
			 */
			//~hide
			void DrawBatteryIconPercentage(int x, int y, float voltage);

			/**
			 * @brief Draw small battery icon at top right with percentage and tiny outlined battery level bar.
			 * 
			 * Bar colors: Green full (greater 3.8 V), Yellow mid-level, Red for low (less 3.55 V)
			 */
			//~hide
			void DrawBatteryIconPercentageAuto(float voltage);

            // =========================================================
			// --- Power ---
            // =========================================================
			
			/**
			 * @brief Set the state of the power LED.
			 */
			void SetLed(bool state);
			
			/**
			 * @brief Power the device off.
			 */
			void PowerOff();

            // =========================================================
			// --- RTC ---
            // =========================================================
			
			/**
			 * @brief Check if the RTC is enabled.
			 * 
			 * @return bool True = enabled, False disabled.
			 */
			bool RTC_IsEnabled();

			/**
			 * @brief Set the RTC date and time.
			 * 
			 * @param int year, Byte month, Byte day, Byte hour, Byte minute, Byte second.
			 */
			void RTC_SetDateTime(int year, Byte month, Byte day, Byte hour, Byte minute, Byte second);
			
			/**
			 * @brief Set the RTC date.
			 * 
			 * @param int year, Byte month, Byte day.
			 */
			void RTC_SetDate(int year, Byte month, Byte day);
			
			/**
			 * @brief Set the RTC time.
			 * 
			 * @param Byte hour, Byte minute, Byte second.
			 */
			void RTC_SetTime(Byte hour, Byte minute, Byte second);

			/**
			 * @brief Update internal date and time variables from the RTC.
			 */
			void RTC_UpdateDateTime(void);

			/**
			 * @brief Get the current date (1–31).
			 */
			Byte RTC_Date(void);
			
			/**
			 * @brief Get the current month (1–12).
			 */
			Byte RTC_Month(void);
			
			/**
			 * @brief Get the current year (2000 + NNN).
			 */
			int  RTC_Year(void);

			/**
			 * @brief Get the current hour (0–23).
			 */
			Byte RTC_Hour(void);

			/**
			 * @brief Get the current minute (0–59).
			 */
			Byte RTC_Minute(void);

			/**
			 * @brief Get the current second (0–59).
			 */
			Byte RTC_Second(void);

			/**
			 * @brief Get the current day of week (0-6).
			 */
			Byte RTC_DayOfWeek(void);

			/**
			 * @brief Get the current time as formatted string.
			 *
			 * @return Time string in format "HH:MM:SS"
			 */
			B4RString* RTC_GetTimeString(void);   
			
			/**
			 * @brief Get the current date as formatted string.
			 *
			 * @return string Date in format "DD/MM/YYYY"
			 */
			B4RString* RTC_GetDateString(void);   

			/**
			 * @brief Get the date and time from the NTP server and set the class vars.
			 * @note List of timezones: https://github.com/nayarsystems/posix_tz_db/blob/master/zones.csv
			 * 
			 * @param timezone See list of timezones github.com/nayarsystems/posix_tz_db/blob/master/zones.csv
			 *
			 * @return true if datetime obtained, false if error 
			 */
			bool RTC_SetDateTimeFromNTP(B4RString* timezone);

            // =========================================================
			// --- Icons ---
            // =========================================================
			
			/**
			 * Draw a battery icon with level indicator
			 * @param startX, startY: top-left corner of the icon
			 * @param voltage: battery voltage
			 */
			void DrawIconBattery(int startX, int startY, float voltage);

			/**
			 * Draw a Wi-Fi signal icon
			 * @param strength: 0–3 bars
			 */
			void DrawIconWiFi(int startX, int startY, int strength);

			/**
			 * Draw a simple solar icon
			 * @param level: 0–100%
			 */
			void DrawIconSolar(int startX, int startY, float level);

			/**
			 * Draw a grid (power) icon
			 * @param active: true = red, false = white
			 */
			void DrawIconGrid(int startX, int startY, bool active);

			/**
			 * Draw a temperature icon
			 * @param tempCelsius: temperature in °C
			 */
			void DrawIconTemp(int startX, int startY, float tempCelsius);

			
            // =========================================================
			// --- Constants ---
            // =========================================================
			/**
			 * Guidance
			 * Category         Prefix	Example
			 * Device/System    M5_  	M5_ROTATION_LANDSCAPE
			 * Display/UI       UI_  	UI_ALIGN_CENTER
			 * Communication	NET_ 	NET_WIFI_OK
			 * Power management	PWR_ 	PWR_LOW_BATTERY
			**/
		
            /**
             * @name Display Constants
             * @brief Defines LCD dimensions in pixels.
             */
			static const int M5_LCD_WIDTH  = 240;   
			static const int M5_LCD_HEIGHT = 135;   

			/**
			 * @name Rotation Constants
			 * @brief Display rotation modes (0–3).
			 * @note Portrait, Landscape, Inverted portrait, Inverted landscape
			 */
			static const Byte M5_ROTATION_PORTRAIT = 0;       
			static const Byte M5_ROTATION_LANDSCAPE = 1;      
			static const Byte M5_ROTATION_PORTRAIT_INV = 2;   
			static const Byte M5_ROTATION_LANDSCAPE_INV = 3;  

			/**
			 * @name UI Text Align Constants
			 * @brief Set align value for SetHeader, SetFooter.
			 */
			static const Byte UI_ALIGN_LEFT   = 0;
			static const Byte UI_ALIGN_CENTER = 1;
			static const Byte UI_ALIGN_RIGHT  = 2;

			/**
			 * @name UI Free Font Constants (fix scale)
			 * @brief Set free font type used to display text. These are fixed scaled.
			 *
			 * @note FreeFonts (fixed size, not scaled by SetTextSize)
			 */
			static const Byte UI_FREEFONT_DEFAULT    = 0;	// fallback built-in font
			static const Byte UI_FREEFONT_SANS9      = 1;	// WxH=6x9
			static const Byte UI_FREEFONT_SANS12     = 2;	// WxH=8x12
			static const Byte UI_FREEFONT_SANS18     = 3;	// WxH=12x18
			static const Byte UI_FREEFONT_SANS24     = 4;	// WxH=16x24
			static const Byte UI_FREEFONT_MONO9      = 5;	// WxH=6x9
			static const Byte UI_FREEFONT_MONO12     = 6;	// WxH=8x12
			static const Byte UI_FREEFONT_MONO18     = 7;	// WxH=12x18
			static const Byte UI_FREEFONT_SERIF12    = 8;	// WxH=8x12
			static const Byte UI_FREEFONT_SERIF18    = 9;	// WxH=12x18
			//static const Byte UI_FREEFONT_7SEG24     = 10; // 7-segment style, 24pt

			/**
			 * @name UI Text Font Constants (bitmap fonts)
			 * @brief Built-in bitmap fonts for general text (ASCII characters).
			 *
			 * @note Scaled via setTextSize(n). Full ASCII supported.
			 */
			// Font ID: 1, Name: FONT 1, Pixel size (WxH): 5×7, Notes: Default font, monospace, very compact, classic 5×7 look.
			static const Byte UI_TEXTFONT_1 = 1;

			// Font ID: 2, Name: FONT 2, Pixel size (WxH): 7×13, Notes: Slightly larger, monospace, good for small labels.                 
			static const Byte UI_TEXTFONT_2 = 2;	

			// Font ID: 4, Name: FONT 4, Pixel size (WxH): 11×18, Notes: Medium size, more readable, standard for UI text.                  
			static const Byte UI_TEXTFONT_4 = 4;	

			// Default Text (same as Font ID 1)
			static const Byte UI_TEXTFONT_DEFAULT = 1;

			/**
			 * @name UI Digit Font Constants (bitmap fonts)
			 * @brief Built-in bitmap fonts for numeric display only.
			 *
			 * @note Digits only (0–9). Recommend scale = 1. Useful for dashboards, meters, numeric indicators.
			 */
			// Font ID: 6, Name: FONT 6, Pixel size (WxH): 16×26, Notes: Large font, clear, good for headings or numeric displays.          
			static const Byte UI_TEXTFONT_6 = 6;	
			static const Byte UI_DIGITFONT_LARGE = 6;     // Alias for FONT6

			// Font ID: 7, Name: FONT 7, Pixel size (WxH): 26×40, Notes: 7-segment style, mostly used for big numbers or indicators.             
			static const Byte UI_TEXTFONT_7 = 7;	
			static const Byte UI_DIGITFONT_LCD = 7;       // Alias for FONT7 / LCD style
			
			// Font ID: 8, Name: FONT 8, Pixel size (WxH): 32×53, Notes: Extra-large font, best for big numeric displays (like dashboards). 
			static const Byte UI_TEXTFONT_8 = 8;
			static const Byte UI_DIGITFONT_XL = 8;        // Alias for FONT8

			/**
			 * @name UI Textsize Constants (bitmap fonts) for TEXTFONT1-4
			 * @brief Set min and max text size (1-10) for only bitmap fonts, not FreeFonts.
			 *
			 * @note Test max 9 or 10.
			 * @note Default size 1 is used when no size specified.
			 */
			static const Byte UI_TEXTSIZE_MIN = 1;
			static const Byte UI_TEXTSIZE_MAX = 10;
			static const Byte UI_TEXTSIZE_DEFAULT = 1;
			
			/**
			 * @name Color Constants
			 * @brief Common color definitions for the LCD.
			 */
			static const int COLOR_BLACK = TFT_BLACK;
			static const int COLOR_NAVY = TFT_NAVY;
			static const int COLOR_DARKGREEN = TFT_DARKGREEN;
			static const int COLOR_DARKCYAN = TFT_DARKCYAN;
			static const int COLOR_MAROON = TFT_MAROON;
			static const int COLOR_PURPLE = TFT_PURPLE;
			static const int COLOR_OLIVE = TFT_OLIVE;
			static const int COLOR_LIGHTGREY = TFT_LIGHTGREY;
			static const int COLOR_DARKGREY = TFT_DARKGREY;
			static const int COLOR_BLUE = TFT_BLUE;
			static const int COLOR_GREEN = TFT_GREEN;
			static const int COLOR_CYAN = TFT_CYAN;
			static const int COLOR_RED = TFT_RED;
			static const int COLOR_MAGENTA = TFT_MAGENTA;
			static const int COLOR_YELLOW = TFT_YELLOW;
			static const int COLOR_WHITE = TFT_WHITE;
			static const int COLOR_ORANGE = TFT_ORANGE;
			static const int COLOR_GREENYELLOW = TFT_GREENYELLOW;
			static const int COLOR_PINK = TFT_PINK;
			static const int COLOR_BROWN = TFT_BROWN;
			static const int COLOR_GOLD = TFT_GOLD;
			static const int COLOR_SILVER = TFT_SILVER;
			static const int COLOR_SKYBLUE = TFT_SKYBLUE;
			static const int COLOR_VIOLET = TFT_VIOLET;
			static const int COLOR_TRANSPARENT = TFT_TRANSPARENT;

			/**
			 * @name Button Constants
			 * @brief Define 3 buttons to be used by the button event.
			 * @note BtnA GPIO37, BtnB GPIO39, BtnPWR GPIO35.
			 */
			static const Byte M5_BUTTON_A 	= 0;   			
			static const Byte M5_BUTTON_B 	= 1;   			
			static const Byte M5_BUTTON_PWR	= 2; 

			// Aliases for developer comfort for those familiar with Arduino M5 APIs (BtnA, BtnB)
			static const Byte BTN_A 	= M5_BUTTON_A;
			static const Byte BTN_B 	= M5_BUTTON_B;
			static const Byte BTN_PWR	= M5_BUTTON_PWR;
			
			/**
			 * @name ON/OFF Constants
			 * @brief Define ON or OFF constants.
			 */
			static const int M5_ON  = true;   			
			static const int M5_OFF = false;   			

			/**
			 * @name Battery Level Constants
			 * @brief Define 4 battery levels in mV.
			 */
			static const int M5_BATTERY_FULL 		= 4200;
			static const int M5_BATTERY_MID  		= 3800;		
			static const int M5_BATTERY_LOW 		= 3550;       	
			static const int M5_BATTERY_CRITICAL	= 3300;

			/**
			 * @name Library version.
			 * @brief Define the library version.
			 * @note Keep as last constant entry for easy update.
			 */
			static const int M5STICKCPLUS2_VERSION = 40;

    };
}
