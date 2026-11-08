# Arduino RFXMeter
The goal is to send sensor & actuator data from an [Arduino](https://www.arduino.cc/) Microcontroller to [Domoticz Home Automation System](https://domoticz.com/) by using a [RFXCOM RFXtrx433e](http://www.rfxcom.com/RFXtrx433E-USB-43392MHz-Transceiver/en) transceiver.

* Create a fit-for-purpose solution for sending all kind of sensor & actuator data to be handled by a Domoticz single device acting as a dispatcher (router).
* Explore 433Mhz communication between Microcontroller & Domoticz RFXtrx433e.
* Develop the solution with [B4R](https://www.b4x.com/b4r.html) & [Domoticz dzVents](https://www.domoticz.com/wiki/DzVents:_next_generation_Lua_scripting) Automation Events.
* This project has been triggered by finding a solution to read the flow temperature of a home heating device and log the value in Domoticz.
* Arduino connected modules tested: 433Mhz Transmitter, DHT22 (Temperature & Humidity), Reed Switch (Contact), Thermosensor MAX6675 (Temperature), SlidePot (Dimmer).

The solution has been developed for personal use only. Use at your own risk.

## Solution
The Arduino microcontroller sends RFXMeter messages to the Domoticz Home Automation System via a cheap 433Mhz transmitter.
The Domoticz Home Automation System, running on a Raspberry Pi, has a RFXCOM RFXtrx433e Transceiver connected to an USB port.
The RFXtrx433e transceiver receives the RFXMeter message and sends the message to Domoticz RFXMeter device (Hardware RFXCOM RFXtrx433e).
A Domoticz Automation Event (dzVents) listens to RFXMeter device changes, converts the message data and updates associated Domoticz device(s) or any other action.
The RFXMeter message data send is an unsigned long (ULong) value with range 0 - 16777215 (HEX FFFF, 3 Bytes from ULong data type).

It is also possible to send data to various Domoticz RFXMeter devices and handle Automation Events accordingly.
The RFXMeter device acts as a trigger to update other devices (or take any other action).

The ULong value contains packed information used by the Automation Event dzVents.
Example:
A temperature & humidity module DHT22 is connected to an Arduino UNO.
The measured temperature 19 C is sent to a Domoticz RFXMeter device with address 09 and assigned via dzVents to temperature device with IDX=375.
The value sent is 1337519: 1 3 375 19 - 1=Leading Number (fixed), 3=Length IDX, 375=IDX, 19=Temperature.
The dzVents script listens to device changes with IDX=384 (the RFXMeter), parses the RFXMeter sValue (ULong 1337519) for the device (IDX=375) and updates the device sValue (19).
```
return {
	on = { devices = { 384 } },
	execute = function(domoticz, device)
        local idxlen = tonumber(string.sub(device.sValue, 2, 2))			-- 3
        local idx = tonumber(string.sub(device.sValue, 3, 3 + idxlen - 1))	-- 375
        local svalue = tonumber(string.sub(device.sValue, 3 + idxlen, -1))	-- 19
        domoticz.devices(idx).setValues(0, svalue)
    end
}
```

The B4R development environment offers a variety of libraries for sensors & actuators. This allows to build modular solutions.

**Heads Up**
As mentioned, this is a fit-for-purpose solution and has limitations given by the ULong value (0 - 16777215) sent from the microsontroller.
This means depending requirements, checks or workarounds needs to be developed accordingly.

### Data Flow
Sensor > Microcontroller > 433Mhz Transmitter > RFXCOM RFXtrx433e > Domoticz Hardware RFXCOM RFXtrx433e > Domoticz RFXMeter device > Domoticz dzVents > Domoticz Virtual Sensor(s).

### Examples RFXMeter Data for Sensors & Actuators
* Temperature: Value Range 0 to 100; Send as value 0 - 100; Domoticz takes the value without conversion.
* Temperature: Value Range -10 to 10; Send as value 0 - 20; Domoticz converts with offset 10 (0=0-10=-10, 20=20-10=10).
* Humidity: Value Range 0 - 100; Send as value 0 - 100; Domoticz takes the value without conversion.
* Switch: Value Range 0 - 1; Send as value 0 (=Off) or 1 (=On); Domoticz takes the value without conversion.
* Up-to 7 Switches: Value Range 1NNNNNNN with N holding switch N state 0-1; Send as 10101101 with 1 as leading for the ulong value; Domoticz converts the switches states and assigns to respective switch devices.
* Device: Value Range depends on IDX & value; Send the value to a device with given IDX. Example: 127841 (1 2 78 41) - Leading 1 followed by IDX length 2 for the IDX 78 with value 41 (max 9999); Domoticz converts the value in IDX and value and assigns the value to the device with the IDX.
* Dimmer: Value Range 0 - 100; Send the value to a device with given IDX. Example: 1338652 (1 3 386 52) - Leading 1 followed by IDX length 3 for the IDX 386 with value 52 (max 9999, but for the dimmer is 100); Domoticz converts the value in IDX and value and assigns the value to the device with the IDX.
* More in progress...

### Why RFXMeter?
An RFXMeter is a remote RF sensor transmitting encoded data from electric power, water, gas, or other metering devices.
Domoticz supports RFXMeter devices connected to the hardware RFXCOM - RFXtrx433 USB 433.92MHz Transceiver. 
The Domoticz device type is RFXCOM with subtype RFXMeter counter. The device supports the types Energy, Gas, Water, Counter, Energy Generated and Time.
The type counter is selected which supports type unsigned long (4 Bytes) from which 3 bytes are used (see next).
The ULong value holds the sensor or actuator data.

## B4R Code Module RFXMeter
The B4R solution has a B4R code module RFXMeter to send the device address, value.
The code module is based on the function RFXMeter from the [X10RF-Arduino](https://github.com/pyrou/X10RF-Arduino) open source project.
If packed in a B4X Library, then the B4XLib contains the code module RFXMeter which does not need to be declared in Process_Globals.

### Methods
Init the RFXMeter RF433 transmitter and LED.
tx_pin - Signal pin of the RF433 Transmitter
led_pin - Signal pin of the LED indicating data is send (0=disabled)
```
Initialize(tx_pin As Byte, led_pin As Byte)
```

Send value to the RFXtrx433e device.
The address parameter enables to send to a dedicated Domoticz RFXMeter device.
addr - Address of the RFXMeter device used as ID in Domoticz. Example: 0x09 (Domoticz ID: 09F9).
value - Long range 0 - 16777215.
```
SendValue(addr As Byte, value As ULong)
```

Send a command to the RFXtrx433e device.
data - array as byte with max length 6, i.e. data=09F98EE40501 for an address=9, value=364260.
```
SendCommand(data() As Byte)
```

Send an array of bytes to the RFXMeter.
addr - Address of the RFXMeter device used as ID in Domoticz. Example: 0x09 (Domoticz ID: 09F9).
data - Array of bytes. Example: array as Byte(1, 2, 3).
```
SendBytes(addr As Byte, data() As Byte)
```

Send an array of max 7 bits (value 0 or 1) to the RFXMeter. The ULong value is max 7 bits + leading 1 = 8 Bits (like 11111111).
The bits can hold the state of switches, lamps, security devices.
addr - Address of the RFXMeter device used as ID in Domoticz. Example: 0x09 (Domoticz ID: 09F9).
data - Array of bits. Example: Sending 5 Switches with state packed in the ULong value of 111010 (with leading 1) = Array as Byte(1,1,0,1,0).
```
SendBits(addr As Byte, bits() As Byte)
```

Send value (ULong) to the Domoticz RFXMeter device which is used to set value of a Domoticz device with given IDX.
RESTRICTION: The longer the IDX number length, the smaller the device value to stay with max number length of 8. For larger values use method Send instead.
addr - Address of the RFXMeter device used as ID in Domoticz. Example: 0x09 (Domoticz ID: 09F9).
idx - IDX of the Domoticz target device. This is not the RFXMeter device but the Virtual Sensor like Temperature device.
value - Device value
The value sent to Domoticz has following pattern:
1 = 1 - allways for leading the value.
2 = IDXLEN - Length of the IDX. Example: IDX 78 has length 2. 
3 to 3 + IDXLEN - 1 = IDX of the target device. Example: 78
3 + IDXLEN to length value = Value. Example: 41. The max value is 9999.
Examples:
127841 (1 2 78 41) - Leading 1 with IDX length 2 for IDX 78 with value 41 (max value 9999). Total length of the value sent is 6 (max 8).
13123999 (1 3 123 999) - Leading 1 with IDX length 3 for IDX 123 with value 999 (max value 999). Total length of the value sent is 8 (max 8).
13123499 (1 4 1234 99) - Leading 1 with IDX length 4 for IDX 1234 with value 99 (max value 99). Total length of the value sent is 8 (max 8).
```
SendValueToIDX(addr As Byte, idx As Int, value As ULong)
```

**Note**
The library contains in addition some experimental methods which are worked upon. These are not listed here.

### Fields
**MAX_VALUE = 16777215 (ULong)**
Max value transmitted. 
The max value are the first 3 bytes of the ULong value: HEX=FFFFFF, DEC=16777215.

**MAX_BITS = 24 (Byte)**
Max number of bits transmitted. 
The max value is 24 bits (3 bytes of the ULong value: 11111111 11111111 11111111).

**MAX_BYTES = 3 (Byte)
Max number of bytes transmitted. 
The max value is ULong 3 Bytes FFFFFF.

**MAX_NUMBERS = 8 (Byte)
Max number of numbers transmitted is 8.
The number  needs to be kept below max value 16777215. Example bit pattern 11111111 for switch states.

**SIGN_POS = 1 (Byte)**
Positive sign used for example for temperature device

**SIGN_NEG = 2 (Byte))**
Negative sign used for example for temperature device

**Repeats = 5 (Byte)**
Number of send command repeats. 
The recommended value is 5 repeats.

**Logging = False (Boolean)**
Set logging to the serial line.
Example Logging to the B4R IDE:
```
RFXMeter: Send address=9, value=16807
RFXMeter: Send Address Bytes 0,1=09F9
RFXMeter: Send Value Bytes 4,2,3=0041A7
RFXMeter: Send Packet Type&Parity Byte 5=08
RFXMeter: SendCommand data=09F941A70008
```

## Hard-/Software
* Hardware: Arduino UNO, cheap 433Mhz Transmitter communicating to the RFXCOM RFXtrx433e USB 433.92MHz Transceiver (Firmware Ext2/1025).
* B4R Library rRFXMeter and program examples developed with [B4R](https://www.b4x.com/b4r.html) v3.9.
* Communication tested with [Domoticz Home Automation System](https://domoticz.com/) 2022.1 running on a Raspberry Pi 3B+ with Raspberry Pi OS (5.10.103-v7+ #1529).

## Files
* rRFXMeter.zip archive contains the class and B4R sample projects.

## Install
The library file rRFXMeter.b4xlib is installed in the B4R additional libraries folder.
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.
```
<path to b4r additional libraries folder>\rRFXMeter.b4xlib
```
For B4R program examples, lookup folder Examples.
The B4XLib contains the code module RFXMeter which does not need to be declared in (for example) Process_Globals.

## Wiring
```
433Mhz Transmitter = Arduino UNO
VCC = 5v
Signal = #7
GND = GND
```

## Domoticz Configuration
The RFXMeter has to be added to the Domoticz devices. This can be done by adding new hardware in the Domoticz GUI:
GUI > Setup > Settings > Hardware/Devices option Allow for 5 Minutes.
When running the Arduino program, the device is added with the address set to the Domoticz hardware RFXCOM - RFXtrx433 USB 433.92MHz Transceiver (Version: Ext2/1025, Name: RFXtrx433e).
Example new RFXMeter with IDX set by Domoticz, address 09F9, hardware RFXtrx433e:
```
IDX=384, Hardware=RFXtrx433e, ID=09F9, Unit=0, Name=RFXMETER, Type=RFXMeter, SubType=RFXMeter counter, Data=NNNN
```
The device has the initial name Unknown and from type Counter. Lookup the GUI > Tab Utility > Device Unknow to change the properties via Edit.
The name changed to RFXMeter. To hide the device from the GUI tabs (like Utility), set the the name to $RFXMeter.
Depending requirements, several RFXMeter devices can be defined - ensure each has a unique address.

## Examples
The first examples simulate a device which value is sent to Domoticz and handled by an Automation Event dzVents.
In addition, a DHT22 Temperature & Humidity module example is given.
More examples in the folder Examples, like Reed Switch, Thermosensor MAX6675.

## Example Basic (Simulation)
This basic example sends a random generated value from an Arduino UNO to the Domoticz RFXMeter device (as created previous).
Additional Libraries: rRFXMeter (rRFXMeter.b4xlib)
### B4R Code
```
Sub Process_Globals
	Public serialLine As Serial
	Private RFXMeter_Address As Byte = 0x09	'Address of the Domoticz RFXMeter used for the Send method (multiple addresses can be used)
	Private TX_PINNR As Byte = 7			'433 Mhz transmitter data pin
	Private LED_PINNR As Byte = 13			'LED to indicate data is transmitted
	Private Timer_Test As Timer
End Sub

Private Sub AppStart
	serialLine.Initialize(115200)
	RFXMeter.Initialize(TX_PINNR, LED_PINNR)
	RFXMeter.Logging = True
	Timer_Test.Initialize("Timer_Test_Tick", 15000)
	Timer_Test.Enabled = True
	Timer_Test_Tick
End Sub

Sub Timer_Test_Tick
	'Generate a random ULong value between 0 and MAX_VALUE - 1 and assign to a Domoticz RFXMeter device (Example):
	'IDX=384, Hardware=RFXtrx433e, ID=09F9, Unit=0, Name=RFXMETER, Type=RFXMeter, SubType=RFXMeter counter, Data=NNNNNN

	'Example: RFXMeter with address=9, value=14307615 is converted to SendCommand: data=09F9511FDA01 (length=6 bytes)
	Dim value As ULong = Rnd(0, RFXMeter.MAX_VALUE - 1)

	'Send the value to the Domoticz RFXMeter device with the given address.
	RFXMeter.SendValue(RFXMeter_Address, value)
	Log("***")
End Sub
```
### Domoticz Automation Event dzVents
The script listens to device changes with IDX=384. If changed, by receiving a new value from the Arduino, the value is converted from sValue to a number.
This number can used for next actions, like updating a device or trigger an alarm.
```
-- RFXMeterBasic.dzVents

local rfxmeter = 384
return {
	on = { devices = { rfxmeter } },
	logging = { level = domoticz.LOG_DEBUG, marker = 'RFXMETER', },
	execute = function(domoticz, device)
	    -- Example: device.sValue=11345
		domoticz.log(("%s: %s"):format(device.name, device.sValue))
        -- Convert the sValue from string to number
		local value = tonumber(device.sValue)
		domoticz.log(("Value=%.f"):format(value))
    end
}
```

## Example RFXMeter to Voltage (Simulation)
On the Arduino UNO, generate a random value between 0 - 12000, send to the Domoticz RFXMeter device (IDX=384) and assign the value to a virtual sensor type Voltage (IDX=385) via an Automation Event dzVents.
### B4R Code
```
Sub Process_Globals
	Public serialLine As Serial
	Private Timer_Test As Timer
End Sub

Private Sub AppStart
	serialLine.Initialize(115200)
	RFXMeter.Initialize(7, 13)
	Timer_Test.Initialize("Timer_Test_Tick", 30000)
	Timer_Test.Enabled = True
	Timer_Test_Tick
End Sub

Sub Timer_Test_Tick
	'Generate a random value between 0 and 12000, i.e. 6864 assigned to a Voltage device in Domoticz with data 6.864V.
	Dim value As Long = Rnd(0, 12001)
	Log("Sending Voltage=", value)
	RFXMeter.SendValue(0x09, value)
End Sub
```

### Domoticz Automation Event dzVents
The script listens to device changes with IDX=384 and updates a Voltage device with IDX=385.
```
local rfxmeter = 384
local rfxmetervoltage = 385
return {
	on = { devices = { rfxmeter } },
	logging = { level = domoticz.LOG_DEBUG, marker = 'RFXMETER', },
	execute = function(domoticz, device)
		domoticz.log(("%s: %s"):format(device.name, device.sValue))
        -- Convert the sValue from string to number
		local value = tonumber(device.sValue)
        -- Convert the Voltage value (mV) for the virtual sensor Voltage value (V)
		value = value * 0.001
		-- Update the Voltage device
		domoticz.devices(rfxmetervoltage).updateVoltage(value)        
		domoticz.log(("Voltage=%.2f"):format(value))
    end
}
```
**Domoticz Log**
```
dzVents: Info: Handling events for: "RFXMETER", value: "7712"
dzVents: Info: RFXMETER: ------ Start internal script: RFXMeter: Device: "RFXMETER (RFXtrx433e)", Index: 384
dzVents: Info: RFXMETER: RFXMETER: 7712
dzVents: Debug: RFXMETER: Processing device-adapter for RFXVoltage: Voltage device adapter
dzVents: Info: RFXMETER: Voltage=7.71
dzVents: Info: RFXMETER: ------ Finished RFXMeter
```

## Example RFXMeter to IDX (Simulation)
Sent the RFXMeter value to a Domoticz device with given IDX.
### B4R Code
```
Sub Process_Globals
	Public serialLine As Serial
	Private RFXMeter_Address As Byte = 0x09	'Address of the Domoticz RFXMeter used for the Send method (multiple addresses can be used)
	Private TX_PINNR As Byte = 7			'433 Mhz transmitter data pin
	Private LED_PINNR As Byte = 13			'LED to indicate data is transmitted
	Private Timer_Test As Timer
End Sub

Private Sub AppStart
	serialLine.Initialize(115200)
	RFXMeter.Initialize(TX_PINNR , LED_PINNR)
	RFXMeter.Logging = True
	Timer_Test.Initialize("Timer_Test_Tick", 15000)
	Timer_Test.Enabled = True
	Timer_Test_Tick
End Sub

Sub Timer_Test_Tick
	'Generate RFXMeter value for Domoticz Humidity device IDX=385 and value between 0 - 100%.
	Dim value As ULong = Rnd(0, 101)
	'Sent the value
	RFXMeter.SendValueToIDX(RFXMeter_Address, 385, value)
End Sub
```

### Domoticz Automation Event dzVents
```
local rfxmeter = 384
local rfxmetertemphum = 385

return {
	on = { devices = { rfxmeter } },
	logging = { level = domoticz.LOG_DEBUG, marker = 'RFXMETERHUMIDITY385', },
	execute = function(domoticz, device)
        -- Convert the value to a given idx and update the device sValue
        -- 385, VirtualSensors,	141D1, 1, RFXHumidity, Humidity, LaCrosse TX3, Humidity 50 %
        -- Method string.sub extracts a piece of the string s, from the i-th to the j-th character inclusive. In Lua, the first character of a string has index 1
        -- The humidity device is updated via HTTP: Processing device-adapter for RFXHumidity: Humidty device adapter
        -- RFXMETER: OpenURL: url = http://127.0.0.1:8080/json.htm?type=command&param=udevice&idx=385&nvalue=81&svalue=0&parsetrigger=false
        
        -- Get the length of the idx at pos 2
        local idxlen = tonumber(string.sub(device.sValue, 2, 2))
        -- Get the idx starting at pos 3 of the sValue
        local idx = tonumber(string.sub(device.sValue, 3, 3 + idxlen - 1))
        -- The humidity is set as nValue. If the device is a Temp+Humidity then the temperature is set as sValue.
        local nvalue = tonumber(string.sub(device.sValue, 3 + idxlen, -1))
        domoticz.log(("IDX %d=%d"):format(idx, nvalue))
        -- Update the device if idx not 0. The humidity status is not updated but set to 0 (=normal)
        if (idx ~= 0) then 
            domoticz.devices(idx).setValues(nvalue, 0)
            domoticz.log(("%d: nValue=%d, sValue=%s"):format(idx, domoticz.devices(idx).nValue, domoticz.devices(idx).sValue))
        end
    end
}
```

## Example DHT22 Sensor
The Arduino sends dht22 sensor data (temperature, humidity) via the 433Mhz Transmitter to the RFXCOM RFXtrx433e connected via USB with the Raspberry Pi running Domoticz.
The data is received by a RFXMeter device, parsed into temperature & humidity values and a Temp+humidity device is updated.
### B4R Code
```
Sub Process_Globals
	Public serialLine As Serial
	'RFXMeter & 433 TX Module
	Private RFX_DEVADDR As Byte	= 0x09				'RFXMeter address which is used as Domoticz ID
	Private RFX_PINTX As Byte 	= 7					'Transmi pin
	Private RFX_PINLED As Byte	= 13				'Internal Arduino UNO LED
	'DHT22 Module
	Private dht22 As DHTEx							'Lib rDHTEx
	Private DHT22_PINNR As UInt = 0x08				'DHT22 signal connected pin#8
	Private humidity As Float
	Private temperature As Float
	'Timer for data sampling
	Private timerDataSampling As Timer
	Private DATASAMPLING_INTERVAL As ULong = 60000
End Sub

Private Sub AppStart
	serialLine.Initialize(115200)
	RFXMeter.Initialize(RFX_PINTX, RFX_PINLED)
	RFXMeter.Logging = False
	dht22.Initialize
	timerDataSampling.Initialize("TimerDataSampling_Tick", DATASAMPLING_INTERVAL)
	timerDataSampling.Enabled = True
	TimerDataSampling_Tick
End Sub

Sub TimerDataSampling_Tick
	If Not(ReadDHT22) Then
		timerDataSampling.Enabled = False
	End If
End Sub

'Read data from the DHT22 sensor, check the read result and sent the data (without digits) to Domoticz.
Private Sub ReadDHT22 As Boolean
	Dim result As Boolean
	Dim readReturn As Int = dht22.Read22(DHT22_PINNR)
	If readReturn == dht22.READ_OK Then
		temperature	= dht22.GetTemperature
		humidity	= dht22.GetHumidity
		'Temperature =18 C, Humidity = 45 %RH
		Log("DHT22 Temperature =", NumberFormat(temperature,0,0) , " C", ", Humidity = ", NumberFormat(humidity,0,0), " %RH")
		'Correct the temperature for neg values as can only sent positive values
		Dim temperaturesign As Byte = RFXMeter.SIGN_POS
		If temperature < 0 Then
			temperaturesign = RFXMeter.SIGN_NEG
			temperature = temperature * -1
		End If
		RFXMeter.SendBytes(RFX_DEVADDR, Array As Byte(temperaturesign, temperature , humidity))
		result = True
	Else
		'ERROR Reading DHT22 Module (code=-2). Note: -2 is timeout (see RFXMeter defines)
		Log("[ERROR] Can not read the DHT22 Module (code=", readReturn, ").")
		result = False
	End If
	Return result
End Sub
```
### Domoticz Automation Event dzVents
```
-- IDX of the devices used.
local IDX_RFXMETER = 384
local IDX_TEMPHUM = 385

-- Convert a number to N ints.
-- value - number to convert (integer or long). Float is not handled.
-- nrbytes - number of bytes to convert from the value.
-- Return table with N ints entries.
local function convert_to_ints(value, nrbytes)
    local result = {}
    for i = 0, nrbytes - 1 do
        -- Convert the byte to a number (int) and assign to the table (note the table index starts with 1 and not 0)
        result[i+1] = math.floor((value / (2 ^ (i * 8))) % (2 ^ 8))
        -- result[i+1] = (value >> (i * 8)) & 0xFF
    end
    return result
end

return {
	on = {
		devices = { IDX_RFXMETER }
	},
	logging = { level = domoticz.LOG_DEBUG, marker = 'RFXMETERDHT22', },
    -- Listen to RFXMeter device changes
	execute = function(domoticz, device)
	    -- Example: device.sValue=131889 holds 3 bytes as HEX value=020331:
        -- HEX 02=temperature sign neg, HEX 03=temperature 3Celsius, converted to -3C because sign is 2 (1 is pos value), HEX 31=humidity 49%
		domoticz.log(("%s: %s"):format(device.name, device.sValue))
        -- Convert the sValue from string to number
		local value = tonumber(device.sValue)
		-- domoticz.log(("Value=%.f"):format(value))
		-- Convert the RFXMeter value in a table with 3 ints
        local data = convert_to_ints(value, 3)
        domoticz.log(data)
        local sign = tonumber(data[3])
        local temperature = tonumber(data[2])
        if (sign == 2) then temperature = temperature * -1 end
        local humidity = data[1]    
        -- dzVents: Info: RFXMETER: s=2, t=-3, h=49
        domoticz.log(("s=%d, t=%d, h=%d"):format(sign, temperature, humidity))
        -- Assign the values to a Domoticz device
        -- Note: status is not used: domoticz.HUM_NORMAL, HUM_COMFORTABLE, HUM_DRY, HUM_WET or HUM_COMPUTE. 
        domoticz.devices(IDX_TEMPHUM).updateTempHum(temperature, humidity)  -- status
    end
}
```

## Hints
* Hide the RFXMeter from the Domoticz tabs: Put $ in from of the device name, i.e. $RFXMETER instead RFXMETER.
* For tests delete device history: http://domoticz-ip:port/json.htm?type=command&param=deletedaterange&idx=382&fromdate=2022-01-01&todate=2022-12-01
* When using multiple Domoticz devices connected to the same RFXMeter device, ensure to select the right device in the Automation Event(s) dzVents or define multiple RFXMeter devices assigned to virtual sensors. This to avoid data clashed when RFXMeter device is updated.

## ToDo
* Consider receiving 433Mhz signals to trigger actuators or change settings like timer intervals.

## Acknowledgements
* Anywhere Software for providing B4R (and of course the whole B4X suite) [Info](https://www.b4x.com/).
* X10RF Open Source Projects [X10RF](https://github.com/p2baron/x10rf) & [X10RF-Arduino](https://github.com/pyrou/X10RF-Arduino).
* [RFXCOM](http://www.rfxcom.com/) for providing the hardware RFXtrx433e and manuals.

## Licence
GNU General Public License v3.0.
