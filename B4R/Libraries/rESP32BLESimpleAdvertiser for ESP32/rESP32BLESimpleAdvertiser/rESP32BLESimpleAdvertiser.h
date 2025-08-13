#pragma once
#include "B4RDefines.h"
#include "ESP32BLESimpleAdvertiser.h"
 #include "BLEDevice.h"
#include "BLEUtils.h"
#include "BLEScan.h"
#include "BLEAdvertisedDevice.h"
#include "BLEUUID.h"

namespace B4R {
    typedef void (*Subvoid_ulong)(uint32_t advDev);
    
    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray from https://github.com/peterk54/ESP32BLESimpleAdvertiser
    //~shortname:BLESimpleAdvertiser
    class B4RBLESimpleAdvertiser
    {
      private:
       uint8_t backend[sizeof(BLESimpleAdvertiser)];
       BLESimpleAdvertiser* simpleAd;
      public:    
        void Initialize();
  
        bool begin(B4RString* localName);
// manufacturer data advertise string
        bool manufacturerDataAdvertise(B4RString* data);
// manufacturer data advertise bytes 
        bool manufacturerDataAdvertise1(ArrayByte* data);
        
// service data advertise string
        bool serviceDataAdvertise(B4RString* data);
// service data advertise string with service data uuid
        bool serviceDataAdvertise1(uint16_t uuid, B4RString* data);

// service data advertise string with service data uuid as string parameter   
        bool serviceDataAdvertise2(B4RString* uuid, B4RString* data);
        
// service data advertise bytes
        bool serviceDataAdvertise3(ArrayByte* data);
// service data advertise bytes with service data uuid        
        bool serviceDataAdvertise4(uint16_t uuid, ArrayByte* data);
// service data advertise bytes with service data uuid as string parameter
        bool serviceDataAdvertise5(B4RString* uuid, ArrayByte* data);
   
        void end();
     };  



            
//****************************************
//class BLEDevice
//****************************************
    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino
    //~shortname:BLEDevice
    class B4RBLEDevice
    {
      private:
        uint8_t backend[sizeof(BLEDevice)];
 //       BLEDevice* server;
        BLEClient* Client;
        BLEServer* Server;
        BLEAdvertising* advert;
        BLEScan* scanner;
      public:
/**
 * @brief Create a new instance of a client.
 * @return A new instance of the client. (return ServerID)
 */        
        uint32_t createServer();
/**
 * @brief Create a new instance of a server.
 * @return A new instance of the server. (return ClientID)
 */
        uint32_t createClient();
/**
 * @brief Get the BLE device address.
 * @return The BLE device address.
 */
        B4RString* getAddress();  
        /**
 * @brief Retrieve the Scan object that we use for scanning.
 * @return The scanning object reference.  This is a singleton object.  The caller should not
 * try and release/delete it.
 * return scanID
 */                                                                                 //#Meth
        uint32_t getScan();                                                                                        //#Meth
/**
 * @brief Get the value of a characteristic of a service on a remote device.
 * @param [in] bdAddress
 * @param [in] serviceUUID
 * @param [in] characteristicUUID
 */
        B4RString* getValue(B4RString* address, B4RString* serviceUUID, B4RString* characteristicUUID);           //#Meth
/**
 * @brief Initialize the %BLE environment.
 * @param deviceName The device name of the device.
 */
        void init(B4RString* deviceName);
/**
 * @brief Set the transmission power. (powerLevel=0 to 7 and powerType=0 to 12)
 * The power level can be one of:
 * * ESP_PWR_LVL_N14 or ESP_PWR_LVL_N11 or ESP_PWR_LVL_N8 or ESP_PWR_LVL_N5 
 * * ESP_PWR_LVL_N2 or ESP_PWR_LVL_P1 or ESP_PWR_LVL_P4 or ESP_PWR_LVL_P7
 *
 * The power types can be one of:
 * * ESP_BLE_PWR_TYPE_CONN_HDL0 or ESP_BLE_PWR_TYPE_CONN_HDL1 or ESP_BLE_PWR_TYPE_CONN_HDL2 or ESP_BLE_PWR_TYPE_CONN_HDL3
 * * ESP_BLE_PWR_TYPE_CONN_HDL4 or ESP_BLE_PWR_TYPE_CONN_HDL5 or ESP_BLE_PWR_TYPE_CONN_HDL6 or ESP_BLE_PWR_TYPE_CONN_HDL7
 * * ESP_BLE_PWR_TYPE_CONN_HDL8 or ESP_BLE_PWR_TYPE_ADV or ESP_BLE_PWR_TYPE_SCAN or ESP_BLE_PWR_TYPE_DEFAULT
 * @param [in] powerType.
 * @param [in] powerLevel.
 */        
        bool setPower(byte powerLevel, byte powerType);                                                            //#Meth
/**
 * @brief Set the value of a characteristic of a service on a remote device.
 * @param [in] bdAddress
 * @param [in] serviceUUID
 * @param [in] characteristicUUID
 */
        void setValue(B4RString* address, B4RString* serviceUUID, B4RString* characteristicUUID, B4RString* value); //#Meth
/**
 * @brief Return a string representation of the nature of this device.
 * @return A string representation of the nature of this device.
 */
        B4RString*  toString();
/**
 * @brief Add an entry to the BLE white list.
 * @param [in] address The address to add to the white list.
 */
        void whiteListAdd(B4RString* address);
/**
 * @brief Remove an entry from the BLE white list.
 * @param [in] address The address to remove from the white list.
 */
        void whiteListRemove(B4RString* address);
/*
 * @brief Set encryption level that will be negotiated with peer device durng connection
 * @param [in] level Requested encryption level  (level = 1 to 3)
 */        
        bool setEncryptionLevel(byte level);                                                            //#Meth
/*
 * @brief Setup local mtu that will be used to negotiate mtu during request from client peer
 * @param [in] mtu Value to set local mtu, should be larger than 23 and lower or equal to 517
 */         
        uint16_t setMTU(uint16_t mtu);                                                                  //#Meth
/*
 * @brief Get local MTU value set during mtu request or default value
 */
        uint16_t getMTU();                                                                              //#Meth

