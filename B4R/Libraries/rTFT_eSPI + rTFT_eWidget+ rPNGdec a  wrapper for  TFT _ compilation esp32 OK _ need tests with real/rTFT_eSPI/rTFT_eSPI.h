    
#pragma once
#include "B4RDefines.h"
#include "TFT_eSPI.h"
#include <SPI.h>
#ifdef FONT_FS_AVAILABLE
    #include <SD.h>
    #include <FS.h>
    #include <LittleFS.h>
#endif
//~hide
const uint8_t tmp[] = {0};
#define VLW0 tmp
#define VLW1 tmp
#define VLW2 tmp
#define VLW3 tmp
#define VLW4 tmp
#define VLW5 tmp
#define VLW6 tmp
#define VLW7 tmp
	
    //~Event: UInt TFTColorCallback(x as UInt, y as UInt)
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino  https://github.com/Bodmer/TFT_eSPI

namespace B4R {
    typedef uint16_t (*Subuint_uintuint)(uint16_t x, uint16_t y);
    //~shortname:TFT_eSPI
    
    class B4RTFT_eSPI
    {
        private:
            uint8_t backend[sizeof(TFT_eSPI)];                        
            TFT_eSPI* rcs;
            static B4RTFT_eSPI*  instance;
            Subuint_uintuint OnTFTColorCallback_Sub;
        public:
            // fonts array to store GFXfonts / VLWfonts / PNGfiles
            //~hide
            static const  GFXfont * GFXfonts[];  
            // VLW fonts in array format and stored in a h file
            //~hide
 //           static const uint8_t * VLWfonts[];
 
            // -1 to use default parameter (_W = TFT_WIDTH, _H = TFT_HEIGHT)
            uint32_t Initialize(int16_t _W, int16_t _H);
            // 0xFF tu use default parameter (tc = TAB_COLOUR)
            void begin(byte tc);
            
            //   push a single pixel at an arbitrary position
            void drawPixel(int32_t x, int32_t y, uint32_t color);
            //   draw a single character in the GLCD or GFXFF font
            void drawChar(int32_t x, int32_t y, uint16_t c, uint32_t color, uint32_t bg, byte size);
            //   draw a line between 2 arbitrary points
            void drawLine(int32_t xs, int32_t ys, int32_t xe, int32_t ye, uint32_t color);
            //   draw a vertical line
            void drawFastVLine(int32_t x, int32_t y, int32_t h, uint32_t color);
            //  draw a horizontal line
            void drawFastHLine(int32_t x, int32_t y, int32_t w, uint32_t color);
            //   draw a filled rectangle
            void fillRect(int32_t x, int32_t y, int32_t w, int32_t h, uint32_t color);
            //   draw a Unicode glyph onto the screen
            //   Any UTF-8 decoding must be done before calling drawChar()
            int16_t drawChar1(uint16_t uniCode, int32_t x, int32_t y, byte font);
            //   draw a Unicode glyph onto the screen
            //   Any UTF-8 decoding must be done before calling drawChar()
            int16_t drawChar2(uint16_t uniCode, int32_t x, int32_t y);
            
            int16_t height();
            int16_t width();
            //   Read the colour of a pixel at x,y and return value in 565 format
            uint16_t readPixel(int32_t x, int32_t y);
            //   define an area to receive a stream of pixels
            void setWindow(int32_t xs, int32_t ys, int32_t xe, int32_t ye);
            //   Push (aka write pixel) colours to the set window
            void pushColor(uint16_t color);
            //   These are non-inlined to enable override
            void begin_nin_write();
            //   Non-inlined version to permit override
            void end_nin_write();
            //   Set the display image orientation to 0, 1, 2 or 3
            void setRotation(byte r);
            //   Read the current rotation
            byte getRotation();
            //   Change the origin position from the default top left
            //   Note: setRotation, setViewport and resetViewport will revert origin to top left corner of screen/sprite            
            void setOrigin(int32_t x, int32_t y);
            //   Get graphics origin to position X
            int32_t getOriginX();
            //   Get graphics origin to position Y            
            int32_t getOriginY();
            //   Tell TFT to invert all displayed colours
            void invertDisplay(bool i);
            //   The TFT_eSprite class inherits the following functions (not all are useful to Sprite class            
            void setAddrWindow(int32_t xs, int32_t ys, int32_t w, int32_t h);
            //   Viewport commands, see "Viewport_Demo" sketch   
            //   default : vpDatum = true     
            void setViewport(int32_t x, int32_t y, int32_t w, int32_t h, bool vpDatum);
            //   Check if any part of specified area is visible in viewport
            //   Note: Setting w and h to 1 will check if coordinate x,y is in area
            bool checkViewport(int32_t x, int32_t y, int32_t w, int32_t h);
            //   Get x position of the viewport datum
            int32_t getViewportX();
            //   Get Y position of the viewport datum            
            int32_t getViewportY();
            //   Get width of the viewport
            int32_t getViewportWidth();
            //   Get height of the viewport
            int32_t getViewportHeight(); 
            //   Get datum flag of the viewport (true = viewport corner)
            bool getViewportDatum();
            //   Draw a frame inside or outside the viewport of width w
            void frameViewport(uint16_t color, int32_t w);
            //   Reset viewport to whole TFT screen, datum at 0,0
            void resetViewport();
            //   Clip address window x,y,w,h to screen and viewport
            //   Arraylong xywh : xywh(0)=x xywh(1)=y xywh(2)=w xywh(3)=h
            bool clipAddrWindow(ArrayLong* xywh);
            //   Clip window xs,ys,xe,ye to screen and viewport
            //   Arraylong xsysxeye xsysxeye(0)=xs xsysxeye(1)=ys xsysxeye(2)=xe xsysxeye(3)=ye
            bool clipWindow(ArrayLong* xsysxeye);

