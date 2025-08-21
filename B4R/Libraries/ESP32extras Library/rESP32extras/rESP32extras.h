#pragma once
#include "B4RDefines.h"
#include <WiFi.h>
#include <WiFiClientSecure.h>

extern "C" {
//#include "user_interface.h"
}

//~version: 1.00

namespace B4R {
	
	//~shortname: ESP32extras
	class B4RESP32extras {
		public:
			void Restart();
			ulong FlashChipSpeed();
			ulong CpuCycleCount();
			ulong FreeHeapSpace();
			byte CpuFreqMHz();
			
			void GetMacAddress(ArrayByte* mac);
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

		private:
			IPAddress b4str2IPaddress(B4RString* sip);
			IPAddress str2IPaddress(byte* sip, int L);
	};
	extern WiFiGenericClass WiFiGeneric;
}
