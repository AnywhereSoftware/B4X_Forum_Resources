"""Handle the config flow for BLE Server DHT integration.

UI based configuration of the BLE server name & MAC address.
Option to use the name or MAC address for BLE server connection.
Set the name of the entities for the temperature, humidity, LED switch, timer advertising.

config_flow.py
"""
import logging
import voluptuous as vol

from homeassistant import config_entries
from homeassistant.core import callback

from .const import (
    LOGGING_PREFIX,
    DOMAIN, 
    CONFIG_TITLE, 
    BLE_SERVER_NAME,
    BLE_SERVER_ADDRESS,
    BLE_CONNECT_USING_ADDRESS,
    SENSOR_TEMPERATURE_NAME,
    SENSOR_HUMIDITY_NAME,
    SWITCH_LED_NAME,
    NUMBER_TIMER_NAME,
)

_LOGGER = logging.getLogger(__name__)

class BLEServerDHTConfigFlow(config_entries.ConfigFlow, domain=DOMAIN):
    """Handle a config flow for BLE Server DHT integration."""

    # The schema version of the entries that it creates
    # Home Assistant will call your migrate method if the version changes
    VERSION = 1
    MINOR_VERSION = 1

    async def async_step_user(self, user_input=None):
        """Handle the initial step."""
        _LOGGER.debug(f"{LOGGING_PREFIX} Starting config flow user step.")

        errors = {}

        if user_input is not None:
            _LOGGER.debug(f"{LOGGING_PREFIX}[async_step_user] Received options input: {user_input}")
            # Save the user input data to the config entry
            return self.async_create_entry(title=CONFIG_TITLE, data=user_input)

        # Define the data scheme
        # Parameter default not used because defined in const.py (i.e. default="Temperature")
        data_schema = vol.Schema(
            {
                vol.Required(BLE_SERVER_NAME): str,
                vol.Required(BLE_SERVER_ADDRESS): str,
                vol.Required(BLE_CONNECT_USING_ADDRESS): bool,  
                vol.Required(SENSOR_TEMPERATURE_NAME): str,
                vol.Required(SENSOR_HUMIDITY_NAME): str,
                vol.Required(SWITCH_LED_NAME): str,
                vol.Required(NUMBER_TIMER_NAME): str,  
            }
        )

        return self.async_show_form(step_id="user", data_schema=data_schema, errors=errors)

    @staticmethod
    @callback
    def async_get_options_flow(entry):
        """Return the options flow handler."""
        return BLEServerDHTOptionsFlowHandler(entry)

class BLEServerDHTOptionsFlowHandler(config_entries.OptionsFlow):
    """Handle options flow for BLE Server DHT."""

    def __init__(self, entry):
        self.entry = entry

    async def async_step_init(self, user_input=None):
        """Manage the options."""
        errors = {}
        if user_input is not None:
            _LOGGER.debug(f"{LOGGING_PREFIX}[async_step_init] Received options input: {user_input}")

            # Update the entry with the new options using async_update_entry
            new_data = {**self.entry.data, **user_input}  # Merge existing data with new options

            # Update the configuration entry
            self.hass.config_entries.async_update_entry(self.entry, data=new_data)

            return self.async_create_entry(title=CONFIG_TITLE, data=new_data)

        # Define the data scheme
        # Parameter default not used because defined in const.py (i.e. default="Temperature")
        data_schema = vol.Schema(
            {
                vol.Required(BLE_SERVER_NAME): str,
                vol.Required(BLE_SERVER_ADDRESS): str,
                vol.Required(BLE_CONNECT_USING_ADDRESS): bool,  
                vol.Required(SENSOR_TEMPERATURE_NAME): str,
                vol.Required(SENSOR_HUMIDITY_NAME): str,
                vol.Required(SWITCH_LED_NAME): str,
                vol.Required(NUMBER_TIMER_NAME): str,  
            }
        )

        return self.async_show_form(step_id="init", data_schema=data_schema, errors=errors)