            //   push a single pixel           
            void pushColor1(uint16_t color, uint32_t len);            
            //    push an array of pixels, for image drawing   
            //    default : swap = true         
            void pushColors(ArrayUInt* data, bool swap);
            //   push an array of pixels for 16-bit raw image drawing
            // Assumed that setAddrWindow() has previously been called
            // len is number of bytes, not pixels              
            void pushColors1(ArrayByte* data);
            // Assumed that setAddrWindow() has previously been called
            // len is number of bytes, not pixels        
            void pushBlock(uint16_t color, uint32_t len);
            //  push an array of pixels for 16-bit raw image drawing
            void pushPixels(ArrayByte* data_in);
            // #ifdef TFT_SDA_READ
            // #if defined (TFT_eSPI_ENABLE_8_BIT_READ)
            // Read 8-bit value from TFT command register
            byte tft_Read8();
            // #ifdef TFT_SDA_READ
            // Begin a read on a half duplex (bi-directional SDA) SPI bus - sets MOSI to input
            void begin_SDA_Read();
            // #ifdef TFT_SDA_READ
            // Restore MOSI to output
            void end_SDA_Read();
            //   Clear the screen to defined colour
            void fillScreen(uint32_t color);
            //  Draw a rectangle outline
            void drawRect(int32_t x, int32_t y, int32_t w, int32_t h, uint32_t color);
            //   Draw a rounded corner rectangle outline
            void drawRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color);
            //   Draw a rounded corner filled rectangle
            void fillRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color);
            //   draw a filled rectangle with a vertical colour gradient
            void fillRectVGradient(int16_t x, int16_t y, int16_t w, int16_t h, uint32_t color1, uint32_t color2);
            //   draw a filled rectangle with a horizontal colour gradient
            void fillRectHGradient(int16_t x, int16_t y, int16_t w, int16_t h, uint32_t color1, uint32_t color2);
            //  Draw a circle outline
            void drawCircle(int32_t x, int32_t y, int32_t r, uint32_t color);
            //   Support function for drawRoundRect()
            void drawCircleHelper(int32_t x, int32_t y, int32_t r, byte cornername, uint32_t color);
            //    draw a filled circle
            void fillCircle(int32_t x, int32_t y, int32_t r, uint32_t color);
            //   Support function for fillRoundRect()
            // Support drawing roundrects, changed to horizontal lines
            void fillCircleHelper(int32_t x, int32_t y, int32_t r, byte cornername, int32_t delta, uint32_t color);
            //   Draw a ellipse outline
            void drawEllipse(int16_t x, int16_t y, int32_t rx, int32_t ry, uint16_t color);
            //    draw a filled ellipse
            void fillEllipse(int16_t x, int16_t y, int32_t rx, int32_t ry, uint16_t color);
            //   Draw a triangle outline using 3 arbitrary points
            void drawTriangle(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3, uint32_t color);
            //   Draw a filled triangle using 3 arbitrary points
            void fillTriangle(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3, uint32_t color);
            //  push a single pixel at an arbitrary position
            //   default : bg_color = 0x00FFFFFF
            uint16_t drawPixel1(int32_t x, int32_t y, uint32_t color, byte alpha, uint32_t bg_color);
            //    Draw a smooth arc clockwise from 6 o'clock
            //  Default : roundEnds = false
            void drawSmoothArc(int32_t x, int32_t y, int32_t r, int32_t ir, uint32_t startAngle, uint32_t endAngle, uint32_t fg_color, uint32_t bg_color, bool roundEnds);
            //   Draw an arc clockwise from 6 o'clock position
            // Centre at x,y
            // r = arc outer radius, ir = arc inner radius. Inclusive, so arc thickness = r-ir+1
            // Angles MUST be in range 0-360
            // Arc foreground fg_color anti-aliased with background colour along sides
            // smooth is optional, default is true, smooth=false means no antialiasing
            // Note: Arc ends are not anti-aliased (use drawSmoothArc instead for that)
            //  Default : smoothArc = true
            void drawArc(int32_t x, int32_t y, int32_t r, int32_t ir, uint32_t startAngle, uint32_t endAngle, uint32_t fg_color, uint32_t bg_color, bool smoothArc);
            //   Draw a smooth circle
            void drawSmoothCircle(int32_t x, int32_t y, int32_t r, uint32_t fg_color, uint32_t bg_color);
            //   Draw a filled anti-aliased circle
            //  Default : bg_color = 0x00FFFFFF
            void fillSmoothCircle(int32_t x, int32_t y, int32_t r, uint32_t color, uint32_t bg_color);
            //   Draw a rounded rectangle
            // x,y is top left corner of bounding box for a complete rounded rectangle
            // r = arc outer corner radius, ir = arc inner radius. Arc thickness = r-ir+1
            // w and h are width and height of the bounding rectangle
            // If w and h are < radius (e.g. 0,0) a circle will be drawn with centre at x+r,y+r
            // Arc foreground fg_color anti-aliased with background colour at edges
            // A subset of corners can be drawn by specifying a quadrants mask. A bit set in the
            // mask means draw that quadrant (all are drawn if parameter missing):   0x1 | 0x2
            //    ---|---    Arc quadrant mask select bits (as in drawCircleHelper fn) 0x8 | 0x4
            //  Default : bg_color = 0x00FFFFFF, quadrants = 0xF
            void drawSmoothRoundRect(int32_t x, int32_t y, int32_t r, int32_t ir, int32_t w, int32_t h, uint32_t fg_color, uint32_t bg_color, byte quadrants);
            //   Draw a filled anti-aliased rounded corner rectangle
            //  Default : bg_color = 0x00FFFFFF
            void fillSmoothRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color, uint32_t bg_color);
            //   Draw an anti-aliased filled circle at ax,ay with radius r
            // Coordinates are floating point to achieve sub-pixel positioning
            //  Default : bg_color = 0x00FFFFFF            
            void drawSpot(double ax, double ay, double r, uint32_t fg_color, uint32_t bg_color);
            //    draw an anti-aliased line with rounded ends, width wd
            //  Default : bg_color = 0x00FFFFFF
            void drawWideLine(double ax, double ay, double bx, double by, double wd, uint32_t fg_color, uint32_t bg_color);
            //   draw an anti-aliased line with different width radiused ends
            void drawWedgeLine(double ax, double ay, double bx, double by, double aw, double bw, uint32_t fg_color, uint32_t bg_color);
            //   Used by 16-bit pushImage() to swap byte order in colours
            void setSwapBytes(bool swap);
            //   Return the swap byte order for colours
            bool getSwapBytes();
            //   Draw an image stored in an array on the TFT
            void drawBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor);
            //   Draw an image stored in an array on the TFT
            void drawBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor, uint16_t bgcolor);
            //   Draw an image stored in an XBM array onto the TFT
            void drawXBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor);
            //   Draw an XBM image with foreground and background colors
            void drawXBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor, uint16_t bgcolor);
            //   Set the foreground foreground and background colour
            void setBitmapColor(uint16_t fgcolor, uint16_t bgcolor);
            //   Set the pivot point on the TFT
            void setPivot(int16_t x, int16_t y);
            //   Get the x pivot position
            int16_t getPivotX();
            //   Get the y pivot position
            int16_t getPivotY();
            //    Read 565 pixel colours from a defined area
            void readRect(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data);
            //    push 565 pixel colours into a defined area
            void pushRect(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data);
            //    plot 16-bit colour sprite or image onto TFT
            void pushImage(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data);
            //    plot 16-bit sprite or image with 1 colour being transparent 
            void pushImage1(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, uint16_t transparent);
            //    plot 16-bit sprite or image with 1 colour being transparent            
//            void pushImage2(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, uint16_t transparent);
            //    plot 16-bit colour sprite or image onto TFT
            //    for FLASH (PROGMEM) stored images            
