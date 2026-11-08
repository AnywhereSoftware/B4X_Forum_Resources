#include "B4RDefines.h"

    B4R::B4RTFT_eSPI*  B4R::B4RTFT_eSPI::instance = NULL;

// Callback function to provide the pixel color at x,y
    static uint16_t TFTColor_Callback(uint16_t x, uint16_t y)
    {
        return B4R::B4RTFT_eSPI::TFTColorCallback( x, y);
    };

namespace B4R
{

    uint32_t B4RTFT_eSPI::Initialize(int16_t _W, int16_t _H)
    {
       if (_W = -1) {rcs = new (backend) TFT_eSPI();}
       else {rcs = new (backend) TFT_eSPI(_W, _H);}
       return ((uint32_t) &rcs);
    };
    
    void B4RTFT_eSPI::begin(byte tc)
    {
             if (tc = 0xFF) {rcs->begin();}
             else {rcs->begin(tc);}
    };

    void B4RTFT_eSPI::drawPixel(int32_t x, int32_t y, uint32_t color)
    {
       rcs->drawPixel(x, y, color);
    };

    void B4RTFT_eSPI::drawChar(int32_t x, int32_t y, uint16_t c, uint32_t color, uint32_t bg, byte size)
    {
       rcs->drawChar(x, y, c, color, bg, size);
    };

    void B4RTFT_eSPI::drawLine(int32_t xs, int32_t ys, int32_t xe, int32_t ye, uint32_t color)
    {
       rcs->drawLine(xs, ys, xe, ye, color);
    };

    void B4RTFT_eSPI::drawFastVLine(int32_t x, int32_t y, int32_t h, uint32_t color)
    {
       rcs->drawFastVLine(x, y, h, color);
    };

    void B4RTFT_eSPI::drawFastHLine(int32_t x, int32_t y, int32_t w, uint32_t color)
    {
       rcs->drawFastHLine(x, y, w, color);
    };

    void B4RTFT_eSPI::fillRect(int32_t x, int32_t y, int32_t w, int32_t h, uint32_t color)
    {
       rcs->fillRect(x, y, w, h, color);
    };

    int16_t B4RTFT_eSPI::drawChar1(uint16_t uniCode, int32_t x, int32_t y, byte font)
    {
       return rcs->drawChar(uniCode, x, y, font);
    };

    int16_t B4RTFT_eSPI::drawChar2(uint16_t uniCode, int32_t x, int32_t y)
    {
       return rcs->drawChar(uniCode, x, y);
    };

    int16_t B4RTFT_eSPI::height()
    {
       return rcs->height();
    };

    int16_t B4RTFT_eSPI::width()
    {
       return rcs->width();
    };

    uint16_t B4RTFT_eSPI::readPixel(int32_t x, int32_t y)
    {
       return rcs->readPixel(x, y);
    };

    void B4RTFT_eSPI::setWindow(int32_t xs, int32_t ys, int32_t xe, int32_t ye)
    {
       rcs->setWindow(xs, ys, xe, ye);
    };

    void B4RTFT_eSPI::pushColor(uint16_t color)
    {
       rcs->pushColor(color);
    };

    void B4RTFT_eSPI::begin_nin_write()
    {
       rcs->begin_nin_write();
    };

    void B4RTFT_eSPI::end_nin_write()
    {
       rcs->end_nin_write();
    };

    void B4RTFT_eSPI::setRotation(byte r)
    {
       rcs->setRotation(r);
    };

    byte B4RTFT_eSPI::getRotation()
    {
       return rcs->getRotation();
    };

    void B4RTFT_eSPI::setOrigin(int32_t x, int32_t y)
    {
       rcs->setOrigin(x, y);
    };

    int32_t B4RTFT_eSPI::getOriginX()
    {
       return rcs->getOriginX();
    };

    int32_t B4RTFT_eSPI::getOriginY()
    {
       return rcs->getOriginY();
    };

    void B4RTFT_eSPI::invertDisplay(bool i)
    {
       rcs->invertDisplay(i);
    };

    void B4RTFT_eSPI::setAddrWindow(int32_t xs, int32_t ys, int32_t w, int32_t h)
    {
       rcs->setAddrWindow(xs, ys, w, h);
    };

    void B4RTFT_eSPI::setViewport(int32_t x, int32_t y, int32_t w, int32_t h, bool vpDatum)
    {
       rcs->setViewport(x, y, w, h, vpDatum);
    };

    bool B4RTFT_eSPI::checkViewport(int32_t x, int32_t y, int32_t w, int32_t h)
    {
       return rcs->checkViewport(x, y, w, h);
    };

    int32_t B4RTFT_eSPI::getViewportX()
    {
       return rcs->getViewportX();
    };

    int32_t B4RTFT_eSPI::getViewportY()
    {
       return rcs->getViewportY();
    };

    int32_t B4RTFT_eSPI::getViewportWidth()
    {
       return rcs->getViewportWidth();
    };

    int32_t B4RTFT_eSPI::getViewportHeight()
    {
       return rcs->getViewportHeight();
    };

    bool B4RTFT_eSPI::getViewportDatum()
    {
       return rcs->getViewportDatum();
    };

    void B4RTFT_eSPI::frameViewport(uint16_t color, int32_t w)
    {
       rcs->frameViewport(color, w);
    };

    void B4RTFT_eSPI::resetViewport()
    {
       rcs->resetViewport();
    };

    bool B4RTFT_eSPI::clipAddrWindow(ArrayLong* xywh)
    {
       int32_t* tmp =(int32_t*) xywh->data;
       return rcs->clipAddrWindow(&tmp[0], &tmp[1], &tmp[2], &tmp[3]);
    };

    bool B4RTFT_eSPI::clipWindow(ArrayLong* xsysxeye)
    {
       int32_t* tmp = (int32_t*)xsysxeye->data;
       return rcs->clipWindow(&tmp[0], &tmp[1], &tmp[2], &tmp[3]);
    };

    void B4RTFT_eSPI::pushColor1(uint16_t color, uint32_t len)
    {
       rcs->pushColor(color, len);
    };

    void B4RTFT_eSPI::pushColors(ArrayUInt* data, bool swap)
    {
       rcs->pushColors((uint16_t*)data->data, data->length, swap);
    };

    void B4RTFT_eSPI::pushColors1(ArrayByte* data)
    {
       rcs->pushColors((byte*)data->data, data->length);
    };

    void B4RTFT_eSPI::pushBlock(uint16_t color, uint32_t len)
    {
       rcs->pushBlock(color, len);
    };

    void B4RTFT_eSPI::pushPixels(ArrayByte* data_in)
    {
       rcs->pushPixels((uint8_t*) data_in, data_in->length);
    };

    byte B4RTFT_eSPI::tft_Read8()
    {
 #ifdef TFT_SDA_READ    
    #if defined (TFT_eSPI_ENABLE_8_BIT_READ)
       return 1; //rcs->tft_Read_8();
    #else
       return 0;   
    #endif
 #else
       return 0;     
 #endif         
    };

    void B4RTFT_eSPI::begin_SDA_Read()
    {
 #ifdef TFT_SDA_READ    
       rcs->begin_SDA_Read();
 #endif       
    };

    void B4RTFT_eSPI::end_SDA_Read()
    {
 #ifdef TFT_SDA_READ    
       rcs->end_SDA_Read();
 #endif
    };

    void B4RTFT_eSPI::fillScreen(uint32_t color)
    {
       rcs->fillScreen(color);
    };

    void B4RTFT_eSPI::drawRect(int32_t x, int32_t y, int32_t w, int32_t h, uint32_t color)
    {
       rcs->drawRect(x, y, w, h, color);
    };

