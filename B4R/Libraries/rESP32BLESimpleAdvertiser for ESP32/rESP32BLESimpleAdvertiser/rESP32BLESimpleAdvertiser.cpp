#include "B4RDefines.h"

    B4R::B4RBLEScan*  B4R::B4RBLEScan::instance = NULL;

//**************************************** 
//class BLEAdvertisedDeviceCallbacks
//****************************************  
// advertising callbacks from scanner
class MyAdvertisedDeviceCallbacks: public BLEAdvertisedDeviceCallbacks 
    {
      // advertising device found
      void onResult(BLEAdvertisedDevice advDev) 
      {
         B4R::B4RBLEScan::On_AdvertisedDeviceSub((uint32_t) &advDev);
      };  
     };
    
namespace B4R
{
//****************************************
//class BLESimpleAdvertiser
//****************************************
    void B4RBLESimpleAdvertiser::Initialize()
    {
       simpleAd = new (backend) BLESimpleAdvertiser();
    };
    
    bool B4RBLESimpleAdvertiser::begin(B4RString* localName)
    {
       return simpleAd->begin(localName->data);
    };

    bool B4RBLESimpleAdvertiser::manufacturerDataAdvertise(B4RString* data)
    {
       return simpleAd->manufacturerDataAdvertise(data->data);
    };

    bool B4RBLESimpleAdvertiser::manufacturerDataAdvertise1(ArrayByte* data)
    {
       return simpleAd->manufacturerDataAdvertise((byte*)data->data, data->length);
    };

    bool B4RBLESimpleAdvertiser::serviceDataAdvertise(B4RString* data)
    {
       return simpleAd->serviceDataAdvertise(data->data);
    };

    bool B4RBLESimpleAdvertiser::serviceDataAdvertise1(uint16_t uuid, B4RString* data)
    {
       return simpleAd->serviceDataAdvertise(uuid, data->data);
    };

    bool B4RBLESimpleAdvertiser::serviceDataAdvertise2(B4RString* uuid, B4RString* data)
    {
       return simpleAd->serviceDataAdvertise(uuid->data, data->data);
    };

    bool B4RBLESimpleAdvertiser::serviceDataAdvertise3(ArrayByte* data)
    {
       return simpleAd->serviceDataAdvertise((byte*)data->data, data->length);
    };

    bool B4RBLESimpleAdvertiser::serviceDataAdvertise4(uint16_t uuid, ArrayByte* data)
    {
       return simpleAd->serviceDataAdvertise(uuid, (byte*)data->data, data->length);
    };

    bool B4RBLESimpleAdvertiser::serviceDataAdvertise5(B4RString* uuid, ArrayByte* data)
    {
       return simpleAd->serviceDataAdvertise(uuid->data, (byte*)data->data, data->length);
    };

    void B4RBLESimpleAdvertiser::end()
    {
       simpleAd->end();
    };



//****************************************
//class BLEDevice
//****************************************

    uint32_t B4RBLEDevice::createServer()
    {
       Server = BLEDevice::createServer();
       return (uint32_t) Server;
    };

    uint32_t B4RBLEDevice::createClient()
    {
       Client = BLEDevice::createClient(); 
       return (uint32_t) Client;   
    };
    
    B4RString* B4RBLEDevice::getAddress()                                    
    {
       BLEAddress Address = BLEDevice::getAddress();                      
       String raw = Address.toString();  
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };      
    
    uint32_t B4RBLEDevice::getScan()                                                
    {       
       scanner = BLEDevice::getScan(); 
       return (uint32_t) scanner;     
    };    

    B4RString* B4RBLEDevice::getValue(B4RString* address, B4RString* serviceUUID, B4RString* characteristicUUID)  
    {  
	   BLEAddress Address(address->data);
       BLEUUID    ServiceUUID(serviceUUID->data);
       BLEUUID CharacteristicUUID(characteristicUUID ->data);
       String raw = BLEDevice::getValue(Address, ServiceUUID, CharacteristicUUID);  
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };      

    void B4RBLEDevice::init(B4RString* deviceName)
    {
       BLEDevice::init(deviceName->data);
    };

    bool B4RBLEDevice::setPower(byte powerLevel, byte powerType)     //powerLevel=0<7 and powerType=0<12
    { if (powerType<13 and powerLevel<8){
      BLEDevice::setPower( (esp_power_level_t) powerLevel, (esp_ble_power_type_t) powerType); return true;}
      else {return false;}
    };

