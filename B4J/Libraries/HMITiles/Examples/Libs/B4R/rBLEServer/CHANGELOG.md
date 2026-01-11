# CHANGELOG - B4R Library rBLEServer

## v0.9.2 (Build 20250731)
* UPD: Reworked this ESP32 BLE UART-like server for B4R.
* Implements a BLE server with:
* - One TX characteristic (Client -> Server, Write/Read)
* - One RX characteristic (Server -> Client, Notify)
* Supports:
* - Connection/disconnection callbacks
* - Receiving byte arrays from clients
* - Sending notifications to connected clients
* - Updating BLE advertisement data dynamically

## v0.8.5 (Build 20250224)
* NEW: Set BLE transmit power to maximum (+9 dBm).
* NEW: Example Home Assistant UI with DHT22 & Traffic-Light.
* Fix: onWrite proper handle of value 0x00.

## v0.8.0 (Build 20250207)
* NEW: Add descriptor 0x2902.
* NEW: Advertising the service UUID.
* NEW: Example InputOutput with B4A Client
* FIX: Various improvements (documentedin rBLEServer.cpp).

## v0.7.0 (Build 20250204)
* NEW: First version. Published [B4R Forum](http://www.b4x.com/android/forum/threads/rbleserver-esp32.165435/#content).
