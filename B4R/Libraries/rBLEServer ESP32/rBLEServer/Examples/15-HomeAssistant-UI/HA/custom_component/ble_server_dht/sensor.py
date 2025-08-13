"""Setup of sensor entities for BLE Server DHT integration.

Two entities temperature (T) & humidity (H) are updated from BLE server advertisements.
The data is advertised as 4 bytes holding 2 integers for T & H.

sensor.py
"""
import logging
from datetime import timedelta

from homeassistant.components.sensor import SensorEntity, SensorDeviceClass
from homeassistant.components.binary_sensor import BinarySensorEntity, BinarySensorDeviceClass
from homeassistant.const import UnitOfTemperature, PERCENTAGE
from homeassistant.core import HomeAssistant
from homeassistant.config_entries import ConfigEntry
from homeassistant.helpers.typing import DiscoveryInfoType
from homeassistant.helpers.entity_platform import AddEntitiesCallback
from homeassistant.helpers.update_coordinator import DataUpdateCoordinator, CoordinatorEntity

from .ble_client import BLEClient

from .const import (
    LOGGING_PREFIX, 
    DOMAIN, 
    BLE_SERVER_REGISTRY, 
    SENSOR_TEMPERATURE_TYPE,
    SENSOR_TEMPERATURE_NAME,
    SENSOR_HUMIDITY_TYPE,
    SENSOR_HUMIDITY_NAME,
    SENSOR_BLECONNECTION_NAME,
)

_LOGGER = logging.getLogger(__name__)

async def async_setup_entry(hass: HomeAssistant, entry: ConfigEntry, async_add_entities: AddEntitiesCallback) -> bool:
    """Set up sensors and binary sensors with the BLE data update coordinator."""

    # Retrieve or create BLEClient instance
    ble_client = hass.data.setdefault(DOMAIN, {}).setdefault(BLE_SERVER_REGISTRY, {})

    # Create a data update coordinator
    coordinator = BLEDataUpdateCoordinator(hass, ble_client)
    await coordinator.async_config_entry_first_refresh()

    # Register each sensor in the BLE client
    ble_client.register_sensor(SENSOR_TEMPERATURE_TYPE, TemperatureSensor(coordinator, entry))
    ble_client.register_sensor(SENSOR_HUMIDITY_TYPE, HumiditySensor(coordinator, entry))
    ble_client.register_sensor(SENSOR_BLECONNECTION_NAME, BLEConnectionSensor(coordinator, entry))

    # Create sensor and binary sensor entities linked to the coordinator
    sensors = [
        TemperatureSensor(coordinator, entry),
        HumiditySensor(coordinator, entry),
        BLEConnectionSensor(coordinator, entry),
    ]
    
    async_add_entities(sensors, update_before_add=True)
    _LOGGER.debug(f"{LOGGING_PREFIX}[async_setup_entry] Sensor entities added.")

    return True


class BLEDataUpdateCoordinator(DataUpdateCoordinator):
    """Coordinator to manage BLE sensor data updates."""

    def __init__(self, hass: HomeAssistant, ble_client):
        """Initialize the data update coordinator."""
        super().__init__(
            hass,
            _LOGGER,
            name="BLE Sensor Data",
            update_interval=timedelta(seconds=10),  # Adjust polling interval as needed
        )
        self.ble_client = ble_client

    async def _async_update_data(self):
        """Fetch latest data from the BLE client."""
        try:
            is_connected = self.ble_client.is_connected()
            temperature = self.ble_client.get_sensor_data(SENSOR_TEMPERATURE_TYPE)
            humidity = self.ble_client.get_sensor_data(SENSOR_HUMIDITY_TYPE)
            _LOGGER.debug(f"{LOGGING_PREFIX}[BLEDataUpdateCoordinator] Received data - Connection: {is_connected}, Temperature: {temperature}, Humidity: {humidity}")
            return {
                "connected": is_connected,
                SENSOR_TEMPERATURE_TYPE: temperature,
                SENSOR_HUMIDITY_TYPE: humidity
            }
        except Exception as e:
            _LOGGER.error(f"{LOGGING_PREFIX}[BLEDataUpdateCoordinator] Error fetching BLE sensor data: {e}")
            return {}

class BLEBaseSensor(CoordinatorEntity, SensorEntity):
    """Base class for BLE sensors using a DataUpdateCoordinator."""

    def __init__(self, coordinator: BLEDataUpdateCoordinator, entry: ConfigEntry, sensor_type: str, name: str, unit, device_class):
        """Initialize the sensor."""
        super().__init__(coordinator)
        self._attr_name = name
        self._attr_unique_id = f"{entry.entry_id}_{sensor_type}"
        self._attr_native_unit_of_measurement = unit
        self._attr_device_class = device_class
        self._sensor_type = sensor_type

    @property
    def native_value(self):
        """Return the latest sensor value."""
        return self.coordinator.data.get(self._sensor_type)

    async def async_update_state(self):
        """Manually trigger state update."""
        self.async_write_ha_state()
        
class TemperatureSensor(BLEBaseSensor):
    """Representation of a BLE Temperature Sensor."""

    def __init__(self, coordinator, entry):
        """Initialize the sensor."""
        super().__init__(
            coordinator,
            entry,
            SENSOR_TEMPERATURE_TYPE,
            SENSOR_TEMPERATURE_NAME,
            UnitOfTemperature.CELSIUS,
            SensorDeviceClass.TEMPERATURE,
        )


class HumiditySensor(BLEBaseSensor):
    """Representation of a BLE Humidity Sensor."""

    def __init__(self, coordinator, entry):
        """Initialize the sensor."""
        super().__init__(
            coordinator,
            entry,
            SENSOR_HUMIDITY_TYPE,
            SENSOR_HUMIDITY_NAME,
            PERCENTAGE,
            SensorDeviceClass.HUMIDITY,
        )


class BLEConnectionSensor(CoordinatorEntity, BinarySensorEntity):
    """Binary sensor to monitor BLE connection state."""

    def __init__(self, coordinator: BLEDataUpdateCoordinator, entry: ConfigEntry):
        """Initialize the BLE connection sensor."""
        super().__init__(coordinator)
        self._attr_name = SENSOR_BLECONNECTION_NAME
        self._attr_unique_id = f"{entry.entry_id}_ble_connection"
        self._attr_device_class = BinarySensorDeviceClass.CONNECTIVITY

    @property
    def is_on(self) -> bool:
        """Return true if BLE is connected."""
        return self.coordinator.data.get("connected", False)

