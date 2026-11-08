"""BLE-TCP-Bridge Server

A TCP server that communicates with a BLE device using BLE-Bridge.

Usage:
    python ble-bridge.py [-d <BLE_DEVICE_NAME>] [-m <BLE_MAC>] [-c <HEX_COMMAND>] [-h <HOST>] [-p <PORT>]

Arguments:
    -d, --device      (Optional) BLE device name (default: None).
    -m, --mac         (Optional) BLE MAC address (default: "30:C9:22:D1:80:2E").
    -c, --command     (Optional) HEX command to send after connection (default: None).
    -s, --server      (Optional) TCP server name (default: "127.0.0.1").
    -p, --port        (Optional) TCP server port (default: 58001).

Examples:
    python ble-bridge.py -m 30:C9:22:D1:80:2E -c 0101
    python ble-bridge.py -d MyBLEDevice -p 60000
    python ble-bridge.py -m AA:BB:CC:DD:EE:FF -h 192.168.1.100

Notes:
    - The server connects to a BLE device using a **MAC address or device name**.
    - The **-c argument** allows sending a HEX command immediately after connecting.
    - Runs a **TCP server** that listens for hex commands from clients.
"""

import psutil
import os
import json
import socket

import argparse
import asyncio
import struct
import logging
from bleak import BleakClient, BleakScanner

# Constants
VERSION = "BLE-Bridge v20250301"

BLE_DEVICE_NAME = "BLEServer"
BLE_DEVICE_MAC = "30:C9:22:D1:80:2E"

SERVICE_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
CHARACTERISTIC_UUID = "6e400002-b5a3-f393-e0a9-e50e24dcca9e"

TCP_HOST = "127.0.0.1"
TCP_PORT = 58001

MAX_RETRIES = 5
TIMEOUT = 30
RETRY_DELAY = 5

logging.basicConfig(level=logging.INFO)
log = logging.getLogger("BLE-TCP-Bridge")

ble_server = None
ble_bridge = None

def send_status(event, message, status):
    """Send a structured status message immediate to stdout."""
    status = {"event": event, "message": message, "status": status}
    print(json.dumps(status), flush=True)  # Flush to ensure immediate output

class BLEBridge:
    def __init__(self, server, device_name, device_mac, initial_command):
        self.server = server
        self.name = device_name
        self.mac = device_mac
        self.initial_command = initial_command
        self.client = None
        self.connected = False
        self.bridge_running = True

    async def connect(self):
        log.info("Scanning for BLE device...")
        device = await BleakScanner.find_device_by_address(self.mac) or \
                 await BleakScanner.find_device_by_name(self.name)
        if not device:
            log.error("BLE device not found!")
            return False

        self.client = BleakClient(device.address)
        for attempt in range(MAX_RETRIES):
            try:
                await self.client.connect(timeout=TIMEOUT)
                if self.client.is_connected:
                    self.connected = True
                    
                    log.info(f"Connected to {device.address}")
                    send_status("connect", "BLE-TCP-Bridge successfully connected", 1)
                    
                    await self.client.start_notify(CHARACTERISTIC_UUID, self.notification_handler)
                    
                    if self.initial_command is not None:
                        await self.send_command(bytearray.fromhex(self.initial_command))
                    return True
            except asyncio.TimeoutError:
                log.error(f"Connection timed out. Retry {attempt + 1}/{MAX_RETRIES}...")
                await asyncio.sleep(RETRY_DELAY)
            except Exception as econnect:
                log.error(f"BLE connection error: {econnect}")
                send_status("connect", f"BLE-TCP-Bridge connection error: {econnect}", 0)
                break
        return False

    async def notification_handler(self, sender, data):
        """Handle ble notifications. Send the data to the BLE server connected clients."""
        _ = sender  # Unused, but avoids Pylint warning
        if len(data) > 0:
            try:
                log.info(f"Received: {data.hex()}")
                # Sent data to ble server clients
                await self.server.send_to_clients(data)
            except struct.error as e:
                log.error(f"Error unpacking data: {e}")

    async def send_command(self, command):
        if self.connected and self.client is not None:
            try:
                if command:
                    await self.client.write_gatt_char(CHARACTERISTIC_UUID, command, response=True)
                    log.info(f"Sent command: {command.hex()}")
            except Exception as e:
                log.error(f"Error sending command: {e}")
        else:
            log.error("BLE client is not connected. Cannot send command.")

    async def disconnect(self):
        if self.client and self.connected:
            try:
                log.info("Disconnecting from BLE device...")
                await self.client.disconnect()
                self.connected = False
                log.info("Disconnected from BLE device.")
            except Exception as e:
                log.error(f"Error during BLE disconnecting: {e}")

    async def stop(self):
        log.info("Stopping BLE Bridge...")
        self.bridge_running = False
        await self.disconnect()

    async def run(self):
        while self.bridge_running:
            if not self.connected:
                log.info("Attempting BLE reconnection...")
                await self.connect()
            await asyncio.sleep(5)

