/**
* ESP32_2432S028.h
* B4R library rLovyanGFX user setting for the display Sunton ESP32 2.8" TFT, w320xh240, touch, driver ILI9341 
* Define: ESP32_2432S028, Class: LGFX.
* 20250322 rwbl
*/

#define LGFX_USE_V1

#include <SPI.h>
#include <LovyanGFX.hpp>

#define LCD_MOSI 13
#define LCD_MISO 12
#define LCD_SCK 14
#define LCD_CS 15
#define LCD_RST -1
#define LCD_DC 2
#define LCD_BL 21

#define TOUCH_MOSI 32
#define TOUCH_MISO 39
#define TOUCH_SCK 25
#define TOUCH_CS 33
#define TOUCH_IRQ 36

class LGFX : public lgfx::LGFX_Device
{
	lgfx::Panel_ILI9341 _panel_instance;
	lgfx::Bus_SPI _bus_instance;
	lgfx::Touch_XPT2046 _touch_instance;
	lgfx::Light_PWM _light_instance;

	public:
		LGFX(void)
		{

			// Set up bus control.
			{
				auto cfg 		= _bus_instance.config(); // Get the structure for bus settings.

				// SPI bus settings
				cfg.spi_host 	= HSPI_HOST;	// Select the SPI to use (VSPI_HOST or HSPI_HOST)
				cfg.spi_mode 	= 0; 			// Set the SPI communication mode (0 to 3)
				cfg.freq_write 	= 40000000; 	// SPI clock when transmitting (Maximum 80MHz, rounded to an integer value of 80MHz)
				cfg.freq_read 	= 16000000; 	// SPI clock when receiving
				cfg.spi_3wire 	= false; 		// Set true if receiving is performed on the MOSI pin
				cfg.use_lock 	= true; 		// Set true if transaction lock is used
				cfg.dma_channel	= 1;			// Set the DMA channel (1 or 2. 0=disable) Set the DMA channel to use (0=DMA not used)
				cfg.pin_sclk 	= LCD_SCK; 		// Set the SPI SCLK pin number
				cfg.pin_mosi 	= LCD_MOSI; 	// Set the SPI MOSI pin number.
				cfg.pin_miso 	= LCD_MISO; 	// Set the SPI MISO pin number (-1 = disable).
				cfg.pin_dc 		= LCD_DC; 		// Set the SPI D/C pin number (-1 = disable).
				// If using a common SPI bus with the SD card, make sure to set MISO.

				_bus_instance.config(cfg); // Reflect the setting value to the bus.
				_panel_instance.setBus(&_bus_instance); // Set the bus to the panel.
			}
			
			// Set the display panel control.
			{
				auto cfg 				= _panel_instance.config(); // Get the structure for display panel settings.

				cfg.pin_cs 				= LCD_CS; // Pin number to which CS is connected (-1 = disable)
				cfg.pin_rst 			= LCD_RST; // Pin number to which RST is connected (-1 = disable)
				cfg.pin_busy 			= -1; // Pin number to which BUSY is connected (-1 = disable)

				// The following settings are set to general default values for each panel, 
				// so try commenting out any items you are unsure of.

				cfg.memory_width		= 240; // Maximum width supported by driver IC
				cfg.memory_height		= 320; // Maximum height supported by driver IC
				cfg.panel_width			= 240; // Actual displayable width
				cfg.panel_height		= 320; // Actual displayable height
				cfg.offset_x 			= 0; // Panel X-direction offset
				cfg.offset_y 			= 0; // Panel Y-direction offset
				cfg.offset_rotation 	= 0; // Rotation value offset 0~7 (4~7 are upside down)
				cfg.dummy_read_pixel	= 8; // Number of dummy read bits before pixel read
				cfg.dummy_read_bits 	= 1; // Number of dummy read bits before non-pixel data read
				cfg.readable 			= true; // Set to true if data can be read
				cfg.invert 				= false; // Set to true if the panel's light and dark are inverted.
				cfg.rgb_order 			= false; // Set to true if the panel's red and blue are swapped.
				cfg.dlen_16bit 			= false; // Set to true if the panel transmits data in 16-bit units.
				cfg.bus_shared 			= false; // Set to true if the bus is shared with the SD card (bus control is performed using drawJpgFile, etc.)

				_panel_instance.config(cfg);
			}

			// Set the backlight control. (Delete if not necessary)
			{
				auto cfg = _light_instance.config(); // Get the structure for backlight settings.

				cfg.pin_bl = LCD_BL; // Pin number connected to the backlight
				cfg.invert = false; // True to invert the backlight brightness
				cfg.freq = 44100; // PWM frequency for the backlight
				cfg.pwm_channel = 7; // PWM channel number to use
				_light_instance.config(cfg);
				_panel_instance.setLight(&_light_instance); // Set the backlight on the panel.
			}
			
			{  // Configure touchscreen control settings - Remove if not needed
			  auto cfg = _touch_instance.config();
			  cfg.x_min = 300;          // minimum X value (raw value) obtained from the touchscreen
			  cfg.x_max = 3900;         // maximum X value from touchscreen (raw value)
			  cfg.y_min = 180;          // smallest Y value (raw value) obtained from the touchscreen
			  cfg.y_max = 3700;         // maximum Y value from touchscreen (raw value)
			  cfg.pin_int = 36;         // pin number where INT is connected, TP IRQ
			  cfg.bus_shared = false;   // set to true if using a common bus with the screen
			  cfg.offset_rotation = 6;  // adjust if display and touch orientation do not match, set to 0~7
			  // For SPI connection
			  cfg.spi_host = VSPI_HOST;  // Select SPI to use (HSPI_HOST or VSPI_HOST)
			  cfg.freq = 1000000;        // Set SPI clock
			  cfg.pin_sclk = 25;         // pin number where SCLK is connected, TP CLK
			  cfg.pin_mosi = 32;         // pin number where MOSI is connected, TP DIN
			  cfg.pin_miso = 39;         // pin number Vwhere MISO is connected, TP DOUT
			  cfg.pin_cs = 33;           // pin number where CS is connected, TP CS
			  _touch_instance.config(cfg);
			  _panel_instance.setTouch(&_touch_instance);  // set the touch screen to the panel.
			}

			// Configure touchscreen control settings alternate - Remove if not needed
			/*
			{
				auto cfg = _touch_instance.config();
				cfg.x_min = 0; // Minimum X value obtained from touch screen (raw value)
				cfg.x_max = 239; // Maximum X value obtained from touch screen (raw value)
				cfg.y_min = 0; // Minimum Y value obtained from touch screen (raw value)
				cfg.y_max = 319; // Maximum Y value obtained from touch screen (raw value)
				cfg.pin_int = TOUCH_IRQ; // Pin number to which INT is connected
				cfg.bus_shared = true; // Set true if using a bus shared with the screen
				cfg.offset_rotation = 0; // Adjust if display and touch orientations do not match. Set to a value between 0 and 7
				// For SPI connection
				cfg.spi_host = VSPI_HOST; // Select the SPI to use (HSPI_HOST or VSPI_HOST)
				cfg.freq = 1000000; // Set the SPI clock
				cfg.pin_sclk = TOUCH_SCK; // Pin number to which SCLK is connected
				cfg.pin_mosi = TOUCH_MOSI; // Pin number to which MOSI is connected
				cfg.pin_miso = TOUCH_MISO; // Pin number to which MISO is connected
				cfg.pin_cs = TOUCH_CS; // Pin number to which CS is connected
				_touch_instance.config(cfg);
				_panel_instance.setTouch(&_touch_instance); // Set the touch screen to the panel.
			}
			*/

			// Set the panel to use.
			setPanel(&_panel_instance);
	}
			
};
