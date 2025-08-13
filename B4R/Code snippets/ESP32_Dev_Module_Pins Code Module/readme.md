### ESP32_Dev_Module_Pins Code Module by Cableguy
### 01/14/2024
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/158630/)

Hi Guys,  
  
Although I've done this for my own needs, I guess this may help others too.  
Copy this to a code module, and name it, if you want to, ESP32\_Dev\_Module\_Pins, or whatever other name is meaningful for you.  
  
Then, whenever you need to refer to a pin, or even to search for a suitable pin, you can….  
  
![](https://www.b4x.com/android/forum/attachments/149684)  
  
[SPOILER="ESP32\_Dev\_Module\_Pins"]

```B4X
#Region CHIP INFO  
' Manufactor Board Name : ESP32S NodeMCU  
' B4R Board : ESP32S DEV MODULE  
'*******************************************  
'*            Components Side              *  
'*        ________________________         *  
'*        |                      |         *  
'*      –|   EN          GPIO-23|–       *  
'*      –|GPIO-36        GPIO-22|–       *  
'*      –|GPIO-39        GPIO-01|–       *  
'*      –|GPIO-34        GPIO-03|–       *  
'*      –|GPIO-35        GPIO-21|–       *  
'*      –|GPIO-32        GPIO-19|–       *  
'*      –|GPIO-33        GPIO-18|–       *  
'*      –|GPIO-25        GPIO-05|–       *  
'*      –|GPIO-26        GPIO-17|–       *  
'*      –|GPIO-27        GPIO-16|–       *  
'*      –|GPIO-14        GPIO-04|–       *  
'*      –|GPIO-12        GPIO-02|–       *  
'*      –|GPIO-13        GPIO-15|–       *  
'*      –|   GND         GND    |–       *  
'*      –|   VIN  _______3V3    |–       *  
'*        |________| USB |_______|         *  
'*                                         *  
'*******************************************  
'  
' There are several variants to this board, to wich the physical pinout differs between them.  
' So, how to know wich board you have? Just look at it, and take note of slight differencesin components position.  
' WIth this particular board, the large MosFET is places just above the USB port, and in an Horizontal orientation,  
' with the large PAD turned to the left, With a CP chip as USB Uart and Micro-USB.  
'  
' Usefull links : https://www.researchgate.net/figure/ESP-32S-ESP-WROOM-32-DEVELOPMENT-BOARD-38P-NODEMCU_fig2_368840530  
#End Region  
Sub Process_Globals  
End Sub  
  
  
'GPIO-01  
'U0_TXD  
'CLK_03  
Public Sub GPIO_01 As Byte  
    Return 01  
End Sub  
  
'GPIO-02  
'ADC2_2  
'HSPI_WP  
'Touch_2  
'CS  
Public Sub GPIO_02 As Byte  
    Return 02  
End Sub  
  
'GPIO-03  
'CLK_02  
'U0_RXD  
Public Sub GPIO_03 As Byte  
    Return 03  
End Sub  
  
'GPIO-04  
'ADC2_0  
'HSPI_HD  
'Touch_0  
Public Sub GPIO_04 As Byte  
    Return 04  
End Sub  
  
'GPIO-05  
'V_SPI_CSO  
Public Sub GPIO_05 As Byte  
    Return 05  
End Sub  
  
'GPIO-12  
'ADC2_05  
'Touch_5  
'HSPI_MISO  
Public Sub GPIO_12 As Byte  
    Return 12  
End Sub  
  
'GPIO-13  
'ADC2_4  
'Touch_4  
'HSPI_MOSI  
Public Sub GPIO_13 As Byte  
    Return 13  
End Sub  
  
'GPIO-14  
'ADC2_6  
'Touch_6  
'HSPI_CLK  
Public Sub GPIO_14 As Byte  
    Return 14  
End Sub  
  
'GPIO-15  
'ADC2_3  
'Touch_3  
'HSPI_CS  
Public Sub GPIO_15 As Byte  
    Return 15  
End Sub  
  
'GPIO-16  
'U2_RXD  
Public Sub GPIO_16 As Byte  
    Return 16  
End Sub  
  
'GPIO-17  
'U2_TXD  
Public Sub GPIO_17 As Byte  
    Return 17  
End Sub  
  
'GPIO-18  
'SCK  
'VSPI_CLK  
Public Sub GPIO_18 As Byte  
    Return 18  
End Sub  
  
'GPIO-19  
'MISO  
'VSPI_MISO  
Public Sub GPIO_19 As Byte  
    Return 19  
End Sub  
  
'GPIO-21  
'SDA  
Public Sub GPIO_21 As Byte  
    Return 21  
End Sub  
  
'GPIO-22  
'SCL  
Public Sub GPIO_22 As Byte  
    Return 22  
End Sub  
  
'GPIO-23  
'MOSI  
'VSPI_MOSI  
Public Sub GPIO_23 As Byte  
    Return 23  
End Sub  
  
'GPIO-25  
'ADC2_8  
'DAC_1  
Public Sub GPIO_25 As Byte  
    Return 25  
End Sub  
  
'GPIO-26  
'ADC2_9  
'DAC_2  
Public Sub GPIO_26 As Byte  
    Return 26  
End Sub  
  
'GPIO-27  
'ADC2_7  
'Touch_7  
Public Sub GPIO_27 As Byte  
    Return 27  
End Sub  
  
'GPIO-32  
'ADC1_4  
'Touch_9  
'XTAL32  
Public Sub GPIO_32 As Byte  
    Return 32  
End Sub  
  
'GPIO-33  
'ADC1_5  
'Touch_8  
'XTAL32  
Public Sub GPIO_33 As Byte  
    Return 33  
End Sub  
  
'GPIO-34  
'ADC1_6  
Public Sub GPIO_34 As Byte  
    Return 34  
End Sub  
  
'GPIO-35  
'ADC1_7  
Public Sub GPIO_35 As Byte  
    Return 35  
End Sub  
  
'GPIO-36  
'ADC1_0  
'SENS_VP  
Public Sub GPIO_36 As Byte  
    Return 36  
End Sub  
  
'GPIO-39  
'ADC1_1  
'SENS_VN  
Public Sub GPIO_39 As Byte  
    Return 39  
End Sub
```

[/SPOILER]  
  
As with everything in the B4X Suite, You are free to adapt this to your needs, but do consider sharing your changes with the rest of us