//            void pushImage3(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data);
            //   plot 8-bit or 4-bit or 1 bit image or sprite using a line buffer
            //    from FLASH (PROGMEM) stored images  
            //  Default : bpp8 = true, cmap = nullptr             
            void pushImage4(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, bool bpp8, ArrayUInt* cmap);
            //    plot 8 or 4 or 1 bit image or sprite with a transparent colour  
            //  Default : bpp8 = true, cmap = nullptr          
            void pushImage5(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, byte  transparent, bool bpp8, ArrayUInt* cmap);
            //    plot 8-bit or 4-bit or 1 bit image or sprite using a line buffer 
            //  Default : bpp8 = true, cmap = nullptr                
            void pushImage6(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, bool bpp8, ArrayUInt* cmap);
            //    Render a 16-bit colour image to TFT with a 1bpp mask
            //    from FLASH (PROGMEM) stored images   
            // Note: pushMaskedImage is for pushing to the TFT and will not work pushing into a sprite         
            void pushMaskedImage(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* img, ArrayByte* mask);
            //    read rectangle (for SPI Interface II i.e. IM [3:0] = "1101")
            //    Read RGB pixel colours from a defined area
            // If w and h are 1, then 1 pixel is read, *data array size must be 3 bytes per pixel            
            void readRectRGB(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data);
            //    draw a long integer with font number
            int16_t drawNumber(int32_t intNumber, int32_t x, int32_t y, byte font);
            //    draw a long integer
            int16_t drawNumber1(int32_t intNumber, int32_t x, int32_t y);
            //    drawFloat, prints 7 non zero digits maximum with font number
            int16_t drawFloat(double doubleNumber, byte decimal, int32_t x, int32_t y, byte font);
            //    drawFloat, prints 7 non zero digits maximum          
            int16_t drawFloat1(double doubleNumber, byte decimal, int32_t x, int32_t y);
            //    draw string with padding if it is defined and with font number
            int16_t drawString(B4RString* string, int32_t x, int32_t y, byte font);
            //    draw string with padding if it is defined 
            //    Without font number, uses font set by setTextFont()                         
            int16_t drawString1(B4RString* string, int32_t x, int32_t y);
            //    draw string centred on dX  (deprecated, use setTextDatum())
            int16_t drawCentreString(B4RString* string, int32_t x, int32_t y, byte font);
            //    draw string right justified to dX  (deprecated, use setTextDatum())             
            int16_t drawRightString(B4RString* string, int32_t x, int32_t y, byte font);
            //    Set the text cursor x,y position
            void setCursor(int16_t x, int16_t y);
            //    Set the text cursor x,y position and font
            void setCursor1(int16_t x, int16_t y, byte font);
            //    Get the text cursor x position
            int16_t getCursorX();
            //    Get the text cursor y position
            int16_t getCursorY();
            //    Set the font foreground colour (background is transparent)
            void setTextColor(uint16_t color);
            //    Set the font foreground and background colour
            // Smooth fonts use the background colour for anti-aliasing and by default the
            // background is not filled. If bgfill = true, then a smooth font background fill will
            // be used.
            //  Default : bgfill = false
            void setTextColor1(uint16_t fgcolor, uint16_t bgcolor, bool bgfill);
            //    Set the text size multiplier
            void setTextSize(byte size);
            //    Define if text should wrap at end of line
            //  Default : wrapY = false
            void setTextWrap(bool wrapX, bool wrapY);
            //   Set the text position reference datum
            void setTextDatum(byte datum);
            //   Return the text datum value (as used by setTextDatum())
            byte getTextDatum();
            //    Define padding width (aids erasing old text and numbers)
            void setTextPadding(uint16_t x_width);
            //    Define padding width (aids erasing old text and numbers)
            uint16_t getTextPadding();
          #ifdef LOAD_GFXFF       
            //    Sets the GFX free font to use (from fonts number define in inline C )
            //   FreeFonts 0 < x  after declaration in inline C
            void setFreeFont(byte GFXid); 
            //    Set the font by default (1<8) for the print stream
            //  Fonts by default 1<8
            void setTextFont(byte font);
          #else  
            //   No GFX free font define: no used
            //  Fonts by default 1<8
            void setFreeFont1(byte font);
            //   Set the font by default (1<8) for the print stream
            //  Fonts by default 1<8            
            void setTextFont1(byte font);
          #endif  
            //   Return the width in pixels of a string in a given font            
            int16_t textWidth(B4RString* string, byte font);
            //   Return the width in pixels of a string in a given font             
            int16_t textWidth1(B4RString* string);
            //   Return the width in pixels of a string in a given font  
            //    from String sent by reference          
            int16_t textWidth2(B4RString* string, byte font);
            //   Return the width in pixels of a string in a given font  
            //    from String sent bynreference            
            int16_t textWidth3(B4RString* string);
            //    return the height of a font (yAdvance for free fonts)
            int16_t fontHeight(int16_t font);
            //    return the height of a font (yAdvance for free fonts)
            int16_t fontHeight1();
            //    Serial UTF-8 decoder with fall-back to extended ASCII
            uint16_t decodeUTF8(ArrayByte* buf, ArrayUInt* index, uint16_t remaining);
            //    Line buffer UTF-8 decoder with fall-back to extended ASCII
            uint16_t decodeUTF81(byte c);
            //    draw characters piped through serial stream
            uint16_t write(uint8_t utf8);

            void setCallback(Subuint_uintuint OnTFTColorCallbackSub);
            //~hide
            static uint16_t TFTColorCallback(uint16_t x, uint16_t y);
            //   return an encoded 16-bit value showing the fonts loaded
            //  Each bit in returned value represents a font type that is loaded - used for debug/error handling only
            uint16_t fontsLoaded();
            //    Write 8 bits to SPI port (legacy support only)
            void spiwrite(uint8_t c);
            //    #ifndef RM68120_DRIVER
            // Send a 16-bit command, function resets DC/RS high ready for data
            void writecommand(uint16_t c);
            //    #ifndef RM68120_DRIVER 
            // Write 8-bit data data to 16-bit command register           
            void writeRegister8(uint16_t c, byte d);
            //    #ifndef RM68120_DRIVER  
            // Write 16-bit data data to 16-bit command register          
            void writeRegister16(uint16_t c, uint16_t d);
           // Send an 8-bit command, function resets DC/RS high ready for data
            void writecommand1(byte c);
            //    #ifdef RM68120_DRIVER            
             // Send data with DC/RS set high
            void writedata(byte d);
            // Send a initialisation sequence to TFT stored in FLASH
            void commandList(ArrayByte* addr);
            // read 8 bits from TFT
            byte readcommand8(byte cmd_function, byte index);
            // read 16 bits from TFT
            uint16_t readcommand16(byte cmd_function, byte index);
            // read 32 bits from TFT
            uint32_t readcommand32(byte cmd_function, byte index);
            // Convert 8-bit red, green and blue to 16 bits
            uint16_t color565(byte red, byte green, byte blue);
            // Convert 8-bit colour to 16 bits
            uint16_t color8to16(byte color332);
            // Convert 16-bit colour to 8 bits
            byte color16to8(uint16_t color565);
            // Convert 16-bit colour to 24-bit, R+G+B concatenated into LS 24 bits
            uint32_t color16to24(uint16_t color565);
            // Convert 16-bit colour from 24-bit, R+G+B concatenated into LS 24 bits
            uint32_t color24to16(uint32_t color888);
            // Alpha blend 2 colours, see generic "alphaBlend_Test" example
            // alpha =   0 = 100% background colour
            // alpha = 255 = 100% foreground colour            
            uint16_t alphaBlend(byte alpha, uint16_t fgc, uint16_t bgc);
            // 16-bit colour alphaBlend with alpha dither (dither reduces colour banding)
            uint16_t alphaBlend1(byte alpha, uint16_t fgc, uint16_t bgc, byte dither);
            // 24-bit colour alphaBlend with optional alpha dither
            //  Default : dither = 0
            uint32_t alphaBlend24(byte alpha, uint32_t fgc, uint32_t bgc, byte dither);
            // Initialise the DMA engine and attach to SPI bus - typically used in setup()
            // Parameter "true" enables DMA engine control of TFT chip select (ESP32 only)
            // For ESP32 only, TFT reads will not work if parameter is true
            //  Default : ctrl_cs = false
            bool initDMA(bool ctrl_cs);
            // De-initialise the DMA engine and detach from SPI bus - typically not used
            void deInitDMA();
            // Push an image to the TFT using DMA, buffer is optional and grabs (double buffers) a copy of the image
            // Use the buffer if the image data will get over-written or destroyed while DMA is in progress
            //
            // Note 1: If swapping colour bytes is defined, and the double buffer option is NOT used, then the bytes
            // in the original image buffer content will be byte swapped by the function before DMA is initiated.
            //
            // Note 2: If part of the image will be off screen or outside of a set viewport, then the the original
            // image buffer content will be altered to a correctly clipped image before DMA is initiated.
            //
            // The function will wait for the last DMA to complete if it is called while a previous DMA is still
            // in progress, this simplifies the sketch and helps avoid "gotchas".  
            //  Default : buffer = nullptr          
            void pushImageDMA(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, ArrayUInt* buffer);
            // ESP32 only at the moment
            // For case where pointer is a const and the image data must not be modified (clipped or byte swapped)
            void pushImageDMA1(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data);
            // Push a block of pixels into a window set up using setAddrWindow()
            void pushPixelsDMA(ArrayUInt* image);
            // Check if the DMA is complete - use while(tft.dmaBusy); for a blocking wait
            // returns true if DMA is still in progress            
            bool dmaBusy();
            // wait until DMA is complete
            void dmaWait();
            // Flag for DMA enabled state
            bool DMA_Enabled();
            // Number of ESP32 transfer buffers to check
            uint8_t spiBusyCheck();
            // Begin SPI transaction
            void startWrite();
            // Deprecated, use pushBlock()
            void writeColor(uint16_t color, uint32_t len);
            // End SPI transaction
            void endWrite();
            // Set attribute value
            //  Default : id=0, a=0
            void setAttribute(byte id, byte a);
            // Get attribute value
            //  Default : id=0
            byte getAttribute(byte id);
            // Text foreground colours
            uint32_t textcolor();
            // Text background colours
            uint32_t textbgcolor();
            // Bitmap foreground (bit=1) colours
            uint32_t bitmap_fg();
            // Bitmap  background (bit=0) colours
            uint32_t bitmap_bg();
            // Get Current selected font number
            byte textfont();
            // Get Current font size multiplier
            byte textsize();
            // Get Text reference datum
            byte textdatum();
            // Display rotation (0-3)
            byte rotation();
            // UTF8 decoder state        - not for user access
            uint16_t decoderState();
            // Unicode code-point buffer - not for user access
            uint16_t decoderBuffer();
            
            // Print a string
            uint16_t print(B4RString* string);
            // Println a string
            uint16_t println(B4RString* string);
            
            // text plotting alignment (reference datum point)
    // Top left (default)    
    #define /*byte TL_DATUM;*/ B4R_TL_DATUM 0 
    // text plotting alignment (reference datum point)
    // Top centre
    #define /*byte TC_DATUM;*/ B4R_TC_DATUM 1 
    // text plotting alignment (reference datum point)
    // Top right
    #define /*byte TR_DATUM;*/ B4R_TR_DATUM 2 
    // text plotting alignment (reference datum point)
    // Middle left
    #define /*byte ML_DATUM;*/ B4R_ML_DATUM 3 
    // text plotting alignment (reference datum point)
    // Centre left, same as above
    #define /*byte CL_DATUM;*/ B4R_CL_DATUM 3 
    // text plotting alignment (reference datum point)
    // Middle centre
    #define /*byte MC_DATUM;*/ B4R_MC_DATUM 4 
    // text plotting alignment (reference datum point)
    // Centre centre, same as above
    #define /*byte CC_DATUM;*/ B4R_CC_DATUM 4 
    // text plotting alignment (reference datum point)
    // Middle right
    #define /*byte MR_DATUM;*/ B4R_MR_DATUM 5 
    // text plotting alignment (reference datum point)
    // Centre right, same as above
    #define /*byte CR_DATUM;*/ B4R_CR_DATUM 5 
    // text plotting alignment (reference datum point)
    // Bottom left
    #define /*byte BL_DATUM;*/ B4R_BL_DATUM 6 
    // text plotting alignment (reference datum point)
    // Bottom centre
    #define /*byte BC_DATUM;*/ B4R_BC_DATUM 7 
    // text plotting alignment (reference datum point)
    // Bottom right
    #define /*byte BR_DATUM;*/ B4R_BR_DATUM 8 
    // text plotting alignment (reference datum point)
    // Left character baseline (Line the 'A' character would sit on)
    #define /*byte L_BASELINE;*/ B4R_L_BASELINE 9 
    // text plotting alignment (reference datum point)
    // Centre character baseline
    #define /*byte C_BASELINE;*/ B4R_C_BASELINE 10 
    // text plotting alignment (reference datum point)
    // Right character baseline
    #define /*byte R_BASELINE;*/ B4R_R_BASELINE 11 

    // Default color definitions
    //   0,   0,   0
    #define /*UInt TFT_BLACK;*/ B4R_TFT_BLACK      0x0000      
    // Default color definitions
    //   0,   0, 128
    #define /*UInt TFT_NAVY;*/ B4R_TFT_NAVY       0x000F      
    // Default color definitions
    //   0, 128,   0
    #define /*UInt TFT_DARKGREEN;*/ B4R_TFT_DARKGREEN  0x03E0      
    // Default color definitions
    //   0, 128, 128
    #define /*UInt TFT_DARKCYAN;*/ B4R_TFT_DARKCYAN   0x03EF      
    // Default color definitions
    // 128,   0,   0
    #define /*UInt TFT_MAROON;*/ B4R_TFT_MAROON     0x7800      
    // Default color definitions
    // 128,   0, 128
    #define /*UInt TFT_PURPLE;*/ B4R_TFT_PURPLE     0x780F      
    // Default color definitions
    // 128, 128,   0
    #define /*UInt TFT_OLIVE;*/ B4R_TFT_OLIVE      0x7BE0      
    // Default color definitions
    // 211, 211, 211
    #define /*UInt TFT_LIGHTGREY;*/ B4R_TFT_LIGHTGREY  0xD69A      
    // Default color definitions
    // 128, 128, 128
    #define /*UInt TFT_DARKGREY;*/ B4R_TFT_DARKGREY   0x7BEF      
    // Default color definitions
    //   0,   0, 255
    #define /*UInt TFT_BLUE;*/ B4R_TFT_BLUE      0x001F      
    // Default color definitions
    //   0, 255,   0
    #define /*UInt TFT_GREEN;*/ B4R_TFT_GREEN      0x07E0      
    // Default color definitions
    //   0, 255, 255
    #define /*UInt TFT_CYAN;*/ B4R_TFT_CYAN       0x07FF      
    // Default color definitions
    // 255,   0,   0
    #define /*UInt TFT_RED;*/ B4R_TFT_RED        0xF800      
    // Default color definitions
    // 255,   0, 255
    #define /*UInt TFT_MAGENTA;*/ B4R_TFT_MAGENTA    0xF81F      
    // Default color definitions
    // 255, 255,   0
    #define /*UInt TFT_YELLOW;*/ B4R_TFT_YELLOW    0xFFE0      
    // Default color definitions
    // 255, 255, 255
    #define /*UInt TFT_WHITE;*/ B4R_TFT_WHITE      0xFFFF      
    // Default color definitions
    // 255, 180,   0
    #define /*UInt TFT_ORANGE;*/ B4R_TFT_ORANGE     0xFDA0     
    // Default color definitions
    // 180, 255,   0
    #define /*UInt TFT_GREENYELLOW;*/ B4R_TFT_GREENYELLOW 0xB7E0      
    // Default color definitions
    // 255, 192, 203 //Lighter pink, was 0xFC9F
    #define /*UInt TFT_PINK;*/ B4R_TFT_PINK      0xFE19      
    // Default color definitions
    // 150,  75,   0
    #define /*UInt TFT_BROWN;*/ B4R_TFT_BROWN      0x9A60      
    // Default color definitions
    // 255, 215,   0
    #define /*UInt TFT_GOLD;*/ B4R_TFT_GOLD       0xFEA0      
    // Default color definitions
    // 192, 192, 192
    #define /*UInt TFT_SILVER;*/ B4R_TFT_SILVER     0xC618      
    // Default color definitions
    // 135, 206, 235
    #define /*UInt TFT_SKYBLUE;*/ B4R_TFT_SKYBLUE    0x867D      
    // Default color definitions
    // 180,  46, 226
    #define /*UInt TFT_VIOLET;*/ B4R_TFT_VIOLET     0x915C 
    // Default color definitions
    #define /*UInt TFT_GREY;*/ B4R_TFT_GREY   0x5AEB
    // Default color definitions
    #define /*UInt TFT_LIGHTGREY2;*/ B4R_TFT_LIGHTGREY2  0xBDF7
    // Default color definitions	
    #define /*UInt TFT_ORANGE2;*/ B4R_TFT_ORANGE2 0xFD20
    // Default color definitions
    #define /*UInt TFT_ORANGE3;*/ B4R_TFT_ORANGE3 0xFBE0
    // Default color definitions
    #define /*UInt TFT_BROWN2;*/ B4R_TFT_BROWN2 0x79E0
    // Default color definitions
    #define /*UInt TFT_BROWN3;*/ B4R_TFT_BROWN3 0x38E0
    // Default color definitions
    #define /*UInt TFT_GREY2;*/ B4R_TFT_GREY2 0x2104
 


    // Convenient for 8-bit and 16-bit transparent sprites.
    // This is actually a dark green
    #define /*UInt TFT_TRANSPARENT;*/ B4R_TFT_TRANSPARENT 0x0120

    // Default palette for 4-bit colour sprites
    //  0  ^
    #define /*byte TFT_BLACK_4b;*/ B4R_TFT_BLACK_4b TFT_BLACK  
    // Default palette for 4-bit colour sprites
    //  1  |  
    #define /*byte TFT_BROWN_4b;*/ B4R_TFT_BROWN_4b TFT_BROWN    
    // Default palette for 4-bit colour sprites
    //  2  |  
    #define /*byte TFT_RED_4b;*/ B4R_TFT_RED_4b TFT_RED      
    // Default palette for 4-bit colour sprites
    //  3  |  
    #define /*byte TFT_ORANGE_4b;*/ B4R_TFT_ORANGE_4b TFT_ORANGE   
    // Default palette for 4-bit colour sprites
    //  4  Colours 0-9 follow the resistor colour code!  
    #define /*byte TFT_YELLOW_4b;*/ B4R_TFT_YELLOW_4b TFT_YELLOW   
    // Default palette for 4-bit colour sprites
    //  5  |  
    #define /*byte TFT_GREEN_4b;*/ B4R_TFT_GREEN_4b TFT_GREEN    
    // Default palette for 4-bit colour sprites
    //  6  |  
    #define /*byte TFT_BLUE_4b;*/ B4R_TFT_BLUE_4b TFT_BLUE     
    // Default palette for 4-bit colour sprites
    //  7  |  
    #define /*byte TFT_PURPLE_4b;*/ B4R_TFT_PURPLE_4b TFT_PURPLE  
    // Default palette for 4-bit colour sprites
    //  8  |  
    #define /*byte TFT_DARKGREY_4b;*/ B4R_TFT_DARKGREY_4b TFT_DARKGREY 
    // Default palette for 4-bit colour sprites
    //  9  v  
    #define /*byte TFT_WHITE_4b;*/ B4R_TFT_WHITE_4b TFT_WHITE    
    // Default palette for 4-bit colour sprites
    // 10  Blue+green mix  
    #define /*byte TFT_CYAN_4b;*/ B4R_TFT_CYAN_4b TFT_CYAN     
    // Default palette for 4-bit colour sprites
    // 11  Blue+red mix  
    #define /*byte TFT_MAGENTA_4b;*/ B4R_TFT_MAGENTA_4b TFT_MAGENTA  
    // Default palette for 4-bit colour sprites
    // 12  Darker red colour  
    #define /*byte TFT_MAROON_4b;*/ B4R_TFT_MAROON_4b TFT_MAROON   
    // Default palette for 4-bit colour sprites
    // 13  Darker green colour  
    #define /*byte TFT_DARKGREEN_4b;*/ B4R_TFT_DARKGREEN_4b TFT_DARKGREEN
    // Default palette for 4-bit colour sprites
    // 14  Darker blue colour  
    #define /*byte TFT_NAVY_4b;*/ B4R_TFT_NAVY_4b  TFT_NAVY     
    // Default palette for 4-bit colour sprites
    // 15  
    #define /*byte TFT_PINK_4b;*/ B4R_TFT_PINK_4b TFT_PINK   

    //"true" for horizontal
    #define /*bool H_SLIDER;*/    B4RH_SLIDER      true
    // "false" for vertical
    #define /*bool V_SLIDER;*/    B4RV_SLIDER      false


