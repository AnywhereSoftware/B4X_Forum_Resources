# sensor.py
import logging
import struct

from homeassistant.components.sensor import SensorEntity
from homeassistant.const import UnitOfTemperature, PERCENTAGE
from homeassistant.core import HomeAssistant
from homeassistant.config_entries import ConfigEntry
from homeassistant.helpers.typing import DiscoveryInfoType
from homeassistant.helpers.entity_platform import AddEntitiesCallback
from homeassistant.helpers import entity_platform
from homeassistant.components.bluetooth import (
    BluetoothServiceInfoBleak,
    BluetoothChange,
    async_register_callback,
)

# Import custom component constants
from .const import (LOGGING_PREFIX, DOMAIN, DEVICE_NAME, SERVICE_UUID, SENSOR_REGISTRY, DATA_FIELD_LENGTH,
    SENSOR_TYPE_TEMPERATURE, SENSOR_TYPE_HUMIDITY, SENSOR_TYPE_TEMPERATURE_STATE, SENSOR_TYPE_HUMIDITY_STATE)

_LOGGER = logging.getLogger(__name__)

class BLEBaseSensor(SensorEntity):
    """Base class for BLE sensors."""

    def __init__(self, name, unit, device_class, unique_id):
        self._attr_name = name
        self._attr_native_unit_of_measurement = unit
        self._attr_device_class = device_class
        self._attr_unique_id = unique_id
        self._attr_native_value = None
        self._attr_available = False  # Assume unavailable until data is received

    @property
    def available(self):
        """Return whether the sensor is available."""
        return self._attr_available

    def update_value(self, value):
        """Update the sensor value."""
        if self._attr_native_value != value:
            _LOGGER.debug(f"{LOGGING_PREFIX} Updating {self._attr_name} to {value}")
            self._attr_native_value = value
            self._attr_available = True  # Mark sensor as available
            self.async_write_ha_state()
        else:
            _LOGGER.debug(f"{LOGGING_PREFIX} No change in value for {self._attr_name}")


class TemperatureSensor(BLEBaseSensor):
    """Temperature sensor entity."""

    def __init__(self, name):
        super().__init__(name, UnitOfTemperature.CELSIUS, SENSOR_TYPE_TEMPERATURE, f"{name.replace(' ', '_').lower()}_temperature")


class HumiditySensor(BLEBaseSensor):
    """Humidity sensor entity."""

    def __init__(self, name):
        super().__init__(name, PERCENTAGE, SENSOR_TYPE_HUMIDITY, f"{name.replace(' ', '_').lower()}_humidity")


class TemperatureStateSensor(BLEBaseSensor):
    """Numeric entity for temperature state."""

    def __init__(self, name):
        super().__init__(name, None, None, f"{name.replace(' ', '_').lower()}_temperature_state")


class HumidityStateSensor(BLEBaseSensor):
    """Numeric entity for humidity state."""

    def __init__(self, name):
        super().__init__(name, None, None, f"{name.replace(' ', '_').lower()}_humidity_state")


