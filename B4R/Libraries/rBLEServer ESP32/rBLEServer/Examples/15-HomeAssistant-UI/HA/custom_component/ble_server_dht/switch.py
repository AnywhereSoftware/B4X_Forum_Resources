"""Setup of switches entity for BLE Server DHT integration.

The switch sets the state of the BLE server traffic-light LED yellow.
When changing the switch state, the new state is sent to the BLE server using the BLE client.
For the UI an extra_state_attribute "friendly_state" is defined to show ON,OFF instead 1,0.

switch.py
"""
import logging
import asyncio

from homeassistant.components.switch import SwitchEntity
from homeassistant.components.binary_sensor import BinarySensorEntity
from homeassistant.core import HomeAssistant
from homeassistant.components.persistent_notification import async_create

from .ble_client import BLEClient

from .const import (
    LOGGING_PREFIX,
    DOMAIN, 
    BLE_SERVER_REGISTRY,
    SWITCH_LED_TYPE,
    SWITCH_LED_NAME,
    CMD_LED_RED, CMD_LED_YELLOW, CMD_LED_GREEN,
    CMD_TIMER,
    )

_LOGGER = logging.getLogger(__name__)

async def async_setup_entry(hass, entry, async_add_entities):
    """Set up BLE switches."""

    # Retrieve BLEClient instance
    ble_client = hass.data.setdefault(DOMAIN, {}).setdefault(BLE_SERVER_REGISTRY, {})
 
    # LED Switch
    led_switch = LEDSwitch(ble_client, entry)
    ble_client.register_switch(SWITCH_LED_TYPE, led_switch)
    
    # Add switches to HA
    async_add_entities([led_switch], update_before_add=True)
    await asyncio.sleep(1)  # Give HA time to process
    _LOGGER.debug(f"{LOGGING_PREFIX}[async_setup_entry] Add entities done")

class LEDSwitch(SwitchEntity):
    """Representation of a BLE LED Switch."""

    def __init__(self, ble_client: BLEClient, entry):
        """Initialize the switch."""
        self._attr_unique_id = f"{entry.entry_id}_led_indicator"
        self._attr_name = SWITCH_LED_NAME
        self._attr_is_on = False
        self._ble_client = ble_client

    @property
    def unique_id(self):
        return self._attr_unique_id

    @property
    def name(self):
        return self._attr_name

    @property
    def is_on(self):
        """Return the state of the switch."""
        return self._attr_is_on

    @property
    def state(self) -> int:
        """Return switch state as an integer (1 for ON, 0 for OFF)."""
        return 1 if self._attr_is_on else 0

    @property
    def extra_state_attributes(self):
        """Return additional state attributes."""
        return {
            "friendly_state": "ON" if self._attr_is_on else "OFF"
        }
                
    async def async_added_to_hass(self):
        """Confirm LEDSwitch is added to HA."""
        _LOGGER.debug(f"{LOGGING_PREFIX}[LEDSwitch] Added to HA: entity_id={self.entity_id}, unique_id={self._attr_unique_id}")

    async def async_turn_on(self, **kwargs):
        """Turn the switch on."""
        _LOGGER.debug(f"{LOGGING_PREFIX}[async_turn_on] Switch Turning ON")
        self._attr_is_on = True
        await self._ble_client.write_led_state(CMD_LED_YELLOW, 1)
        self.async_write_ha_state()

    async def async_turn_off(self, **kwargs):
        """Turn the switch off."""
        _LOGGER.debug(f"{LOGGING_PREFIX}[async_turn_off] Switch Turning OFF")
        self._attr_is_on = False
        await self._ble_client.write_led_state(CMD_LED_YELLOW, 0)
        self.async_write_ha_state()

    async def async_update_state(self, value: bool):
        """Update the switch state when BLE advertisement is received."""
        _LOGGER.debug(f"{LOGGING_PREFIX}[async_update_state] state={value}")
        self._attr_is_on = value
        self.async_write_ha_state()
