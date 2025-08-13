#pragma once
#include "B4RDefines.h"
#include "ILI9488.h"
    //~Event: 
    //~Version: 2.1 
    //~Author - 
    //~Libray from Arduino

namespace B4R {
    //~shortname:ILI9488
    class B4RILI9488
    {
        private:
            uint8_t backend[sizeof(ILI9488)];
            ILI9488* rcs;

        public: 
            // fonts array to store fonts used
            static const  GFXfont * myfonts[];
            // Constructor when using software SPI.  All output pins are configurable.
            void Initialize1(byte _CS,byte _DC,byte _MOSI,byte _SCLK,byte _RST,byte _MISO);
            // Constructor when using default hardware SPI.  Faster, but must use SPI pins
            void Initialize2(byte _CS, byte _DC, byte _RST);
            // Constructor when using default hardware SPI without RST pin
            void Initialize3(byte _CS, byte _DC);
            // init SPI link
            void begin();
            void setAddrWindow(uint16_t x0, uint16_t y0, uint16_t x1, uint16_t y1);
            void setScrollArea(uint16_t topFixedArea, uint16_t bottomFixedArea);
            void scroll(uint16_t pixels);
            void pushColor(uint16_t color);
            void pushColors(ArrayUInt* data, byte len, bool first);
            void drawImage(ArrayByte* img, uint16_t x, uint16_t y, uint16_t w, uint16_t h);
            void fillScreen(uint16_t color);
            void drawPixel(int16_t x, int16_t y, uint16_t color);
            void drawFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color);
            void drawFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color);
            void fillRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color);
            void setRotation(byte r);
            void invertDisplay(bool i);
            uint16_t color565(byte r, byte g, byte b);
            byte readdata();
            byte readcommand8(byte reg, byte index);
            void spiwrite(byte c);
            void writecommand(byte c);
            void write16BitColor(uint16_t color);
            void writedata(byte d);
            void commandList(ArrayByte* addr);
            byte spiread();
// from Adafruit_GFX            
            uint16_t print(B4RString* txt);
            uint16_t println(B4RString* txt);
            void drawPixel1(int16_t x, int16_t y, uint16_t color);
            void startWrite();
            void writePixel(int16_t x, int16_t y, uint16_t color);
            void writeFillRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color);
            void writeFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color);
            void writeFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color);
            void writeLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1, uint16_t color);
            void endWrite();
            void setRotation1(byte r);
            void invertDisplay1(bool i);
            void fillRect1(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color);
            void fillScreen1(uint16_t color);
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
            void getTextBounds(B4RString* string, int16_t x, int16_t y, ArrayInt* x1, ArrayInt* y1, ArrayUInt* w, ArrayUInt* h);
            void getTextBounds1(B4RString* str, int16_t x, int16_t y, ArrayInt* x1, ArrayInt* y1, ArrayUInt* w, ArrayUInt* h);
            void setTextSize(byte s);
            void setTextSize1(byte sx, byte sy);
            void setFont(byte fb);
            void setCursor(int16_t x, int16_t y);
            void setTextColor(uint16_t c);
            void setTextColor1(uint16_t c, uint16_t bg);
            void setTextWrap(bool w);
            void cp437(bool x);
            uint16_t write1(byte c);
            int16_t width();
            int16_t height();
            byte getRotation();
            int16_t getCursorX();
            int16_t getCursorY();
            
        #define /*Uint   ILI9488_TFTWIDTH;*/          B4R_ILI9488_TFTWIDTH       320
        #define /*Uint   ILI9488_TFTHEIGHT;*/         B4R_ILI9488_TFTHEIGHT      480   

        #define /*byte   ILI9488_NOP;*/              B4R_ILI9488_NOP            0x00
        #define /*byte   ILI9488_SWRESET;*/          B4R_ILI9488_SWRESET        0x01
        #define /*byte   ILI9488_RDDID;*/            B4R_ILI9488_RDDID          0x04
        #define /*byte   ILI9488_RDDST;*/            B4R_ILI9488_RDDST          0x09

        #define /*byte   ILI9488_SLPIN;*/            B4R_ILI9488_SLPIN          0x10
        #define /*byte   ILI9488_SLPOUT;*/           B4R_ILI9488_SLPOUT         0x11
        #define /*byte   ILI9488_PTLON;*/            B4R_ILI9488_PTLON          0x12
        #define /*byte   ILI9488_NORON;*/            B4R_ILI9488_NORON          0x13

        #define /*byte   ILI9488_RDMODE;*/           B4R_ILI9488_RDMODE         0x0A
        #define /*byte   ILI9488_RDMADCTL;*/         B4R_ILI9488_RDMADCTL       0x0B
        #define /*byte   ILI9488_RDPIXFMT:*/         B4R_ILI9488_RDPIXFMT       0x0C
        #define /*byte   ILI9488_RDIMGFMT;*/         B4R_ILI9488_RDIMGFMT       0x0D
        #define /*byte   ILI9488_RDSELFDIAG;*/       B4R_ILI9488_RDSELFDIAG     0x0F

        #define /*byte   ILI9488_INVOFF;*/           B4R_ILI9488_INVOFF         0x20
        #define /*byte   ILI9488_INVON;*/            B4R_ILI9488_INVON          0x21
        #define /*byte   ILI9488_GAMMASET;*/         B4R_ILI9488_GAMMASET       0x26
        #define /*byte   ILI9488_DISPOFF;*/          B4R_ILI9488_DISPOFF        0x28
        #define /*byte   ILI9488_DISPON;*/           B4R_ILI9488_DISPON         0x29

        #define /*byte   ILI9488_CASET;*/            B4R_ILI9488_CASET          0x2A
        #define /*byte   ILI9488_PASET;*/            B4R_ILI9488_PASET          0x2B
        #define /*byte   ILI9488_RAMWR;*/            B4R_ILI9488_RAMWR          0x2C
        #define /*byte   ILI9488_RAMRD;*/            B4R_ILI9488_RAMRD          0x2E

        #define /*byte   ILI9488_PTLAR;*/            B4R_ILI9488_PTLAR          0x30
        #define /*byte   ILI9488_MADCTL;*/           B4R_ILI9488_MADCTL         0x36
        #define /*byte   ILI9488_PIXFMT;*/           B4R_ILI9488_PIXFMT         0x3A

        #define /*byte   ILI9488_FRMCTR1;*/          B4R_ILI9488_FRMCTR1        0xB1
        #define /*byte   ILI9488_FRMCTR2;*/          B4R_ILI9488_FRMCTR2        0xB2
        #define /*byte   ILI9488_FRMCTR3;*/          B4R_ILI9488_FRMCTR3        0xB3
        #define /*byte   ILI9488_INVCTR;*/           B4R_ILI9488_INVCTR         0xB4
        #define /*byte   ILI9488_DFUNCTR;*/          B4R_ILI9488_DFUNCTR        0xB6

        #define /*byte   ILI9488_PWCTR1;*/           B4R_ILI9488_PWCTR1         0xC0
        #define /*byte   ILI9488_PWCTR2;*/           B4R_ILI9488_PWCTR2         0xC1
        #define /*byte   ILI9488_PWCTR3;*/           B4R_ILI9488_PWCTR3         0xC2
        #define /*byte   ILI9488_PWCTR4;*/           B4R_ILI9488_PWCTR4         0xC3
        #define /*byte   ILI9488_PWCTR5;*/           B4R_ILI9488_PWCTR5         0xC4
        #define /*byte   ILI9488_VMCTR1;*/           B4R_ILI9488_VMCTR1         0xC5
        #define /*byte   ILI9488_VMCTR2;*/           B4R_ILI9488_VMCTR2         0xC7

        #define /*byte   ILI9488_RDID1;*/            B4R_ILI9488_RDID1          0xDA
        #define /*byte   ILI9488_RDID2;*/            B4R_ILI9488_RDID2          0xDB
        #define /*byte   ILI9488_RDID3;*/            B4R_ILI9488_RDID3          0xDC
        #define /*byte   ILI9488_RDID4;*/            B4R_ILI9488_RDID4          0xDD

        #define /*byte   ILI9488_GMCTRP1;*/          B4R_ILI9488_GMCTRP1        0xE0
        #define /*byte   ILI9488_GMCTRN1;*/          B4R_ILI9488_GMCTRN1        0xE1


