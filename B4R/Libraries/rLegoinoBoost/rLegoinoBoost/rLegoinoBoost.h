// B4R Library rLegoinoBoost
// This B4R library wraps the Boost methods of the Legoino library (https://github.com/corneliusmunz/legoino).
// The library enables controlling the LEGO® Motorized Hub (MoveHUB, Hub) from the LEGO Creative Toolbox 17101 (https://www.lego.com/en-de/product/boost-creative-toolbox-17101).
// LEGO is a trademark of the LEGO Group.
// The Legoino library depends on the libraries:
// [NimBLE-Arduino](https://github.com/h2zero/NimBLE-Arduino)
// The Legoino library must be installed via the Arduino IDE or copied to the Arduino Libraries folder.
// The library has been tested with an ESP-WROOM-32 module.
// Press the MoveHUB green button and reset (or provide power) the ESP32. If connection OK, the LED turns from white flashing > steady blue > steady green.
// MoveHUB LED Color States:
// Flashing WHITE: Waiting BLE connection; Flashing YELLOW: Battery Low; Steady RED: Battery close getting empty; Steady BLUE: BLE Connected;
// MoveHUB (or the drivebase):
// * Communicates via Bluetooth Low Energy (BLE)
// * Two internal tacho motors (ports A, B - can be used same time as port AB)
// * One external basic motor (port C or D)
// * Built-in Tilt Sensor XY axis, Voltage Sensor, Current Sensor
// * One external Color (detect colors) and Distance (measure distance to an object in mm) Sensor (port C or D)
// * Power 6 AAA batteries - recommend to use use rechargeable batteries - MoveHUB uses extensive power draining the batteries fast
// NOTE: Not all method comments have examples. Check the folder Examples for more.
// 20211017 rwbl
#pragma once
#include "B4RDefines.h"
// The Legoino includes - these are located in the Arduino IDE libraries folder.
#include "Lpf2Hub.h"
#include "Boost.h"
//~Author: Robert W.B. Linn
//~Version: 1.0
//~Event: StateChanged (Connected As Boolean)
//~Event: StateChangedEx (Connected As Boolean, Battery As Byte, Voltage As Double, Distance As Double, Color As Int)
namespace B4R {
	//~shortname: LegoinoBoost
	typedef void (*SubVoidBoost)(bool s, Byte bl, Double vs, Double ds, Int cs);
	class B4RLegoinoBoost {
		private:
			// StateChangedSub for property Connected.
			SubVoidBool StateChangedSub;
			static void checkForData(void* b);
			// StateChangedExSub for various properties Connected, BatteryLevel, VoltageSensor, DistanceSensor, ColorSensor.
			SubVoidBoost StateChangedExSub;
			static void checkForDataEx(void* b);
			// Poller used by StateChangedSubs.
			PollerNode pnode;
			// Holding the last state of the hub connection and various sensors.
			bool lastState;
			byte lastBatteryLevel;
			double lastVoltageSensor;
			double lastDistanceSensor;
			int lastColorSensor;
			//add more like int lastTiltSensorX; ...
		public:
			//
			//PROPERTIES
			//Must be public as required by the legoino object (see cpp)
			//name (the hub name) - obtained from the function getName. The hidden var name is used as temp to convert from the hub callback (see cpp).
			