    void B4RTFT_eSPI::drawRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color)
    {
       rcs->drawRoundRect(x, y, w, h, radius, color);
    };

    void B4RTFT_eSPI::fillRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color)
    {
       rcs->fillRoundRect(x, y, w, h, radius, color);
    };

    void B4RTFT_eSPI::fillRectVGradient(int16_t x, int16_t y, int16_t w, int16_t h, uint32_t color1, uint32_t color2)
    {
       rcs->fillRectVGradient(x, y, w, h, color1, color2);
    };

    void B4RTFT_eSPI::fillRectHGradient(int16_t x, int16_t y, int16_t w, int16_t h, uint32_t color1, uint32_t color2)
    {
       rcs->fillRectHGradient(x, y, w, h, color1, color2);
    };

    void B4RTFT_eSPI::drawCircle(int32_t x, int32_t y, int32_t r, uint32_t color)
    {
       rcs->drawCircle(x, y, r, color);
    };

    void B4RTFT_eSPI::drawCircleHelper(int32_t x, int32_t y, int32_t r, byte cornername, uint32_t color)
    {
       rcs->drawCircleHelper(x, y, r, cornername, color);
    };

    void B4RTFT_eSPI::fillCircle(int32_t x, int32_t y, int32_t r, uint32_t color)
    {
       rcs->fillCircle(x, y, r, color);
    };

    void B4RTFT_eSPI::fillCircleHelper(int32_t x, int32_t y, int32_t r, byte cornername, int32_t delta, uint32_t color)
    {
       rcs->fillCircleHelper(x, y, r, cornername, delta, color);
    };

    void B4RTFT_eSPI::drawEllipse(int16_t x, int16_t y, int32_t rx, int32_t ry, uint16_t color)
    {
       rcs->drawEllipse(x, y, rx, ry, color);
    };

    void B4RTFT_eSPI::fillEllipse(int16_t x, int16_t y, int32_t rx, int32_t ry, uint16_t color)
    {
       rcs->fillEllipse(x, y, rx, ry, color);
    };

    void B4RTFT_eSPI::drawTriangle(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3, uint32_t color)
    {
       rcs->drawTriangle(x1, y1, x2, y2, x3, y3, color);
    };

    void B4RTFT_eSPI::fillTriangle(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3, uint32_t color)
    {
       rcs->fillTriangle(x1, y1, x2, y2, x3, y3, color);
    };

    uint16_t B4RTFT_eSPI::drawPixel1(int32_t x, int32_t y, uint32_t color, byte alpha, uint32_t bg_color)
    {
       return rcs->drawPixel(x, y, color, alpha, bg_color);
    };

    void B4RTFT_eSPI::drawSmoothArc(int32_t x, int32_t y, int32_t r, int32_t ir, uint32_t startAngle, uint32_t endAngle, uint32_t fg_color, uint32_t bg_color, bool roundEnds)
    {
       rcs->drawSmoothArc(x, y, r, ir, startAngle, endAngle, fg_color, bg_color, roundEnds);
    };

    void B4RTFT_eSPI::drawArc(int32_t x, int32_t y, int32_t r, int32_t ir, uint32_t startAngle, uint32_t endAngle, uint32_t fg_color, uint32_t bg_color, bool smoothArc)
    {
       rcs->drawArc(x, y, r, ir, startAngle, endAngle, fg_color, bg_color, smoothArc);
    };

    void B4RTFT_eSPI::drawSmoothCircle(int32_t x, int32_t y, int32_t r, uint32_t fg_color, uint32_t bg_color)
    {
       rcs->drawSmoothCircle(x, y, r, fg_color, bg_color);
    };

    void B4RTFT_eSPI::fillSmoothCircle(int32_t x, int32_t y, int32_t r, uint32_t color, uint32_t bg_color)
    {
       rcs->fillSmoothCircle(x, y, r, color, bg_color);
    };

    void B4RTFT_eSPI::drawSmoothRoundRect(int32_t x, int32_t y, int32_t r, int32_t ir, int32_t w, int32_t h, uint32_t fg_color, uint32_t bg_color, byte quadrants)
    {
       rcs->drawSmoothRoundRect(x, y, r, ir, w, h, fg_color, bg_color, quadrants);
    };

    void B4RTFT_eSPI::fillSmoothRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color, uint32_t bg_color)
    {
       rcs->fillSmoothRoundRect(x, y, w, h, radius, color, bg_color);
    };

    void B4RTFT_eSPI::drawSpot(double ax, double ay, double r, uint32_t fg_color, uint32_t bg_color)
    {
       rcs->drawSpot(ax, ay, r, fg_color, bg_color);
    };

    void B4RTFT_eSPI::drawWideLine(double ax, double ay, double bx, double by, double wd, uint32_t fg_color, uint32_t bg_color)
    {
       rcs->drawWideLine(ax, ay, bx, by, wd, fg_color, bg_color);
    };

    void B4RTFT_eSPI::drawWedgeLine(double ax, double ay, double bx, double by, double aw, double bw, uint32_t fg_color, uint32_t bg_color)
    {
       rcs->drawWedgeLine(ax, ay, bx, by, aw, bw, fg_color, bg_color);
    };

    void B4RTFT_eSPI::setSwapBytes(bool swap)
    {
       rcs->setSwapBytes(swap);
    };

    bool B4RTFT_eSPI::getSwapBytes()
    {
       return rcs->getSwapBytes();
    };

    void B4RTFT_eSPI::drawBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor)
    {
       rcs->drawBitmap(x, y, (byte*)bitmap->data, w, h, fgcolor);
    };

    void B4RTFT_eSPI::drawBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor, uint16_t bgcolor)
    {
       rcs->drawBitmap(x, y, (byte*)bitmap->data, w, h, fgcolor, bgcolor);
    };

    void B4RTFT_eSPI::drawXBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor)
    {
       rcs->drawXBitmap(x, y, (byte*)bitmap->data, w, h, fgcolor);
    };

    void B4RTFT_eSPI::drawXBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor, uint16_t bgcolor)
    {
       rcs->drawXBitmap(x, y, (byte*)bitmap->data, w, h, fgcolor, bgcolor);
    };

    void B4RTFT_eSPI::setBitmapColor(uint16_t fgcolor, uint16_t bgcolor)
    {
       rcs->setBitmapColor(fgcolor, bgcolor);
    };

    void B4RTFT_eSPI::setPivot(int16_t x, int16_t y)
    {
       rcs->setPivot(x, y);
    };

    int16_t B4RTFT_eSPI::getPivotX()
    {
       return rcs->getPivotX();
    };

    int16_t B4RTFT_eSPI::getPivotY()
    {
       return rcs->getPivotY();
    };

    void B4RTFT_eSPI::readRect(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data)
    {
       rcs->readRect(x, y, w, h, (uint16_t*)data->data);
    };

    void B4RTFT_eSPI::pushRect(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data)
    {
       rcs->pushRect(x, y, w, h, (uint16_t*)data->data);
    };

    void B4RTFT_eSPI::pushImage(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data)
    {
       rcs->pushImage(x, y, w, h, (uint16_t*)data->data);
    };

    void B4RTFT_eSPI::pushImage1(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, uint16_t transparent)
    {
       rcs->pushImage(x, y, w, h, (uint16_t*)data->data, transparent);
    };

//    void B4RTFT_eSPI::pushImage2(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, uint16_t transparent)
//    {
//       rcs->pushImage(x, y, w, h, (uint16_t*)data->data, transparent);
//    };