    void B4RBLEDevice::setValue(B4RString* address, B4RString* serviceUUID, B4RString* characteristicUUID, B4RString* value)
    {
	   BLEAddress Address(address->data);
       BLEUUID    ServiceUUID(serviceUUID->data);
       BLEUUID CharacteristicUUID(characteristicUUID->data);
       BLEDevice::setValue(Address, ServiceUUID, CharacteristicUUID, value->data);  

    };

    B4RString*  B4RBLEDevice::toString()
    {
       String raw = BLEDevice::toString();  
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };      

    void B4RBLEDevice::whiteListAdd(B4RString* address)
    {
       BLEAddress Address(address->data);
       BLEDevice::whiteListAdd( Address);
    };

    void B4RBLEDevice::whiteListRemove(B4RString* address)
    {
       BLEAddress Address(address->data);   
       BLEDevice::whiteListRemove( Address);
    };

    bool B4RBLEDevice::setEncryptionLevel(byte level)      //level = 1<3
    {  if (level<4) {
       esp_ble_sec_act_t level1 = (esp_ble_sec_act_t)level; 
       BLEDevice::setEncryptionLevel( level1); return true;}
       else {return false;}
    };

    uint16_t B4RBLEDevice::setMTU(uint16_t mtu)      // esp_err is int
    {  
       esp_err_t tmp = BLEDevice::setMTU(mtu);  
       return (uint16_t)tmp;
    };

    uint16_t B4RBLEDevice::getMTU()
    {
       return BLEDevice::getMTU();
    };

    bool B4RBLEDevice::getInitialized()
    {
       return BLEDevice::getInitialized();
    };

//??     /* move advertising to BLEDevice for saving ram and flash in beacons */
    uint32_t B4RBLEDevice::getAdvertising()
    {
       advert = BLEDevice::getAdvertising();
       return (uint32_t) advert;   
    };

    void B4RBLEDevice::startAdvertising()
    {
       BLEDevice::startAdvertising();
    };

    void B4RBLEDevice::stopAdvertising()
    {
       BLEDevice::stopAdvertising();
    };

    uint16_t B4RBLEDevice::m_appId()
    {
       return BLEDevice::m_appId;
    };



//****************************************
//class BLEScan 
//****************************************
// scanner launch from BLEDevice
//    BLEScan * scanner;              //??????????????????????????????

    void B4RBLEScan::setActiveScan(uint32_t scanID, bool active)
    {
       BLEScan* scanner =  (BLEScan*) scanID;
       scanner->setActiveScan(active);
    };

    void B4RBLEScan::setAdvertisedDeviceCallbacks(uint32_t scanID, Subvoid_ulong OnAdvertisedDeviceSub)
    {
       BLEScan* scanner =  (BLEScan*) scanID;
       this->OnAdvertisedDevice_Sub = OnAdvertisedDeviceSub;
       instance = this;  
       scanner->setAdvertisedDeviceCallbacks(new MyAdvertisedDeviceCallbacks());
    };
    
    void B4RBLEScan::On_AdvertisedDeviceSub( uint32_t advDevID)
    {    
       instance->OnAdvertisedDevice_Sub(advDevID); 
    };
     
    void B4RBLEScan::setInterval(uint32_t scanID, uint16_t intervalMSecs)
    {
       BLEScan* scanner =  (BLEScan*) scanID;
       scanner->setInterval(intervalMSecs);
    };

    void B4RBLEScan::setWindow(uint32_t scanID, uint16_t windowMSecs)
    {
       BLEScan* scanner =  (BLEScan*) scanID;
       scanner->setWindow(windowMSecs);
    };

    uint32_t B4RBLEScan::start(uint32_t scanID, uint32_t duration, bool is_continue)
    {
      BLEScan* scanner =  (BLEScan*) scanID;
      BLEScanResults  res =  scanner->start(duration, is_continue);
      return (uint32_t) &res;
    };       
       
    void B4RBLEScan::stop(uint32_t scanID)
    {
       BLEScan* scanner =  (BLEScan*) scanID;    
       scanner->stop();
    };

    void B4RBLEScan::erase(uint32_t scanID, B4RString* address)
    {
       BLEScan* scanner =  (BLEScan*) scanID;
       BLEAddress Address(address->data);   
       scanner->erase(Address);
    };

    uint32_t B4RBLEScan::getResults(uint32_t scanID)
    {
       BLEScan* scanner =  (BLEScan*) scanID;
       BLEScanResults res = scanner->getResults();
       return (uint32_t)&res;
    };