			//Battery Level 0-100%.
			//Example:<code>
			//Private moveHub As LegoinoBoost
			//moveHUB.Initialize("MoveHub_StateChanged", "00:16:53:AE:9B:27", False)
			//Sub MoveHub_StateChanged(Connected As Boolean)
			//If Connected Then
			//	Log("BatteryLevel: ", moveHUB.BatteryLevel, "%")
			//End If
			//</code>
			Byte BatteryLevel;
			//Voltage V from the sensor. Max voltage is 9.6 V.
			//Example:<code>
			//Private moveHub As LegoinoBoost
			//moveHUB.Initialize("MoveHub_StateChanged", "00:16:53:AE:9B:27", False)
			//Sub MoveHub_StateChanged(Connected As Boolean)
			//If Connected Then
			//	Log("VoltageSensor: ", moveHUB.VoltageSensor, "V")
			//End If
			//</code>
			double VoltageSensor;
			//Current mA from the sensor. Max current is 2444 mA.
			double CurrentSensor;
			//Distance sensor measuring in millimeter.
			//Example:<code>
			//Private moveHub As LegoinoBoost
			//Private DistanceSensor As Double = -1
			//moveHUB.Initialize("MoveHub_StateChanged", "00:16:53:AE:9B:27", False)
			//Sub MoveHub_StateChanged(Connected As Boolean)
			//If Connected Then
			//	Log("DistanceSensor: ", moveHub.DistanceSensor, "mm")
			//End If
			//</code>
			double DistanceSensor;
			//Color sensor with values: BLACK = 0, PINK = 1, PURPLE = 2, BLUE = 3, LIGHTBLUE = 4, CYAN = 5,
			//GREEN = 6, YELLOW = 7, ORANGE = 8, RED = 9, WHITE = 10, NONE = 255
			//Example:<code>
			//Private moveHub As LegoinoBoost
			//Private colorSensor As Int = -1
			//moveHUB.Initialize("MoveHub_StateChanged", "00:16:53:AE:9B:27", False)
			//If moveHUB.Connected Then
			//	colorSensor = moveHub.ColorSensor
			//	moveHub.SetLedColor(colorSensor)
			//End If
			//</code>
			int ColorSensor;
			//Tilt sensor degrees of rotation/tilt around the x axis.
			int TiltSensorX;
			//Tilt sensor degrees of rotation/tilt around the y axis.
			int TiltSensorY;
			//~hide
			String name;

			//
			//INIT
			//

			//Initializes the hub object.
			//StateChangedSub - The sub to call when the hub connection has changed.
			//Addr - Device MAC address - a4:c1:38:38:a9:0c.
			//Debug - Set to true to log the various steps from init to getting data.
			//Returns:
			//None
			//Example:<code>
			//Private moveHub As LegoinoBoost
			//moveHub.Initialize("MoveHub_StateChangedSub", "00:16:53:AE:9B:27", False)
			//Sub MoveHub_StateChanged(Connected As Boolean)
			//  Log("MoveHUB StateChanged: Connected to ", moveHub.Name)
			//End Sub
			//</code>
			bool Initialize(SubVoidBool StateChangedSub, B4RString* Addr, bool Debug=false);

			//Initializes the hub object.
			//StateChangedExSub - The sub to call when the hub connection or any of the sensor values has changed.
			//Addr - Device MAC address - a4:c1:38:38:a9:0c.
			//Debug - Set to true to log the various steps from init to getting data.
			//Returns:
			//None
			//Example:<code>
			//Private moveHub As LegoinoBoost
			//Private ConnectionStatePrev As Boolean = False
			//moveHub.InitializeEx("MoveHub_StateChangedExSub", "00:16:53:AE:9B:27", False)
			//Sub MoveHub_StateChangedEx(Connected As Boolean, Battery As Byte, Voltage As Double, Distance As Double, Color As Int)
			//	If Connected <> ConnectionStatePrev Then
			//		If Connected Then
			//			Log("MoveHUB StateChanged: Connected to ", moveHub.Name)
			//		Else
			//			Log("MoveHUB StateChanged: Disconnected")
			//		End If
			//		ConnectionStatePrev = Connected
			//	End If
			//	If Connected And Distance <= 0 Then Return
			//	If Connected Then Log("Distance: ", Distance, "mm")
			//End Sub
			//</code>
			bool InitializeEx(SubVoidBoost StateChangedExSub, B4RString* Addr, bool Debug=false);

