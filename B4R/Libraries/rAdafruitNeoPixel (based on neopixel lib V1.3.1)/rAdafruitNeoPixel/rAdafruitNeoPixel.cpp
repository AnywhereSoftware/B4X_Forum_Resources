#include "B4RDefines.h"
namespace B4R {
	void B4RAdafruitNeoPixel::Initialize(UInt NumberOfLEDs, Byte PinNumber, UInt LEDType) {
		pixel = new(be) Adafruit_NeoPixel(NumberOfLEDs, PinNumber, LEDType);
		pixel->begin();
	}
	void B4RAdafruitNeoPixel::SetPixelColor(UInt N, Byte R, Byte G, Byte B) {
		pixel->setPixelColor(N, R, G, B);
	}
    void B4RAdafruitNeoPixel::SetPixelColor3(UInt N,ULong C) {
        pixel->setPixelColor(N, C);
    }
	void B4RAdafruitNeoPixel::SetPixelColor2(UInt N, Byte R, Byte G, Byte B, Byte W) {
		pixel->setPixelColor(N, R, G, B, W);
	
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
    ULong B4RAdafruitNeoPixel::getPixelColor(UInt n){
        pixel->getPixelColor(n);
    }
    Byte B4RAdafruitNeoPixel::getBrightness(void){
        pixel->getBrightness();
    }     
}