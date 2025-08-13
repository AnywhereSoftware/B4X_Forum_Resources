//~B4R Library: 	rIRRemote
//~Brief:			A library for sending & receiving infra-red signals based on the Arduino IRremote library.
//~Library wrapped:	https://github.com/Arduino-IRremote/Arduino-IRremote (partial wrapped, LICENSE: Up to the version 2.7.0, the License is GPLv2. From the version 2.8.0, the license is the MIT license).
//~Author: 			Robert W.B. Linn
//~Date: 			20250530
//~Notes: 			Inlude the hpp header and not the h header. This is done in the CPP file rIRRemote.cpp to avoid the linker error "multiple definitions of ...".

#pragma once
#include "B4RDefines.h"

// Defines actual pin number for pins like IR_RECEIVE_PIN, IR_SEND_PIN for many different boards and architectures
#include "PinDefinitionsAndMore.h"

namespace B4R {

	/**
	 * B4RIrDecodedData
	 */

	//~Version: 0.84
	//~Shortname: IrDecodedData
	class B4RIrDecodedData {
		public:
			// Struct selected members from enum IRData (see IRProtocol.h)
			// with additions: protocolname (get name from protocol, i.e 8=NEC)
			int Protocol;
			B4RString* ProtocolName;
			UInt Address;
			UInt Command;
			UInt Extra;
			UInt NumberOfBits;
			Byte Flags;
			UInt RawDataLen;
			ULong RawDataDecoded;
			UInt InitialGapTicks; 
			
			// Special for protocol PULSE_DISTANCE using the DistanceWidthTimingInfoStruct (see IRProtocol.h)			
			UInt PulseDistanceHeaderMarkMicros;
			UInt PulseDistanceHeaderSpaceMicros;
			UInt PulseDistanceOneMarkMicros;
			UInt PulseDistanceOneSpaceMicros;
			UInt PulseDistanceZeroMarkMicros;
			UInt PulseDistanceZeroSpaceMicros;
	};
	typedef void (*SubVoidIrDecodedData)(B4RIrDecodedData* Result) ;

	/**
	 * IrReceiver
	 */

	//~ShortName: IrReceiver
	//~Event: DecodedData (Data As B4RIrDecodedData)
	class B4RIrReceiver { 
		private:
			// B4R callback event
			SubVoidIrDecodedData IrDecodedDataSub;

			// Looper
			PollerNode pnode;
			static void looper(void* b);
			
			// Various
			bool enableProtocolUnknown;
			bool dumpToSerial;						// Option to write the received data to the serial line in JSON format
			unsigned long lastReceivedTime;			// Time in millis of the last received data
			unsigned int repeatCount;				// Number of repeats of the received data

		public:
			/**
			 * Initialize the IR Receiver object.
			 * The IR receiver pin is default 2 (example Arduino UNO) (see PinDefinitionsAndMore.h).
			 * IrDecodedDataSub - The sub that will handle the callback event. NOTE: Only for known protocols and not for noise or protocol UNKNOWN.
			 */
			void Initialize(SubVoidIrDecodedData IrDecodedDataSub);

			/**
			 * Get the protocol as string.
			 * ProtocolId - Type as defined by the protocol enum decode_type_t in IRProtocol.h
			 */
			B4RString* GetProtocolString(int ProtocolType);

			/**
			 * Enable protocol UNKNOWN.
			 * Show unknow protocol data in the B4R callback event.
			 */
			void setEnableProtocolUnknown(bool state);
			bool getEnableProtocolUnknown();

			/**
			 * Enable to dump the received data to the serial line.
			 * The data received is converted to JSON string.
			 */
			void setDumpToSerial(bool state);
			bool getDumpToSerial();

			//~hide
			void DumpToSerialJson(void);

			//~hide
			B4RString* StringToB4R(String* o);

			/**
			 * DEFINES and additional CONSTANTS
			 */

