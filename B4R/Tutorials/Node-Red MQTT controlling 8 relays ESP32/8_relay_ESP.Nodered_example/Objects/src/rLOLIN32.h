#pragma once
#include "B4RDefines.h"
//~version: 1.00

namespace B4R {
	
#define EXTERNAL_NUM_INTERRUPTS 16
#define NUM_DIGITAL_PINS        40
#define NUM_ANALOG_INPUTS       16

#define analogInputToDigitalPin(p)  (((p)<20)?(esp32_adc2gpio[(p)]):-1)
#define digitalPinToInterrupt(p)    (((p)<40)?(p):-1)
#define digitalPinHasPWM(p)         (p < 34)

static const Byte LED_BUILTIN = 5;
#define BUILTIN_LED  LED_BUILTIN // backward compatibility

	//~shortname: LolinPins
	//Pins constants for WeMos LOLIN32 boards.
	class LolinPins {
		public:

static const Byte TX = 1;     //D1
static const Byte RX = 3;     //D3

static const Byte SDA = 21;   //D21
static const Byte SCL = 22;   //D22

static const Byte SS    = 5;   //D5
static const Byte MOSI  = 23;  //D23
static const Byte MISO  = 19;  //D19
static const Byte SCK   = 18;  //D18

static const Byte A0 = 36;  //D36 input only
                               //A1, D37 not available
                               //A2, D38 not available
static const Byte A3 = 39;  //D39 input only
static const Byte A4 = 32;  //D32
static const Byte A5 = 33;  //D33
static const Byte A6 = 34;  //D34 input only
static const Byte A7 = 35;  //D35 input only
                               //A8 not existng
                               //A9 not existng
static const Byte A10 = 4;   //ADC2 CH0, D4
static const Byte A11 = 0;   //D0
static const Byte A12 = 2;   //D2
static const Byte A13 = 15;  //D15
static const Byte A14 = 13;  //D13
static const Byte A15 = 12;  //D12
static const Byte A16 = 14;  //D14
static const Byte A17 = 27;  //D27
static const Byte A18 = 25;  //DAC 1, D25
static const Byte A19 = 26;  //DAC 2, D26

static const Byte T0 = 4;    //ADC2 CH0, D4
static const Byte T1 = 0;    //ADC2 CH1, D0
static const Byte T2 = 2;    //ADC2 CH2, D2
static const Byte T3 = 15;   //ADC2 CH3, D15
static const Byte T4 = 13;   //ADC2 CH4, D13
static const Byte T5 = 12;   //
static const Byte T6 = 14;
static const Byte T7 = 27;   //ADC2 CH7, D27
static const Byte T8 = 33;
static const Byte T9 = 32;   //ADC1 CH4, D32

static const Byte DAC1 = 25;//ADC2_CH8, D25
static const Byte DAC2 = 26;//ADC2_CH9, D26

static const Byte D0   = 0;
static const Byte D1   = 1;   //TX
static const Byte D2   = 2;
static const Byte D3   = 3;   //RX
static const Byte D4   = 4;
static const Byte D5   = 5;
//static const Byte D6   = 6;
//static const Byte D7   = 7;
//static const Byte D8   = 8;
static const Byte D12 = 12;  //A15
static const Byte D13 = 13;  //A14
static const Byte D14 = 14;  //A16
static const Byte D15 = 15;  //A13
static const Byte D16 = 16;  //U2RX
static const Byte D17 = 17;  //U2TX
static const Byte D18 = 18;  //SCK
static const Byte D19 = 19;  //MISO
static const Byte D21 = 21;  //SDA
static const Byte D22 = 22;  //SCL
static const Byte D23 = 23;  //MOSI
static const Byte D25 = 25;  //DAC 1, A18
static const Byte D26 = 26;  //DAC 2, A19
static const Byte D27 = 27;  //A17

static const Byte D32 = 32;  //A4
static const Byte D33 = 33;  //A5
static const Byte D34 = 34;  //A6
static const Byte D35 = 35;  //A7	
static const Byte D36 = 36;  //A0
static const Byte D39 = 39;  //A3

//Reads the pin value and returns a value between 0 to X.
//	UInt touchRead();
	
	};
//~shortname: LOLIN32
		class B4RLOLIN32 {
		public:
			void Restart();
	};
}


