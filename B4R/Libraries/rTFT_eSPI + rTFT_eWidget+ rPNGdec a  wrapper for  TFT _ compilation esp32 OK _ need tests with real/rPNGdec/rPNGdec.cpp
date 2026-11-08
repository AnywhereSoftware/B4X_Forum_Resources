#include "B4RDefines.h"
//******************************************************************************
 void pngDraw(PNGDRAW *pDraw) 
 {
    B4R::B4RPNG::pngDrawCB((uint32_t)pDraw, pDraw->y, pDraw->iWidth); 
 };
//*****************************************************************************
File pngfile;
void* pngOpen(const char *filename, int32_t *size) 
{
   Serial.printf("Attempting to open %s\n", filename);
   pngfile = FileSys.open(filename, "r");
   *size = pngfile.size();
   return &pngfile;
};
void pngClose(void *handle) 
{
   File pngfile = *((File*)handle);
   if (pngfile) pngfile.close();
};

int32_t pngRead(PNGFILE *page, uint8_t *buffer, int32_t length) 
{
   if (!pngfile) return 0;
   page = page; // Avoid warning
   return pngfile.read(buffer, length);
};

int32_t pngSeek(PNGFILE *page, int32_t position) 
{
   if (!pngfile) return 0;
   page = page; // Avoid warning
   return pngfile.seek(position);
};
//******************************************************************************
B4R::B4RPNG* B4R::B4RPNG::instance = NULL;
namespace B4R
{
    void B4RPNG::Initialize()
    {
       PNG png;
    };

    int16_t B4RPNG::openRAM(ArrayByte* pData, SubVoid_DblIntInt pngDrawSub)
    {
       this->pngDraw_Sub = pngDrawSub;
       instance = this;
       return png.openRAM((uint8_t*) pData->data, pData->length, pngDraw);
    };

    int16_t B4RPNG::openFLASH(byte PNGid, SubVoid_DblIntInt pngDrawSub)
    {
       this->pngDraw_Sub = pngDrawSub;
       instance = this;
       return png.openFLASH((uint8_t*) PNGfiles[PNGid], PNGsize[PNGid], pngDraw);
    };

    int16_t B4RPNG::open(B4RString* szFilename, SubVoid_DblIntInt pngDrawSub)
    {
       this->pngDraw_Sub = pngDrawSub;
       instance = this;
       return png.open( szFilename->data, pngOpen, pngClose, pngRead, pngSeek, pngDraw);
    };    
//callback  
    void B4RPNG::pngDrawCB(uint32_t pDrawID, int16_t pDraw_y, int16_t pDraw_iWidth) 
    { 
        instance->pngDraw_Sub(pDrawID, pDraw_y, pDraw_iWidth); 
    };
//*************    
    void B4RPNG::close()
    {
       png.close();
    };

    int16_t B4RPNG::decode(int16_t iOptions)
    {
       return png.decode(NULL, iOptions);
    };

    int16_t B4RPNG::getWidth()
    {
       return png.getWidth();
    };

    int16_t B4RPNG::getHeight()
    {
       return png.getHeight();
    };

    int16_t B4RPNG::getBpp()
    {
       return png.getBpp();
    };

    int16_t B4RPNG::hasAlpha()
    {
       return png.hasAlpha();
    };

    uint32_t B4RPNG::getTransparentColor()
    {
       return png.getTransparentColor();
    };

    int16_t B4RPNG::isInterlaced()
    {
       return png.isInterlaced();
    };

    ArrayByte* B4RPNG::getPalette()
    {
       byte* raw = png.getPalette();
       uint16_t len = sizeof(raw); // or fixe value depending of the arduino part
       ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
       arr->data=raw;
       arr->length=len;
       return arr;
    };

    int16_t B4RPNG::getPixelType()
    {
       return png.getPixelType();
    };

    int16_t B4RPNG::getLastError()
    {
       return png.getLastError();
    };

    int16_t B4RPNG::getBufferSize()
    {
       return png.getBufferSize();
    };

    ArrayByte* B4RPNG::getBuffer()
    {
       byte* raw = png.getBuffer();
       uint16_t len = png.getBufferSize();
       ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
       arr->data=raw;
       arr->length=len;
       return arr;
    };

    void B4RPNG::setBuffer(ArrayByte* pBuffer)
    {
       png.setBuffer((byte*)pBuffer->data);
    };
    // Note: pushMaskedImage is for pushing to the TFT and will not work pushing into a sprite
    //  uint8_t pmask[1 + MAX_IMAGE_WIDTH / 8];  // Mask buffer
    // default: ucThreshold = 255
    byte B4RPNG::getAlphaMask(uint32_t pDrawID, ArrayByte* pMask, byte ucThreshold)
    {
       return png.getAlphaMask((PNGDRAW*) pDrawID, (byte*)pMask->data, ucThreshold);
    };
    //u32Bkgd = 0xffffffff
    //iEndianness = PNG_RGB565_BIG_ENDIAN
    //uint16_t lineBuffer[MAX_IMAGE_WIDTH];          // Line buffer for rendering
    void B4RPNG::getLineAsRGB565(uint32_t pDrawID, ArrayUInt* lineBuffer, int16_t iEndianness, uint32_t u32Bkgd)
    {
       png.getLineAsRGB565((PNGDRAW*) pDrawID, (uint16_t*)lineBuffer->data, iEndianness, u32Bkgd);
    };
}
