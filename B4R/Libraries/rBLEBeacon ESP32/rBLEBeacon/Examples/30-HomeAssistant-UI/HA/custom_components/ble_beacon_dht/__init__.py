# __init__.py
import logging

from homeassistant.core import HomeAssistant
from homeassistant.config_entries import ConfigEntry
from .sensor import async_setup_entry

# Import custom component constants
from .const import DOMAIN

_LOGGER = logging.getLogger(__name__)

async def async_setup(hass: HomeAssistant, config: dict) -> bool:
    """Set up the BLE Beacon DHT integration."""
    hass.data[DOMAIN] = {}
    return True

async def async_setup_entry(hass: HomeAssistant, entry: ConfigEntry) -> bool:
    """Set up the integration from a config entry."""
    hass.data.setdefault(DOMAIN, {})
    await hass.config_entries.async_forward_entry_setups(entry, ["sensor"])
    return True
