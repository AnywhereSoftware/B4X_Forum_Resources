### rControllino by Johan Schoeman
### 04/01/2024
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/160168/)

Attached a working wrap for [**this Github Project**](https://github.com/CONTROLLINO-PLC/CONTROLLINO_Library/tree/master). It is for the Controllino Mega PLC.  
Have wrapped whatever functionality is useful and available in the Controllino.h file (only for the Controllino Mega at present). Please add to this library if you find some additional functionality. But most of the control can be done via standard B4R code.  
  
You can initialize any of the "pins" by the Controllino pin name (see the pop-up help when typing)  
Important - you cannot use the same "pin" simultaneously on both the 5V hearders and the 24V terminals (only one or the other)  
  
The available methods are as follows:  
  

```B4X
            //Initialize the RTC  
            Byte Init();  
            //Set the RTC Date and Time  
            Byte SetTimeDate(Byte aDay, Byte aWeekDay, Byte aMonth, Byte aYear, Byte aHour, Byte aMinute, Byte aSecond);  
            //Get the Day  
            //Returns day 01 - 31, or -1 if the RTC library was not initialized before  
            Byte GetDay();  
            //Get the Weekday  
            //Returns weekday 00 - 06, or -1 if the RTC library was not initialized before  
            Byte GetWeekDay();  
            //Get the Month  
            //Returns month 01 - 12, or -1 if the RTC library was not initialized before  
            Byte GetMonth();  
            //Get the Year  
            //Returns year 00 - 99, or -1 if the RTC library was not initialized before  
            Byte GetYear();  
            //Get the Hour  
            //Returns hours 01 - 12, or 00 - 23 (depending of 12H/24H mode), or -1 if the RTC library was not initialized before  
            Byte GetHour();  
            //Get the Minutes  
            //Returns minutes 00 - 59, or -1 if the RTC library was not initialized before  
            Byte GetMinute();  
            //Get the Seconds  
            //Returns seconds 00 - 59, or -1 if the RTC library was not initialized before  
            Byte GetSecond();  
            //Set the Date and Time by defining the time and date by strings, e.g. "Nov 15 2018", "11:41:02"  
            Byte SetTimeDateStrings(ArrayByte* aDate, ArrayByte* aTime);  
               
            //Initialization of the SPI slave select pin for the RTC chip (RV-2123)  
            //For experienced users only.  
            //Returns 0 when succeeded, or -2 if there is not selected proper CONTROLLINO board  
            Byte RTC_SPI_SLAVE_PIN_INIT();  
               
            //Control of SPI slave select pin for the RTC chip (RV-2123)  
            //mode 0 for RTC chip SPI bus disable, 1 for RTC SPI bus enable  
            //Returns 0 when succeeded, -1 for unsupported mode, or -2 if there is not selected proper CONTROLLINO board  
            Byte RTC_SPI_SLAVE_PIN_CONTROL(Byte mode);  
           
            //Initialization of the RS485 bus  
            //Serial3 still needs to be initialized separately. This only inits RE and DE pins.  
            //Always returns 0  
            Byte RS485Init();          
   
            //Initialization of the RS485 bus with baudrate  
            //Always returns 0  
            Byte RS485Init_with_BaudRate(long aBaudrate);  
  
            //Enable RS485 bus trasmission  
            void RS485TxEnable();  
  
            //Enable RS485 bus reception  
            void RS485RxEnable();  
  
            //Control of RS485 bus RE signal  
            //mode 0 for RS485 Receive Enable Active, 1 for Receive Enable Inactive  
            //Returns 0 when succeeded, -1 for unsupported mode  
            Byte SwitchRS485RE(Byte mode);  
  
            //Control of RS485 bus DE signal  
            //mode 0 for RS485 Data transmission Enable Inactive, 1 for Data transmission Enable Active  
            //Returns 0 when succeeded, -1 for unsupported mode  
            Byte SwitchRS485DE(Byte mode);  
   
            //Reads time and date from RTC chip and prints it on serial line  
            //This function expects that the serial line was initialized before calling it.  
            //Format is DD/MM/YY   HH:MM:SS  
            //Returns seconds 0, or -1 if the RTC library was not initialized before  
            Byte PrintTimeAndDate();  
           
            //Clears alarm interrupt on the RTC chip (RV-2123)  
            //Returns 0 when succeeded, or -1 if the RTC library was not initialized before  
            Byte ClearRTCAlarm();  
           
            //Configures an alarm on the RTC chip (RV-2123)  
            //aHour: 01 - 12, or 00 - 23 (depending of 12H/24H mode)  
            //aMinute:  minutes 00 - 59  
            //Returns 0 when succeeded, or -1 if the RTC library was not initialized before  
            Byte SetRTCAlarm(Byte hour, Byte minute);
```

  
  
Attached a sample project that is using the Controllino Mega onboard Real Time Clock (RTC):  
1. Set date/time (2 methods) of the RTC (Method 1 via Bytes and Method 2 via Strings)  
2. Read date/time from the RTC (methods return Bytes)  
3. Set and clear RTC alarm  
  
B4R lib files also attached.  
  
  
  

```B4X
            /**  
            *Pin = 70  
            */                  
            Byte CONTROLLINO_ETHERNET_CHIP_SELECT = 70;  
            /**  
            *Pin = 71  
            */      
            Byte CONTROLLINO_ETHERNET_INTERRUPT  = 71;  
            /**  
            *Pin = 71  
            */      
            Byte CONTROLLINO_RTC_CHIP_SELECT  = 72;  
            /**  
            *Pin = 73  
            */      
            Byte CONTROLLINO_RTC_INTERRUPT  = 73;  
            /**  
            *Pin = 74  
            */      
            Byte CONTROLLINO_OVERLOAD  = 74;  
            /**  
            *Pin = 75  
            */      
            Byte CONTROLLINO_RS485_DE  = 75;  
            /**  
            *Pin = 76  
            */      
            Byte CONTROLLINO_RS485_nRE  = 76;  
           
            /**  
            *Pin = 2  
            */      
            Byte CONTROLLINO_PIN_HEADER_PWM_00 = 2;  
            /**  
            *Pin = 2  
            */                  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_00 = 2;  
            /**  
            *Pin = 2  
            */      
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_00 = 2;  
            /**  
            *Pin = 2  
            */                  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_00 = 2;  
           
            /**  
            *Pin = 3  
            */                  
            Byte CONTROLLINO_PIN_HEADER_PWM_01 = 3;  
            /**  
            *Pin = 3  
            */                  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_01 = 3;  
            /**  
            *Pin = 3  
            */                  
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_01 = 3;  
            /**  
            *Pin = 3  
            */                  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_01 = 3;  
  
            /**  
            *Pin = 4  
            */          
            Byte CONTROLLINO_PIN_HEADER_PWM_02 = 4;  
            /**  
            *Pin = 4  
            */                      
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_02  = 4;  
            /**  
            *Pin = 4  
            */                      
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_02  = 4;  
            /**  
            *Pin = 4  
            */                      
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_02  = 4;  
           
            /**  
            *Pin = 5  
            */  
            Byte CONTROLLINO_PIN_HEADER_PWM_03 = 5;  
            /**  
            *Pin = 5  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_03 = 5;  
            /**  
            *Pin = 5  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_03 = 5;  
            /**  
            *Pin = 5  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_03 = 5;  
  
            /**  
            *Pin = 6  
            */  
            Byte CONTROLLINO_PIN_HEADER_PWM_04  = 6;  
            /**  
            *Pin = 6  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_04  = 6;  
            /**  
            *Pin = 6  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_04  = 6;  
            /**  
            *Pin = 6  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_04  = 6;  
  
            /**  
            *Pin = 7  
            */  
            Byte CONTROLLINO_PIN_HEADER_PWM_05 = 7;  
            /**  
            *Pin = 7  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_05 = 7;  
            /**  
            *Pin = 7  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_05 = 7;  
            /**  
            *Pin = 7  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_05 = 7;  
  
            /**  
            *Pin = 8  
            */  
            Byte CONTROLLINO_PIN_HEADER_PWM_06 = 8;  
            /**  
            *Pin = 8  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_06 = 8;  
            /**  
            *Pin = 8  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_06 = 8;  
            /**  
            *Pin = 8  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_06 = 8;  
  
            /**  
            *Pin = 9  
            */  
            Byte CONTROLLINO_PIN_HEADER_PWM_07 = 9;  
            /**  
            *Pin = 9  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_07 = 9;  
            /**  
            *Pin = 9  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_07 = 9;  
            /**  
            *Pin = 9  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_07 = 9;  
  
            /**  
            *Pin = 10  
            */  
            Byte CONTROLLINO_PIN_HEADER_PWM_08 = 10;  
            /**  
            *Pin = 10  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_08 = 10;  
            /**  
            *Pin = 10  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_08 = 10;  
            /**  
            *Pin = 10  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_08 = 10;  
  
            /**  
            *Pin = 11  
            */  
            Byte CONTROLLINO_PIN_HEADER_PWM_09 = 11;  
            /**  
            *Pin = 11  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_09 = 11;  
            /**  
            *Pin = 11  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_09 = 11;  
            /**  
            *Pin = 11  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_09 = 11;  
  
            /**  
            *Pin = 12  
            */  
            Byte CONTROLLINO_PIN_HEADER_PWM_10 = 12;  
            /**  
            *Pin = 12  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_10 = 12;  
            /**  
            *Pin = 12  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_10 = 12;  
            /**  
            *Pin = 12  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_10 = 12;  
  
            /**  
            *Pin = 13  
            */  
            Byte CONTROLLINO_PIN_HEADER_PWM_11 = 13;  
            /**  
            *Pin = 13  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_11 = 13;  
            /**  
            *Pin = 13  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_PWM_11 = 13;  
            /**  
            *Pin = 13  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_OUT_11 = 13;  
  
            /**  
            *Pin = 14  
            */  
            Byte CONTROLLINO_RS485_TX = 14;  
            /**  
            *Pin = 15  
            */  
            Byte CONTROLLINO_RS485_RX = 15;  
            /**  
            *Pin = 16  
            */  
            Byte CONTROLLINO_UART_TX = 16;  
            /**  
            *Pin = 17  
            */  
            Byte CONTROLLINO_UART_RX = 17;  
           
            /**  
            *Pin = 18  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_16 = 18;  
            /**  
            *Pin = 18  
            */  
            Byte CONTROLLINO_PIN_HEADER_INT_00 = 18;  
            /**  
            *Pin = 18  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_16 = 18;  
            /**  
            *Pin = 18  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_INT_00 = 18;  
  
            /**  
            *Pin = 19  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_17 = 19;  
            /**  
            *Pin = 19  
            */  
            Byte CONTROLLINO_PIN_HEADER_INT_01 = 19;  
            /**  
            *Pin = 19  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_17 = 19;  
            /**  
            *Pin = 19  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_INT_01 = 19;  
  
  
            /**  
            *Pin = 20  
            */  
            Byte CONTROLLINO_PIN_HEADER_SDA = 20;  
            /**  
            *Pin = 20  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_25 = 20;  
  
            /**  
            *Pin = 21  
            */  
            Byte CONTROLLINO_PIN_HEADER_SCL = 21;  
            /**  
            *Pin = 21  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_24 = 21;  
  
            /**  
            *Pin = 22  
            */  
            Byte CONTROLLINO_RELAY_00 = 22;  
            /**  
            *Pin = 23  
            */  
            Byte CONTROLLINO_RELAY_01 = 23;  
            /**  
            *Pin = 24  
            */  
            Byte CONTROLLINO_RELAY_02 = 24;  
            /**  
            *Pin = 25  
            */  
            Byte CONTROLLINO_RELAY_03 = 25;  
            /**  
            *Pin = 26  
            */  
            Byte CONTROLLINO_RELAY_04 = 26;  
            /**  
            *Pin = 27  
            */  
            Byte CONTROLLINO_RELAY_05 = 27;  
            /**  
            *Pin = 28  
            */  
            Byte CONTROLLINO_RELAY_06 = 28;  
            /**  
            *Pin = 29  
            */  
            Byte CONTROLLINO_RELAY_07 = 29;  
            /**  
            *Pin = 30  
            */  
            Byte CONTROLLINO_RELAY_08 = 30;  
            /**  
            *Pin = 31  
            */  
            Byte CONTROLLINO_RELAY_09 = 31;  
            /**  
            *Pin = 42  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_12 = 42;  
            /**  
            *Pin = 43  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_13 = 43;  
            /**  
            *Pin = 44  
            */  
            Byte CONTROLLINO_PIN_HEADER_PWM_12 = 44;  
            /**  
            *Pin = 44  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_14 = 44;  
            /**  
            *Pin = 45  
            */  
            Byte CONTROLLINO_PIN_HEADER_PWM_13 = 45;  
            /**  
            *Pin = 45  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_15 = 45;  
            /**  
            *Pin = 50  
            */  
            Byte CONTROLLINO_PIN_HEADER_MISO = 50;  
            /**  
            *Pin = 50  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_29 = 50;  
            /**  
            *Pin = 51  
            */      
            Byte CONTROLLINO_PIN_HEADER_MOSI = 51;  
            /**  
            *Pin = 51  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_28 = 51;  
            /**  
            *Pin = 52  
            */  
            Byte CONTROLLINO_PIN_HEADER_SCK  = 52;  
            /**  
            *Pin = 52  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_27 = 52;  
            /**  
            *Pin = 53  
            */  
            Byte CONTROLLINO_PIN_HEADER_SS = 53;  
            /**  
            *Pin = 53  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_OUT_26 = 53;  
           
            /**  
            *Pin = 54  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_00 = 54;  
            /**  
            *Pin = 54  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_00 = 54;  
            /**  
            *Pin = 54  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_ADC_IN_00 = 54;  
            /**  
            *Pin = 54  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_ANALOG_ADC_IN_00 = 54;  
            /**  
            *Pin = 54  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_00 = 54;  
            /**  
            *Pin = 54  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_00 = 54;  
  
  
            /**  
            *Pin = 55  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_01 = 55;  
            /**  
            *Pin = 55  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_01 = 55;  
            /**  
            *Pin = 55  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_ADC_IN_01 = 55;  
            /**  
            *Pin = 55  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_ANALOG_ADC_IN_01 = 55;  
            /**  
            *Pin = 55  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_01 = 55;  
            /**  
            *Pin = 55  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_01 = 55;  
           
            /**  
            *Pin = 56  
            */      
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_02 = 56;  
            /**  
            *Pin = 56  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_02 = 56;  
            /**  
            *Pin = 56  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_ADC_IN_02 = 56;  
            /**  
            *Pin = 56  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_ANALOG_ADC_IN_02 = 56;  
            /**  
            *Pin = 56  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_02 = 56;  
            /**  
            *Pin = 56  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_02 = 56;  
  
  
            /**  
            *Pin = 57  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_03 = 57;  
            /**  
            *Pin = 57  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_03 = 57;  
            /**  
            *Pin = 57  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_ADC_IN_03 = 57;  
            /**  
            *Pin = 57  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_ANALOG_ADC_IN_03 = 57;  
            /**  
            *Pin = 57  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_03 = 57;  
            /**  
            *Pin = 57  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_03 = 57;  
           
           
            /**  
            *Pin = 58  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_04 = 58;  
            /**  
            *Pin = 58  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_04 = 58;  
            /**  
            *Pin = 58  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_ADC_IN_04 = 58;  
            /**  
            *Pin = 58  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_ANALOG_ADC_IN_04 = 58;  
            /**  
            *Pin = 58  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_04 = 58;  
            /**  
            *Pin = 58  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_04 = 58;  
           
           
            /**  
            *Pin = 59  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_05 = 59;  
            /**  
            *Pin = 59  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_05 = 59;  
            /**  
            *Pin = 59  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_ADC_IN_05 = 59;  
            /**  
            *Pin = 59  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_ANALOG_ADC_IN_05 = 59;  
            /**  
            *Pin = 59  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_05 = 59;  
            /**  
            *Pin = 59  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_05 = 59;  
           
           
            /**  
            *Pin = 60  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_06 = 60;  
            /**  
            *Pin = 60  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_06 = 60;  
            /**  
            *Pin = 60  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_ADC_IN_06 = 60;  
            /**  
            *Pin = 60  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_ANALOG_ADC_IN_06 = 60;  
            /**  
            *Pin = 60  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_06 = 60;  
            /**  
            *Pin = 60  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_06 = 60;  
           
           
            /**  
            *Pin = 61  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_07 = 61;  
            /**  
            *Pin = 61  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_07 = 61;  
            /**  
            *Pin = 61  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_ADC_IN_07 = 61;  
            /**  
            *Pin = 61  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_ANALOG_ADC_IN_07 = 61;  
            /**  
            *Pin = 61  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_07 = 61;  
            /**  
            *Pin = 61  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_07 = 61;  
  
  
            /**  
            *Pin = 62  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_08 = 62;  
            /**  
            *Pin = 62  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_08 = 62;  
            /**  
            *Pin = 62  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_ADC_IN_08 = 62;  
            /**  
            *Pin = 62  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_ANALOG_ADC_IN_08 = 62;  
            /**  
            *Pin = 62  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_08 = 62;  
            /**  
            *Pin = 62  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_08 = 62;  
  
  
            /**  
            *Pin = 63  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_09 = 63;  
            /**  
            *Pin = 63  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_09 = 63;  
            /**  
            *Pin = 63  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_ADC_IN_09 = 63;  
            /**  
            *Pin = 63  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_ANALOG_ADC_IN_09 = 63;  
            /**  
            *Pin = 63  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_09 = 63;  
            /**  
            *Pin = 63  
            */  
            Byte CONTROLLINO_SCREW_TERMINAL_DIGITAL_IN_09 = 63;  
  
  
            /**  
            *Pin = 64  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_10 = 64;  
            /**  
            *Pin = 64  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_10 = 64;  
            /**  
            *Pin = 64  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_10 = 64;  
  
  
            /**  
            *Pin = 65  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_11 = 65;  
            /**  
            *Pin = 65  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_11 = 65;  
            /**  
            *Pin = 65  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_11 = 65;  
           
           
            /**  
            *Pin = 66  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_12 = 66;  
            /**  
            *Pin = 66  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_12 = 66;  
            /**  
            *Pin = 66  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_12 = 66;  
  
  
            /**  
            *Pin = 67  
            */  
            Byte CONTROLLINO_PIN_HEADER_ANALOG_ADC_IN_13 = 67;  
            /**  
            *Pin = 67  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_ADC_IN_13 = 67;  
            /**  
            *Pin = 67  
            */  
            Byte CONTROLLINO_PIN_HEADER_DIGITAL_IN_13 = 67;  
  
            /**  
            *Pin = 2  
            */  
            Byte CONTROLLINO_D0 = 2;  
            /**  
            *Pin = 3  
            */  
            Byte CONTROLLINO_D1 = 3;  
            /**  
            *Pin = 4  
            */  
            Byte CONTROLLINO_D2 = 4;  
            /**  
            *Pin = 5  
            */  
            Byte CONTROLLINO_D3 = 5;  
            /**  
            *Pin = 6  
            */  
            Byte CONTROLLINO_D4 = 6;  
            /**  
            *Pin = 7  
            */  
            Byte CONTROLLINO_D5 = 7;  
            /**  
            *Pin = 8  
            */  
            Byte CONTROLLINO_D6 = 8;  
            /**  
            *Pin = 9  
            */  
            Byte CONTROLLINO_D7 = 9;  
            /**  
            *Pin = 10  
            */  
            Byte CONTROLLINO_D8 = 10;  
            /**  
            *Pin = 11  
            */  
            Byte CONTROLLINO_D9 = 11;  
            /**  
            *Pin = 12  
            */  
            Byte CONTROLLINO_D10 = 12;  
            /**  
            *Pin = 13  
            */  
            Byte CONTROLLINO_D11 = 13;  
            /**  
            *Pin = 42  
            */  
            Byte CONTROLLINO_D12 = 42;  
            /**  
            *Pin = 43  
            */  
            Byte CONTROLLINO_D13 = 43;  
            /**  
            *Pin = 44  
            */  
            Byte CONTROLLINO_D14 = 44;  
            /**  
            *Pin = 45  
            */  
            Byte CONTROLLINO_D15 = 45;  
            /**  
            *Pin = 46  
            */  
            Byte CONTROLLINO_D16 = 46;  
            /**  
            *Pin = 47  
            */  
            Byte CONTROLLINO_D17 = 47;  
            /**  
            *Pin = 48  
            */  
            Byte CONTROLLINO_D18 = 48;  
            /**  
            *Pin = 49  
            */  
            Byte CONTROLLINO_D19 = 49;  
            /**  
            *Pin = 77  
            */  
            Byte CONTROLLINO_D20 = 77;  
            /**  
            *Pin = 78  
            */  
            Byte CONTROLLINO_D21 = 78;  
            /**  
            *Pin = 79  
            */  
            Byte CONTROLLINO_D22 = 79;  
            /**  
            *Pin = 80  
            */  
            Byte CONTROLLINO_D23 = 80;  
            /**  
            *Pin = 54  
            */  
            Byte CONTROLLINO_A0 = 54;  
            /**  
            *Pin = 55  
            */  
            Byte CONTROLLINO_A1 = 55;  
            /**  
            *Pin = 56  
            */  
            Byte CONTROLLINO_A2 = 56;  
            /**  
            *Pin = 57  
            */  
            Byte CONTROLLINO_A3 = 57;  
            /**  
            *Pin = 58  
            */  
            Byte CONTROLLINO_A4 = 58;  
            /**  
            *Pin = 59  
            */  
            Byte CONTROLLINO_A5 = 59;  
            /**  
            *Pin = 60  
            */  
            Byte CONTROLLINO_A6 = 60;  
            /**  
            *Pin = 61  
            */  
            Byte CONTROLLINO_A7 = 61;  
            /**  
            *Pin = 62  
            */  
            Byte CONTROLLINO_A8 = 62;  
            /**  
            *Pin = 63  
            */  
            Byte CONTROLLINO_A9 = 63;  
            /**  
            *Pin = 64  
            */  
            Byte CONTROLLINO_A10 = 64;  
            /**  
            *Pin = 65  
            */  
            Byte CONTROLLINO_A11 = 65;  
            /**  
            *Pin = 66  
            */  
            Byte CONTROLLINO_A12 = 66;  
            /**  
            *Pin = 67  
            */  
            Byte CONTROLLINO_A13 = 67;  
            /**  
            *Pin = 68  
            */  
            Byte CONTROLLINO_A14 = 68;  
            /**  
            *Pin = 69  
            */  
            Byte CONTROLLINO_A15 = 69;  
            /**  
            *Pin = 38  
            */  
            Byte CONTROLLINO_I16 = 38;  
            /**  
            *Pin = 39  
            */  
            Byte CONTROLLINO_I17 = 39;  
            /**  
            *Pin = 40  
            */  
            Byte CONTROLLINO_I18 = 40;  
            /**  
            *Pin = 18  
            */  
            Byte CONTROLLINO_IN0 = 18;  
            /**  
            *Pin = 19  
            */  
            Byte CONTROLLINO_IN1 = 19;  
  
            /**  
            *Pin = 14  
            */  
            Byte CONTROLLINO_MINUS = 14;  
            /**  
            *Pin = 15  
            */  
            Byte CONTROLLINO_PLUS = 15;  
  
            /**  
            *Pin = 22  
            */  
            Byte CONTROLLINO_R0 = 22;  
            /**  
            *Pin = 23  
            */  
            Byte CONTROLLINO_R1 = 23;  
            /**  
            *Pin = 24  
            */  
            Byte CONTROLLINO_R2 = 24;  
            /**  
            *Pin = 25  
            */  
            Byte CONTROLLINO_R3 = 25;  
            /**  
            *Pin = 26  
            */  
            Byte CONTROLLINO_R4 = 26;  
            /**  
            *Pin = 27  
            */  
            Byte CONTROLLINO_R5 = 27;  
            /**  
            *Pin = 28  
            */  
            Byte CONTROLLINO_R6 = 28;  
            /**  
            *Pin = 29  
            */  
            Byte CONTROLLINO_R7 = 29;  
            /**  
            *Pin = 30  
            */  
            Byte CONTROLLINO_R8 = 30;  
            /**  
            *Pin = 31  
            */  
            Byte CONTROLLINO_R9 = 31;  
            /**  
            *Pin = 32  
            */  
            Byte CONTROLLINO_R10 = 32;  
            /**  
            *Pin = 33  
            */  
            Byte CONTROLLINO_R11 = 33;  
            /**  
            *Pin = 34  
            */  
            Byte CONTROLLINO_R12 = 34;  
            /**  
            *Pin = 35  
            */  
            Byte CONTROLLINO_R13 = 35;  
            /**  
            *Pin = 36  
            */  
            Byte CONTROLLINO_R14 = 36;  
            /**  
            *Pin = 37  
            */  
            Byte CONTROLLINO_R15 = 37;
```

  
  
  
Sample Project code:  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 300  
#End Region  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
  
Sub Process_Globals  
   
    Public Serial1 As Serial  
    Dim aDay , aWeekDay, aMonth, aYear, aHour, aMinute, aSecond As Byte  
  
    Dim t As Timer  
   
    Dim p As Pin                  'will be using it for cont_rtc.CONTROLLINO_D0  
   
    Dim p2 As Pin                 'RTC Alarm Interrupt (cont_rtc.CONTROLLINO_RTC_INTERRUPT)  
   
    Dim p3 As Pin  
   
    Dim cont_rtc As CONTROLLINO   'Get an instance of the CONTROLLINO library  
   
  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
   
    cont_rtc.Init                  'initialize the RTC  
   
    cont_rtc.ClearRTCAlarm         'clear all RTC alarms  
   
    t.Initialize("t_tick", 1000)   'timer runs every 1 second  
   
    p.Initialize(cont_rtc.CONTROLLINO_D0, p.MODE_OUTPUT)    'it will just blink the D0 LED in the timer  
   
    p3.Initialize(cont_rtc.CONTROLLINO_D16, p3.MODE_OUTPUT)  
   
    aDay = 25  
    aWeekDay = 1  
    aMonth = 2  
    aYear = 24  
    aHour = 18  
    aMinute = 26  
    aSecond = 0  
   
    'Method 1 to set date and time  
    'cont_rtc.SetTimeDate(aDay, aWeekDay, aMonth, aYear, aHour, aMinute, aSecond)  
  
    'Method 2 to set date and time  
    Dim datum() As Byte = "Mar 29 2024"  
    Dim tyd() As Byte = "14:58:45"  
    Dim err As Byte = cont_rtc.SetTimeDateStrings(datum, tyd)  
    Log("err = ", err)  
   
    p2.Initialize(cont_rtc.CONTROLLINO_RTC_INTERRUPT, p2.MODE_INPUT_PULLUP)    'pull the CONTROLLINO_RTC_INTERRUPT pin HIGH (see the hover help - it is pin 73)  
    Dim alarmset As Byte = cont_rtc.SetRTCAlarm(14, 59)    'set the time that the alarm should be triggered (RTC time - it is not relative to current RTC time but actual time)  
    If alarmset = 0 Then  
        p3.DigitalWrite(True)                             'if the alarm has been set then light up the LED of pin CONTROLLINO_D16  
    End If  
    t.Enabled = True                     'enable the timer  
   
End Sub  
  
Sub t_tick  
   
    p.DigitalWrite(Not(p.DigitalRead))    'blink the LED of D0  
   
    cont_rtc.PrintTimeAndDate             'prints the date and time to the log (eg 29/3/24   11:14:28)  
   
    aDay = cont_rtc.GetDay                'get the Day of the month  
    aWeekDay = cont_rtc.GetWeekDay        'get the weekday of the date (0 = Sun, 6 = Sat)  
    aMonth = cont_rtc.GetMonth            'get the month (1 to 12)  
    aYear = cont_rtc.GetYear              'get the year (it returns the last 2 digits eg 24 for 2024)  
    aHour = cont_rtc.GetHour              'get the hour (1 to 12 or 0 to 23)  
    aMinute = cont_rtc.GetMinute          'get the minutes (0 to 59)  
    aSecond = cont_rtc.GetSecond          'get the seconds (0 to 59)  
   
    Log("aDay = " , aDay)                 'log what was read from the RTC  
    Log("aWeekday = " , aWeekDay)  
    Log("aMonth = " , aMonth)  
    Log("aYear = " , aYear)  
    Log("aHour = " , aHour)  
    Log("aMinute = " , aMinute)  
    Log("aSecond = " , aSecond)  
    Log(" ")  
   
    If p2.DigitalRead = False Then       'P2 was pulled HIGH when initialized - Once the alarm trigger is will be pulled LOW  
        cont_rtc.ClearRTCAlarm           'Clear the alarm after it was triggered  
        Log("Alarm triggered!")          'Log Alaram Triggered  
        p3.DigitalWrite(False)           'switch off the LED of pin CONTROLLINO_D16 when the alarm was triggered  
       
        If aMinute < 59 Then  
            t.Enabled = False  
            Delay(500)  
            cont_rtc.SetRTCAlarm(aHour, aMinute + 1)  
            t.Enabled = True  
            p3.DigitalWrite(True)               'switch on the LED of CONTROLLINO_D16  
        Else if aMinute = 59 Then  
            t.Enabled = False  
            Delay(500)  
            cont_rtc.SetRTCAlarm(aHour + 1 , 0)    'switch on the LED of CONTROLLINO_D16  
            t.Enabled = True  
            p3.DigitalWrite(True)  
        End If  
       
    End If  
  
   
End Sub
```