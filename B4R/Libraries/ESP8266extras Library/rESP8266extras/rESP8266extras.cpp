#include "B4RDefines.h"
#include <ESP8266WiFi.h>
#include <EEPROM.h>

extern "C" {
#include "user_interface.h"
}

namespace B4R {
	void B4RESP8266extras::Restart() {
		ESP.restart();
	}
	ulong B4RESP8266extras::UniqueID() {
		  return ESP.getChipId();
	}
	ulong B4RESP8266extras::FlashChipId() {
		  return ESP.getFlashChipId();
	}
	ulong B4RESP8266extras::FlashChipSize() {
		  return ESP.getFlashChipSize();
	}
	ulong B4RESP8266extras::FlashChipSpeed() {
		  return ESP.getFlashChipSpeed();
	}
	ulong B4RESP8266extras::CpuCycleCount() {
		  return ESP.getCycleCount();
	}
	ulong B4RESP8266extras::FreeHeapSpace() {
		  return ESP.getFreeHeap();
	}
	ulong B4RESP8266extras::Vcc() {
		  return ESP.getVcc();
	}
	ulong B4RESP8266extras::SketchSize() {
		  return ESP.getSketchSize();
	}
	ulong B4RESP8266extras::FreeSketchSpace() {
		  return ESP.getFreeSketchSpace();
	}
	byte B4RESP8266extras::CpuFreqMHz() {
		  return ESP.getCpuFreqMHz();
	}
	void B4RESP8266extras::DeepSleep(uint32 microseconds, uint wakemode) {
		ESP.deepSleep(microseconds,(RFMode)wakemode);
	}
	void B4RESP8266extras::GetMacAddress(ArrayByte* mac) {
		WiFi.macAddress((byte*)mac->data);
	}
	B4RString* B4RESP8266extras::ResetReasonMessage() {
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(ESP.getResetReason());
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}
	ulong B4RESP8266extras::ResetReason() {
		// had to recast rst_info structure to overcome a forward declaration error
		my_rst_info *r;
		r = (my_rst_info*)ESP.getResetInfoPtr();
		return r->reason;
	}
	void B4RESP8266extras::ConfigNetwork(ArrayByte* ip,ArrayByte* gateway,ArrayByte* subnet,ArrayByte* dns1,ArrayByte* dns2)  {
		IPAddress ipa;
		IPAddress gw;
		IPAddress sn;
		IPAddress d1;
		IPAddress d2;
		for (byte i = 0;i < 4;i++) {
			ipa[i] = ((byte*)ip->data)[i];
			gw[i] = ((byte*)gateway->data)[i];
			sn[i] = ((byte*)subnet->data)[i];
			d1[i] = ((byte*)dns1->data)[i];
			d2[i] = ((byte*)dns2->data)[i];
		}
		WiFi.config(ipa,gw,sn,d1,d2);
	}
	bool B4RESP8266extras::ConfigAP(B4RString* ip, B4RString* gateway, B4RString* subnet)  {
		IPAddress ipa = b4str2IPaddress(ip);
		IPAddress gw = b4str2IPaddress(gateway);
		IPAddress sn = b4str2IPaddress(subnet);
		//for (byte i = 0;i < 4;i++) {
		//	ipa[i] = ((Byte*)ip->data)[i];
		//	gw[i] = ((Byte*)gateway->data)[i];
		//	sn[i] = ((Byte*)subnet->data)[i];
		//}
		return WiFi.softAPConfig(ipa,gw,sn);
	}
	void B4RESP8266extras::GetAPIP(ArrayByte* ip)  {
		IPAddress ipa = WiFi.softAPIP();
		for (byte i = 0;i < 4;i++) {
			((Byte*)ip->data)[i] = ipa[i];
		}
	}
	B4RString* B4RESP8266extras::IP2str(ArrayByte* ip) {
		IPAddress ipa;
		for (byte i = 0;i < 4;i++) {
			ipa[i] = ((Byte*)ip->data)[i];
		}
		return B4RString::PrintableToString(&ipa);
	}
	ArrayByte* B4RESP8266extras::str2IP(B4RString* sip)  {
	    IPAddress ip = b4str2IPaddress(sip);
		ArrayByte* ipa = CreateStackMemoryObject(ArrayByte);
		ipa->data = StackMemory::buffer + StackMemory::cp;
		ipa->length = 4;
		B4R::StackMemory::cp += 4;
		for (byte i = 0;i < 4;i++) {
			((byte*)ipa->data)[i] = ip[i];
		}
		return ipa;
	}
	bool B4RESP8266extras::Host2IP(B4RString* Host, ArrayByte* ip)  {
		IPAddress ipResult;
		int j = 0;
		int err = WiFi.hostByName(Host->data, ipResult);
		//I found that hostByName returned OK(1) even if HostName was not resolved
		//but did return an IP of 0.0.0.0
		for (byte i = 0;i < 4;i++) {
			((byte*)ip->data)[i] = ipResult[i];
			if (ipResult[i]==0) {
				j=j+1;  //count (0) bytes of IP
			}
		}
		return (j!=4);  //returns True = successfully resolved
	}
	bool B4RESP8266extras::IsBadIP(ArrayByte* ip)  {
		for (byte i = 0;i < 4;i++) {
			if (((byte*)ip->data)[i] != 0) {  //look for bad IP  ie. 0.0.0.0
				return false;  //False = IP not 0.0.0.0
			}
		}
		return true;  //True = was a bad IP  ie. 0.0.0.0
	}
	
