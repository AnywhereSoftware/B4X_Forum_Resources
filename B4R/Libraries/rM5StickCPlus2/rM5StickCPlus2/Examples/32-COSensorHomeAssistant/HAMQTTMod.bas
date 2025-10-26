B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Code Module Info
' File:			HAMQTTMod.bas
' Brief:		Home Assistant MQTT Topic & Payload definitions.
' References:	HA device_class - Type of sensor. Ref: http://developers.home-assistant.io/docs/core/entity/sensor/
' HA Entities:	hawe_cosensor.co
'				hawe_cosensor.voltage
'				hawe_cosensor.temperature
' HA Notes:		Config topic syntax: ...
#End Region

'These global variables will be declared once when the application starts.
'Public variables can be accessed from all modules.
Sub Process_Globals
	' MQTT
	Public CLIENT_ID As String = "haclient"

	' MQTT Availability
	Public STATE_TOPIC_AVAILABILITY As String = "homeassistant/sensor/hawe/cosensor/availability"

	' MQTT CO Concentration
	Public CONFIG_TOPIC_CO As String  = "homeassistant/sensor/hawe_cosensor_co/config"
	Public CONFIG_PAYLOAD_CO As String = _
		"{" _
		  """device_class"": ""carbon_monoxide""," _
		  """name"": ""CO""," _
		  """state_topic"": ""hawe/cosensor/co/state""," _
		  """unit_of_measurement"": ""ppm""," _
		  """default_entity_id"": ""hawe/cosensor/co""," _
		  """unique_id"": ""hawe/cosensor/co""," _
		  """availability_topic"": ""homeassistant/sensor/hawe/cosensor/availability""," _
		  """device"": { ""identifiers"": [""cosensor""], ""name"": ""Hawe CO Sensor""}" _
		"}"
	Public STATE_TOPIC_CO As String  = "hawe/cosensor/co/state"

	' MQTT Voltage
	Public CONFIG_TOPIC_VOLTAGE As String  = "homeassistant/sensor/hawe_cosensor_voltage/config"
	Public CONFIG_PAYLOAD_VOLTAGE As String = _
		"{" _
		  """device_class"": ""voltage""," _
		  """name"": ""Voltage""," _
		  """state_topic"": ""hawe/cosensor/voltage/state""," _
		  """unit_of_measurement"": ""V""," _
		  """default_entity_id"": ""hawe/cosensor/voltage""," _
		  """unique_id"": ""hawe/cosensor/voltage""," _
		  """availability_topic"": ""homeassistant/sensor/hawe/cosensor/availability""," _
		  """device"": { ""identifiers"": [""cosensor""], ""name"": ""Hawe CO Sensor""}" _
		"}"
	Public STATE_TOPIC_VOLTAGE As String  = "hawe/cosensor/voltage/state"

	' MQTT Temperature
	Public CONFIG_TOPIC_TEMPERATURE As String = "homeassistant/sensor/hawe_cosensor_temperature/config"
	Public CONFIG_PAYLOAD_TEMPERATURE As String = _
		"{" _
		  """device_class"": ""temperature""," _
		  """name"": ""Temperature""," _
		  """state_topic"": ""hawe/cosensor/temperature/state""," _
		  """unit_of_measurement"": ""°C""," _
		  """default_entity_id"": ""hawe/cosensor/temperature""," _
		  """unique_id"": ""hawe/cosensor/temperature""," _
		  """availability_topic"": ""homeassistant/sensor/hawe/cosensor/availability""," _
		  """device"": { ""identifiers"": [""cosensor""], ""name"": ""Hawe CO Sensor""}" _
		"}"
	Public STATE_TOPIC_TEMPERATURE As String = "hawe/cosensor/temperature/state"

	' MQTT command topics triggered by HA like a button.
	' These topics are subscribed and handled by messagearrived.
	' Important:
	' For the payload sent by HA stick with strings, like "0" / "1" payloads for all MQTT control commands.
	' That keeps things: Simple, Compatible with HA dashboards, Human-readable in MQTT Explorer or mosquitto_sub
	' Commands
	' Refresh: Read the actual data by calling PerformMeasurement. Payload="refresh"
	Public COMMAND_REFRESH_TOPIC As String = "hawe/cosensor/command/refresh"
	' LED Status: Set the state of the ESP32 onboard LED. Payload "0" (off) or "1" (ON)
	Public COMMAND_LED_STATUS_TOPIC As String = "hawe/cosensor/command/led_status"

	Public DELAY_AFTER_TASK As ULong = 100	' ms, short delay after every MQTT task like publish

End Sub
