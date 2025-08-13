#pragma once
// Library: rESP3228CYD
// This library is intended to control the Sunton ESP32 2.8” TFT Cheap Yellow Display (CYD).
// Date: 20250319
// Author: Robert W.B. Linn

// Partial wrapper of the LovyanGFX library https://lovyangfx.readthedocs.io/en/master/02_using.html.
// References and credits: lovyan03 (LovyanGFX) https://github.com/lovyan03.
// Additional functions defined, color code used RGB888 (24-bits).
// Tested with the Cheap Yellow Display (CYD) Sunton ESP32 2.8 inch TFT (ESP-WROVER-KIT, driver ILI9341).

#include "B4RDefines.h"
#include <LovyanGFX.h>

// Include the configuration for the CYD ESP32-2432S028 with display driver SPI 9341
// Must be in the same folder as the rESP3228CYD header.
#include "ESP32_2432S028.h"

// Convert color code 16-bit RGB565 to 24-bit RGB888 - used by the color defines, a color has type ULong.
#define RGB565_TO_RGB888(c) ((((c >> 8) & 0xF8) << 16) | (((c >> 3) & 0xFC) << 8) | ((c << 3) & 0xF8))

// Namespace B4R
namespace B4R
{
	//~Version: 0.60
	//~Shortname: ESP3228CYD
	//~Event: Touch (x As ULong, y As ULong)
	typedef void (*SubVoidTouch)(ULong x, ULong y);
	
	class B4RESP3228CYD
	{
		private:
			// LCD instance.
			LGFX* gfx;
			uint8_t be[sizeof(LGFX)];

			// Touch 
			// Client touch callback sub defined in the B4R code.
			SubVoidTouch TouchSub;
			// PollerNode added to the pollers
			PollerNode pnode;
			// Looper listening to touch events. Set the sensitivity delay in this function.
			static void Looper(void* b);
									
			// RGB LED pin mapping
			int redPin		= 4;
			int greenPin	= 16;
			int bluePin		= 17;

			// Helpers for getters & setters
			ULong backgroundColor;
			Byte selectedFont;

		public:
			/**
			* Initializes the ESP3228CYD object with touch event.
			* TouchSub (SubVoidTouch) - Name of the touch event. Set NULL to disable touch.
			*/
			void Initialize(SubVoidTouch TouchSub);
			
			/**
			* Clear the screen.
			*/
			void Clear();

			/**
			* Clear the display and set background color.
			*/
			void ClearSetColor(ULong color);
			
			/**
			* Clear rect area of the display.
			*/
			void ClearArea(Long x, Long y, Long w, Long h, ULong color);

			/**
			* Get display height.
			*/
			ULong Height();
			
			/**
			* Get display width.
			*/
			ULong Width();

			/**
			* Set display rotation 4 directions 0 - 3.
			* 0=vertical (power supply top right),1=horizontal (power supply top left), 
			* 2=vertical (power supply bottom left), 3=horizontal (power supply bottom right), 
			* (rotations 4 to 7, image will be mirrored.)
			* rotation - Byte 0 - 3
			*/
			void setDisplayRotation(Byte direction);

			/**
			* Get the display rotation direction 0-3.
			*/
			Byte getDisplayRotation();

			/**
			* Set the cursor at x,y position.
			*/
			void SetCursor(ULong x, ULong y);

			/**
			* Set the backlight brightness in the range 0-255.
			* brightness - Byte 0 (low) - 255 (high)
			*/
			void SetBrightness(uint8_t brightness);

			/**
			* Fill the screen with color, i.e. set background color.
			*/
			void FillScreen(ULong color);

			/**
			* Set the screen background color.
			*/
			void setBackgroundColor(ULong color);

			/**
			* Get screen background color.
			*/
			ULong getBackgroundColor();

			/**
			* Set the text color.
			* color - ULong, use constants TFT_color or ColorRGB(R,G,B)
			*/
			void SetTextColor(ULong color);

			/**
			* Set the textsize.
			* size - Double, size 1 is 8x8 px
			*/
			void SetTextSize(Double size);

			/**
			* Set text datum.
			*/
			void SetTextDatum(Byte datum);

			/**
			* Print string at cursor position.
			*/
			void Print(B4RString* text);

			/**
			* Print string with linebreak at cursor position.
			*/
			void Println(B4RString* text);

			/**
			* Draw text at x,y position with text size, color and backgroundcolor (set to COLOR_DEFAULT to use previous color defined).
			*/
			void DrawText(ULong x, ULong y, B4RString* text, Byte textAlignment, double textSize, ULong textColor, ULong backgroundColor);

