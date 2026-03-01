#ifndef rAda_NeoPixel_h
#define rAda_NeoPixel_h

#include "Arduino.h"
#include "Adafruit_NeoPixel.h"

namespace B4R {

    class B4RAda_NeoPixel {
    private:
        Adafruit_NeoPixel* strip = nullptr;

    public:
        // Initialization
        void Initialize(uint16_t NumberOfPixels, uint8_t Pin, uint32_t PixelType);

        // Core control
        void Begin();
        void Show();
        void Clear();

        // Pixel control
        void SetPixelColor(uint16_t Index, uint8_t Red, uint8_t Green, uint8_t Blue);
        void SetPixelColorW(uint16_t Index, uint8_t Red, uint8_t Green, uint8_t Blue, uint8_t White);
        void SetPixelColorPacked(uint16_t Index, uint32_t Colour);
        void MovePixel(uint16_t From, uint16_t To);
        void AnimatePixelColor(uint16_t Start, uint16_t Finish, uint32_t Colour, uint16_t DelayMs);
        uint32_t DimPixel(uint32_t Colour, uint8_t Percent);
        void FadePixel(uint16_t Index, uint32_t Colour, uint16_t Steps, uint16_t DelayMs);

        // Set colors
        uint32_t SetRGB(uint8_t Red, uint8_t Green, uint8_t Blue);
        uint32_t SetRGBW(uint8_t Red, uint8_t Green, uint8_t Blue, uint8_t White);

        // Scroll text
        void ScrollText(B4RString* Text, uint32_t Colour, uint16_t SpeedMs);

        // Bulk
        void Fill(uint32_t Colour, uint16_t First, uint16_t Count);

        // Brightness
        void SetBrightness(uint8_t Brightness);
        uint8_t GetBrightness();

        // Queries
        uint32_t GetPixelColor(uint16_t Index);
        uint16_t GetNumPixels();

        // Color helpers (Static to prevent bootloops)
        static uint32_t Neo_GRB();
        static uint32_t Neo_RGB();
        static uint32_t Neo_KHZ800();
        static uint32_t Neo_KHZ400();

    };

}

#endif
