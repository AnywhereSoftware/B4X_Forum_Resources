/**
 * @file rNimBLEServer.h
 * @brief Header for the thin B4R NimBLE Server Wrapper.
 * Provides resource-efficient BLE server functionality on ESP32 for B4R.
 * 
 * @date 2026-03-25
 * @author Robert W.B. Linn
 * @version 1.0
 * 
 * @section description Description
 * This wrapper exposes a minimal BLE server interface for B4R, allowing:
 * - Advertising a BLE service
 * - Receiving data from clients (Write)
 * - Sending notifications to clients
 * - Handling connection lifecycle events
 * 
 * Designed to mirror rNimBLEClient for consistency.
 * 
 * @section dependencies Dependencies
 * Platform: esp32@3.3.6  
 * NimBLE: 2.3.7
 * 
 * @section license License
 * MIT License
 */

#pragma once
#ifndef RNIMBLESERVER_H
#define RNIMBLESERVER_H

#include "B4RDefines.h"
#include <NimBLEDevice.h>

// GPIO
#define ONBOARD_LED_PIN 2

//~Library: rNimBLEServer
//~Version: 1.0

namespace B4R {

    typedef void (*SubVoidArray)(ArrayByte* data);
    typedef void (*SubVoidVoid)();

    //~shortname: NimBLEServer
    //~Event: Connected ()
    //~Event: Disconnected ()
    //~Event: Write (Buffer() As Byte)

    /**
     * @class B4RNimBLEServer
     * @brief Lightweight BLE server wrapper for B4R.
     */
    class B4RNimBLEServer {
        private:
            // Internal state
            bool nimbleInitialized = false;
            bool connected = false;

			std::string deviceName;

            // NimBLE pointers
            NimBLEServer* pServer = nullptr;
            NimBLEService* pService = nullptr;
            NimBLECharacteristic* pCharacteristic = nullptr;
            NimBLEAdvertising* pAdvertising = nullptr;

            // UUIDs
            NimBLEUUID serviceUUID;
            NimBLEUUID charUUID;

            // B4R callbacks
            SubVoidVoid ConnectedSub;
            SubVoidVoid DisconnectedSub;
            SubVoidArray WriteSub;

        public:
            /** @brief Singleton instance for static callbacks */
			//~hide
            static B4RNimBLEServer* instance;

            /** @brief Enable debug logging */
			//~hide
            bool debug = false;

			/** NOT USED as handled by B4R */
			/** --- HubController Protocol --- */

			//~hide
			static const uint8_t FRAME_START = 0x19;
			//~hide
			static const uint8_t FRAME_END   = 0x58;

			/** NOT USED - Example defining constants to toggle onboard led */
			/** Addresses */
			//~hide
			static const uint8_t SYSTEM1_ADDRESS 			= 0x3C;	// DEC 60
			/** Commands */
			//~hide
			static const uint8_t SYSTEM_CMD_ONBOARD_LED		= 0x01;	// DEC 1
			/** States */
			//~hide
			static const uint8_t STATE_OFF					= 0x00;	// DEC 0
			//~hide
			static const uint8_t STATE_ON					= 0x01;	// DEC 1

            /**
             * @brief Initializes the BLE server.
             * @param DeviceName - Name of the BLE device (advertised)
             * @param ServiceUUID - UUID of the BLE service
             * @param CharUUID - UUID of the characteristic (RX/TX combined)
             * @param OnConnected - Callback when client connects
             * @param OnDisconnected - Callback when client disconnects
             * @param OnWrite - Callback when client writes data
             * @param Debug - Enable serial debug output
             */
            void Initialize(B4RString* DeviceName, B4RString* ServiceUUID, B4RString* CharUUID, SubVoidVoid OnConnected, SubVoidVoid OnDisconnected, SubVoidArray OnWrite, bool Debug);

            /**
             * @brief Starts the BLE server and begins advertising.
             */
            void Start();

            /**
             * @brief Stops the BLE server and advertising.
             */
            void Stop();

            /**
             * @brief Sends notification to connected client.
             * @param data Byte array to send
             */
            void Write(ArrayByte* data);

            /**
             * @brief Set cleitn connection state.
             * @param state bool true or false
             */
			void SetConnected(bool state);

            /**
             * @brief Returns connection status.
             */
            bool IsConnected();

            /** Internal event handlers */
			
			//~hide
            void HandleConnect();

			//~hide
            void HandleDisconnect();

			//~hide
            void HandleWrite(uint8_t* data, size_t length);
			
			//~hide
			void SendAck(uint8_t* data, size_t length);
    };

} // namespace B4R

#endif