			/**
			 * LED
			 */
			#define /*Byte UNKNOWN;*/ 						B4RIrReceiver_UNKNOWN 0 
			#define /*Byte DISABLE_LED_FEEDBACK;*/       	B4RIrReceiver_DISABLE_LED_FEEDBACK false
			#define /*Byte ENABLE_LED_FEEDBACK;*/       	B4RIrReceiver_ENABLE_LED_FEEDBACK true
			#define /*Byte USE_DEFAULT_FEEDBACK_LED_PIN;*/	B4RIrReceiver_USE_DEFAULT_FEEDBACK_LED_PIN 0
			#define /*Byte NO_REPEATS;*/					B4RIrReceiver_NO_REPEATS 0
						
			/**
			 * IRDATA_FLAGS. The comments are taken from the source IRProtocol.h.
			 */
			 
			#define /*Byte IRDATA_FLAGS_EMPTY;*/ 				B4RIrReceiver_IRDATA_FLAGS_EMPTY 0x00
			// The gap between the preceding frame is as smaller than the maximum gap expected for a repeat.
			// !!!We do not check for changed command or address, because it is almost not possible to press 2 different buttons on the remote within around 100 ms!!!
			#define /*Byte IRDATA_FLAGS_IS_REPEAT;*/          	B4RIrReceiver_IRDATA_FLAGS_IS_REPEAT 0x01 
			// The current repeat frame is a repeat, that is always sent after a regular frame and cannot be avoided. Only specified for protocols DENON, and LEGO.			
			#define /*Byte IRDATA_FLAGS_IS_AUTO_REPEAT;*/     	B4RIrReceiver_IRDATA_FLAGS_IS_AUTO_REPEAT 0x02 
			// The current (autorepeat) frame violated parity check.
			#define /*Byte IRDATA_FLAGS_PARITY_FAILED;*/      	B4RIrReceiver_IRDATA_FLAGS_PARITY_FAILED 0x04 
			// Is set if RC5 or RC6 toggle bit is set.
			#define /*Byte IRDATA_FLAGS_TOGGLE_BIT;*/			B4RIrReceiver_IRDATA_FLAGS_TOGGLE_BIT 0x08 
			// deprecated -is set if RC5 or RC6 toggle bit is set.
			#define /*Byte IRDATA_TOGGLE_BIT_MASK;*/          	B4RIrReceiver_IRDATA_TOGGLE_BIT_MASK 0x08 
			// There is extra info not contained in address and data (e.g. Kaseikyo unknown vendor ID, or in decodedRawDataArray).
			#define /*Byte IRDATA_FLAGS_EXTRA_INFO;*/         	B4RIrReceiver_IRDATA_FLAGS_EXTRA_INFO 0x10 
			// Here we have a repeat of type NEC2 or SamsungLG
			#define /*Byte IRDATA_FLAGS_IS_PROTOCOL_WITH_DIFFERENT_REPEAT;*/ B4RIrReceiver_IRDATA_FLAGS_IS_PROTOCOL_WITH_DIFFERENT_REPEAT 0x20 
			// irparams.rawlen is set to 0 in this case to avoid endless OverflowFlag.
			#define /*Byte IRDATA_FLAGS_WAS_OVERFLOW;*/       	B4RIrReceiver_IRDATA_FLAGS_WAS_OVERFLOW 0x40 
			// Value is mainly determined by the (known) protocol.
			#define /*Byte IRDATA_FLAGS_IS_MSB_FIRST;*/       	B4RIrReceiver_IRDATA_FLAGS_IS_MSB_FIRST 0x80 
			// Value is mainly determined by the (known) protocol.
			#define /*Byte IRDATA_FLAGS_IS_LSB_FIRST;*/       	B4RIrReceiver_IRDATA_FLAGS_IS_LSB_FIRST 0x00

