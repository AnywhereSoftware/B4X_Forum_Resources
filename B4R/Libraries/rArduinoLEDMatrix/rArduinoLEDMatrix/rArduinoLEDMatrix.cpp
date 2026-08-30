#include "B4RDefines.h"
// #include "rArduinoLEDMatrix.h"

namespace B4R {

    // Standard 5x7 Pixel Font (ASCII 32 to 90)
    static const uint8_t font5x7[59][5] = {
        {0x00, 0x00, 0x00, 0x00, 0x00}, // Space (32)
        {0x00, 0x00, 0x5F, 0x00, 0x00}, // !
        {0x00, 0x07, 0x00, 0x07, 0x00}, // "
        {0x14, 0x7F, 0x14, 0x7F, 0x14}, // #
        {0x24, 0x2A, 0x7F, 0x2A, 0x12}, // $
        {0x23, 0x13, 0x08, 0x64, 0x62}, // %
        {0x36, 0x49, 0x55, 0x22, 0x50}, // &
        {0x00, 0x05, 0x03, 0x00, 0x00}, // '
        {0x00, 0x1C, 0x22, 0x41, 0x00}, // (
        {0x00, 0x41, 0x22, 0x1C, 0x00}, // )
        {0x14, 0x08, 0x3E, 0x08, 0x14}, // *
        {0x08, 0x08, 0x3E, 0x08, 0x08}, // +
        {0x00, 0x50, 0x30, 0x00, 0x00}, // ,
        {0x08, 0x08, 0x08, 0x08, 0x08}, // -
        {0x00, 0x60, 0x60, 0x00, 0x00}, // .
        {0x20, 0x10, 0x08, 0x04, 0x02}, // /
        {0x3E, 0x51, 0x49, 0x45, 0x3E}, // 0
        {0x00, 0x42, 0x7F, 0x40, 0x00}, // 1
        {0x42, 0x61, 0x51, 0x49, 0x46}, // 2
        {0x21, 0x41, 0x45, 0x4B, 0x31}, // 3
        {0x18, 0x14, 0x12, 0x7F, 0x10}, // 4
        {0x27, 0x45, 0x45, 0x45, 0x39}, // 5
        {0x3C, 0x4A, 0x49, 0x49, 0x30}, // 6
        {0x01, 0x71, 0x09, 0x05, 0x03}, // 7
        {0x36, 0x49, 0x49, 0x49, 0x36}, // 8
        {0x06, 0x49, 0x49, 0x29, 0x1E}, // 9
        {0x36, 0x36, 0x00, 0x00, 0x00}, // :
        {0x56, 0x36, 0x00, 0x00, 0x00}, // ;
        {0x08, 0x14, 0x22, 0x41, 0x00}, // <
        {0x24, 0x24, 0x24, 0x24, 0x24}, // =
        {0x00, 0x41, 0x22, 0x14, 0x08}, // >
        {0x02, 0x01, 0x51, 0x09, 0x06}, // ?
        {0x32, 0x49, 0x79, 0x41, 0x3E}, // @
        {0x7E, 0x11, 0x11, 0x11, 0x7E}, // A
        {0x7F, 0x49, 0x49, 0x49, 0x36}, // B
        {0x3E, 0x41, 0x41, 0x41, 0x22}, // C
        {0x7F, 0x41, 0x41, 0x22, 0x1C}, // D
        {0x7F, 0x49, 0x49, 0x49, 0x41}, // E
        {0x7F, 0x09, 0x09, 0x09, 0x01}, // F
        {0x3E, 0x41, 0x49, 0x49, 0x7A}, // G
        {0x7F, 0x08, 0x08, 0x08, 0x7F}, // H
        {0x00, 0x41, 0x7F, 0x41, 0x00}, // I
        {0x20, 0x40, 0x41, 0x3F, 0x01}, // J
        {0x7F, 0x08, 0x14, 0x22, 0x41}, // K
        {0x7F, 0x40, 0x40, 0x40, 0x40}, // L
        {0x7F, 0x02, 0x0C, 0x02, 0x7F}, // M
        {0x7F, 0x04, 0x08, 0x10, 0x7F}, // N
        {0x3E, 0x41, 0x41, 0x41, 0x3E}, // O
        {0x7F, 0x09, 0x09, 0x09, 0x06}, // P
        {0x3E, 0x41, 0x51, 0x21, 0x5E}, // Q
        {0x7F, 0x09, 0x19, 0x29, 0x46}, // R
        {0x46, 0x49, 0x49, 0x49, 0x31}, // S
        {0x01, 0x01, 0x7F, 0x01, 0x01}, // T
        {0x3F, 0x40, 0x40, 0x40, 0x3F}, // U
        {0x1F, 0x20, 0x40, 0x20, 0x1F}, // V
        {0x3F, 0x40, 0x38, 0x40, 0x3F}, // W
        {0x63, 0x14, 0x08, 0x14, 0x63}, // X
        {0x07, 0x08, 0x70, 0x08, 0x07}, // Y
        {0x61, 0x51, 0x49, 0x45, 0x43}  // Z
    };