//    void B4RTFT_eSPI::pushImage3(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data)
//    {
//       rcs->pushImage(x, y, w, h, (uint16_t*)data->data);
//    };

    void B4RTFT_eSPI::pushImage4(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, bool bpp8, ArrayUInt* cmap)
    {
       rcs->pushImage(x, y, w, h, (byte*)data->data, bpp8, (uint16_t*)cmap->data);
    };

    void B4RTFT_eSPI::pushImage5(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, byte  transparent, bool bpp8, ArrayUInt* cmap)
    {
       rcs->pushImage(x, y, w, h, (byte*)data->data, transparent, bpp8, (uint16_t*)cmap->data);
    };

    void B4RTFT_eSPI::pushImage6(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, bool bpp8, ArrayUInt* cmap)
    {
       rcs->pushImage(x, y, w, h, (byte*)data->data, bpp8, (uint16_t*)cmap->data);
    };

    void B4RTFT_eSPI::pushMaskedImage(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* img, ArrayByte* mask)
    {
       rcs->pushMaskedImage(x, y, w, h, (uint16_t*)img->data, (byte*)mask->data);
    };

    void B4RTFT_eSPI::readRectRGB(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data)
    {
       rcs->readRectRGB(x, y, w, h, (byte*)data->data);
    };

    int16_t B4RTFT_eSPI::drawNumber(int32_t intNumber, int32_t x, int32_t y, byte font)
    {
       return rcs->drawNumber(intNumber, x, y, font);
    };

    int16_t B4RTFT_eSPI::drawNumber1(int32_t intNumber, int32_t x, int32_t y)
    {
       return rcs->drawNumber(intNumber, x, y);
    };

    int16_t B4RTFT_eSPI::drawFloat(double doubleNumber, byte decimal, int32_t x, int32_t y, byte font)
    {
       return rcs->drawFloat(doubleNumber, decimal, x, y, font);
    };

    int16_t B4RTFT_eSPI::drawFloat1(double doubleNumber, byte decimal, int32_t x, int32_t y)
    {
       return rcs->drawFloat(doubleNumber, decimal, x, y);
    };

    int16_t B4RTFT_eSPI::drawString(B4RString* string, int32_t x, int32_t y, byte font)
    {
       return rcs->drawString(string->data, x, y, font);
    };

    int16_t B4RTFT_eSPI::drawString1(B4RString* string, int32_t x, int32_t y)
    {
       return rcs->drawString(string->data, x, y);
    };

    int16_t B4RTFT_eSPI::drawCentreString(B4RString* string, int32_t x, int32_t y, byte font)
    {
       return rcs->drawCentreString(string->data, x, y, font);
    };

    int16_t B4RTFT_eSPI::drawRightString(B4RString* string, int32_t x, int32_t y, byte font)
    {
       return rcs->drawRightString(string->data, x, y, font);
    };

    void B4RTFT_eSPI::setCursor(int16_t x, int16_t y)
    {
       rcs->setCursor(x, y);
    };

    void B4RTFT_eSPI::setCursor1(int16_t x, int16_t y, byte font)
    {
       rcs->setCursor(x, y, font);
    };

    int16_t B4RTFT_eSPI::getCursorX()
    {
       return rcs->getCursorX();
    };

    int16_t B4RTFT_eSPI::getCursorY()
    {
       return rcs->getCursorY();
    };

    void B4RTFT_eSPI::setTextColor(uint16_t color)
    {
       rcs->setTextColor(color);
    };

    void B4RTFT_eSPI::setTextColor1(uint16_t fgcolor, uint16_t bgcolor, bool bgfill)
    {
       rcs->setTextColor(fgcolor, bgcolor, bgfill);
    };

    void B4RTFT_eSPI::setTextSize(byte size)
    {
       rcs->setTextSize(size);
    };

    void B4RTFT_eSPI::setTextWrap(bool wrapX, bool wrapY)
    {
       rcs->setTextWrap(wrapX, wrapY);
    };

    void B4RTFT_eSPI::setTextDatum(byte datum)
    {
       rcs->setTextDatum(datum);
    };

    byte B4RTFT_eSPI::getTextDatum()
    {
       return rcs->getTextDatum();
    };

    void B4RTFT_eSPI::setTextPadding(uint16_t x_width)
    {
       rcs->setTextPadding(x_width);
    };

    uint16_t B4RTFT_eSPI::getTextPadding()
    {
       return rcs->getTextPadding();
    };

  #ifdef LOAD_GFXFF
    void B4RTFT_eSPI::setFreeFont(byte GFXid)
    {
     //  rcs->setFreeFont(GFXfont * f);
       rcs->setFreeFont(GFXfonts[GFXid]);
    };

    void B4RTFT_eSPI::setTextFont(byte font)
    {    
       rcs->setTextFont(font);    
    };
  #else
    void B4RTFT_eSPI::setFreeFont1(byte font)
    {     
       rcs->setFreeFont(font);      
    };

    void B4RTFT_eSPI::setTextFont1(byte font)
    {    
       rcs->setTextFont(font);    
    };
  #endif 
  
    int16_t B4RTFT_eSPI::textWidth(B4RString* string, byte font)
    {
       return rcs->textWidth(string->data, font);
    };

    int16_t B4RTFT_eSPI::textWidth1(B4RString* string)
    {
       return rcs->textWidth(string->data);
    };

    int16_t B4RTFT_eSPI::textWidth2(B4RString* string, byte font)
    {
       return rcs->textWidth( string->data, font);
    };

    int16_t B4RTFT_eSPI::textWidth3(B4RString* string)
    {
       return rcs->textWidth( string->data);
    };

    int16_t B4RTFT_eSPI::fontHeight(int16_t font)
    {
       return rcs->fontHeight(font);
    };

    int16_t B4RTFT_eSPI::fontHeight1()
    {
       return rcs->fontHeight();
    };

    uint16_t B4RTFT_eSPI::decodeUTF8(ArrayByte* buf, ArrayUInt* index, uint16_t remaining)
    {
       return rcs->decodeUTF8((byte*)buf->data, (uint16_t*)index->data, remaining);
    };

    uint16_t B4RTFT_eSPI::decodeUTF81(byte c)
    {
       return rcs->decodeUTF8(c);
    };

    uint16_t B4RTFT_eSPI::write(uint8_t utf8)
    {
       return rcs->write(utf8);
    };

    void B4RTFT_eSPI::setCallback(Subuint_uintuint OnTFTColorCallbackSub)
    {
       this->OnTFTColorCallback_Sub = OnTFTColorCallbackSub;
       instance = this;  
       rcs->setCallback(TFTColor_Callback);
    };
// ????????????????????????????????????????????????????????????????????????
 
    uint16_t B4RTFT_eSPI::TFTColorCallback(uint16_t x, uint16_t y)
    {
       return instance->OnTFTColorCallback_Sub(x, y);
    };

    uint16_t B4RTFT_eSPI::fontsLoaded()
    {
       return rcs->fontsLoaded();
    };

    void B4RTFT_eSPI::spiwrite(uint8_t c)
    {
       rcs->spiwrite( c);
    };

    void B4RTFT_eSPI::writecommand(uint16_t c)
    {
#ifdef RM68120_DRIVER
       rcs->writecommand(c);
#endif       
    };

    void B4RTFT_eSPI::writeRegister8(uint16_t c, byte d)
    {
#ifdef RM68120_DRIVER    
       rcs->writeRegister8(c, d);
#endif
    };

    void B4RTFT_eSPI::writeRegister16(uint16_t c, uint16_t d)
    {
#ifdef RM68120_DRIVER    
       rcs->writeRegister16(c, d);
#endif       
    };

    void B4RTFT_eSPI::writecommand1(byte c)
    {
#ifndef RM68120_DRIVER    
       rcs->writecommand(c);
#endif       
    };

    void B4RTFT_eSPI::writedata(byte d)
    {
       rcs->writedata(d);
    };

    void B4RTFT_eSPI::commandList(ArrayByte* addr)
    {
       rcs->commandList((byte*)addr->data);
    };

    byte B4RTFT_eSPI::readcommand8(byte cmd_function, byte index)
    {
       return rcs->readcommand8(cmd_function, index);
    };

    uint16_t B4RTFT_eSPI::readcommand16(byte cmd_function, byte index)
    {
       return rcs->readcommand16(cmd_function, index);
    };

    uint32_t B4RTFT_eSPI::readcommand32(byte cmd_function, byte index)
    {
       return rcs->readcommand32(cmd_function, index);
    };

    uint16_t B4RTFT_eSPI::color565(byte red, byte green, byte blue)
    {
       return rcs->color565(red, green, blue);
    };

    uint16_t B4RTFT_eSPI::color8to16(byte color332)
    {
       return rcs->color8to16(color332);
    };

    byte B4RTFT_eSPI::color16to8(uint16_t color565)
    {
       return rcs->color16to8(color565);
    };

    uint32_t B4RTFT_eSPI::color16to24(uint16_t color565)
    {
       return rcs->color16to24(color565);
    };

    uint32_t B4RTFT_eSPI::color24to16(uint32_t color888)
    {
       return rcs->color24to16(color888);
    };

    uint16_t B4RTFT_eSPI::alphaBlend(byte alpha, uint16_t fgc, uint16_t bgc)
    {
       return rcs->alphaBlend(alpha, fgc, bgc);
    };

    uint16_t B4RTFT_eSPI::alphaBlend1(byte alpha, uint16_t fgc, uint16_t bgc, byte dither)
    {
       return rcs->alphaBlend(alpha, fgc, bgc, dither);
    };

    uint32_t B4RTFT_eSPI::alphaBlend24(byte alpha, uint32_t fgc, uint32_t bgc, byte dither)
    {
       return rcs->alphaBlend24(alpha, fgc, bgc, dither);
    };

    bool B4RTFT_eSPI::initDMA(bool ctrl_cs)
    {
       return rcs->initDMA(ctrl_cs);
    };

    void B4RTFT_eSPI::deInitDMA()
    {
       rcs->deInitDMA();
    };

    void B4RTFT_eSPI::pushImageDMA(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, ArrayUInt* buffer)
    {
       rcs->pushImageDMA(x, y, w, h, (uint16_t*)data->data, (uint16_t*)buffer->data);
    };

    void B4RTFT_eSPI::pushImageDMA1(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data)
    {
#if defined (ESP32)    
       rcs->pushImageDMA(x, y, w, h, (uint16_t*)data->data);      
#endif       
    };

    void B4RTFT_eSPI::pushPixelsDMA(ArrayUInt* image)
    {
       rcs->pushPixelsDMA((uint16_t*)image->data, image->length);
    };

    bool B4RTFT_eSPI::dmaBusy()
    {
       return rcs->dmaBusy();
    };

    void B4RTFT_eSPI::dmaWait()
    {
       rcs->dmaWait();
    };
    
     bool B4RTFT_eSPI::DMA_Enabled()
    {
      return  rcs->DMA_Enabled;
    };
    
    uint8_t B4RTFT_eSPI::spiBusyCheck()
    {
       return rcs->spiBusyCheck;
    };

    void B4RTFT_eSPI::startWrite()
    {
       rcs->startWrite();
    };

    void B4RTFT_eSPI::writeColor(uint16_t color, uint32_t len)
    {
       rcs->writeColor(color, len);
    };

    void B4RTFT_eSPI::endWrite()
    {
       rcs->endWrite();
    };

//??            #define CP437_SWITCH 1
//??            #define UTF8_SWITCH  2
//??            #define PSRAM_ENABLE 3

    void B4RTFT_eSPI::setAttribute(byte id, byte a)
    {
       rcs->setAttribute(id, a);
    };

    byte B4RTFT_eSPI::getAttribute(byte id)
    {
       return rcs->getAttribute(id);
    };

  //
  // void     getSetup(setup_t& tft_settings); 
  //
  
