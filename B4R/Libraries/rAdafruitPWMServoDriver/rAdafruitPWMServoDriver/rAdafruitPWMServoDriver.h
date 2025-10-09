/**
 * File:        rAdafruitPWMServoDriver.h
 * Brief:       B4R library wrapper for the Adafruit 16-channel PWM & Servo driver.
 *              Based on the Adafruit_PWMServoDriver library:
 *              https://github.com/adafruit/Adafruit-PWM-Servo-Driver-Library
 *
 * Original Library (Adafruit):
 *   Copyright (c) 2012 Adafruit Industries
 *   Licensed under the BSD 3-Clause License
 *   (see LICENSE file in the original repository).
 *
 * This Wrapper (B4R):
 *   Enhancements for B4R integration:
 *     - Added custom constants
 *     - Added helper functions
 *     - Renamed parameter: num > channel
 *   Requires Adafruit_PWMServoDriver v3.0.2 or higher (install via Arduino IDE Library Manager).
 *
 * Author (Wrapper): Robert W.B. Linn
 * Date:            2025-09-04
 *
 * License for this wrapper: MIT
 *   Copyright © 2025 Robert W.B. Linn
 *   Permission is hereby granted, free of charge, to use, copy, modify, merge,
 *   publish, distribute, sublicense, and/or sell copies of this software.
 *
 * Note: The Adafruit library remains under the BSD license.
 *       This wrapper code is MIT licensed. When distributing, both licenses apply.
 */

#pragma once
#include "B4RDefines.h"
#include <Adafruit_PWMServoDriver.h>

namespace B4R {
    //~Version: 1.0
    //~shortname: AdafruitPWMServoDriver
    /**
     * @class B4RAdafruitPWMServoDriver
     * @brief Wrapper class that exposes the Adafruit 16-channel PWM/Servo driver (PCA9685) to B4R.
	 *        Enhanced with custom constants & functions.
     *
     * Provides functions for initialization, PWM frequency configuration, direct PWM control,
     * servo angle control, and oscillator tuning.
     */
    class B4RAdafruitPWMServoDriver {
        private:
            /** Internal buffer to hold the Adafruit_PWMServoDriver instance. */
            uint8_t beAdafruitPWMServoDriver[sizeof(Adafruit_PWMServoDriver)];
			
			/** Store the last commanded angle for each channel (0–15) (using int for initial angle -1). */
			int servoAngles[16];
			
			/** Per channel minimum safe angle. */
			UInt servoMinAngles[16]; 
			
			//** per channel maximum safe angle. */
			UInt servoMaxAngles[16];
            
        public:
		
            /** Pointer to the underlying Adafruit PWM Servo Driver object. */
            //~hide
            Adafruit_PWMServoDriver* pwm;

            /** Initialize with default I2C address (0x40). */
            void Initialize();

            /** Initialize with a custom I2C address. */
            void Initialize2(const Byte addr);

            /** Initialize with a custom I2C address and I2C bus instance. */
            void Initialize3(const Byte addr, TwoWire &i2c);
            
            /** Reset the device to default settings. */
            void Reset();

            /** Put the device into low-power sleep mode. */
            void Sleep();

            /** Wake the device from sleep mode. */
            void Wakeup();

            /**
             * Use an external clock source.
             * @param prescale - The prescale value for the external clock.
             */
            void SetExtClk(Byte prescale);

            /**
             * Set PWM frequency for all channels.
             * @param freq - Frequency in Hz (typical for servos: 50–60 Hz).
             */
            void SetPWMFreq(float freq);

            /**
             * Configure output mode.
             * @param totempole - true for totem pole, false for open drain.
             */
            void SetOutputMode(bool totempole);

            /**
             * Read PWM on/off values for a given channel.
             * @param channel - Channel number (0–15).
             * @param off - When true, returns the "off" value; otherwise, the "on" value.
             * @return The raw PWM counter value.
             */
            UInt GetPWM(Byte channel, bool off);

