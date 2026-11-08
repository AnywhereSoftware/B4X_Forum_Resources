#include "B4RDefines.h"

// Option to set own send pin
// Undefine the IR_SEND_PIN to be able to set the pin in IrSend.Begin(pin) (see https://github.com/Arduino-IRremote/Arduino-IRremote > Send Pin)
// #undef IR_SEND_PIN

// In any other file define prior including hpp file.
// #define USE_IRREMOTE_HPP_AS_PLAIN_INCLUDE
#include <IRremote.hpp>

// Used to get the protocol as string (defined as arraystring, see function GetProtocolString)
#include <IRProtocol.hpp>

namespace B4R {

	/**
	 * IRRECEIVER
	 */

	
	void B4RIrReceiver::Initialize(SubVoidIrDecodedData IrDecodedDataSub) {

		// Assign the default receiver pin as defined in PinDefinitionsAndMore.h
		::Serial.print("[rIRRemoteEx IrReceiver Initialize] IrReceiverPin=");
		::Serial.println(IR_RECEIVE_PIN);

		// Do not listen to protocol unknown per default.
		this->enableProtocolUnknown = false;

		// Do not dump the output to serial and reset the millis & repeat count of the last data received
		this->dumpToSerial = false;
		this->lastReceivedTime = 0;
		this->repeatCount = 0;

		// Assign the receiver result event
		if (IrDecodedDataSub != NULL) {
			this->IrDecodedDataSub = IrDecodedDataSub;
			::Serial.println("[rIRRemoteEx IrReceiver Initialize] IrDecodedDataSub added");
		} else {
			::Serial.println("[rIRRemoteEx IrReceiver Initialize] IrDecodedDataSub not added");	
		}

		// Start the receiver and if not 3. parameter specified, take LED_BUILTIN pin from the internal boards definition as default feedback LED
		IrReceiver.begin(IR_RECEIVE_PIN, ENABLE_LED_FEEDBACK);
		::Serial.print("[rIRRemoteEx IrReceiver Initialize] Ready to receive IR signals of protocols: ");
		printActiveIRProtocols(&::Serial);
		::Serial.println();

		// Setup the looper for the B4R callback event
		FunctionUnion fu;
		fu.PollerFunction = looper;
		pnode.functionUnion = fu;
		pnode.tag = this;
		if (pnode.next == NULL) {
			pollers.add(&pnode);
		}		
	}
	
	void B4RIrReceiver::setEnableProtocolUnknown(bool state) {
		enableProtocolUnknown = state;
	}
	bool B4RIrReceiver::getEnableProtocolUnknown() {
		return enableProtocolUnknown;
	}

	void B4RIrReceiver::setDumpToSerial(bool state) {
		dumpToSerial = state;
	}
	bool B4RIrReceiver::getDumpToSerial() {
		return dumpToSerial;
	}

