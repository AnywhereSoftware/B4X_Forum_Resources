// rLiquidCrystalI2CEX.h
// Library for the I2C LCD Displays 20x4 (20 columns, 4 rows) or 16x2 (16 columns, 2 rows).
// The LCD display is connected to the I2C pins SDA, SCL of the Arduino.
// The LCD display default addresses (Byte) are LCD20x4: 0x27, LCD16x2: 0x3F
// Additional Libraries required:
// None
// Additional Classes required (included in the wrapped library folder):
// None
// Notes:
// First library wrapping done by Anywhere Software (www.b4x.com). many thanks.
// Changelog
// 20210216: v1.00

#pragma once
#include "B4RDefines.h"
#include "LiquidCrystal_I2C.h"
//~Version: 1.00
namespace B4R {
	//~shortname: LiquidCrystalI2CEX
	class B4RLiquidCrystal_I2C {
		private:
			uint8_t beLcd[sizeof(LiquidCrystal_I2C)];
		public:
			// Create lcd object
			LiquidCrystal_I2C* lcd;
			// Get the number of columns
			Byte ColumnSize;
			// Get the number of rows
			Byte RowSize;

			/**
			* Init the LCD with address (default 0x27) and columns (20), rows (4)
			*/
			void Initialize(Byte Address, Byte Columns, Byte Rows);

			/**
			* Set the cursor position at column, row
			* LCD20x4: Columns = 0-19, Rows = 0-3
			* LCD16x2: Columns = 0-15, Rows = 0-1
			*/
			void SetCursor(Byte Column, Byte Row);

			/**
			* Write text at the position prior set via SetCursor(Col,Row).
			* The text can be a string, number or array of bytes.
			*/
			void Write(Object* Message);

			/**
			* Write text at the position col,row.
			* The text can be a string, number or array of bytes.
			* Column: 0-19 (LCD20x4), 0-15 (LCD16x2)
			* Row: 0-3 (LCD20x4), 0-1 (LCD16x2)
			*/
			void WriteAt(Byte Column, Byte Row, Object* Message);

			/**
			* Clear the screen and set the cursor at position 0,0.
			*/
			void Clear();

			/**
			* Clear a row and set the cursor at position 0, row.
			*/
			void ClearRow(Byte Row);

			/**
			* Set cursor blink ON (true) or OFF (false).
			*/
			void setBlink(bool State);

			/**
			* Sets the cursor state ON (true) or OFF ( false)
			*/
			void setCursorOn(bool State);

			/**
			* Turn the LCD backlight ON (true) or OFF (false)
			*/
			void setBacklight(bool State);
			
			/**
			* Create special character location 0-7.
			* The Charmap as byte array contains the 8 bytes of the character.
			*/
			void CreateChar(Byte Location, ArrayByte* Charmap);

			/**
			* Write special character 0-7
			*/
			void WriteChar(Byte Location);

			/**
			* Write special character wih location 0-7 at the position column, row.
			* Note: The first column or row start with 0.
			* The special character has to be created first with function CreateChar.
			* LCD20x4: Columns = 0-19, Rows = 0-3
			* LCD16x2: Columns = 0-15, Rows = 0-1
			*/
			void WriteCharAt(Byte Column, Byte Row, Byte Location);
	};
}