			/**
			* Get the text number of characters.
			*/
			UInt TextLength(B4RString* text);
			
			/**
			* Get the text width in px for the selected font.
			*/
			UInt TextWidth(B4RString* text);

			/**
			* Get the text width in px for the default font 8x8.
			*/
			UInt TextWidthDefault(B4RString* text, double textSize);
			
			/**
			* Get the text height in px.
			*/
			UInt TextHeight(double textSize);

			/**
			* Get font heigth in px.
			* font - (Byte) size, 1 is default 8x8 px
			*/
			ULong FontHeight(Byte font);
			
			/**
			* Get font width in px.
			* font - (Byte) size, 1 is default 8x8 px
			*/
			ULong FontWidth(Byte font);

			/**
			* FONTS
			*/
			
			// TODO: Include IFont structure; See lgfx_fonts.hpp and lgfx_fonts.cpp (namespace fonts)
			// void B4RESP3228CYD::SetFont(IFont* font);

			/**
			* Set or get the font type.
			* The font size is given at the end of the font name. 
			* Recommend to set the font size in f.e. DrawText to 1 to use the font size set by the selected font.
			* Example:<code>
			* lcd.Font = lcd.FONT_ORBITRON_LIGHT_24
			* lcd.DrawText(lcd.Width/2, lcd.Height/2, Settings.MSG_WAITING, lcd.TEXT_ALIGN_MIDDLE_CENTER, 1, lcd.COLOR_BLACK, lcd.BackgroundColor)
			* lcd.Font = lcd.FONT_DEFAULT
			* </code>
			*/
			void setFont(Byte font);
			Byte getFont(void);
			
			/**
			/* Color Functions
			*/
			
			/**
			* Set color mode.
			* bits 16 - RGB565 Faster, red and blue tones are 5 bits.
			* bits 24 - RGB888 Slower, gradation expression is cleaner.
			* Note: bits 24 number colors displayed depends on hardware and may be 18 bits (RGB666).
			*/
			void SetColorDepth(int bits);

			/**
			* Set color using constant, like TFT_BLUE.
			* color - ULong
			*/
			void SetColor(ULong color);
			
			/**
			* Set color using R-G-B.
			* r red
			* g green
			* b blue
			*/
			void SetColorRGB(Byte r, Byte g, Byte b);
			
			/**
			* Converts RGB information to 8-bit color code.
			* r red
			* g green
			* b blue
			* return 8-bit color code
			*/
			//~Hide
			Byte Color332(Byte r, Byte g, Byte b);

			/** 
			* Converts RGB information to 16-bit color code.
			* r red
			* g green
			* b blue
			* return 16-bit color code
			*/
			//~Hide
			UInt Color565(Byte r, Byte g, Byte b);

			/**
			* Converts RGB information to 24-bit color code.
			* This function is recommended.
			* r red
			* g green
			* b blue
			* return 24-bit color code
			*/
			//~Hide
			ULong Color888(Byte r, Byte g, Byte b);

			/**
			* Converts RGB information to 24-bit color code.
			* This function is recommended.
			* r red
			* g green
			* b blue
			* return 24-bit color code
			*/
			ULong ColorRGB(Byte r, Byte g, Byte b);
			
			/**
			* Convert 16-bit (565) to 24-bit (888) color code.
			*/
			//~Hide
			ULong Color16to24(ULong rgb565);

			/**
			* SPI Bus
			*/

			/**
			* Secure SPI bus.
			*/
			void BeginTransaction(void);

			/**
			* Release SPI bus.
			*/
			void EndTransaction(void);
			
			/**
			* Drawing Functions
			*/
			
			/**
			* In case drawing speed is important, use startWrite and endWrite before and after the drawing process.
			* transaction (boolean) - If true, transaction processing is performed.
			*/
			void StartWrite(bool transaction);
			
			/**
			* In case drawing speed is important, use startWrite and endWrite before and after the drawing process.
			*/
			void EndWrite(void);
			
			/**
			* Draw pixel with size 1x1.
			*/
			void DrawPixel     ( Long x, Long y, ULong color);

			/**
			* Draw pixel with size, like 4x4, 8x8 etc.
			*/
			void DrawPixelSize ( Long x, Long y, UInt size, ULong color);

			/**
			* Draw pixel with size 4x4.
			*/
			void DrawPixel4    ( Long x, Long y, ULong color);

			/**
			* Draw pixel with size 8x8.
			*/
			void DrawPixel8    ( Long x, Long y, ULong color);