	void B4RIrReceiver::DumpToSerialJson(void) {
		::Serial.print("{");

		::Serial.print("\"protocol\":\"");
		// Handle special cases
		if (IrReceiver.decodedIRData.protocol == NEC && IrReceiver.decodedIRData.address > 0xFF) {
			::Serial.print("NECEXT");
		} else {
			::Serial.print(getProtocolString(IrReceiver.decodedIRData.protocol));
		}
		::Serial.print("\",");

		//if (IrReceiver.decodedIRData.protocol != UNKNOWN) {
		::Serial.print("\"address\":\"");
		::Serial.print(IrReceiver.decodedIRData.address, HEX);
		::Serial.print("\",\"command\":\"");
		::Serial.print(IrReceiver.decodedIRData.command, HEX);
		::Serial.print("\",");
		//}

		unsigned long now = millis();
		unsigned long repeatPeriod = now - lastReceivedTime;

		if (IrReceiver.decodedIRData.flags & IRDATA_FLAGS_IS_REPEAT) {
			repeatCount++;
		} else {
			repeatCount = 0;
		}

		lastReceivedTime = now;

		::Serial.print("\"repeatperiod\":");
		::Serial.print(repeatPeriod);
		::Serial.print(",");
		::Serial.print("\"repeatcount\":");
		::Serial.print(repeatCount);
		::Serial.print(",");

		::Serial.print("\"repeat\":");
		bool isRepeat = (IrReceiver.decodedIRData.flags & IRDATA_FLAGS_IS_REPEAT) != 0;
		::Serial.print(isRepeat ? "1" : "0");
		::Serial.print(",");

		::Serial.print("\"bits\":");
		::Serial.print(IrReceiver.decodedIRData.numberOfBits);
		::Serial.print(",");

		::Serial.print("\"flags\":");
		::Serial.print(IrReceiver.decodedIRData.flags);
		::Serial.print(",");

		::Serial.print("\"extra\":");
		::Serial.print(IrReceiver.decodedIRData.extra);
		::Serial.print(",");

		::Serial.print("\"rawdata\":");
		::Serial.print(IrReceiver.decodedIRData.decodedRawData);
		::Serial.print(",");

		uint_fast8_t len = IrReceiver.decodedIRData.rawDataPtr ? IrReceiver.decodedIRData.rawDataPtr->rawlen : 0;

		// Pulses
		uint32_t frameDuration = 0;
		::Serial.print("\"pulses\":[");
		for (uint_fast8_t i = 1; i < len; i++) {
		uint16_t duration = IrReceiver.decodedIRData.rawDataPtr->rawbuf[i] * MICROS_PER_TICK;
		uint8_t level = (i % 2 == 1) ? 1 : 0;
		::Serial.print("{\"level\":");
		::Serial.print(level);
		::Serial.print(",\"duration\":");
		::Serial.print(duration);
		::Serial.print("}");
		if (i < len - 1) ::Serial.print(",");
		frameDuration += duration;
		}
		::Serial.print("],");

		::Serial.print("\"pulsecount\":");
		::Serial.print(len - 1); // since we started at i = 1
		::Serial.print(",");

		::Serial.print("\"frameduration\":");
		::Serial.print(frameDuration);
		::Serial.print(",");

		// Raw ticks
		::Serial.print("\"rawticks\":[");
		for (uint_fast8_t i = 1; i < len; i++) {
		::Serial.print(IrReceiver.decodedIRData.rawDataPtr->rawbuf[i]);
		if (i < len - 1) ::Serial.print(",");
		}
		::Serial.print("],");

		::Serial.print("\"rawtickcount\":");
		::Serial.print(len - 1);
		::Serial.print(",");

		// Header mark and space
		if (len >= 2) {
		::Serial.print("\"headermark\":");
		::Serial.print(IrReceiver.decodedIRData.rawDataPtr->rawbuf[0] * MICROS_PER_TICK);
		::Serial.print(",");
		::Serial.print("\"headerspace\":");
		::Serial.print(IrReceiver.decodedIRData.rawDataPtr->rawbuf[1] * MICROS_PER_TICK);
		::Serial.print(",");
		}

		::Serial.print("\"len\":");
		::Serial.print(len);

		::Serial.println("}");
		
		delay(DELAY_LONG_AFTER_RECEIVE);
	}

