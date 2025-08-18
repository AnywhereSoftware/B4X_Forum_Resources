//rMAX6675 - B4R Library MAX6675.
//Wrapped from this open source library https://www.arduino.cc/reference/en/libraries/max6675-library/ (https://github.com/adafruit/MAX6675-library)
//Notes: The MAX6675 requires a delay of 250ms between updates.
#pragma once
#include "B4RDefines.h"
#include "max6675.h"
namespace B4R {
	//~Version: 1.00
	//~Shortname: MAX6675
	//~Author: rwbl
	class B4RMAX6675 {
		private:
			uint8_t beMAX6675[sizeof(MAX6675)];
			MAX6675* max;
		public:
		
			/**
			*Initialize the MAX6675 module.
			* SCK - Pin Serial Clock
			* CS - Pin Chip Select
			* SO - Pin Serial Output
			*/
			void Initialize(Byte SCK, Byte CS, Byte SO);
		
			/**
			*Read temperature in degrees Celsius.
			*Returns Temperature C as double.
			*/
			double ReadCelsius(void);
			
			/**
			*Read temperature in degrees Fahrenheit.
			*Returns Temperature F as double.
			*/
			double ReadFahrenheit(void);
	};
}