//    bool B4RTFT_eSPI::verifySetupID(uint32_t id)
//    {
//       return rcs->verifySetupID(id);
//    };

//#if !defined (TFT_PARALLEL_8_BIT) && !defined (RP2040_PIO_INTERFACE)
//??     SPIClass& getSPIinstance(void) 
//#endif
    uint32_t B4RTFT_eSPI::textcolor()
    {
       return rcs->textcolor;
    };

    uint32_t B4RTFT_eSPI::textbgcolor()
    {
       return rcs->textbgcolor;
    };

    uint32_t B4RTFT_eSPI::bitmap_fg()
    {
       return rcs->bitmap_fg;
    };

    uint32_t B4RTFT_eSPI::bitmap_bg()
    {
       return rcs->bitmap_bg;
    };

    byte B4RTFT_eSPI::textfont()
    {
       return rcs->textfont;
    };

    byte B4RTFT_eSPI::textsize()
    {
       return rcs->textsize;
    };

    byte B4RTFT_eSPI::textdatum()
    {
       return rcs->textdatum;
    };

    byte B4RTFT_eSPI::rotation()
    {
       return rcs->rotation;
    };
    
    uint16_t B4RTFT_eSPI::decoderState()
    {
       return rcs->decoderState;
    };
    
    uint16_t B4RTFT_eSPI::decoderBuffer()
    {
       return rcs->decoderBuffer;
    };
    
    uint16_t B4RTFT_eSPI::print(B4RString* string)
    {
       return rcs->print(string->data);
    };

    uint16_t B4RTFT_eSPI::println(B4RString* string)
    {
       return rcs->println(string->data);
    };
//*****************************    
//TFT_eSPI Touch
//*****************************
    #ifdef TOUCH_CS
    byte B4RTFT_eSPI::getTouchRaw(ArrayUInt* xy)
    {
       uint16_t* tmp = (uint16_t*)xy->data;
       return rcs->getTouchRaw(&tmp[0], &tmp[1]);     
    };

    uint16_t B4RTFT_eSPI::getTouchRawZ()
    {
       return rcs->getTouchRawZ();  
    };

    void B4RTFT_eSPI::convertRawXY(ArrayUInt* xy)
    {
       uint16_t* tmp = (uint16_t*)xy->data;   
       rcs->convertRawXY(&tmp[0], &tmp[1]); 
    };

    byte B4RTFT_eSPI::getTouch(ArrayUInt* xy, uint16_t threshold)
    {
       uint16_t* tmp = (uint16_t*)xy->data;
       return rcs->getTouch(&tmp[0], &tmp[1], threshold);  
    };

    void B4RTFT_eSPI::calibrateTouch(ArrayUInt* data, uint32_t color_fg, uint32_t color_bg, byte size)
    {
       rcs->calibrateTouch((uint16_t*)data->data, color_fg, color_bg, size);   
    };

    void B4RTFT_eSPI::setTouch(ArrayUInt* data)
    {
       rcs->setTouch((uint16_t*)data->data);
    };
    #endif  
//***********************    
//TFT_eSPI smooth_font
//***********************
  #ifdef SMOOTH_FONT
    #ifdef LOAD_GFXFF  
    void B4RTFT_eSPI::loadFontH(byte VLWid)
    {
       switch (VLWid) {
       case 0: 
          rcs->loadFont(VLW0); break;
       case 1:
          rcs->loadFont(VLW1); break;
       case 2:
          rcs->loadFont(VLW2); break;
       case 3:
          rcs->loadFont(VLW3); break;
       case 4:
          rcs->loadFont(VLW4); break;
       case 5:
          rcs->loadFont(VLW5); break;
       case 6:
          rcs->loadFont(VLW6); break;  
       case 7:
          rcs->loadFont(VLW7); break; 
        default:
          rcs->loadFont(VLW0); break;}                  
    };

    #ifdef FONT_FS_AVAILABLE 
    #if defined(ESP32)
    uint8_t B4RTFT_eSPI::loadFontSD(B4RString* fontName)
    {
       if (!SD.begin()) { return 1;}
       uint8_t cardType = SD.cardType();
       if (cardType == CARD_NONE) {return 2; }
       rcs->loadFont(fontName->data, SD);
       return 0;
    };
    #endif
    uint8_t B4RTFT_eSPI::loadFontLittleFS(B4RString* fontName)
    { 
      if (!LittleFS.begin()) { return 1;}
      rcs->loadFont(fontName->data, LittleFS);
      return 0;
    };
    #endif   

    void B4RTFT_eSPI::loadFontFS(B4RString* fontName)
    {
       rcs->loadFont(fontName->data, true); 
    };

    void B4RTFT_eSPI::unloadFont()
    {
       rcs->unloadFont(); 
    };

    bool B4RTFT_eSPI::getUnicodeIndex(uint16_t unicode, ArrayUInt* index)
    {
       return rcs->getUnicodeIndex(unicode, (uint16_t*)index->data);    
    };

    void B4RTFT_eSPI::drawGlyph(uint16_t code)
    {
       rcs->drawGlyph(code); 
    };

    void B4RTFT_eSPI::showFont(uint32_t td)
    {
       rcs->showFont(td);
    };
    #endif
    #endif
 
 
 
    