//****************     
//TFT_eSPI Touch  
//****************
   #ifdef TOUCH_CS   
    //  #ifdef TOUCH_CS    
    // Get raw x,y ADC values from touch controller
    byte getTouchRaw(ArrayUInt* xy);
    //  #ifdef TOUCH_CS 
    // Get raw z (i.e. pressure) ADC value from touch controller
    uint16_t getTouchRawZ();
    //   #ifdef TOUCH_CS 
    // Convert raw x,y values to calibrated and correctly rotated screen coordinates
    void convertRawXY(ArrayUInt* xy);
    //   #ifdef TOUCH_CS 
    // Get the screen touch coordinates, returns true if screen has been touched
    // if the touch coordinates are off screen then x and y are not updated
    // The returned value can be treated as a bool type, false or 0 means touch not detected
    // In future the function may return an 8-bit "quality" (jitter) value.
    // The threshold value is optional, this must be higher than the bias level for z (pressure)
    // reported by Test_Touch_Controller when the screen is NOT touched. When touched the z value
    // must be higher than the threshold for a touch to be detected.
    // ArrayUInt* xy : xy(0) = x   xy(1) = y
    // Default : threshold = 600)
    byte getTouch(ArrayUInt* xy, uint16_t threshold);
    //   #ifdef TOUCH_CS 
    // Run screen calibration and test, report calibration values to the serial port
    void calibrateTouch(ArrayUInt* data, uint32_t color_fg, uint32_t color_bg, byte size);
    //   #ifdef TOUCH_CS 
    // Set the screen calibration values
    void setTouch(ArrayUInt* data);
  #endif
