
#include "B4RDefines.h"

namespace B4R
{

//class Adafruit_SH1106
    void B4RVEGA_SH1106::Initialize(byte SID,byte SCLK,byte DC,byte RST,byte CS)
    {
       sh1106 = new (backend) Adafruit_SH1106(SID, SCLK, DC, RST, CS);
    };
    void B4RVEGA_SH1106::Initialize1( byte DC,byte RST,byte CS)
    {
       sh1106 = new (backend) Adafruit_SH1106( DC, RST, CS);
    };
    void B4RVEGA_SH1106::Initialize2( byte RST)
    {
       sh1106 = new (backend) Adafruit_SH1106( RST);
    };
//??   Adafruit_SH1106(byte SID, byte SCLK, byte DC, byte RST, byte CS)
//??   Adafruit_SH1106(byte DC, byte RST, byte CS)
//??   Adafruit_SH1106(byte RST)
    void B4RVEGA_SH1106::begin(byte switchvcc, byte i2caddr, bool reset)
    {
       sh1106->begin(switchvcc, i2caddr, reset);
    };

    void B4RVEGA_SH1106::SH1106_command(byte c)
    {
       sh1106->SH1106_command(c);
    };

    void B4RVEGA_SH1106::SH1106_data(byte c)
    {
       sh1106->SH1106_data(c);
    };

    void B4RVEGA_SH1106::clearDisplay()
    {
       sh1106->clearDisplay();
    };

    void B4RVEGA_SH1106::invertDisplay(byte i)
    {
       sh1106->invertDisplay(i);
    };

    void B4RVEGA_SH1106::display()
    {
       sh1106->display();
    };

    void B4RVEGA_SH1106::dim(byte contrast)
    {
       sh1106->dim(contrast);
    };

    void B4RVEGA_SH1106::drawPixel(int16_t x, int16_t y, uint16_t color)
    {
       sh1106->drawPixel(x, y, color);
    };

    void B4RVEGA_SH1106::drawFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color)
    {
       sh1106->drawFastVLine(x, y, h, color);
    };

    void B4RVEGA_SH1106::drawFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color)
    {
       sh1106->drawFastHLine(x, y, w, color);
    };
