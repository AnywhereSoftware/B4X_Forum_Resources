#include "rArduinoBLE.h"
#include "string.h" 

namespace B4R {
    
    static BLEUnsignedCharCharacteristic* globalBatChar = NULL;

    void B4RBLEDescriptor::Initialize(void* UUID, void* Data) {
        nativeDesc = new BLEDescriptor(((B4RString*)UUID)->data, ((B4RString*)Data)->data);
    }

    bool B4RBLEMaster::Begin() {
        bool res = BLE.begin();
        if (res) {
            if (LocalName != NULL && LocalName->data != NULL) BLE.setLocalName(LocalName->data);
            if (DeviceName != NULL && DeviceName->data != NULL) BLE.setDeviceName(DeviceName->data);
            if (Appearance != 0) BLE.setAppearance((uint16_t)Appearance);
        }
        return res;
    }

    void B4RBLEMaster::SetAppearance(int Value) {
        Appearance = Value;
        BLE.setAppearance((uint16_t)Value);
    }
    
    void B4RBLEMaster::AddService(B4RLocalService* Service) {
        BLE.addService(*(Service->nativeService));
    }
    
    void B4RBLEMaster::SetAdvertisedService(B4RLocalService* Service) {
        BLE.setAdvertisedService(*(Service->nativeService));
    }
    
    void B4RBLEMaster::Advertise() {
        if (LocalName != NULL && LocalName->data != NULL) BLE.setLocalName(LocalName->data);
        if (DeviceName != NULL && DeviceName->data != NULL) BLE.setDeviceName(DeviceName->data);
        if (Appearance != 0) BLE.setAppearance((uint16_t)Appearance);
        BLE.advertise();
    }
    
    void B4RBLEMaster::Poll() { BLE.poll(); }
    void B4RBLEMaster::Scan() { BLE.scan(); }
    void B4RBLEMaster::StopScan() { BLE.stopScan(); }

    B4RBLEDevice* B4RBLEMaster::Available() {
        BLEDevice dev = BLE.available();
        if (dev) {
            static B4RBLEDevice b4r_dev;
            b4r_dev.nativeDevice = dev;
            return &b4r_dev;
        }
        return NULL;
    }

    void B4RBLEMaster::AddBatteryService(int InitialLevel) {
        static BLEService batteryService("180F"); 
        if (globalBatChar == NULL) {
            globalBatChar = new BLEUnsignedCharCharacteristic("2A19", BLERead | BLENotify);
        }
        batteryService.addCharacteristic(*globalBatChar);
        BLE.addService(batteryService);
        globalBatChar->writeValue((unsigned char)InitialLevel);
    }

    void B4RBLEMaster::SetBatteryLevel(int Level) {
        if (globalBatChar != NULL) globalBatChar->writeValue((unsigned char)Level);
    }

    void B4RBLEMaster::SetManufacturerData(B4R::Array* Data) {
        ArrayByte* arr = (ArrayByte*)Data;
        if (arr != NULL && arr->data != NULL && arr->length > 0) {
            BLE.setManufacturerData((const uint8_t*)arr->data, arr->length);
        }
    }

    void B4RBLEMaster::AddDeviceInformationService(void* ManufacturerName, void* ModelNumber, void* SerialNumber) {
        static BLEService disService("180A");
        static BLEStringCharacteristic manChar("2A29", BLERead, 32);
        static BLEStringCharacteristic modChar("2A24", BLERead, 32);
        static BLEStringCharacteristic serChar("2A25", BLERead, 32);
        disService.addCharacteristic(manChar);
        disService.addCharacteristic(modChar);
        disService.addCharacteristic(serChar);
        BLE.addService(disService);
        manChar.writeValue(((B4RString*)ManufacturerName)->data);
        modChar.writeValue(((B4RString*)ModelNumber)->data);
        serChar.writeValue(((B4RString*)SerialNumber)->data);
    }

    B4R::B4RString* B4RBLEDevice::LocalName() {
        static char nameBuffer[32]; 
        static B4RString bs;
        String s = nativeDevice.localName();
        s.toCharArray(nameBuffer, 32);
        bs.data = nameBuffer;
        return &bs;
    }

    B4R::B4RString* B4RBLEDevice::Address() {
        static char addrBuffer[20];
        static B4RString bs;
        String s = nativeDevice.address();
        s.toCharArray(addrBuffer, 20);
        bs.data = addrBuffer;
        return &bs;
    }