//**********************  
// TFT_eSPI smooth Font
//**********************
  #ifdef SMOOTH_FONT
  #ifdef LOAD_GFXFF 
    // #ifdef LOAD_GFXFF
    // loads parameters from a font vlw array from h file     
    void loadFontH(byte VLWid);
  #ifdef FONT_FS_AVAILABLE 
    #if defined(ESP32)
    // #ifdef LOAD_GFXFF  
    // #ifdef FONT_FS_AVAILABLE 
    // only for ESP32
    // loads parameters from a font vlw file from SD 
    // return 0=OK / 1=error init / 2=error card        
    uint8_t loadFontSD(B4RString* fontName);
    #endif
    // #ifdef LOAD_GFXFF  
    // #ifdef FONT_FS_AVAILABLE 
    // loads parameters from a font vlw file  from LittleFS  
    // return 0=OK / 1=error init           
    uint8_t loadFontLittleFS(B4RString* fontName);
  #endif
    // #ifdef LOAD_GFXFF  
    // loads parameters from a font vlw file from SPIFFS
    void loadFontFS(B4RString* fontName);
    // #ifdef LOAD_GFXFF    
    // Delete the old glyph metrics and free up the memory
    void unloadFont();
    // #ifdef LOAD_GFXFF
    // Get the font file index of a Unicode character
    bool getUnicodeIndex(uint16_t unicode, ArrayUInt* index);
    // #ifdef LOAD_GFXFF
    // Write a character to the TFT cursor position
    void drawGlyph(uint16_t code);
    // #ifdef LOAD_GFXFF
    // Page through all characters in font, td ms between screens
    void showFont(uint32_t td);
  #endif
  #endif
    };

//**********************
// TFT_eSPI_Sprite
//**********************   
    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino  https://github.com/Bodmer/TFT_eSPI
    //~shortname:TFT_eSprite
    class B4RTFT_eSprite
    {
        private:
            uint8_t backend[sizeof(TFT_eSprite)];
            TFT_eSprite* rct;
        public: 
            uint32_t Initialize(uint32_t TFTid);
           // Create a sprite of width x height pixels, return a pointer to the RAM area
           // Sketch can cast returned value to (uint16_t*) for 16-bit depth if needed
           // RAM required is:
           //  - 1 bit per pixel for 1 bit colour depth
           //  - 1 nibble per pixel for 4-bit colour (with palette table)
           //  - 1 byte per pixel for 8-bit colour (332 RGB format)
           //  - 2 bytes per pixel for 16-bit color depth (565 RGB format)
           //  Default : frames = 1
            uint32_t createSprite(int16_t width, int16_t height, byte frames);
           // Returns a pointer to the sprite or nullptr if not created, user must cast to pointer type
            uint32_t getPointer();
           // Returns true if sprite has been created
            bool created();
           // Delete the sprite to free up the RAM
            void deleteSprite();
           // Select the frame buffer for graphics write (for 2 colour ePaper and DMA toggle buffer)
           // Returns a pointer to the Sprite frame buffer
            uint32_t frameBuffer(byte f);
           // Set the colour depth to 1, 4, 8 or 16 bits. Can be used to change depth an existing
           // sprite, but clears it to black, returns a new pointer if sprite is re-created.
            uint32_t setColorDepth(byte b);
           // Get the colour depth (1, 4, 8 or 16 bits). 
            byte getColorDepth();
           // Set the palette for a 4-bit depth sprite.  Only the first 16 colours in the map are used.
           // Palette in RAM  
           // Default :  palette = nullptr, colors = 16
            void createPalette(ArrayUInt* palette, byte colors);
           // Set the palette for a 4-bit depth sprite.  Only the first 16 colours in the map are used.
           // Palette in FLASH
           // Default : palette = nullptr, colors = 16
            void createPalette1(ArrayUInt* palette, byte colors);
           // Set a single palette index to the given color
            void setPaletteColor(byte index, uint16_t color);
           // Get the color at the given palette index
            uint16_t getPaletteColor(byte index);
           // Set foreground and background colours for 1 bit per pixel Sprite
            void setBitmapColor(uint16_t fg, uint16_t bg);
           // Draw a single pixel at x,y
            void drawPixel(int32_t x, int32_t y, uint32_t color);
           // Draw a single character in the GLCD or GFXFF font
            void drawChar(int32_t x, int32_t y, uint16_t c, uint32_t color, uint32_t bg, byte size);
           // Fill Sprite with a colour
            void fillSprite(uint32_t color);
           // Define a window to push 16-bit colour pixels into in a raster order
           // Colours are converted to the set Sprite colour bit depth
            void setWindow(int32_t x0, int32_t y0, int32_t x1, int32_t y1);
           // Push a color (aka singe pixel) to the sprite's set window area
            void pushColor(uint16_t color);
           // Push len colors (pixels) to the sprite's set window area
            void pushColor1(uint16_t color, uint32_t len);
           // Push a pixel pre-formatted as a 1, 4, 8 or 16-bit colour (avoids conversion overhead)
            void writeColor(uint16_t color);
           // Set the scroll zone, top left corner at x,y with defined width and height
           // The colour (optional, black is default) is used to fill the gap after the scroll
           //  Default :  color = TFT_BLACK
            void setScrollRect(int32_t x, int32_t y, int32_t w, int32_t h, uint16_t color);
           // Scroll the defined zone dx,dy pixels. Negative values left,up, positive right,down
           // dy is optional (default is 0, so no up/down scroll).
           // The sprite coordinate frame does not move because pixels are moved
           //  Default : dy = 0
            void scroll(int16_t dx, int16_t dy);
           // Draw lines
            void drawLine(int32_t x0, int32_t y0, int32_t x1, int32_t y1, uint32_t color);
           // Draw lines
            void drawFastVLine(int32_t x, int32_t y, int32_t h, uint32_t color);
           // Draw lines
            void drawFastHLine(int32_t x, int32_t y, int32_t w, uint32_t color);
           // Fill a rectangular area with a color (aka draw a filled rectangle)
            void fillRect(int32_t x, int32_t y, int32_t w, int32_t h, uint32_t color);
           // Set the coordinate rotation of the Sprite (for 1bpp Sprites only)
           // Note: this uses coordinate rotation and is primarily for ePaper which does not support
           // CGRAM rotation (like TFT drivers do) within the displays internal hardware
            void setRotation(byte rotation);
            // Get the coordinate rotation of the Sprite
            byte getRotation();
           // Push a rotated copy of Sprite to TFT with optional transparent colour
           // Default : transp = 0x00FFFFFF
            bool pushRotated(int16_t angle, uint32_t transp);
           // Push a rotated copy of Sprite to another different Sprite with optional transparent colour
           // Default : transp = 0x00FFFFFF           
            bool pushRotated1(uint32_t sprID, int16_t angle, uint32_t transp);
           // Get the TFT bounding box for a rotated copy of this Sprite
            bool getRotatedBounds(int16_t angle, ArrayInt* min_x, ArrayInt* min_y, ArrayInt* max_x, ArrayInt* max_y);
           // Get the destination Sprite bounding box for a rotated copy of this Sprite
            bool getRotatedBounds1(uint32_t sprID, int16_t angle, ArrayInt* min_x, ArrayInt* min_y, ArrayInt* max_x, ArrayInt* max_y);
           // Bounding box support function
            void getRotatedBounds2(int16_t angle, int16_t w, int16_t h, int16_t xp, int16_t yp, ArrayInt* min_x, ArrayInt* min_y, ArrayInt* max_x, ArrayInt* max_y);
           // Read the colour of a pixel at x,y and return value in 565 format 
            uint16_t readPixel(int32_t x0, int32_t y0);
           // return the numerical value of the pixel at x,y (used when scrolling)
           // 16bpp = colour, 8bpp = byte, 4bpp = colour index, 1bpp = 1 or 0
            uint16_t readPixelValue(int32_t x, int32_t y);
           // Write an image (colour bitmap) to the sprite.
            void pushImage(int32_t x0, int32_t y0, int32_t w, int32_t h, ArrayUInt* data, byte sbpp);
           // Write an image (colour bitmap) to the sprite.
            void pushImage1(int32_t x0, int32_t y0, int32_t w, int32_t h, ArrayUInt* data);
                        
            
           // Push the sprite to the TFT screen, this fn calls pushImage() in the TFT class.
            void pushSprite(int32_t x, int32_t y);
           // Push the sprite to the TFT screen, this fn calls pushImage() in the TFT class.
           // Optionally a "transparent" colour can be defined, pixels of that colour will not be rendered
            void pushSprite1(int32_t x, int32_t y, uint16_t transparent);
           // Push a windowed area of the sprite to the TFT at tx, ty
            bool pushSprite2(int32_t tx, int32_t ty, int32_t sx, int32_t sy, int32_t sw, int32_t sh);
           // Push the sprite to another sprite at x,y. This fn calls pushImage() in the destination sprite (dspr) class.
            bool pushToSprite(uint32_t dsprID, int32_t x, int32_t y);
           // Push the sprite to another sprite at x,y. This fn calls pushImage() in the destination sprite (dspr) class.
            bool pushToSprite1(uint32_t dsprID, int32_t x, int32_t y, uint16_t transparent);
           // Draw a single character in the selected font
            int16_t drawChar1(uint16_t uniCode, int32_t x, int32_t y, byte font);
           // Draw a single character
            int16_t drawChar2(uint16_t uniCode, int32_t x, int32_t y);
           // Return the width of the sprite
            int16_t width();
           // Return the height of the sprite
            int16_t height();
           // Functions associated with anti-aliased fonts
           // Draw a single Unicode character using the loaded font
 //           void drawGlyph(uint16_t code);
           // Print string to sprite using loaded font at cursor position
            void printToSprite(B4RString* string);
           // Print char array to sprite using loaded font at cursor position
            void printToSprite1(ArrayByte* cbuffer);
           // Print indexed glyph to sprite using loaded font at x,y
            int16_t printToSprite2(int16_t x, int16_t y, uint16_t index);
 //****************
 //from TFT_eSPI 
 //****************      
             //   push a single pixel at an arbitrary position
//            void drawPixel(int32_t x, int32_t y, uint32_t color);
            //   draw a single character in the GLCD or GFXFF font
//            void drawChar(int32_t x, int32_t y, uint16_t c, uint32_t color, uint32_t bg, byte size);
            //   draw a line between 2 arbitrary points
//            void drawLine(int32_t xs, int32_t ys, int32_t xe, int32_t ye, uint32_t color);
            //   draw a vertical line
//            void drawFastVLine(int32_t x, int32_t y, int32_t h, uint32_t color);
            //  draw a horizontal line
//            void drawFastHLine(int32_t x, int32_t y, int32_t w, uint32_t color);
            //   draw a filled rectangle
//            void fillRect(int32_t x, int32_t y, int32_t w, int32_t h, uint32_t color);
            //   draw a Unicode glyph onto the screen
            //   Any UTF-8 decoding must be done before calling drawChar()
//            int16_t drawChar1(uint16_t uniCode, int32_t x, int32_t y, byte font);
            //   draw a Unicode glyph onto the screen
            //   Any UTF-8 decoding must be done before calling drawChar()
//            int16_t drawChar2(uint16_t uniCode, int32_t x, int32_t y);
            
//            int16_t height();
//            int16_t width();
            //   Read the colour of a pixel at x,y and return value in 565 format
//            uint16_t readPixel(int32_t x, int32_t y);
            //   define an area to receive a stream of pixels
//            void setWindow(int32_t xs, int32_t ys, int32_t xe, int32_t ye);
            //   Push (aka write pixel) colours to the set window
//            void pushColor(uint16_t color);
            //   These are non-inlined to enable override
//            void begin_nin_write();
            //   Non-inlined version to permit override
//            void end_nin_write();
            //   Set the display image orientation to 0, 1, 2 or 3
//            void setRotation(byte r);
            //   Read the current rotation
//            byte getRotation();
            //   Change the origin position from the default top left
            //   Note: setRotation, setViewport and resetViewport will revert origin to top left corner of screen/sprite            
            void setOrigin(int32_t x, int32_t y);
            //   Get graphics origin to position X
            int32_t getOriginX();
            //   Get graphics origin to position Y            
            int32_t getOriginY();
            //   Tell TFT to invert all displayed colours
            void invertDisplay(bool i);
            //   The TFT_eSprite class inherits the following functions (not all are useful to Sprite class            
            void setAddrWindow(int32_t xs, int32_t ys, int32_t w, int32_t h);
            //   Viewport commands, see "Viewport_Demo" sketch        
            void setViewport(int32_t x, int32_t y, int32_t w, int32_t h, bool vpDatum);
            //   Check if any part of specified area is visible in viewport
            //   Note: Setting w and h to 1 will check if coordinate x,y is in area
            bool checkViewport(int32_t x, int32_t y, int32_t w, int32_t h);
            //   Get x position of the viewport datum
            int32_t getViewportX();
            //   Get Y position of the viewport datum            
            int32_t getViewportY();
            //   Get width of the viewport
            int32_t getViewportWidth();
            //   Get height of the viewport
            int32_t getViewportHeight(); 
            //   Get datum flag of the viewport (true = viewport corner)
            bool getViewportDatum();
            //   Draw a frame inside or outside the viewport of width w
            void frameViewport(uint16_t color, int32_t w);
            //   Reset viewport to whole TFT screen, datum at 0,0
            void resetViewport();
            //   Clip address window x,y,w,h to screen and viewport
            //   Arraylong xywh : xywh(0)=x xywh(1)=y xywh(2)=w xywh(3)=h
            bool clipAddrWindow(ArrayLong* xywh);
            //   Clip window xs,ys,xe,ye to screen and viewport
            //   Arraylong xsysxeye xsysxeye(0)=xs xsysxeye(1)=ys xsysxeye(2)=xe xsysxeye(3)=ye
            bool clipWindow(ArrayLong* xsysxeye);

            //   push a single pixel           
//            void pushColor1(uint16_t color, uint32_t len);            
            //    push an array of pixels, for image drawing            
            void pushColors(ArrayUInt* data, bool swap);
            //   push an array of pixels for 16-bit raw image drawing
            // Assumed that setAddrWindow() has previously been called
            // len is number of bytes, not pixels              
            void pushColors1(ArrayByte* data);
            // Assumed that setAddrWindow() has previously been called
            // len is number of bytes, not pixels        
            void pushBlock(uint16_t color, uint32_t len);
            //  push an array of pixels for 16-bit raw image drawing
            void pushPixels(ArrayByte* data_in);
            // #ifdef TFT_SDA_READ
            // #if defined (TFT_eSPI_ENABLE_8_BIT_READ)
            // Read 8-bit value from TFT command register
            byte tft_Read8();
            // #ifdef TFT_SDA_READ
            // Begin a read on a half duplex (bi-directional SDA) SPI bus - sets MOSI to input
            void begin_SDA_Read();
            // #ifdef TFT_SDA_READ
            // Restore MOSI to output
            void end_SDA_Read();
            //   Clear the screen to defined colour
            void fillScreen(uint32_t color);
            //  Draw a rectangle outline
            void drawRect(int32_t x, int32_t y, int32_t w, int32_t h, uint32_t color);
            //   Draw a rounded corner rectangle outline
            void drawRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color);
            //   Draw a rounded corner filled rectangle
            void fillRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color);
            //   draw a filled rectangle with a vertical colour gradient
            void fillRectVGradient(int16_t x, int16_t y, int16_t w, int16_t h, uint32_t color1, uint32_t color2);
            //   draw a filled rectangle with a horizontal colour gradient
            void fillRectHGradient(int16_t x, int16_t y, int16_t w, int16_t h, uint32_t color1, uint32_t color2);
            //  Draw a circle outline
            void drawCircle(int32_t x, int32_t y, int32_t r, uint32_t color);
            //   Support function for drawRoundRect()
            void drawCircleHelper(int32_t x, int32_t y, int32_t r, byte cornername, uint32_t color);
            //    draw a filled circle
            void fillCircle(int32_t x, int32_t y, int32_t r, uint32_t color);
            //   Support function for fillRoundRect()
            // Support drawing roundrects, changed to horizontal lines
            void fillCircleHelper(int32_t x, int32_t y, int32_t r, byte cornername, int32_t delta, uint32_t color);
            //   Draw a ellipse outline
            void drawEllipse(int16_t x, int16_t y, int32_t rx, int32_t ry, uint16_t color);
            //    draw a filled ellipse
            void fillEllipse(int16_t x, int16_t y, int32_t rx, int32_t ry, uint16_t color);
            //   Draw a triangle outline using 3 arbitrary points
            void drawTriangle(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3, uint32_t color);
            //   Draw a filled triangle using 3 arbitrary points
            void fillTriangle(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3, uint32_t color);
            //  push a single pixel at an arbitrary position
