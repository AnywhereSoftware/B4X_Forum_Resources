
#include "B4RDefines.h"
#pragma once
#include "B4RDefines.h"
#include "Adafruit_SH1106.h"

    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino https://registry.platformio.org/libraries/gitlab-display/VEGA_SH1106

namespace B4R {
//class Adafruit_SH1106
    //~shortname:VEGA_SH1106
//    The driver is used in multiple displays (128x64, 128x32, etc.).
//    Select the appropriate display below to create an appropriately
//    sized framebuffer, etc.
//
//    SH1106_128_64  128x64 pixel display
//
//    SH1106_128_32  128x32 pixel display
//
//    SH1106_96_16
    class B4RVEGA_SH1106
    {
        private:
            uint8_t backend[sizeof(Adafruit_SH1106)];
            Adafruit_SH1106* sh1106;
        public: 
// fonts array to store fonts used
            static const  GFXfont * myfonts[];
            void Initialize(byte SID,byte SCLK,byte DC,byte RST,byte CS);
            void Initialize1( byte DC,byte RST,byte CS);
            void Initialize2( byte RST);
//??   Adafruit_SH1106(byte SID, byte SCLK, byte DC, byte RST, byte CS)
//??   Adafruit_SH1106(byte DC, byte RST, byte CS)
//??   Adafruit_SH1106(byte RST)
            void begin(byte switchvcc, byte i2caddr, bool reset);
            void SH1106_command(byte c);
            void SH1106_data(byte c);
            void clearDisplay();
            void invertDisplay(byte i);
            void display();
            void dim(byte contrast);
            void drawPixel(int16_t x, int16_t y, uint16_t color);
            void drawFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color);
            void drawFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color);
//******************************************************************************
// from Adafruit_GFX            
            uint16_t print( B4RString* txt);
            uint16_t println( B4RString* txt);
            void drawPixel1(int16_t x, int16_t y, uint16_t color);
            void startWrite();
            void writePixel(int16_t x, int16_t y, uint16_t color);
            void writeFillRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color);
            void writeFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color);
            void writeFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color);
            void writeLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1, uint16_t color);
            void endWrite();
            void setRotation(byte r);
            void invertDisplay1(bool i);
            void fillRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color);
            void fillScreen(uint16_t color);
            void drawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1, uint16_t color);
            void drawRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color);
            void drawCircle(int16_t x0, int16_t y0, int16_t r, uint16_t color);
            void drawCircleHelper(int16_t x0, int16_t y0, int16_t r, byte cornername, uint16_t color);
            void fillCircle(int16_t x0, int16_t y0, int16_t r, uint16_t color);
            void fillCircleHelper(int16_t x0, int16_t y0, int16_t r, byte cornername, int16_t delta, uint16_t color);
            void drawTriangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2, uint16_t color);
            void fillTriangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2, uint16_t color);
            void drawRoundRect(int16_t x0, int16_t y0, int16_t w, int16_t h, int16_t radius, uint16_t color);
            void fillRoundRect(int16_t x0, int16_t y0, int16_t w, int16_t h, int16_t radius, uint16_t color);
            void drawBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t color);
            void drawBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t color, uint16_t bg);
            void drawGrayscaleBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h);
            void drawGrayscaleBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, ArrayByte* mask, int16_t w, int16_t h);
            void drawRGBBitmap(int16_t x, int16_t y, ArrayUInt* bitmap, int16_t w, int16_t h);
            void drawRGBBitmap1(int16_t x, int16_t y, ArrayUInt* bitmap, ArrayByte* mask, int16_t w, int16_t h);
            void drawChar(int16_t x, int16_t y, byte c, uint16_t color, uint16_t bg, byte size);
            void drawChar1(int16_t x, int16_t y, byte c, uint16_t color, uint16_t bg, byte size_x, byte size_y);
            void getTextBounds( B4RString* string, int16_t x, int16_t y, ArrayInt* x1, ArrayInt* y1, ArrayUInt* w, ArrayUInt* h);
            void getTextBounds1( B4RString* str, int16_t x, int16_t y, ArrayInt* x1, ArrayInt* y1, ArrayUInt* w, ArrayUInt* h);
            void setTextSize(byte s);
            void setTextSize1(byte sx, byte sy);
            void setFont(byte fb);
            void setCursor(int16_t x, int16_t y);
            void setTextColor(uint16_t c);
            void setTextColor1(uint16_t c, uint16_t bg);
            void setTextWrap(bool w);
            void cp437(bool x);
            uint16_t write(byte c);
            int16_t width();
            int16_t height();
            byte getRotation();
            int16_t getCursorX();
            int16_t getCursorY();
            
