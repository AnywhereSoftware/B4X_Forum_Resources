#pragma once
/**
 * @file rArduinoLEDMatrix.h
 * @brief B4R C++ wrapper for the ArduinoLEDMatrix 12x8 library.
 * @note Ensure the ArduinoGraphics and Arduino_LED_Matrix libraries are installed via the Arduino IDE.
 * @version 1.0
 * @date 2026-08-27
 * @author Robert W. B. Linn (c) 2026 — MIT License
 */

#include "Arduino.h"
// ArduinoGraphics must be included BEFORE Arduino_LED_Matrix
#include "ArduinoGraphics.h" 
// Uses the built-in, fast hardware driver
#include "Arduino_LED_Matrix.h" 

#include "B4RDefines.h"

//~version: 1.0
namespace B4R {
	//~shortname: ArduinoLEDMatrix
    /**
     * @brief The core B4R wrapper class for the Arduino UNO R4 LED Matrix.
     */
    class B4RArduinoLEDMatrix {
        private:
            // The official hardware controller instance
            ArduinoLEDMatrix matrixInstance;
			
            // Internal 8 rows x 12 colss binary matrix frame representation
            uint8_t targetFrame[8][12];

        public:
            /**
             * @brief Initializes the LED matrix peripheral and starts the background refresh driver.
             */
			void Initialize();
            
            /**
             * @brief Toggles an isolated single pixel coordinate.
             * @param X Column coordinate (0 to 11).
             * @param Y Row coordinate (0 to 7).
             * @param TurnOn Set to 1 to illuminate, 0 to extinguish.
             */
			void SetPixel(Byte X, Byte Y, Byte TurnOn);
            
            /**
             * @brief Wipes the internal frame buffer and blanks out the display matrix.
             */
			void Clear();
			
			/**
			 * @brief Draws a full 12x8 custom frame using a flattened 1D B4R byte array.
			 * @param FrameData A 1D B4R byte array containing exactly 96 elements (8 rows * 12 columns).
			 */
            void DrawFrame(ArrayByte* FrameData);

			/**
			 * @brief Prints or scrolls a text string using the native hardware-accelerated ArduinoGraphics engine vectors.
			 * @param Text The B4R string payload to render.
			 * @param X Starting horizontal anchor pixel offset.
			 * @param Y Starting vertical anchor pixel offset (use 1 for perfect 5x7 font centering).
			 * @param Direction Dynamic shift behavior: 0 = Static Text, 1 = Scroll Left, 2 = Scroll Right.
			 * @param ScrollSpeedMS Clock pacing delay duration in milliseconds per structural frame translation step.
			 */
            void PrintText(B4RString* Text, Int X, Int Y, Byte Direction, ULong ScrollSpeedMS);

			/**
			 * @brief Draws a crisp vector line topology layout between two grid points.
			 * @param X1 Starting coordinate horizontal column.
			 * @param Y1 Starting coordinate vertical row.
			 * @param X2 Terminating coordinate horizontal column.
			 * @param Y2 Terminating coordinate vertical row.
			 * @param TurnOn Set to 1 to render visible strokes, 0 to erase matching paths.
			 */
            void DrawLine(Int X1, Int Y1, Int X2, Int Y2, Byte TurnOn);
            
            /**
             * @brief Draws an empty bounding outline structural rectangle canvas grid framework.
             * @param X Starting boundary left corner column index.
             * @param Y Starting boundary top corner row index.
             * @param Width Total structural width horizontally in pixel segments.
             * @param Height Total structural height vertically in pixel segments.
             * @param TurnOn Set to 1 to render visible strokes, 0 to erase matching paths.
             */
            void DrawRect(Int X, Int Y, Int Width, Int Height, Byte TurnOn);
            
            /**
             * @brief Draws an empty boundary perimeter path radius ring circle configuration.
             * @param X Axis coordinate center focal target column.
             * @param Y Axis coordinate center focal target row.
             * @param Radius Linear sizing span distance from the target center boundary out in pixels.
             * @param TurnOn Set to 1 to render visible strokes, 0 to erase matching paths.
             */
            void DrawCircle(Int X, Int Y, Int Radius, Byte TurnOn);

			/**
			 * @brief Loads and displays a factory-predefined gallery icon buffer structure straight from core flash memory.
			 * @param FrameData The raw numeric flash memory address of the target icon token asset.
			 */		
            void LoadFrame(ULong FrameData);

			/**
			 * @name Native Flash Icons
			 * Read-only constant property-getters mapping directly to embedded global structures inside gallery.h.
			 */
            ULong ICON_BLUETOOTH();
            ULong ICON_BOOTLOADER_ON();
            ULong ICON_CHIP();
            ULong ICON_CLOUD_WIFI();
            ULong ICON_DANGER();
            ULong ICON_EMOJI_BASIC();
            ULong ICON_EMOJI_HAPPY();
            ULong ICON_EMOJI_SAD();
            ULong ICON_HEART_BIG();
            ULong ICON_HEART_SMALL();
            ULong ICON_LIKE();
            ULong ICON_MUSIC_NOTE();

			/**
			 * @name text scroll
			 */
			const Byte TEXT_SCROLL_NONE = 0;
			const Byte TEXT_SCROLL_LEFT = 1;
			const Byte TEXT_SCROLL_RIGHT = 2;
			
			/**
			 * CUSTOM FUNCTIONS
			 */

			/**
			 * @brief A custom software text scroller that slides an uppercase alphanumeric string from right to left using local bit-shifting matrices.
			 * @note Operates synchronously on the active core thread context without relying on the ArduinoGraphics engine.
			 * @param Text The B4R string sequence to scroll.
			 * @param SpeedMS Frame rate stepping delay loop index in milliseconds per single-column translation shift.
			 */
            void ScrollText(B4RString* Text, ULong SpeedMS);
    };
}
