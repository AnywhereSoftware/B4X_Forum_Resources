### rAdafruitMCP23017_I2C by rwblinn
### 09/11/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168597/)

**B4R Library rAdafruitMCP23017\_I2C**  

---

  
  
**Brief  
rAdafruitMCP23017\_I2C** is an open-source library for **MCP23017 I2C Port Expanders**.  
This library is partial wrapped (**I2C only**) and enhanced from the library [Adafruit MCP23017 Arduino library](https://github.com/adafruit/Adafruit-MCP23017-Arduino-Library).  

---

  
  
**Development Info**  

- Written in C++ (Arduino IDE 2.3.4 and the B4Rh2xml tool).
- Depends on the library Adafruit MCP23017 Arduino Library.
- Tested with

- Hardware - Arduino UNO, ESP-32, SEENGREAT MCP23017 IO Expander Module I2C, ELEGOO 5 mm LED, Keyes Pushbutton.
- Software - B4R 4.00 (64-bit), Adafruit-MCP23017-Arduino-Library v2.3.2, ESP-32 Board Manager 3.3.0.

---

  
  
![](https://www.b4x.com/android/forum/attachments/166745)  
  
**Files**  
The *rAdafruitMCP23017\_I2C-NNN.zip* archive contains the library and sample projects.  

---

  
  
**Install**  
Copy the *rAdafruitMCP23017\_I2C* library folder from the archive into the B4R **Additional Libraries** folder, keeping the folder structure intact.  
*Ensure* the library Adafruit-MCP23017-Arduino-Library v2.3.2 is installed using the Arduino IDE libraries manager.  

---

  
  
**Wiring**  
MCP23017 = Arduino UNO  
VCC = 5V (red)  
GND = GND (black)  
SDA = A4 (blue)  
SCL = A5 (yellow)  
  
MCP23017 = ESP-32  
VCC = 3V3 (red)  
GND = GND (black)  
SDA = GPIO21 [D21] (blue)  
SCL = GPIO22 [D22] (yellow)  
  
MCP23017 = Button  
PA0 (yellow) = Signal  
GND = GND (black)  
  
MCP23017 = LED  
PB7 = + (yellow) with 330Ohm resistor  
GND = GND (black)  
  
I2C  
MCP23017 I2C Address = 0x27  

---

  
  
**Basic Example**  
Example blinking all MCP23017 pins with one LED (for tests) connected to pin PA0.  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Public mcp As AdafruitMCP23017_I2C  
    Private MCP_ADDRESS_I2C As Byte = 0x27  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    If Not(mcp.Initialize2(MCP_ADDRESS_I2C)) Then  
        Log("[Main.AppStart][ERROR] Initialize expander.")  
        Return  
    Else  
        Log("[Main.AppStart] Initialize expander: OK, address=0x", mcp.ByteToHex(MCP_ADDRESS_I2C))  
    End If  
   
    ' Set all pins to mode output  
    Dim i As Byte  
    For i = 0 To mcp.pins - 1  
        mcp.SetPinMode(i, mcp.MODE_OUTPUT)  
    Next  
   
    CallSubPlus("TestBlink", 1, 5)  
End Sub  
  
Private Sub TestBlink(Tag As Byte)    'ignore  
    Dim i As Byte  
    For i = 0 To mcp.PINS - 1  
        mcp.digitalWrite(i, mcp.STATE_HIGH)  
    Next  
    Delay(1000)  
    For i = 0 To mcp.PINS - 1  
        mcp.digitalWrite(i, mcp.STATE_LOW)  
    Next  
    Delay(1000)  
End Sub
```

  

---

  
  
**Functions**  
Initialize() As Boolean  
Initialize MCP using I2C with default I2C address 0x20.  
Returns - true if initialization successful, otherwise false.  
  
Initialize2(addr As Byte) As Boolean  
Initialize MCP using I2C with custom I2C address.  
Example: 0x27 = MCP23017 module has the address jumpers A0/A1/A2 pulled high.  
addr - I2C address.  
Returns - true if initialization successful, otherwise false.  
  
SetPinMode(pin As Byte, mode As Byte)  
Configures the specified pin to behave either as an input or an output.  
pin - the Arduino pin number to set the mode of.  
mode - INPUT, OUTPUT, or INPUT\_PULLUP.  
  
GetPinMode(pin As Byte) As Byte  
Get the specified pin mode.  
pin - Arduino pin number to get the mode of.  
mode - INPUT, OUTPUT, or INPUT\_PULLUP.  
  
DigitalRead(pin As Byte) As Byte  
Reads the value from a specified digital pin, either HIGH or LOW.  
pin - Arduino pin number you want to read.  
Returns - HIGH or LOW  
  
DigitalWrite(pin As Byte, value As Byte)  
Write a HIGH or a LOW value to a digital pin.  
pin - Arduino pin number  
value - HIGH or LOW  
   
ReadGPIO(port As Byte) As Byte  
Bulk read all pins on a port.  
port - 0 for Port A, 1 for Port B (MCP23X17 only).  
Returns - current pin states of port as byte.  
  
WriteGPIO(value As Byte, port As Byte)  
Bulk write all pins on a port.  
value - pin states to write as a uint8\_t.  
port - 0 for Port A, 1 for Port B (MCP23X17 only).  
  
SetupInterrupts(mirroring As Boolean, openDrain As Boolean, polarity As Byte)  
Configure the interrupt system.  
mirroring - true to OR both INTA and INTB pins.  
openDrain - true for open drain output, false for active drive output.  
polarity - HIGH or LOW  
  
SetupInterruptPin(pin As Byte, mode As Byte)  
Enable interrupt and set mode for given pin.  
pin - Pin to enable.  
mode - CHANGE, LOW, HIGH.  
  
DisableInterruptPin(pin As Byte)  
Disable interrupt for given pin.  
pin - Pin to disable.  
  
ClearInterrupts  
Clear interrupts.  
  
GetLastInterruptPin As Byte  
Gets the pin that caused the latest interrupt, from INTF, without clearing any interrupt flags.  
Returns - Pin that caused latest interrupt.  
  
GetCapturedInterrupt As UInt  
Get pin states captured at time of interrupt.  
Returns - Multi-bit value representing pin states.  
  
**Custom Functions**  
  
AddInputHandler(StateChangedSub As SubVoidPinState)  
Add input handler for the input/input\_pullup pins  
The Input\_StateChanged in B4R only sees clean transitions:  
Button press > 1 clean LOW event.  
Button release > 1 clean HIGH event.  
No multiple toggles caused by bouncing contacts.  
StateChangedSub - Event name handling the input state change.  
  
AttachInterrupt(intPin As Byte, buttonPin As Byte, StateChangedSub As VoidPinState)  
Attach MCP pin interrupt with MCU pin for INTA/B  
intPin - Interrupt pin INTA or INTB.  
buttonPin - Button pin GPA0-7 or GPB0-GPB7.  
StateChangedSub - Event name handling the input state change.  
  

---

  
  
**Constants**  
  
MCP23XXX\_ADDR As Byte = 0x20 - Default I2C Address.  
  
MODE\_OUTPUT As Byte = OUTPUT - Pin Modes Output (LED).  
MODE\_INPUT As Byte = INPUT Pin Modes Input (Button).  
MODE\_INPUT\_PULLUP As Byte = INPUT\_PULLUP - Pin mode input pullup (Pushbutton).  
  
STATE\_CHANGE As Byte = CHANGE - Pin state change.  
STATE\_HIGH As Byte = HIGH - Pin state hight  
STATE\_LOW As Byte = LOW - Pin state low.  
  
PINS As Byte = 0x10 - Number of PINS 16 (0-15).  
  
Pin codes for PA0 to PB7 - 16 pins.  
PIN\_PA0 As Byte = 0  
PIN\_PA1 As Byte = 1  
PIN\_PA2 As Byte = 2  
PIN\_PA3 As Byte = 3  
PIN\_PA4 As Byte = 4  
PIN\_PA5 As Byte = 5  
PIN\_PA6 As Byte = 6  
PIN\_PA7 As Byte = 7  
PIN\_PB0 As Byte = 8  
PIN\_PB1 As Byte = 9  
PIN\_PB2 As Byte = 10  
PIN\_PB3 As Byte = 11  
PIN\_PB4 As Byte = 12  
PIN\_PB5 As Byte = 13  
PIN\_PB6 As Byte = 14  
PIN\_PB7 As Byte = 15  

---

  
  
**Credits**  
Adafruit Industries for the MCP23017 Arduino library.  
  
**Disclaimer**  

- This project is developed for **personal use only**.
- All examples and code are provided **as-is** and should be used **at your own risk**.
- Any guidance provided **as-is**, without any guarantee or liability for errors, omissions, or misconfiguration.
- **Always test** thoroughly and exercise caution when connecting hardware components.

  
**Licenses**  
Original Library (Adafruit)  
Copyright © 2012 Adafruit Industries. Licensed under the BSD 3-Clause License (see LICENSE file in the original repository).  
  
License for this wrapper  
Copyright © 2025 Robert W.B. Linn. Licensed unter the MIT License (see LICENSE file).  
  
Notes  
The Adafruit library remains under the BSD license.  
This wrapper code is MIT licensed. When distributing, both licenses apply.