#include "B4RDefines.h"

namespace B4R {
	void B4RESP32extras::Restart() {
		ESP.restart();
	}
	ulong B4RESP32extras::FlashChipSpeed() {
		  return ESP.getFlashChipSpeed();
	}
	ulong B4RESP32extras::CpuCycleCount() {
		  return ESP.getCycleCount();
	}
	ulong B4RESP32extras::FreeHeapSpace() {
		  return ESP.getFreeHeap();
	}
	byte B4RESP32extras::CpuFreqMHz() {
		  return ESP.getCpuFreqMHz();
	}
	void B4RESP32extras::GetMacAddress(ArrayByte* mac) {
		WiFi.macAddress((byte*)mac->data);
	}
	void B4RESP32extras::ConfigNetwork(ArrayByte* ip,ArrayByte* gateway,ArrayByte* subnet,ArrayByte* dns1,ArrayByte* dns2)  {
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
	bool B4RESP32extras::ConfigAP(B4RString* ip, B4RString* gateway, B4RString* subnet)  {
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
	void B4RESP32extras::GetAPIP(ArrayByte* ip)  {
		IPAddress ipa = WiFi.softAPIP();
		for (byte i = 0;i < 4;i++) {
			((Byte*)ip->data)[i] = ipa[i];
		}
	}
	B4RString* B4RESP32extras::IP2str(ArrayByte* ip) {
		IPAddress ipa;
		for (byte i = 0;i < 4;i++) {
			ipa[i] = ((Byte*)ip->data)[i];
		}
		return B4RString::PrintableToString(&ipa);
	}
	ArrayByte* B4RESP32extras::str2IP(B4RString* sip)  {
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
	bool B4RESP32extras::Host2IP(B4RString* Host, ArrayByte* ip)  {
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
	bool B4RESP32extras::IsBadIP(ArrayByte* ip)  {
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
	IPAddress B4RESP32extras::b4str2IPaddress(B4RString* b4sip)  {
		int L = b4sip->getLength();
		byte* sip = (byte*)b4sip->data;
		return str2IPaddress(sip,L);
	}
		//private function
	// convert string holding "192.168.10.20" into 
	// IPAddress .. 4 byte array (0=192,1=168,2=10,3=20)
	IPAddress B4RESP32extras::str2IPaddress(byte* sip, int L)  {
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
	
	int B4RESP32extras::GetInternetIP(ArrayByte* ip)  {
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
		            "User-Agent: esp32 \r\n" + 
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

	B4RString* B4RESP32extras::SSID() {
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(WiFi.SSID());
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}
	
	void B4RESP32extras::GetLocalIP(ArrayByte* ip)  {
		IPAddress ipa = WiFi.localIP(); 
		for (byte i = 0;i < 4;i++) {
			((Byte*)ip->data)[i] = ipa[i];
		}
	}

	void B4RESP32extras::GetSubnetMask(ArrayByte* ip)  {
		IPAddress ipa = WiFi.subnetMask(); 
		for (byte i = 0;i < 4;i++) {
			((Byte*)ip->data)[i] = ipa[i];
		}
	}

	void B4RESP32extras::GetGatewayIP(ArrayByte* ip)  {
		IPAddress ipa = WiFi.gatewayIP(); 
		for (byte i = 0;i < 4;i++) {
			((Byte*)ip->data)[i] = ipa[i];
		}
	}

}
