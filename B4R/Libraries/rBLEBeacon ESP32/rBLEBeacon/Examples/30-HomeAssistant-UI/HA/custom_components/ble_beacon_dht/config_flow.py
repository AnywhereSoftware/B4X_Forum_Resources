# config.flow
import logging
import voluptuous as vol
from homeassistant import config_entries
from homeassistant.core import callback
from .const import (LOGGING_PREFIX, DOMAIN,
    SENSOR_NAME_TEMPERATURE, SENSOR_NAME_HUMIDITY, SENSOR_NAME_TEMPERATURE_STATE, SENSOR_NAME_HUMIDITY_STATE,
    SENSOR_LOCATION_TEMPERATURE, SENSOR_LOCATION_HUMIDITY, SENSOR_LOCATION_TEMPERATURE_STATE, SENSOR_LOCATION_HUMIDITY_STATE,
    CONFIG_TITLE)

_LOGGER = logging.getLogger(__name__)

async def async_step_user(self, user_input=None):
    """Handle the initial step."""
    errors = {}
    if user_input is not None:
        _LOGGER.debug(f"{LOGGING_PREFIX} User input: {user_input}")
        return self.async_create_entry(title=CONFIG_TITLE, data=user_input)

    data_schema = vol.Schema(
        {
            vol.Required(SENSOR_NAME_TEMPERATURE,       default=SENSOR_LOCATION_TEMPERATURE): str,
            vol.Required(SENSOR_NAME_HUMIDITY,          default=SENSOR_LOCATION_HUMIDITY): str,
            vol.Optional(SENSOR_NAME_TEMPERATURE_STATE, default=SENSOR_LOCATION_TEMPERATURE_STATE): str,
            vol.Optional(SENSOR_NAME_HUMIDITY_STATE,    default=SENSOR_LOCATION_HUMIDITY_STATE): str,
        }
    )

    return self.async_show_form(step_id="user", data_schema=data_schema, errors=errors)

class BLEBeaconDHTConfigFlow(config_entries.ConfigFlow, domain=DOMAIN):
    """Handle a config flow for BLE Beacon DHT."""

    VERSION = 1

    async def async_step_user(self, user_input=None):
        """Handle the initial step."""
        errors = {}
        if user_input is not None:
            return self.async_create_entry(title=CONFIG_TITLE, data=user_input)

        data_schema = vol.Schema(
            {
                vol.Required(SENSOR_NAME_TEMPERATURE,       default=SENSOR_LOCATION_TEMPERATURE): str,
                vol.Required(SENSOR_NAME_HUMIDITY,          default=SENSOR_LOCATION_HUMIDITY): str,
                vol.Optional(SENSOR_NAME_TEMPERATURE_STATE, default=SENSOR_LOCATION_TEMPERATURE_STATE): str,
                vol.Optional(SENSOR_NAME_HUMIDITY_STATE,    default=SENSOR_LOCATION_HUMIDITY_STATE): str,
            }
        )

        return self.async_show_form(step_id="user", data_schema=data_schema, errors=errors)

    @staticmethod
    @callback
    def async_get_options_flow(entry):
        """Return the options flow handler."""
        return BLEBeaconDHTOptionsFlowHandler(entry)

class BLEBeaconDHTOptionsFlowHandler(config_entries.OptionsFlow):
    """Handle options flow for BLE Beacon DHT."""

    def __init__(self, entry):
        self.entry = entry

    async def async_step_init(self, user_input=None):
        """Manage the options."""
        errors = {}
        if user_input is not None:
            return self.async_create_entry(title=CONFIG_TITLE, data=user_input)

        data_schema = vol.Schema(
            {
                vol.Required(SENSOR_NAME_TEMPERATURE,       default=self.entry.data.get(SENSOR_NAME_TEMPERATURE, SENSOR_LOCATION_TEMPERATURE)): str,
                vol.Required(SENSOR_NAME_HUMIDITY,          default=self.entry.data.get(SENSOR_NAME_HUMIDITY, SENSOR_LOCATION_HUMIDITY)): str,
                vol.Optional(SENSOR_NAME_TEMPERATURE_STATE, default=self.entry.data.get(SENSOR_NAME_TEMPERATURE_STATE, SENSOR_LOCATION_TEMPERATURE_STATE)): str,
                vol.Optional(SENSOR_NAME_HUMIDITY_STATE,    default=self.entry.data.get(SENSOR_NAME_HUMIDITY_STATE, SENSOR_LOCATION_HUMIDITY_STATE)): str,
            }
        )

        return self.async_show_form(step_id="init", data_schema=data_schema, errors=errors)
