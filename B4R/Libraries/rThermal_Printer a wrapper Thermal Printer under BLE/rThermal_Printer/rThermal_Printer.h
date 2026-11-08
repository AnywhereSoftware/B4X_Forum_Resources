#pragma once
#include "B4RDefines.h"
#include "Thermal_Printer.h"

    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray from https://github.com/bitbank2/Thermal_Printer

namespace B4R {
    //~shortname:Thermal_Printer
    class B4RThermal_Printer
    {
        private:

//?? #define MODE_WITH_RESPONSE 1
//?? #define MODE_WITHOUT_RESPONSE 0

        public:
            // fonts array to store fonts used
            //~hide
        const static GFXfont * myfonts[]; 
//
// Return the printer width in pixels
// The printer needs to be connected to get this info
//            
            int16_t GetWidth();
//
// Returns the BLE name of the connected printer
// as a zero terminated c-string
// Returns NULL if not connected
//            
            B4RString* GetName();
//
// Feed the paper in scanline increments
//            
            void Feed(int16_t iLines);
//
// tpSetEnergy Set Energy - switch between eco and nice images :) 
//            
            void SetEnergy(int16_t iEnergy);
//
// Return the measurements of a rectangle surrounding the given text string
// rendered in the given font
// ArrayInt* rectangle[3] needed / at return: rectangle[0] = width , rectange[1] = top , rectangle[2]= botton
//                             
            void GetStringBox(byte pFontNb, B4RString* szMsg, ArrayInt* rectangle); //width, ArrayInt* top, ArrayInt* bottom);
//
// Draw a string of characters in a custom font into the gfx buffer
//
            int16_t DrawCustomText(byte pFontNb, int16_t x, int16_t y, B4RString* szMsg);
//
// Print a string of characters in a custom font to the connected printer
//
            int16_t PrintCustomText(byte pFontNb, int16_t x, B4RString* szMsg);
//
// Send raw data to printer
//            
            void WriteRawData(ArrayByte* pData, int16_t iLen);
//
// Select one of 2 available text fonts along with attributes
// FONT_12x24 or FONT_9x17
// Each option is either 0 (disabled) or 1 (enabled)
// These are the text attributes offered by the standard printer spec
//            
            void SetFont(int16_t iFont, int16_t iUnderline, int16_t iDoubleWide, int16_t iDoubleTall, int16_t iEmphasized);
//
// Provide a back buffer for your printer graphics
// This allows you to manage the RAM used on
// embedded platforms like Arduinos
// The memory is laid out horizontally (384 pixels across = 48 bytes)
// So a 384x384 buffer would need to be 48x384 = 18432 bytes
//            
            void SetBackBuffer(ArrayByte* pBuffer, int16_t iWidth, int16_t iHeight);
//
// Print plain text immediately
//
// Pass a C-string (zero terminated char array)
// If the text doesn't reach the end of the line
// it will not be printed until the printer receives
// a CR (carriage return) or new text which forces
// it to wrap around
//
            int16_t Print(B4RString* pString);
//
// Print plain text immediately
// Pass a C-string (zero terminated char array)
// A CR (carriage return) will be added at the end
// to cause the printer to print the text and advance
// the paper one line
//
            int16_t PrintLine(B4RString* pString);
//
// Set the BLE write mode
// MODE_WITH_RESPONSE asks the receiver to ack each packet
// it will be slower, but might be necessary to successfully transmit
// every packet. The default is to wait for a response for each write
//            
            void SetWriteMode(byte bWriteMode);
//
// Draw text into the graphics buffer
//            
            int16_t DrawText(int16_t x, int16_t y, B4RString* pString, int16_t iFontSize, int16_t bInvert);
//
// Load a 1-bpp Windows bitmap into the back buffer
// Pass the pointer to the beginning of the BMP file
// along with a x and y offset (upper left corner)
//
            int16_t LoadBMP(ArrayByte* pBMP, int16_t bInvert, int16_t iXOffset, int16_t iYOffset);
//
// Fill the frame buffer with a byte pattern
// e.g. all off (0x00) or all on (0xff)
//            
            void Fill(byte ucData);
//
// Set (or clear) an individual pixel
//            
            int16_t SetPixel(int16_t x, int16_t y, byte ucColor);
//
// Send the graphics to the printer (must be connected over BLE first)
//            
            void PrintBuffer();
//
// Same as tpPrintBuffer, but output will be rotated by 90 degrees
//
            void PrintBufferSide();
//
// Draw a line between 2 points
//            
            void DrawLine(int16_t x1, int16_t y1, int16_t x2, int16_t y2, byte ucColor);    
//
// Scan for compatible printers
// returns true if found
// and stores the printer address internally
// for use with the tpConnect() function
// szName is the printer device name to match
// iSeconds = how many seconds to scan for devices
//            
            int16_t Scan(B4RString* szName, int16_t iSeconds);         //????????????????????????????
//
// connect to a printer with a macaddress
// returns 1 if successful, 0 for failure
//            
            int16_t Connect(B4RString* szMacAddress);
//
// Set the text and barcode alignment
// Use ALIGN_LEFT, ALIGN_CENTER or ALIGN_RIGHT
//            
            void Align(byte ucAlign);
//
// Print a 2D (QR) barcode
//            
            void QRCode(B4RString* szText);
//
// Print a 2D (QR) barcode
// iSize = starting from 1 / standard is 3
//            
            void QRCode1(B4RString* szText, int16_t iSize);
//
// Print a 1D barcode
//
            void DBarcode(int16_t iType, int16_t iHeight, B4RString* szData, int16_t iTextPos);
//
// Parameterless version
// finds supported printers automatically
//            
            int16_t Scan1();
//
// After a successful scan, connect to the printer
// returns 1 if successful, 0 for failure
//            
            int16_t Connect1();
//
// Disconnect Printer
//            
            void Disconnect();
//
// check if printer is connected
//            
            int16_t IsConnected();

