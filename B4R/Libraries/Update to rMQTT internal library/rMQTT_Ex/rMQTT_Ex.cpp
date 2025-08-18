#include "B4RDefines.h"
namespace B4R {
	MqttClient* MqttClient::instance = NULL;
	void MqttClient::Initialize2(B4RStream* Stream, B4RString* HostName, UInt Port, B4RString* ClientId, SubVoidStringByteArray MessageArrivedSub, SubVoidVoid DisconnectedSub) {
		psClient.setServer(HostName->data, Port);
		sharedInit(Stream, ClientId,MessageArrivedSub, DisconnectedSub);
	}
	void MqttClient::Initialize(B4RStream* Stream, ArrayByte* Ip, UInt Port, B4RString* ClientId,
			SubVoidStringByteArray MessageArrivedSub, SubVoidVoid DisconnectedSub) {
		
		IPAddress ip((Byte*)Ip->data);
		psClient.setServer(ip, Port);
		sharedInit(Stream, ClientId,MessageArrivedSub, DisconnectedSub);
	}
	void MqttClient::sharedInit(B4RStream* Stream, B4RString* ClientId, SubVoidStringByteArray MessageArrivedSub, SubVoidVoid DisconnectedSub) {
		psClient.setClient(*Stream->wrappedClient);
		psClient.setCallback(callback);
		this->MessageArrivedSub = MessageArrivedSub;
		this->DisconnectedSub = DisconnectedSub;
		FunctionUnion fu;
		fu.PollerFunction = looper;
		pnode.functionUnion = fu;
		pnode.tag = this;
		this->clientId = ClientId->data;
		instance = this;
	}
	bool MqttClient::Connect() {
		return Connect2(NULL);
	}
	bool MqttClient::Connect2(MqttConnectOptions* Options) {
		bool r;
		if (Options == NULL)
			r = psClient.connect(clientId);
		else {
			const char* user = Options->UserName->getLength() == 0 ? NULL : Options->UserName->data;
			const char* password = Options->Password->getLength() == 0 ? NULL : Options->Password->data;
			if (Options->willTopic != NULL) {
				r = psClient.connect(clientId, user, password, Options->willTopic->data, Options->willQOS,
					Options->willRetain, Options->willPayload->data);
			} else {
				r = psClient.connect(clientId, user, password);
			}
		}
		if (r) {
			if (pnode.next == NULL)
				pollers.add(&pnode);
		}
		return r;
	}
	void MqttClient::callback(char* topic, uint8_t* payload, unsigned int length) {
		const UInt cp = B4R::StackMemory::cp;
		B4RString* strTopic = CreateStackMemoryObject(B4RString);
		strTopic->data = topic;
		ArrayByte* arrPayload = CreateStackMemoryObject(ArrayByte);
		arrPayload->data = payload;
		arrPayload->length = length;
		instance->MessageArrivedSub(strTopic, arrPayload);
		B4R::StackMemory::cp = cp;
	}
	void MqttClient::looper(void* b) {
		MqttClient* me = (MqttClient*)b;
		if (me->psClient.connected() == false) {
			pollers.remove(&me->pnode);
			me->DisconnectedSub();
		} else {
			me->psClient.loop();
		}
	}
	bool MqttClient::Subscribe(B4RString* Topic, Byte QOS) {
		return psClient.subscribe(Topic->data, QOS);
	}
	bool MqttClient::Unsubscribe(B4RString* Topic) {
		return psClient.unsubscribe(Topic->data);
	}
	bool MqttClient::Publish(B4RString* Topic, ArrayByte* Payload) {
		return psClient.publish(Topic->data, (Byte*)Payload->data, Payload->length);
	}
	bool MqttClient::Publish2(B4RString* Topic, ArrayByte* Payload, bool Retained) {
		return psClient.publish(Topic->data, (Byte*)Payload->data, Payload->length, Retained);
	}
	bool MqttClient::BeginPublish(B4RString* Topic, UInt TotalLength, bool Retained) {
		return psClient.beginPublish(Topic->data, TotalLength, Retained);
	}
	bool MqttClient::WriteChunk(ArrayByte* Payload) {
		return psClient.write((Byte*)Payload->data, Payload->length);
	}
	bool MqttClient::EndPublish() {
		return psClient.endPublish();
	}
	void MqttClient::Close() {
		psClient.disconnect();
		if (pnode.next != NULL)
			pollers.remove(&pnode);
	}
	void MqttConnectOptions::Initialize(B4RString* UserName, B4RString* Password) {
		this->UserName = UserName;
		this->Password = Password;
	}
	void MqttConnectOptions::SetLastWill(B4RString* Topic, B4RString* Message, Byte QOS, bool Retained) {
		this->willTopic = Topic;
		this->willPayload = Message;
		this->willQOS = QOS;
		this->willRetain = Retained;
	}
	
	bool MqttClient::IsConnected() {
		return psClient.connected();
	}
	bool MqttClient::SetBufferSize(UInt size) {
		return psClient.setBufferSize(size);
	}
	void MqttClient::SetKeepAlive(UInt keepAlive){
		psClient.setKeepAlive(keepAlive);
	}
	void MqttClient::SetSocketTimeout(UInt timeout){
		psClient.setSocketTimeout(timeout);
	}

}

















