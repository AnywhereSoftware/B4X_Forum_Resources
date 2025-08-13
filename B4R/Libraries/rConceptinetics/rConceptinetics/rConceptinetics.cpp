#include "B4RDefines.h"

namespace B4R
{
    void B4RCONCEPTINETICS::Initialize(UInt master_channels, int rxen_pin)
    {
		dmxm = new (be) DMX_Master(master_channels, rxen_pin);
		dmxm->enable();
    };

	void B4RCONCEPTINETICS::Enable  ( void )
	{
		dmxm->enable();
	}

	void B4RCONCEPTINETICS::Disable ( void )
	{
		dmxm->disable();
	}

	void B4RCONCEPTINETICS::SetChannelValue(UInt channel, byte value)
	{
		dmxm->setChannelValue(channel, value);
	};

	void B4RCONCEPTINETICS::SetChannelLevel(UInt channel, byte level)
	{
		int value = (int) ( (255 * level) / 100);
		dmxm->setChannelValue(channel, value);
	};

	void B4RCONCEPTINETICS::SetChannelOff(UInt channel)
	{
		dmxm->setChannelValue(channel, 0);		
	}
	
	void B4RCONCEPTINETICS::SetChannelRange(UInt start, UInt end, byte value)
	{
		dmxm->setChannelRange(start, end, value);		
	}

	void B4RCONCEPTINETICS::SetRGB(UInt red_channel, UInt green_channel, UInt blue_channel, byte red_value, byte green_value, byte blue_value)
	{
		dmxm->setChannelValue(red_channel, red_value);
		dmxm->setChannelValue(green_channel, green_value);
		dmxm->setChannelValue(blue_channel, blue_value);		
	}

	void B4RCONCEPTINETICS::SetRGBOff(UInt red_channel, UInt green_channel, UInt blue_channel)
	{
		dmxm->setChannelValue(red_channel, 0);
		dmxm->setChannelValue(green_channel, 0);
		dmxm->setChannelValue(blue_channel, 0);
	}

}
