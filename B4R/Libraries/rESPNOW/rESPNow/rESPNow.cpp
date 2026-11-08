
#include "B4RDefines.h"

namespace B4R {

	B4RESPNow* B4RESPNow::instance = nullptr;

	// ---------------------------------------------------------
	bool B4RESPNow::Initialize(SubVoidByteArrByteArr DataReceivedSub,
							   SubVoidByteArrByte DataSentSub) {

		instance = this;

		this->DataReceivedSub = DataReceivedSub;
		this->DataSentSub = DataSentSub;

		currentChannel = 1;

		WiFi.mode(WIFI_STA);

		if (esp_now_init() != ESP_OK) {
			return false;
		}

		// Once ESPNow is successfully Init
		// Register for recv CB to get recv packer info
		esp_now_register_recv_cb(esp_now_recv_cb_t(OnDataRecv));
		
		// Register for Send CB to get the status of Trasnmitted packet
		esp_now_register_send_cb(esp_now_send_cb_t(OnDataSent));

		return true;
	}

	// ---------------------------------------------------------
	void B4RESPNow::SetChannel(Byte channel) {
		currentChannel = channel;
		esp_wifi_set_channel(channel, WIFI_SECOND_CHAN_NONE);
	}

	// ---------------------------------------------------------
	ArrayByte* B4RESPNow::GetMAC(void) {

		static uint8_t mac[6];

		esp_wifi_get_mac(WIFI_IF_STA, mac);

		static ArrayByte macArr;
		macArr.data = mac;
		macArr.length = 6;

		return &macArr;
	}

	// ---------------------------------------------------------
	bool B4RESPNow::AddPeer(ArrayByte* mac) {

		esp_now_peer_info_t peerInfo = {};
		memcpy(peerInfo.peer_addr, mac->data, 6);
		peerInfo.channel = currentChannel;
		peerInfo.encrypt = false;

		return esp_now_add_peer(&peerInfo) == ESP_OK;
	}

	// ---------------------------------------------------------
	bool B4RESPNow::RemovePeer(ArrayByte* mac) {
		return esp_now_del_peer((const uint8_t*)mac->data) == ESP_OK;
	}

	// ---------------------------------------------------------
	bool B4RESPNow::SendData(ArrayByte* mac, ArrayByte* data) {
		return esp_now_send(
			(const uint8_t*)mac->data,
			(const uint8_t*)data->data,
			data->length
			) == ESP_OK;
	}

	// ---------------------------------------------------------
	void B4RESPNow::OnDataRecv(const uint8_t *mac, const uint8_t *incomingData, int len) {

		if (instance == nullptr || instance->DataReceivedSub == nullptr) return;

		ArrayByte macArr;
		macArr.data = (Byte*)mac;
		macArr.length = 6;

		ArrayByte dataArr;
		dataArr.data = (Byte*)incomingData;
		dataArr.length = len;

		const UInt cp = B4R::StackMemory::cp;
		instance->DataReceivedSub(&macArr, &dataArr);
		B4R::StackMemory::cp = cp;
	}

	// ---------------------------------------------------------
	void B4RESPNow::OnDataSent(const uint8_t *mac, esp_now_send_status_t status) {

		if (instance == nullptr || instance->DataSentSub == nullptr) return;

		ArrayByte macArr;
		macArr.data = (Byte*)mac;
		macArr.length = 6;

		Byte result = (status == ESP_NOW_SEND_SUCCESS) ? 1 : 0;

		const UInt cp = B4R::StackMemory::cp;
		instance->DataSentSub(&macArr, result);
		B4R::StackMemory::cp = cp;
	}

}