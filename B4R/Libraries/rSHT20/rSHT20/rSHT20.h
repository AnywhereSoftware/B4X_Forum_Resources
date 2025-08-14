#pragma once
//~Library: 		rSHT20
//~File:			rSHT20.h
//~Brief: 			B4R library, wrapped from the SHT20 library, to read the temperature & humidity from an SHT220 module.
//~Version: 		1.0
//~Built: 			20250626
//~License:			MIT License (MIT)
//~Author:			Copyright (c) 2025 Robert W.B. Linn https://github.com/rwbl

#include "B4RDefines.h"
// Include the SHT20 library header located in the same folder as rSHT20.h
#include "SHT20.h"

namespace B4R
{

	//~shortname: SHT20
	class B4RSHT20
	{
		private:
			uint8_t beSHT20[sizeof(SHT20)];
			SHT20* sht;

			float temperature, humidity, dewpoint;
		public:

			/**
			 * Initialize the I2C Connection to the SHT20 module.
			 */
			bool Initialize(void);

			/**
			 * Perform measurement; returns true if successful.
			 */
			bool Measure(void);

			/**
			 * Get the temperature after Measure called.
			 */
			float Temperature(void);

			/**
			 * Get the humidity after Measure called.
			 */
			float Humidity(void);

			/**
			 * Get the dewpoint after Measure called.
			 */
			float Dewpoint(float temperature, float humidity);
	};
}