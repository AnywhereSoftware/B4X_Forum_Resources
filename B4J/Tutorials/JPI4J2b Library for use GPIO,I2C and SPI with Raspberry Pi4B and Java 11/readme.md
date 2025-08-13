### JPI4J2b Library for use GPIO,I2C and SPI with Raspberry Pi4B and Java 11 by Jaume Guillem
### 02/12/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165292/)

For years I have been using the JPI4J library to control the GPIOs and I2C bus of the Raspberry 3B with Java8.  
  
With the appearance of the Raspberry 4B with Java11, this library stopped working, and after a while Erel gave us the JPI4J2 that works perfectly with the GPIOs but does NOT have the I2C bus methods.  
  
There is some librarys for I2C but not all the methods are there, and so I finally decided to write a library that contains the GPIOs, the I2C bus and the SPI bus, all together.  
  
This library works perfectly on the Raspberry 4B with Java11 or later and is tested with different I2C devices, and all the GPIOs. The SPI bus is not tested because I don't have any devices right now, but I'm sure it will work.  
  
I attach a code example in B4J to use it.  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
  
    'path to Java11  
    #JavaCompilerPath: 11, C:\Java\jdk-11.0.1\bin\javac.exe  
  
    'jar containing I2C, SPI and GPIO code  
    #AdditionalJar: JPI4J2b.jar  
   
    #AdditionalJar: pi4j-core.jar  
    #AdditionalJar: pi4j-device.jar  
    #AdditionalJar: pi4j-gpio-extension.jar  
    #AdditionalJar: pi4j-library-pigpio.jar  
    #AdditionalJar: pi4j-plugin-pigpio.jar  
    #AdditionalJar: pi4j-plugin-raspberrypi.jar  
    #AdditionalJar: slf4j-api.jar  
    #AdditionalJar: slf4j-simple.jar  
#End Region  
  
Sub Process_Globals  
    Dim timer1 As Timer  
    Dim pinpon As Boolean  
  
    Dim pi4 As PI4wrapper 'or your name of the class <<<<<<<<<<<<<<<<<<<<<<<<<<<<  
    Dim Pot1,Pot2 As Int  
    Dim ADC1 As Int  
    Dim Add_Pot1,Add_Pot2 As Int  
    Dim Add_ADC1 As Int  
End Sub  
  
Sub AppStart (Args() As String)  
    Log("Welcome to PI4J for raspberry 4 and Java11 !!!")  
    timer1.Initialize("timer1",3000)  
  
    Add_Pot1=40 'Address of first DS1882 (Digital Audio Potentiometer) in bus I2c  
    Add_Pot2=41 'Address of second DS1882 (Digital Audio Potentiometer) in bus I2c  
    Add_ADC1=72 'or 0x48 address of ADS1115 (ADC converter) in bus I2C  
   
    CallSubDelayed(Me,"start")  
    StartMessageLoop  
End Sub  
  
Sub start  
'init  
    pi4.Initialize  
  
'GPIO  
    'init GPIO as output .Pins numbered following PI4J2 description (different from PI4J)  
    pi4.initOutput(15)  
    pi4.initOutput(21)  
    'init GPIO as input  
    pi4.initInput(24,True)  
    pi4.initInput(25,True)  
    pi4.initInput(4,True)  
    pi4.initInput(8,True)  
    
'I2C    
    'init I2Cdevices  
        pi4.initializeI2C(1,3) 'bus 1, 3 I2C devices  
        Pot1=pi4.setI2CDevice(Add_Pot1)  
        Pot2=pi4.setI2CDevice(Add_Pot2)  
        ADC1=pi4.setI2CDevice(Add_ADC1)  
   
        'Digital Pots DS1882 I2C devices  
        'configure POT1 and POT2 for 33 steps  
        pi4.WriteI2C(Pot1,135)  
        pi4.WriteI2C(Pot2,135)  
        'ADC ADS1115  
        pi4.WritebytesI2C(ADC1, Array As Byte(0x01,0xC2,0x83)) 'Configuration. View datasheet  
        pi4.WritebytesI2C(ADC1,Array As Byte(0x00)) ' 0x00 = Change to Conversion Register.  
  
  