// Color definitions
        #define /*Uint    ILI9488_BLACK;*/       B4R_ILI9488_BLACK          0x0000      //   0,   0,   0 //
        #define /*Uint    ILI9488_NAVY;*/        B4R_ILI9488_NAVY           0x000F      //   0,   0, 128 //
        #define /*Uint    ILI9488_DARKGREEN;*/   B4R_ILI9488_DARKGREEN      0x03E0      //   0, 128,   0 //
        #define /*Uint    ILI9488_DARKCYAN;*/    B4R_ILI9488_DARKCYAN       0x03EF      //   0, 128, 128 //
        #define /*Uint    ILI9488_MAROON;*/      B4R_ILI9488_MAROON         0x7800      // 128,   0,   0 //
        #define /*Uint    ILI9488_PURPLE;*/      B4R_ILI9488_PURPLE         0x780F      // 128,   0, 128 //
        #define /*Uint    ILI9488_OLIVE;*/       B4R_ILI9488_OLIVE          0x7BE0      // 128, 128,   0 //
        #define /*Uint    ILI9488_LIGHTGREY;*/   B4R_ILI9488_LIGHTGREY      0xC618      // 192, 192, 192 //
        #define /*Uint    ILI9488_DARKGREY;*/    B4R_ILI9488_DARKGREY       0x7BEF      // 128, 128, 128 //
        #define /*Uint    ILI9488_BLUE;*/        B4R_ILI9488_BLUE           0x001F      //   0,   0, 255 //
        #define /*Uint    ILI9488_GREEN;*/       B4R_ILI9488_GREEN          0x07E0      //   0, 255,   0 //
        #define /*Uint    ILI9488_CYAN;*/        B4R_ILI9488_CYAN           0x07FF      //   0, 255, 255 //
        #define /*Uint    ILI9488_RED;*/         B4R_ILI9488_RED            0xF800      // 255,   0,   0 //
        #define /*Uint    ILI9488_MAGENTA;*/     B4R_ILI9488_MAGENTA        0xF81F      // 255,   0, 255 //
        #define /*Uint    ILI9488_YELLOW;*/      B4R_ILI9488_YELLOW         0xFFE0      // 255, 255,   0 //
        #define /*Uint    ILI9488_WHITE;*/       B4R_ILI9488_WHITE          0xFFFF      // 255, 255, 255 //
        #define /*Uint    ILI9488_ORANGE;*/      B4R_ILI9488_ORANGE         0xFD20      // 255, 165,   0 //
        #define /*Uint    ILI9488_GREENYELLOW;*/ B4R_ILI9488_GREENYELLOW    0xAFE5      // 173, 255,  47 //
        #define /*Uint    ILI9488_PINK;*/        B4R_ILI9488_PINK           0xF81F
    };
}