            /**
             * Set the on/off tick counts for a channel.
             * @param channel - Channel number (0–15).
             * @param on - Counter tick when signal goes high.
             * @param off - Counter tick when signal goes low.
             * @return The last written "off" value.
             */
            Byte SetPWM(Byte channel, UInt on, UInt off);

            /**
             * Set channel output value.
             * @param channel - Channel number (0–15).
             * @param val - PWM value (0–4095).
             * @param invert - When true, output is inverted.
             */
            void SetPin(Byte channel, UInt val, bool invert);

            /** Read current prescale value. */
            Byte ReadPrescale(void);

            /**
             * Write pulse length in microseconds to a channel.
             * @param channel - Channel number (0–15).
             * @param microseconds - Pulse width in µs.
             */
            void WriteMicroseconds(Byte channel, UInt microseconds);

            /**
             * Set the internal oscillator frequency.
             * @param freq - Frequency in Hz (e.g. 25,000,000).
             */
            void setOscillatorFrequency(ULong freq);

            /** Get the current oscillator frequency in Hz. */
            ULong getOscillatorFrequency(void);
            
            /**
             * Custom Functions
             */

			/**
			 * Check if a channel index is valid.
			 * @param channel - Channel number to validate.
			 * @return true if channel is within 0–15, false otherwise.
			 */
			//~hide
			bool IsChannel(int channel);

			/**
			 * EnablePWM
			 *
			 * Re-enables PWM output for a channel using the last stored angle.
			 * Useful after DisablePWM() to "wake up" the servo at its previous position.
			 *
			 * @param channel Servo channel (0–15).
			 */
			void EnablePWM(Byte channel);

			/**
			 * Disable PWM (servo free, no buzz) by setting pulse length to 0.
             * @param channel - Channel number (0–15).
			 */
			void DisablePWM(Byte channel);

            /**
             * Set servo angle min / max limits on a given channel.
			 * If not used, the defaults are 0°-180°.
             * @param channel - Channel number (0–15).
             * @param minangle - Minimum servo angle (clamped to ANGLE_MIN).
             * @param minangle - Maximum servo angle (clamped to ANGLE_MAX).
             */
			void SetLimits(Byte channel, UInt minAngle, UInt maxAngle);

            /**
             * Set servo angle on a given channel.
             * @param channel - Channel number (0–15).
             * @param angle - Desired servo angle (clamped to servo min / max angle).
             * @param disable - Disable PWM (servo free, no buzz).
             * @return Corresponding pulse length (out of 4096) or -1 if channel is invalid.
             */
            int SetAngle(Byte channel, UInt angle, bool disable);

            /**
             * Get servo angle on a given channel.
             * @param channel - Channel number (0–15).
             * @return Current angle (0-180) or -1 if channel is invalid.
             */
			int GetAngle(Byte channel);

            /**
             * Convert angle (0–180°) to PWM pulse length.
             * @param angle - Angle in degrees.
             * @return Corresponding pulse length (out of 4096).
             */
            UInt AngleToPulse(UInt angle);

            /**
             * Convert PWM pulse length to angle (0–180°).
             * @param microseconds - Pulse width in µs.
             * @return Corresponding angle (0-180°). Not 100% accurate +/- 1°.
             */
            UInt PulseToAngle(UInt microseconds);

            /**
             * Constants
             */

            /** Number of PWM channels (0-15)*/
            static const UInt CHANNELS = 16;

            /** Default PWM frequency (Analog servos typically run at ~60 Hz). */
            static const UInt PWM_FREQUENCY_DEFAULT = 60;

            /** Minimum pulse length (out of 4096) corresponding to ~0°. */
            static const UInt SERVO_MIN = 150;

            /** Maximum pulse length (out of 4096) corresponding to ~180°. */
            static const UInt SERVO_MAX = 600;

			/** Unknown angle. */
			static const UInt ANGLE_UNKNOWN = -1;
			
            /** Minimum angle 0°. */
            static const UInt ANGLE_MIN = 0;

            /** Maximum angle 180°. */
            static const UInt ANGLE_MAX = 180;

            /** Servo move delay in microseconds. */
            static const UInt MOVE_DELAY = 200;
            
    };
    
}
