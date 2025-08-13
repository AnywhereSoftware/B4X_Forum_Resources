#include "B4RDefines.h"

namespace B4R
{
    void B4RILI9488::Initialize1(byte _CS,byte _DC,byte _MOSI,byte _SCLK,byte _RST,byte _MISO)
    {
       rcs = new (backend) ILI9488(_CS, _DC, _MOSI, _SCLK, _RST, _MISO);
    };
    void B4RILI9488::Initialize2(byte _CS, byte _DC, byte _RST)
    {
       rcs = new (backend) ILI9488(_CS, _DC, _RST);
    };
    void B4RILI9488::Initialize3(byte _CS, byte _DC)
    {
       rcs = new (backend) ILI9488(_CS, _DC);
    };

    void B4RILI9488::begin()
    {
       rcs->begin();
    };

    void B4RILI9488::setAddrWindow(uint16_t x0, uint16_t y0, uint16_t x1, uint16_t y1)
    {
       rcs->setAddrWindow(x0, y0, x1, y1);
    };

    void B4RILI9488::setScrollArea(uint16_t topFixedArea, uint16_t bottomFixedArea)
    {
       rcs->setScrollArea(topFixedArea, bottomFixedArea);
    };

    void B4RILI9488::scroll(uint16_t pixels)
    {
       rcs->scroll(pixels);
    };

    void B4RILI9488::pushColor(uint16_t color)
    {
       rcs->pushColor(color);
    };

    void B4RILI9488::pushColors(ArrayUInt* data, byte len, bool first)
    {
       rcs->pushColors((uint16_t*)data->data, len, first);
    };

    void B4RILI9488::drawImage(ArrayByte* img, uint16_t x, uint16_t y, uint16_t w, uint16_t h)
    {
       rcs->drawImage((byte*)img->data, x, y, w, h);
    };

    void B4RILI9488::fillScreen(uint16_t color)
    {
       rcs->fillScreen(color);
    };

    void B4RILI9488::drawPixel(int16_t x, int16_t y, uint16_t color)
    {
       rcs->drawPixel(x, y, color);
    };

    void B4RILI9488::drawFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color)
    {
       rcs->drawFastVLine(x, y, h, color);
    };

    void B4RILI9488::drawFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color)
    {
       rcs->drawFastHLine(x, y, w, color);
    };

    void B4RILI9488::fillRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color)
    {
       rcs->fillRect(x, y, w, h, color);
    };

    void B4RILI9488::setRotation(byte r)
    {
       rcs->setRotation(r);
    };

    void B4RILI9488::invertDisplay(bool i)
    {
       rcs->invertDisplay(i);
    };

    uint16_t B4RILI9488::color565(byte r, byte g, byte b)
    {
       return rcs->color565(r, g, b);
    };

    byte B4RILI9488::readdata()
    {
       return rcs->readdata();
    };

    byte B4RILI9488::readcommand8(byte reg, byte index)
    {
       return rcs->readcommand8(reg, index);
    };

    void B4RILI9488::spiwrite(byte c)
    {
       rcs->spiwrite(c);
    };

    void B4RILI9488::writecommand(byte c)
    {
       rcs->writecommand(c);
    };

    void B4RILI9488::write16BitColor(uint16_t color)
    {
       rcs->write16BitColor(color);
    };

    void B4RILI9488::writedata(byte d)
    {
       rcs->writedata(d);
    };

    void B4RILI9488::commandList(ArrayByte* addr)
    {
       rcs->commandList((byte*)addr->data);
    };

    byte B4RILI9488::spiread()
    {
       return rcs->spiread();
    };

    uint16_t B4RILI9488::print(B4RString* txt)
    {
       return rcs->print(txt->data);
    };

    uint16_t B4RILI9488::println(B4RString* txt)
    {
       return rcs->println(txt->data);
    };

    void B4RILI9488::drawPixel1(int16_t x, int16_t y, uint16_t color)
    {
       rcs->drawPixel(x, y, color);
    };

    void B4RILI9488::startWrite()
    {
       rcs->startWrite();
    };

    void B4RILI9488::writePixel(int16_t x, int16_t y, uint16_t color)
    {
       rcs->writePixel(x, y, color);
    };

    void B4RILI9488::writeFillRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color)
    {
       rcs->writeFillRect(x, y, w, h, color);
    };

    void B4RILI9488::writeFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color)
    {
       rcs->writeFastVLine(x, y, h, color);
    };

    void B4RILI9488::writeFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color)
    {
       rcs->writeFastHLine(x, y, w, color);
    };

    void B4RILI9488::writeLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1, uint16_t color)
    {
       rcs->writeLine(x0, y0, x1, y1, color);
    };

    void B4RILI9488::endWrite()
    {
       rcs->endWrite();
    };

    void B4RILI9488::setRotation1(byte r)
    {
       rcs->setRotation(r);
    };

    void B4RILI9488::invertDisplay1(bool i)
    {
       rcs->invertDisplay(i);
    };

