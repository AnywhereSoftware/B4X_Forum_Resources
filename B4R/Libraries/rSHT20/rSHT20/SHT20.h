/**
 * @file SHT20.h
 *
 * @brief Library for the SHT20 sensor.
 *
 ************************************************************************************
 * MIT License
 *
 * Copyright (c) 2025 Robert W.B. Linn https://github.com/rwbl
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 * CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
 * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 ************************************************************************************
 */

#ifndef SHT20_H
#define SHT20_H

#include <Arduino.h>
#include <Wire.h>

class SHT20 {
	public:
		SHT20();

		// Initialize I2C (call in setup)
		void begin();

		// Perform measurement; returns true if successful
		bool measure(float &temperature, float &humidity);

		// Static helper function to calculate dew point
		static float dewpoint(float temperature, float humidity);

	private:
		static const uint8_t addr = 0x40;

		// Low-level read function: send command, read 3 bytes
		bool read(uint8_t cmd, uint8_t *data);
	};

#endif // SHT20_H
