"""Handle the client & service for BLE Server DHT integration.

BLE client to manage the connection with the BLE server.
Handle advertised data by parsing & update temperature & humidity entities.
Write data to set the traffic-light (LEDs) state and the advertisement timer interval.
Monitor the connection state.
Service to restart the connection via f.e. button.

ble_client.py
"""
import logging
import asyncio
import struct

from bleak import BleakScanner, BleakClient
from homeassistant.helpers import config_validation as cv
from homeassistant.core import HomeAssistant
from homeassistant.helpers import service

from .const import (
    LOGGING_PREFIX,
    DOMAIN, 
    BLE_SERVER_NAME,
    BLE_SERVER_ADDRESS,
    BLE_CONNECT_USING_ADDRESS,
    BLE_SCANNING_TIMEOUT,
    SERVICE_UUID,
    CHARACTERISTICS_UUID,
    SENSOR_TEMPERATURE_TYPE,
    SENSOR_HUMIDITY_TYPE,
    SWITCH_LED_TYPE,
    NUMBER_TIMER_TYPE,
    CMD_LED_RED, CMD_LED_YELLOW, CMD_LED_GREEN,
    CMD_TIMER,
)

_LOGGER = logging.getLogger(__name__)

async def async_setup(hass: HomeAssistant, config: dict):
    """Set up the BLE client service."""
    
    async def reconnect_service(call):
        """Service to manually trigger a reconnect."""
        ble_client = hass.data.get("ble_client")
        if ble_client:
            await ble_client.force_reconnect()

    hass.services.async_register(
        DOMAIN,             # Integration domain
        "force_reconnect",  # Service name
        reconnect_service,  # The function to call
    )

