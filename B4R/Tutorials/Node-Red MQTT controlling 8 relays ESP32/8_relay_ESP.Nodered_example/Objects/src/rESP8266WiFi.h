#pragma once
#include "B4RDefines.h"
#ifdef ESP32
#include <WiFi.h>
#include <WiFiClientSecure.h>
#else
#include <ESP8266WiFi.h>
#endif
#include <WiFiUdp.h>

//~version: 1.58
namespace B4R {
	//~shortname: ESP8266WiFi
	//~Event: Connected (Success As Boolean)
	class B4RESPWiFi {
		private:
			PollerNode pnode;
			SubVoidBool connected;
			static void checkForConnected(void* wss);
		public:
			//~hide
			static B4RString* StringToB4R(String* s);
			//Scans for wireless networks. Returns the number of networks found. 
			Byte Scan(); 
			//Returns the SSID of the network. Make sure to call Scan before calling this method.
			//Index - The index of the network in the internal list.
			B4RString* ScannedSSID(Byte Index);
			//Returns the BSSID (MAC address) of the network. Make sure to call Scan before calling this method.
			//Index - The index of the network in the internal list
			ArrayByte* ScannedBSSID(Byte Index);
			//Returns the RSSI of the network. Make sure to call Scan before calling this method.
			//Index - The index of the network in the internal list.
			Long ScannedRSSI(Byte Index);
			
			//Tries to connect to the open network. Return True if successful.
			bool Connect(B4RString* SSID);
			//Tries to connect to the secured network. Returns True if successful.
			bool Connect2(B4RString* SSID, B4RString* Password);
			//Tries to connect to the network. Returns True if successful.
			//SSID - Network ssid.
			//Password - Network password. Pass an empty string if not needed.
			//Channel - Network ap channel. Pass 0 if not needed.
			//BSSID - Network bssid (Mac address). Pass Null if not needed.
			bool Connect3(B4RString* SSID, B4RString* Password, Long Channel, ArrayByte* BSSID);
			//Tries to connect to the network. Raises the Connected event.
			//SSID - Network ssid.
			//Password - Network password. Pass an empty string if not needed.
			//Channel - Network ap channel. Pass 0 if not needed.
			//BSSID - Network bssid (Mac address). Pass Null if not needed.
			void ConnectAsync(B4RString* SSID, B4RString* Password, Long Channel, ArrayByte* BSSID, SubVoidBool ConnectedSub);
			//Returns the local ip address as a string.
			B4RString* getLocalIp();
			//Returns the board ip when the board acts as an access point.
			B4RString* getAccessPointIp();
			//Starts the soft access point.
			//SSID - The network name.
			bool StartAccessPoint(B4RString* SSID);
			//Starts the soft access point.
			//SSID - The network name.
			//Password - Network password.
			bool StartAccessPoint2(B4RString* SSID, B4RString* Password);
			//Returns true if WiFi is connected.
			bool getIsConnected();
			void Disconnect();
	};
	//~hide
	class BufferedWiFiClient : public Client {
		private:
			const static UInt MaxSize = 200;
			Byte buffer[MaxSize];
			UInt index = 0;
		public:
			Client* wrappedClient;
			virtual size_t write(uint8_t);
			virtual size_t write(const uint8_t *buf, size_t size);
			virtual int available();
			virtual int read();
			virtual int read(uint8_t *buf, size_t size);
			virtual int peek();
			
			virtual uint8_t connected();
			virtual operator bool();
			void setClient(Client* client);
			virtual void flush();
			virtual void stop();
			virtual int connect(const char *host, uint16_t port) ;
			virtual int connect(IPAddress ip, uint16_t port);
	};
	//~shortname: WiFiSocket
	//A client socket implementation. Usage is identical to the usage of EthernetSocket.
	class WiFiSocket {
		private:
			B4RStream stream;
			
