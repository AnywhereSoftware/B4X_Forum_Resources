"""Definition of constants for BLE Server DHT integration.

All constants to be defined here and import in module using:
from .const import (DOMAIN,)

const.py
"""

# Logging prefix
LOGGING_PREFIX = "[BLE_SERVER_DHT]"

# Domain used for the configuration
DOMAIN = "ble_server_dht"

# BLE
# Servername is set in the B4R program.
BLE_SERVER_NAME = "BLEServer"
# Serveraddress taken from Bluetooth scanner tool, like BLE Scanner
BLE_SERVER_ADDRESS = "30:C9:22:D1:80:2E"
BLE_SERVER_REGISTRY = "ble_server_dht"
BLE_CONNECT_USING_ADDRESS = "Use BLE Server Address"
BLE_SCANNING_TIMEOUT = 30 # seconds

# UUID (must be lowercase)
SERVICE_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
# UUID to notify,read,write
CHARACTERISTICS_UUID = "6e400002-b5a3-f393-e0a9-e50e24dcca9e"

# Configuration UI
CONFIG_TITLE = "BLE Server DHT"

# Sensors
SENSOR_TEMPERATURE_TYPE = "temperature"
SENSOR_TEMPERATURE_NAME = "Room Temperature"

SENSOR_HUMIDITY_TYPE = "humidity"
SENSOR_HUMIDITY_NAME = "Room Humidity"

SENSOR_BLECONNECTION_TYPE = "binary_sensor"
SENSOR_BLECONNECTION_NAME = "BLE Connection"

# Switches
SWITCH_LED_TYPE = "power"
SWITCH_LED_NAME = "LED Indicator"
SWITCH_LED_STATE_DEFAULT = 0

# Number
NUMBER_TIMER_TYPE = "number"
NUMBER_TIMER_NAME = "Timer Advertising"
NUMBER_TIMER_DEFAULT_VALUE = 30 # seconds
NUMBER_TIMER_MAX_VALUE = 60 # seconds
NUMBER_TIMER_STEP = 5

# Commands send to the BLE Server ESP32
CMD_LED_RED     = 1     # set led red state 0=off,1=on, command byte array (0x) 0100 or 0101
CMD_LED_YELLOW  = 2     # set led yellow
CMD_LED_GREEN   = 3     # set led green
CMD_TIMER       = 4     # set timer interval in seconds reading DHT22 sensor values 