    void B4RArduinoLEDMatrix::Initialize() {
        matrixInstance.begin(); 
        Clear();
    }

    void B4RArduinoLEDMatrix::SetPixel(Byte X, Byte Y, Byte TurnOn) {
        if (X >= 12 || Y >= 8) return;
        targetFrame[Y][X] = (TurnOn > 0) ? 1 : 0; // Fixed structural type evaluation snippet
        matrixInstance.renderBitmap(targetFrame, 8, 12);
    }

    void B4RArduinoLEDMatrix::Clear() {
        memset(targetFrame, 0, sizeof(targetFrame));
        matrixInstance.renderBitmap(targetFrame, 8, 12);
    }

    void B4RArduinoLEDMatrix::DrawFrame(ArrayByte* FrameData) {
        if (FrameData == NULL || FrameData->length < 96) return;
        Byte* data = (Byte*)FrameData->data;
        
        int index = 0;
        for (int y = 0; y < 8; y++) {
            for (int x = 0; x < 12; x++) {
                targetFrame[y][x] = (data[index] > 0) ? 1 : 0;
                index++;
            }
        }
        matrixInstance.renderBitmap(targetFrame, 8, 12);
    }

    void B4RArduinoLEDMatrix::PrintText(B4RString* Text, Int X, Int Y, Byte Direction, ULong ScrollSpeedMS) {
        if (Text == NULL || Text->data == NULL) return;
        
        matrixInstance.beginDraw();
        
        // FIX 1: Only wipe the canvas for STATIC text layouts.
        // Clearing during an active native scroll loop causes flickering/blank frames.
        if (Direction == 0) {
            matrixInstance.clear(); 
        }
        
        matrixInstance.stroke(0xFFFFFFFF); 
        matrixInstance.textFont(Font_5x7); 
        matrixInstance.textScrollSpeed(ScrollSpeedMS);
        
        matrixInstance.beginText(X, Y, 0xFFFFFF);
        
        // FIX 2: Use println() instead of print() as demonstrated in the official example.
        // This ensures the layout engine applies the proper string termination spacing,
        // removing the artifact borders ("|") around your static text.
        matrixInstance.println(Text->data); 
        
        if (Direction == 1) {
            matrixInstance.endText(SCROLL_LEFT);
        } else if (Direction == 2) {
            matrixInstance.endText(SCROLL_RIGHT);
        } else {
            matrixInstance.endText(); 
        }
        
        matrixInstance.endDraw();
    }

    // Draws a line from (X1, Y1) to (X2, Y2)
    void B4RArduinoLEDMatrix::DrawLine(Int X1, Int Y1, Int X2, Int Y2, Byte TurnOn) {
        matrixInstance.beginDraw();
        matrixInstance.clear(); // CRITICAL FIX: Wipes the canvas clean first!
        matrixInstance.stroke(TurnOn > 0 ? 0xFFFFFFFF : 0x00000000);
        matrixInstance.line(X1, Y1, X2, Y2);
        matrixInstance.endDraw();
    }

    // Draws an empty rectangle from starting position
    void B4RArduinoLEDMatrix::DrawRect(Int X, Int Y, Int Width, Int Height, Byte TurnOn) {
        matrixInstance.beginDraw();
        matrixInstance.clear(); // CRITICAL FIX: Wipes the canvas clean first!
        matrixInstance.stroke(TurnOn > 0 ? 0xFFFFFFFF : 0x00000000);
        matrixInstance.rect(X, Y, Width, Height);
        matrixInstance.endDraw();
    }