	//private function
	// convert string holding "192.168.10.20" into 
	// IPAddress .. 4 byte array (0=192,1=168,2=10,3=20)
	IPAddress B4RESP8266extras::b4str2IPaddress(B4RString* b4sip)  {
		int L = b4sip->getLength();
		byte* sip = (byte*)b4sip->data;
		return str2IPaddress(sip,L);
	}
		//private function
	// convert string holding "192.168.10.20" into 
	// IPAddress .. 4 byte array (0=192,1=168,2=10,3=20)
	IPAddress B4RESP8266extras::str2IPaddress(byte* sip, int L)  {
	    IPAddress ip;
		byte c;
		int b = 0;
		int j = 0;
		for (UInt i = 0;i < L;i++) {
			c = (sip)[i];
			if (c==46)  {  // a period chr "."
				if (j<4)  {
					if (b<256)  {
						if (b<0)  {
							j=99;  //byte value was out of range
						}
						else  {
							ip[j] = b;
						}
					}
					else  {
						j=99;  //byte value was out of range
					}
				}
					b = 0;
				j = j+1;
			}
			else  {
				if (c>=48)  {
					if (c<=57)  {
						b = (b*10)+(c-48);
					}
				}
			}
		}
 		if (j<4)  {
			ip[j] = b;
		}
		else  {
			ip[0] = 0;	//denote a bad IP  ie. 0.0.0.0
			ip[1] = 0;
			ip[2] = 0;
			ip[3] = 0;
		}
		return ip;
	}
	
	int B4RESP8266extras::GetInternetIP(ArrayByte* ip)  {
		IPAddress ipResult(0,0,0,0);
		int j = 0;
		WiFiClient client;
		const char* host = "api.ipify.org";
		String url = "/";
		const int httpPort = 80;

		if (WiFi.status() != WL_CONNECTED) {
			//Wifi not connected
			return 2;
		}
		
		if (!client.connect(host, httpPort)) {
			//Host not found
			return 3;
		}

		client.print(String("GET ") + url + " HTTP/1.0\r\n" +
					"Host: " + host + "\r\n" + 
		            "User-Agent: esp8266 \r\n" + 
					"Connection: close\r\n\r\n");
		delay(500);
		
		while(client.available()) {
			String line = client.readStringUntil('\r');
			if (line=="\n") {
				String line = client.readStringUntil('\r');
				byte* bl = (byte*)&line[0];
				ipResult = str2IPaddress(bl,line.length());
				for (byte i = 0;i < 4;i++) {
					((byte*)ip->data)[i] = ipResult[i];
					if (ipResult[i]==0) {
						j=j+1;  //count (0) bytes of IP
					}
				}
				if (j!=4) {
					return 0;   //successfully obtained IP
				} else {
					return 1;   //invalid IP
				}
			}
		}
		return 4;  //invalid response from host
	}

	//try to connect to a secure network via WPS
	bool B4RESP8266extras::ConnectWPS()  {
		WiFi.mode(WIFI_STA);
		delay(1000);
		WiFi.begin("afoobar","xxyyzz"); // make a failed connection
		while (WiFi.status() == WL_DISCONNECTED) {
			delay(500);
		}
		bool wpsSuccess = WiFi.beginWPSConfig();
		if (wpsSuccess)  {
			for (byte j = 0;j < 10;j++) {
				//wait for DHCP to allocate IP
				IPAddress ipa = WiFi.localIP(); 
				for (byte i = 0;i < 4;i++) {
				    if (ipa[i]!=0)  {
						// now has a valid IP address
						delay(100);
						return true;  //connected via WPS
					}
				}
				delay(500);
			}
		}
		
		WiFi.disconnect();
		return false;  //failed to connect via WPS
	}

