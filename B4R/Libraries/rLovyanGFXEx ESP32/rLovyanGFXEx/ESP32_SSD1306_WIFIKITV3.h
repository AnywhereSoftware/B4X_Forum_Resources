/**
* ESP32_SSD1306_WIFIKITV3.h
* B4R library rLovyanGFX user setting for the display Heltec WifiKit32(V3) with OLED SSD1306 w128xh64 and I2C address 0x3C, OLED_SDA #17, OLED_SCL #18, OLED_PWR #21
* Define: ESP32_SSD1306_WIFIKITV3, Class: SSD1306.
* Notes:
* The OLED power pin is set to high prior defining the i2c bus and the panel.
* The display enters deep sleep mode after 30 seconds.
* 20250602 rwbl
*/

#define LGFX_USE_V1

#include <LovyanGFX.hpp>

#define OLED_SDA 17
#define OLED_SCL 18
#define OLED_PWR 21

class SSD1306 : public lgfx::LGFX_Device
{
	lgfx::Panel_SSD1306	_panel_instance;
	lgfx::Bus_I2C       _bus_instance;

	public:

	  SSD1306(void)
	  {
	    // Power OLED (only if needed)
	    pinMode(OLED_PWR, OUTPUT);
	    digitalWrite(OLED_PWR, HIGH);
	    delay(50);

		{ // I2C bus config
		  auto cfg = _bus_instance.config();
		  cfg.i2c_port    = 0;
		  cfg.freq_write  = 400000;
		  cfg.freq_read   = 400000;
		  cfg.pin_sda     = OLED_SDA;
		  cfg.pin_scl     = OLED_SCL;
		  cfg.i2c_addr    = 0x3C;
		  _bus_instance.config(cfg);
		  _panel_instance.setBus(&_bus_instance);
		}

		{ // Panel config
		  auto cfg = _panel_instance.config();
		  cfg.pin_cs           = -1;
		  cfg.pin_rst          = -1;
		  cfg.pin_busy         = -1;

		  cfg.memory_width     = 128;
		  cfg.memory_height    = 64;
		  cfg.panel_width      = 128;
		  cfg.panel_height     = 64;
		  cfg.offset_x         = 0;
		  cfg.offset_y         = 0;
		  cfg.offset_rotation  = 2;
		  cfg.dummy_read_pixel = 8;
		  cfg.dummy_read_bits  = 1;
		  cfg.readable         = false;
		  cfg.invert           = false;
		  cfg.rgb_order        = false;
		  cfg.dlen_16bit       = false;
		  cfg.bus_shared       = false;
		  _panel_instance.config(cfg);
		}

		setPanel(&_panel_instance);
	  }
};
