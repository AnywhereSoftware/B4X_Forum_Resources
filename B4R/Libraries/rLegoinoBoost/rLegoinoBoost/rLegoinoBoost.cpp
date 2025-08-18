// B4R Library rLegoinoBoost
// The B4R defines are required!
#include "B4RDefines.h"
namespace B4R {
	// Debug flag true  false
	bool isDebug = true;

	// Declare the boost object (movehub)
	Boost MoveHub;
	
	// Declare the legoboost object - only a single instance can be created. This object is used for the MoveHUB property & port callbacks.
	B4RLegoinoBoost* legoino;
	
	// Flags for various checks
	bool isInitialized = false;
	bool isHwVersionAvailable = false;
	bool isFwVersionAvailable = false;
	bool isBatteryTypeAvailable = false;
	// Flag to trigger state update
	bool updateState = false;

	// Initialize the device and set event to handle connection state change
	bool B4RLegoinoBoost::Initialize(SubVoidBool StateChangedSub, B4RString* Addr, bool Debug) {
		// Set the debug flag
		isDebug = Debug;
		if (isDebug) { ::Serial.println("[DEBUG] Initializing"); }

		// Create a hub instance
		MoveHub.init(Addr->data);
		if (isDebug) { ::Serial.println("[DEBUG] HUB Instance initialized"); }

		// Create a single legoino instance - used in the device&sensor property callbacks
		legoino = this;

		// Setup the looper for the sub StateChangedSub handled by the poller checkForData()
		this->StateChangedSub = StateChangedSub;
		FunctionUnion fu;
		fu.PollerFunction = checkForData;
		pnode.functionUnion = fu;
		pnode.tag = this;
		if (pnode.next == NULL) {
			pollers.add(&pnode);
		}
		// Init the last state values
		this->lastState = false;		//boolean

		if (isDebug) { ::Serial.println("[DEBUG] HUB StateChangeSub setup done"); }
		return true;
	}

	// Initialize the device and set event to handle property changes, like connection state, batterylebvel, voltage, distance, color
	bool B4RLegoinoBoost::InitializeEx(SubVoidBoost StateChangedExSub, B4RString* Addr, bool Debug) {
		// Set the debug flag
		isDebug = Debug;
		if (isDebug) { ::Serial.println("[DEBUG] Initializing"); }

		// Create a hub instance
		MoveHub.init(Addr->data);
		if (isDebug) { ::Serial.println("[DEBUG] HUB Instance initialized"); }

		// Create a single legoino instance - used in the device&sensor property callbacks
		legoino = this;

		// Setup the looper for the sub StateChangedSub handled by the poller checkForData()
		this->StateChangedExSub = StateChangedExSub;
		FunctionUnion fu;
		fu.PollerFunction = checkForDataEx;
		pnode.functionUnion = fu;
		pnode.tag = this;
		if (pnode.next == NULL) {
			pollers.add(&pnode);
		}
		// Init the last state values
		this->lastState = false;		//boolean
		this->lastBatteryLevel = 0;		//byte
		this->lastVoltageSensor = -1;	//double
		this->lastDistanceSensor = 0;	//double
		this->lastColorSensor = 0;		//int

		if (isDebug) { ::Serial.println("[DEBUG] HUB StateChangedExSub setup done"); }
		return true;
	}

	/*
	*	BOOST
	*/

