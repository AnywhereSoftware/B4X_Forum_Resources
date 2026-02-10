#include "B4RDefines.h"
#include "rAda_NeoPixel.h"

using namespace B4R;

void B4RAda_NeoPixel::Initialize(uint16_t NumberOfPixels, uint8_t Pin, uint32_t PixelType) {
    strip = new Adafruit_NeoPixel(NumberOfPixels, Pin, PixelType);
}

void B4RAda_NeoPixel::Begin() {
    if (strip) strip->begin();
}

void B4RAda_NeoPixel::Show() {
    if (strip) strip->show();
}

void B4RAda_NeoPixel::Clear() {
    if (strip) strip->clear();
}

void B4RAda_NeoPixel::SetPixelColor(uint16_t Index, uint8_t Red, uint8_t Green, uint8_t Blue) {
    if (strip) strip->setPixelColor(Index, Red, Green, Blue);
}

void B4RAda_NeoPixel::SetPixelColorW(uint16_t Index, uint8_t Red, uint8_t Green, uint8_t Blue, uint8_t White) {
    if (strip) strip->setPixelColor(Index, Red, Green, Blue, White);
}

void B4RAda_NeoPixel::SetPixelColorPacked(uint16_t Index, uint32_t Colour) {
    if (strip) strip->setPixelColor(Index, Colour);
}

void B4RAda_NeoPixel::Fill(uint32_t Colour, uint16_t First, uint16_t Count) {
    if (strip) strip->fill(Colour, First, Count);
}

void B4RAda_NeoPixel::SetBrightness(uint8_t Brightness) {
    if (strip) strip->setBrightness(Brightness);
}

uint8_t B4RAda_NeoPixel::GetBrightness() {
    return strip ? strip->getBrightness() : 0;
}

uint32_t B4RAda_NeoPixel::GetPixelColor(uint16_t Index) {
    return strip ? strip->getPixelColor(Index) : 0;
}

uint16_t B4RAda_NeoPixel::GetNumPixels() {
    return strip ? strip->numPixels() : 0;
}

// Static constant accessors
uint32_t B4RAda_NeoPixel::Neo_GRB()    { return NEO_GRB; }
uint32_t B4RAda_NeoPixel::Neo_RGB()    { return NEO_RGB; }
uint32_t B4RAda_NeoPixel::Neo_KHZ800() { return NEO_KHZ800; }
uint32_t B4RAda_NeoPixel::Neo_KHZ400() { return NEO_KHZ400; }

void B4RAda_NeoPixel::MovePixel(uint16_t From, uint16_t To) {
    if (!strip) return;
    if (From >= strip->numPixels() || To >= strip->numPixels()) return;

    uint32_t colour = strip->getPixelColor(From);
    strip->setPixelColor(From, 0);
    strip->setPixelColor(To, colour);
}

void B4RAda_NeoPixel::AnimatePixelColor(uint16_t Start, uint16_t Finish, uint32_t Colour, uint16_t DelayMs) {
    if (!strip) return;

    uint16_t count = strip->numPixels();
    if (Start >= count || Finish >= count) return;

    int step = (Start <= Finish) ? 1 : -1;

    for (int i = Start; i != (int)Finish; i += step) {
        strip->setPixelColor(i, Colour);
        strip->show();
        delay(DelayMs);

        strip->setPixelColor(i, 0);
        strip->show();

        delay(1);
    }

    strip->setPixelColor(Finish, Colour);
    strip->show();
}

uint32_t B4RAda_NeoPixel::SetRGB(uint8_t Red, uint8_t Green, uint8_t Blue) {
    // Pack RGB into 0x00RRGGBB
    return ((uint32_t)Red << 16) | ((uint32_t)Green << 8) | Blue;
}