//**********************  
//TFT_eSPI_Sprite
//**********************

    uint32_t B4RTFT_eSprite::Initialize(uint32_t TFTid)
    {
       rct = new (backend) TFT_eSprite((TFT_eSPI *)TFTid);
       return ((uint32_t) &rct);
    };

    uint32_t B4RTFT_eSprite::createSprite(int16_t width, int16_t height, byte frames)
    {
       return (uint32_t) rct->createSprite(width, height, frames);
    };

    uint32_t B4RTFT_eSprite::getPointer()
    {
       return (uint32_t)rct->getPointer();
    };

    bool B4RTFT_eSprite::created()
    {
       return rct->created();
    };

    void B4RTFT_eSprite::deleteSprite()
    {
       rct->deleteSprite();
    };

    uint32_t B4RTFT_eSprite::frameBuffer(byte f)
    {
       return (uint32_t)rct->frameBuffer(f);
    };

    uint32_t B4RTFT_eSprite::setColorDepth(byte b)
    {
       return (uint32_t)rct->setColorDepth(b);
    };

    byte B4RTFT_eSprite::getColorDepth()
    {
       return rct->getColorDepth();
    };

    void B4RTFT_eSprite::createPalette(ArrayUInt* palette, byte colors)
    {
       rct->createPalette((uint16_t*)palette->data, colors);
    };

    void B4RTFT_eSprite::createPalette1(ArrayUInt* palette, byte colors)
    {
       rct->createPalette((uint16_t*)palette->data, colors);
    };

    void B4RTFT_eSprite::setPaletteColor(byte index, uint16_t color)
    {
       rct->setPaletteColor(index, color);
    };

    uint16_t B4RTFT_eSprite::getPaletteColor(byte index)
    {
       return rct->getPaletteColor(index);
    };

    void B4RTFT_eSprite::setBitmapColor(uint16_t fg, uint16_t bg)
    {
       rct->setBitmapColor(fg, bg);
    };

    void B4RTFT_eSprite::drawPixel(int32_t x, int32_t y, uint32_t color)
    {
       rct->drawPixel(x, y, color);
    };

    void B4RTFT_eSprite::drawChar(int32_t x, int32_t y, uint16_t c, uint32_t color, uint32_t bg, byte size)
    {
       rct->drawChar(x, y, c, color, bg, size);
    };

    void B4RTFT_eSprite::fillSprite(uint32_t color)
    {
       rct->fillSprite(color);
    };

    void B4RTFT_eSprite::setWindow(int32_t x0, int32_t y0, int32_t x1, int32_t y1)
    {
       rct->setWindow(x0, y0, x1, y1);
    };

    void B4RTFT_eSprite::pushColor(uint16_t color)
    {
       rct->pushColor(color);
    };

    void B4RTFT_eSprite::pushColor1(uint16_t color, uint32_t len)
    {
       rct->pushColor(color, len);
    };

    void B4RTFT_eSprite::writeColor(uint16_t color)
    {
       rct->writeColor(color);
    };

    void B4RTFT_eSprite::setScrollRect(int32_t x, int32_t y, int32_t w, int32_t h, uint16_t color)
    {
       rct->setScrollRect(x, y, w, h, color);
    };

    void B4RTFT_eSprite::scroll(int16_t dx, int16_t dy)
    {
       rct->scroll(dx, dy);
    };

    void B4RTFT_eSprite::drawLine(int32_t x0, int32_t y0, int32_t x1, int32_t y1, uint32_t color)
    {
       rct->drawLine(x0, y0, x1, y1, color);
    };

    void B4RTFT_eSprite::drawFastVLine(int32_t x, int32_t y, int32_t h, uint32_t color)
    {
       rct->drawFastVLine(x, y, h, color);
    };

    void B4RTFT_eSprite::drawFastHLine(int32_t x, int32_t y, int32_t w, uint32_t color)
    {
       rct->drawFastHLine(x, y, w, color);
    };

    void B4RTFT_eSprite::fillRect(int32_t x, int32_t y, int32_t w, int32_t h, uint32_t color)
    {
       rct->fillRect(x, y, w, h, color);
    };

    void B4RTFT_eSprite::setRotation(byte rotation)
    {
       rct->setRotation(rotation);
    };

    byte B4RTFT_eSprite::getRotation()
    {
       return rct->getRotation();
    };

    bool B4RTFT_eSprite::pushRotated(int16_t angle, uint32_t transp)
    {
       return rct->pushRotated(angle, transp);
    };

    bool B4RTFT_eSprite::pushRotated1(uint32_t sprID, int16_t angle, uint32_t transp)
    {
       return rct->pushRotated((TFT_eSprite *) sprID, angle, transp);
    };

    bool B4RTFT_eSprite::getRotatedBounds(int16_t angle, ArrayInt* min_x, ArrayInt* min_y, ArrayInt* max_x, ArrayInt* max_y)
    {
       return rct->getRotatedBounds(angle, (int16_t*)min_x->data, (int16_t*)min_y->data, (int16_t*)max_x->data, (int16_t*)max_y->data);
    };

    bool B4RTFT_eSprite::getRotatedBounds1(uint32_t sprID, int16_t angle, ArrayInt* min_x, ArrayInt* min_y, ArrayInt* max_x, ArrayInt* max_y)
    {
       return rct->getRotatedBounds((TFT_eSprite *) sprID, angle, (int16_t*)min_x->data, (int16_t*)min_y->data, (int16_t*)max_x->data, (int16_t*)max_y->data);
    };

    void B4RTFT_eSprite::getRotatedBounds2(int16_t angle, int16_t w, int16_t h, int16_t xp, int16_t yp, ArrayInt* min_x, ArrayInt* min_y, ArrayInt* max_x, ArrayInt* max_y)
    {
       rct->getRotatedBounds(angle, w, h, xp, yp, (int16_t*)min_x->data, (int16_t*)min_y->data, (int16_t*)max_x->data, (int16_t*)max_y->data);
    };

    uint16_t B4RTFT_eSprite::readPixel(int32_t x0, int32_t y0)
    {
       return rct->readPixel(x0, y0);
    };

    uint16_t B4RTFT_eSprite::readPixelValue(int32_t x, int32_t y)
    {
       return rct->readPixelValue(x, y);
    };

    void B4RTFT_eSprite::pushImage(int32_t x0, int32_t y0, int32_t w, int32_t h, ArrayUInt* data, byte sbpp)
    {
       rct->pushImage(x0, y0, w, h, (uint16_t*)data->data, sbpp);
    };

    void B4RTFT_eSprite::pushImage1(int32_t x0, int32_t y0, int32_t w, int32_t h, ArrayUInt* data)
    {
       rct->pushImage(x0, y0, w, h, (uint16_t*)data->data);
    };

    void B4RTFT_eSprite::pushSprite(int32_t x, int32_t y)
    {
       rct->pushSprite(x, y);
    };

    void B4RTFT_eSprite::pushSprite1(int32_t x, int32_t y, uint16_t transparent)
    {
       rct->pushSprite(x, y, transparent);
    };

    bool B4RTFT_eSprite::pushSprite2(int32_t tx, int32_t ty, int32_t sx, int32_t sy, int32_t sw, int32_t sh)
    {
       return rct->pushSprite(tx, ty, sx, sy, sw, sh);
    };

    bool B4RTFT_eSprite::pushToSprite(uint32_t dsprID, int32_t x, int32_t y)
    {
       return rct->pushToSprite((TFT_eSprite *) dsprID, x, y);
    };

    bool B4RTFT_eSprite::pushToSprite1(uint32_t dsprID, int32_t x, int32_t y, uint16_t transparent)
    {
       return rct->pushToSprite((TFT_eSprite *) dsprID, x, y, transparent);
    };

    int16_t B4RTFT_eSprite::drawChar1(uint16_t uniCode, int32_t x, int32_t y, byte font)
    {
       return rct->drawChar(uniCode, x, y, font);
    };

    int16_t B4RTFT_eSprite::drawChar2(uint16_t uniCode, int32_t x, int32_t y)
    {
       return rct->drawChar(uniCode, x, y);
    };

    int16_t B4RTFT_eSprite::width()
    {
       return rct->width();
    };

    int16_t B4RTFT_eSprite::height()
    {
       return rct->height();
    };

//    void B4RTFT_eSprite::drawGlyph(uint16_t code)
//    {
//       rct->drawGlyph(code);
//    };

    void B4RTFT_eSprite::printToSprite(B4RString* string)
    {
       rct->printToSprite(string->data);
    };

    void B4RTFT_eSprite::printToSprite1(ArrayByte* cbuffer)
    {
       rct->printToSprite((char*)cbuffer->data, cbuffer->length);
    };

    int16_t B4RTFT_eSprite::printToSprite2(int16_t x, int16_t y, uint16_t index)
    {
       return rct->printToSprite(x, y, index);
    };
        
//*************
//from TFT_eSPI 
//*************
//    void B4RTFT_eSprite::begin_nin_write()
//    {
//       rct->begin_nin_write();
//    };

//    void B4RTFT_eSprite::end_nin_write()
//    {
//       rct->end_nin_write();
//    };
    
    void B4RTFT_eSprite::setOrigin(int32_t x, int32_t y)
    {
       rct->setOrigin(x, y);
    };

    int32_t B4RTFT_eSprite::getOriginX()
    {
       return rct->getOriginX();
    };

    int32_t B4RTFT_eSprite::getOriginY()
    {
       return rct->getOriginY();
    };

    void B4RTFT_eSprite::invertDisplay(bool i)
    {
       rct->invertDisplay(i);
    };

    void B4RTFT_eSprite::setAddrWindow(int32_t xs, int32_t ys, int32_t w, int32_t h)
    {
       rct->setAddrWindow(xs, ys, w, h);
    };

    void B4RTFT_eSprite::setViewport(int32_t x, int32_t y, int32_t w, int32_t h, bool vpDatum)
    {
       rct->setViewport(x, y, w, h, vpDatum);
    };

    bool B4RTFT_eSprite::checkViewport(int32_t x, int32_t y, int32_t w, int32_t h)
    {
       return rct->checkViewport(x, y, w, h);
    };

    int32_t B4RTFT_eSprite::getViewportX()
    {
       return rct->getViewportX();
    };

    int32_t B4RTFT_eSprite::getViewportY()
    {
       return rct->getViewportY();
    };

    int32_t B4RTFT_eSprite::getViewportWidth()
    {
       return rct->getViewportWidth();
    };

    int32_t B4RTFT_eSprite::getViewportHeight()
    {
       return rct->getViewportHeight();
    };

    bool B4RTFT_eSprite::getViewportDatum()
    {
       return rct->getViewportDatum();
    };

    void B4RTFT_eSprite::frameViewport(uint16_t color, int32_t w)
    {
       rct->frameViewport(color, w);
    };

    void B4RTFT_eSprite::resetViewport()
    {
       rct->resetViewport();
    };

    bool B4RTFT_eSprite::clipAddrWindow(ArrayLong* xywh)
    {
       int32_t* tmp =(int32_t*) xywh->data;
       return rct->clipAddrWindow(&tmp[0], &tmp[1], &tmp[2], &tmp[3]);
    };

    bool B4RTFT_eSprite::clipWindow(ArrayLong* xsysxeye)
    {
       int32_t* tmp = (int32_t*)xsysxeye->data;
       return rct->clipWindow(&tmp[0], &tmp[1], &tmp[2], &tmp[3]);
    };