			// Short delay 40ms after data has been received to avoid multiple data received within short timeframe.
			ULong DELAY_SHORT_AFTER_RECEIVE = 40;
			// Long delay 2000ms (2s) after data has been receive to avoid multiple data received within short timeframe.
			ULong DELAY_LONG_AFTER_RECEIVE = 1000;	
			
			/**
			 * PROTOCOLS taken from IRProtocol.h enum decode_type_t
			 * IMPORTANT: The codes are hardcoded from the enum, but if the enum changes the codes below must be changed accordingly.
			 * Numbering starts with 0.
			 */

			UInt PROTOCOL_UNKNOWN 				= 0;
			UInt PROTOCOL_PULSE_WIDTH 			= 1;
			UInt PROTOCOL_PULSE_DISTANCE 		= 2;
			UInt PROTOCOL_APPLE 				= 3;
			UInt PROTOCOL_DENON 				= 4;
			UInt PROTOCOL_JVC 					= 5;
			UInt PROTOCOL_LG 					= 6;
			UInt PROTOCOL_LG2 					= 7;
			UInt PROTOCOL_NEC 					= 8;
			UInt PROTOCOL_NEC2 					= 9;
			UInt PROTOCOL_ONKYO 				= 10;
			UInt PROTOCOL_PANASONIC 			= 11;
			UInt PROTOCOL_KASEIKYO 				= 12;
			UInt PROTOCOL_KASEIKYO_DENON 		= 13;
			UInt PROTOCOL_KASEIKYO_SHARP 		= 14;
			UInt PROTOCOL_KASEIKYO_JVC 			= 15;
			UInt PROTOCOL_KASEIKYO_MITSUBISHI	= 16;
			UInt PROTOCOL_RC5 					= 17;
			UInt PROTOCOL_RC6 					= 18;
			UInt PROTOCOL_RC6A 					= 19;
			UInt PROTOCOL_SAMSUNG 				= 20;
			UInt PROTOCOL_SAMSUNGLG 			= 21;
			UInt PROTOCOL_SAMSUNG48 			= 22;
			UInt PROTOCOL_SHARP 				= 23;
			UInt PROTOCOL_SONY 					= 24;
			UInt PROTOCOL_BANG_OLUFSEN 			= 25;
			UInt PROTOCOL_BOSEWAVE 				= 26;
			UInt PROTOCOL_LEGO_PF 				= 27;
			UInt PROTOCOL_MAGIQUEST 			= 28;
			UInt PROTOCOL_WHYNTE 				= 29;
			UInt PROTOCOL_FAST 					= 30;
	};


	/**
	 * IrSender
	 */

	//~Shortname: IrSender
	class B4RIrSender {
		private:

		public:
		
			/**
			 * Init the IR sender.
			 * The IR sender pin is default 3 (Example Arduino) (see PinDefinitionsAndMore.h).
			 */
			void Initialize(void);

			/**
			 * NEC Send frame and special repeats.
			 * There is NO delay after the last sent repeat.
			 * NumberOfRepeats  - If less 0 then only a special NEC repeat frame will be sent by calling NECProtocolConstants.SpecialSendRepeatFunction.
			 */
			void SendNEC(UInt Address, UInt Command, int NumberOfRepeats);

			/**
			 * Sends NEC protocol
			 * NumberOfRepeats  If less 0 then only a special repeat frame without leading and trailing space will be sent by calling NECProtocolConstants.SpecialSendRepeatFunction.
			 */
			void SendNECRaw(ULong RawData, int NumberOfRepeats);

			/**
			 * NumberOfRepeats=NO_REPEATS
			 * NumberOfHeaderBits = 8
			 */
			void SendBangOlufsen(UInt Header, UInt Data, int NumberOfRepeats, Byte NumberOfHeaderBits );