async def handle_ble_data(hass, service_info: BluetoothServiceInfoBleak, change_type: BluetoothChange):
    """Handle BLE advertisement data and update sensors."""
    _LOGGER.debug(f"{LOGGING_PREFIX} Received BLE data: {service_info}")

    # Check if the device name is found
    if service_info.name != DEVICE_NAME:
        # _LOGGER.debug(f"{LOGGING_PREFIX} Ignoring device: {service_info.name}")
        return

    # Get the raw data from the advertised service info
    # name=BLEBEACONDHT address=30:C9:22:D1:80:2E manufacturer_data={} service_data={'0000181a-0000-1000-8000-00805f9b34fb': b'\x94\x07\xea\x15\x03\x01'}
    raw_data = service_info.service_data.get(SERVICE_UUID)
    if raw_data is None or len(raw_data) < DATA_FIELD_LENGTH:
        _LOGGER.warning("{LOGGING_PREFIX} No valid service data found.")
        return

    _LOGGER.debug(f"{LOGGING_PREFIX} Raw data received: {raw_data.hex()}")

    try:
        temperature_raw, humidity_raw, temperature_state, humidity_state = struct.unpack("<HHBB", raw_data)

        temperature = temperature_raw / 100.0
        humidity = humidity_raw / 100.0

        #[BLE_BEACON_DHT] Parsed Temperature: 19.4°C, Humidity: 56.1%, Temperature State: 3, Humidity State: 1
        _LOGGER.info(f"{LOGGING_PREFIX} Parsed Temperature: {temperature}°C, Humidity: {humidity}%, "
                     f"Temperature State: {temperature_state}, Humidity State: {humidity_state}")

        # Access the sensor registry       
        # Use setdefault to guarantee that hass.data[SENSOR_REGISTRY] always exists
        sensor_registry = hass.data.setdefault(DOMAIN, {}).get(SENSOR_REGISTRY, {})

        sensor_updates = {
            SENSOR_TYPE_TEMPERATURE: temperature,
            SENSOR_TYPE_HUMIDITY: humidity,
            SENSOR_TYPE_TEMPERATURE_STATE: temperature_state,
            SENSOR_TYPE_HUMIDITY_STATE: humidity_state
        }

        for sensor_type, value in sensor_updates.items():
            sensor = sensor_registry.get(sensor_type)
            if sensor:
                _LOGGER.debug(f"{LOGGING_PREFIX} Updating sensor: {sensor._attr_name}")
                sensor.update_value(value)
            else:
                _LOGGER.warning(f"{LOGGING_PREFIX} Sensor for {sensor_type} not found.")

    except struct.error as e:
        _LOGGER.error(f"{LOGGING_PREFIX} Error unpacking BLE data: {e}")
    except Exception as e:
        _LOGGER.error(f"{LOGGING_PREFIX} Unexpected error parsing BLE data: {e}")


async def async_setup_entry(hass: HomeAssistant, entry: ConfigEntry, async_add_entities: AddEntitiesCallback) -> bool:
    """Set up sensors from a config entry."""
    _LOGGER.info("{LOGGING_PREFIX} Initializing BLE sensors via UI configuration.")

    sensor_registry = hass.data.setdefault(DOMAIN, {}).setdefault(SENSOR_REGISTRY, {})
    sensors = []

    sensor_classes = {
        SENSOR_TYPE_TEMPERATURE: TemperatureSensor,
        SENSOR_TYPE_HUMIDITY: HumiditySensor,
        SENSOR_TYPE_TEMPERATURE_STATE: TemperatureStateSensor,
        SENSOR_TYPE_HUMIDITY_STATE: HumidityStateSensor,
    }

    for sensor_type, sensor_class in sensor_classes.items():
        # The sensor type has suffix _name as set in config_flow.py
        sensor_name = entry.data.get(f"{sensor_type}_name", f"BLE {sensor_type.replace('_', ' ').title()}")
        _LOGGER.debug(f"{LOGGING_PREFIX} Sensor name for {sensor_type}: {sensor_name}")
        
        if sensor_type not in sensor_registry:
            sensor = sensor_class(name=sensor_name)
            sensors.append(sensor)
            sensor_registry[sensor_type] = sensor

    async_add_entities(sensors, update_before_add=True)

    # Ensure the sensor registry is stored in the correct domain
    hass.data[DOMAIN][SENSOR_REGISTRY] = sensor_registry

    # Register the BLE advertisement callback
    async_register_callback(
        hass,
        lambda service_info, change: hass.async_create_task(handle_ble_data(hass, service_info, change)),
        {"name": DEVICE_NAME},
        BluetoothChange.ADVERTISEMENT,
    )

    _LOGGER.info("{LOGGING_PREFIX} BLE advertisement listener registered via UI config.")
    return True