//    void B4RTFT_eSprite::pushColor1(uint16_t color, uint32_t len)
//    {
//       rct->pushColor(color, len);
//    };

    void B4RTFT_eSprite::pushColors(ArrayUInt* data, bool swap)
    {
       rct->pushColors((uint16_t*)data->data, data->length, swap);
    };

    void B4RTFT_eSprite::pushColors1(ArrayByte* data)
    {
       rct->pushColors((byte*)data->data, data->length);
    };

    void B4RTFT_eSprite::pushBlock(uint16_t color, uint32_t len)
    {
       rct->pushBlock(color, len);
    };

    void B4RTFT_eSprite::pushPixels(ArrayByte* data_in)
    {
       rct->pushPixels((uint8_t*) data_in, data_in->length);
    };

    byte B4RTFT_eSprite::tft_Read8()
    {
 #ifdef TFT_SDA_READ    
    #if defined (TFT_eSPI_ENABLE_8_BIT_READ)
       return 1; //rct->tft_Read_8();
    #else
       return 0;   
    #endif
 #else
       return 0;     
 #endif         
    };

    void B4RTFT_eSprite::begin_SDA_Read()
    {
 #ifdef TFT_SDA_READ    
       rct->begin_SDA_Read();
 #endif       
    };

    void B4RTFT_eSprite::end_SDA_Read()
    {
 #ifdef TFT_SDA_READ    
       rct->end_SDA_Read();
 #endif
    };

    void B4RTFT_eSprite::fillScreen(uint32_t color)
    {
       rct->fillScreen(color);
    };

    void B4RTFT_eSprite::drawRect(int32_t x, int32_t y, int32_t w, int32_t h, uint32_t color)
    {
       rct->drawRect(x, y, w, h, color);
    };

    void B4RTFT_eSprite::drawRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color)
    {
       rct->drawRoundRect(x, y, w, h, radius, color);
    };

    void B4RTFT_eSprite::fillRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color)
    {
       rct->fillRoundRect(x, y, w, h, radius, color);
    };

    void B4RTFT_eSprite::fillRectVGradient(int16_t x, int16_t y, int16_t w, int16_t h, uint32_t color1, uint32_t color2)
    {
       rct->fillRectVGradient(x, y, w, h, color1, color2);
    };

    void B4RTFT_eSprite::fillRectHGradient(int16_t x, int16_t y, int16_t w, int16_t h, uint32_t color1, uint32_t color2)
    {
       rct->fillRectHGradient(x, y, w, h, color1, color2);
    };

    void B4RTFT_eSprite::drawCircle(int32_t x, int32_t y, int32_t r, uint32_t color)
    {
       rct->drawCircle(x, y, r, color);
    };

    void B4RTFT_eSprite::drawCircleHelper(int32_t x, int32_t y, int32_t r, byte cornername, uint32_t color)
    {
       rct->drawCircleHelper(x, y, r, cornername, color);
    };

    void B4RTFT_eSprite::fillCircle(int32_t x, int32_t y, int32_t r, uint32_t color)
    {
       rct->fillCircle(x, y, r, color);
    };

    void B4RTFT_eSprite::fillCircleHelper(int32_t x, int32_t y, int32_t r, byte cornername, int32_t delta, uint32_t color)
    {
       rct->fillCircleHelper(x, y, r, cornername, delta, color);
    };

    void B4RTFT_eSprite::drawEllipse(int16_t x, int16_t y, int32_t rx, int32_t ry, uint16_t color)
    {
       rct->drawEllipse(x, y, rx, ry, color);
    };

    void B4RTFT_eSprite::fillEllipse(int16_t x, int16_t y, int32_t rx, int32_t ry, uint16_t color)
    {
       rct->fillEllipse(x, y, rx, ry, color);
    };

    void B4RTFT_eSprite::drawTriangle(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3, uint32_t color)
    {
       rct->drawTriangle(x1, y1, x2, y2, x3, y3, color);
    };

    void B4RTFT_eSprite::fillTriangle(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3, uint32_t color)
    {
       rct->fillTriangle(x1, y1, x2, y2, x3, y3, color);
    };

//    uint16_t B4RTFT_eSprite::drawPixel1(int32_t x, int32_t y, uint32_t color, byte alpha, uint32_t bg_color)
//    {
//       return rct->drawPixel(x, y, color, alpha, bg_color);
//    };

    void B4RTFT_eSprite::drawSmoothArc(int32_t x, int32_t y, int32_t r, int32_t ir, uint32_t startAngle, uint32_t endAngle, uint32_t fg_color, uint32_t bg_color, bool roundEnds)
    {
       rct->drawSmoothArc(x, y, r, ir, startAngle, endAngle, fg_color, bg_color, roundEnds);
    };

    void B4RTFT_eSprite::drawArc(int32_t x, int32_t y, int32_t r, int32_t ir, uint32_t startAngle, uint32_t endAngle, uint32_t fg_color, uint32_t bg_color, bool smoothArc)
    {
       rct->drawArc(x, y, r, ir, startAngle, endAngle, fg_color, bg_color, smoothArc);
    };

    void B4RTFT_eSprite::drawSmoothCircle(int32_t x, int32_t y, int32_t r, uint32_t fg_color, uint32_t bg_color)
    {
       rct->drawSmoothCircle(x, y, r, fg_color, bg_color);
    };

    void B4RTFT_eSprite::fillSmoothCircle(int32_t x, int32_t y, int32_t r, uint32_t color, uint32_t bg_color)
    {
       rct->fillSmoothCircle(x, y, r, color, bg_color);
    };

    void B4RTFT_eSprite::drawSmoothRoundRect(int32_t x, int32_t y, int32_t r, int32_t ir, int32_t w, int32_t h, uint32_t fg_color, uint32_t bg_color, byte quadrants)
    {
       rct->drawSmoothRoundRect(x, y, r, ir, w, h, fg_color, bg_color, quadrants);
    };

    void B4RTFT_eSprite::fillSmoothRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color, uint32_t bg_color)
    {
       rct->fillSmoothRoundRect(x, y, w, h, radius, color, bg_color);
    };

    void B4RTFT_eSprite::drawSpot(double ax, double ay, double r, uint32_t fg_color, uint32_t bg_color)
    {
       rct->drawSpot(ax, ay, r, fg_color, bg_color);
    };

    void B4RTFT_eSprite::drawWideLine(double ax, double ay, double bx, double by, double wd, uint32_t fg_color, uint32_t bg_color)
    {
       rct->drawWideLine(ax, ay, bx, by, wd, fg_color, bg_color);
    };

    void B4RTFT_eSprite::drawWedgeLine(double ax, double ay, double bx, double by, double aw, double bw, uint32_t fg_color, uint32_t bg_color)
    {
       rct->drawWedgeLine(ax, ay, bx, by, aw, bw, fg_color, bg_color);
    };

    void B4RTFT_eSprite::setSwapBytes(bool swap)
    {
       rct->setSwapBytes(swap);
    };

    bool B4RTFT_eSprite::getSwapBytes()
    {
       return rct->getSwapBytes();
    };

    void B4RTFT_eSprite::drawBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor)
    {
       rct->drawBitmap(x, y, (byte*)bitmap->data, w, h, fgcolor);
    };

    void B4RTFT_eSprite::drawBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor, uint16_t bgcolor)
    {
       rct->drawBitmap(x, y, (byte*)bitmap->data, w, h, fgcolor, bgcolor);
    };

    void B4RTFT_eSprite::drawXBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor)
    {
       rct->drawXBitmap(x, y, (byte*)bitmap->data, w, h, fgcolor);
    };

    void B4RTFT_eSprite::drawXBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor, uint16_t bgcolor)
    {
       rct->drawXBitmap(x, y, (byte*)bitmap->data, w, h, fgcolor, bgcolor);
    };

//    void B4RTFT_eSprite::setBitmapColor(uint16_t fgcolor, uint16_t bgcolor)
//    {
//       rct->setBitmapColor(fgcolor, bgcolor);
//    };

    void B4RTFT_eSprite::setPivot(int16_t x, int16_t y)
    {
       rct->setPivot(x, y);
    };

    int16_t B4RTFT_eSprite::getPivotX()
    {
       return rct->getPivotX();
    };

    int16_t B4RTFT_eSprite::getPivotY()
    {
       return rct->getPivotY();
    };

    void B4RTFT_eSprite::readRect(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data)
    {
       rct->readRect(x, y, w, h, (uint16_t*)data->data);
    };

    void B4RTFT_eSprite::pushRect(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data)
    {
       rct->pushRect(x, y, w, h, (uint16_t*)data->data);
    };

//    void B4RTFT_eSprite::pushImage(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data)
//    {
//       rct->pushImage(x, y, w, h, (uint16_t*)data->data);
//    };

//    void B4RTFT_eSprite::pushImage1(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, uint16_t transparent)
//    {
//       rct->pushImage(x, y, w, h, (uint16_t*)data->data, transparent);
//    };

//    void B4RTFT_eSprite::pushImage2(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, uint16_t transparent)
//    {
//       rct->pushImage(x, y, w, h, (uint16_t*)data->data, transparent);
//    };

//    void B4RTFT_eSprite::pushImage3(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data)
//   {
//       rct->pushImage(x, y, w, h, (uint16_t*)data->data);
//    };

//    void B4RTFT_eSprite::pushImage4(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, bool bpp8, ArrayUInt* cmap)
//    {
//       rct->pushImage(x, y, w, h, (byte*)data->data, bpp8, (uint16_t*)cmap->data);
//    };

//    void B4RTFT_eSprite::pushImage5(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, byte  transparent, bool bpp8, ArrayUInt* cmap)
//    {
//       rct->pushImage(x, y, w, h, (byte*)data->data, transparent, bpp8, (uint16_t*)cmap->data);
//    };

