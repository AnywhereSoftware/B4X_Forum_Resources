#pragma once
/**
 * @file rESPNOW.h
 * @brief B4R C++ wrapper for the ESP-NOW communication protocol.
 * @note Tested with two ESP-WROOM-32 MCU's.
 * @note ESP-NOW is inherently bidirectional.
 * @version 1.0
 * @date 2026-05-04
 * @author Robert W. B. Linn (c) 2026 — MIT License
 */

#include "B4RDefines.h"
#include <esp_now.h>
#include <esp_wifi.h>
#include <WiFi.h>

namespace B4R {
	//~Version: 1.00
	//~Shortname: ESPNow
	//~Event: DataReceived (Mac() As Byte, Data() As Byte)
	//~Event: DataSent (Mac() As Byte, Status As Byte)

	/**
	* @class B4RESPNow
	* @brief ESP-NOW wrapper for ESP32 (B4R style, event-driven).
	*
	* Role-neutral design:
	* - Sender: use SendData()
	* - Receiver: handle DataReceived event
	* - Both: simply use both
	*
	* @note Only one instance supported (ESP-NOW uses global callbacks)
	*/
	class B4RESPNow {

		// Callback type definitions
		typedef void (*SubVoidByteArrByteArr)(ArrayByte* mac, ArrayByte* data);
		typedef void (*SubVoidByteArrByte)(ArrayByte* mac, Byte status);

		private:
			/** @brief Singleton instance (required for static callbacks) */
			static B4RESPNow* instance;

			/** @brief Event callbacks */
			SubVoidByteArrByteArr DataReceivedSub;
			SubVoidByteArrByte DataSentSub;

			/** @brief WiFi channel */
			Byte currentChannel;

			/** @brief Static ESP-NOW receive callback */
			static void OnDataRecv(const uint8_t * mac, const uint8_t *incomingData, int len);

			/** @brief Static ESP-NOW send callback */
			static void OnDataSent(const uint8_t *mac_addr, esp_now_send_status_t status);

		public:

			/**
			 * @brief Initialize ESP-NOW
			 * @param DataReceivedSub Callback for received data
			 * @param DataSentSub Callback for send result
			 * @return true if successful
			 */
			bool Initialize(SubVoidByteArrByteArr DataReceivedSub, SubVoidByteArrByte DataSentSub);

			/**
			 * @brief Set WiFi channel (must match peers)
			 */
			void SetChannel(Byte channel);

			/**
			 * @brief Get own MAC address
			 * @return ArrayByte (6 bytes)
			 */
			ArrayByte* GetMAC(void);

			/**
			 * @brief Add peer (uses current channel)
			 */
			bool AddPeer(ArrayByte* mac);

			/**
			 * @brief Remove peer
			 */
			bool RemovePeer(ArrayByte* mac);

			/**
			 * @brief Send data to peer
			 */
			bool SendData(ArrayByte* mac, ArrayByte* data);

			/**
			 * CONSTANTS
			 */
			 
			/** 
			 * @brief Send successful 
			 */
			const Byte SEND_OK = 1;

			/** 
			 * @brief Send failed 
			 */
			const Byte SEND_FAIL = 0;

	};	// Class

}	// Namespace