	//static
	void B4RIrReceiver::looper(void* b) {
		/**
		 * Check if received data is available and if yes, try to decode it.
		 * Decoded result is in the IrReceiver.decodedIRData structure.
		 *
		 * E.g. command is in IrReceiver.decodedIRData.command
		 * address is in command is in IrReceiver.decodedIRData.address
		 * and up to 32 bit raw data in IrReceiver.decodedIRData.decodedRawData
		 *
		 * In addition the hash data is assigned to the decoded data.
		 */
		if (IrReceiver.decode()) {
			
			// Get irreceiver instance
			B4RIrReceiver* me = (B4RIrReceiver*) b;

			// Check option dumpToSerial
			if (me->dumpToSerial) {
				me->DumpToSerialJson();

				// Call the B4R callback 
				// me->IrDecodedDataSub(&irDecodedData);

				// Get next IR frame
				IrReceiver.resume();

				return;
			}

			// Handle UNKNOWN protocol
			if (IrReceiver.decodedIRData.protocol == UNKNOWN && me->enableProtocolUnknown) {
				::Serial.println("[rIRRemoteEx IrReceiver Looper] Received noise or an unknown (or not yet enabled) protocol");
				// We have an unknown protocol here, print extended info
				IrReceiver.printIRResultRawFormatted(&::Serial, true);					
								
				// Define B4R callback result data.
				// Only selected members taken from the printIRResultRawFormatted
				B4RIrDecodedData irDecodedData;
				irDecodedData.Protocol = UNKNOWN;
				irDecodedData.ProtocolName = me->GetProtocolString(IrReceiver.decodedIRData.protocol);
				irDecodedData.RawDataLen = IrReceiver.decodedIRData.rawlen;
				irDecodedData.InitialGapTicks = IrReceiver.decodedIRData.initialGapTicks; 
				// All other members are not used -> initialize with 0
				irDecodedData.Address = 0;
				irDecodedData.Command = 0;
				irDecodedData.Extra = 0;
				irDecodedData.NumberOfBits = 0;
				irDecodedData.Flags = 0;
				irDecodedData.RawDataDecoded = 0;

				// Log the data
				::Serial.print("[rIRRemoteEx IrReceiver Looper] UNKNOWN data=");
				int i;
				for (i = 0; i < IrReceiver.decodedIRData.rawlen; i++) {
					::Serial.print(i);
					::Serial.print("=");
					::Serial.print(IrReceiver.decodedIRData.rawDataPtr->rawbuf[i]);
					if (i < IrReceiver.decodedIRData.rawlen - 1) { ::Serial.print(","); }
				}
				::Serial.println();

				// Call the B4R callback
				me->IrDecodedDataSub(&irDecodedData);

				// Do it here, to preserve raw data for printing with printIRResultRawFormatted()
				IrReceiver.resume();

			} else {
				// NOT USED to avoid repeat = Early enable receiving of the next IR frame
				// IrReceiver.resume();
			
				::Serial.print("[rIRRemoteEx IrReceiver Looper] irresultshort=");
				IrReceiver.printIRResultShort(&::Serial);
				
				::Serial.print("[rIRRemoteEx IrReceiver Looper] irsendusage=");
				IrReceiver.printIRSendUsage(&::Serial);	

				// Define B4R callback result data using the decodedIRData structure
				B4RIrDecodedData irDecodedData;

				irDecodedData.Protocol = IrReceiver.decodedIRData.protocol;
				irDecodedData.ProtocolName = me->GetProtocolString(IrReceiver.decodedIRData.protocol);
				irDecodedData.Address = IrReceiver.decodedIRData.address;
				irDecodedData.Command = IrReceiver.decodedIRData.command;
				irDecodedData.Extra = IrReceiver.decodedIRData.extra;
				irDecodedData.NumberOfBits = IrReceiver.decodedIRData.numberOfBits;
				irDecodedData.Flags = IrReceiver.decodedIRData.flags;
				irDecodedData.InitialGapTicks = IrReceiver.decodedIRData.initialGapTicks; 
				irDecodedData.RawDataLen = IrReceiver.decodedIRData.rawlen;

				// Print pulses
				::Serial.print("[rIRRemoteEx IrReceiver Looper] pulses=");
				for (int i = 1; i < irDecodedData.RawDataLen; i++) {
					UInt pulseduration = IrReceiver.decodedIRData.rawDataPtr->rawbuf[i] * MICROS_PER_TICK;
					::Serial.print(pulseduration);
					if (i < irDecodedData.RawDataLen - 1) ::Serial.print(",");
				}
				::Serial.println();
				
				// RawDataDecoded contains the result of decodehash to get the proper decoderawdata!
				IrReceiver.decodeHash();
				irDecodedData.RawDataDecoded = IrReceiver.decodedIRData.decodedRawData;
				
				// Handle special protocols which have additional members
				// PulseDistanceWidth - 12 bits (6 UInt a 2 bytes)
				irDecodedData.PulseDistanceHeaderMarkMicros = 0;
				irDecodedData.PulseDistanceHeaderSpaceMicros = 0;
				irDecodedData.PulseDistanceOneMarkMicros = 0;
				irDecodedData.PulseDistanceOneSpaceMicros = 0;
				irDecodedData.PulseDistanceZeroMarkMicros = 0;
				irDecodedData.PulseDistanceZeroSpaceMicros = 0;

				// Pulse distance 12 bits (6 bytes UInt (2 bytes))
				if (irDecodedData.Protocol == PULSE_DISTANCE) {
					irDecodedData.PulseDistanceHeaderMarkMicros = IrReceiver.decodedIRData.DistanceWidthTimingInfo.HeaderMarkMicros;
					irDecodedData.PulseDistanceHeaderSpaceMicros = IrReceiver.decodedIRData.DistanceWidthTimingInfo.HeaderSpaceMicros;				
					irDecodedData.PulseDistanceOneMarkMicros = IrReceiver.decodedIRData.DistanceWidthTimingInfo.OneMarkMicros;				
					irDecodedData.PulseDistanceOneSpaceMicros = IrReceiver.decodedIRData.DistanceWidthTimingInfo.OneSpaceMicros;				
					irDecodedData.PulseDistanceZeroMarkMicros = IrReceiver.decodedIRData.DistanceWidthTimingInfo.ZeroMarkMicros;				
					irDecodedData.PulseDistanceZeroSpaceMicros = IrReceiver.decodedIRData.DistanceWidthTimingInfo.ZeroSpaceMicros;				
				}

				// Call the B4R callback - NOT HERE but only when receiving a known protocol (see below)
				// me->IrDecodedDataSub(&irDecodedData);
				
				// Call the B4R callback 
				me->IrDecodedDataSub(&irDecodedData);

				// Get next IR frame
				IrReceiver.resume();
			}

			/*
			 * Finally, check the received data and perform actions according to the received command
			 */
			if (IrReceiver.decodedIRData.flags & IRDATA_FLAGS_IS_REPEAT) {
				// ::Serial.println("[rIRRemoteEx IrReceiver Looper] Repeat received. Here repeat the same action as before.");
			} else {
				//auto tDecodedRawData = IrReceiver.decodedIRData.decodedRawData; // uint32_t on 8 and 16 bit CPUs and uint64_t on 32 and 64 bit CPUs
				//::Serial.print("[rIRRemoteEx IrReceiver Looper] Raw data received are 0x");
				//::Serial.println(tDecodedRawData);
			}
		}		
	}
	