#define /*byte SH1106_SETCONTRAST;*/ B4R_SH1106_SETCONTRAST 0x81
#define /*byte SH1106_DISPLAYALLON_RESUME;*/ B4R_SH1106_DISPLAYALLON_RESUME 0xA4
#define /*byte SH1106_DISPLAYALLON;*/  B4R_SH1106_DISPLAYALLON 0xA5
#define /*byte SH1106_NORMALDISPLAY;*/  B4R_SH1106_NORMALDISPLAY 0xA6
#define /*byte SH1106_INVERTDISPLAY;*/  B4R_SH1106_INVERTDISPLAY 0xA7
#define /*byte SH1106_DISPLAYOFF;*/  B4R_SH1106_DISPLAYOFF 0xAE
#define /*byte SH1106_DISPLAYON;*/  B4R_SH1106_DISPLAYON 0xAF

#define /*byte SH1106_SETDISPLAYOFFSET;*/  B4R_SH1106_SETDISPLAYOFFSET 0xD3
#define /*byte SH1106_SETCOMPINS;*/  B4R_SH1106_SETCOMPINS 0xDA

#define /*byte SH1106_SETVCOMDETECT;*/  B4R_SH1106_SETVCOMDETECT 0xDB

#define /*byte SH1106_SETDISPLAYCLOCKDIV;*/  B4R_SH1106_SETDISPLAYCLOCKDIV 0xD5
#define /*byte SH1106_SETPRECHARGE;*/  B4R_SH1106_SETPRECHARGE 0xD9

#define /*byte SH1106_SETMULTIPLEX;*/  B4R_SH1106_SETMULTIPLEX 0xA8

#define /*byte SH1106_SETLOWCOLUMN;*/  B4R_SH1106_SETLOWCOLUMN 0x00
#define /*byte SH1106_SETHIGHCOLUMN;*/  B4R_SH1106_SETHIGHCOLUMN 0x10

#define /*byte SH1106_SETSTARTLINE;*/  B4R_SH1106_SETSTARTLINE 0x40

#define /*byte SH1106_MEMORYMODE;*/  B4R_SH1106_MEMORYMODE 0x20
#define /*byte SH1106_COLUMNADDR;*/  B4R_SH1106_COLUMNADDR 0x21
#define /*byte SH1106_PAGEADDR;*/  B4R_SH1106_PAGEADDR   0x22

#define /*byte SH1106_COMSCANINC;*/  B4R_SH1106_COMSCANINC 0xC0
#define /*byte SH1106_COMSCANDEC;*/  B4R_SH1106_COMSCANDEC 0xC8

#define /*byte SH1106_SEGREMAP;*/  B4R_SH1106_SEGREMAP 0xA0

#define /*byte SH1106_CHARGEPUMP;*/  B4R_SH1106_CHARGEPUMP 0x8D

#define /*byte SH1106_EXTERNALVCC;*/  B4R_SH1106_EXTERNALVCC 0x1
#define /*byte SH1106_SWITCHCAPVCC;*/  B4R_SH1106_SWITCHCAPVCC 0x2

//?? Scrolling #defines
#define /*byte SH1106_ACTIVATE_SCROLL;*/  B4R_SH1106_ACTIVATE_SCROLL 0x2F
#define /*byte SH1106_DEACTIVATE_SCROLL;*/  B4R_SH1106_DEACTIVATE_SCROLL 0x2E
#define /*byte SH1106_SET_VERTICAL_SCROLL_AREA;*/  B4R_SH1106_SET_VERTICAL_SCROLL_AREA 0xA3
#define /*byte SH1106_RIGHT_HORIZONTAL_SCROLL;*/  B4R_SH1106_RIGHT_HORIZONTAL_SCROLL 0x26
#define /*byte SH1106_LEFT_HORIZONTAL_SCROLL;*/  B4R_SH1106_LEFT_HORIZONTAL_SCROLL 0x27
#define /*byte SH1106_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL;*/  B4R_SH1106_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL 0x29
#define /*byte SH1106_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL;*/  B4R_SH1106_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL 0x2A

#define /*byte BLACK;*/  B4R_BLACK 0
#define /*byte WHITE;*/  B4R_WHITE 1
#define /*byte INVERSE;*/  B4R_INVERSE 2
// Address for 128x32 is 0x3C
// Address for 128x64 is 0x3D (default) or 0x3C (if SA0 is grounded)
#define /*byte SH1106_I2C_ADDRESS_0x3C;*/  B4R_SH1106_I2C_ADDRESS_0x3C  0x3C // 011110+SA0+RW - 0x3C or 0x3D
// Address for 128x32 is 0x3C
// Address for 128x64 is 0x3D (default) or 0x3C (if SA0 is grounded)
#define /*byte SH1106_I2C_ADDRESS_0x3D:*/  B4R_SH1106_I2C_ADDRESS_0x3D  0x3D 

    };
}