			/**
			* Draw pixel with size 16x16.
			*/
			void DrawPixel16   ( Long x, Long y, ULong color);

			void DrawFastVLine ( Long x, Long y, Long h, ULong color);

			void DrawFastHLine ( Long x, Long y, Long w, ULong color);

			void DrawRect      ( Long x, Long y, Long w, Long h, ULong color);

			void FillRect      ( Long x, Long y, Long w, Long h, ULong color);

			void DrawRoundRect ( Long x, Long y, Long w, Long h, Long r, ULong color);

			void FillRoundRect ( Long x, Long y, Long w, Long h, Long r, ULong color);

			void DrawCircle    ( Long x, Long y, Long r, ULong color);

			void FillCircle    ( Long x, Long y, Long r, ULong color);

			void DrawEllipse   ( Long x, Long y, Long rx, Long ry, ULong color);

			void FillEllipse   ( Long x, Long y, Long rx, Long ry, ULong color);

			void DrawLine      ( Long x0, Long y0, Long x1, Long y1, ULong color);

			void DrawGradientLine ( Long x0, Long y0, Long x1, Long y1, ULong colorstart, ULong colorend);

			void DrawWideLine     ( Long x0, Long y0, Long x1, Long y1, double r, ULong color);

			void DrawTriangle  ( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, ULong color);

			void FillTriangle  ( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, ULong color);

			// 3-point Bezier
			void DrawBezier3   ( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, ULong color);

			// 4-point Bezier
			void DrawBezier4   ( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, Long x3, Long y3, ULong color);

			void DrawArc       ( Long x, Long y, Long r0, Long r1, Long angle0, Long angle1, ULong color);

			void FillArc       ( Long x, Long y, Long r0, Long r1, Long angle0, Long angle1, ULong color);

			/**
			* TEXTBOX
			*/

			void DrawTextBox(int x, int y, int w, int h, B4RString* text, ULong textColor, double textSize, ULong fillColor, ULong borderColor, int borderSize);
			void DrawTextBoxMultiLine(int x, int y, int w, int h, B4RString* line1, B4RString* line2, B4RString* line3, ULong textColor, double textSize, ULong fillColor, ULong borderColor, int borderSize);

			/**
			* GAUGE
			*/
		
			void DrawGauge(int x, int y, int radius, double minValue, double maxValue, double currentValue, B4RString* title, ULong scaleColor, ULong borderColor, ULong needleColor,  int needleThickness, double textSize, ULong innerColor);

			/**
			* EXPORT SCREENSHOT
			* TODO: PNG created is empty. Cause not found.
			*/
			//~Hide
			B4R::ArrayByte* CreatePNG( Long x, Long y, Long width, Long height);

			/**
			* TOUCH
			*/
			// See CPP initialize and Looper.

			/**
			* RGB LED
			*/
			
			/**
			* Set the color of the RGB LED.
			* redValue (int) - 0 (OFF) - 255 (ON)
			* greenValue (int) - 0 (OFF) - 255 (ON)
			* blueValue (int) - 0 (OFF) - 255 (ON)
			*/
			void SetRGBLEDColor(int redValue, int greenValue,  int blueValue);

			/**
			* Set RGB LED off (color black).
			*/
			void SetRGBLEDOff(void);

			/**
			* Set or get the value 0 (OFF) - 255 (ON) of the RED LED.
			*/
			void setRGBLEDRed(int value);
			int getRGBLEDRed(void);

			/**
			* Set or get the value 0 (OFF) - 255 (ON) of the GREEN LED.
			*/
			void setRGBLEDGreen(int value);
			int getRGBLEDGreen(void);

			/**
			* Set or get the value 0 (OFF) - 255 (ON) of the BLUE LED.
			*/
			void setRGBLEDBlue(int value);
			int getRGBLEDBlue(void);

			/**
			* BITMAP
			*/

			/**
			* Draw Bitmap any size.
			* TODO: Define the bitmap structure.
			*/
			void DrawBitmap(int x, int y, int width, int height, ArrayByte* bitmap, ULong color, ULong bgColor);
			
			/**
			* Draw an icon from an byte array.
			*/
			void DrawIcon(int x, int y, int numRows, int numCols, Byte size, ArrayByte* bitmap, ULong color, ULong bgColor);

			/**
			* TEXT CONSTANTS
			*/