		public:
			//~hide
			WiFiSocket();
			//~hide
			WiFiClient wifiClient;
			//~hide
			BufferedWiFiClient client;
			/**
			*Tries to connect to the server. Returns true if connection was successful.
			*IP - Server ip address as an array of bytes.
			*Port - Server port.
			*/
			bool ConnectIP(ArrayByte* IP, UInt Port);
			/**
			*Tries to connect to the server. Returns true if connection was successful.
			*Host - Host name.
			*Port - Server port.
			*/
			bool ConnectHost(B4RString* Host, UInt Port);
			//Gets the network stream. Can be used together with AsyncStreams.
			B4RStream* getStream();
			//Tests whether the client is connected.
			bool getConnected();
			//Closes the connection.
			void Close();
			//Returns the remote client ip address as a string.
			//Useful in server solutions.
			B4RString* getRemoteIp();
			//Returns the remote client port.
			UInt getRemotePort();
	};
	//~shortname: WiFiSSLSocket
	//A client SSL socket implementation. Similar to WiFiSocket. Can only make SSL connections.
	//Note that the server certificate is not verified unless you explicitly verify it with the VerifyCertificate method.
	class WiFiSSLSocket {
		private:
			B4RStream stream;
			
		public:
		
			//~hide
			WiFiSSLSocket();
			//~hide
			WiFiClientSecure wifiClient;
			
		
			//~hide
			BufferedWiFiClient client;
			/**
			*Tries to connect to the server. Returns true if connection was successful.
			*IP - Server ip address as an array of bytes.
			*Port - Server port.
			*/
			bool ConnectIP(ArrayByte* IP, UInt Port);
			/**
			*Doesn't do anything.
			*/
			bool VerifyCertificate(B4RString* FingerPrint, B4RString* Host);
			/**
			*Tries to connect to the server. Returns true if connection was successful.
			*Host - Host name.
			*Port - Server port.
			*/
			bool ConnectHost(B4RString* Host, UInt Port);
			//Gets the network stream. Can be used together with AsyncStreams.
			B4RStream* getStream();
			//Tests whether the client is connected.
			bool getConnected();
			//Closes the connection.
			void Close();
	};
	typedef void (*SubVoidWiFiSocket)(WiFiSocket*);
	//~shortname: WiFiServerSocket
	//~Event: NewConnection (NewSocket As WiFiSocket)
	//A server socket implementation. Usage is identical to the usage of EthernetServerSocket.
	class WiFiServerSocket {
		private:
			Byte backend[sizeof(WiFiServer)];
			PollerNode pnode;
			WiFiSocket ethSocket;
			SubVoidWiFiSocket newConnection;
			static void checkForClient(void* wss);
			WiFiClient wifiClient;
		public:
			//~hide
			WiFiServer* server;
			//Initializes the server.
			//Port - The server port.
			//NewConnectionSub - The sub that will handle the NewConnection event.
			void Initialize(UInt Port, SubVoidWiFiSocket NewConnectionSub);
			//Starts listening for connections.
			//The NewConnection event will be raised when a client connects.
			//You should call Listen again after the connection has broken. AsyncStreams_Error is a good place for this call.
			void Listen();
			//Returns the last connected socket.
			WiFiSocket* getSocket();
			
	};
	typedef void (*SubPacketArrived)(ArrayByte*, ArrayByte*, UInt);
	//~shortname: WiFiUDP
	//~Event: PacketArrived (Data() As Byte, IP() As Byte, Port As UInt)
	//Allows receiving and sending UDP packets. Usage is identical to the usage of EthernetUDP.
	class B4RWiFiUDP {
		private:
			WiFiUDP udp;
			static void checkForData(void* b);
			SubPacketArrived PacketArrivedSub;
			PollerNode pnode;
		public:
			/**
			*Initializes the object. Returns True if successful.
			*Port - The UDP socket will be bound to this port.
			*PacketArrivedSub - The sub that handles the PacketArrived event.
			*/
			bool Initialize(UInt Port, SubPacketArrived PacketArrivedSub);
			/**
			*Starts sending a packet. The packet will be sent when SendPacket is called.
			*IP - Target ip address.
			*Port - Target port address.
			*/
			bool BeginPacket(ArrayByte* IP, UInt Port);
			//Writes data to the packet. Returns the number of bytes that were written successfully.
			//This method should only be called between a call to BeginPacket and SendPacket.
			//You can call Write multiple times.
			Int Write(ArrayByte* Data);
			//Sends the packet.
			bool SendPacket();
			//Closes the socket.
			void Close();
	};
	
}