    void B4RBLEScan::clearResults(uint32_t scanID)
    {
       BLEScan* scanner =  (BLEScan*) scanID;
       scanner->clearResults();
    };


    
//****************************************
//class BLEScanResults
//****************************************
//    BLEScanResults* scanres;

    int16_t B4RBLEScanResults::getCount(uint32_t scanresID)
    {
       BLEScanResults* scanres = (BLEScanResults*) scanresID;
       return scanres->getCount();
    };

    uint32_t B4RBLEScanResults::getDevice(uint32_t scanresID, uint32_t i)
    {
       BLEScanResults* scanres = (BLEScanResults*) scanresID;    
       BLEAdvertisedDevice res = scanres->getDevice(i);
//       B4R::B4RBLEAdvertisedDevice::advDev = &res;
       return  (uint32_t) &(res);          
    };    



//****************************************    
//class BLEAdvertisedDevice 
//****************************************
//    BLEAdvertisedDevice* advDev;

    B4RString* B4RBLEAdvertisedDevice::getAddress(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       BLEAddress address = advDev->getAddress();
       String raw = address.toString().c_str();  
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };      
    
    uint16_t B4RBLEAdvertisedDevice::getAppearance(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->getAppearance();
    };

    B4RString* B4RBLEAdvertisedDevice::getManufacturerData(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       String raw = advDev->getManufacturerData().c_str();
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };       
                
    B4RString* B4RBLEAdvertisedDevice::getName(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       String raw = advDev->getName().c_str();
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };      

    int16_t B4RBLEAdvertisedDevice::getRSSI(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return (int16_t) advDev->getRSSI();
    };

    uint32_t B4RBLEAdvertisedDevice::getScan(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       BLEScan* scanner = advDev->getScan();
       return (uint32_t) scanner;
    };

    B4RString* B4RBLEAdvertisedDevice::getServiceData(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       String raw =  advDev->getServiceData().c_str();
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };       
       
    B4RString* B4RBLEAdvertisedDevice::getServiceData1(uint32_t advDevID, int16_t i)
    {       
       advDev = (BLEAdvertisedDevice*) advDevID;
       String raw =  advDev->getServiceData().c_str();
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };      

    B4RString* B4RBLEAdvertisedDevice::getServiceDataUUID(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       BLEUUID ServiceDataUUID = advDev->getServiceDataUUID();
       String raw = ServiceDataUUID.toString();
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };           
       
    B4RString* B4RBLEAdvertisedDevice::getServiceDataUUID1(uint32_t advDevID, int16_t i)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       BLEUUID ServiceDataUUID = advDev->getServiceDataUUID(i);
       String raw = ServiceDataUUID.toString();
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };            

    B4RString* B4RBLEAdvertisedDevice::getServiceUUID(uint32_t advDevID)    
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       BLEUUID ServiceUUID = advDev->getServiceUUID();
       String raw = ServiceUUID.toString().c_str();
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };            

    B4RString* B4RBLEAdvertisedDevice::getServiceUUID1(uint32_t advDevID, int16_t i) 
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       BLEUUID ServiceUUID = advDev->getServiceUUID(i);
       String raw = ServiceUUID.toString().c_str();
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };         
    
    int16_t B4RBLEAdvertisedDevice::getServiceDataCount(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->getServiceDataCount();
    };

    int16_t B4RBLEAdvertisedDevice::getServiceDataUUIDCount(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->getServiceDataUUIDCount();
    };

    int16_t B4RBLEAdvertisedDevice::getServiceUUIDCount(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->getServiceUUIDCount();
    };

    byte B4RBLEAdvertisedDevice::getTXPower(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->getTXPower();
    };

    ArrayByte* B4RBLEAdvertisedDevice::getPayload(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       uint8_t * raw = advDev->getPayload();      
       uint16_t len = advDev->getPayloadLength();
       ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
       arr->data=raw;
       arr->length=len;
       return arr;
    };

    uint16_t B4RBLEAdvertisedDevice::getPayloadLength(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->getPayloadLength();
    };

    byte B4RBLEAdvertisedDevice::getAddressType(uint32_t advDevID)          //BLE device address type = 0<3
    { 
       advDev = (BLEAdvertisedDevice*) advDevID;
       esp_ble_addr_type_t tmp = advDev->getAddressType();
       return (byte) tmp;   
    };          

    bool B4RBLEAdvertisedDevice::setAddressType(uint32_t advDevID, byte type)   // type = 0<3
    {
       advDev = (BLEAdvertisedDevice*) advDevID;      
       if(type<4) {
         esp_ble_addr_type_t type1 =(esp_ble_addr_type_t) type;
         advDev->setAddressType(type1); return true;}
       else{return false;}
    };

    bool B4RBLEAdvertisedDevice::isAdvertisingService(uint32_t advDevID, B4RString* uuid)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       BLEUUID   Uuid(uuid->data);       
       return advDev->isAdvertisingService( Uuid);
    };

    bool B4RBLEAdvertisedDevice::haveAppearance(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->haveAppearance();
    };

    bool B4RBLEAdvertisedDevice::haveManufacturerData(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->haveManufacturerData();
    };

    bool B4RBLEAdvertisedDevice::haveName(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->haveName();
    };

    bool B4RBLEAdvertisedDevice::haveRSSI(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->haveRSSI();
    };

    bool B4RBLEAdvertisedDevice::haveServiceData(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->haveServiceData();
    };

    bool B4RBLEAdvertisedDevice::haveServiceUUID(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->haveServiceUUID();
    };

    bool B4RBLEAdvertisedDevice::haveTXPower(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       return advDev->haveTXPower();
    };

    B4RString* B4RBLEAdvertisedDevice::toString(uint32_t advDevID)
    {
       advDev = (BLEAdvertisedDevice*) advDevID;
       String raw =  advDev->toString();   
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(raw);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };      
    
