"""Setup of a number entity for BLE Server DHT integration.

The number entity controls the BLE server advertising interval for the environment data temperature & humidity.
The interval can be set via the UI slider with range 0-60 seconds (see const.py).
When changing the slider, the new interval is sent to the BLE server using the BLE client.

number.py
"""
import logging

from homeassistant.components.number import NumberEntity, NumberEntityDescription
from homeassistant.const import UnitOfTime

from .ble_client import BLEClient

from .const import (
    LOGGING_PREFIX,
    DOMAIN,
    BLE_SERVER_REGISTRY,
    NUMBER_TIMER_TYPE,
    NUMBER_TIMER_NAME,
    NUMBER_TIMER_DEFAULT_VALUE,
    NUMBER_TIMER_MAX_VALUE,
    NUMBER_TIMER_STEP,
)

_LOGGER = logging.getLogger(__name__)

async def async_setup_entry(hass, entry, async_add_entities):
    """Set up the number entity."""
    
    # Retrieve BLEClient instance
    ble_client = hass.data.setdefault(DOMAIN, {}).setdefault(BLE_SERVER_REGISTRY, {})

    # Initialize the timer number entity with entry
    timer_number = TimerNumber(ble_client, entry)

    # Register the number in BLE client
    ble_client.register_number(NUMBER_TIMER_TYPE, timer_number)

    # Add the entity to Home Assistant
    async_add_entities([timer_number], update_before_add=True)
    _LOGGER.debug(f"{LOGGING_PREFIX}[async_setup_entry][TimerNumber] timer_number added, min_value={timer_number.entity_description.native_min_value}, max_value={timer_number.entity_description.native_max_value}")

class TimerNumber(NumberEntity):
    """Representation of a BLE Number Entity."""

    _attr_should_poll = False  # No need to poll; updates are pushed

    def __init__(self, ble_client: BLEClient, entry):
        """Initialize the number entity."""
        self._client = ble_client
        self._entry = entry

        # Set entity description correctly
        self.entity_description = NumberEntityDescription(
            key=NUMBER_TIMER_TYPE,
            name=NUMBER_TIMER_NAME,
            native_min_value=0,
            native_max_value=NUMBER_TIMER_MAX_VALUE,
            native_step=NUMBER_TIMER_STEP,
            native_unit_of_measurement=UnitOfTime.SECONDS,
        )

        self._attr_unique_id = f"{entry.entry_id}_timer_advertising"
        self._attr_native_value = NUMBER_TIMER_DEFAULT_VALUE  # Ensure it's set

    @property
    def native_value(self) -> float:
        """Return the current value of the number."""
        return self._attr_native_value  # Always return the internal value

    async def async_set_native_value(self, value: float) -> None:
        """Set the value of the number entity."""
        _LOGGER.debug(f"{LOGGING_PREFIX}[async_set_native_value][TimerNumber] Setting value to {value}")
        self._attr_native_value = value
        await self._client.write_timer_value(value)
        self.async_write_ha_state()

    async def async_update_state(self, value: float):
        """Update the state when a new value is received (e.g., from BLE)."""
        _LOGGER.debug(f"{LOGGING_PREFIX}[async_update_state][TimerNumber] Received value={value}")
        self._attr_native_value = value
        self.async_write_ha_state()