	B4RString* B4RIrReceiver::GetProtocolString(int ProtocolType){

		// Get the protocol string
		#if defined(__AVR__)
			const __FlashStringHelper* protocol = getProtocolString(ProtocolType);
		#else
			const char* protocol = ProtocolNames[ProtocolType];
		#endif

		// Buffer to hold the protocol name - ensure large enough for the largest name (see IRProtocol.hpp)
		char buffer[21];

		// _P is the version to read from program space
		strncpy_P(buffer, (const char*)protocol, 20);
		//::Serial.print(",name=");
		//::Serial.println(buffer);
		
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(buffer);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}

	B4RString* B4RIrReceiver::StringToB4R(String* o)
	{
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(*o);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}

	/**
	 * IRSENDER
	 */

	void B4RIrSender::Initialize(void) {

		// Assign the default receiver pin as defined in PinDefinitionsAndMore.h
		Byte pin = IR_SEND_PIN;
		::Serial.print("[rIRRemoteEx IrSender Initialize] IrSenderPin=");
		::Serial.println(pin);

		// Start the sender
		IrSender.begin();
	}

	// Send NEC command to address.
	// This function has logging for tests. The other send functions have not.
	void B4RIrSender::SendNEC(UInt Address, UInt Command, int NumberOfRepeats) {
		::Serial.print("[rIRRemoteEx IrSender SendNEC] address=");
		::Serial.print(Address);
		::Serial.print(",command=");
		::Serial.println(Command);
		IrSender.sendNEC(Address, Command, NumberOfRepeats);	
	}
	
	void B4RIrSender::SendNECRaw(ULong RawData, int NumberOfRepeats) {
		IrSender.sendNECRaw(RawData, NumberOfRepeats);
	}

	void B4RIrSender::SendBangOlufsen(UInt Header, UInt Data, int NumberOfRepeats, Byte NumberOfHeaderBits ) {
		IrSender.sendBangOlufsen (Header, Data, NumberOfRepeats, NumberOfHeaderBits);
	}

	void B4RIrSender::SendBoseWave(UInt Command, int NumberOfRepeats) {
		IrSender.sendBoseWave(Command, NumberOfRepeats);
	}

	void B4RIrSender::SendDenon(UInt Address, UInt Command, int NumberOfRepeats, UInt SendSharpFrameMarker) {
		IrSender.sendDenon (Address, Command, NumberOfRepeats, SendSharpFrameMarker);
	}