        bool getInitialized();                                                                          //#Meth
        // get advertID
        uint32_t getAdvertising();                                                                          //#Meth
    
        void startAdvertising();                                                                                     

        void stopAdvertising();                                                                                     

        uint16_t m_appId();
    };
    
    
    
    
//****************************************
//class BLEScan 
//****************************************
// scanner launched from BLEDevice
    
    //~Event:
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino
    //~shortname:BLEScan
/**
 * @brief Perform and manage %BLE scans.
 *
 * Scanning is associated with a %BLE client that is attempting to locate BLE servers.
 */
    class B4RBLEScan
    {
      private:
        uint8_t backend[sizeof(BLEScan)];
        BLEScan* scanner;
        static B4RBLEScan*  instance;
        Subvoid_ulong OnAdvertisedDevice_Sub;
      public: 
//        static BLEScan* scanner;         
        void setActiveScan(uint32_t scanID, bool active);                                                       //#Meth

        void setAdvertisedDeviceCallbacks(uint32_t scanID, Subvoid_ulong OnAdvertisedDeviceSub);                 //#Meth
    
        static void On_AdvertisedDeviceSub(uint32_t advDevID);

        void setInterval(uint32_t scanID, uint16_t intervalMSecs);                                               //#Meth

        void setWindow(uint32_t scanID, uint16_t windowMSecs);                                                   //#Meth
        // get ScanResID
        uint32_t start(uint32_t scanID, uint32_t duration, bool is_continue);      
       
        void stop(uint32_t scanID);
        
        void erase(uint32_t scanID, B4RString* address);
        // get ScanResID
        uint32_t getResults(uint32_t scanID);                                                                      //#Meth
                                                                                             
        void clearResults(uint32_t scanID);
    };          
      
      
      
            
//****************************************
//class BLEScanResults
//****************************************
    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino
    //~shortname:BLEScanResults
/**
 * @brief The result of having performed a scan.
 * When a scan completes, we have a set of found devices.  Each device is described
 * by a BLEAdvertisedDevice object.  The number of items in the set is given by
 * getCount().  We can retrieve a device by calling getDevice() passing in the
 * index (starting at 0) of the desired device.
 */    
    class B4RBLEScanResults
    {
      private:
        uint8_t backend[sizeof(BLEScanResults)];
        BLEScanResults* scanres;
      public:     
        int16_t getCount(uint32_t scanresID);                                                  //#Meth
        // get advDevID
        uint32_t getDevice(uint32_t scanresID, uint32_t i);                                     //#Meth
     };
     
     
     
                    
//****************************************    
//class BLEAdvertisedDevice 
//****************************************
    //~Event: On_AdvertisedDeviceSub(ulong advDev) 
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino
    //~shortname:BLEAdvertisedDevice
    