class BLEClient:
    """Set up the BLE client."""
    
    def __init__(self, hass, config):
        self._hass = hass
        self._config = config
        self.ble_server_name = config.get(BLE_SERVER_NAME, "BLEServer")
        self.ble_server_address = config.get(BLE_SERVER_ADDRESS, "30:C9:22:D1:80:2E")
        self.connect_using_address = config.get(BLE_CONNECT_USING_ADDRESS, False)
        self._scanner = BleakScanner()
        self._client = None
        self._is_connected = False
        
        self.sensors = {}               # Stores sensor instances
        self.switches = {}              # Stores switch instances
        self.numbers = {}               # Stores numbers instances
        self._reconnect_task = None     # Task to monitor BLE connection
        self._led_state = None          # Store led state 0 or 1
        self._timer_value = None        # Store timer value 0-60
        self._sensor_data = {}          # Initialize this in the __init__ method

    def register_sensor(self, sensor_type, sensor_obj):
        """Register a sensor for updates."""
        self.sensors[sensor_type] = sensor_obj
        _LOGGER.debug(f"{LOGGING_PREFIX}[register_sensor] Registered: {sensor_type}, Object: {sensor_obj}")
        
    def register_switch(self, switch_type, switch_obj):
        """Register a switch for updates."""
        self.switches[switch_type] = switch_obj
        _LOGGER.debug(f"{LOGGING_PREFIX}[register_switch] Registered: {switch_type}, Object: {switch_obj}")

    def register_number(self, number_type, number_obj):
        """Register a number for updates."""
        self.numbers[number_type] = number_obj
        _LOGGER.debug(f"{LOGGING_PREFIX}[register_number] Registered: {number_type}, Object: {number_obj}")

    async def start_ble_scanning(self):
        """Start scanning and connect to the BLE device based on settings."""
        _LOGGER.debug(f"{LOGGING_PREFIX}[start_ble_scanning] Searching for {self.ble_server_name} or {self.ble_server_address}")

        try:
            # Start BLE device discovery
            devices = await self._scanner.discover(timeout=BLE_SCANNING_TIMEOUT)
            
            # Check if devices were found
            if not devices:
                _LOGGER.error(f"{LOGGING_PREFIX}[start_ble_scanning] No BLE devices found.")
                return

            # Search for the device by address or name
            for device in devices:
                if self.connect_using_address and device.address == self.ble_server_address:
                    _LOGGER.debug(f"{LOGGING_PREFIX}[start_ble_scanning] Found device by MAC: {device.address}")
                    await self.connect_to_device(device)
                    return
                elif not self.connect_using_address and device.name == self.ble_server_name:
                    _LOGGER.debug(f"{LOGGING_PREFIX}[start_ble_scanning] Found device by Name: {device.name}")
                    await self.connect_to_device(device)
                    return

            _LOGGER.error(f"{LOGGING_PREFIX}[start_ble_scanning] Target device not found.")

        except asyncio.TimeoutError:
            # Handle timeout during scanning
            _LOGGER.error(f"{LOGGING_PREFIX}[start_ble_scanning] BLE scanning timed out.")
        except Exception as e:
            # General exception handler for any other errors
            _LOGGER.error(f"{LOGGING_PREFIX}[start_ble_scanning] Error during BLE scanning: {e}")

    async def connect_to_device(self, device):
        """Connect to the BLE device and enable notifications."""
        self._client = BleakClient(device.address)
        try:
            if await self._client.connect():
                _LOGGER.debug(f"{LOGGING_PREFIX}[connect_to_device] Connected to {device.address}")
                self._is_connected = True
                await self.write_led_state(CMD_LED_GREEN, 1)
                
                # Enable notifications for sensor data
                await self._client.start_notify(CHARACTERISTICS_UUID, self.handle_notify)

                # Start monitoring the connection
                if self._reconnect_task is None:
                    self._reconnect_task = asyncio.create_task(self._monitor_connection())

        except Exception as e:
            self._is_connected = False
            await self.write_led_state(CMD_LED_GREEN, 0)
            _LOGGER.error(f"{LOGGING_PREFIX}[connect_to_device] Failed to connect to {device.address}: {e}")

    async def _monitor_connection(self):
        """Monitor BLE connection and attempt reconnection if lost."""
        retry_delay = 5  # Start with a 5-second delay
        max_delay = 60  # Cap the delay to 60 seconds
        
        while True:
            await asyncio.sleep(retry_delay)
            
            if self._client and not self._client.is_connected:
                _LOGGER.warning(f"{LOGGING_PREFIX}[monitor_connection] BLE connection lost! Attempting to reconnect...")
                self._is_connected = False
                await self.write_led_state(CMD_LED_GREEN, 0)

                # Close the existing client properly
                try:
                    await self._client.disconnect()
                except Exception as e:
                    _LOGGER.warning(f"{LOGGING_PREFIX}[monitor_connection] Error closing client: {e}")

                # Attempt to reconnect
                await self.start_ble_scanning()

                if self._is_connected:
                    _LOGGER.info(f"{LOGGING_PREFIX}[monitor_connection] Reconnection successful!")
                    retry_delay = 5  # Reset delay on successful reconnection
                else:
                    retry_delay = min(retry_delay * 2, max_delay)  # Exponential backoff
                    _LOGGER.warning(f"{LOGGING_PREFIX}[monitor_connection] Retrying in {retry_delay} seconds...")

    async def reconnect(self):
        """Reconnect to the BLE server."""
        if self._client and not self._client.is_connected:
            _LOGGER.debug(f"{LOGGING_PREFIX}[reconnect] Reconnecting...")
            await self._client.connect()
            self._is_connected = True

    async def force_reconnect(self):
        """Forcefully reconnect to the BLE device."""
        if self._client and self._client.is_connected:
            _LOGGER.debug(f"{LOGGING_PREFIX}[force_reconnect] Already connected, disconnecting first...")
            await self._client.disconnect()

        _LOGGER.debug(f"{LOGGING_PREFIX}[force_reconnect] Attempting to reconnect...")
        await self.start_ble_scanning()


    def is_connected(self) -> bool:
        """Check if the BLE client is connected to the server."""
        return self._client is not None and self._client.is_connected

    def get_sensor_data(self, sensor_type: str):
        """Retrieve the latest sensor data for the given sensor type."""
        return self._sensor_data.get(sensor_type, None)

    async def handle_notify(self, characteristic, data):
        """Handle BLE notifications."""
        _LOGGER.debug(f"{LOGGING_PREFIX}[handle_notify] Notification received from {characteristic.uuid}: {data}")
        if characteristic.uuid.lower() == CHARACTERISTICS_UUID.lower():
            await self.process_data(characteristic, data)

    async def process_data(self, characteristic, data):
        """Process received BLE data."""
        _LOGGER.debug(f"{LOGGING_PREFIX}[process_data] {characteristic}: {data}")
        try:
            # Get the raw values using little-endian
            temperature_raw, humidity_raw = struct.unpack("<HH", data)

            # Parse the raw values
            temperature = temperature_raw / 100.0
            humidity = humidity_raw / 100.0

            _LOGGER.info(f"{LOGGING_PREFIX}[process_data] Received Temperature: {temperature}°C, Humidity: {humidity}%")

            # Store sensor data
            self._sensor_data[SENSOR_TEMPERATURE_TYPE] = temperature
            self._sensor_data[SENSOR_HUMIDITY_TYPE] = humidity

        except Exception as e:
            _LOGGER.error(f"{LOGGING_PREFIX}[process_data] Error processing data: {e}")

    #
    # BLE Write Functions to the connected client
    #

    async def write_led_state(self, led: int, state: int):
        """Write LED state (on/off) to BLE server."""
        self._led_state = state          # Store led state 0 or 1

        if self._client is None or not self._client.is_connected:
            _LOGGER.error(f"{LOGGING_PREFIX}[write_led_state] Not connected to BLE server.")
            return

        try:
            _LOGGER.debug(f"{LOGGING_PREFIX} Writing LED {led} state to {BLE_SERVER_ADDRESS}")
            stateBytes = bytearray([led, state])
            await asyncio.sleep(0.1)
            await self._client.write_gatt_char(CHARACTERISTICS_UUID, stateBytes)
            _LOGGER.info(f"{LOGGING_PREFIX}[write_led_state] LED state written: " + ", ".join(f"0x{b:02X}" for b in stateBytes))

        except Exception as e:
            _LOGGER.error(f"{LOGGING_PREFIX}[write_led_state] Failed to write LED state: {e}")

    async def write_timer_value(self, value: float):
        """Write timer value 0-60 to BLE server."""
        self._timer_value = int(value)        # Store timer value 0-60
        
        _LOGGER.error(f"{LOGGING_PREFIX}[write_timer_value] value={value}")
        if self._client is None or not self._client.is_connected:
            _LOGGER.error(f"{LOGGING_PREFIX}[write_timer_value] Not connected to BLE server.")
            return

        try:
            _LOGGER.debug(f"{LOGGING_PREFIX}[write_timer_value] Writing to {BLE_SERVER_ADDRESS}")
            # Convert the value from float to int
            valueInt = int(value)
            # Convert the value int to bytearray
            valueBytes = bytearray([CMD_TIMER, valueInt])
            await asyncio.sleep(0.1)
            # Send the byte array
            await self._client.write_gatt_char(CHARACTERISTICS_UUID, valueBytes)
            _LOGGER.info(f"{LOGGING_PREFIX}[write_timer_value] Value {valueInt} written: " + ", ".join(f"0x{b:02X}" for b in valueBytes))

        except Exception as e:
            _LOGGER.error(f"{LOGGING_PREFIX}[write_timer_value] Failed to write timer value: {e}")
