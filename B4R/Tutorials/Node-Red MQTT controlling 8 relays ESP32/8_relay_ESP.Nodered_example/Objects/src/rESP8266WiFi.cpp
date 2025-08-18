#include "B4RDefines.h"
namespace B4R {
	Byte B4RESPWiFi::Scan() {
		return WiFi.scanNetworks(false, false);
	}
	B4RString* B4RESPWiFi::StringToB4R(String* o) {
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(*o);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}
	B4RString* B4RESPWiFi::ScannedSSID(Byte Index) {
		String s = WiFi.SSID(Index);
		return StringToB4R(&s);
	}
	ArrayByte* B4RESPWiFi::ScannedBSSID(Byte Index) {
		uint8_t* t = WiFi.BSSID(Index);
		ArrayByte* a = CreateStackMemoryObject(ArrayByte);
		a->length = 6;
		a->data = t;
		return a;
	}
	Long B4RESPWiFi::ScannedRSSI(Byte Index) {
		return (Long)WiFi.RSSI(Index);
	}
	bool B4RESPWiFi::Connect(B4RString* SSID) {
		return Connect2(SSID, NULL);
	}
	bool B4RESPWiFi::Connect2(B4RString* SSID, B4RString* Password) {
		return Connect3(SSID, Password, 0, NULL);
	}
	bool B4RESPWiFi::Connect3(B4RString* SSID, B4RString* Password, Long Channel, ArrayByte* bssid) {
		ULong start = millis();
		WiFi.begin(SSID->data, (Password != NULL && Password->getLength() > 0)? Password->data : NULL, Channel,
			bssid != NULL ? (uint8_t*)bssid->data : NULL, true);
		while (WiFi.status() != WL_CONNECTED && millis() - start < 15000){
			delay(500);
		}
		return WiFi.waitForConnectResult() == WL_CONNECTED;
	}
	void B4RESPWiFi::ConnectAsync(B4RString* SSID, B4RString* Password, Long Channel, ArrayByte* bssid, SubVoidBool ConnectedSub) {
		this->connected = ConnectedSub;
		FunctionUnion fu;
		fu.PollerFunction = checkForConnected;
		pnode.functionUnion = fu;
		pnode.tag = this;
		if (pnode.next == NULL) {
			pollers.add(&pnode);
		}
		WiFi.begin(SSID->data, (Password != NULL && Password->getLength() > 0)? Password->data : NULL, Channel,
			bssid != NULL ? (uint8_t*)bssid->data : NULL, true);
	}
	
	//static
	void B4RESPWiFi::checkForConnected(void* b) {
		B4RESPWiFi* me = (B4RESPWiFi*) b;
		delay(1);
		if (WiFi.status() != WL_IDLE_STATUS && WiFi.status() != WL_DISCONNECTED) {
			me->connected(WiFi.status() == WL_CONNECTED);
			pollers.remove(&me->pnode);
		}
	}
	
	bool B4RESPWiFi::StartAccessPoint(B4RString* SSID) {
		return StartAccessPoint2(SSID, NULL);
	}
	bool B4RESPWiFi::StartAccessPoint2(B4RString* SSID, B4RString* Password) {
		WiFi.disconnect();
		delay(100);
		return WiFi.softAP(SSID->data, Password != NULL ? Password->data : NULL);
	}
	B4RString* B4RESPWiFi::getLocalIp() {
		IPAddress ip = WiFi.localIP();
		return B4RString::PrintableToString(&ip);
	}
	B4RString* B4RESPWiFi::getAccessPointIp() {
		IPAddress ip = WiFi.softAPIP();
		return B4RString::PrintableToString(&ip);
	}
	bool B4RESPWiFi::getIsConnected() {
		return WiFi.isConnected();
	}
	void B4RESPWiFi::Disconnect() {
		WiFi.disconnect();
	}
	WiFiSocket::WiFiSocket()  {
		client.setClient(&wifiClient);
		stream.wrappedStream = stream.wrappedClient = &client;
	}
	bool WiFiSocket::ConnectIP(ArrayByte* IP, UInt Port) {
		IPAddress ip((Byte*)IP->data);
		return client.connect(ip, Port);
	}
	bool WiFiSocket::ConnectHost(B4RString* Host, UInt Port) {
		return client.connect(Host->data, Port);
	}
	B4RStream* WiFiSocket::getStream() {
		return &stream;
	}
	bool WiFiSocket::getConnected() {
		return client.connected();
	}
	void WiFiSocket::Close() {
		#if ESP32
		if (client.connected() == false)
			return;
		#endif
		client.stop();
	}
	B4RString* WiFiSocket::getRemoteIp() {
		IPAddress ip = ((WiFiClient*)client.wrappedClient)->remoteIP();
		return B4RString::PrintableToString(&ip);
	}
	UInt WiFiSocket::getRemotePort(){
		return ((WiFiClient*)client.wrappedClient)->remotePort();
	}
	