			//
			//BOOST - Basic Move/Rotate methods
			//
			
			//Move forward (port AB) with the default speed and stop after the number of steps.
			//steps - Number of steps (Boost grid).
			//Returns:
			//None
			void MoveForward(int steps);

			//Move back (port AB) with the default speed and stop after the number of steps.
			//steps - Number of steps (Boost grid).
			//Returns:
			//None
			void MoveBack(int steps);

			//Rotate (port AB) with the default speed and stop after the degrees.
			//degrees - negative: left, positive: right.
			//Returns:
			//None
			void Rotate(int degrees);
			void RotateLeft(int degrees);
			void RotateRight(int degrees);

			//Move an arc (port AB) with the default speed and stop after degrees.
			//degrees - negative: left, positive: right.
			void MoveArc(int degrees);
			void MoveArcLeft(int degrees);
			void MoveArcRight(int degrees);
			//Returns:
			//None
			
			//
			//HUB LED COLORS
			//
			
			//Set the color of the hub LED with predefined colors.
			//color - one of the available hub colors.
			//Color values if set direct:
			//BLACK = 0,PINK = 1,PURPLE = 2,BLUE = 3,LIGHTBLUE = 4,CYAN = 5,
			//GREEN = 6,YELLOW = 7,ORANGE = 8,RED = 9,WHITE = 10,NONE = 255
			//Returns:
			//None
			//Example:<code>
			//Private moveHub As LegoinoBoost
			//Private DEBUG As Boolean = False
			//Private Const MOVEHUB_ADDRESS As String = "00:16:53:AE:9B:27"
			//moveHub.Initialize("MoveHub_StateChanged", MOVEHUB_ADDRESS, DEBUG)
			//If moveHUB.Connected Then
			//	moveHub.SetLEDColor(moveHub.LED_COLOR_GREEN)
			//End If
			//</code>
			void SetLEDColor(Byte color);
			
			//Set the color of the hub LED with RGB values .
			//red - 0..255.
			//green - 0..255. 
			//blue - 0..255. 
			//Returns:
			//None
			//Example:<code>
			//Private moveHub As LegoinoBoost
			//Private DEBUG As Boolean = False
			//Private Const MOVEHUB_ADDRESS As String = "00:16:53:AE:9B:27"
			//moveHub.Initialize("MoveHub_StateChanged", MOVEHUB_ADDRESS, DEBUG)
			//If moveHUB.Connected Then
			//	moveHub.SetLEDRGBColor(255, 125, 125)
			//End If
			//</code>
			void SetLEDRGBColor(Byte red, Byte green, Byte blue);
			
			//Set the color of the hub LED with HSV values.
			//hue - 0..360.
			//saturation - 0..1.
			//value - 0..1.
			//Returns:
			//None
			//Example:<code>
			//Private moveHub As LegoinoBoost
			//Private DEBUG As Boolean = False
			//Private Const MOVEHUB_ADDRESS As String = "00:16:53:AE:9B:27"
			//moveHub.Initialize("MoveHub_StateChanged", MOVEHUB_ADDRESS, DEBUG)
			//Log("HSV CYAN 180°, 100%, 50%")
			//If moveHUB.Connected Then
			//	moveHub.SetLEDHSVColor(180, 1, 0.5)
			//End If
			//</code>
			void SetLEDHSVColor(int hue, double saturation, double value);

			//
			//HUB MOTORS - Port A and B internal motors; Port C or D external motor
			//

			//Stop the motor on a defined port. Calls SetBasicMotorSpeed with speed 0.
			//port - Port of the hub on which the motor will be stopped (A, B) or (0, 1).
			//Returns:
			//None
			void StopBasicMotor(byte port);

			//Set the motor speed on a defined port.
			//port - Port of the hub on which the speed of the motor will set (A, B, AB).
			//speed - Speed of the motor -100..0..100 negative values will reverse the rotation.
			//Returns:
			//None
			void SetBasicMotorSpeed(byte port, int speed);