//****************************************    
//class BLEAddress 
//****************************************
// Bluetooth address length  --> #define ESP_BD_ADDR_LEN     6
// Bluetooth device address --> typedef uint8_t esp_bd_addr_t[ESP_BD_ADDR_LEN];

	//BLEAddress(esp_bd_addr_t address);
	//BLEAddress(std::string stringAddress);
    
// get an address 6 * bytes [0]<[5] from a hex string in the format: 00:00:00:00:00:00  which is 17 characters in length.      
    ArrayByte* B4RBLEAddress::getNative(B4RString* address)                      //#Meth
    {
//        String address2 = address->data;
//        std::string address1(address.length, address.data);
	    BLEAddress Address(address->data);
        esp_bd_addr_t* ipa = Address.getNative(); 
	    ArrayByte* ip = CreateStackMemoryObject(ArrayByte);
        ip->data = StackMemory::buffer + StackMemory::cp;
        ip->length = 6;
        ip->data = ipa;
//        for (byte i = 0;i < 6;i++) {(ip->data)[i] = ipa[i]; }
	    return ip;
    };
    
    bool B4RBLEAddress::equals(B4RString* address, B4RString* otheraddress)        // 6 * bytes [0]<[5]
    {   
//        std::string address1; address1.append(address.length, address.data);
	    BLEAddress Address(address->data);   
//        std::string Otheraddress1; Otheraddress1.append(otheraddress.length, otheraddress.data);
	    BLEAddress Otheraddress(otheraddress->data);      
	    return Address.equals( Otheraddress);
    };    
    
    B4RString* B4RBLEAddress::toString(ArrayByte* address)     //hex string in format: 00:00:00:00:00:00  (17 char)
    {  
       uint8_t* ipb = (uint8_t*) address->data;
       esp_bd_addr_t ipa = {ipb[0],ipb[1],ipb[2],ipb[3],ipb[4],ipb[5]};
       BLEAddress Address(ipa);  
	   String raw =  Address.toString();
       char* raw1 = const_cast<char*>(raw.c_str());         
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data =  raw1;
       return arr;     
    };


//****************************************    
// class BLEUUID
//****************************************    
//esp_bt_uuid_t                                                                  /*!< UUID length, 16bit, 32bit or 128bit */
//    union {
//   uint16_t    uuid16;                 /*!< 16bit UUID */
//   uint32_t    uuid32;                 /*!< 32bit UUID */
//   uint8_t     uuid128[ESP_UUID_LEN_128]; /*!< 128bit UUID */
//   } uuid;									/*!< UUID */
//} __attribute__((packed)) esp_bt_uuid_t;                                       // native format