    int B4RBLEDevice::RSSI() { return nativeDevice.rssi(); }
    bool B4RBLEDevice::Connect() { return nativeDevice.connect(); }
    void B4RBLEDevice::Disconnect() { nativeDevice.disconnect(); }
    bool B4RBLEDevice::Connected() { return nativeDevice.connected(); }
    bool B4RBLEDevice::DiscoverAttributes() { return nativeDevice.discoverAttributes(); }

    void B4RBLEDevice::WriteCharacteristic(void* ServiceUUID, void* CharUUID, void* Data) {
        BLECharacteristic characteristic = nativeDevice.characteristic(((B4RString*)CharUUID)->data);
        if (characteristic) {
            ArrayByte* arr = (ArrayByte*)Data;
            if (arr != NULL && arr->data != NULL && arr->length > 0) {
                characteristic.writeValue((const uint8_t*)arr->data, (size_t)arr->length);
            }
        }
    }

    B4R::Array* B4RBLEDevice::ReadCharacteristic(void* ServiceUUID, void* CharUUID) {
        BLECharacteristic characteristic = nativeDevice.characteristic(((B4RString*)CharUUID)->data);
        if (characteristic && characteristic.canRead()) {
            characteristic.read();
            static ArrayByte readAb;
            readAb.data = (uint8_t*)characteristic.value();
            readAb.length = characteristic.valueLength();
            return (B4R::Array*)&readAb;
        }
        return NULL;
    }

    B4R::Array* B4RBLEDevice::ReadDescriptor(void* ServiceUUID, void* CharUUID, void* DescriptorUUID) {
        BLECharacteristic characteristic = nativeDevice.characteristic(((B4RString*)CharUUID)->data);
        if (characteristic) {
            BLEDescriptor descriptor = characteristic.descriptor(((B4RString*)DescriptorUUID)->data);
            if (descriptor) {
                descriptor.read();
                static ArrayByte readAb;
                readAb.data = (uint8_t*)descriptor.value();
                readAb.length = descriptor.valueLength();
                return (B4R::Array*)&readAb;
            }
        }
        return NULL;
    }

    bool B4RBLEDevice::CanSubscribe(void* ServiceUUID, void* CharUUID) {
        BLECharacteristic characteristic = nativeDevice.characteristic(((B4RString*)CharUUID)->data);
        return characteristic ? characteristic.canSubscribe() : false;
    }

    bool B4RBLEDevice::Subscribe(void* ServiceUUID, void* CharUUID) {
        BLECharacteristic characteristic = nativeDevice.characteristic(((B4RString*)CharUUID)->data);
        return (characteristic && characteristic.canSubscribe()) ? characteristic.subscribe() : false;
    }    

    bool B4RBLEDevice::Unsubscribe(void* ServiceUUID, void* CharUUID) {
        BLECharacteristic characteristic = nativeDevice.characteristic(((B4RString*)CharUUID)->data);
        return (characteristic && characteristic.canSubscribe()) ? characteristic.unsubscribe() : false;
    }

    B4R::Array* B4RBLEDevice::ManufacturerData() {
        static uint8_t mBuffer[31]; 
        static ArrayByte mAb;
        int len = nativeDevice.manufacturerData(mBuffer, 31);
        if (len < 0) len = 0;
        mAb.data = mBuffer; mAb.length = (uint16_t)len;
        return (B4R::Array*)&mAb;
    }

    void B4RLocalService::Initialize(void* UUID) {
        nativeService = new BLEService(((B4RString*)UUID)->data);
    }
    
    void B4RLocalService::AddCharacteristic(B4RLocalCharacteristic* Characteristic) {
        nativeService->addCharacteristic(*(Characteristic->nativeChar));
    }

    void B4RLocalCharacteristic::Initialize(void* UUID, unsigned char Properties, int Size) {
        uint8_t flags = 0;
        const char* uuidStr = ((B4RString*)UUID)->data;
        
        // Save the UUID string locally
        strncpy(_uuid, uuidStr, 36);
        _uuid[36] = '\0';

        if (Properties & 0x01) flags |= BLERead;
        if (Properties & 0x02) flags |= BLEWrite;
        if (Properties & 0x04) flags |= BLEWriteWithoutResponse;
        if (Properties & 0x08) flags |= BLENotify;
        if (Properties & 0x10) flags |= BLEIndicate;
        nativeChar = new BLECharacteristic(uuidStr, flags, Size);
    }