//            uint16_t drawPixel1(int32_t x, int32_t y, uint32_t color, byte alpha, uint32_t bg_color);
            //    Draw a smooth arc clockwise from 6 o'clock
            // Default ; roundEnds = false
            void drawSmoothArc(int32_t x, int32_t y, int32_t r, int32_t ir, uint32_t startAngle, uint32_t endAngle, uint32_t fg_color, uint32_t bg_color, bool roundEnds);
            //   Draw an arc clockwise from 6 o'clock position
            // Centre at x,y
            // r = arc outer radius, ir = arc inner radius. Inclusive, so arc thickness = r-ir+1
            // Angles MUST be in range 0-360
            // Arc foreground fg_color anti-aliased with background colour along sides
            // smooth is optional, default is true, smooth=false means no antialiasing
            // Note: Arc ends are not anti-aliased (use drawSmoothArc instead for that)  
            // Default : smoothArc = true 
            void drawArc(int32_t x, int32_t y, int32_t r, int32_t ir, uint32_t startAngle, uint32_t endAngle, uint32_t fg_color, uint32_t bg_color, bool smoothArc);
            //   Draw a smooth circle
            void drawSmoothCircle(int32_t x, int32_t y, int32_t r, uint32_t fg_color, uint32_t bg_color);
            //   Draw a filled anti-aliased circle
            //  Default :  bg_color = 0x00FFFFFF)
            void fillSmoothCircle(int32_t x, int32_t y, int32_t r, uint32_t color, uint32_t bg_color);
            //   Draw a rounded rectangle
            // x,y is top left corner of bounding box for a complete rounded rectangle
            // r = arc outer corner radius, ir = arc inner radius. Arc thickness = r-ir+1
            // w and h are width and height of the bounding rectangle
            // If w and h are < radius (e.g. 0,0) a circle will be drawn with centre at x+r,y+r
            // Arc foreground fg_color anti-aliased with background colour at edges
            // A subset of corners can be drawn by specifying a quadrants mask. A bit set in the
            // mask means draw that quadrant (all are drawn if parameter missing):   0x1 | 0x2
            //    ---|---    Arc quadrant mask select bits (as in drawCircleHelper fn) 0x8 | 0x4
            //  Default : bg_color = 0x00FFFFFF, quadrants = 0xF
            void drawSmoothRoundRect(int32_t x, int32_t y, int32_t r, int32_t ir, int32_t w, int32_t h, uint32_t fg_color, uint32_t bg_color, byte quadrants);
            //   Draw a filled anti-aliased rounded corner rectangle
            //  Default : bg_color = 0x00FFFFFF
            void fillSmoothRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t radius, uint32_t color, uint32_t bg_color);
            //   Draw an anti-aliased filled circle at ax,ay with radius r
            // Coordinates are floating point to achieve sub-pixel positioning
            // Default : bg_color = 0x00FFFFFF
            void drawSpot(double ax, double ay, double r, uint32_t fg_color, uint32_t bg_color);
            //    draw an anti-aliased line with rounded ends, width wd
            //  default :  bg_color = 0x00FFFFFF
            void drawWideLine(double ax, double ay, double bx, double by, double wd, uint32_t fg_color, uint32_t bg_color);
            //   draw an anti-aliased line with different width radiused ends
            // Default : bg_color = 0x00FFFFFF
            void drawWedgeLine(double ax, double ay, double bx, double by, double aw, double bw, uint32_t fg_color, uint32_t bg_color);
            //   Used by 16-bit pushImage() to swap byte order in colours
            void setSwapBytes(bool swap);
            //   Return the swap byte order for colours
            bool getSwapBytes();
            //   Draw an image stored in an array on the TFT
            void drawBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor);
            //   Draw an image stored in an array on the TFT
            void drawBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor, uint16_t bgcolor);
            //   Draw an image stored in an XBM array onto the TFT
            void drawXBitmap(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor);
            //   Draw an XBM image with foreground and background colors
            void drawXBitmap1(int16_t x, int16_t y, ArrayByte* bitmap, int16_t w, int16_t h, uint16_t fgcolor, uint16_t bgcolor);
            //   Set the foreground foreground and background colour