	//try to connect to a secure network via WPS
	bool B4RESP8266extras::ConnectWPS2(UInt Position)  {
		//stores login info in EEPROM at Position.
		//byte 0,1 = 'S' and 'C' as valid login info prefix
		//byte 2 to 17 .. last SSID
		//byte 18 to 33 .. last Password
		if (Position+34 >= 1024)  {
			return false;  //not enough room left for login info
		}
		byte b;	
		EEPROM.begin(1024);
		
		if ((EEPROM.read(Position)==(byte)'S') && 
			(EEPROM.read(Position+1)==(byte)'C'))  {
			char ssid[16];
			char pwd[16];
			for (UInt i = 0;i < 16;i++)  {
				b = EEPROM.read(Position + 2 + i);
				ssid[i]=(char)b;
				if (b==0) break;
			}
			for (UInt i = 0;i < 16;i++)  {
				b = EEPROM.read(Position + 18 + i);
				pwd[i]=(char)b;
				if (b==0) break;
			}
			WiFi.begin(ssid, pwd);
			if (WiFi.waitForConnectResult() == WL_CONNECTED)  {
				EEPROM.end();
				return true;  //successfully reconnected, using stored login info
			}
		}

		if (ConnectWPS())  {
			//a new WPS connection success
			EEPROM.write(Position,(byte)'S');
			EEPROM.write(Position+1,(byte)'C');
			String new_ssid = WiFi.SSID();
			String new_pwd = WiFi.psk();
			for (UInt i = 0;i < 16;i++)  {
				b = (byte)new_ssid[i];
				EEPROM.write(Position + 2 + i,b);
				if(b==0) break;
			}
			for (UInt i = 0;i < 16;i++)  {
				b = (byte)new_pwd[i];
				EEPROM.write(Position + 18 + i,b);
				if(b==0) break;
			}
			EEPROM.end();
			return true;
		}
		
		EEPROM.end();
		WiFi.disconnect();
		return false;  //failed to connect via WPS
	}

	B4RString* B4RESP8266extras::SSID() {
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(WiFi.SSID());
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}
	
	void B4RESP8266extras::GetLocalIP(ArrayByte* ip)  {
		IPAddress ipa = WiFi.localIP(); 
		for (byte i = 0;i < 4;i++) {
			((Byte*)ip->data)[i] = ipa[i];
		}
	}

	void B4RESP8266extras::GetSubnetMask(ArrayByte* ip)  {
		IPAddress ipa = WiFi.subnetMask(); 
		for (byte i = 0;i < 4;i++) {
			((Byte*)ip->data)[i] = ipa[i];
		}
	}

	void B4RESP8266extras::GetGatewayIP(ArrayByte* ip)  {
		IPAddress ipa = WiFi.gatewayIP(); 
		for (byte i = 0;i < 4;i++) {
			((Byte*)ip->data)[i] = ipa[i];
		}
	}

	bool B4RESP8266extras::SetChannel(ulong channel)  {
		if(channel > 0 && channel <= 13) {
			wifi_set_channel(channel);  //from user_interface.h
			return true;
		}
		return false;
	}

	ulong B4RESP8266extras::GetChannel()  {
		return wifi_get_channel();  //from user_interface.h
	}
	void B4RESP8266extras::SetPower(Byte dBm)  {
		float dbm_float = dBm;
		WiFiGeneric.setOutputPower(dbm_float);
	}

	void B4RESP8266extras::PrintWifiDetails()  {
		WiFi.printDiag(::Serial);
	}

	void B4RESP8266extras::SetWifiMode(Byte new_wifi_mode) {
		WiFiMode wm = WIFI_OFF;
		switch (new_wifi_mode)  {
			case WIFI_MODE_AP:
				wm=WIFI_AP;
				break;
			case WIFI_MODE_STA:
				wm=WIFI_STA;
				break;
			case WIFI_MODE_AP_STA:
				wm=WIFI_AP_STA;
				break;
		}
		WiFi.mode(wm);
	}
	
	//added (in v1.05) these PWM functions as requested by B4R user "janderkan" on 5-Oct-18
	void B4RESP8266extras::AnalogWriteRange(uint32_t Range) {
		analogWriteRange(Range);
	}
	void B4RESP8266extras::AnalogWriteFreq(uint32_t Freq) {
		analogWriteFreq(Freq);
	}
	void B4RESP8266extras::SerialSwap() {
		::Serial.swap();
	}	
	//added (in v1.06) by Bryon Dunkley-Smith on 30-Jun-19
	void B4RESP8266extras::GetAPMacAddress(ArrayByte* mac) {
		mac->data = WiFi.BSSID();
	}

}