	void B4RIrSender::SendFAST(Byte Command, int NumberOfRepeats) {
		IrSender.sendFAST(Command, NumberOfRepeats);
	}
	 
	void B4RIrSender::SendJVC(Byte Address, Byte Command, int NumberOfRepeats) {
		IrSender.sendJVC (Address, Command, NumberOfRepeats);
	}
	 
	void B4RIrSender::SendOnkyo(UInt Address, UInt Command, int NumberOfRepeats) {
		IrSender.sendOnkyo (Address, Command, NumberOfRepeats);
	}

	void B4RIrSender::SendApple(UInt Address, UInt Command, int NumberOfRepeats) {
		IrSender.sendApple (Address, Command, NumberOfRepeats);
	}

	void B4RIrSender::SendKaseikyo(UInt Address, Byte Data, int NumberOfRepeats, UInt VendorCode) {
		IrSender.sendKaseikyo (Address, Data, NumberOfRepeats, VendorCode);
	}

	void B4RIrSender::SendPanasonic(UInt Address, Byte Data, int NumberOfRepeats) {
		IrSender.sendPanasonic (Address, Data, NumberOfRepeats);
	}

	void B4RIrSender::SendKaseikyo_Denon(UInt Address, Byte Data, int NumberOfRepeats) {
		IrSender.sendKaseikyo_Denon (Address, Data, NumberOfRepeats);
	}

	void B4RIrSender::SendKaseikyo_Mitsubishi(UInt Address, Byte Data, int NumberOfRepeats) {
		IrSender.sendKaseikyo_Mitsubishi (Address, Data, NumberOfRepeats);
	}

	void B4RIrSender::SendKaseikyo_Sharp(UInt Address, Byte Data, int NumberOfRepeats) {
		IrSender.sendKaseikyo_Sharp (Address, Data, NumberOfRepeats);
	}

	void B4RIrSender::SendKaseikyo_JVC(UInt Address, Byte Data, int NumberOfRepeats) {
		IrSender.sendKaseikyo_JVC (Address, Data, NumberOfRepeats);
	}
	 
	void B4RIrSender::SendRC5(Byte Address, Byte Command, int NumberOfRepeats, bool EnableAutomaticToggle) {
		IrSender.sendRC5 (Address, Command, NumberOfRepeats, EnableAutomaticToggle);
	}

	void B4RIrSender::SendRC6(Byte Address, Byte Command, int NumberOfRepeats, bool EnableAutomaticToggle) {
		IrSender.sendRC6 (Address, Command, NumberOfRepeats, EnableAutomaticToggle);
	}

	void B4RIrSender::SendRC6A(Byte Address, Byte Command, int NumberOfRepeats, UInt Customer, bool EnableAutomaticToggle) {
		IrSender.sendRC6A (Address, Command, NumberOfRepeats, Customer, EnableAutomaticToggle);
	}

	void B4RIrSender::SendSamsung(UInt Address, UInt Command, int NumberOfRepeats) {
		IrSender.sendSamsung (Address, Command, NumberOfRepeats);
	}

	void B4RIrSender::SendSamsung16BitAddressAnd8BitCommand(UInt Address, Byte Command, int NumberOfRepeats) {
		IrSender.sendSamsung16BitAddressAnd8BitCommand (Address, Command, NumberOfRepeats);
	}

	void B4RIrSender::SendSamsung16BitAddressAndCommand(UInt Address, UInt Command, int NumberOfRepeats) {
		IrSender.sendSamsung16BitAddressAndCommand (Address, Command, NumberOfRepeats);
	}

	void B4RIrSender::SendSamsung48(UInt Address, ULong Command, int NumberOfRepeats) {
		IrSender.sendSamsung48 (Address, Command, NumberOfRepeats);
	}

	void B4RIrSender::SendSamsungLG(UInt Address, UInt Command, int NumberOfRepeats) {
		IrSender.sendSamsungLG (Address, Command, NumberOfRepeats);
	}

	void B4RIrSender::SendSharp(UInt Address, Byte Command, int NumberOfRepeats) {
		IrSender.sendSharp (Address, Command, NumberOfRepeats);
	}