//            void setBitmapColor(uint16_t fgcolor, uint16_t bgcolor);
            //   Set the pivot point on the TFT
            void setPivot(int16_t x, int16_t y);
            //   Get the x pivot position
            int16_t getPivotX();
            //   Get the y pivot position
            int16_t getPivotY();
            //    Read 565 pixel colours from a defined area
            void readRect(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data);
            //    push 565 pixel colours into a defined area
            void pushRect(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data);
            //    plot 16-bit colour sprite or image onto TFT
//            void pushImage(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data);
            //    plot 16-bit sprite or image with 1 colour being transparent 
//            void pushImage1(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, uint16_t transparent);
            //    plot 16-bit sprite or image with 1 colour being transparent            
// ???           void pushImage2(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, uint16_t transparent);
            //    plot 16-bit colour sprite or image onto TFT
            //    for FLASH (PROGMEM) stored images            
// ???           void pushImage3(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data);
            //   plot 8-bit or 4-bit or 1 bit image or sprite using a line buffer
            //    from FLASH (PROGMEM) stored images               
//            void pushImage4(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, bool bpp8, ArrayUInt* cmap);
            //    plot 8 or 4 or 1 bit image or sprite with a transparent colour            
//            void pushImage5(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, byte  transparent, bool bpp8, ArrayUInt* cmap);
            //    plot 8-bit or 4-bit or 1 bit image or sprite using a line buffer                 
//            void pushImage6(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data, bool bpp8, ArrayUInt* cmap);
            //    Render a 16-bit colour image to TFT with a 1bpp mask
            //    from FLASH (PROGMEM) stored images            
            void pushMaskedImage(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* img, ArrayByte* mask);
            //    read rectangle (for SPI Interface II i.e. IM [3:0] = "1101")
            //    Read RGB pixel colours from a defined area
            // If w and h are 1, then 1 pixel is read, *data array size must be 3 bytes per pixel            
            void readRectRGB(int32_t x, int32_t y, int32_t w, int32_t h, ArrayByte* data);
            //    draw a long integer with font number
            int16_t drawNumber(int32_t intNumber, int32_t x, int32_t y, byte font);
            //    draw a long integer
            int16_t drawNumber1(int32_t intNumber, int32_t x, int32_t y);
            //    drawFloat, prints 7 non zero digits maximum with font number
            int16_t drawFloat(double doubleNumber, byte decimal, int32_t x, int32_t y, byte font);
            //    drawFloat, prints 7 non zero digits maximum          
            int16_t drawFloat1(double doubleNumber, byte decimal, int32_t x, int32_t y);
            //    draw string with padding if it is defined and with font number
            int16_t drawString(B4RString* string, int32_t x, int32_t y, byte font);
            //    draw string with padding if it is defined 
            //    Without font number, uses font set by setTextFont()                         
            int16_t drawString1(B4RString* string, int32_t x, int32_t y);
            //    draw string centred on dX  (deprecated, use setTextDatum())
            int16_t drawCentreString(B4RString* string, int32_t x, int32_t y, byte font);
            //    draw string right justified to dX  (deprecated, use setTextDatum())             
            int16_t drawRightString(B4RString* string, int32_t x, int32_t y, byte font);
            //    Set the text cursor x,y position
            void setCursor(int16_t x, int16_t y);
            //    Set the text cursor x,y position and font
            void setCursor1(int16_t x, int16_t y, byte font);
            //    Get the text cursor x position
            int16_t getCursorX();
            //    Get the text cursor y position
            int16_t getCursorY();
            //    Set the font foreground colour (background is transparent)
            void setTextColor(uint16_t color);
            //    Set the font foreground and background colour
            // Smooth fonts use the background colour for anti-aliasing and by default the
            // background is not filled. If bgfill = true, then a smooth font background fill will
            // be used.
            // Default : bgfill = false
            void setTextColor1(uint16_t fgcolor, uint16_t bgcolor, bool bgfill);
            //    Set the text size multiplier
            void setTextSize(byte size);
            //    Define if text should wrap at end of line
            //  Default :  wrapY = false
            void setTextWrap(bool wrapX, bool wrapY);
            //   Set the text position reference datum
            void setTextDatum(byte datum);
            //   Return the text datum value (as used by setTextDatum())
            byte getTextDatum();
            //    Define padding width (aids erasing old text and numbers)
            void setTextPadding(uint16_t x_width);
            //    Define padding width (aids erasing old text and numbers)
            uint16_t getTextPadding();
          #ifdef LOAD_GFXFF       
            //    Sets the GFX free font to use (from fonts number define in inline C )
            //  FreeFonts 1<x after declaration in inline C            
            void setFreeFont(byte GFXid); 
            //    Set the font by default (1<8) for the print stream
            //  Fonts by default 1<8            
            void setTextFont(byte font);
          #else  
            //   No GFX free font define: no used
            //  Fonts by default 1<8            
            void setFreeFont1(byte font);
            //   Set the font by default (1<8) for the print stream
            //  Fonts by default 1<8
            void setTextFont1(byte font);
          #endif  
            //   Return the width in pixels of a string in a given font            
            int16_t textWidth(B4RString* string, byte font);
            //   Return the width in pixels of a string in a given font             
            int16_t textWidth1(B4RString* string);
            //   Return the width in pixels of a string in a given font  
            //    from String sent by reference          
            int16_t textWidth2(B4RString* string, byte font);
            //   Return the width in pixels of a string in a given font  
            //    from String sent bynreference            
            int16_t textWidth3(B4RString* string);
            //    return the height of a font (yAdvance for free fonts)
            int16_t fontHeight(int16_t font);
            //    return the height of a font (yAdvance for free fonts)
            int16_t fontHeight1();
            //    Serial UTF-8 decoder with fall-back to extended ASCII
            uint16_t decodeUTF8(ArrayByte* buf, ArrayUInt* index, uint16_t remaining);
            //    Line buffer UTF-8 decoder with fall-back to extended ASCII
            uint16_t decodeUTF81(byte c);
            //    draw characters piped through serial stream
            uint16_t write(uint8_t utf8);

//            void setCallback(Subuint_uintuint OnTFTColorCallbackSub);
            //~hide