			//Set the acceleration profile.
			//port - Port of the hub on which the speed of the motor will set (A, B, AB).
			//time - Time value in ms of the acceleration from 0-100% speed/Power.
			//Returns:
			//None
			void SetAccelerationProfile(byte port, int time);

			//Set the deceleration profile.
			//port - Port of the hub on which the speed of the motor will set (A, B, AB).
			//time - Time value in ms of the deceleration from 100-0% speed/Power.
			//Returns:
			//None
			void SetDecelerationProfile(byte port, int time);

			//Stop the motor on a defined port.
			//port - Port of the hub on which the motor will be stopped (A, B, AB, C, D).
			//Returns:
			//None
			//Example:<code>
			//Private moveHub As LegoinoBoost
			//Private DEBUG As Boolean = False
			//Private Const MOVEHUB_ADDRESS As String = "00:16:53:AE:9B:27"
			//moveHub.Initialize("MoveHub_StateChanged", MOVEHUB_ADDRESS, DEBUG)
			//If moveHUB.Connected Then
			//	moveHUB.StopTachoMotor(moveHUB.MOVEHUBPORT_A)
			//End If
			//</code>
			void StopTachoMotor(byte port);

			//Set the motor speed on a defined port. 
			//port - Port of the hub on which the speed of the motor will set.
			//speed - Speed of the motor -100..0..100 negative values will reverse the rotation.
			//maximum - Power of the motor 0..100.
			//brakingStyle - Braking style how the motor will stop = Brake (default), Float, Hold.
			//Returns:
			//None
			//Example:<code>
			//Private moveHub As LegoinoBoost
			//Private DEBUG As Boolean = False
			//Private Const MOVEHUB_ADDRESS As String = "00:16:53:AE:9B:27"
			//moveHub.Initialize("MoveHub_StateChanged", MOVEHUB_ADDRESS, DEBUG)
			//If moveHUB.Connected Then
			//	moveHUB.SetTachoMotorSpeed(moveHUB.MOVEHUBPORT_A, 20, 100, moveHUB.BRAKINGSTYLE_BRAKE)
			//End If
			//</code>
			void SetTachoMotorSpeed(byte port, int speed, byte maxPower, byte brakingStyle);

			//Set the motor speed on a defined port. 
			//port - Port of the hub on which the speed of the motor will set.
			//speed - Speed of the motor -100..0..100 negative values will reverse the rotation.
			//time - Time in miliseconds for running the motor on the desired speed.
			//maximum - Power of the motor 0..100.
			//brakingStyle - Braking style how the motor will stop = Brake (default), Float, Hold.
			//Returns:
			//None
			void SetTachoMotorSpeedForTime(byte port, int speed, int time, byte maxPower, byte brakingStyle);

			//Set the motor speed on a defined port. 
			//port - Port of the hub on which the speed of the motor will set (A, B, AB).
			//speed - Speed of the motor -100..0..100 negative values will reverse the rotation.
			//degrees - Till which rotation in degrees the motors should run.
			//maximum - Power of the motor 0..100 (default value=100).
			//brakingStyle - Braking style how the motor will stop. Brake (default), Float, Hold.
			//Returns:
			//None
			void SetTachoMotorSpeedForDegrees(byte port, int speed, long degrees, byte maxPower, byte brakingStyle);

			//Set the speed of the hub motors (port A and B).
			//speedLeft - Speed of the left motor.
			//speedRight - Speed of the right motor.
			//degrees - Till which rotation in degrees the hub motors should run.
			//maximum - Power of the motor 0..100 (default value = 100).
			//brakingStyle - Braking style how the motor will stop = Brake (default), Float, Hold.
			//Returns:
			//None
			void SetTachoMotorSpeedsForDegrees(int speedLeft, int speedRight, long degrees, byte maxPower, byte brakingStyle);

