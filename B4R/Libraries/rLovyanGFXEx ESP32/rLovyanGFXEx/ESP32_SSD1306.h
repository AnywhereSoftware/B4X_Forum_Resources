/**
* ESP32_SSD1306.h
* B4R library rLovyanGFX user setting for the display SSD1306 w128xh64 and I2C address 0x3C, SDA #21, SCL #22.
* Define: ESP32_SSD1306, Class: SSD1306.
* 20250322 rwbl
*/

#define LGFX_USE_V1

// #include <Arduino.h>
#include <LovyanGFX.hpp>

// Define the sda & clock pins
#define OLED_SDA 21
#define OLED_SCL 22

// derive custom class
class SSD1306 : public lgfx::LGFX_Device
{
	lgfx::Panel_SSD1306	_panel_instance;
	lgfx::Bus_I2C       _bus_instance;			//  i2c bus instance ESP32

	public:
 
	  SSD1306(void)
	  {
		{ // bus config
		  auto cfg = _bus_instance.config();	// get bus config struture

		  // i2c settings
		  cfg.i2c_port    = 0;          
		  cfg.freq_write  = 400000;     
		  cfg.freq_read   = 400000; 
		  cfg.pin_sda     = OLED_SDA;         
		  cfg.pin_scl     = OLED_SCL;         
		  cfg.i2c_addr    = 0x3C; 
		  _bus_instance.config(cfg);       
		  _panel_instance.setBus(&_bus_instance); // assign bus to panel
		}

		{ // panel setup
		  auto cfg = _panel_instance.config(); // get panel config structure
		  cfg.pin_cs           =    -1;  // not used for i2c display
		  cfg.pin_rst          =    -1;  // not used for i2c display
		  cfg.pin_busy         =    -1;  // not used for i2c display

		  cfg.memory_width     =   128;  
		  cfg.memory_height    =    64;  
		  cfg.panel_width      =   128;  
		  cfg.panel_height     =    64;  
		  cfg.offset_x         =     0;  
		  cfg.offset_x         =     0; 
		  cfg.offset_y         =     0;  
		  cfg.offset_rotation  =     2;  
		  cfg.dummy_read_pixel =     8;  
		  cfg.dummy_read_bits  =     1;  
		  cfg.readable         = false; 
		  cfg.invert           = false;  
		  cfg.rgb_order        = false;  
		  cfg.dlen_16bit       = false;  
		  cfg.bus_shared       = false;  
		  _panel_instance.config(cfg);
		}

		setPanel(&_panel_instance); // set panel to use
	  }
};