        #define /*byte MODE_WITH_RESPONSE;*/ B4RMODE_WITH_RESPONSE                      1
        #define /*byte MODE_WITHOUT_RESPONSE;*/ B4RMODE_WITH_RESPONSE                   0

        #define /*byte FONT_SMALL;*/ B4RFONT_SMALL                                      0 
        #define /*byte FONT_LARGE;*/ B4RFONT_LARGE                                      1
        #define /*byte FONT_12x24;*/ B4RFONT_12x24                                      0
        #define /*byte FONT_9x17;*/  B4RFONT_9x17                                       1                          

//enum {

        #define /*byte ALIGN_LEFT;*/    B4RALIGN_LEFT                                    0x30        
        #define /*byte ALIGN_CENTER;*/  B4RALIGN_CENTER                                  0x31        
        #define /*byte ALIGN_RIGHT;*/   B4RALIGN_RIGHT                                   0x32                        

//enum {

        #define /*byte BARCODE_TEXT_NONE;*/    B4RBARCODE_TEXT_NONE                      0x30        
        #define /*byte BARCODE_TEXT_ABOVE;*/   B4RBARCODE_TEXT_ABOVE                     0x31        
        #define /*byte BARCODE_TEXT_BELOW;*/   B4RBARCODE_TEXT_BELOW                     0x32  
        #define /*byte BARCODE_TEXT_BOTH;*/    B4RBARCODE_TEXT_BOTH                      0x33             

//enum {

        #define /*byte   BARCODE_UPCA;*/                    B4RBARCODE_UPCA                  0
        #define /*byte   BARCODE_UPCE;*/                    B4RBARCODE_UPCE                  0x01
        #define /*byte   BARCODE_EAN13;*/                   B4RBARCODE_EAN13                 0x02
        #define /*byte   BARCODE_EAN8;*/                    B4RBARCODE_EAN8                  0x03
        #define /*byte   BARCODE_CODE39;*/                  B4RBARCODE_CODE39                0x04
        #define /*byte   BARCODE_ITF;*/                     B4RBARCODE_ITF                   0x05
        #define /*byte   BARCODE_CODABAR;*/                 B4RBARCODE_CODABAR               0x06
        #define /*byte   BARCODE_CODE93;*/                  B4RBARCODE_CODE93                0x48
        #define /*byte   BARCODE_CODE128;*/                 B4RBARCODE_CODE128               0x49
        #define /*byte   BARCODE_GS1_128;*/                 B4RBARCODE_GS1_128               0x50
        #define /*byte   BARCODE_GS1_DATABAR_OMNI;*/        B4RBARCODE_GS1_DATABAR_OMNI      0x51
        #define /*byte   BARCODE_GS1_DATABAR_TRUNCATED;*/   B4RBARCODE_GS1_DATABAR_TRUNCATED 0x52
        #define /*byte   BARCODE_GS1_DATABAR_LIMITED;*/     B4RBARCODE_GS1_DATABAR_LIMITED   0x53
        #define /*byte   BARCODE_GS1_DATABAR_EXPANDED;*/    B4RBARCODE_GS1_DATABAR_EXPANDED  0x54
        #define /*byte   BARCODE_CODE128_AUTO;*/            B4RBARCODE_CODE128_AUTO          0x55

//enum {

        #define /*byte   PRINTER_MTP2;*/          B4RPRINTER_MTP2         0
        #define /*byte   PRINTER_MTP3;*/          B4RPRINTER_MTP3         1
        #define /*byte   PRINTER_CAT;*/           B4RPRINTER_CAT          2
        #define /*byte   PRINTER_PERIPAGEPLUS;*/  B4RPRINTER_PERIPAGEPLUS 3
        #define /*byte   PRINTER_PERIPAGE;*/      B4RPRINTER_PERIPAGE     4
        #define /*byte   PRINTER_FOMEMO;*/        B4RPRINTER_FOMEMO       5
        #define /*byte   PRINTER_COUNT;*/         B4RPRINTER_COUNT        6
    };
}