	WiFiSSLSocket::WiFiSSLSocket()  {
		client.setClient(&wifiClient);
		#ifndef ESP32
		wifiClient.setInsecure();
		#endif
		stream.wrappedStream = stream.wrappedClient = &client;
	}
	bool WiFiSSLSocket::VerifyCertificate(B4RString* FingerPrint, B4RString* Host) {
		return true;
	}
	bool WiFiSSLSocket::ConnectIP(ArrayByte* IP, UInt Port) {
		IPAddress ip((Byte*)IP->data);
		return client.connect(ip, Port);
	}
	bool WiFiSSLSocket::ConnectHost(B4RString* Host, UInt Port) {
		return client.connect(Host->data, Port);
	}
	B4RStream* WiFiSSLSocket::getStream() {
		return &stream;
	}
	bool WiFiSSLSocket::getConnected() {
		return client.connected();
	}
	void WiFiSSLSocket::Close() {
		client.stop();
	}
	
	void WiFiServerSocket::checkForClient(void* ess) {
		WiFiServerSocket* server = (WiFiServerSocket*)ess;
		server->wifiClient = server->server->available();
		if (server->wifiClient) {
			pollers.remove(&server->pnode);
			server->ethSocket.client.setClient(&server->wifiClient);
			server->newConnection(&server->ethSocket);
		}
		
	}
	void WiFiServerSocket::Initialize(UInt Port, SubVoidWiFiSocket NewConnectionSub) {
		server = new (backend) WiFiServer(Port);
		this->newConnection = NewConnectionSub;
		FunctionUnion fu;
		fu.PollerFunction = checkForClient;
		pnode.functionUnion = fu;
		pnode.tag = this;
		pnode.next = NULL;

		server->begin();
	}
	
	void WiFiServerSocket::Listen() {
		if (pnode.next == NULL)
			pollers.add(&pnode);
	}
	WiFiSocket* WiFiServerSocket::getSocket() {
		return &ethSocket;
	}
	//static
	void B4RWiFiUDP::checkForData(void* b) {
		B4RWiFiUDP* me = (B4RWiFiUDP*) b;
		int size = me->udp.parsePacket();
		if (size == 0)
			return;
		const UInt cp = B4R::StackMemory::cp;
		ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
		arr->data = StackMemory::buffer + StackMemory::cp;
		arr->length = me->udp.read((Byte*)arr->data, size);
		B4R::StackMemory::cp += size;
		ArrayByte* ip = CreateStackMemoryObject(ArrayByte);
		ip->data = StackMemory::buffer + StackMemory::cp;
		ip->length = 4;
		B4R::StackMemory::cp += 4;
		IPAddress ipa = me->udp.remoteIP();
		for (byte i = 0;i < 4;i++) {
			((Byte*)ip->data)[i] = ipa[i];
		}
		me->PacketArrivedSub(arr, ip, me->udp.remotePort());
		B4R::StackMemory::cp = cp;
	}
	bool B4RWiFiUDP::Initialize(UInt Port, SubPacketArrived PacketArrivedSub) {
		if (udp.begin(Port) == 0)
			return false;
		if (PacketArrivedSub != NULL) {
			this->PacketArrivedSub = PacketArrivedSub;
			FunctionUnion fu;
			fu.PollerFunction = checkForData;
			pnode.functionUnion = fu;
			pnode.tag = this;
			if (pnode.next == NULL) {
				pollers.add(&pnode);
			}
		}
		return true;
	}
	bool B4RWiFiUDP::BeginPacket(ArrayByte* IP, UInt Port) {
		IPAddress ip((Byte*)IP->data);
		return udp.beginPacket(ip, Port);
	}
	Int B4RWiFiUDP::Write(ArrayByte* Data) {
		return udp.write((Byte*)Data->data, Data->length);
	}
	bool B4RWiFiUDP::SendPacket() {
		return udp.endPacket();
	}
	void B4RWiFiUDP::Close() {
		return udp.stop();
	}
	
}