class BLEServer:
    def __init__(self, bridge, host, port):
        self.ble_bridge = bridge
        self.host = host
        self.port = port
        self.server = None
        self.clients = set()

    def find_and_kill_process(self, port):
        """Find and kill the process using the given port."""
        for conn in psutil.net_connections():
            if conn.laddr.port == port and conn.status == psutil.CONN_LISTEN:
                pid = conn.pid
                if pid:
                    log.info(f"Port {port} is in use by PID {pid}. Terminating process...")
                    os.system(f"taskkill /PID {pid} /F")
                    return True
        return False

    async def handle_client(self, reader, writer):
        """Handle incoming TCP client connections."""
        addr = writer.get_extra_info('peername')
        log.info(f"New client connected: {addr}")
        self.clients.add(writer)

        try:
            while True:
                # Read command data 100 bytes
                data = await reader.read(100)
                if not data:
                    log.info(f"Client {addr} sent no data or disconnected.")
                    break
                log.info(f"Received command from client: {data.hex()}")
                # Check the command
                if data == b"stop":
                    log.info("Stop command received. Shutting down server.")
                    await self.stop()
                    break
                await self.ble_bridge.send_command(data)
        except asyncio.CancelledError:
            log.info("Client handler task cancelled.")
        finally:
            self.clients.discard(writer)
            writer.close()
            await writer.wait_closed()

    async def send_to_clients(self, message):
        """Send BLE data to all connected TCP clients."""
        for writer in self.clients.copy():
            try:
                writer.write(message)
                await writer.drain()
            except:
                self.clients.discard(writer)

    async def start_server(self):
        """Start the BLE TCP Bridge server."""
        if self.find_and_kill_process(self.port):
            await asyncio.sleep(1)  # Allow OS to release the port

        self.server = await asyncio.start_server(self.handle_client, self.host, self.port)
        log.info(f"BLE Server running on {self.host}:{self.port}")
        async with self.server:
            await self.server.serve_forever()

    async def stop(self):
        """Stop the BLE TCP Bridge server."""
        log.info("Stopping BLE Server...")
        for writer in self.clients.copy():
            try:
                writer.close()
                await writer.wait_closed()
            except Exception as e:
                log.error(f"Error closing client connection: {e}")
        self.clients.clear()
        if self.server:
            self.server.close()
            await self.server.wait_closed()
        log.info("BLE Server stopped.")

async def shutdown():
    log.info("Shutting down application...")
    if ble_server:
        await ble_server.stop()
    if ble_bridge:
        await ble_bridge.stop()
    log.info("Shutdown complete.")

async def main(ble_name, ble_mac, initial_command, host, port):
    """Main function that runs the BLE bridge and TCP server."""
    global ble_server, ble_bridge

    # Init the BLE server
    ble_server = BLEServer(None, host, port)
    
    # Init the BLE bridge and assign the instance to the server
    ble_bridge = BLEBridge(ble_server, ble_name, ble_mac, initial_command)
    ble_server.ble_bridge = ble_bridge
    
    # 
    try:
        # Run the BLE bridge by connecting to the device
        # Followed by startig the BLE server
        await asyncio.gather(
            ble_bridge.run(),
            ble_server.start_server()
        )
    except asyncio.CancelledError:
        log.info("Main task cancelled.")
    finally:
        await shutdown()

if __name__ == "__main__":
    """Run BLE-TCP-Bridge server with command-line arguments."""
    log.info(VERSION)

    parser = argparse.ArgumentParser(add_help=False, description="BLE-Bridge Server - Communicate with BLE device over TCP.")
    parser.add_argument("-d", "--name", default=BLE_DEVICE_NAME, help="BLE device name (optional).")
    parser.add_argument("-m", "--mac", default=BLE_DEVICE_MAC, help="BLE MAC address (default: 30:C9:22:D1:80:2E).")
    parser.add_argument("-c", "--command", default=None, help="Initial HEX command to send.")
    parser.add_argument("-h", "--host", default=TCP_HOST, help="TCP server host (default: 127.0.0.1).")
    parser.add_argument("-p", "--port", type=int, default=TCP_PORT, help="TCP server port (default: 58001).")
    parser.add_argument("-H", "--help", action='help', help='Show this help message and exit')

    args = parser.parse_args()

    try:
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
        loop.run_until_complete(main(args.name, args.mac, args.command, args.host, args.port))
    except KeyboardInterrupt:
        log.info("Keyboard interrupt received. Stopping...")
    finally:
        loop.run_until_complete(shutdown())
        loop.close()
