#pragma once
#include "B4RDefines.h"
#include "Conceptinetics.h"

//File: rConceptinetics
//Date: 20240601
//Partial wrapper for the Conceptinetics library - only the DMX_Master class.

//~Event: 
//~Version: 0.5
//~Author: Robert W.B. Linn
//~Library from Arduino: https://github.com/alfo/arduino-libraries/tree/master/Conceptinetics

namespace B4R {
    //~shortname:DMXMaster
    class B4RCONCEPTINETICS
    {
        private:
			DMX_Master* dmxm;
			uint8_t be[sizeof(DMX_Master)];

        public:
			/**
			* Initialize the DMX Master controller using hardware serial 1 (as set in conceptinetics.h).
			* master_channels - number of master channels 1 - 512 (default 100).
			* rxen_pin - pin to control the write operation on the bus (default 2).
			* <b>IMPORTANT: Ensure to initialize prior Serial1.</b>
			* Example:<code>
			* Sub Process_Globals
			* Private dmx_master As DMXMaster
			* Public Serial1 As Serial
			* Private Sub AppStart
			*  dmx_master.Initialize(10, dmx_master.RXEN_PIN)
			*  Serial1.Initialize(115200)
			* </code>
			*/
            void Initialize(UInt master_channels, int rxen_pin);
		
			/**
			* Enable to start transmitting.
			*/
			void Enable(void);
        
			/**
			* Disable stops transmitting.
			*/
			void Disable(void);
		
			/**
			* SetChannelValue by writing to the channel.
			* channel - channel number from the range set in initialize.
			* value - channel value between 0-255.
			* Example:<code>
			* dmx_master.SetChannelValue(4, 10)
			* </code>
			*/
			void SetChannelValue(UInt channel, byte value);
			
			/**
			* SetChannelLevel by writing to the channel.
			* channel - channel number from the range set in initialize.
			* level - value level between 0-100%.
			* Example:<code>
			* dmx_master.SetChannelLevel(4, 50)
			* </code>
			*/
			void SetChannelLevel(UInt channel, byte level);

			/**
			* SetChannel Off by writing 0 to the channel.
			* channel - channel number from the range set in initialize.
			* Example:<code>
			* dmx_master.SetChannelOff(2)
			* </code>
			*/
			void SetChannelOff(UInt channel);
			
			/**
			* SetChannelRange to a value.
			* start - start number of the channel range.
			* end - end number of the channel range.
			* value - value between 0-255 assigned to the channel range.
			* Example:<code>
			* dmx_master.SetChannelRange(2, 4, 10)
			* </code>
			*/
			void SetChannelRange(UInt start, UInt end, byte value);

			/**
			* SetRGB by writing to the RGB channels.
			* red/green/blue_channel - channel number from the range set in initialize.
			* red/green/blue_value - color value between 0-255.
			* Example:<code>
			* dmx_master.SetRGB(3,4,5,10,20,30)
			* </code>
			*/
			void SetRGB(UInt red_channel, UInt green_channel, UInt blue_channel, byte red_value, byte green_value, byte blue_value);

			/**
			* SetRGB off by writing 0 to the RGB channels.
			* red/green/blue_channel - channel number from the range set in initialize.
			* Example:<code>
			* dmx_master.SetRGBOff(3,4,5)
			* </code>
			*/
			void SetRGBOff(UInt red_channel, UInt green_channel, UInt blue_channel);

			/**
			* Defines
			*/
			
			// Default number of channels (100) the master will control.
			// This depends on free memory available (minimum 1).
			#define /*Byte DMX_MASTER_CHANNELS;*/ B4RCONCEPTINETICS_DMX_MASTER_CHANNELS 100

			// Default pin number (2) to change read or write mode on the shield.
			#define /*Byte RXEN_PIN;*/ B4RCONCEPTINETICS_RXEN_PIN 2

			// Default channel number for the Dimmer, Red, Green, Blue
			#define /*Byte CHANNEL_DIMMER;*/ B4RCONCEPTINETICS_CHANNEL_DIMMER 1
			#define /*Byte CHANNEL_RED;*/ B4RCONCEPTINETICS_CHANNEL_RED 2
			#define /*Byte CHANNEL_GREEN;*/ B4RCONCEPTINETICS_CHANNEL_GREEN 3
			#define /*Byte CHANNEL_BLUE;*/ B4RCONCEPTINETICS_CHANNEL_BLUE 4

			// TODO: find a way to set the hardware serial port
			//#define /*Byte USE_DMX_SERIAL_0;*/ B4RCONCEPTINETICS_USE_DMX_SERIAL_0 0
			//#define /*Byte USE_DMX_SERIAL_1;*/ B4RCONCEPTINETICS_USE_DMX_SERIAL_1 1

    };
}