	// 
	void B4RLegoinoBoost::MoveForward(int Steps) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB moving forward steps: %d\r", Steps); }
		MoveHub.moveForward(Steps);
	}

	// 
	void B4RLegoinoBoost::MoveBack(int Steps) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB moving backward steps: %d\r", Steps); }
		MoveHub.moveBack(Steps);
	}

	// 
	void B4RLegoinoBoost::Rotate(int Degrees) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB rotating degrees: %d\r", Degrees); }
		MoveHub.rotate(Degrees);
	}

	// 
	void B4RLegoinoBoost::RotateLeft(int Degrees) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB rotating left degrees: %d\r", Degrees); }
		MoveHub.rotateLeft(Degrees);
	}

	// 
	void B4RLegoinoBoost::RotateRight(int Degrees) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB rotating right degrees: %d\r", Degrees); }
		MoveHub.rotateRight(Degrees);
	}

	// 
	void B4RLegoinoBoost::MoveArc(int Degrees) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB moveArc degrees: %d\r", Degrees); }
		MoveHub.moveArc(Degrees);
	}

	// 
	void B4RLegoinoBoost::MoveArcLeft(int Degrees) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB moveArc Left degrees: %d\r", Degrees); }
		MoveHub.moveArcLeft(Degrees);
	}

	// 
	void B4RLegoinoBoost::MoveArcRight(int Degrees) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB moveArc Right degrees: %d\r", Degrees); }
		MoveHub.moveArcRight(Degrees);
	}

	/*
	* COLORS
	*/
	
	void B4RLegoinoBoost::SetLEDColor(Byte color) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set LED Color: %d\r", color); }
		MoveHub.setLedColor((Color) color);
	}

	void B4RLegoinoBoost::SetLEDRGBColor(Byte red, Byte green, Byte blue) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set LED RGB Color: %d-%d-%d\r", red, green, blue); }
		MoveHub.setLedRGBColor((char)red, (char) green, (char) blue);
	}

	void B4RLegoinoBoost::SetLEDHSVColor(int hue, double saturation, double value) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set LED HSV Color: %d-%.f-%.f\r", hue, saturation, value); }
		MoveHub.setLedHSVColor(hue, saturation, value);
	}

	/*
	* MOTORS
	*/

	void B4RLegoinoBoost::StopBasicMotor(byte port) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Stop basic motor port: %d\r", port); }
		MoveHub.stopBasicMotor(port);
	}

	void B4RLegoinoBoost::SetBasicMotorSpeed(byte port, int speed) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set basic motor speed port, speed: %d, %d\r", port, speed); }
		MoveHub.setBasicMotorSpeed(port, speed);
	}

	void B4RLegoinoBoost::SetAccelerationProfile(byte port, int time) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set accelaration profile port, time: %d, %d\r", port, time); }
		MoveHub.setAccelerationProfile(port, time);
	}

	void B4RLegoinoBoost::SetDecelerationProfile(byte port, int time) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set declaration profile port, time: %d, %d\r", port, time); }
		MoveHub.setDecelerationProfile(port, time);
	}

	void B4RLegoinoBoost::StopTachoMotor(byte port) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Stop tacho motor port: %d\r", port); }
		MoveHub.stopTachoMotor(port);
	}

	void B4RLegoinoBoost::SetTachoMotorSpeed(byte port, int speed, byte maxPower, byte brakingStyle) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set tacho motor speed port, speed: %d, %d\r", port, speed); }
		BrakingStyle bs = BrakingStyle::BRAKE;
		if (brakingStyle == B4RLegoinoBoost_BRAKINGSTYLE_HOLD) { bs = BrakingStyle::HOLD; }
		if (brakingStyle == B4RLegoinoBoost_BRAKINGSTYLE_FLOAT) { bs = BrakingStyle::FLOAT; }
		MoveHub.setTachoMotorSpeed(port, speed, maxPower, bs);
	}

	void B4RLegoinoBoost::SetTachoMotorSpeedForTime(byte port, int speed, int time, byte maxPower, byte brakingStyle) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set tacho motor speed for time port, speed: %d, %d\r", port, speed); }
		BrakingStyle bs = BrakingStyle::BRAKE;
		if (brakingStyle == B4RLegoinoBoost_BRAKINGSTYLE_HOLD) { bs = BrakingStyle::HOLD; }
		if (brakingStyle == B4RLegoinoBoost_BRAKINGSTYLE_FLOAT) { bs = BrakingStyle::FLOAT; }
		MoveHub.setTachoMotorSpeedForTime(port, speed, time, maxPower, bs);
	}

	void B4RLegoinoBoost::SetTachoMotorSpeedForDegrees(byte port, int speed, long degrees, byte maxPower, byte brakingStyle) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set tacho motor speed for degrees port, speed, degrees: %d, %d, %d\r", port, speed, degrees); }
		BrakingStyle bs = BrakingStyle::BRAKE;
		if (brakingStyle == B4RLegoinoBoost_BRAKINGSTYLE_HOLD) { bs = BrakingStyle::HOLD; }
		if (brakingStyle == B4RLegoinoBoost_BRAKINGSTYLE_FLOAT) { bs = BrakingStyle::FLOAT; }
		MoveHub.setTachoMotorSpeedForDegrees(port, speed, (int32_t) degrees, maxPower, bs);
	}

	void B4RLegoinoBoost::SetTachoMotorSpeedsForDegrees(int speedLeft, int speedRight, long degrees, byte maxPower, byte brakingStyle) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set tacho motor speeds for degrees port, speed left, right, degrees: %d, %d, %d\r", speedLeft, speedRight, degrees); }
		BrakingStyle bs = BrakingStyle::BRAKE;
		if (brakingStyle == B4RLegoinoBoost_BRAKINGSTYLE_HOLD) { bs = BrakingStyle::HOLD; }
		if (brakingStyle == B4RLegoinoBoost_BRAKINGSTYLE_FLOAT) { bs = BrakingStyle::FLOAT; }
		MoveHub.setTachoMotorSpeedsForDegrees(speedLeft, speedRight, (int32_t) degrees, maxPower, bs);
	}

	void B4RLegoinoBoost::SetAbsoluteMotorPosition(byte port, int speed, long position, byte maxPower, byte brakingStyle) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set absolute motor position: %d, %d, %d\r", port, speed, position); }
		BrakingStyle bs = BrakingStyle::BRAKE;
		if (brakingStyle == B4RLegoinoBoost_BRAKINGSTYLE_HOLD) { bs = BrakingStyle::HOLD; }
		if (brakingStyle == B4RLegoinoBoost_BRAKINGSTYLE_FLOAT) { bs = BrakingStyle::FLOAT; }
		MoveHub.setAbsoluteMotorPosition(port, speed, (int32_t) position, maxPower, bs);
	}

	void B4RLegoinoBoost::SetAbsoluteMotorEncoderPosition(byte port, long position) {
		if (isDebug) { ::Serial.printf("[DEBUG] HUB Set absolute motor encoder position: %d, %d\r", port, position); }
		MoveHub.setAbsoluteMotorEncoderPosition(port, (int32_t) position);
	}

	void B4RLegoinoBoost::SetMotorCalibration(byte port) {
		MoveHub.setLedColor(Color::ORANGE);
		// Move motor to the minimum endstop (i.e. -90)
		MoveHub.setTachoMotorSpeedForDegrees(port, -100, 180);
		delay(2000);
		// Reset the motor encoded position to -90
		MoveHub.setAbsoluteMotorEncoderPosition(port, -90);
		delay(1000);
		// Move to motor center
		MoveHub.setAbsoluteMotorPosition(port, 100, 0);
		MoveHub.setLedColor(Color::YELLOW);
		delay(1000);
	}

	/*
	* SOUND
	*/

	void B4RLegoinoBoost::PlaySound(byte sound) {
		if (isDebug) { ::Serial.printf("[DEBUG] Play sound: %d\r", sound); }
		MoveHub.playSound(sound);
	}

	void B4RLegoinoBoost::PlayTone(byte number) {
		if (isDebug) { ::Serial.printf("[DEBUG] Play tone number: %d\r", number); }
		MoveHub.playTone(number);
	}

	/*
	* SHUTDOWN
	*/

	//
	void B4RLegoinoBoost::ShutDownHub() {
		if (isDebug) { ::Serial.println("[DEBUG] Shutting down the hub"); }
		MoveHub.shutDownHub();
		if (pnode.next != NULL)
			pollers.remove(&pnode);
	}

	/*
	* STATES
	*/
	
	bool B4RLegoinoBoost::getConnected() {
		return MoveHub.isConnected();
	}

	/*
	* PROPERTIES
	*/

	B4RString* B4RLegoinoBoost::getName(void) {
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(name);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}

	void B4RLegoinoBoost::setDebug(bool debug) {
		isDebug = debug;
	}

	/*
	* CALLBACKS
	*/

	// Callback to handle updates of property values, like Battery Level
	void hubPropertyChangeCallback(void *hub, HubPropertyReference hubProperty, uint8_t *pData) {
		Lpf2Hub *myHub = (Lpf2Hub *)hub;

		if (isDebug) { ::Serial.print("[DEBUG] HubProperty: "); }
		if (isDebug) { ::Serial.println((byte)hubProperty, HEX); }

		if (hubProperty == HubPropertyReference::RSSI) {
			if (isDebug) { ::Serial.print("[DEBUG] RSSI: "); }
			if (isDebug) { ::Serial.println(myHub->parseRssi(pData), DEC); }
			return;
		}

		if (hubProperty == HubPropertyReference::ADVERTISING_NAME) {
			if (isDebug) { ::Serial.print("[DEBUG] Advertising Name: "); }
			if (isDebug) { ::Serial.println(myHub->parseHubAdvertisingName(pData).c_str()); }
			legoino->name = myHub->parseHubAdvertisingName(pData).c_str();
			return;
		}

		if (hubProperty == HubPropertyReference::BATTERY_VOLTAGE) {
			legoino->BatteryLevel = myHub->parseBatteryLevel(pData);
			if (isDebug) { ::Serial.print("[DEBUG] BatteryLevel: "); }
			if (isDebug) { ::Serial.println(legoino->BatteryLevel, DEC); }
			return;
		}

		if (hubProperty == HubPropertyReference::BUTTON) {
			if (isDebug) { ::Serial.print("[DEBUG] Button: "); }
			if (isDebug) { ::Serial.println((byte)myHub->parseHubButton(pData), HEX); }
			return;
		}

		if (hubProperty == HubPropertyReference::BATTERY_TYPE) {
			if (isDebug) { ::Serial.print("[DEBUG] BatteryType: "); }
			if (isDebug) { ::Serial.println(myHub->parseBatteryType(pData), HEX); }
			isBatteryTypeAvailable = true;
			return;
		}

		if (hubProperty == HubPropertyReference::FW_VERSION) {
			Version version = myHub->parseVersion(pData);
			if (isDebug) { ::Serial.print("[DEBUG] FWVersion: "); }
			if (isDebug) { ::Serial.print(version.Major); }
			if (isDebug) { ::Serial.print("-"); }
			if (isDebug) { ::Serial.print(version.Minor); }
			if (isDebug) { ::Serial.print("-"); }
			if (isDebug) { ::Serial.print(version.Bugfix); }
			if (isDebug) { ::Serial.print(" Build: "); }
			if (isDebug) { ::Serial.println(version.Build); }
			isFwVersionAvailable = true;
			return;
		}

		if (hubProperty == HubPropertyReference::HW_VERSION) {
			Version version = myHub->parseVersion(pData);
			if (isDebug) { ::Serial.print("[DEBUG] HWVersion: "); }
			if (isDebug) { ::Serial.print(version.Major); }
			if (isDebug) { ::Serial.print("-"); }
			if (isDebug) { ::Serial.print(version.Minor); }
			if (isDebug) { ::Serial.print("-"); }
			if (isDebug) { ::Serial.print(version.Bugfix); }
			if (isDebug) { ::Serial.print(" Build: "); }
			if (isDebug) { ::Serial.println(version.Build); }
			isHwVersionAvailable = true;
			return;
		}
	}

	// Callback to handle updates of sensor values, like VoltageSensor
	void portValueChangeCallback(void *hub, byte portNumber, DeviceType deviceType, uint8_t *pData) {
		Lpf2Hub *myHub = (Lpf2Hub *)hub;

		if (deviceType == DeviceType::VOLTAGE_SENSOR) {
			legoino->VoltageSensor = myHub->parseVoltageSensor(pData);
			if (isDebug) { ::Serial.print("[DEBUG] VoltageSensor: "); }
			if (isDebug) { ::Serial.println(legoino->VoltageSensor, 2); }
			return;
		}
		
		if (deviceType == DeviceType::CURRENT_SENSOR) {
			legoino->CurrentSensor = myHub->parseCurrentSensor(pData);
			if (isDebug) { ::Serial.print("[DEBUG] CurrentSensor: "); }
			if (isDebug) { ::Serial.println(legoino->CurrentSensor, 2); }
			return;
		}
		  
		if (deviceType == DeviceType::MOVE_HUB_TILT_SENSOR) {
			legoino->TiltSensorX = myHub->parseBoostTiltSensorX(pData);
			legoino->TiltSensorY = myHub->parseBoostTiltSensorY(pData);
			if (isDebug) { ::Serial.print("[DEBUG] TiltSensor X: "); }
			if (isDebug) { ::Serial.print(legoino->TiltSensorX, DEC); }
			if (isDebug) { ::Serial.print(" Y: "); }
			if (isDebug) { ::Serial.println(legoino->TiltSensorY, DEC); }
		}

		if (deviceType == DeviceType::COLOR_DISTANCE_SENSOR) {
			// Distance in mm
			legoino->DistanceSensor = myHub->parseDistance(pData);
			if (isDebug) { ::Serial.print("[DEBUG] Distance: "); }
			if (isDebug) { ::Serial.println(legoino->DistanceSensor, DEC); }
			// Color
			// BLACK=0,PINK=1,PURPLE=2,BLUE=3,LIGHTBLUE=4,CYAN=5,GREEN=6,YELLOW=7,ORANGE=8,RED=9,WHITE=10,NONE=255
			legoino->ColorSensor = myHub->parseColor(pData);
			if (isDebug) { ::Serial.print("[DEBUG] Color: "); }
			if (isDebug) { ::Serial.println(legoino->ColorSensor, DEC); }
			// if (isDebug) { ::Serial.print(" "); }
			// if (isDebug) { ::Serial.println(LegoinoCommon::ColorStringFromColor(legoino->Color).c_str()); }
		}
	}

	// CHECKFORDATA - Connection
	// Looper handling movehub connection
	// This method only checks the connection state and not the various sensors (see method checkForDataEx)
	void B4RLegoinoBoost::checkForData(void* b) {
		// Create an legoinoboost object
		B4RLegoinoBoost* me = (B4RLegoinoBoost*)b; 
		// if (isDebug) { ::Serial.println("[DEBUG] Checking for data ..."); }
		// Flag to trigge state update
		updateState = false;

		// Connect via BLE to the movehub using the unique MAC of the hub (try to connect if the uuid of the hub is found).
		if (MoveHub.isConnecting()){
			if (isDebug) { ::Serial.println("[DEBUG] HUB Connecting..."); }
			MoveHub.connectHub();
			// If connected but not initialised then init the callbacks
			if (MoveHub.isConnected() && !isInitialized){
				if (isDebug) { ::Serial.println("[DEBUG] HUB Connected"); }
				// Guided by Legoino lib = Delay needed because otherwise the message is to fast after the connection procedure and the message will get lost
				delay(50);
				MoveHub.activateHubPropertyUpdate(HubPropertyReference::ADVERTISING_NAME, hubPropertyChangeCallback);
				delay(50);
				MoveHub.activateHubPropertyUpdate(HubPropertyReference::BATTERY_VOLTAGE, hubPropertyChangeCallback);
				delay(50);
				MoveHub.activateHubPropertyUpdate(HubPropertyReference::BUTTON, hubPropertyChangeCallback);
				delay(50);
				MoveHub.activateHubPropertyUpdate(HubPropertyReference::RSSI, hubPropertyChangeCallback);
				delay(50);
				MoveHub.activatePortDevice((byte)MoveHubPort::TILT, portValueChangeCallback);
				delay(50);
				MoveHub.activatePortDevice((byte)MoveHubPort::CURRENT, portValueChangeCallback);
				delay(50);
				MoveHub.activatePortDevice((byte)MoveHubPort::VOLTAGE, portValueChangeCallback);
				delay(50);
				// Color Distance Sensor get port and if found activate the port value change callback
				byte portForDevice = MoveHub.getPortForDeviceType((byte)DeviceType::COLOR_DISTANCE_SENSOR);
				if (isDebug) { ::Serial.print("[DEBUG] Color Distance Sensor check ports... if needed sensor is already connected: "); }
				if (isDebug) { ::Serial.println(portForDevice, DEC); }
				if (portForDevice != 255) {
					MoveHub.activatePortDevice(portForDevice, portValueChangeCallback);
				};
				// 
				isInitialized = true;
			}
			else {
				if (isDebug) { ::Serial.println("[DEBUG] FAILED to connect to the HUB"); }
			}
		}

		// Check for state update of the connection
		if (me->lastState != MoveHub.isConnected()) {
			me->lastState = MoveHub.isConnected();
			updateState = true;
		}
		// Update the state by triggering the state changed sub defined as b4r event
		if (updateState) {
			me->StateChangedSub(me->lastState);
			if (isDebug) { ::Serial.print("[DEBUG] State Changed:"); }
			if (isDebug) { ::Serial.print(me->lastState); }
			if (isDebug) { ::Serial.println(""); }
		}
	}

	// CHECKFORDATAEX - All Sensors
	// Looper handling movehub connection
	void B4RLegoinoBoost::checkForDataEx(void* b) {
		// Create an legoinoboost object
		B4RLegoinoBoost* me = (B4RLegoinoBoost*)b; 
		// if (isDebug) { ::Serial.println("[DEBUG] Checking for data ..."); }
		// Flag to trigge state update
		updateState = false;

		// Connect via BLE to the movehub using the unique MAC of the hub (try to connect if the uuid of the hub is found).
		if (MoveHub.isConnecting()){
			if (isDebug) { ::Serial.println("[DEBUG] HUB Connecting..."); }
			MoveHub.connectHub();
			// If connected but not initialised then init the callbacks
			if (MoveHub.isConnected() && !isInitialized){
				if (isDebug) { ::Serial.println("[DEBUG] HUB Connected"); }
				// Guided by Legoino lib = Delay needed because otherwise the message is to fast after the connection procedure and the message will get lost
				delay(50);
				MoveHub.activateHubPropertyUpdate(HubPropertyReference::ADVERTISING_NAME, hubPropertyChangeCallback);
				delay(50);
				MoveHub.activateHubPropertyUpdate(HubPropertyReference::BATTERY_VOLTAGE, hubPropertyChangeCallback);
				delay(50);
				MoveHub.activateHubPropertyUpdate(HubPropertyReference::BUTTON, hubPropertyChangeCallback);
				delay(50);
				MoveHub.activateHubPropertyUpdate(HubPropertyReference::RSSI, hubPropertyChangeCallback);
				delay(50);
				MoveHub.activatePortDevice((byte)MoveHubPort::TILT, portValueChangeCallback);
				delay(50);
				MoveHub.activatePortDevice((byte)MoveHubPort::CURRENT, portValueChangeCallback);
				delay(50);
				MoveHub.activatePortDevice((byte)MoveHubPort::VOLTAGE, portValueChangeCallback);
				delay(50);
				// Color Distance Sensor get port and if found activate the port value change callback
				byte portForDevice = MoveHub.getPortForDeviceType((byte)DeviceType::COLOR_DISTANCE_SENSOR);
				if (isDebug) { ::Serial.print("[DEBUG] Color Distance Sensor check ports... if needed sensor is already connected: "); }
				if (isDebug) { ::Serial.println(portForDevice, DEC); }
				if (portForDevice != 255) {
					MoveHub.activatePortDevice(portForDevice, portValueChangeCallback);
				};
				// 
				isInitialized = true;
			}
			else {
				if (isDebug) { ::Serial.println("[DEBUG] FAILED to connect to the HUB"); }
			}
		}

		// Check for state updates of the various properties
		// Additional checks ca be implemented, like if differencevalue between last and currtent value < NN do nothing.
		if (me->lastState != MoveHub.isConnected()) {
			me->lastState = MoveHub.isConnected();
			updateState = true;
		}
		if (me->lastBatteryLevel != legoino->BatteryLevel) {
			me->lastBatteryLevel = legoino->BatteryLevel;
			updateState = true;
			/* Example updating besed on diff change
			if ( (me->lastBatteryLevel - legoino->BatteryLevel) > 5 ) {
				updateState = true;
			}
			*/
		}
		if (me->lastVoltageSensor != legoino->VoltageSensor) {
			me->lastVoltageSensor = legoino->VoltageSensor;
			updateState = true;
			/* Example updating besed on diff change
			if ( (me->lastVoltageSensor - legoino->VoltageSensor) > 0.5 ) {
				updateState = true;
			}
			*/
		}
		if (me->lastDistanceSensor != legoino->DistanceSensor) {
			me->lastDistanceSensor = legoino->DistanceSensor;
			updateState = true;
			/* Example checking abs value
			double d = me->lastDistanceSensor - legoino->DistanceSensor;
			if ( abs(d) > 10 ) {
				updateState = true;
			}
			*/
		}
		if (me->lastColorSensor != legoino->ColorSensor) {
			me->lastColorSensor = legoino->ColorSensor;
			updateState = true;			
		}

		// Update the state by triggering the state changed sub defined as b4r event
		if (updateState) {
			me->StateChangedExSub(me->lastState, me->lastBatteryLevel, me->lastVoltageSensor, me->lastDistanceSensor, me->lastColorSensor);
			if (isDebug) { ::Serial.print("[DEBUG] State Changed Ex:"); }
			if (isDebug) { ::Serial.print(me->lastState); }
			if (isDebug) { ::Serial.print(","); }
			if (isDebug) { ::Serial.print(me->lastBatteryLevel); }
			if (isDebug) { ::Serial.print(","); }
			if (isDebug) { ::Serial.print(me->lastVoltageSensor); }
			if (isDebug) { ::Serial.print(","); }
			if (isDebug) { ::Serial.print(me->lastDistanceSensor); }
			if (isDebug) { ::Serial.print(","); }
			if (isDebug) { ::Serial.print(me->lastColorSensor); }
			if (isDebug) { ::Serial.println(""); }
		}
	}
}