			/**
			 * NumberOfRepeats=NO_REPEATS
			 */
			void SendBoseWave(UInt Command, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendDenon(UInt Address, UInt Command, int NumberOfRepeats, UInt SendSharpFrameMarker);
			
			/**
			 * 
			 */
			void SendFAST(Byte aCommand, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendJVC(Byte Address, Byte Command, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendOnkyo(UInt Address, UInt Command, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendApple(UInt Address, UInt Command, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendKaseikyo(UInt Address, Byte Data, int NumberOfRepeats, UInt VendorCode);
			 
			/**
			 * 
			 */
			void SendPanasonic(UInt Address, Byte Data, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendKaseikyo_Denon(UInt Address, Byte Data, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendKaseikyo_Mitsubishi(UInt Address, Byte Data, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendKaseikyo_Sharp(UInt Address, Byte Data, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendKaseikyo_JVC(UInt Address, Byte Data, int NumberOfRepeats);
			 
			/**
			 * EnableAutomaticToggle=true
			 */
			void SendRC5(Byte Address, Byte Command, int NumberOfRepeats, bool aEnableAutomaticToggle);
			 
			/**
			 * EnableAutomaticToggle=true
			 */
			void SendRC6(Byte Address, Byte Command, int NumberOfRepeats, bool aEnableAutomaticToggle);
			 
			/**
			 * EnableAutomaticToggle=true
			 */
			void SendRC6A(Byte Address, Byte Command, int NumberOfRepeats, UInt Customer, bool aEnableAutomaticToggle);
			 
			/**
			 * 
			 */
			void SendSamsung(UInt Address, UInt Command, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendSamsung16BitAddressAnd8BitCommand(UInt Address, Byte Command, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendSamsung16BitAddressAndCommand(UInt Address, UInt Command, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendSamsung48(UInt Address, ULong Command, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendSamsungLG(UInt Address, UInt Command, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendSharp(UInt Address, Byte Command, int NumberOfRepeats);
			 
			/**
			 * numberOfBits=12
			 */
			void SendSony(UInt Address, Byte Command, int NumberOfRepeats, Byte numberOfBits);
			 
			/**
			 * DoSend5Times=true
			 */
			void SendLegoPowerFunctions(Byte Channel, Byte Command, Byte Mode, bool DoSend5Times);
			 
			/**
			 * DoSend5Times=true
			 */
			void SendLegoPowerFunctions2(UInt RawData, bool DoSend5Times);
			 
			/**
			 * DoSend5Times=true
			 */
			void SendLegoPowerFunctions3(UInt RawData, Byte Channel, bool DoSend5Times);
			 
			/**
			 * 
			 */
			void SendMagiQuest(ULong WandId, UInt Magnitude);
			 
			/**
			 * NumberOfRepeats=NO_REPEATS
			 */
			void SendPronto (UInt *data, UInt length, int NumberOfRepeats);
			 
			/**
			 * 
			 */
			void SendShuzu(UInt Address, Byte Command, int NumberOfRepeats);
			 			 
			/**
			 * 
			 */
			void SendDish(UInt Data);
			 
			/**
			 * 
			 */
			void SendWhynter(ULong Data, Byte NumberOfBitsToSend);

			/**
			 * RAW
			 */

			/**
			 * Sends a 16 byte microsecond timing array.
			 */
			 void SendRawWithMicroseconds(B4R::ArrayUInt* BufferWithMicroseconds, int IRFrequencyKilohertz);

			/**
			 * PULSE_DISTANCE
			 */

			/**
			 * Sends PulseDistance frames and repeats.
			 * @param aFrequencyKHz, aHeaderMarkMicros, aHeaderSpaceMicros, aOneMarkMicros, aOneSpaceMicros, aZeroMarkMicros, aZeroSpaceMicros, aFlags, aRepeatPeriodMillis  
			 * Values to use for sending this protocol, also contained in the PulseDistanceWidthProtocolConstants of this protocol.
			 * @param aData             uint32 or uint64 holding the bits to be sent.
			 * @param aNumberOfBits     Number of bits from aData to be actually sent.
			 * @param aFlags            Evaluated flags are PROTOCOL_IS_MSB_FIRST and SUPPRESS_STOP_BIT. Stop bit is otherwise sent for all pulse distance protocols.
			 * @param aNumberOfRepeats  If less 0 and a aProtocolConstants->SpecialSendRepeatFunction() is specified then it is called without leading and trailing space.
			 * SpecialSendRepeatFunction is not defined (nullptr).
			 */
			void SendPulseDistanceWidth(UInt FrequencyKHz, UInt HeaderMarkMicros, UInt HeaderSpaceMicros, UInt OneMarkMicros, UInt OneSpaceMicros, UInt ZeroMarkMicros, UInt ZeroSpaceMicros, ULong Data, UInt NumberOfBits, Byte Flags, UInt RepeatPeriodMillis, UInt NumberOfRepeats);
				
			/**
			 * Defines
			 */
			
			#define /*Byte DISABLE_LED_FEEDBACK;*/       	B4RIrSender_DISABLE_LED_FEEDBACK false
			#define /*Byte ENABLE_LED_FEEDBACK;*/       	B4RIrSender_ENABLE_LED_FEEDBACK true
			#define /*Byte USE_DEFAULT_FEEDBACK_LED_PIN;*/	B4RIrSender_USE_DEFAULT_FEEDBACK_LED_PIN 0
			#define /*Byte NO_REPEATS;*/					B4RIrSender_NO_REPEATS 0
			#define /*Byte SIRCS_12_PROTOCOL;*/				B4RIrSender_SIRCS_12_PROTOCOL 12
			#define /*Byte SIRCS_15_PROTOCOL;*/				B4RIrSender_SIRCS_15_PROTOCOL 15
			#define /*Byte SIRCS_20_PROTOCOL;*/				B4RIrSender_SIRCS_20_PROTOCOL 20

			// Definitions for member PulseDistanceWidthProtocolConstants.Flags

			// Stop bit is otherwise sent for all pulse distance protocols, i.e. aOneSpaceMicros != aZeroSpaceMicros.
			#define /*Byte SUPPRESS_STOP_BIT;*/				B4RIrSender_SUPPRESS_STOP_BIT       0x20
			#define /*Byte PROTOCOL_IS_MSB_FIRST;*/			B4RIrSender_PROTOCOL_IS_MSB_FIRST   B4RIrReceiver_IRDATA_FLAGS_IS_MSB_FIRST
			#define /*Byte PROTOCOL_IS_LSB_FIRST;*/			B4RIrSender_PROTOCOL_IS_LSB_FIRST   B4RIrReceiver_IRDATA_FLAGS_IS_LSB_FIRST
			
			#define /*Byte SONY_KHZ;*/						B4RIrSender_SONY_KHZ        40
			#define /*Byte BOSEWAVE_KHZ;*/					B4RIrSender_BOSEWAVE_KHZ    38
			#define /*Byte DENON_KHZ;*/						B4RIrSender_DENON_KHZ       38
			#define /*Byte JVC_KHZ;*/						B4RIrSender_JVC_KHZ         38
			#define /*Byte LG_KHZ;*/						B4RIrSender_LG_KHZ          38
			#define /*Byte NEC_KHZ;*/						B4RIrSender_NEC_KHZ         38
			#define /*Byte SAMSUNG_KHZ;*/					B4RIrSender_SAMSUNG_KHZ     38
			#define /*Byte KASEIKYO_KHZ;*/					B4RIrSender_KASEIKYO_KHZ    37
			#define /*Byte RC5_RC6_KHZ;*/					B4RIrSender_RC5_RC6_KHZ     36

			// Short delay 40ms after data has been sent.
			ULong DELAY_SHORT_AFTER_SEND = 40;
			// Long delay 2000ms (2s) after data has been sent.
			ULong DELAY_LONG_AFTER_SEND = 2000;

	};
}
