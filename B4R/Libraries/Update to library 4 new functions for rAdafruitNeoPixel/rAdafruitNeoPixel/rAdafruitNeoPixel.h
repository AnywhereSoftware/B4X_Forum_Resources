#pragma once
#include "B4RDefines.h"
#include "Adafruit_NeoPixel.h"
//~version: 1.05
namespace B4R {
	//~shortname: AdafruitNeoPixel
	class B4RAdafruitNeoPixel {
		private:
			uint8_t be[sizeof(Adafruit_NeoPixel)];
			Adafruit_NeoPixel* pixel;
		public:
			//Initializes the object.
			//LEDType should be one of the NEO constants. Add 0x100 to indicate a 400 KHZ device.
			void Initialize(UInt NumberOfLEDs, Byte PinNumber, UInt LEDType);
			void SetPixelColor(UInt N, Byte R, Byte G, Byte B);
			void SetPixelColor2(UInt N, Byte R, Byte G, Byte B, Byte W);
            void SetPixelColor3(UInt N, ULong C);
			void SetBrightness (Byte Level);
            ULong ColorHSV(UInt hue);
            //Convert hue, saturation and value into a packed 32-bit RGB color
            //that can be passed to setPixelColor() or other RGB-compatible
            //functions.
            ULong ColorHSV2(UInt hue, Byte sat, Byte val);
            ULong Gamma32(ULong x);
            void  fill(ULong c=0, Byte first=0, Byte count=0);

            void  MovePixelColorDirect(UInt to, UInt from);
			ULong GetPixelColorDirect(UInt n);
			void  SetPixelColorDirect3(UInt n, ULong c);
			void SetPixelColorDirect(UInt N, Byte R, Byte G, Byte B);


            ULong getPixelColor(UInt n);
            //Retrieve the last-set brightness value for the strip.
            Byte  getBrightness(void);
			//Sends the updated colors to the hardware.
			void Show();
			void Clear();
			#define /*UInt NEO_RGB;*/ B4RAdafruitNeoPixel_NEO_RGB NEO_RGB 
			#define /*UInt NEO_RBG;*/ B4RAdafruitNeoPixel_NEO_RBG NEO_RBG 
			#define /*UInt NEO_GRB;*/ B4RAdafruitNeoPixel_NEO_GRB NEO_GRB 
			#define /*UInt NEO_GBR;*/ B4RAdafruitNeoPixel_NEO_GBR NEO_GBR 
            #define /*UInt NEO_BRG;*/ B4RAdafruitNeoPixel_NEO_BRG NEO_BRG 
            #define /*UInt NEO_BGR;*/ B4RAdafruitNeoPixel_NEO_BGR NEO_BGR 
            
            #define /*UInt NEO_WRGB;*/ B4RAdafruitNeoPixel_NEO_WRGB NEO_WRGB
            #define /*UInt NEO_WRBG;*/ B4RAdafruitNeoPixel_NEO_WRBG NEO_WRBG
            #define /*UInt NEO_WGRB;*/ B4RAdafruitNeoPixel_NEO_WGRB NEO_WGRB
            #define /*UInt NEO_WGBR;*/ B4RAdafruitNeoPixel_NEO_WGBR NEO_WGBR
            #define /*UInt NEO_WBRG;*/ B4RAdafruitNeoPixel_NEO_WBRG NEO_WBRG
            #define /*UInt NEO_WBGR;*/ B4RAdafruitNeoPixel_NEO_WBGR NEO_WBGR
            
            #define /*UInt NEO_RWGB;*/ B4RAdafruitNeoPixel_NEO_RWGB NEO_RWGB
            #define /*UInt NEO_RWBG;*/ B4RAdafruitNeoPixel_NEO_RWBG NEO_RWBG
            #define /*UInt NEO_RGWB;*/ B4RAdafruitNeoPixel_NEO_RGWB NEO_RGWB
            #define /*UInt NEO_RGBW;*/ B4RAdafruitNeoPixel_NEO_RGBW NEO_RGBW
            #define /*UInt NEO_RBWG;*/ B4RAdafruitNeoPixel_NEO_RBWG NEO_RBWG
            #define /*UInt NEO_RBGW;*/ B4RAdafruitNeoPixel_NEO_RBGW NEO_RBGW
            
            #define /*UInt NEO_GWRB;*/ B4RAdafruitNeoPixel_NEO_GWRB NEO_GWRB
            #define /*UInt NEO_GWBR;*/ B4RAdafruitNeoPixel_NEO_GWBR NEO_GWBR
            #define /*UInt NEO_GRWB;*/ B4RAdafruitNeoPixel_NEO_GRWB NEO_GRWB
            #define /*UInt NEO_GRBW;*/ B4RAdafruitNeoPixel_NEO_GRBW NEO_GRBW
            #define /*UInt NEO_GBWR;*/ B4RAdafruitNeoPixel_NEO_GBWR NEO_GBWR
            #define /*UInt NEO_GBRW;*/ B4RAdafruitNeoPixel_NEO_GBRW NEO_GBRW
            
            #define /*UInt NEO_BWRG;*/ B4RAdafruitNeoPixel_NEO_BWRG NEO_BWRG
            #define /*UInt NEO_BWGR;*/ B4RAdafruitNeoPixel_NEO_BWGR NEO_BWGR
            #define /*UInt NEO_BRWG;*/ B4RAdafruitNeoPixel_NEO_BRWG NEO_BRWG
            #define /*UInt NEO_BRGW;*/ B4RAdafruitNeoPixel_NEO_BRGW NEO_BRGW
            #define /*UInt NEO_BGWR;*/ B4RAdafruitNeoPixel_NEO_BGWR NEO_BGWR
            #define /*UInt NEO_BGRW;*/ B4RAdafruitNeoPixel_NEO_BGRW NEO_BGRW
	};
}