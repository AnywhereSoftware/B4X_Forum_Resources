#pragma once
#include "B4RDefines.h"
#include "PNGdec.h"
#include <LittleFS.h>
#define FileSys LittleFS

    //~Event: pngDraw(pDrawID as ULong, pDraw_y as Int, pDraw_iWidth as Int)
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino : https://github.com/bitbank2/PNGdec

namespace B4R {

    typedef void (*SubVoid_DblIntInt)(uint32_t pDrawID, int16_t pDraw_y, int16_t pDraw_iWidth);
    //~shortname:PNG
    class B4RPNG
    {
        private:
            PNG png;
            static B4RPNG* instance;
            SubVoid_DblIntInt pngDraw_Sub;
        public:
            //~hide             
            static const uint8_t* PNGfiles[];  
            static const uint32_t PNGsize[];
            void Initialize();
            // Memory initialization
            int16_t openRAM(ArrayByte* pData, SubVoid_DblIntInt pngDrawSub);
            // It's necessary to separate out a FLASH version on Harvard architecture machines
            int16_t openFLASH(byte PNGid, SubVoid_DblIntInt pngDrawSub);
            // File (SD/MMC) based initialization
            int16_t open(B4RString* szFilename, SubVoid_DblIntInt pngDrawSub);    
            //callback
            //~hide  
            static void pngDrawCB(uint32_t pDrawID, int16_t pDraw_y, int16_t pDraw_iWidth); 
            // Close the file - not needed when decoding from memory
            void close();
            
            int16_t decode(int16_t iOptions);
            // Get the width of the image in pixels
            // can be called after opening the file (before decoding)
            int16_t getWidth();
            // Get the height of the image in pixels
            // can be called after opening the file (before decoding)
            int16_t getHeight();
            // Returns the number of bits per color stimulus
            // values of 1,2,4, and 8 are supported
            int16_t getBpp();
            // Alpha information can be per pixel, per color or a single color
            // depending on the PNG pixel type of the image
            // This call simply tells you if there is alpha for the current pixel type
            int16_t hasAlpha();
            // For truecolor and palette images, it's possible to have a single
            // transparent color defined. This call will return it if defined
            uint32_t getTransparentColor();
            // Returns true or false for the use of Adam7 interlacing
            // This option is not supported by the decoder, but after opening the image
            // you can determine if it's set
            int16_t isInterlaced();
            // Returns a pointer to the palette
            // If there is alpha info for the palette, it starts at pPalette[768]
            ArrayByte* getPalette();
            // Returns the PNG pixel type (see enum in PNGdec.h)
            int16_t getPixelType();
            // return the last error (if any)
            int16_t getLastError();
            // Returns the size in bytes of the buffer needed to hold the uncompressed image
            int16_t getBufferSize();
            // Returns the previously set image buffer or NULL if there is none
            ArrayByte* getBuffer();
            // Set the image buffer to memory managed by the caller
            // If set, decode() will not use the PNGDRAW callback function
            // and instead write the image into this buffer in one shot
            void setBuffer(ArrayByte* pBuffer);
            // Note: pushMaskedImage is for pushing to the TFT and will not work pushing into a sprite
            //  uint8_t  pmask[1 + MAX_IMAGE_WIDTH / 8];  // Mask buffer
            // default: ucThreshold = 255
            // check if any pixels are opaque, and draw them
            byte getAlphaMask(uint32_t pDrawID, ArrayByte* pMask, byte ucThreshold);
            // Convert a line of native pixels (all supported formats) into RGB565
            // can optionally mix in a background color - set to -1 to disable
            // Background color is in the form of a uint32_t -> 00BBGGRR (MSB on left)
            //default: u32Bkgd = 0xffffffff
            //default: iEndianness = PNG_RGB565_BIG_ENDIAN
            //uint16_t lineBuffer[MAX_IMAGE_WIDTH];          // Line buffer for rendering
            void getLineAsRGB565(uint32_t pDrawID, ArrayUInt* lineBuffer, int16_t iEndianness, uint32_t u32Bkgd);
            
    #define /*byte PNG_RGB565_BIG_ENDIAN;*/     B4R_PNG_RGB565_BIG_ENDIAN       PNG_RGB565_BIG_ENDIAN
    
    #define /*byte PNG_SUCCESS;*/               B4R_PNG_SUCCESS                 0
    #define /*byte PNG_INVALID_PARAMETER;*/     B4R_PNG_INVALID_PARAMETER       1
    #define /*byte PNG_DECODE_ERROR;*/          B4R_PNG_DECODE_ERROR            2
    #define /*byte PNG_MEM_ERROR;*/             B4R_PNG_MEM_ERROR               3
    #define /*byte PNG_NO_BUFFER;*/             B4R_PNG_NO_BUFFER               4
    #define /*byte PNG_UNSUPPORTED_FEATURE;*/   B4R_PNG_UNSUPPORTED_FEATURE     5
    #define /*byte PNG_INVALID_FILE;*/          B4R_PNG_INVALID_FILE            6
    #define /*byte PNG_TOO_BIG;*/               B4R_ PNG_TOO_BIG                7
    };
}
