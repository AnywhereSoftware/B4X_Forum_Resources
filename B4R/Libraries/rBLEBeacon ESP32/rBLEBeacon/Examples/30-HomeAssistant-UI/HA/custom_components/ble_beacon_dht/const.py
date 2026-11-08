# const.py
# Constants for BLE Beacon DHT Integration

# Domain used for the configuration
DOMAIN = "ble_beacon_dht"

# Service UUID (must be lowercase) used to parse the data advertised by B4R.
# HA Log snippet:
# [BLE_BEACON_DHT] Received BLE data: name=BLEBEACONDHT address=30:C9:22:D1:80:2E rssi=-71 manufacturer_data={} service_data={'0000181a-0000-1000-8000-00805f9b34fb': b'0\x07\xc0&'} service_uuids=['0000181a-0000-1000-8000-00805f9b34fb'] 
SERVICE_UUID = '0000181a-0000-1000-8000-00805f9b34fb'

# Name of the device as set in B4R method appstart.
# Example: BLEBeacon.Initialize("BLEBEACONDHT", "BLEBeacon_Error")
# The name is used to select the device from the BLE advertised data received.
DEVICE_NAME = 'BLEBEACONDHT'

# Sensor types
SENSOR_REGISTRY                     = "ble_beacon_dht_sensors"
SENSOR_TYPE_TEMPERATURE             = "temperature"
SENSOR_TYPE_HUMIDITY                = "humidity"
SENSOR_TYPE_TEMPERATURE_STATE       = "temperature_state"
SENSOR_TYPE_HUMIDITY_STATE          = "humidity_state"

# Sensor names
SENSOR_NAME_TEMPERATURE             = "temperature_name"
SENSOR_NAME_HUMIDITY                = "humidity_name"
SENSOR_NAME_TEMPERATURE_STATE       = "temperature_state_name"
SENSOR_NAME_HUMIDITY_STATE          = "humidity_state_name"

SENSOR_LOCATION_TEMPERATURE          = "Room Temperature"
SENSOR_LOCATION_HUMIDITY             = "Room Humidity"
SENSOR_LOCATION_TEMPERATURE_STATE    = "Room Temperature State"
SENSOR_LOCATION_HUMIDITY_STATE       = "Room Humidity State"

CONFIG_TITLE = "BLE Beacon DHT"

# Length of the advertised data received = 6 bytes <HHBB
DATA_FIELD_LENGTH = 6

# Other constants
DEFAULT_SENSOR_NAME = "BLE Sensor DHT"

# Logging prefix
LOGGING_PREFIX = "[BLE_BEACON_DHT]"