			//Set the motor absolute position on a defined port.
			//port - Port of the hub on which the speed of the motor will set (A, B, AB).
			//speed - Speed of the motor 0..100 = positive values only.
			//position - Position in degrees (relative to zero point on power up, or encoder reset) -2,147,483,648..0..2,147,483,647.
			//maximum - Power of the motor 0..100 (default value=100).
			//brakingStyle - Braking style how the motor will stop = Brake (default), Float, Hold.
			//Returns:
			//None
			void SetAbsoluteMotorPosition(byte port, int speed, long position, byte maxPower, byte brakingStyle);

			//Set the motor encoded position on a defined port.
			//port - Port of the hub on which the speed of the motor will set (A, B, AB).
			//position - Position in degrees to encode (0=Reset) -2,147,483,648..0..2,147,483,647.
			//Returns:
			//None
			void SetAbsoluteMotorEncoderPosition(byte port, long position);

			//Calibrate the motor on a defined port.
			//This should be done once. 
			//During calibration, approx 5 seconds, the LED turns orange and to yellow if finished.
			//port - Port of the hub the motor will calibrated (A, B, AB for Tacho motor; C or D for Basic motor).
			//Returns:
			//None
			void SetMotorCalibration(byte port);
  
			//
			//DUPLO TRAIN SOUND 
			//
  
			//Play a predefined sound on the Duplo train hub.
			//sound - value. Could be set via the DuploTrainBaseSound enum.
			//Returns:
			//None
			void PlaySound(byte sound);

			//Play a predefined tone on the Duplo train hub.
			//tone - value. Different bieps on different number 0..10 Which number is which.
			//beep is not really clear right now.
			//Returns:
			//None
			void PlayTone(byte number);

			//
			//HUB
			//
			
			//Send shutdown command to the hub.
			//Returns:
			//None
			void ShutDownHub();

			//
			//STATES
			//

			//Hub connection state.
			//Returns:
			//Boolean True (Connected) or False (Disconnected).
			bool getConnected();


			//
			//PROPERTIES
			//

			//Name of the hub.
			//Returns:
			//String with the hub name.
			B4RString* getName(void);

			//Debug.
			//Set debug on or off.
			//Returns:
			//None
			void setDebug(bool debug);

			//
			//DEFINES
			//

			//MoveHUB LED Color BLACK = 0
			#define /*Byte LED_COLOR_BLACK;*/		B4RLegoinoBoost_LED_COLOR_BLACK		(byte)Color::BLACK
			//MoveHUB LED Color PINK = 1
			#define /*Byte LED_COLOR_PINK;*/		B4RLegoinoBoost_LED_COLOR_PINK		(byte)Color::PINK
			//MoveHUB LED Color PURPLE = 2
			#define /*Byte LED_COLOR_PURPLE;*/		B4RLegoinoBoost_LED_COLOR_PURPLE	(byte)Color::PURPLE
			//MoveHUB LED Color BLUE = 3
			#define /*Byte LED_COLOR_BLUE;*/		B4RLegoinoBoost_LED_COLOR_BLUE		(byte)Color::BLUE
			//MoveHUB LED Color LIGHTBLUE = 4
			#define /*Byte LED_COLOR_LIGHTBLUE;*/	B4RLegoinoBoost_LED_COLOR_LIGHTBLUE	(byte)Color::LIGHTBLUE
			//MoveHUB LED Color CYAN = 5
			#define /*Byte LED_COLOR_CYAN;*/		B4RLegoinoBoost_LED_COLOR_CYAN		(byte)Color::CYAN
			//MoveHUB LED Color GREEN = 6
			#define /*Byte LED_COLOR_GREEN;*/		B4RLegoinoBoost_LED_COLOR_GREEN		(byte)Color::GREEN
			//MoveHUB LED Color YELLOW = 7
			#define /*Byte LED_COLOR_YELLOW;*/		B4RLegoinoBoost_LED_COLOR_YELLOW	(byte)Color::YELLOW
			//MoveHUB LED Color ORANGE = 8
			#define /*Byte LED_COLOR_ORANGE;*/		B4RLegoinoBoost_LED_COLOR_ORANGE	(byte)Color::ORANGE
			//MoveHUB LED Color RED = 9
			#define /*Byte LED_COLOR_RED;*/			B4RLegoinoBoost_LED_COLOR_RED		(byte)Color::RED
			//MoveHUB LED Color WHITE = 10
			#define /*Byte LED_COLOR_WHITE;*/		B4RLegoinoBoost_LED_COLOR_WHITE		(byte)Color::WHITE
			//MoveHUB LED Color NONE = 255
			#define /*Byte LED_COLOR_NONE;*/		B4RLegoinoBoost_LED_COLOR_NONE		(byte)Color::NONE