'SPI  
    pi4.InitSPI(1,0, 500000) 'chip select, address, bitrate  
                
    timer1.Enabled=True    
End Sub  
  
Sub timer1_Tick  
    If pinpon Then  
        pinpon=False  
        pi4.WriteI2C(Pot1,0) '0 attenuation in Pot1 channel L  
        pi4.WriteI2C(Pot1,64)'0 attenuation in Pot1 channel R  
        pi4.WriteI2C(Pot2,0) '0 attenuation in Pot2 channel L  
        pi4.WriteI2C(Pot2,64)'0 attenuation in Pot2 channel R  
    
        'write GPO output  
        pi4.WritePin(21,True)  
  
        'write to SPI  
        pi4.writeSPI(Array As Byte(0,1,1)) 'no real data. I haven't any SPI device to test  
    Else  
        pinpon=True  
        pi4.WriteI2C(Pot1,33)   'full attenuation in Pot1 channel L  
        pi4.WriteI2C(Pot1,33+64)'full attenuation in Pot1 channel R  
        pi4.WriteI2C(Pot2,33)   'full attenuation in Pot2 channel L  
        pi4.WriteI2C(Pot2,33+64)'full attenuation in Pot2 channel R  
    
        'write GPO output  
        pi4.WritePin(21,False)  
  
        'write to SPI  
        pi4.writeSPI(Array As Byte(0,2,3)) 'no real data. I haven't any SPI device to test  
    End If  
  
  
  
    'read devices  
   
    'read position of pots 1 and 2<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  
    Log("POT0= "&pi4.ReadI2C(Pot1))  
    Log("POT1= "&pi4.ReadI2C(Pot2))  
   
    'read state of an input <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  
    Log("Read pin24 "&pi4.readInputPin(24))  
   
    'read state of an output  
    Log("Read pin21 "&pi4.readOutputPin(21))'attention. is the value off an output  
  
  
    'read level in ADC<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  
    Dim rcvbuffer() As Byte  
    rcvbuffer = pi4.ReadbytesI2C(ADC1,2) 'read 2 bytes . View datasheet  
    For i = 0 To 1  
        rcvbuffer(i) = Bit.And(0xff, rcvbuffer(i)) 'Convert Signed(-128 to 127) byte to Unsigned (0 to 255)  
    Next  
    Dim VAlue As Int = (255* rcvbuffer(0)) + rcvbuffer(1)  
    Log("Value read from AnalogtoDigital converter = "&VAlue)  
   
   
    'SPI <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  
    Log("SPIvalue="&pi4.readSPI(3)) 'read 3 bytes  
  
  
    Log("———————")  
End Sub  
  
Sub PinState(nPin As Int,state As Boolean)  
    'this function receives callback from the classe when a GPI changes  
    Log("pin="&nPin&" state="&state)  
End Sub
```

  
  
The class that controls it is (Named PI4wrapper or your choice):  
  

```B4X
'PI4J2b for use in B4J and raspberry Pi4B with Java11  
'Class named PI4wrapper in this example <<<<<<<<<<<<<<<<<  
  
Sub Class_Globals  
    Private pi4b As JavaObject  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
        pi4b.InitializeNewInstance("JPI4J2b", Null)  
        pi4b.RunMethod("initializeContext", Null)  
        pi4b.RunMethod("setB4JCallback", Array(Me))  
              
        Log("Library version="&pi4b.RunMethod("getVersion", Null))        
End Sub  
  
#region setup  
    Sub initializeI2C(nBus As Int,numberDevices As Int)  
        pi4b.RunMethod("initializeI2C", Array(nBus,numberDevices))  
    End Sub  
  
    Sub setI2CDevice(device As Int) As Int  
        Dim HDevice As Int=pi4b.RunMethod("initializeDevice", Array(device))  
        Return HDevice  
    End Sub  
   
    Sub InitSPI(chipselect As Int,address As Int,baudrate As Int)  
        pi4b.RunMethod("initializeSPI", Array(chipselect, address, baudrate))  
    End Sub  
#End region setups  
  