//  void drawFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color)
//  void drawFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color)
    void B4RILI9488::fillRect1(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color)
    {
       rcs->fillRect(x, y, w, h, color);
    };

    void B4RILI9488::fillScreen1(uint16_t color)
    {
       rcs->fillScreen(color);
    };

    void B4RILI9488::drawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1, uint16_t color)
    {
       rcs->drawLine(x0, y0, x1, y1, color);
    };

    void B4RILI9488::drawRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color)
    {
       rcs->drawRect(x, y, w, h, color);
    };

    void B4RILI9488::drawCircle(int16_t x0, int16_t y0, int16_t r, uint16_t color)
    {
       rcs->drawCircle(x0, y0, r, color);
    };

    void B4RILI9488::drawCircleHelper(int16_t x0, int16_t y0, int16_t r, byte cornername, uint16_t color)
    {
       rcs->drawCircleHelper(x0, y0, r, cornername, color);
    };

    void B4RILI9488::fillCircle(int16_t x0, int16_t y0, int16_t r, uint16_t color)
    {
       rcs->fillCircle(x0, y0, r, color);
    };

    void B4RILI9488::fillCircleHelper(int16_t x0, int16_t y0, int16_t r, byte cornername, int16_t delta, uint16_t color)
    {
       rcs->fillCircleHelper(x0, y0, r, cornername, delta, color);
    };

    void B4RILI9488::drawTriangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2, uint16_t color)
    {
       rcs->drawTriangle(x0, y0, x1, y1, x2, y2, color);
    };

    void B4RILI9488::fillTriangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2, uint16_t color)
    {
       rcs->fillTriangle(x0, y0, x1, y1, x2, y2, color);
    };

    void B4RILI9488::drawRoundRect(int16_t x0, int16_t y0, int16_t w, int16_t h, int16_t radius, uint16_t color)
    {
       rcs->drawRoundRect(x0, y0, w, h, radius, color);
    };

    void B4RILI9488::fillRoundRect(int16_t x0, int16_t y0, int16_t w, int16_t h, int16_t radius, uint16_t color)
    {
       rcs->fillRoundRect(x0, y0, w, h, radius, color);
    };

//  void drawBitmap(int16_t x, int16_t y, byte bitmap[], int16_t w, int16_t h, uint16_t color)
//  void drawBitmap(int16_t x, int16_t y, byte bitmap[], int16_t w, int16_t h, uint16_t color, uint16_t bg)
    void B4RILI9488::drawBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t color)
    {
       rcs->drawBitmap(x, y, (byte*)bitmap->data, w, h, color);
    };

    void B4RILI9488::drawBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t color, uint16_t bg)
    {
       rcs->drawBitmap(x, y, (byte*)bitmap->data, w, h, color, bg);
    };

//  void drawXBitmap(int16_t x, int16_t y, byte bitmap[], int16_t w, int16_t h, uint16_t color)
//  void drawGrayscaleBitmap(int16_t x, int16_t y, byte bitmap[], int16_t w, int16_t h)
    void B4RILI9488::drawGrayscaleBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h)
    {
       rcs->drawGrayscaleBitmap(x, y, (byte*)bitmap->data, w, h);
    };