	void B4RIrSender::SendSony(UInt Address, Byte Command, int NumberOfRepeats, Byte numberOfBits) {
		IrSender.sendSony (Address, Command, NumberOfRepeats, numberOfBits);
	}

	void B4RIrSender::SendLegoPowerFunctions(Byte Channel, Byte Command, Byte Mode, bool DoSend5Times) {
		IrSender.sendLegoPowerFunctions (Channel, Command, Mode, DoSend5Times);
	}

	void B4RIrSender::SendLegoPowerFunctions2(UInt RawData, bool DoSend5Times) {
		IrSender.sendLegoPowerFunctions (RawData, DoSend5Times);
	}

	void B4RIrSender::SendLegoPowerFunctions3(UInt RawData, Byte Channel, bool DoSend5Times) {
		IrSender.sendLegoPowerFunctions (RawData, Channel, DoSend5Times);
	}

	void B4RIrSender::SendMagiQuest(ULong WandId, UInt Magnitude) {
		IrSender.sendMagiQuest (WandId, Magnitude);
	}

	void B4RIrSender::SendPronto (UInt *data, UInt length, int NumberOfRepeats) {
		IrSender.sendPronto (data, length, NumberOfRepeats);
	}
	
	void B4RIrSender::SendShuzu(UInt Address, Byte Command, int NumberOfRepeats) {
		IrSender.sendShuzu (Address, Command, NumberOfRepeats);
	}

	void B4RIrSender::SendDish(UInt Data) {
		IrSender.sendDish (Data);
	}

	void B4RIrSender::SendWhynter(ULong Data, Byte NumberOfBitsToSend) {
		IrSender.sendWhynter (Data, NumberOfBitsToSend);
	}

	/**
	 * SENDRAW DATA
	 */

	void B4RIrSender::SendRawWithMicroseconds(B4R::ArrayUInt* BufferWithMicroseconds, int IRFrequencyKilohertz) {
		// ::Serial.print("[rIRRemoteEx IrSender SendRawWithMicroseconds]");
		
		// Define the C array from the B4R buffer data array
		uint16_t* rawdatabuffer = (uint16_t*)BufferWithMicroseconds->data;

		// Get the length of the B4R buffer data array
		int bufferlen = BufferWithMicroseconds->length;

		// Define the rawdata buffer from the C array
		uint16_t rawdata[bufferlen];

		// Populate the rawdata buffer with data from the C array
		int i;
		for( i = 0; i < bufferlen; i++ ) {
			rawdata[i] = rawdatabuffer[i];
		}

		// Send RAW data
		IrSender.sendRaw(rawdata, bufferlen, IRFrequencyKilohertz);
 	}
	
	/**
	 * PULSE_DISTANCE
	 */

	void B4RIrSender::SendPulseDistanceWidth(UInt FrequencyKHz, UInt HeaderMarkMicros, UInt HeaderSpaceMicros,
					UInt OneMarkMicros, UInt OneSpaceMicros, UInt ZeroMarkMicros, UInt ZeroSpaceMicros, ULong Data,
					UInt NumberOfBits, Byte Flags, UInt RepeatPeriodMillis, UInt NumberOfRepeats) {
		
		IRRawDataType cleanData = static_cast<IRRawDataType>((uint32_t)Data); // ensure upper bits zeroed
		
		IrSender.sendPulseDistanceWidth( (uint_fast8_t) FrequencyKHz, (uint16_t) HeaderMarkMicros, (uint16_t) HeaderSpaceMicros,
					(uint16_t) OneMarkMicros, (uint16_t) OneSpaceMicros, (uint16_t) ZeroMarkMicros, (uint16_t) ZeroSpaceMicros, cleanData,
					(uint_fast8_t) NumberOfBits, (uint8_t) Flags, (uint16_t) RepeatPeriodMillis, (int_fast8_t) NumberOfRepeats, nullptr);
		
		//IrSender.sendPulseDistanceWidthData( (uint16_t) OneMarkMicros, (uint16_t) OneSpaceMicros, (uint16_t) ZeroMarkMicros, (uint16_t) ZeroSpaceMicros, (IRRawDataType) Data, (uint_fast8_t) NumberOfBits, (uint8_t) Flags);
		
	}
	 
}