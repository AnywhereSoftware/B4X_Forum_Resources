#pragma once
#include "B4RDefines.h"
#include "BleMouse.h"
namespace B4R {
	//~Version: 1.01
	//~Shortname: BLEMouse
    //~Author: Original Library from T-vk
	class B4RBLEMOUSE {
		private:
            uint8_t sizeblekey[sizeof(BleMouse)];
			BleMouse* blemouse;
		public:
			//Start BLE server. Pass the name of the BT mouse device.
			//This library is only intended for the ESP32.
			void Initialize(ArrayByte* s);
			//Returns True if device is connected otherwise False.
			bool isConnected(void);
			//Set a new battery level from 0-100.
			void BatteryLevelSet(byte level);
			//Return battery level from 0-100.
			byte BatteryLevelGet(void);
			
			//Click mouse button. Use button constants.
			void Click(byte b);
			//Press mouse button. Use button constants.
			void Press(byte b);
			//Release mouse button. Use button constants.
			void Release(byte b);
			//Check button status. Use button constants.
			bool isPressed(byte b);
			//Move mouse x, y, vertical wheel and horizontal wheel.
			//The range is a signed byte, -127 to +127 only.
			void Move(int x, int y, int vwheel, int hwheel);
			
			//Left mouse button.
			const byte LEFT = 1;
			//Rignt mouse button.
			const byte RIGHT = 2;
			//Middle mouse button.
			const byte MIDDLE = 4;
			//Back mouse button.
			const byte BACK = 8;
			//Forward mouse button.
			const byte FORWARD = 16;
	};
}