//	    BLEUUID uuid(std::string uuid); 
//	    BLEUUID uuid(uint16_t uuid);  
//	    BLEUUID uuid(uint32_t uuid);
//	    BLEUUID uuid(esp_bt_uuid_t uuid);
//	    BLEUUID uuid(uint8_t* pData, size_t size, bool msbFirst);
//	    BLEUUID uuid(esp_gatt_id_t gattId);
//	    BLEUUID uuid();
    B4RString* B4RBLEUUID::setUUID1(B4RString* uuid)
    {
       BLEUUID Uuid(uuid->data);      
	   String raw = Uuid.toString();
       char* raw1 = const_cast<char*>(raw.c_str());  
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw1;
       return arr;       
    };
                                                                                    
    B4RString* B4RBLEUUID::setUUID2(uint16_t uuid)
    {
       BLEUUID Uuid(uuid);      
	   String raw = Uuid.toString();
       char* raw1 = const_cast<char*>(raw.c_str());  
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw1;
       return arr;        
    };

    B4RString* B4RBLEUUID::setUUID3(uint32_t uuid)
    {
       BLEUUID Uuid(uuid);      
	   String raw = Uuid.toString();
       char* raw1 = const_cast<char*>(raw.c_str());         
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw1;
       return arr;        
    };
     
    B4RString* B4RBLEUUID::setUUID4(ArrayByte* uuid, bool msbFirst)
    { 
       BLEUUID Uuid((uint8_t*)uuid->data, uuid->length, msbFirst);      
	   String raw = Uuid.toString();
       char* raw1 = const_cast<char*>(raw.c_str());         
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw1;
       return arr;        
    };

    uint8_t B4RBLEUUID::bitSize(B4RString* uuid)
    {
	    BLEUUID Uuid(uuid->data); 
	    return Uuid.bitSize();   // Get the number of bits in this uuid.
    };
    
    bool B4RBLEUUID::equals(B4RString* uuid1, B4RString* uuid2)
    {
	    BLEUUID Uuid1(uuid1->data);   
	    BLEUUID Uuid2(uuid2->data);          
	    return Uuid1.equals(Uuid2);
    };
    
    ArrayByte* B4RBLEUUID::getNative(B4RString* uuid)                                //~Meth
    {    
	    BLEUUID Uuid(uuid->data);  
        uint8_t* uui = (uint8_t*) Uuid.getNative();
        int uuilen =  Uuid.bitSize();       
        ArrayByte* ui = CreateStackMemoryObject(ArrayByte);
        ui->data = StackMemory::buffer + StackMemory::cp;
        ui->length = uuilen;// uint8_t* uuj = (uint8_t*) uui;
        ui->data = uui;
	    return ui;  
     };   

    B4RString* B4RBLEUUID::to128(B4RString* uuid)
    {
	    BLEUUID Uuid(uuid->data);         
	    Uuid.to128();
 	    String raw = Uuid.toString();
        char* raw1 = const_cast<char*>(raw.c_str());         
        B4RString* arr = CreateStackMemoryObject(B4RString);
        arr->data = raw1;
        return arr;            
    };  
    
//    B4RString* B4RBLEUUID::toString(ArrayByte* uuid)
//    {
//       esp_bt_uuid_t* uui = (esp_bt_uuid_t*) uuid->data; 
//       uint8_t* uui = (uint8_t*) uuid->data;  
//       esp_bt_uuid_t uui1[uuid->length]; for (int i = 0; i<(uuid->length); i++){uui1[i]= (esp_bt_uuid_t)uui[i];} ; 
//       BLEUUID Uuid(uui1);      
//	   String raw = Uuid.toString();
//       char* raw1 = const_cast<char*>(raw.c_str());         
//       B4RString* arr = CreateStackMemoryObject(B4RString);
//       arr->data = raw1;
//       return arr;            
//    };    

    ArrayByte* B4RBLEUUID::fromString(B4RString* uuid)
    {   
	    BLEUUID Uuid(uuid->data);  // Create a BLEUUID from a string
        uint8_t* uui = (uint8_t*) Uuid.getNative();
        int uuilen =  Uuid.bitSize();     
        ArrayByte* ui = CreateStackMemoryObject(ArrayByte);
        ui->data = StackMemory::buffer + StackMemory::cp;
        ui->length = uuilen;
        ui->data = uui;
	    return ui;  
    };
    
}    
//typedef enum {
//    ESP_PWR_LVL_N12 = 0,                /*!< Corresponding to -12dbm */
//    ESP_PWR_LVL_N9  = 1,                /*!< Corresponding to  -9dbm */
//    ESP_PWR_LVL_N6  = 2,                /*!< Corresponding to  -6dbm */
//    ESP_PWR_LVL_N3  = 3,                /*!< Corresponding to  -3dbm */
//    ESP_PWR_LVL_N0  = 4,                /*!< Corresponding to   0dbm */
//    ESP_PWR_LVL_P3  = 5,                /*!< Corresponding to  +3dbm */
//    ESP_PWR_LVL_P6  = 6,                /*!< Corresponding to  +6dbm */
//    ESP_PWR_LVL_P9  = 7,                /*!< Corresponding to  +9dbm */
//} esp_power_level_t;

