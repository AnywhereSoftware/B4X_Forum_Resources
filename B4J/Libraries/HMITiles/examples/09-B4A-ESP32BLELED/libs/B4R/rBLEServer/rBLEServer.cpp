/**
 * @file rBLEServer.cpp
 * @brief ESP32 BLE UART-like server for B4R.
 */

#include "B4RDefines.h"
#include "rBLEServer.h"

// UART-like BLE service UUIDs
#define SERVICE_UUID            "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
#define CHARACTERISTIC_UUID_TX  "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"  ///< Client -> Server (Write)
#define CHARACTERISTIC_UUID_RX  "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"  ///< Server -> Client (Notify)

namespace B4R {

    /// Static instance pointer initialization
    B4RBLEServer* B4RBLEServer::instance = nullptr;

    /**
     * @brief BLE Server callback for connection events.
     */
    class MyServerCallbacks : public BLEServerCallbacks {
    public:
        /**
         * @brief Called when a BLE client connects.
         * @param pServer Pointer to BLEServer instance.
         */
        void onConnect(BLEServer* pServer) override {
            if (B4RBLEServer::GetInstance()) {
                B4RBLEServer::GetInstance()->SetDeviceConnected(true);
                ::Serial.println("[B4RBLEServer::onConnect] Client connected");
            }
        }

        /**
         * @brief Called when a BLE client disconnects.
         * @param pServer Pointer to BLEServer instance.
         */
        void onDisconnect(BLEServer* pServer) override {
            if (B4RBLEServer::GetInstance()) {
                B4RBLEServer::GetInstance()->SetDeviceConnected(false);
                B4RBLEServer::GetInstance()->SetStartAdvertising();
                ::Serial.println("[B4RBLEServer::onDisconnect] Client disconnected, restarting advertising");
            }
        }
    };

    /**
     * @brief BLE Characteristic callback for client writes.
     *
     * This class handles incoming byte arrays written by the BLE client
     * to the TX characteristic.
     */
    class MyCallbacks : public BLECharacteristicCallbacks {
    public:
        /**
         * @brief Invoked when a client writes data to the TX characteristic.
         * @param pCharacteristic Pointer to BLECharacteristic.
         */
        void onWrite(BLECharacteristic* pCharacteristic) override {
            int len = pCharacteristic->getLength();
            if (len == 0) return;

            static uint8_t buffer[512];
            if (len > sizeof(buffer)) len = sizeof(buffer);

            const uint8_t* rawData = pCharacteristic->getData();
            memcpy(buffer, rawData, len);

            ArrayByte b4rData;
            b4rData.data = buffer;
            b4rData.length = len;

            if (B4RBLEServer::GetInstance()) {
                B4RBLEServer::GetInstance()->HandleDataReceived(b4rData);
            }

            ::Serial.print("[B4RBLEServer::onWrite] Received bytes: ");
            ::Serial.println(len);
        }
    };

    /**
     * @brief Initialize the BLE server.
     * @param Name Device name to advertise.
     * @param NewDataSub Callback for receiving byte arrays from client.
     * @param ErrorSub Callback for error handling.
     * @param mtuSize Preferred MTU size (23..517).
     */
    void B4RBLEServer::Initialize(B4RString* Name, SubVoidArray NewDataSub, SubVoidByte ErrorSub, uint16_t mtuSize) {
        instance = this;
        this->NewDataSub = NewDataSub;
        this->ErrorSub = ErrorSub;

        internalDeviceName = String(Name->data, Name->getLength());

        // Reset BLE to ensure clean init
        BLEDevice::deinit();
        delay(100);

        BLEDevice::init(internalDeviceName.c_str());

        String macStr = BLEDevice::getAddress().toString().c_str();
        ::Serial.print("[B4RBLEServer::Initialize] MAC Address: ");
        ::Serial.println(macStr.c_str());

        pServer = BLEDevice::createServer();
        pServer->setCallbacks(new MyServerCallbacks());

        // Create the UART-like BLE service
        pService = pServer->createService(SERVICE_UUID);

        // Characteristic for client writes (TX)
        pCharacteristicTX = pService->createCharacteristic(
            CHARACTERISTIC_UUID_TX,
            BLECharacteristic::PROPERTY_WRITE | BLECharacteristic::PROPERTY_READ
        );
        pCharacteristicTX->setCallbacks(new MyCallbacks());

        // Characteristic for server notifications (RX)
        pCharacteristicRX = pService->createCharacteristic(
            CHARACTERISTIC_UUID_RX,
            BLECharacteristic::PROPERTY_NOTIFY
        );
        pCharacteristicRX->addDescriptor(new BLE2902());

        pService->start();

        // Validate and set MTU
        if (mtuSize < MTU_SIZE_MIN || mtuSize > MTU_SIZE_MAX) {
            HandleError(ERROR_INVALID_CHARACTERISTIC);
            mtuSize = MTU_SIZE_MIN;
        }
        BLEDevice::setMTU(mtuSize);

        // Set TX power to maximum
        esp_ble_tx_power_set(ESP_BLE_PWR_TYPE_DEFAULT, ESP_PWR_LVL_P9);

        SetStartAdvertising();
    }

