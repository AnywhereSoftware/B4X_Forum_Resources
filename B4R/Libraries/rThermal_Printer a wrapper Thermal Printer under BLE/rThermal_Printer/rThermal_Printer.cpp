#include "B4RDefines.h"

namespace B4R
{
    int16_t B4RThermal_Printer::GetWidth()
    {
       return tpGetWidth();
    };

    B4RString* B4RThermal_Printer::GetName()
    {
       char* raw = tpGetName();
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw;
       return arr;
    };

    void B4RThermal_Printer::Feed(int16_t iLines)
    {
       tpFeed(iLines);
    };

    void B4RThermal_Printer::SetEnergy(int16_t iEnergy)
    {
       tpSetEnergy(iEnergy);
    };

    void B4RThermal_Printer::GetStringBox(byte pFontNb, B4RString* szMsg, ArrayInt* rectangle) //ArrayInt* width, ArrayInt* top, ArrayInt* bottom)
    {  
       int* Rec =  (int*) rectangle->data; 
       tpGetStringBox((GFXfont*) myfonts[pFontNb],(char*) szMsg->data, &Rec[0], &Rec[1], &Rec[2]);
    };

    int16_t B4RThermal_Printer::DrawCustomText(byte pFontNb, int16_t x, int16_t y, B4RString* szMsg)
    {
       return tpDrawCustomText((GFXfont*) myfonts[pFontNb], x, y,(char*) szMsg->data);
    };

    int16_t B4RThermal_Printer::PrintCustomText(byte pFontNb, int16_t x, B4RString* szMsg)
    {
       return tpPrintCustomText((GFXfont*) myfonts[pFontNb], x,(char*) szMsg->data);
    };

    void B4RThermal_Printer::WriteRawData(ArrayByte* pData, int16_t iLen)
    {
       tpWriteRawData((byte*)pData->data, iLen);
    };

    void B4RThermal_Printer::SetFont(int16_t iFont, int16_t iUnderline, int16_t iDoubleWide, int16_t iDoubleTall, int16_t iEmphasized)
    {
       tpSetFont(iFont, iUnderline, iDoubleWide, iDoubleTall, iEmphasized);
    };

    void B4RThermal_Printer::SetBackBuffer(ArrayByte* pBuffer, int16_t iWidth, int16_t iHeight)
    {
       tpSetBackBuffer((byte*)pBuffer->data, iWidth, iHeight);
    };

    int16_t B4RThermal_Printer::Print(B4RString* pString)
    {
       return tpPrint((char*)pString->data);
    };

    int16_t B4RThermal_Printer::PrintLine(B4RString* pString)
    {
       return tpPrintLine((char*)pString->data);
    };

//?? #define MODE_WITH_RESPONSE 1
//?? #define MODE_WITHOUT_RESPONSE 0
    void B4RThermal_Printer::SetWriteMode(byte bWriteMode)
    {
       tpSetWriteMode(bWriteMode);
    };

    int16_t B4RThermal_Printer::DrawText(int16_t x, int16_t y, B4RString* pString, int16_t iFontSize, int16_t bInvert)
    {
       return tpDrawText(x, y, (char*)pString->data, iFontSize, bInvert);
    };

    int16_t B4RThermal_Printer::LoadBMP(ArrayByte* pBMP, int16_t bInvert, int16_t iXOffset, int16_t iYOffset)
    {
       return tpLoadBMP((byte*)pBMP->data, bInvert, iXOffset, iYOffset);
    };

    void B4RThermal_Printer::Fill(byte ucData)
    {
       tpFill(ucData);
    };

    int16_t B4RThermal_Printer::SetPixel(int16_t x, int16_t y, byte ucColor)
    {
       return tpSetPixel(x, y, ucColor);
    };

    void B4RThermal_Printer::PrintBuffer()
    {
       tpPrintBuffer();
    };

    void B4RThermal_Printer::PrintBufferSide()
    {
       tpPrintBufferSide();
    };

    void B4RThermal_Printer::DrawLine(int16_t x1, int16_t y1, int16_t x2, int16_t y2, byte ucColor)
    {
       tpDrawLine(x1, y1, x2, y2, ucColor);
    };

    int16_t B4RThermal_Printer::Scan(B4RString* szName, int16_t iSeconds)
    {
       return tpScan((char*)szName->data, iSeconds);
    };

    int16_t B4RThermal_Printer::Connect(B4RString* szMacAddress)
    {
       return tpConnect(szMacAddress->data);
    };

    void B4RThermal_Printer::Align(byte ucAlign)
    {
       tpAlign(ucAlign);
    };

    void B4RThermal_Printer::QRCode(B4RString* szText)
    {
       tpQRCode((char*)szText->data);
    };

    void B4RThermal_Printer::QRCode1(B4RString* szText, int16_t iSize)
    {
       tpQRCode((char*)szText->data, iSize);
    };

    void B4RThermal_Printer::DBarcode(int16_t iType, int16_t iHeight, B4RString* szData, int16_t iTextPos)
    {
       tp1DBarcode(iType, iHeight,(char*) szData->data, iTextPos);
    };

    int16_t B4RThermal_Printer::Scan1()
    {
       return tpScan();
    };

    int16_t B4RThermal_Printer::Connect1()
    {
       return tpConnect();
    };

    void B4RThermal_Printer::Disconnect()
    {
       tpDisconnect();
    };

    int16_t B4RThermal_Printer::IsConnected()
    {
       return tpIsConnected();
    };
}
