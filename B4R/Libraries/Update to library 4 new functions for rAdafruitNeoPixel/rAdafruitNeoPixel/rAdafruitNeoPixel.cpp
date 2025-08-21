#include "B4RDefines.h"
#include "HardwareSerial.h"



namespace B4R {
//	extern HardwareSerial Serial;

	void B4RAdafruitNeoPixel::Initialize(UInt NumberOfLEDs, Byte PinNumber, UInt LEDType) {
//		Serial.begin(115200);

		pixel = new(be) Adafruit_NeoPixel(NumberOfLEDs, PinNumber, LEDType);
		pixel->begin();
	}
	void B4RAdafruitNeoPixel::SetPixelColor(UInt N, Byte R, Byte G, Byte B) {
		if  (N >= 0 && N < pixel->numPixels()) {
			pixel->setPixelColor(N, R, G, B);
			return;
		}
	}
    void B4RAdafruitNeoPixel::SetPixelColor3(UInt N,ULong C) {
		if  (N >= 0 && N < pixel->numPixels()) {
			pixel->setPixelColor(N, C);
			return;
		}
    }
	void B4RAdafruitNeoPixel::SetPixelColor2(UInt N, Byte R, Byte G, Byte B, Byte W) {
		if  (N >= 0 && N < pixel->numPixels()) {
			pixel->setPixelColor(N, R, G, B, W);
			return;
		}
	}
	void B4RAdafruitNeoPixel::SetBrightness (Byte Level) {
		pixel->setBrightness(Level);
	}
	void B4RAdafruitNeoPixel::Show() {
		pixel->show();
	}
	void B4RAdafruitNeoPixel::Clear() {
		pixel->clear();
	}
  	ULong B4RAdafruitNeoPixel::ColorHSV(UInt hue) {
		pixel->ColorHSV(hue);
    }
	ULong B4RAdafruitNeoPixel::ColorHSV2(UInt hue, Byte sat, byte val) {
		pixel->ColorHSV(hue, sat, val);
    }
    ULong B4RAdafruitNeoPixel::Gamma32(ULong x){
        pixel->gamma32(x);
    }
    void  B4RAdafruitNeoPixel::fill(ULong c, Byte first, Byte count){
        pixel->fill(c, first, count);
    }
    ULong B4RAdafruitNeoPixel::getPixelColor(UInt N){
		if  (N >= 0 && N < pixel->numPixels()) {
			return pixel->getPixelColor(N);
		}

		return 0;
    }
    Byte B4RAdafruitNeoPixel::getBrightness(void){
        pixel->getBrightness();
    }     

    void B4RAdafruitNeoPixel::MovePixelColorDirect(UInt to, UInt from){
		if  (from != to && from >= 0 && from < pixel->numPixels() && to >= 0 && to < pixel->numPixels()) {
			pixel->movePixelColorDirect(to, from);
		}
    }

    ULong B4RAdafruitNeoPixel::GetPixelColorDirect(UInt N){
		if  (N >= 0 && N < pixel->numPixels()) {
			return pixel->getPixelColorDirect(N);
		}
    }

    void B4RAdafruitNeoPixel::SetPixelColorDirect3(UInt N,ULong C) {
		if  (N >= 0 && N < pixel->numPixels()) {
			pixel->setPixelColorDirect(N, C);
			return;
		}
    }

	void B4RAdafruitNeoPixel::SetPixelColorDirect(UInt N, Byte R, Byte G, Byte B) {
		if  (N >= 0 && N < pixel->numPixels()) {
			pixel->setPixelColorDirect(N, R, G, B);
			return;
		}
	}


}