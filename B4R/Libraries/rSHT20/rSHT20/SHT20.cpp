/**
 * @file SHT20.cpp
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

#include "SHT20.h"
#include <math.h>

SHT20::SHT20() {
    // Constructor - nothing needed here
}

void SHT20::begin() {
    Wire.begin();
}

bool SHT20::read(uint8_t cmd, uint8_t *data) {
    Wire.beginTransmission(addr);
    Wire.write(cmd);
    if (Wire.endTransmission() != 0) {
        return false; // transmission error
    }

    delay(100); // wait for measurement

    Wire.requestFrom(addr, (uint8_t)3);
    if (Wire.available() < 3) {
        return false; // not enough data received
    }
    data[0] = Wire.read();
    data[1] = Wire.read();
    data[2] = Wire.read();

    return true;
}

bool SHT20::measure(float &temperature, float &humidity) {
    uint8_t raw[3];

    // Temperature measurement
    if (!read(0xF3, raw)) return false;
    uint16_t temp_raw = ((uint16_t)raw[0] << 8) | raw[1];
    temperature = -46.85 + (175.72 * temp_raw / 65536.0);

    // Humidity measurement
    if (!read(0xF5, raw)) return false;
    uint16_t hum_raw = ((uint16_t)raw[0] << 8) | raw[1];
    humidity = -6 + (125.0 * hum_raw / 65536.0);

    return true;
}

float SHT20::dewpoint(float temperature, float humidity) {
    const float a = 17.62;
    const float b = 243.12;
    float gamma = (a * temperature) / (b + temperature) + log(humidity / 100.0);
    return (b * gamma) / (a - gamma);
}