//  void drawGrayscaleBitmap(int16_t x, int16_t y, byte bitmap[], byte mask[], int16_t w, int16_t h)
    void B4RILI9488::drawGrayscaleBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, ArrayByte* mask, int16_t w, int16_t h)
    {
       rcs->drawGrayscaleBitmap(x, y, (byte*)bitmap->data, (byte*)mask->data, w, h);
    };

//  void drawRGBBitmap(int16_t x, int16_t y, uint16_t bitmap[], int16_t w, int16_t h)
    void B4RILI9488::drawRGBBitmap(int16_t x, int16_t y, ArrayUInt* bitmap, int16_t w, int16_t h)
    {
       rcs->drawRGBBitmap(x, y, (uint16_t*)bitmap->data, w, h);
    };

//  void drawRGBBitmap(int16_t x, int16_t y, uint16_t bitmap[], byte mask[], int16_t w, int16_t h)
    void B4RILI9488::drawRGBBitmap1(int16_t x, int16_t y, ArrayUInt* bitmap, ArrayByte* mask, int16_t w, int16_t h)
    {
       rcs->drawRGBBitmap(x, y, (uint16_t*)bitmap->data, (byte*)mask->data, w, h);
    };

    void B4RILI9488::drawChar(int16_t x, int16_t y, byte c, uint16_t color, uint16_t bg, byte size)
    {
       rcs->drawChar(x, y, c, color, bg, size);
    };

    void B4RILI9488::drawChar1(int16_t x, int16_t y, byte c, uint16_t color, uint16_t bg, byte size_x, byte size_y)
    {
       rcs->drawChar(x, y, c, color, bg, size_x, size_y);
    };

    void B4RILI9488::getTextBounds(B4RString* string, int16_t x, int16_t y, ArrayInt* x1, ArrayInt* y1, ArrayUInt* w, ArrayUInt* h)
    {
       rcs->getTextBounds(string->data, x, y, (int16_t*)x1->data, (int16_t*)y1->data, (uint16_t*)w->data, (uint16_t*)h->data);
    };

//  void getTextBounds(__FlashStringHelper * s, int16_t x, int16_t y, int16_t * x1, int16_t * y1, uint16_t * w, uint16_t * h)
    void B4RILI9488::getTextBounds1(B4RString* str, int16_t x, int16_t y, ArrayInt* x1, ArrayInt* y1, ArrayUInt* w, ArrayUInt* h)
    {
       rcs->getTextBounds(str->data, x, y, (int16_t*)x1->data, (int16_t*)y1->data, (uint16_t*)w->data, (uint16_t*)h->data);
    };

    void B4RILI9488::setTextSize(byte s)
    {
       rcs->setTextSize(s);
    };

    void B4RILI9488::setTextSize1(byte sx, byte sy)
    {
       rcs->setTextSize(sx, sy);
    };

    void B4RILI9488::setFont(byte fb )
    { 
       rcs->setFont(myfonts[fb]);
    };

    void B4RILI9488::setCursor(int16_t x, int16_t y)
    {
       rcs->setCursor(x, y);
    };

    void B4RILI9488::setTextColor(uint16_t c)
    {
       rcs->setTextColor(c);
    };

    void B4RILI9488::setTextColor1(uint16_t c, uint16_t bg)
    {
       rcs->setTextColor(c, bg);
    };

    void B4RILI9488::setTextWrap(bool w)
    {
       rcs->setTextWrap(w);
    };

    void B4RILI9488::cp437(bool x)
    {
       rcs->cp437(x);
    };

//  using Print::write
    uint16_t B4RILI9488::write1(byte c)
    {
       return rcs->write(c);
    };

    int16_t B4RILI9488::width()
    {
       return rcs->width();
    };

    int16_t B4RILI9488::height()
    {
       return rcs->height();
    };

    byte B4RILI9488::getRotation()
    {
       return rcs->getRotation();
    };

    int16_t B4RILI9488::getCursorX()
    {
       return rcs->getCursorX();
    };

    int16_t B4RILI9488::getCursorY()
    {
       return rcs->getCursorY();
    };


}
