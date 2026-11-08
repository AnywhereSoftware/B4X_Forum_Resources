#ifndef rArduinoBLE_h
#define rArduinoBLE_h

#include "ArduinoBLE.h" 

namespace B4R {
    class B4RLocalCharacteristic;
    class B4RLocalService;
    class B4RBLEDevice;
    class B4RBLEMaster;
    
    struct Array;
    struct B4RString; 

    class B4RBLEDescriptor {
        public:
            BLEDescriptor* nativeDesc;
            void Initialize(void* UUID, void* Data);
    };

    class B4RLocalCharacteristic {
        private:
            uint8_t buffer[512]; 
            char _uuid[37]; // Store the UUID string (36 chars + null)
            B4R::Array* ab;        
        public:
            BLECharacteristic* nativeChar;
            void Initialize(void* UUID, unsigned char Properties, int Size);
            void SetValue(void* Data);
            bool Written();
            bool Subscribed(); 
            B4R::Array* GetValue(); 
            void AddDescriptor(B4RBLEDescriptor* Descriptor);
            B4R::B4RString* UUID();
    };

    class B4RLocalService {
        public:
            BLEService* nativeService;
            void Initialize(void* UUID);
            void AddCharacteristic(B4RLocalCharacteristic* Characteristic);
    };

    class B4RBLEDevice {
        public:
            BLEDevice nativeDevice;
            B4R::B4RString* LocalName();
            B4R::B4RString* Address();
            int RSSI();
            bool Connect();
            void Disconnect();
            bool Connected();
            bool DiscoverAttributes();
            void WriteCharacteristic(void* ServiceUUID, void* CharUUID, void* Data);
            B4R::Array* ReadCharacteristic(void* ServiceUUID, void* CharUUID);
            B4R::Array* ReadDescriptor(void* ServiceUUID, void* CharUUID, void* DescriptorUUID);
            bool Subscribe(void* ServiceUUID, void* CharUUID);
            bool Unsubscribe(void* ServiceUUID, void* CharUUID);
            bool CanSubscribe(void* ServiceUUID, void* CharUUID);
            B4R::Array* ManufacturerData(); 
    };

    class B4RBLEMaster {
        public:
            B4R::B4RString* LocalName = NULL;
            B4R::B4RString* DeviceName = NULL;
          
            B4R::B4RString* StringFromBytes(B4R::Array* Data);
            B4R::B4RString* HexFromBytes(B4R::Array* Data);

            B4R::B4RString* SubStringText(B4R::Array* Data, int Start, int Length);
            B4R::B4RString* SubStringHex(B4R::Array* Data, int Start, int Length);

            int Appearance = 0;

            bool Begin();
            void SetAppearance(int Value);
            void AddService(B4RLocalService* Service);
            void SetAdvertisedService(B4RLocalService* Service);
            void Advertise();
            void Poll();
            void Scan();
            void StopScan();
            B4RBLEDevice* Available();
            void AddBatteryService(int InitialLevel);
            void SetBatteryLevel(int Level);
            void SetManufacturerData(B4R::Array* Data);
            void AddDeviceInformationService(void* ManufacturerName, void* ModelNumber, void* SerialNumber);
    };
}

#include "B4RDefines.h"

#endif