			// Text alignment
			Byte TEXT_ALIGN_TOP_LEFT		= 0; // default
			Byte TEXT_ALIGN_TOP_CENTER		= 1;
			Byte TEXT_ALIGN_TOP_RIGHT		= 2;
			Byte TEXT_ALIGN_MIDDLE_LEFT		= 4;
			Byte TEXT_ALIGN_MIDDLE_CENTER	= 5;
			Byte TEXT_ALIGN_MIDDLE_RIGHT	= 6;
			Byte TEXT_ALIGN_BOTTOM_LEFT		= 8;
			Byte TEXT_ALIGN_BOTTOM_CENTER	= 9;
			Byte TEXT_ALIGN_BOTTOM_RIGHT	= 10;
			
			/**
			* COLORS CONSTANTS
			*/

			// Colors 16-bits to 24-bits converted from the library color list
			
			#define /*ULong COLOR_BLACK;*/ 			B4RESP3228CYD_COLOR_BLACK 			RGB565_TO_RGB888(0x0000)	//   0,   0,   0
			#define /*ULong COLOR_BLUE;*/ 			B4RESP3228CYD_COLOR_BLUE			RGB565_TO_RGB888(0x001F)	//   0,   0, 255
			#define /*ULong COLOR_BROWN;*/ 			B4RESP3228CYD_COLOR_BROWN 			RGB565_TO_RGB888(0x9A60)	// 150,  75,   0
			#define /*ULong COLOR_CYAN;*/ 			B4RESP3228CYD_COLOR_CYAN			RGB565_TO_RGB888(0x07FF)	//   0, 255, 255
			#define /*ULong COLOR_DARKCYAN;*/ 		B4RESP3228CYD_COLOR_DARKCYAN 		RGB565_TO_RGB888(0x03EF)	//   0, 128, 128
			#define /*ULong COLOR_DARKGRAY;*/ 		B4RESP3228CYD_COLOR_DARKGRAY 		RGB565_TO_RGB888(0x7BEF)	// 128, 128, 128
			#define /*ULong COLOR_DARKGREEN;*/ 		B4RESP3228CYD_COLOR_DARKGREEN 		RGB565_TO_RGB888(0x03E0)	//   0, 128,   0
			#define /*ULong COLOR_DARKGREY;*/ 		B4RESP3228CYD_COLOR_DARKGREY 		RGB565_TO_RGB888(0x7BEF)	// 128, 128, 128
			#define /*ULong COLOR_GOLD;*/ 			B4RESP3228CYD_COLOR_GOLD			RGB565_TO_RGB888(0xFAE0)	// 255, 215,   0
			#define /*ULong COLOR_GREEN;*/ 			B4RESP3228CYD_COLOR_GREEN 			RGB565_TO_RGB888(0x07E0)	//   0, 255,   0
			#define /*ULong COLOR_GREENYELLOW;*/ 	B4RESP3228CYD_COLOR_GREENYELLOW 	RGB565_TO_RGB888(0xB7E0)	// 180, 255,   0
			#define /*ULong COLOR_LIGHTGRAY;*/ 		B4RESP3228CYD_COLOR_LIGHTGRAY 		RGB565_TO_RGB888(0xD69A)	// 128, 128, 128
			#define /*ULong COLOR_LIGHTGREY;*/ 		B4RESP3228CYD_COLOR_LIGHTGREY 		RGB565_TO_RGB888(0xD69A)	// 211, 211, 211
			#define /*ULong COLOR_MAGENTA;*/ 		B4RESP3228CYD_COLOR_MAGENTA 		RGB565_TO_RGB888(0xF81F)	// 255,   0, 255
			#define /*ULong COLOR_MAROON;*/ 		B4RESP3228CYD_COLOR_MAROON 			RGB565_TO_RGB888(0x7800)	// 128,   0,   0
			#define /*ULong COLOR_NAVY;*/ 			B4RESP3228CYD_COLOR_NAVY 			RGB565_TO_RGB888(0x000F)	//   0,   0, 128
			#define /*ULong COLOR_OLIVE;*/ 			B4RESP3228CYD_COLOR_OLIVE 			RGB565_TO_RGB888(0x7BE0)	// 128, 128, 0
			#define /*ULong COLOR_ORANGE;*/ 		B4RESP3228CYD_COLOR_ORANGE 			RGB565_TO_RGB888(0xFDA0)	// 255, 180,   0
			#define /*ULong COLOR_PINK;*/ 			B4RESP3228CYD_COLOR_PINK			RGB565_TO_RGB888(0xFE19)	// 255, 192, 203
			#define /*ULong COLOR_PURPLE;*/ 		B4RESP3228CYD_COLOR_PURPLE 			RGB565_TO_RGB888(0x780F)	// 128,   0,
			#define /*ULong COLOR_RED;*/ 			B4RESP3228CYD_COLOR_RED				RGB565_TO_RGB888(0xF800)	// 255,   0,   0
			#define /*ULong COLOR_SILVER;*/ 		B4RESP3228CYD_COLOR_SILVER 			RGB565_TO_RGB888(0xC618)	// 192, 192, 192
			#define /*ULong COLOR_SKYBLUE;*/ 		B4RESP3228CYD_COLOR_SKYBLUE 		RGB565_TO_RGB888(0x867D)	// 135, 206, 235
			#define /*ULong COLOR_TRANSPARENT;*/	B4RESP3228CYD_COLOR_TRANSPARENT		RGB565_TO_RGB888(0x0120)	//
			#define /*ULong COLOR_VIOLET;*/ 		B4RESP3228CYD_COLOR_VIOLET 			RGB565_TO_RGB888(0x915C)	// 180,  46, 226
			#define /*ULong COLOR_WHITE;*/ 			B4RESP3228CYD_COLOR_WHITE 			RGB565_TO_RGB888(0xFFFF)	// 255, 255, 255
			#define /*ULong COLOR_YELLOW;*/ 		B4RESP3228CYD_COLOR_YELLOW 			RGB565_TO_RGB888(0xFFE0)	// 255, 255,   0