    /**
     * @brief Start BLE advertising with device name and service UUID.
     */
    void B4RBLEServer::SetStartAdvertising() {
        deviceConnected = false;

        BLEAdvertising* pAdvertising = BLEDevice::getAdvertising();
        pAdvertising->stop();

        BLEAdvertisementData advData;
        advData.setName(internalDeviceName.c_str());
        advData.setCompleteServices(BLEUUID(SERVICE_UUID));
        pAdvertising->setAdvertisementData(advData);

        BLEAdvertisementData scanRespData;
        scanRespData.setName(internalDeviceName.c_str());
        pAdvertising->setScanResponseData(scanRespData);

        pAdvertising->setScanResponse(true);
        pAdvertising->setMinPreferred(0x06);
        pAdvertising->setMaxPreferred(0x12);

        pAdvertising->start();

        ::Serial.print("[B4RBLEServer::SetStartAdvertising] Started advertising: ");
        ::Serial.println(internalDeviceName.c_str());
    }

    /**
     * @brief Returns whether a BLE client is connected.
     */
    bool B4RBLEServer::IsConnected() {
        return deviceConnected;
    }

    /**
     * @brief Sets the internal device connection status.
     * @param status True if client connected.
     */
    void B4RBLEServer::SetDeviceConnected(bool status) {
        deviceConnected = status;
    }

    /**
     * @brief Internal callback to process received data.
     * @param value Array of bytes received from client.
     */
    void B4RBLEServer::HandleDataReceived(ArrayByte& value) {
        if (NewDataSub) {
            NewDataSub(&value);
        }
    }

    /**
     * @brief Send data to the connected client via notification.
     * @param data Pointer to byte array.
     */
    void B4RBLEServer::Write(ArrayByte* data) {
        if (pCharacteristicRX == nullptr) {
            HandleError(ERROR_INVALID_CHARACTERISTIC);
            return;
        }
        if (data->length == 0) {
            HandleError(ERROR_EMPTY_DATA);
            return;
        }
        pCharacteristicRX->setValue((uint8_t*)data->data, data->length);
        pCharacteristicRX->notify();

        ::Serial.print("[B4RBLEServer::Write] Notified bytes: ");
        ::Serial.println(data->length);
    }

    /**
     * @brief Update BLE advertisement manufacturer data.
     * @param data Pointer to byte array containing manufacturer data.
     */
    void B4RBLEServer::WriteAdvertisement(ArrayByte* data) {
        BLEAdvertising* pAdvertising = BLEDevice::getAdvertising();
        pAdvertising->stop();

        BLEAdvertisementData advertisementData;

        uint8_t* bytes = (uint8_t*)data->data;
        String manufData = "";
        for (int i = 0; i < data->length; i++) {
            if (bytes[i] < 16) manufData += "0";
            manufData += String(bytes[i], HEX);
        }

        advertisementData.setManufacturerData(manufData);
        pAdvertising->setAdvertisementData(advertisementData);
        pAdvertising->start();
    }

    /**
     * @brief Invokes the error callback.
     * @param errorcode Error code.
     */
    void B4RBLEServer::HandleError(uint8_t errorcode) {
        if (ErrorSub) {
            ErrorSub(errorcode);
        }
    }

} // namespace B4R
