#include "B4RDefines.h"
namespace B4R {
	int BufferedWiFiClient::connect(IPAddress ip, uint16_t port) {
		return wrappedClient->connect(ip, port);
	}
	int BufferedWiFiClient::connect(const char *host, uint16_t port) {
		return wrappedClient->connect(host, port);
	}
	
	size_t BufferedWiFiClient::write(uint8_t t) {
		return write(&t, 1);
	}
	size_t BufferedWiFiClient::write(const uint8_t *buf, size_t size) {
		size_t total = 0;
		if (size + index > MaxSize) {
			flush();
			total += index;
		}
		if (size > MaxSize) {
			return total + wrappedClient->write(buf, size);
		}
		else {
			memcpy(buffer + index, buf, size);
			index += size;
			return total + size;
		}
	}
	int BufferedWiFiClient::available() {
		flush();
		return wrappedClient->available();
	}
	int BufferedWiFiClient::read() {
		return wrappedClient->read();
	}
	int BufferedWiFiClient::read(uint8_t *buf, size_t size) {
		return wrappedClient->read(buf, size);
	}
	int BufferedWiFiClient::peek() {
		return wrappedClient->peek();
	}
	void BufferedWiFiClient::flush(){
		if (index > 0)
			wrappedClient->write(buffer, index);
		index = 0;
	}
	
	void BufferedWiFiClient::stop() {
		flush();
		wrappedClient->stop();
	}
	uint8_t BufferedWiFiClient::connected() {
		return wrappedClient->connected();
	}
	BufferedWiFiClient::operator bool() {
		return wrappedClient == 0;
	}
	void BufferedWiFiClient::setClient(Client* client) {
		wrappedClient = client;
		index = 0;
	}
}