    void B4RLocalCharacteristic::SetValue(void* Data) {
        ArrayByte* arr = (ArrayByte*)Data;
        if (arr != NULL && arr->data != NULL && arr->length > 0) {
            nativeChar->writeValue((const uint8_t*)arr->data, (size_t)arr->length);
        }
    }

    bool B4RLocalCharacteristic::Written() { return nativeChar->written(); }
    bool B4RLocalCharacteristic::Subscribed() { return nativeChar->subscribed(); }

    B4R::Array* B4RLocalCharacteristic::GetValue() {
        int len = nativeChar->valueLength();
        if (len < 0) len = 0;
        if (len > (int)sizeof(buffer)) len = sizeof(buffer);
        const uint8_t* val = nativeChar->value();
        if (val != NULL && len > 0) memcpy(buffer, val, len); else len = 0;
        static ArrayByte internalAb; 
        internalAb.data = buffer; internalAb.length = (uint16_t)len;
        return (B4R::Array*)&internalAb;
    }

    void B4RLocalCharacteristic::AddDescriptor(B4RBLEDescriptor* Descriptor) {
        nativeChar->addDescriptor(*(Descriptor->nativeDesc));
    }

    B4R::B4RString* B4RLocalCharacteristic::UUID() {
        static B4RString bs;
        bs.data = _uuid;
        return &bs;
    }

    B4R::B4RString* B4RBLEMaster::StringFromBytes(B4R::Array* Data) {
        static char strBuffer[512];
        static B4RString bs;
        ArrayByte* arr = (ArrayByte*)Data;
        if (arr == NULL || arr->data == NULL || arr->length == 0) { bs.data = (char*)""; return &bs; }
        uint16_t len = arr->length;
        if (len >= sizeof(strBuffer)) len = sizeof(strBuffer) - 1;
        memcpy(strBuffer, arr->data, len);
        strBuffer[len] = '\0';
        bs.data = strBuffer;
        return &bs;
    }

    B4R::B4RString* B4RBLEMaster::HexFromBytes(B4R::Array* Data) {
        static char hexBuffer[256];
        static B4RString bs;
        ArrayByte* arr = (ArrayByte*)Data;
        if (arr == NULL || arr->data == NULL || arr->length == 0) { bs.data = (char*)""; return &bs; }
        const char* hexChars = "0123456789ABCDEF";
        uint16_t len = arr->length;
        if (len * 2 >= sizeof(hexBuffer)) len = (sizeof(hexBuffer) - 1) / 2;
        for (uint16_t i = 0; i < len; i++) {
            unsigned char b = ((unsigned char*)arr->data)[i];
            hexBuffer[i * 2] = hexChars[b >> 4];
            hexBuffer[i * 2 + 1] = hexChars[b & 0x0F];
        }
        hexBuffer[len * 2] = '\0';
        bs.data = hexBuffer;
        return &bs;
    }

    B4R::B4RString* B4RBLEMaster::SubStringText(B4R::Array* Data, int Start, int Length) {
        static char strBuf[64]; static B4RString bs;
        ArrayByte* arr = (ArrayByte*)Data;
        if (arr == NULL || Start < 0 || (uint16_t)(Start + Length) > arr->length) { bs.data = (char*)""; return &bs; }
        if (Length >= sizeof(strBuf)) Length = sizeof(strBuf) - 1;
        memcpy(strBuf, (unsigned char*)arr->data + Start, Length);
        strBuf[Length] = '\0'; bs.data = strBuf; return &bs;
    }

    B4R::B4RString* B4RBLEMaster::SubStringHex(B4R::Array* Data, int Start, int Length) {
        static char hexBuf[128]; static B4RString bs;
        ArrayByte* arr = (ArrayByte*)Data;
        const char* hexChars = "0123456789ABCDEF";
        if (arr == NULL || Start < 0 || (uint16_t)(Start + Length) > arr->length) { bs.data = (char*)""; return &bs; }
        if (Length * 2 >= sizeof(hexBuf)) Length = (sizeof(hexBuf) - 1) / 2;
        for (int i = 0; i < Length; i++) {
            unsigned char b = ((unsigned char*)arr->data)[Start + i];
            hexBuf[i * 2] = hexChars[b >> 4]; hexBuf[i * 2 + 1] = hexChars[b & 0x0F];
        }
        hexBuf[Length * 2] = '\0'; bs.data = hexBuf; return &bs;
    }
}