			// Additional colors HEX, RGB
			ULong COLOR_LIME		= 0x32CD32; 	// 50, 205, 50
			ULong COLOR_CRIMSON		= 0xDC143C;		// 220, 20, 60
			ULong COLOR_FIREBRICK 	= 0xB22222;		// 178, 34, 34

			// Color use the default set (like for DrawText) - note the additional F to indentify this color
			ULong COLOR_DEFAULT = 0xFFFFFFF;

			/**
			* FONT CONSTANTS
			* See source lgfx_fonts.cpp
			* Add more fonts as required and change the function setFont accordingly (switch statement).
			* A font group starts with 10, 20, 30 etc.
			*/

			// Default Font0 height 8 px.
			static const Byte FONT_HEIGHT_DEFAULT = 8;

			// Default font which is Font0
			static const Byte FONT_DEFAULT 				= 0;
			
			// Font Font0.
			static const Byte FONT_FONT0 				= 10;
			// Font Font2.
			static const Byte FONT_FONT2 				= 11;
			// Font Font4.
			static const Byte FONT_FONT4 				= 12;
			// Font Font6.
			static const Byte FONT_FONT6 				= 13;
			// Font Font7.
			static const Byte FONT_FONT7 				= 14;
			// Font Font8.
			static const Byte FONT_FONT8 				= 15;

			// Font FreeMono9pt7b FM9.
			static const Byte FONT_FREEMONO_9 			= 20;
			// Font FreeMonoBold9pt7b FMB12.
			static const Byte FONT_FREEMONOBOLD_9 		= 21;
			// Font FreeMono12pt7b FM12.
			static const Byte FONT_FREEMONO_12 			= 22;
			// Font FreeMonoBold12pt7b FMB12.
			static const Byte FONT_FREEMONOBOLD_12 		= 23;
			
			// Font FreeSans9pt7b FSS9.
			static const Byte FONT_FREESANS_9 			= 30;
			// Font FreeSansBold9pt7b FSS9.
			static const Byte FONT_FREESANSBOLD_9 		= 31;
			// Font FreeSans12pt7b FSS12.
			static const Byte FONT_FREESANS_12 			= 32;
			// Font FreeSansBold12pt7b FSS12.
			static const Byte FONT_FREESANSBOLD_12 		= 33;
			
			// Font TomThumb TT1.
			static const Byte FONT_TOMTHUMB_1 			= 40;
			
			// Font FreeSerif12pt7b FS12.
			static const Byte FONT_FREESERIF_12 		= 50;
			// Font FreeSerifBold12pt7b FSB12.
			static const Byte FONT_FREESERIFBOLD_12 	= 51;
			// Font FreeSerifBold24pt7b FSB24
			static const Byte FONT_FREESERIFBOLD_24 	= 52;
			
			// Font Orbitron_Light_24 OL24
			static const Byte FONT_ORBITRON_LIGHT_24 	= 60;
			// Font Orbitron_Light_32 OL32
			static const Byte FONT_ORBITRON_LIGHT_32	= 61;

			// Font Roboto_Thin_24 RT24
			static const Byte FONT_ROBOTO_THIN_24 		= 70;

	};
}