//typedef enum {
//    ESP_BLE_PWR_TYPE_CONN_HDL0  = 0,            /*!< For connection handle 0 */
//    ESP_BLE_PWR_TYPE_CONN_HDL1  = 1,            /*!< For connection handle 1 */
//    ESP_BLE_PWR_TYPE_CONN_HDL2  = 2,            /*!< For connection handle 2 */
//    ESP_BLE_PWR_TYPE_CONN_HDL3  = 3,            /*!< For connection handle 3 */
//    ESP_BLE_PWR_TYPE_CONN_HDL4  = 4,            /*!< For connection handle 4 */
//    ESP_BLE_PWR_TYPE_CONN_HDL5  = 5,            /*!< For connection handle 5 */
//    ESP_BLE_PWR_TYPE_CONN_HDL6  = 6,            /*!< For connection handle 6 */
//    ESP_BLE_PWR_TYPE_CONN_HDL7  = 7,            /*!< For connection handle 7 */
//    ESP_BLE_PWR_TYPE_CONN_HDL8  = 8,            /*!< For connection handle 8 */
//    ESP_BLE_PWR_TYPE_ADV        = 9,            /*!< For advertising */
//    ESP_BLE_PWR_TYPE_SCAN       = 10,           /*!< For scan */
//    ESP_BLE_PWR_TYPE_DEFAULT    = 11,           /*!< For default, if not set other, it will use default value */
//    ESP_BLE_PWR_TYPE_NUM        = 12,           /*!< TYPE numbers */
//} esp_ble_power_type_t;

/// BLE device address type
//typedef enum {
//    BLE_ADDR_TYPE_PUBLIC        = 0x00,
//    BLE_ADDR_TYPE_RANDOM        = 0x01,
//    BLE_ADDR_TYPE_RPA_PUBLIC    = 0x02,
//    BLE_ADDR_TYPE_RPA_RANDOM    = 0x03,
//} esp_ble_addr_type_t;

//typedef enum {
//    ESP_BLE_SEC_ENCRYPT = 1,            
//    ESP_BLE_SEC_ENCRYPT_NO_MITM,
//    ESP_BLE_SEC_ENCRYPT_MITM,
//}esp_ble_sec_act_t;

/* Definitions for error constants. */
//typedef int esp_err_t;
//#define ESP_OK          0       /*!< esp_err_t value indicating success (no error) */
//#define ESP_FAIL        -1      /*!< Generic esp_err_t code indicating failure */

//#define ESP_ERR_NO_MEM              0x101   /*!< Out of memory */
//#define ESP_ERR_INVALID_ARG         0x102   /*!< Invalid argument */
//#define ESP_ERR_INVALID_STATE       0x103   /*!< Invalid state */
//#define ESP_ERR_INVALID_SIZE        0x104   /*!< Invalid size */
//#define ESP_ERR_NOT_FOUND           0x105   /*!< Requested resource not found */
//#define ESP_ERR_NOT_SUPPORTED       0x106   /*!< Operation or feature not supported */
//#define ESP_ERR_TIMEOUT             0x107   /*!< Operation timed out */
//#define ESP_ERR_INVALID_RESPONSE    0x108   /*!< Received response was invalid */
//#define ESP_ERR_INVALID_CRC         0x109   /*!< CRC or checksum was invalid */
//#define ESP_ERR_INVALID_VERSION     0x10A   /*!< Version was invalid */
//#define ESP_ERR_INVALID_MAC         0x10B   /*!< MAC address was invalid */
//#define ESP_ERR_NOT_FINISHED        0x10C   /*!< There are items remained to retrieve */

//#define ESP_ERR_WIFI_BASE           0x3000  /*!< Starting number of WiFi error codes */
//#define ESP_ERR_MESH_BASE           0x4000  /*!< Starting number of MESH error codes */
//#define ESP_ERR_FLASH_BASE          0x6000  /*!< Starting number of flash error codes */
//#define ESP_ERR_HW_CRYPTO_BASE      0xc000  /*!< Starting number of HW cryptography module error codes */
//#define ESP_ERR_MEMPROT_BASE        0xd000  /*!< Starting number of Memory Protection API error codes */
