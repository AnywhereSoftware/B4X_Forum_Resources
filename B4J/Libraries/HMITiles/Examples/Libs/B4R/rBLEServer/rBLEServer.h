/**
 * @file rBLEServer.h
 * @brief ESP32 BLE UART-like server for B4R.
 *
 * This class implements a BLE server with:
 * - One TX characteristic (Client -> Server, Write/Read)
 * - One RX characteristic (Server -> Client, Notify)
 *
 * It supports:
 * - Connection/disconnection callbacks
 * - Receiving byte arrays from clients
 * - Sending notifications to connected clients
 * - Updating BLE advertisement data dynamically
 *
 * @author Robert W.B. Linn
 * @date 2025
 * @license MIT
 */


#pragma once
#include "B4RDefines.h"

// ESP32 BLE library
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLECharacteristic.h>
#include <BLEUtils.h>
#include <BLE2902.h>

//~Library: rBLEServer
//~Author: Robert W.B. Linn
//~Brief: B4R library Bluetooth Low Energy (BLE) server for ESP32 (UART-style TX/RX).
//~Dependencies: Built-in ESP32 BLE library 3.1.1
//~Version: 0.92
//~Built: 20250730

namespace B4R {

    //~shortname: BLEServer
    //~Event: NewData (Buffer() As Byte)
    //~Event: Error
    typedef void (*SubVoidByte)(Byte b);

    class B4RBLEServer {
    private:
        // Global singleton instance
        static B4RBLEServer* instance;

        // B4R callbacks
        SubVoidArray NewDataSub;
        SubVoidByte ErrorSub;

        // BLE components
        BLEServer* pServer;
        BLEService* pService;
        BLECharacteristic* pCharacteristicTX;  // Client -> Server (Write)
        BLECharacteristic* pCharacteristicRX;  // Server -> Client (Notify)

        // Internal device name storage
        String internalDeviceName;

        // Internal Connection flag
        bool deviceConnected = false;

        // Centralized error handler
        void HandleError(uint8_t errorcode);

    public:
        /** MTU limits */
        static const UInt MTU_SIZE_MIN = 23;
        static const UInt MTU_SIZE_MAX = 512;

        /** Warning and error codes */
        static const Byte WARNING_INVALID_MTU = 1;
        static const Byte ERROR_INVALID_CHARACTERISTIC = 2;
        static const Byte ERROR_EMPTY_DATA = 3;

        /**
         * Initialize the BLE server.
         * @param Name B4RString with device name
         * @param NewDataSub Callback for received data
         * @param ErrorSub Callback for errors
         * @param mtuSize Desired MTU size (23-512)
         */
        void Initialize(B4RString* Name, SubVoidArray NewDataSub, SubVoidByte ErrorSub, UInt mtuSize);

        /** Check if a client is connected */
        bool IsConnected();

        /** Send data to client via Notify */
        void Write(ArrayByte* data);

        /** Update BLE advertisement manufacturer data */
        void WriteAdvertisement(ArrayByte* data);

        // --- Hidden / internal methods for B4R runtime ---

        //~hide
        static B4RBLEServer* GetInstance() { return instance; }

        //~hide
        void SetDeviceConnected(bool status);

        //~hide
        void SetStartAdvertising();

        //~hide
        void HandleDataReceived(ArrayByte &value);
    };

} // namespace B4R
