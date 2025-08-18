#pragma once
#include "B4RDefines.h"
#include "BleKeyboard.h"
namespace B4R {
	//~Version: 1.01
	//~Shortname: BLEKeyBoard
    //~Author: Original Library from T-vk
	class B4RBLEKEY {
		private:
            uint8_t sizeblekey[sizeof(BleKeyboard)];
			BleKeyboard* blekey;
		public:
			//Start BLE server. Pass the name of the BT keyboard device.
			//This library is only intended for the ESP32.
			void Initialize(ArrayByte* s);
			//Returns True if device is connected otherwise False.
			bool isConnected(void);
			//Set a new battery level from 0-100.
			void BatteryLevelSet(byte level);
			//Return battery level from 0-100.
			byte BatteryLevelGet(void);
			
			//Press a key, use key constants or ASCII value.
			byte Press(byte k);
			//Release a key, use key constants or ASCII value.
			byte Release(byte k);
			//Release all keys.
			void ReleaseAll (void);
			
			//Write a single ascii value or use key constants.
			byte Write(byte c);
			//Write a string of a given length.
			UInt WriteStr(ArrayByte* s, UInt size);
			//Write a media key, using key constants.
			byte WriteMedia(MediaKeyReport mk);
			
			// Media keys
			
			MediaKeyReport KEY_MEDIA_NEXT_TRACK = {1, 0};
			MediaKeyReport KEY_MEDIA_PREVIOUS_TRACK = {2, 0};
			MediaKeyReport KEY_MEDIA_STOP = {4, 0};
			MediaKeyReport KEY_MEDIA_PLAY_PAUSE = {8, 0};
			MediaKeyReport KEY_MEDIA_MUTE = {16, 0};
			MediaKeyReport KEY_MEDIA_VOLUME_UP = {32, 0};
			MediaKeyReport KEY_MEDIA_VOLUME_DOWN = {64, 0};
			MediaKeyReport KEY_MEDIA_WWW_HOME = {128, 0};
			// Opens "My Computer" on Windows
			MediaKeyReport KEY_MEDIA_LOCAL_MACHINE_BROWSER = {0, 1};
			MediaKeyReport KEY_MEDIA_CALCULATOR = {0, 2};
			MediaKeyReport KEY_MEDIA_WWW_BOOKMARKS = {0, 4};
			MediaKeyReport KEY_MEDIA_WWW_SEARCH = {0, 8};
			MediaKeyReport KEY_MEDIA_WWW_STOP = {0, 16};
			MediaKeyReport KEY_MEDIA_WWW_BACK = {0, 32};
			// Media Selection
			MediaKeyReport KEY_MEDIA_CONSUMER_CONTROL_CONFIGURATION = {0, 64};
			MediaKeyReport KEY_MEDIA_EMAIL_READER = {0, 128};
			
			//Non printable keys
			
			const byte KEY_LEFT_CTRL = 0x80;
			const byte KEY_LEFT_SHIFT = 0x81;
			const byte KEY_LEFT_ALT = 0x82;
			const byte KEY_LEFT_GUI = 0x83;
			const byte KEY_RIGHT_CTRL = 0x84;
			const byte KEY_RIGHT_SHIFT = 0x85;
			const byte KEY_RIGHT_ALT = 0x86;
			const byte KEY_RIGHT_GUI = 0x87;

			const byte KEY_UP_ARROW = 0xDA;
			const byte KEY_DOWN_ARROW = 0xD9;
			const byte KEY_LEFT_ARROW = 0xD8;
			const byte KEY_RIGHT_ARROW = 0xD7;
			const byte KEY_BACKSPACE = 0xB2;
			const byte KEY_TAB = 0xB3;
			const byte KEY_RETURN = 0xB0;
			const byte KEY_ESC = 0xB1;
			const byte KEY_INSERT = 0xD1;
			const byte KEY_DELETE = 0xD4;
			const byte KEY_PAGE_UP = 0xD3;
			const byte KEY_PAGE_DOWN = 0xD6;
			const byte KEY_HOME = 0xD2;
			const byte KEY_END = 0xD5;
			const byte KEY_CAPS_LOCK = 0xC1;
			const byte KEY_F1 = 0xC2;
			const byte KEY_F2 = 0xC3;
			const byte KEY_F3 = 0xC4;
			const byte KEY_F4 = 0xC5;
			const byte KEY_F5 = 0xC6;
			const byte KEY_F6 = 0xC7;
			const byte KEY_F7 = 0xC8;
			const byte KEY_F8 = 0xC9;
			const byte KEY_F9 = 0xCA;
			const byte KEY_F10 = 0xCB;
			const byte KEY_F11 = 0xCC;
			const byte KEY_F12 = 0xCD;
			const byte KEY_F13 = 0xF0;
			const byte KEY_F14 = 0xF1;
			const byte KEY_F15 = 0xF2;
			const byte KEY_F16 = 0xF3;
			const byte KEY_F17 = 0xF4;
			const byte KEY_F18 = 0xF5;
			const byte KEY_F19 = 0xF6;
			const byte KEY_F20 = 0xF7;
			const byte KEY_F21 = 0xF8;
			const byte KEY_F22 = 0xF9;
			const byte KEY_F23 = 0xFA;
			const byte KEY_F24 = 0xFB;

	};
}