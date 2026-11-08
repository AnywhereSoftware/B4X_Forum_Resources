// B4R Library rTM1637EX
#include "B4RDefines.h"
namespace B4R {
	
	void B4RTM1637Display::Initialize(Byte PinClk, Byte PinDIO) {
		display = new (beTM1637Display) TM1637Display(PinClk, PinDIO);
		display->setBrightness(0x0f);
	}

  void B4RTM1637Display::SetBrightness(Byte brightness, bool on){
		display->setBrightness(brightness, on);
  }

	void B4RTM1637Display::SetSegments(ArrayByte* Segments, Byte Position) {
		display->setSegments((Byte*)Segments->data, Segments->length, Position);
	}

	void B4RTM1637Display::ShowNumberDec(Int Number) {
		ShowNumberDec2(Number, false, 4, 0);
	}

	void B4RTM1637Display::ShowNumberDec2(Int Number, bool LeadingZero, Byte Length, Byte Position) {
		display->showNumberDec(Number, LeadingZero, Length, Position);
	}

	void B4RTM1637Display::ShowNumberDec3(Int Number, bool LeadingZero, Byte Length, Byte Position, Byte DotsMask) {
		display->showNumberDecEx(Number, DotsMask, LeadingZero, Length, Position);
	}

	void B4RTM1637Display::Clear() {
		uint8_t data[] = { 0, 0, 0, 0 };
		display->setSegments(data);
	}

	// #if defined(ARDUINO) && ARDUINO >= 100 

	// Get a char as byte from the font char table by its ascii dec index 0-127
	// Two fonts: ascii and siekoo
	Byte B4RTM1637Display::GetChar(Int Index, Byte Font) {
		byte b = 0;
		if (Font == B4RTM1637Display_FONT_ASCII) {
			b = AscIICharTable[Index];
		}
		else if (Font == B4RTM1637Display_FONT_SIEKOO) {
			b = SiekooCharTable[Index];
		}
		else {
			b = AscIICharTable[Index];			
		}
		return b;
	}
	
	// Show text - max 4 chars from font char table 
	void B4RTM1637Display::ShowText(B4RString* Text, Byte Position, Byte Font) {
		char* textString = (char*)Text->data; 
		uint8_t seg[] = {0,0,0,0};
		for(int i =0; i < strlen(textString); i++ ) {
			char c = textString[i];
			int index = c;
			Byte b = GetChar(index, Font);
			seg[i] = b;
		}
		display->setSegments(seg, strlen(textString), Position);
	}

	// #endif
}

