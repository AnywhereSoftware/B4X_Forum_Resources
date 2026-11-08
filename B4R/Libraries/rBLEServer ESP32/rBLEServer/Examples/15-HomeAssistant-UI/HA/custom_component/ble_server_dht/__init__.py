"""Init the BLE Server DHT integration.

Setup of BLE client instance and connection to the BLE server.
Setup of platforms, like sensor, switch, number.
The entities are defined in mandatory files sensor.py, switch.py, number.py.

__init__.py
"""
import logging
import asyncio

from homeassistant.config_entries import ConfigEntry
from homeassistant.core import HomeAssistant

from .ble_client import BLEClient

from .const import (
    LOGGING_PREFIX, 
    DOMAIN, 
    BLE_SERVER_REGISTRY,
    BLE_SCANNING_TIMEOUT
    )

_LOGGER = logging.getLogger(__name__)

async def async_setup_entry(hass: HomeAssistant, entry: ConfigEntry):
    """Set up the BLE Server DHT integration."""
    hass.data.setdefault(DOMAIN, {})
    
    # Create and store a global BLEClient instance
    ble_client = BLEClient(hass, entry.data)
    hass.data[DOMAIN][BLE_SERVER_REGISTRY] = ble_client  

    # Forward setup of platforms (sensor, switch, number etc.)
    # Ensure the files are in the custom folder, i.e. sensor.py (custom_components.ble_server_dht.sensor)
    await hass.config_entries.async_forward_entry_setups(entry, ["sensor", "switch", "number"])

    # Start scanning and connecting to the BLE server
    _LOGGER.debug(f"{LOGGING_PREFIX}[async_setup_entry] Starting BLE scan for devices...")
    try:
        # Start BLE scanning with 30s (default) timeout
        await asyncio.wait_for(ble_client.start_ble_scanning(), timeout=BLE_SCANNING_TIMEOUT)
    except asyncio.TimeoutError:
        _LOGGER.error(f"{LOGGING_PREFIX}[async_setup_entry] BLE scanning timed out.")
        return False
    except Exception as e:
        _LOGGER.error(f"{LOGGING_PREFIX}[async_setup_entry] Failed to start BLE scanning: {e}")
        return False

    return True