    class B4RBLEAdvertisedDevice
    {
      private:
         uint8_t backend[sizeof(BLEAdvertisedDevice)];
         BLEAdvertisedDevice* advDev;
      public:
/**
 * @brief Get the address.
 *
 * Every %BLE device exposes an address that is used to identify it and subsequently connect to it.
 * Call this function to obtain the address of the advertised device.
 *
 * @return The address of the advertised device.
 */
        B4RString* getAddress(uint32_t advDevID);                                     //#Meth
/**
 * @brief Get the appearance.
 *
 * A %BLE device can declare its own appearance.  The appearance is how it would like to be shown to an end user
 * typcially in the form of an icon.
 *
 * @return The appearance of the advertised device.
 */    
        uint16_t getAppearance(uint32_t advDevID);                                    //#Meth
/**
 * @brief Get the manufacturer data.
 * @return The manufacturer data of the advertised device.
 */
        B4RString* getManufacturerData(uint32_t advDevID);                            //#Meth
/**
 * @brief Get the name.
 * @return The name of the advertised device.
 */      
        B4RString* getName(uint32_t advDevID);                                        //#Meth
/**
 * @brief Get the RSSI.
 * @return The RSSI of the advertised device.
 */
        int16_t getRSSI(uint32_t advDevID);                                           //#Meth
/**
 * @brief Get the scan object that created this advertisement.
 * @return The scan object. (scanID)
 */        
        uint32_t getScan(uint32_t advDevID);                                              //#Meth
/**
 * @brief Get the service data.
 * @return The ServiceData of the advertised device.
 */
        B4RString* getServiceData(uint32_t advDevID);                                 //#Meth
/**
 * @brief Get the service data.
 * @return The ServiceData of the advertised device.
 */
        B4RString* getServiceData1(uint32_t advDevID, int16_t i);                        //#Meth
/**
 * @brief Get the service data UUID.
 * @return The service data UUID.
 */
        B4RString* getServiceDataUUID(uint32_t advDevID);                             //#Meth
/**
 * @brief Get the service data UUID.
 * @return The service data UUID.
 */
        B4RString* getServiceDataUUID1(uint32_t advDevID, int16_t i);                    //#Meth
/**
 * @brief Get the Service UUID.
 * @return The Service UUID of the advertised device.
 */
        B4RString* getServiceUUID(uint32_t advDevID);                                 //#Meth
/**
 * @brief Get the Service UUID.
 * @return The Service UUID of the advertised device.
 */
        B4RString* getServiceUUID1(uint32_t advDevID, int16_t i);                        //#Meth
/**
 * @brief Get the number of service data.
 * @return Number of service data discovered.
 */
        int16_t getServiceDataCount(uint32_t advDevID);                               //#Meth
/**
 * @brief Get the number of service data UUIDs.
 * @return Number of service data UUIDs discovered.
 */
        int16_t getServiceDataUUIDCount(uint32_t advDevID);                           //#Meth
/**
 * @brief Get the number of service UUIDs.
 * @return Number of service UUIDs discovered.
 */
        int16_t getServiceUUIDCount(uint32_t advDevID);                               //#Meth
/**
 * @brief Get the TX Power.
 * @return The TX Power of the advertised device.
 */
        byte getTXPower(uint32_t advDevID);                                           //#Meth

        ArrayByte* getPayload(uint32_t advDevID);                                     //#Meth

        uint16_t getPayloadLength(uint32_t advDevID);                                 //#Meth
        //BLE device address type = 0 to 3  
        byte getAddressType(uint32_t advDevID);                                       //#Meth
        // address type = 0 to 3
        bool setAddressType(uint32_t advDevID, byte type);                              //#Meth

        bool isAdvertisingService(uint32_t advDevID, B4RString* uuid);                 

        bool haveAppearance(uint32_t advDevID);

        bool haveManufacturerData(uint32_t advDevID);

        bool haveName(uint32_t advDevID);

        bool haveRSSI(uint32_t advDevID);
    
        bool haveServiceData(uint32_t advDevID);

        bool haveServiceUUID(uint32_t advDevID);

        bool haveTXPower(uint32_t advDevID);

        B4RString* toString(uint32_t advDevID);      
       
    };
    
    
    
            
//****************************************    
//class BLEAddress 
//****************************************
//  Bluetooth address length  --> #define ESP_BD_ADDR_LEN     6
//  Bluetooth device address --> typedef uint8_t esp_bd_addr_t[ESP_BD_ADDR_LEN];