#Region I2Cdevice_without_register  
    Sub ReadI2C(device As Int) As Byte'' read one byte from device  
        Dim result As Byte=pi4b.RunMethod("readByte", Array(device))  
        Return result  
    End Sub  
'  
    Sub WriteI2C(device As Int, b As Byte)' write one byte to device  
        pi4b.RunMethod("writeByte", Array(device,b))  
    End Sub                        '  
  
    Sub ReadBytesI2C(device As Int,Length As Int) As Byte()'' Read multiple bytes from device  
        Dim result() As Byte=pi4b.RunMethod("readBytes", Array(device,Length))  
        Return result  
    End Sub  
  
    Sub WriteBytesI2C(device As Int, bytes() As Byte)' Write multiple bytes to device  
        pi4b.RunMethod("writeBytes", Array(device,bytes))  
    End Sub                        '  
#End Region I2Cdevice_without_register  
  
#Region I2Cdevice_with_register  
    Sub ReadRegisterI2C(device As Int,register As Int) As Byte 'Read one byte from register  
        Dim result As Byte=pi4b.RunMethod("readRegister", Array(device,register))  
        Return result  
    End Sub  
  
    Sub WriteRegisterI2C(device As Int,register As Int, b As Byte)' write one byte to register  
        pi4b.RunMethod("writeRegister", Array(device,register,b))  
    End Sub                    
  
    Sub ReadRegistersI2C(device As Int,register As Int,length As Int) As Byte() 'Read multiple bytes from register  
        Dim result(length) As Byte  
        result=pi4b.RunMethod("readRegisters", Array(device,register,length))  
        Return result  
    End Sub  
  
    Sub WriteRegistersI2C(device As Int,register As Int, bytes() As Byte)' write multiple bytes to registers  
        pi4b.RunMethod("writeRegisters", Array(device,register,bytes))  
    End Sub                        '  
#End Region I2Cdevice_with_register  
  
  
#Region GPIO  
    Sub initOutput(pin As Int)  
         pi4b.RunMethod("setupOutputPin", Array(pin))  
    End Sub  
  
    Sub initInput(pin As Int,PullUp As Boolean)  
        Dim PullResistance As JavaObject  
        PullResistance.InitializeStatic("com.pi4j.io.gpio.digital.PullResistance")  
        If PullUp Then  
            pi4b.RunMethod("setupInputPinWithListener", Array(pin, PullResistance.GetField("PULL_UP")))  
        Else  
            pi4b.RunMethod("setupInputPinWithListener", Array(pin, PullResistance.GetField("PULL_DOWN")))  
        End If  
    End Sub  
   
    Sub WritePin(pin As Int,value As Boolean)  
        pi4b.RunMethod("writeOutputPin", Array(pin,value))  
    End Sub  
  
    Sub readInputPin(pin As Int) As Boolean  
           Dim state As Boolean = pi4b.RunMethod("readInputPin", Array(pin))  
        Return state  
    End Sub  
    Sub readOutputPin(pin As Int) As Boolean  
           Dim state As Boolean = pi4b.RunMethod("readOutputPin", Array(pin))  
        Return state  
    End Sub  
    
    Public Sub onpin_statechanged (changedPin As Int, state As String)  
        Select Case state  
        Case "HIGH"  
            CallSub3(Main,"PinState",changedPin,True)  
        Case "LOW"  
            CallSub3(Main,"PinState",changedPin,False)  
        End Select  
    End Sub  
#End Region GPIO  
  
#Region SPI  
    Sub writeSPI(data() As Byte)  
        pi4b.RunMethod("writeSPI", Array(data))  
    End Sub  
   
    Sub readSPI(length As Int) As String  
        Dim response() As Byte = pi4b.RunMethod("readSPI", Array(length))  
        Return (BytesToString(response, 0, response.Length, "UTF8"))  
    End Sub  
#End Region SPI  
   
Sub ClosePI4  
    Try  
        pi4b.RunMethod("close", Null)  
    Catch  
        Log("err close bus")  
    End Try  
End Sub
```

  
  
I am attaching the jar. The dependencies are those in the example, but you must pay attention to the fact that they must be those that correspond to versions 2.1.X of PI4J.  
  
I hope it can be useful to someone.