//            static uint16_t TFTColorCallback(uint16_t x, uint16_t y);
            //   return an encoded 16-bit value showing the fonts loaded
            //  Each bit in returned value represents a font type that is loaded - used for debug/error handling only
            uint16_t fontsLoaded();
            //    Write 8 bits to SPI port (legacy support only)
            void spiwrite(uint8_t c);
            //    #ifndef RM68120_DRIVER
            // Send a 16-bit command, function resets DC/RS high ready for data
            void writecommand(uint16_t c);
            //    #ifndef RM68120_DRIVER 
            // Write 8-bit data data to 16-bit command register           
            void writeRegister8(uint16_t c, byte d);
            //    #ifndef RM68120_DRIVER  
            // Write 16-bit data data to 16-bit command register          
            void writeRegister16(uint16_t c, uint16_t d);
           // Send an 8-bit command, function resets DC/RS high ready for data
            void writecommand1(byte c);
            //    #ifdef RM68120_DRIVER            
             // Send data with DC/RS set high
            void writedata(byte d);
            // Send a initialisation sequence to TFT stored in FLASH
            void commandList(ArrayByte* addr);
            // read 8 bits from TFT
            byte readcommand8(byte cmd_function, byte index);
            // read 16 bits from TFT
            uint16_t readcommand16(byte cmd_function, byte index);
            // read 32 bits from TFT
            uint32_t readcommand32(byte cmd_function, byte index);
            // Convert 8-bit red, green and blue to 16 bits
            uint16_t color565(byte red, byte green, byte blue);
            // Convert 8-bit colour to 16 bits
            uint16_t color8to16(byte color332);
            // Convert 16-bit colour to 8 bits
            byte color16to8(uint16_t color565);
            // Convert 16-bit colour to 24-bit, R+G+B concatenated into LS 24 bits
            uint32_t color16to24(uint16_t color565);
            // Convert 16-bit colour from 24-bit, R+G+B concatenated into LS 24 bits
            uint32_t color24to16(uint32_t color888);
            // Alpha blend 2 colours, see generic "alphaBlend_Test" example
            // alpha =   0 = 100% background colour
            // alpha = 255 = 100% foreground colour            
            uint16_t alphaBlend(byte alpha, uint16_t fgc, uint16_t bgc);
            // 16-bit colour alphaBlend with alpha dither (dither reduces colour banding)
            uint16_t alphaBlend1(byte alpha, uint16_t fgc, uint16_t bgc, byte dither);
            // 24-bit colour alphaBlend with optional alpha dither
            //  Default : dither = 0
            uint32_t alphaBlend24(byte alpha, uint32_t fgc, uint32_t bgc, byte dither);
            // Initialise the DMA engine and attach to SPI bus - typically used in setup()
            // Parameter "true" enables DMA engine control of TFT chip select (ESP32 only)
            // For ESP32 only, TFT reads will not work if parameter is true
            //  Default : ctrl_cs = false
            bool initDMA(bool ctrl_cs);
            // De-initialise the DMA engine and detach from SPI bus - typically not used
            void deInitDMA();
            // Push an image to the TFT using DMA, buffer is optional and grabs (double buffers) a copy of the image
            // Use the buffer if the image data will get over-written or destroyed while DMA is in progress
            //
            // Note 1: If swapping colour bytes is defined, and the double buffer option is NOT used, then the bytes
            // in the original image buffer content will be byte swapped by the function before DMA is initiated.
            //
            // Note 2: If part of the image will be off screen or outside of a set viewport, then the the original
            // image buffer content will be altered to a correctly clipped image before DMA is initiated.
            //
            // The function will wait for the last DMA to complete if it is called while a previous DMA is still
            // in progress, this simplifies the sketch and helps avoid "gotchas". 
            // Default : buffer = nullptr           
            void pushImageDMA(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data, ArrayUInt* buffer);
            // ESP32 only at the moment
            // For case where pointer is a const and the image data must not be modified (clipped or byte swapped)
            void pushImageDMA1(int32_t x, int32_t y, int32_t w, int32_t h, ArrayUInt* data);
            // Push a block of pixels into a window set up using setAddrWindow()
            void pushPixelsDMA(ArrayUInt* image);
            // Check if the DMA is complete - use while(tft.dmaBusy); for a blocking wait
            // returns true if DMA is still in progress            
            bool dmaBusy();
            // wait until DMA is complete
            void dmaWait();
            // Flag for DMA enabled state
            bool DMA_Enabled();
            // Number of ESP32 transfer buffers to check
            uint8_t spiBusyCheck();
            // Begin SPI transaction
            void startWrite();
            // Deprecated, use pushBlock()
 //           void writeColor2(uint16_t color, uint32_t len);
            // End SPI transaction
            void endWrite();
            // Set attribute value
            // Default : id=0 a=0
            void setAttribute(byte id, byte a);
            // Get attribute value
            //  Default : id=0
            byte getAttribute(byte id);
            // Text foreground colours
            uint32_t textcolor();
            // Text background colours
            uint32_t textbgcolor();
            // Bitmap foreground (bit=1) colours
            uint32_t bitmap_fg();
            // Bitmap  background (bit=0) colours
            uint32_t bitmap_bg();
            // Get Current selected font number
            byte textfont();
            // Get Current font size multiplier
            byte textsize();
            // Get Text reference datum
            byte textdatum();
            // Display rotation (0-3)
            byte rotation();
            // UTF8 decoder state        - not for user access
            uint16_t decoderState();
            // Unicode code-point buffer - not for user access
            uint16_t decoderBuffer();
            
            // Print a string
            uint16_t print(B4RString* string);
            // Println a string
            uint16_t println(B4RString* string);
            
//****************     
//From TFT_eSPI Touch  
//****************
   #ifdef TOUCH_CS   
    //  #ifdef TOUCH_CS    
    // Get raw x,y ADC values from touch controller
    byte getTouchRaw(ArrayUInt* xy);
    //  #ifdef TOUCH_CS 
    // Get raw z (i.e. pressure) ADC value from touch controller
    uint16_t getTouchRawZ();
    //   #ifdef TOUCH_CS 
    // Convert raw x,y values to calibrated and correctly rotated screen coordinates
    void convertRawXY(ArrayUInt* xy);
    //   #ifdef TOUCH_CS 
    // Get the screen touch coordinates, returns true if screen has been touched
    // if the touch coordinates are off screen then x and y are not updated
    // The returned value can be treated as a bool type, false or 0 means touch not detected
    // In future the function may return an 8-bit "quality" (jitter) value.
    // The threshold value is optional, this must be higher than the bias level for z (pressure)
    // reported by Test_Touch_Controller when the screen is NOT touched. When touched the z value
    // must be higher than the threshold for a touch to be detected.
    // ArrayUInt* xy : xy(0) = x   xy(1) = y
    // Default :  threshold = 600)
    byte getTouch(ArrayUInt* xy, uint16_t threshold);
    //   #ifdef TOUCH_CS 
    // Run screen calibration and test, report calibration values to the serial port
    void calibrateTouch(ArrayUInt* data, uint32_t color_fg, uint32_t color_bg, byte size);
    //   #ifdef TOUCH_CS 
    // Set the screen calibration values
    void setTouch(ArrayUInt* data);
  #endif
//**********************  
// From TFT_eSPI smooth Font
//**********************
  #ifdef SMOOTH_FONT
  #ifdef LOAD_GFXFF  
    // #ifdef LOAD_GFXFF
    // loads parameters from a font vlw array from h file   
    void loadFontH(byte VLWid);
  #ifdef FONT_FS_AVAILABLE 
    #if defined(ESP32)
    // #ifdef LOAD_GFXFF  
    // #ifdef FONT_FS_AVAILABLE 
    // only for ESP32
    // loads parameters from a font vlw file from SD 
    // return 0=OK / 1=error init / 2=error card    
    uint8_t loadFontSD(B4RString* fontName);
    #endif
    // #ifdef LOAD_GFXFF  
    // #ifdef FONT_FS_AVAILABLE 
    // loads parameters from a font vlw file  from LittleFS  
    // return 0=OK / 1=error init
    uint8_t loadFontLittleFS(B4RString* fontName);
  #endif
    // #ifdef LOAD_GFXFF  
    // loads parameters from a font vlw file from SPIFFS
    void loadFontFS(B4RString* fontName);
    // #ifdef LOAD_GFXFF    
    // Delete the old glyph metrics and free up the memory
    void unloadFont();
    // #ifdef LOAD_GFXFF
    // Get the font file index of a Unicode character
    bool getUnicodeIndex(uint16_t unicode, ArrayUInt* index);
    // #ifdef LOAD_GFXFF
    // Write a character to the TFT cursor position
    void drawGlyph(uint16_t code);
    // #ifdef LOAD_GFXFF
    // Page through all characters in font, td ms between screens
    void showFont(uint32_t td);
  #endif
  #endif
    };
    
    
    
//********************
// TFT_eSPI_Button
//******************** 
    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino  https://github.com/Bodmer/TFT_eSPI
    //~shortname:TFT_eSPI_Button
    class B4RTFT_eSPI_Button
    {
        private:
            uint8_t backend[sizeof(TFT_eSPI_Button)];
            TFT_eSPI_Button* rcr;
        public: 
            void Initialize();
            // "Classic" initButton() uses centre and size
            void initButton(uint32_t TFTid, int16_t x, int16_t y, uint16_t w, uint16_t h, uint16_t outline, uint16_t fill, uint16_t textcolor, B4RString* label, byte textsize);
            // New/alt initButton() uses upper-left corner and size    
            void initButtonUL(uint32_t TFTid, int16_t x1, int16_t y1, uint16_t w, uint16_t h, uint16_t outline, uint16_t fill, uint16_t textcolor, B4RString* label, byte textsize);
            // Adjust text datum and x, y deltas
            //  Default : datum = MC_DATUM
            void setLabelDatum(int16_t x_delta, int16_t y_delta, byte datum);
            //  Default : long_name = ""
            void drawButton(bool inverted, B4RString* long_name);
            
            bool contains(int16_t x, int16_t y);
            
            void press(bool p);
            
            bool isPressed();
            
            bool justPressed();
            
            bool justReleased();
    };
}