//******************************************************************************
// from Adafruit_GFX            
    uint16_t B4RVEGA_SH1106::print( B4RString* txt)
    {
       return sh1106->print( txt->data);
    };

    uint16_t B4RVEGA_SH1106::println( B4RString* txt)
    {
       return sh1106->println( txt->data);
    };

    void B4RVEGA_SH1106::drawPixel1(int16_t x, int16_t y, uint16_t color)
    {
       sh1106->drawPixel(x, y, color);
    };

    void B4RVEGA_SH1106::startWrite()
    {
       sh1106->startWrite();
    };

    void B4RVEGA_SH1106::writePixel(int16_t x, int16_t y, uint16_t color)
    {
       sh1106->writePixel(x, y, color);
    };

    void B4RVEGA_SH1106::writeFillRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color)
    {
       sh1106->writeFillRect(x, y, w, h, color);
    };

    void B4RVEGA_SH1106::writeFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color)
    {
       sh1106->writeFastVLine(x, y, h, color);
    };

    void B4RVEGA_SH1106::writeFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color)
    {
       sh1106->writeFastHLine(x, y, w, color);
    };

    void B4RVEGA_SH1106::writeLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1, uint16_t color)
    {
       sh1106->writeLine(x0, y0, x1, y1, color);
    };

    void B4RVEGA_SH1106::endWrite()
    {
       sh1106->endWrite();
    };

    void B4RVEGA_SH1106::setRotation(byte r)
    {
       sh1106->setRotation(r);
    };

    void B4RVEGA_SH1106::invertDisplay1(bool i)
    {
       sh1106->invertDisplay(i);
    };

    void B4RVEGA_SH1106::fillRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color)
    {
       sh1106->fillRect(x, y, w, h, color);
    };

    void B4RVEGA_SH1106::fillScreen(uint16_t color)
    {
       sh1106->fillScreen(color);
    };

    void B4RVEGA_SH1106::drawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1, uint16_t color)
    {
       sh1106->drawLine(x0, y0, x1, y1, color);
    };

    void B4RVEGA_SH1106::drawRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color)
    {
       sh1106->drawRect(x, y, w, h, color);
    };

    void B4RVEGA_SH1106::drawCircle(int16_t x0, int16_t y0, int16_t r, uint16_t color)
    {
       sh1106->drawCircle(x0, y0, r, color);
    };

    void B4RVEGA_SH1106::drawCircleHelper(int16_t x0, int16_t y0, int16_t r, byte cornername, uint16_t color)
    {
       sh1106->drawCircleHelper(x0, y0, r, cornername, color);
    };

    void B4RVEGA_SH1106::fillCircle(int16_t x0, int16_t y0, int16_t r, uint16_t color)
    {
       sh1106->fillCircle(x0, y0, r, color);
    };

    void B4RVEGA_SH1106::fillCircleHelper(int16_t x0, int16_t y0, int16_t r, byte cornername, int16_t delta, uint16_t color)
    {
       sh1106->fillCircleHelper(x0, y0, r, cornername, delta, color);
    };

    void B4RVEGA_SH1106::drawTriangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2, uint16_t color)
    {
       sh1106->drawTriangle(x0, y0, x1, y1, x2, y2, color);
    };

    void B4RVEGA_SH1106::fillTriangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2, uint16_t color)
    {
       sh1106->fillTriangle(x0, y0, x1, y1, x2, y2, color);
    };

    void B4RVEGA_SH1106::drawRoundRect(int16_t x0, int16_t y0, int16_t w, int16_t h, int16_t radius, uint16_t color)
    {
       sh1106->drawRoundRect(x0, y0, w, h, radius, color);
    };

    void B4RVEGA_SH1106::fillRoundRect(int16_t x0, int16_t y0, int16_t w, int16_t h, int16_t radius, uint16_t color)
    {
       sh1106->fillRoundRect(x0, y0, w, h, radius, color);
    };

    void B4RVEGA_SH1106::drawBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t color)
    {
       sh1106->drawBitmap(x, y, (byte*)bitmap->data, w, h, color);
    };

    void B4RVEGA_SH1106::drawBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t color, uint16_t bg)
    {
       sh1106->drawBitmap(x, y, (byte*)bitmap->data, w, h, color, bg);
    };

    void B4RVEGA_SH1106::drawGrayscaleBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h)
    {
       sh1106->drawGrayscaleBitmap(x, y, (byte*)bitmap->data, w, h);
    };

    void B4RVEGA_SH1106::drawGrayscaleBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, ArrayByte* mask, int16_t w, int16_t h)
    {
       sh1106->drawGrayscaleBitmap(x, y, (byte*)bitmap->data, (byte*)mask->data, w, h);
    };

    void B4RVEGA_SH1106::drawRGBBitmap(int16_t x, int16_t y, ArrayUInt* bitmap, int16_t w, int16_t h)
    {
       sh1106->drawRGBBitmap(x, y, (uint16_t*)bitmap->data, w, h);
    };

    void B4RVEGA_SH1106::drawRGBBitmap1(int16_t x, int16_t y, ArrayUInt* bitmap, ArrayByte* mask, int16_t w, int16_t h)
    {
       sh1106->drawRGBBitmap(x, y, (uint16_t*)bitmap->data, (byte*)mask->data, w, h);
    };

    void B4RVEGA_SH1106::drawChar(int16_t x, int16_t y, byte c, uint16_t color, uint16_t bg, byte size)
    {
       sh1106->drawChar(x, y, c, color, bg, size);
    };

    void B4RVEGA_SH1106::drawChar1(int16_t x, int16_t y, byte c, uint16_t color, uint16_t bg, byte size_x, byte size_y)
    {
       sh1106->drawChar(x, y, c, color, bg, size_x, size_y);
    };

    void B4RVEGA_SH1106::getTextBounds( B4RString* string, int16_t x, int16_t y, ArrayInt* x1, ArrayInt* y1, ArrayUInt* w, ArrayUInt* h)
    {
       sh1106->getTextBounds(string->data, x, y, (int16_t*)x1->data, (int16_t*)y1->data, (uint16_t*)w->data, (uint16_t*)h->data);
    };

    void B4RVEGA_SH1106::getTextBounds1( B4RString* str, int16_t x, int16_t y, ArrayInt* x1, ArrayInt* y1, ArrayUInt* w, ArrayUInt* h)
    {
       sh1106->getTextBounds(str->data, x, y, (int16_t*)x1->data, (int16_t*)y1->data, (uint16_t*)w->data, (uint16_t*)h->data);
    };

    void B4RVEGA_SH1106::setTextSize(byte s)
    {
       sh1106->setTextSize(s);
    };

    void B4RVEGA_SH1106::setTextSize1(byte sx, byte sy)
    {
       sh1106->setTextSize(sx, sy);
    };

    void B4RVEGA_SH1106::setFont(byte fb)
    {
       sh1106->setFont(myfonts[fb]);
    };

    void B4RVEGA_SH1106::setCursor(int16_t x, int16_t y)
    {
       sh1106->setCursor(x, y);
    };

    void B4RVEGA_SH1106::setTextColor(uint16_t c)
    {
       sh1106->setTextColor(c);
    };

    void B4RVEGA_SH1106::setTextColor1(uint16_t c, uint16_t bg)
    {
       sh1106->setTextColor(c, bg);
    };

    void B4RVEGA_SH1106::setTextWrap(bool w)
    {
       sh1106->setTextWrap(w);
    };

    void B4RVEGA_SH1106::cp437(bool x)
    {
       sh1106->cp437(x);
    };

    uint16_t B4RVEGA_SH1106::write(byte c)
    {
       return sh1106->write(c);
    };

    int16_t B4RVEGA_SH1106::width()
    {
       return sh1106->width();
    };

    int16_t B4RVEGA_SH1106::height()
    {
       return sh1106->height();
    };

    byte B4RVEGA_SH1106::getRotation()
    {
       return sh1106->getRotation();
    };

    int16_t B4RVEGA_SH1106::getCursorX()
    {
       return sh1106->getCursorX();
    };

    int16_t B4RVEGA_SH1106::getCursorY()
    {
       return sh1106->getCursorY();
    };

}