			//Braking style BRAKE = 127
			#define /*Byte BRAKINGSTYLE_BRAKE;*/	B4RLegoinoBoost_BRAKINGSTYLE_BRAKE	(byte)BrakingStyle::BRAKE
			//Braking style HOLD = 126
			#define /*Byte BRAKINGSTYLE_HOLD;*/		B4RLegoinoBoost_BRAKINGSTYLE_HOLD	(byte)BrakingStyle::HOLD
			//Braking style FLOAT = 0
			#define /*Byte BRAKINGSTYLE_FLOAT;*/	B4RLegoinoBoost_BRAKINGSTYLE_FLOAT	(byte)BrakingStyle::FLOAT

			// MoveHUB Port A = 0x00 = Tacho Motor A
			#define /*Byte MOVEHUBPORT_A;*/			B4RLegoinoBoost_MOVEHUBPORT_A		(byte)MoveHubPort::A
			// MoveHUB Port B = 0x01 = Tacho Motor B
			#define /*Byte MOVEHUBPORT_B;*/			B4RLegoinoBoost_MOVEHUBPORT_B		(byte)MoveHubPort::B
			// MoveHUB Port AB = 0x10 = Tacho Motors A and B
			#define /*Byte MOVEHUBPORT_AB;*/		B4RLegoinoBoost_MOVEHUBPORT_AB		(byte)MoveHubPort::AB
			// MoveHUB Port C = 0x02 = Basic Motor or Color Distance Sensor
			#define /*Byte MOVEHUBPORT_C;*/			B4RLegoinoBoost_MOVEHUBPORT_C		(byte)MoveHubPort::C
			// MoveHUB Port D = 0x03 = Basic Motor or Color Distance Sensor
			#define /*Byte MOVEHUBPORT_D;*/			B4RLegoinoBoost_MOVEHUBPORT_D		(byte)MoveHubPort::D
			// MoveHUB Port LED = 0x32 = Hub LED
			#define /*Byte MOVEHUBPORT_LED;*/		B4RLegoinoBoost_MOVEHUBPORT_LED		(byte)MoveHubPort::LED
			// MoveHUB Port TILT = 0x3A = Tilt X or Z Sensor
			#define /*Byte MOVEHUBPORT_TILT;*/		B4RLegoinoBoost_MOVEHUBPORT_TILT	(byte)MoveHubPort::TILT
			// MoveHUB Port CURRENT = 0x3B = Hub Current - Max current is 2444 mA
			#define /*Byte MOVEHUBPORT_CURRENT;*/	B4RLegoinoBoost_MOVEHUBPORT_CURRENT	(byte)MoveHubPort::CURRENT
			// MoveHUB Port CURRENT = 0x3C = Hub Voltage - Max Voltage is 9.6V
			#define /*Byte MOVEHUBPORT_VOLTAGE;*/	B4RLegoinoBoost_MOVEHUBPORT_VOLTAGE	(byte)MoveHubPort::VOLTAGE
			
	};
}