    // Draws an empty circle boundary centered at (X, Y)
    void B4RArduinoLEDMatrix::DrawCircle(Int X, Int Y, Int Radius, Byte TurnOn) {
        matrixInstance.beginDraw();
        matrixInstance.clear(); // CRITICAL FIX: Wipes the canvas clean first!
        matrixInstance.stroke(TurnOn > 0 ? 0xFFFFFFFF : 0x00000000);
        matrixInstance.circle(X, Y, Radius);
        matrixInstance.endDraw();
    }

	void B4RArduinoLEDMatrix::LoadFrame(ULong FrameAddress) {
        if (FrameAddress == 0) return;
        
        // Re-interpret the numeric address back to the required const uint32_t pointer
        const uint32_t* framePtr = (const uint32_t*)FrameAddress;
        
        matrixInstance.loadFrame(framePtr); 
    }	

	// Icons from gallery.h
	ULong B4RArduinoLEDMatrix::ICON_BLUETOOTH()     { return (ULong)LEDMATRIX_BLUETOOTH; }
    ULong B4RArduinoLEDMatrix::ICON_BOOTLOADER_ON()  { return (ULong)LEDMATRIX_BOOTLOADER_ON; }
    ULong B4RArduinoLEDMatrix::ICON_CHIP()          { return (ULong)LEDMATRIX_CHIP; }
    ULong B4RArduinoLEDMatrix::ICON_CLOUD_WIFI()     { return (ULong)LEDMATRIX_CLOUD_WIFI; }
    ULong B4RArduinoLEDMatrix::ICON_DANGER()        { return (ULong)LEDMATRIX_DANGER; }
    ULong B4RArduinoLEDMatrix::ICON_EMOJI_BASIC()    { return (ULong)LEDMATRIX_EMOJI_BASIC; }
    ULong B4RArduinoLEDMatrix::ICON_EMOJI_HAPPY()    { return (ULong)LEDMATRIX_EMOJI_HAPPY; }
    ULong B4RArduinoLEDMatrix::ICON_EMOJI_SAD()      { return (ULong)LEDMATRIX_EMOJI_SAD; }
    ULong B4RArduinoLEDMatrix::ICON_HEART_BIG()      { return (ULong)LEDMATRIX_HEART_BIG; }
    ULong B4RArduinoLEDMatrix::ICON_HEART_SMALL()    { return (ULong)LEDMATRIX_HEART_SMALL; }
    ULong B4RArduinoLEDMatrix::ICON_LIKE()          { return (ULong)LEDMATRIX_LIKE; }
    ULong B4RArduinoLEDMatrix::ICON_MUSIC_NOTE()     { return (ULong)LEDMATRIX_MUSIC_NOTE; }
	
	/**
	 * CUSTOM FUNCTIONS
	 */

    // Direct extraction via text pointer allocation maps
    void B4RArduinoLEDMatrix::ScrollText(B4RString* Text, ULong SpeedMS) {
        if (Text == NULL || Text->data == NULL) return;
        
        const char* str = Text->data;
        int strLen = strlen(str);
        if (strLen == 0) return;

        int totalColumns = strLen * 6;

        for (int shift = 0; shift < totalColumns + 12; shift++) {
            memset(targetFrame, 0, sizeof(targetFrame));

            for (int displayX = 0; displayX < 12; displayX++) {
                int virtualX = shift + displayX - 12;
                
                if (virtualX >= 0 && virtualX < totalColumns) {
                    int charIndex = virtualX / 6;
                    int colIndex = virtualX % 6;

                    if (colIndex < 5) {
                        char c = str[charIndex];
                        if (c >= 'a' && c <= 'z') c -= 32; 
                        
                        if (c >= 32 && c <= 90) {
                            uint8_t fontColumnData = font5x7[c - 32][colIndex];
                            
                            for (int y = 0; y < 7; y++) {
                                if ((fontColumnData >> y) & 0x01) {
                                    targetFrame[y + 1][displayX] = 1; 
                                }
                            }
                        }
                    }
                }
            }

            matrixInstance.renderBitmap(targetFrame, 8, 12);
            delay(SpeedMS);
        }
    }
}
