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

        void MovePixel(uint16_t From, uint16_t To);
        void AnimatePixelColor(uint16_t Start, uint16_t Finish, uint32_t Colour, uint16_t DelayMs);

        // Pack RGB into a 32-bit colour
        uint32_t SetRGB(uint8_t Red, uint8_t Green, uint8_t Blue);
    };

}

#endif