//    void B4RTFT_eSprite::pushImage6(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, bool bpp8, ArrayUInt* cmap)
//    {
//       rct->pushImage(x, y, w, h, (byte*)data->data, bpp8, (uint16_t*)cmap->data);
//    };

    void B4RTFT_eSprite::pushMaskedImage(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* img, ArrayByte* mask)
    {
       rct->pushMaskedImage(x, y, w, h, (uint16_t*)img->data, (byte*)mask->data);
    };

    void B4RTFT_eSprite::readRectRGB(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data)
    {
       rct->readRectRGB(x, y, w, h, (byte*)data->data);
    };

    int16_t B4RTFT_eSprite::drawNumber(int32_t intNumber, int32_t x, int32_t y, byte font)
    {
       return rct->drawNumber(intNumber, x, y, font);
    };

    int16_t B4RTFT_eSprite::drawNumber1(int32_t intNumber, int32_t x, int32_t y)
    {
       return rct->drawNumber(intNumber, x, y);
    };

    int16_t B4RTFT_eSprite::drawFloat(double doubleNumber, byte decimal, int32_t x, int32_t y, byte font)
    {
       return rct->drawFloat(doubleNumber, decimal, x, y, font);
    };

    int16_t B4RTFT_eSprite::drawFloat1(double doubleNumber, byte decimal, int32_t x, int32_t y)
    {
       return rct->drawFloat(doubleNumber, decimal, x, y);
    };

    int16_t B4RTFT_eSprite::drawString(B4RString* string, int32_t x, int32_t y, byte font)
    {
       return rct->drawString(string->data, x, y, font);
    };

    int16_t B4RTFT_eSprite::drawString1(B4RString* string, int32_t x, int32_t y)
    {
       return rct->drawString(string->data, x, y);
    };

    int16_t B4RTFT_eSprite::drawCentreString(B4RString* string, int32_t x, int32_t y, byte font)
    {
       return rct->drawCentreString(string->data, x, y, font);
    };

    int16_t B4RTFT_eSprite::drawRightString(B4RString* string, int32_t x, int32_t y, byte font)
    {
       return rct->drawRightString(string->data, x, y, font);
    };

    void B4RTFT_eSprite::setCursor(int16_t x, int16_t y)
    {
       rct->setCursor(x, y);
    };

    void B4RTFT_eSprite::setCursor1(int16_t x, int16_t y, byte font)
    {
       rct->setCursor(x, y, font);
    };

    int16_t B4RTFT_eSprite::getCursorX()
    {
       return rct->getCursorX();
    };

    int16_t B4RTFT_eSprite::getCursorY()
    {
       return rct->getCursorY();
    };

    void B4RTFT_eSprite::setTextColor(uint16_t color)
    {
       rct->setTextColor(color);
    };

    void B4RTFT_eSprite::setTextColor1(uint16_t fgcolor, uint16_t bgcolor, bool bgfill)
    {
       rct->setTextColor(fgcolor, bgcolor, bgfill);
    };

    void B4RTFT_eSprite::setTextSize(byte size)
    {
       rct->setTextSize(size);
    };

    void B4RTFT_eSprite::setTextWrap(bool wrapX, bool wrapY)
    {
       rct->setTextWrap(wrapX, wrapY);
    };

    void B4RTFT_eSprite::setTextDatum(byte datum)
    {
       rct->setTextDatum(datum);
    };

    byte B4RTFT_eSprite::getTextDatum()
    {
       return rct->getTextDatum();
    };

    void B4RTFT_eSprite::setTextPadding(uint16_t x_width)
    {
       rct->setTextPadding(x_width);
    };

    uint16_t B4RTFT_eSprite::getTextPadding()
    {
       return rct->getTextPadding();
    };

  #ifdef LOAD_GFXFF
    void B4RTFT_eSprite::setFreeFont(byte GFXid)
    {
     //  rct->setFreeFont(GFXfont * f);
       rct->setFreeFont(B4RTFT_eSPI::GFXfonts[GFXid]);
    };

    void B4RTFT_eSprite::setTextFont(byte font)
    {    
       rct->setTextFont(font);    
    };
  #else
    void B4RTFT_eSprite::setFreeFont1(byte font)
    {     
       rct->setFreeFont(font);      
    };

    void B4RTFT_eSprite::setTextFont1(byte font)
    {    
       rct->setTextFont(font);    
    };
  #endif 
  
    int16_t B4RTFT_eSprite::textWidth(B4RString* string, byte font)
    {
       return rct->textWidth(string->data, font);
    };

    int16_t B4RTFT_eSprite::textWidth1(B4RString* string)
    {
       return rct->textWidth(string->data);
    };

    int16_t B4RTFT_eSprite::textWidth2(B4RString* string, byte font)
    {
       return rct->textWidth( string->data, font);
    };

    int16_t B4RTFT_eSprite::textWidth3(B4RString* string)
    {
       return rct->textWidth( string->data);
    };

    int16_t B4RTFT_eSprite::fontHeight(int16_t font)
    {
       return rct->fontHeight(font);
    };

    int16_t B4RTFT_eSprite::fontHeight1()
    {
       return rct->fontHeight();
    };

    uint16_t B4RTFT_eSprite::decodeUTF8(ArrayByte* buf, ArrayUInt* index, uint16_t remaining)
    {
       return rct->decodeUTF8((byte*)buf->data, (uint16_t*)index->data, remaining);
    };

    uint16_t B4RTFT_eSprite::decodeUTF81(byte c)
    {
       return rct->decodeUTF8(c);
    };

    uint16_t B4RTFT_eSprite::write(uint8_t utf8)
    {
       return rct->write(utf8);
    };

//    void B4RTFT_eSprite::setCallback(Subuint_uintuint OnTFTColorCallbackSub)
//    {
//       this->OnTFTColorCallback_Sub = OnTFTColorCallbackSub;
//       instance = this;  
//       rct->setCallback(TFTColor_Callback);
//    };
// ????????????????????????????????????????????????????????????????????????
 
//    uint16_t B4RTFT_eSprite::TFTColorCallback(uint16_t x, uint16_t y)
//    {
//       return instance->OnTFTColorCallback_Sub(x, y);
//    };

    uint16_t B4RTFT_eSprite::fontsLoaded()
    {
       return rct->fontsLoaded();
    };

    void B4RTFT_eSprite::spiwrite(uint8_t c)
    {
       rct->spiwrite( c);
    };

    void B4RTFT_eSprite::writecommand(uint16_t c)
    {
#ifdef RM68120_DRIVER
       rct->writecommand(c);
#endif       
    };

    void B4RTFT_eSprite::writeRegister8(uint16_t c, byte d)
    {
#ifdef RM68120_DRIVER    
       rct->writeRegister8(c, d);
#endif
    };

    void B4RTFT_eSprite::writeRegister16(uint16_t c, uint16_t d)
    {
#ifdef RM68120_DRIVER    
       rct->writeRegister16(c, d);
#endif       
    };

    void B4RTFT_eSprite::writecommand1(byte c)
    {
#ifndef RM68120_DRIVER    
       rct->writecommand(c);
#endif       
    };

    void B4RTFT_eSprite::writedata(byte d)
    {
       rct->writedata(d);
    };

    void B4RTFT_eSprite::commandList(ArrayByte* addr)
    {
       rct->commandList((byte*)addr->data);
    };

    byte B4RTFT_eSprite::readcommand8(byte cmd_function, byte index)
    {
       return rct->readcommand8(cmd_function, index);
    };

    uint16_t B4RTFT_eSprite::readcommand16(byte cmd_function, byte index)
    {
       return rct->readcommand16(cmd_function, index);
    };

    uint32_t B4RTFT_eSprite::readcommand32(byte cmd_function, byte index)
    {
       return rct->readcommand32(cmd_function, index);
    };

    uint16_t B4RTFT_eSprite::color565(byte red, byte green, byte blue)
    {
       return rct->color565(red, green, blue);
    };

    uint16_t B4RTFT_eSprite::color8to16(byte color332)
    {
       return rct->color8to16(color332);
    };

    byte B4RTFT_eSprite::color16to8(uint16_t color565)
    {
       return rct->color16to8(color565);
    };

    uint32_t B4RTFT_eSprite::color16to24(uint16_t color565)
    {
       return rct->color16to24(color565);
    };

    uint32_t B4RTFT_eSprite::color24to16(uint32_t color888)
    {
       return rct->color24to16(color888);
    };

    uint16_t B4RTFT_eSprite::alphaBlend(byte alpha, uint16_t fgc, uint16_t bgc)
    {
       return rct->alphaBlend(alpha, fgc, bgc);
    };

    uint16_t B4RTFT_eSprite::alphaBlend1(byte alpha, uint16_t fgc, uint16_t bgc, byte dither)
    {
       return rct->alphaBlend(alpha, fgc, bgc, dither);
    };

    uint32_t B4RTFT_eSprite::alphaBlend24(byte alpha, uint32_t fgc, uint32_t bgc, byte dither)
    {
       return rct->alphaBlend24(alpha, fgc, bgc, dither);
    };

    bool B4RTFT_eSprite::initDMA(bool ctrl_cs)
    {
       return rct->initDMA(ctrl_cs);
    };

    void B4RTFT_eSprite::deInitDMA()
    {
       rct->deInitDMA();
    };

    void B4RTFT_eSprite::pushImageDMA(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, ArrayUInt* buffer)
    {
       rct->pushImageDMA(x, y, w, h, (uint16_t*)data->data, (uint16_t*)buffer->data);
    };

    void B4RTFT_eSprite::pushImageDMA1(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data)
    {
#if defined (ESP32)    
       rct->pushImageDMA(x, y, w, h, (uint16_t*)data->data);      
#endif       
    };

    void B4RTFT_eSprite::pushPixelsDMA(ArrayUInt* image)
    {
       rct->pushPixelsDMA((uint16_t*)image->data, image->length);
    };

    bool B4RTFT_eSprite::dmaBusy()
    {
       return rct->dmaBusy();
    };

    void B4RTFT_eSprite::dmaWait()
    {
       rct->dmaWait();
    };
    
     bool B4RTFT_eSprite::DMA_Enabled()
    {
      return  rct->DMA_Enabled;
    };
    
    uint8_t B4RTFT_eSprite::spiBusyCheck()
    {
       return rct->spiBusyCheck;
    };

    void B4RTFT_eSprite::startWrite()
    {
       rct->startWrite();
    };

