#pragma once
#include "B4RDefines.h"
#include <ESP8266WiFi.h>

extern "C" {
#include "user_interface.h"
}
 
//~version: 1.07

namespace B4R {
	
	//~shortname: D1Pins
	//Pins constants for Wemos D1 Legacy boards.
	//~shortname: Wemos_LegacyD1_Pins
	//Pins constants for Wemos D1 Legacy boards (not R2).
	class Wemos_LegacyD1_Pins {
		public:
		static const Byte D0   = 3;
		static const Byte D1   = 1; 
		static const Byte D2   = 16; 
		static const Byte D3   = 5; 
		static const Byte D4   = 4;
		static const Byte D5   = 14;
		static const Byte D6   = 12;
		static const Byte D7   = 13;
		static const Byte D8   = 0; 
		static const Byte D9   = 2; 
		static const Byte D10  = 15; 
		static const Byte D11  = 13; 
		static const Byte D12  = 12; 
		static const Byte D13  = 14; 
		static const Byte D14  = 4; 
		static const Byte D15  = 5; 
		static const Byte RX   = 2;
		static const Byte TX   = 15;
		static const Byte LED  = 2;
		static const Byte A0   = 0;
		};
	
	//~shortname: NodeMCU_ESP12_pins
	//Pins constants for NodeMCU ESP-12 boards.
	class NodeMCU_ESP12_pins {
		public:
		static const Byte D0   = 16;
		static const Byte D1   = 5;
		static const Byte D2   = 4;
		static const Byte D3   = 0;
		static const Byte D4   = 2;
		static const Byte D5   = 14;
		static const Byte D6   = 12;
		static const Byte D7   = 13;
		static const Byte D8   = 15;
		static const Byte RX   = 3;
		static const Byte TX   = 1;
		static const Byte LED1 = 14;
		static const Byte LED2 = 2;
		static const Byte SD2  = 9;
		static const Byte SD3  = 10;
		static const Byte SPI_CLK  = 14;
		static const Byte SPI_MISO = 12;
		static const Byte SPI_MOSI = 13;
		static const Byte SPI_CS   = 15;
		static const Byte A0   = 0;
	};
	
	//~shortname: Wemos_D1_R2_Pins
	//Pins constants for Wemos D1 R2 boards.
		class Wemos_D1_R2_Pins {
		public:
		static const Byte D0   = 16;
		static const Byte D1   = 5;
		static const Byte D2   = 4;
		static const Byte D3   = 0;
		static const Byte D4   = 2;
		static const Byte D5   = 14;
		static const Byte D6   = 12;
		static const Byte D7   = 13;
		static const Byte D8   = 15;
		static const Byte RX   = 3;
		static const Byte TX   = 1;
		static const Byte LED1 = 14;
		static const Byte LED2 = 2;
		static const Byte SD2  = 9;
		static const Byte SD3  = 10;
		static const Byte SDA  = 4;
		static const Byte SCL  = 5;
		static const Byte SPI_CLK  = 14;
		static const Byte SPI_MISO = 12;
		static const Byte SPI_MOSI = 13;
		static const Byte SPI_CS   = 15;
		static const Byte A0   = 0;
	};

	//~shortname: ESP8266extras
	class B4RESP8266extras {
		//  https://links2004.github.io/Arduino/d4/dd2/class_esp_class.html
		public:
			void Restart();
			ulong UniqueID();
			ulong FlashChipId();
			ulong FlashChipSize();
			ulong FlashChipSpeed();
			ulong CpuCycleCount();
			ulong FreeHeapSpace();
			ulong Vcc();
			byte CpuFreqMHz();
			ulong SketchSize();
			ulong FreeSketchSpace();

			static const int WAKE_RF_DEFAULT   = 0;
			static const int WAKE_RFCAL   		= 1;
			static const int WAKE_NO_RFCAL   	= 2;
			static const int WAKE_RF_DISABLED  = 4;
			
			void DeepSleep(uint32 microseconds, uint wakemode);		
			
			void GetMacAddress(ArrayByte* mac);
			
			B4RString* ResetReasonMessage();
			ulong ResetReason();
			
			struct my_rst_info{
				uint32 reason;
				uint32 exccause;
				uint32 epc1;
				uint32 epc2;
				uint32 epc3;
				uint32 excvaddr;
				uint32 depc;
			};
			
			static const ulong REASON_DEFAULT_RST		= 0;
			static const ulong REASON_WDT_RST			= 1;
			static const ulong REASON_EXCEPTION_RST		= 2;
			static const ulong REASON_SOFT_WDT_RST		= 3;
			static const ulong REASON_SOFT_RESTART		= 4;
			static const ulong REASON_DEEP_SLEEP_AWAKE	= 5;
			static const ulong REASON_EXT_SYS_RST		= 6;
			
			static const Byte WIFI_MODE_OFF    = 0;  //following changed in v1.07 by Starchild 
			static const Byte WIFI_MODE_STA    = 1;  //swapped values of AP and STA
			static const Byte WIFI_MODE_AP     = 2;  //to be same as in the Wifi source library
			static const Byte WIFI_MODE_AP_STA = 3;


			void ConfigNetwork(ArrayByte* ip,ArrayByte* gateway,ArrayByte* subnet,ArrayByte* dns1,ArrayByte* dns2);
			bool ConfigAP(B4RString* ip, B4RString* gateway, B4RString* subnet);	
			void GetAPIP(ArrayByte* ip);
			B4RString* IP2str(ArrayByte* ip);
			ArrayByte* str2IP(B4RString* sip);
			bool Host2IP(B4RString* Host, ArrayByte* ip);
			bool IsBadIP(ArrayByte* ip);
			int GetInternetIP(ArrayByte* ip);
			bool ConnectWPS();
			bool ConnectWPS2(UInt Position);
			B4RString* SSID();
			void GetLocalIP(ArrayByte* ip);
			void GetSubnetMask(ArrayByte* ip);
			void GetGatewayIP(ArrayByte* ip);
			bool SetChannel(ulong channel);
			ulong GetChannel();
			void SetPower(Byte dBm);
			void PrintWifiDetails();
			void SetWifiMode(Byte new_wifi_mode);

			//added (in v1.05) these PWM functions as requested by B4R user "janderkan"
			void AnalogWriteRange(uint32_t Range);
			void AnalogWriteFreq(uint32_t Freq);
			void SerialSwap();
			//added (in V1.06) by Bryon Dunkley-Smith
			void GetAPMacAddress(ArrayByte* mac);
		private:
			IPAddress b4str2IPaddress(B4RString* sip);
			IPAddress str2IPaddress(byte* sip, int L);
	};
	extern ESP8266WiFiGenericClass WiFiGeneric;
}