    class B4RBLEAddress
    { 
    //BLEAddress(esp_bd_addr_t address);
    //BLEAddress(std::string stringAddress);
      private: 
        BLEAddress address;
      public:     
// get an address 6 * bytes [0] to[5] from a hex string in the format: 00:00:00:00:00:00  which is 17 characters in length.     
        ArrayByte* getNative(B4RString* address);                     //#Meth
// compare 2 address in format: 00:00:00:00:00:00  which is 17 characters in length.
        bool equals(B4RString* address, B4RString* otheraddress);                
// get an hex string in the format: 00:00:00:00:00:00  which is 17 characters in length from an address 6 * bytes [0] to [5]    
        B4RString* toString(ArrayByte* address);     
    };    
    
    
    
     
//****************************************    
// class BLEUUID
//**************************************** 
//esp_bt_uuid_t       /*!< UUID length, 16bit, 32bit or 128bit */
//    union {
//   uint16_t    uuid16;                 /*!< 16bit UUID */
//   uint32_t    uuid32;                 /*!< 32bit UUID */
//   uint8_t     uuid128[ESP_UUID_LEN_128]; /*!< 128bit UUID */
//   } uuid;									/*!< UUID */
//} __attribute__((packed)) esp_bt_uuid_t;

    //BLEUUID uuid(std::string uuid);                                       //Create a UUID from a string, the string can be binary or hexa format   
    //BLEUUID uuid(uint16_t uuid);                                          //Create a UUID 16bits from the 16bit value.
    //BLEUUID uuid(uint32_t uuid);                                          //Create a UUID 32bits from The 32bit short form UUID
    //BLEUUID uuid(esp_bt_uuid_t uuid);                                     //Create a UUID from The native UUID
    //BLEUUID uuid(uint8_t* pData, size_t size, bool msbFirst);             //Create a UUID from pData a pointer to the start of the UUID +size The size of the data + msbFirst Is the MSB first in pData memory
    //BLEUUID uuid(esp_gatt_id_t gattId);                                   //Create a UUID from gattId data
    //BLEUUID uuid();                                                       //Create a empty UUID
 
    class B4RBLEUUID
    { 
//      private: 
//        BLEUUID uuid;

      public:
/**
 * Create a UUID from a string.  There will be two possible stories here.
 * Either the string represents a binary data field or the string represents a hex encoding of a UUID.
 * For the hex encoding, here is an example:
 * "beb5483e-36e1-4688-b7f5-ea07361b26a8"
 *  0 1 2 3  4 5  6 7  8 9  0 1 2 3 4 5
 *  12345678-90ab-cdef-1234-567890abcdef
 * ```
 * This has a length of 36 characters.  We need to parse this into 16 bytes.
 * @param [in] value The string to build a UUID from.
 */      
    B4RString* setUUID1(B4RString* uuid);                                         //#Meth
    
/**
 * @brief Create a UUID from the 16bit value.
 *
 * @param [in] uuid The 16bit short form UUID.
 */    
    B4RString* setUUID2(uint16_t uuid);                                           //#Meth
    
/**
 * @brief Create a UUID from the 32bit value.
 *
 * @param [in] uuid The 32bit short form UUID.
 */    
    B4RString* setUUID3(uint32_t uuid);                                           //#Meth
      
/**
 *Create a UUID from <128 bytes of memory.
 * @param [in] pData The pointer to the start of the UUID.
 * @param [in] size The size of the data.
 * @param [in] msbFirst Is the MSB first in pData memory?
 */
    B4RString* setUUID4(ArrayByte* uuid, bool msbFirst);                          //#Meth
        
/**
 * Get the number of bits in this uuid.
 * return The number of bits in the UUID.  One of 16, 32 or 128.
 */
    uint8_t bitSize(B4RString* uuid);
    
/**
 * Compare a UUID against this UUID.
 * param [in] uuid The UUID to compare against.
 * return True if the UUIDs are equal and false otherwise.
 */
    bool equals(B4RString* uuid1, B4RString* uuid2);
    
/**
 * Get the native UUID value.
 * return The native UUID value or NULL if not set.
 */
    ArrayByte* getNative(B4RString* uuid);                                       //#Meth
    
/**
 * Convert a UUID to its 128 bit representation.
 * A UUID can be internally represented as 16bit, 32bit or the full 128bit.
 * This method will convert 16 or 32 bit representations to the full 128bit.
 */
    B4RString* to128(B4RString* uuid); 
       
/**
 * Get a string representation of the UUID.
 * The format of a string is:
 *     01234567 8901 2345 6789 012345678901
 *     0000180d-0000-1000-8000-00805f9b34fb
 *     0 1 2 3  4 5  6 7  8 9  0 1 2 3 4 5
 * return A string representation of the UUID.
 */
 //   B4RString* toString(ArrayByte* uuid);
    
/**
 * Create a BLEUUID from a string of the form:
 * 0xNNNN
 * 0xNNNNNNNN
 * 0x<UUID>
 * NNNN
 * NNNNNNNN
 * <UUID>
 */
        ArrayByte* fromString(B4RString* uuid);    
    };    
    
    
    

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
}
