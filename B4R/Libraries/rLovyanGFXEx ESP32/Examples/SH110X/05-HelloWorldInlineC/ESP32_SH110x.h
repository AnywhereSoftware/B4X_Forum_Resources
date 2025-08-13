/**
* ESP32_SH110x.h
* B4R library rLovyanGFX user setting for the display SH110x w128xh64 and I2C address 0x3C, SDA #21, SCL #22.
* Define: ESP32_SH110x, Class: SH110x.
* Tested with display SH1106.
* 20250325 rwbl
*/

#define LGFX_USE_V1

// #include <Arduino.h>
#include <LovyanGFX.hpp>

// Define the sda & clock pins
#define OLED_SDA 21
#define OLED_SCL 22

// derive custom class
class SH110x : public lgfx::LGFX_Device
{
	lgfx::Panel_SH110x	_panel_instance;
	lgfx::Bus_I2C       _bus_instance;			//  i2c bus instance ESP32

	public:
 
	  SH110x(void)
	  {
		{ // bus config
			auto cfg = _bus_instance.config();	// get bus config structure

			// i2c settings
			cfg.i2c_port    = 0;          		// Select I2C to use (0 or 1)
			cfg.freq_write  = 400000;     		// Clock sending
			cfg.freq_read   = 400000; 			// Clock receiving
			cfg.pin_sda     = OLED_SDA;         
			cfg.pin_scl     = OLED_SCL;         
			cfg.i2c_addr    = 0x3C;
			
			_bus_instance.config(cfg);       
			_panel_instance.setBus(&_bus_instance); // assign bus to panel
		}

		{ // panel setup
			auto cfg = _panel_instance.config(); // get panel config structure
			cfg.pin_cs           =    -1;	// not used for i2c display
			cfg.pin_rst          =    -1;	// not used for i2c display
			cfg.pin_busy         =    -1;	// not used for i2c display

			// Set the following only if the display is misaligned with a driver that has a variable number of pixels, such as ST7735 or ILI9163.
			// cfg.memory_width = 240; 		// Maximum width supported by the driver IC
			// cfg.memory_height = 320; 	// Maximum height supported by the driver IC

			cfg.panel_width = 128;	// 128; 			// Actual displayable width
			cfg.panel_height = 64;	// 64; 			// Actual displayable height
			cfg.offset_x = 2; 				// Panel X-direction offset
			cfg.offset_y = 0; 				// Panel Y-direction offset
			cfg.offset_rotation = 2; 		// Rotation offset 0-7 (4-7 are upside down)
			cfg.dummy_read_pixel = 8; 		// Number of dummy read bits before pixel read
			cfg.dummy_read_bits = 1; 		// Number of dummy read bits before non-pixel data read
			cfg.readable = false; 			// Set to true if data can be read
			cfg.invert = false; 			// Set to true if the panel's light and dark are inverted
			cfg.rgb_order = false; 			// Set to true if the panel's red and blue are swapped
			cfg.dlen_16bit = false; 		// Set to true if the panel transmits data length in 16-bit units via 16-bit parallel or SPI.
			cfg.bus_shared = false;			// Set to true if the bus is shared with the SD card (bus control is performed using drawJpgFile, etc.)

			_panel_instance.config(cfg);
		}

		setPanel(&_panel_instance); // set panel to use
	  }
};