//    void B4RTFT_eSprite::writeColor2(uint16_t color, uint32_t len)
//    {
//       rct->writeColor(color, len);
//    };

    void B4RTFT_eSprite::endWrite()
    {
       rct->endWrite();
    };

//??            #define CP437_SWITCH 1
//??            #define UTF8_SWITCH  2
//??            #define PSRAM_ENABLE 3

    void B4RTFT_eSprite::setAttribute(byte id, byte a)
    {
       rct->setAttribute(id, a);
    };

    byte B4RTFT_eSprite::getAttribute(byte id)
    {
       return rct->getAttribute(id);
    };

  //
  // void     getSetup(setup_t& tft_settings); 
  //
  
//    bool B4RTFT_eSprite::verifySetupID(uint32_t id)
//    {
//       return rct->verifySetupID(id);
//    };

//#if !defined (TFT_PARALLEL_8_BIT) && !defined (RP2040_PIO_INTERFACE)
//??     SPIClass& getSPIinstance(void) 
//#endif
    uint32_t B4RTFT_eSprite::textcolor()
    {
       return rct->textcolor;
    };

    uint32_t B4RTFT_eSprite::textbgcolor()
    {
       return rct->textbgcolor;
    };

    uint32_t B4RTFT_eSprite::bitmap_fg()
    {
       return rct->bitmap_fg;
    };

    uint32_t B4RTFT_eSprite::bitmap_bg()
    {
       return rct->bitmap_bg;
    };

    byte B4RTFT_eSprite::textfont()
    {
       return rct->textfont;
    };

    byte B4RTFT_eSprite::textsize()
    {
       return rct->textsize;
    };

    byte B4RTFT_eSprite::textdatum()
    {
       return rct->textdatum;
    };

    byte B4RTFT_eSprite::rotation()
    {
       return rct->rotation;
    };
    
    uint16_t B4RTFT_eSprite::decoderState()
    {
       return rct->decoderState;
    };
    
    uint16_t B4RTFT_eSprite::decoderBuffer()
    {
       return rct->decoderBuffer;
    };
    
    uint16_t B4RTFT_eSprite::print(B4RString* string)
    {
       return rct->print(string->data);
    };

    uint16_t B4RTFT_eSprite::println(B4RString* string)
    {
       return rct->println(string->data);
    };
//*****************************    
//TFT_eSPI Touch
//*****************************
    #ifdef TOUCH_CS
    byte B4RTFT_eSprite::getTouchRaw(ArrayUInt* xy)
    {
       uint16_t* tmp = (uint16_t*)xy->data;
       return rct->getTouchRaw(&tmp[0], &tmp[1]);     
    };

    uint16_t B4RTFT_eSprite::getTouchRawZ()
    {
       return rct->getTouchRawZ();  
    };

    void B4RTFT_eSprite::convertRawXY(ArrayUInt* xy)
    {
       uint16_t* tmp = (uint16_t*)xy->data;   
       rct->convertRawXY(&tmp[0], &tmp[1]); 
    };

    byte B4RTFT_eSprite::getTouch(ArrayUInt* xy, uint16_t threshold)
    {
       uint16_t* tmp = (uint16_t*)xy->data;
       return rct->getTouch(&tmp[0], &tmp[1], threshold);  
    };

    void B4RTFT_eSprite::calibrateTouch(ArrayUInt* data, uint32_t color_fg, uint32_t color_bg, byte size)
    {
       rct->calibrateTouch((uint16_t*)data->data, color_fg, color_bg, size);   
    };

    void B4RTFT_eSprite::setTouch(ArrayUInt* data)
    {
       rct->setTouch((uint16_t*)data->data);
    };
    #endif  
//***********************    
//TFT_eSPI smooth_font
//***********************
  #ifdef SMOOTH_FONT
    #ifdef LOAD_GFXFF  
    void B4RTFT_eSprite::loadFontH(byte VLWid)
    {
       switch (VLWid) {
       case 0: 
          rct->loadFont(VLW0); break;
       case 1:
          rct->loadFont(VLW1); break;
       case 2:
          rct->loadFont(VLW2); break;
       case 3:
          rct->loadFont(VLW3); break;
       case 4:
          rct->loadFont(VLW4); break;
       case 5:
          rct->loadFont(VLW5); break;
       case 6:
          rct->loadFont(VLW6); break;  
       case 7:
          rct->loadFont(VLW7); break; 
       default:
          rct->loadFont(VLW0); break;}                  
    };

    #ifdef FONT_FS_AVAILABLE 
    #if defined(ESP32)
    uint8_t B4RTFT_eSprite::loadFontSD(B4RString* fontName)
    {
       if (!SD.begin()) { return 1;}
       uint8_t cardType = SD.cardType();
       if (cardType == CARD_NONE) { return 2; }
       rct->loadFont(fontName->data, SD);
       return 0;
    };
    #endif
    uint8_t B4RTFT_eSprite::loadFontLittleFS(B4RString* fontName)
    { 
      if (!LittleFS.begin()) { return 1;}
      rct->loadFont(fontName->data, LittleFS);
      return 0;
    };
    #endif   

    void B4RTFT_eSprite::loadFontFS(B4RString* fontName)
    {
//       rct->loadFont(fontName->data, true); 
    };

    void B4RTFT_eSprite::unloadFont()
    {
       rct->unloadFont(); 
    };

    bool B4RTFT_eSprite::getUnicodeIndex(uint16_t unicode, ArrayUInt* index)
    {
       return rct->getUnicodeIndex(unicode, (uint16_t*)index->data);    
    };

    void B4RTFT_eSprite::drawGlyph(uint16_t code)
    {
       rct->drawGlyph(code); 
    };

    void B4RTFT_eSprite::showFont(uint32_t td)
    {
       rct->showFont(td);
    };
    #endif
    #endif
 



 //**********************
 //TFT_eSPI_Buttom
 //********************** 
     void B4RTFT_eSPI_Button::Initialize()
    {
       rcr = new (backend) TFT_eSPI_Button();
    };

    void B4RTFT_eSPI_Button::initButton(uint32_t TFTid, int16_t x, int16_t y, uint16_t w, uint16_t h, uint16_t outline, uint16_t fill, uint16_t textcolor, B4RString* label, byte textsize)
    {
       rcr->initButton((TFT_eSPI *) TFTid, x, y, w, h, outline, fill, textcolor, (char*)label->data, textsize);
    };

    void B4RTFT_eSPI_Button::initButtonUL(uint32_t TFTid, int16_t x1, int16_t y1, uint16_t w, uint16_t h, uint16_t outline, uint16_t fill, uint16_t textcolor, B4RString* label, byte textsize)
    {
       rcr->initButtonUL((TFT_eSPI *) TFTid, x1, y1, w, h, outline, fill, textcolor, (char*)label->data, textsize);
    };

    void B4RTFT_eSPI_Button::setLabelDatum(int16_t x_delta, int16_t y_delta, byte datum)
    {
       rcr->setLabelDatum(x_delta, y_delta, datum);
    };

    void B4RTFT_eSPI_Button::drawButton(bool inverted, B4RString* long_name)
    {
       rcr->drawButton(inverted, long_name->data);
    };

    bool B4RTFT_eSPI_Button::contains(int16_t x, int16_t y)
    {
       return rcr->contains(x, y);
    };

    void B4RTFT_eSPI_Button::press(bool p)
    {
       rcr->press(p);
    };

    bool B4RTFT_eSPI_Button::isPressed()
    {
       return rcr->isPressed();
    };

    bool B4RTFT_eSPI_Button::justPressed()
    {
       return rcr->justPressed();
    };

    bool B4RTFT_eSPI_Button::justReleased()
    {
       return rcr->justReleased();
    };

}
