#include "B4RDefines.h"

namespace B4R
{
	void B4RLOVYANGFXEX::Initialize(SubVoidTouch TouchSub)
	{
		// Check if driver is set
		#if defined(UNKNOWN_DRIVER)
			::Serial.println("[ERROR] Display driver not found!");
		#endif

		#if defined(ESP32_2432S028)
			::Serial.println("Display Driver: ESP32_2432S028");
			gfx = new (be) LGFX;
			// Init the RGB LED (positioned on the back of the device)
			pinMode(this->redPin, OUTPUT);              
			pinMode(this->greenPin, OUTPUT);
			pinMode(this->bluePin, OUTPUT);
		#endif

		#if defined(ESP32_SSD1306)
			::Serial.println("Display Driver: ESP32_SSD1306");
			gfx = new (be) SSD1306;
		#endif
		
		#if defined(ESP32_SSD1306_WIFIKITV3)
			::Serial.println("Display Driver: ESP32_SSD1306_WIFIKITV3");
			gfx = new (be) SSD1306;
		#endif
		
		#if defined(ESP32_SH110x)
			::Serial.println("Display Driver: ESP32_SH110x");
			gfx = new (be) SH110x;
		#endif
		
		// Init the display instance.
		gfx->init();
		
		// Short delay to let init complete.
		delay(100);  
				
		// Set display rotation default to 0
		gfx->setRotation(0);
		
		// Set color depth to 24 bits for RGB888.
		// Actual number of colors displayed may be 18 bits (RGB666) depending display hardware.
		gfx->setColorDepth(24);		

		// Set the default background color
		backgroundColor = B4RLOVYANGFXEX_COLOR_BLACK;
		gfx->fillScreen(backgroundColor);

		// Set the brightness to max
		selectedBrightness = 255;
		gfx->setBrightness(selectedBrightness);

		// Set the default font (FONT0)
		selectedFont = FONT_DEFAULT;
		gfx->setFont(&Font0);

		// Check if touch event is set to assign the B4R touch event
		if (TouchSub != NULL) {
			::Serial.println("Touch: Enabled");
			// Assign the touch event
			this->TouchSub = TouchSub;
			FunctionUnion fu;
			fu.PollerFunction = Looper;
			pnode.functionUnion = fu;
			pnode.tag = this;
			if (pnode.next == NULL) {
				pollers.add(&pnode);
			}			
		}
	}

	ULong B4RLOVYANGFXEX::Height()
	{
		return (uint32_t)gfx->height();
	}

	ULong B4RLOVYANGFXEX::Width()
	{
		return (uint32_t)gfx->width();
	}

	ULong B4RLOVYANGFXEX::CenterX()
	{
		return (uint32_t)gfx->width() / 2;
	}

	ULong B4RLOVYANGFXEX::CenterY()
	{
		return (uint32_t)gfx->height() / 2;
	}

	void B4RLOVYANGFXEX::Clear()
	{
		gfx->clear();
	}

	void B4RLOVYANGFXEX::ClearSetColor(ULong color)
	{
		gfx->clear((uint32_t) color);
	}

	void B4RLOVYANGFXEX::ClearArea(Long x, Long y, Long w, Long h, ULong color)
	{
		gfx->fillRect(x, y, w, h, color);
	}
	
	void B4RLOVYANGFXEX::setDisplayRotation(Byte direction)
	{
		gfx->setRotation( (int_fast8_t) direction);
	}

	Byte B4RLOVYANGFXEX::getDisplayRotation()
	{
		return (Byte) gfx->getRotation();
	}

	void B4RLOVYANGFXEX::SetColorDepth(int bits)
	{
		if (bits != 16 || bits != 24) { bits = 16; }
		gfx->setColorDepth(bits);
	}

	void B4RLOVYANGFXEX::setBrightness(Byte brightness)
	{
		selectedBrightness = brightness;
		gfx->setBrightness( (uint8_t) brightness);
	}
	Byte B4RLOVYANGFXEX::getBrightness()
	{
		return selectedBrightness;
	}
		
	void B4RLOVYANGFXEX::FillScreen(ULong color)
	{
		gfx->fillScreen((uint32_t)color);
		backgroundColor = color;
	}

	void B4RLOVYANGFXEX::setBackgroundColor(ULong color)
	{
		gfx->fillScreen((uint32_t)color);
		backgroundColor = color;
	}
	ULong B4RLOVYANGFXEX::getBackgroundColor()
	{
		return backgroundColor;
	}
	
	void B4RLOVYANGFXEX::SetTextColor(ULong color)
	{
		gfx->setTextColor( (uint32_t)color);
	}
	
	void B4RLOVYANGFXEX::SetTextSize(Double size)
	{
		gfx->setTextSize(size);
	}

	void B4RLOVYANGFXEX::SetTextSizeXY(Double sx, Double sy)
	{
		gfx->setTextSize((float)sx, (float)sy);
	}
		
	void B4RLOVYANGFXEX::SetTextDatum(Byte datum)
	{
		gfx->setTextDatum(datum);
	}
	
	void B4RLOVYANGFXEX::SetCursor(ULong x, ULong y)
	{
		gfx->setCursor( (int32_t) x, (int32_t) y);
	}
		
	void B4RLOVYANGFXEX::Print(B4RString* text)
	{
		gfx->print(text->data);
	}

	void B4RLOVYANGFXEX::Println(B4RString* text)
	{
		gfx->println(text->data);
	}

	void B4RLOVYANGFXEX::DrawText(ULong x, ULong y, B4RString* text, Byte textAlignment, double textSize, ULong textColor, ULong backgroundColor)
	{
		// Set text size, center text alignment and text color
		gfx->setTextSize(textSize);
		gfx->setTextDatum(textAlignment);
		gfx->setTextColor(textColor);

		// Check setting backgroundcolor
		if (backgroundColor != COLOR_DEFAULT) {
			// Calculate text bounding rectangle
			int textlen = text->getLength();
			int textWidth = textSize * FONT_HEIGHT_DEFAULT * textlen; // text length by character count
			int textHeight = textSize * FONT_HEIGHT_DEFAULT;

			// Clear the text area by filling it with the background color
			ULong rx = x - (textWidth/2);
			ULong ry = y - (textHeight/2);
			gfx->fillRect((int32_t)rx, (int32_t)ry, textWidth, textHeight,  backgroundColor);
		}

		// Draw the text
		gfx->drawString(text->data, x, y);
	}

	void B4RLOVYANGFXEX::DrawTextFont(ULong x, ULong y, B4RString* text, Byte textFont, Byte textAlignment, double textSize, ULong textColor, ULong backgroundColor)
	{
		B4RLOVYANGFXEX::setFont(textFont);
		B4RLOVYANGFXEX::DrawText(x, y, text, textAlignment, textSize, textColor, backgroundColor);
		B4RLOVYANGFXEX::setFont(FONT_DEFAULT);		
	}

	void B4RLOVYANGFXEX::DrawString(B4RString* text, ULong x, ULong y)
	{
		gfx->drawString(text->data, (int32_t)x, (int32_t)y);
	}

	void B4RLOVYANGFXEX::DrawNumber(Long value, ULong x, ULong y)
	{
		gfx->drawNumber(value, (int32_t)x, (int32_t)y);
	}

	void B4RLOVYANGFXEX::DrawFloat(float value, Byte dp, ULong x, ULong y)
	{
		gfx->drawFloat(value, dp, (int32_t)x, (int32_t)y);
	}

	void B4RLOVYANGFXEX::DrawLeftString(ULong x, ULong y, B4RString* text)
	{
		gfx->drawString(text->data, (int32_t)x, (int32_t)y);
	}
	
	void B4RLOVYANGFXEX::DrawCenterString(ULong x, ULong y, B4RString* text)
	{
		gfx->drawCenterString(text->data, (int32_t)x, (int32_t)y);
	}
	
	void B4RLOVYANGFXEX::DrawRightString(ULong x, ULong y, B4RString* text)
	{
		gfx->drawRightString(text->data, (int32_t)x, (int32_t)y);
	}
		
	UInt B4RLOVYANGFXEX::TextLength(B4RString* text)
	{
		// Get the text length by character count
		UInt textlen = text->getLength();

		// This is another option
		// char* c = (char*)text->data;
		// int textlen = strlen(c);
		return textlen;
	}

	UInt B4RLOVYANGFXEX::TextWidth(B4RString* text)
	{
		return (UInt) gfx->textWidth(text->data);
	}

	UInt B4RLOVYANGFXEX::TextWidthDefault(B4RString* text, double textSize)
	{
		UInt textlen = text->getLength();
		return textlen * textSize * FONT_HEIGHT_DEFAULT;
	}

	UInt B4RLOVYANGFXEX::TextHeight(double textSize)
	{
		return textSize * FONT_HEIGHT_DEFAULT;
	}

	ArrayByte* B4RLOVYANGFXEX::GetTextSize(B4RString* text, Byte font)
	{

		UInt Length = 3;
		Array* arr = CreateStackMemoryObject(Array);
		arr->data = StackMemory::buffer + StackMemory::cp;
		StackMemory::cp += Length;
		arr->length = Length;
		((Byte*)arr->data)[0] = gfx->textWidth(text->data);
		((Byte*)arr->data)[1] = gfx->fontHeight(font);
		((Byte*)arr->data)[2] = text->getLength();
		return arr;
	}

	/**
	* FONT
	*/

	Long B4RLOVYANGFXEX::FontHeight()
	{
		return selectedFontHeight;
	}

	Long B4RLOVYANGFXEX::FontWidth()
	{
		// For some fonts the width is 0, then use textstyle x with size 1
		if (selectedFontWidth == 0) {
			selectedFontWidth = gfx->fontWidth(1);
		}
		return selectedFontWidth;
	}

	ULong B4RLOVYANGFXEX::FontHeightY(Byte font)
	{
		return gfx->fontHeight(font);
	}

	ULong B4RLOVYANGFXEX::FontWidthX(Byte font)
	{
		return gfx->fontWidth(font);
	}

	// Set the font to be used.
	// Important are the class properties selectedFontHeight and Width to determine the selected font size in px.
	// To get the full size in px multiply with fonr or text size.
	void B4RLOVYANGFXEX::setFont(Byte font)
	{
		switch (font) {
			
			selectedFont = font;
			
			case FONT_DEFAULT:
				gfx->setFont(&Font0);
				selectedFontHeight = gfx->fontHeight(&Font0);
				selectedFontWidth = gfx->fontWidth(&Font0);
				break;
			case FONT_FONT0:
				gfx->setFont(&Font0);
				selectedFontHeight = gfx->fontHeight(&Font0);
				selectedFontWidth = gfx->fontWidth(&Font0);
				break;
			case FONT_FONT2:
				gfx->setFont(&Font2);
				selectedFontHeight = gfx->fontHeight(&Font2);
				selectedFontWidth = gfx->fontWidth(&Font2);
				break;
			case FONT_FONT4:
				gfx->setFont(&Font4);
				selectedFontHeight = gfx->fontHeight(&Font4);
				selectedFontWidth = gfx->fontWidth(&Font4);
				break;
			case FONT_FONT6:
				gfx->setFont(&Font6);
				selectedFontHeight = gfx->fontHeight(&Font6);
				selectedFontWidth = gfx->fontWidth(&Font6);
				break;
			case FONT_FONT7:
				gfx->setFont(&Font7);
				selectedFontHeight = gfx->fontHeight(&Font7);
				selectedFontWidth = gfx->fontWidth(&Font7);
				break;
			case FONT_FONT8:
				gfx->setFont(&Font8);
				selectedFontHeight = gfx->fontHeight(&Font8);
				selectedFontWidth = gfx->fontWidth(&Font8);
				break;
			case FONT_FREEMONO_9:
				gfx->setFont(&FreeMono9pt7b);
				selectedFontHeight = gfx->fontHeight(&FreeMono9pt7b);
				selectedFontWidth = gfx->fontWidth(&FreeMono9pt7b);
				break;
			case FONT_FREEMONOBOLD_9:
				gfx->setFont(&FreeMonoBold9pt7b);
				selectedFontHeight = gfx->fontHeight(&FreeMonoBold9pt7b);
				selectedFontWidth = gfx->fontWidth(&FreeMonoBold9pt7b);
				break;
			case FONT_FREEMONO_12:
				gfx->setFont(&FreeMono12pt7b);
				selectedFontHeight = gfx->fontHeight(&FreeMono12pt7b);
				selectedFontWidth = gfx->fontWidth(&FreeMono12pt7b);
				break;
			case FONT_FREEMONOBOLD_12:
				gfx->setFont(&FreeMonoBold12pt7b);
				selectedFontHeight = gfx->fontHeight(&FreeMonoBold12pt7b);
				selectedFontWidth = gfx->fontWidth(&FreeMonoBold12pt7b);
				break;
			case FONT_FREESANS_9:
				gfx->setFont(&FreeSans9pt7b);
				selectedFontHeight = gfx->fontHeight(&FreeSans9pt7b);
				selectedFontWidth = gfx->fontWidth(&FreeSans9pt7b);
				break;
			case FONT_FREESANSBOLD_9:
				gfx->setFont(&FreeSansBold9pt7b);
				selectedFontHeight = gfx->fontHeight(&FreeSansBold9pt7b);
				selectedFontWidth = gfx->fontWidth(&FreeSansBold9pt7b);
				break;
			case FONT_FREESANS_12:
				gfx->setFont(&FreeSans12pt7b);
				selectedFontHeight = gfx->fontHeight(&FreeSans12pt7b);
				selectedFontWidth = gfx->fontWidth(&FreeSans12pt7b);
				break;
			case FONT_FREESANSBOLD_12:
				gfx->setFont(&FreeSansBold12pt7b);
				selectedFontHeight = gfx->fontHeight(&FreeSansBold12pt7b);
				selectedFontWidth = gfx->fontWidth(&FreeSansBold12pt7b);
				break;
			case FONT_TOMTHUMB_1:
				gfx->setFont(&TomThumb);
				selectedFontHeight = gfx->fontHeight(&TomThumb);
				selectedFontWidth = gfx->fontWidth(&TomThumb);
				break;
			case FONT_FREESERIF_12:
				gfx->setFont(&FreeSerif12pt7b);
				selectedFontHeight = gfx->fontHeight(&FreeSerif12pt7b);
				selectedFontWidth = gfx->fontWidth(&FreeSerif12pt7b);
				break;
			case FONT_FREESERIFBOLD_12:
				gfx->setFont(&FreeSerifBold12pt7b);
				selectedFontHeight = gfx->fontHeight(&FreeSerifBold12pt7b);
				selectedFontWidth = gfx->fontWidth(&FreeSerifBold12pt7b);
				break;
			case FONT_FREESERIFBOLD_24:
				gfx->setFont(&FreeSerifBold24pt7b);
				selectedFontHeight = gfx->fontHeight(&FreeSerifBold24pt7b);
				selectedFontWidth = gfx->fontWidth(&FreeSerifBold24pt7b);
				break;
			case FONT_ORBITRON_LIGHT_24:
				gfx->setFont(&Orbitron_Light_24);
				selectedFontHeight = gfx->fontHeight(&Orbitron_Light_24);
				selectedFontWidth = gfx->fontWidth(&Orbitron_Light_24);
				break;
			case FONT_ORBITRON_LIGHT_32:
				gfx->setFont(&Orbitron_Light_32);
				selectedFontHeight = gfx->fontHeight(&Orbitron_Light_32);
				selectedFontWidth = gfx->fontWidth(&Orbitron_Light_32);
				break;
			case FONT_ROBOTO_THIN_24:
				gfx->setFont(&Roboto_Thin_24);
				selectedFontHeight = gfx->fontHeight(&Roboto_Thin_24);
				selectedFontWidth = gfx->fontWidth(&Roboto_Thin_24);
				break;
			default:
				gfx->setFont(&Font0);
				selectedFontHeight = gfx->fontHeight(&Font0);
				selectedFontWidth = gfx->fontWidth(&Font0);
				break; 
		}	
	}

	Byte B4RLOVYANGFXEX::getFont(void)
	{
		return selectedFont;
	}
	
	/*
	NOT WORKING as IFont needs to be defined (included)
	void B4RLOVYANGFXEX::SetFont(IFont* font)
	{
		gfx->setFont(font);
	}

	void B4RLOVYANGFXEX::GetFontInfo(void)
	{
		 ::Serial.print("font:");
		 ::Serial.print("height=");
		 ::Serial.print(gfx->fontHeight());
		 ::Serial.print(",width=");
		 ::Serial.print(gfx->fontWidth());
		 ::Serial.print(",textwidth=");
		 ::Serial.print(gfx->textWidth("World"));
		 ::Serial.println();
	}
	*/

	/**
	* COLOR
	*/
	
	void B4RLOVYANGFXEX::SetColor(ULong color)
	{
		gfx->setColor( (int32_t)color);
	}
	
	void B4RLOVYANGFXEX::SetColorRGB(Byte r, Byte g, Byte b)
	{
		gfx->setColor( (uint8_t)r, (uint8_t)g, (uint8_t)b);
	}
	
	Byte B4RLOVYANGFXEX::Color332(Byte r, Byte g, Byte b)
	{
		return gfx->color332((uint8_t)r,(uint8_t)g,(uint8_t)b);
	}

	UInt B4RLOVYANGFXEX::Color565(Byte r, Byte g, Byte b)
	{
		return gfx->color565((uint8_t)r,(uint8_t)g,(uint8_t)b);
	}

	ULong B4RLOVYANGFXEX::Color888(Byte r, Byte g, Byte b)
	{
		ULong c = gfx->color888((uint8_t)r,(uint8_t)g,(uint8_t)b);
		return gfx->color888((uint8_t)r,(uint8_t)g,(uint8_t)b);
	}

	ULong B4RLOVYANGFXEX::ColorRGB(Byte r, Byte g, Byte b)
	{
		ULong c = gfx->color888((uint8_t)r,(uint8_t)g,(uint8_t)b);
		return gfx->color888((uint8_t)r,(uint8_t)g,(uint8_t)b);
	}

	ULong B4RLOVYANGFXEX::Color16to24(ULong rgb565)
	{
		return gfx->color16to24( (uint32_t) rgb565);
	}
	
	/**
	* SPI bus
	*/

	/**
	* Secure SPI bus.
	*/
	void B4RLOVYANGFXEX::BeginTransaction(void)
	{
		gfx->beginTransaction();
	}

	/**
	* Release SPI bus.
	*/
	void B4RLOVYANGFXEX::EndTransaction(void)
	{
		gfx->endTransaction();
	}

	/**
	* Drawing Functions
	*/

	void B4RLOVYANGFXEX::StartWrite(bool transaction)
	{
		gfx->startWrite(transaction);
	}

	void B4RLOVYANGFXEX::EndWrite(void)
	{
		gfx->endWrite();
	}

	void B4RLOVYANGFXEX::DrawPixel( Long x, Long y, ULong color)
	{
		gfx->drawPixel( (int32_t) x, (int32_t) y, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::DrawPixelSize( Long x, Long y, UInt size, ULong color)
	{
		for (int i = 1; i <= size; i++) {
			for (int j = 1; j <= size; j++) {
				gfx->drawPixel( (int32_t) x + i, (int32_t) y + j, (uint32_t) color);
			}
		}
	}

	void B4RLOVYANGFXEX::DrawPixel4( Long x, Long y, ULong color)
	{
		B4RLOVYANGFXEX::DrawPixelSize( x, y, 4, color);
	}

	void B4RLOVYANGFXEX::DrawPixel8( Long x, Long y, ULong color)
	{
		B4RLOVYANGFXEX::DrawPixelSize( x, y, 8, color);
	}

	void B4RLOVYANGFXEX::DrawPixel16( Long x, Long y, ULong color)
	{
		B4RLOVYANGFXEX::DrawPixelSize( x, y, 16, color);
	}

	void B4RLOVYANGFXEX::DrawFastVLine ( Long x, Long y, Long h, ULong color)
	{
		gfx->drawFastVLine ( (int32_t) x, (int32_t) y, (int32_t) h, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::DrawFastHLine ( Long x, Long y, Long w, ULong color)
	{
		gfx->drawFastHLine ( (int32_t) x, (int32_t) y, (int32_t) w, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::DrawRect  ( Long x, Long y, Long w, Long h, ULong color)
	{
		gfx->drawRect  ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::FillRect  ( Long x, Long y, Long w, Long h, ULong color)
	{
		gfx->fillRect  ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::DrawRoundRect ( Long x, Long y, Long w, Long h, Long r, ULong color)
	{
		gfx->drawRoundRect ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (int32_t) r, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::FillRoundRect ( Long x, Long y, Long w, Long h, Long r, ULong color)
	{
		gfx->fillRoundRect ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (int32_t) r, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::DrawCircle( Long x, Long y, Long r, ULong color)
	{
		gfx->drawCircle( (int32_t) x, (int32_t) y, (int32_t) r, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::FillCircle( Long x, Long y, Long r, ULong color)
	{
		gfx->fillCircle( (int32_t) x, (int32_t) y, (int32_t) r, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::DrawEllipse( Long x, Long y, Long rx, Long ry , ULong color)
	{
		gfx->drawEllipse( (int32_t) x, (int32_t) y, (int32_t) rx, (int32_t) ry, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::FillEllipse( Long x, Long y, Long rx, Long ry, ULong color)
	{
		gfx->fillEllipse( (int32_t) x, (int32_t) y, (int32_t) rx, (int32_t) ry, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::DrawLine  ( Long x0, Long y0, Long x1, Long y1, ULong color)
	{
		gfx->drawLine( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (uint32_t) color);
	}
	
	void B4RLOVYANGFXEX::DrawGradientLine ( Long x0, Long y0, Long x1, Long y1, ULong colorstart, ULong colorend)
	{
		gfx->drawGradientLine( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (uint32_t) colorstart, (uint32_t) colorend);
	}

	void B4RLOVYANGFXEX::DrawWideLine ( Long x0, Long y0, Long x1, Long y1, double r, ULong color)
	{
		gfx->drawWideLine( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (float) r, (uint32_t) color);
	}
		
	void B4RLOVYANGFXEX::DrawTriangle  ( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, ULong color)
	{
		gfx->drawTriangle( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (int32_t) x2, (int32_t) y2, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::FillTriangle  ( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, ULong color)
	{
		gfx->fillTriangle( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (int32_t) x2, (int32_t) y2, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::DrawBezier3( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, ULong color)
	{
		gfx->drawBezier( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (int32_t) x2, (int32_t) y2, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::DrawBezier4( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, Long x3, Long y3, ULong color)
	{
		gfx->drawBezier( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (int32_t) x2, (int32_t) y2, (int32_t) x3, (int32_t) y3, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::DrawArc( Long x, Long y, Long r0, Long r1, Long angle0, Long angle1, ULong color)
	{
		gfx->drawArc( (int32_t) x, (int32_t) y, (int32_t) r0, (int32_t) r1, (int32_t) angle0, (int32_t) angle1, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::FillArc( Long x, Long y, Long r0, Long r1, Long angle0, Long angle1, ULong color)
	{
		gfx->fillArc( (int32_t) x, (int32_t) y, (int32_t) r0, (int32_t) r1, (int32_t) angle0, (int32_t) angle1, (uint32_t) color);
	}

	void B4RLOVYANGFXEX::FloodFill( Long x, Long y, ULong color)
	{
		gfx->floodFill( (int32_t) x, (int32_t) y, (uint32_t) color);
	}

	/**
	* TEXTBOX
	*/

	void B4RLOVYANGFXEX::DrawTextBox(int x, int y, int w, int h, B4RString* text, ULong textColor, double textSize, ULong fillColor, ULong borderColor, int borderSize) {

		gfx->setTextSize(textSize);
		gfx->setTextDatum(MC_DATUM); // Center text alignment
		gfx->setTextColor(textColor);

		// Fill rectangle with background color
		gfx->fillRect(x, y, w, h, fillColor);

		// Draw border with specified thickness
		for (int i = 0; i < borderSize; i++) {
			gfx->drawRect(x + i, y + i, w - (i * 2), h - (i * 2), borderColor);
		}

		// Calculate center position
		int centerX = x + w / 2;
		int centerY = y + h / 2;

		// Draw centered text
		gfx->drawString(text->data, centerX, centerY);
	}

	void B4RLOVYANGFXEX::DrawTextBoxMultiLine(int x, int y, int w, int h, B4RString* line1, B4RString* line2, B4RString* line3, 
											 ULong textColor, double textSize, ULong fillColor, ULong borderColor, int borderSize) {
		gfx->setTextColor(textColor);

		// Fill rectangle with background color
		gfx->fillRect(x, y, w, h, fillColor);

		// Draw border with specified thickness
		for (int i = 0; i < borderSize; i++) {
			gfx->drawRect(x + i, y + i, w - (i * 2), h - (i * 2), borderColor);
		}

		// Text margins
		const int margin = 2;
		double availableHeight = h - (2 * margin);  // Available vertical space
		double availableWidth = w - (2 * margin);   // Available horizontal space
		double totalSpacing = 4 * margin;           // 2px spacing between each line (4 spaces)
		double lineHeight = (availableHeight - totalSpacing) / 3.0;  // Height per text line

		// If textSize is 0, auto-adjust based on height
		double maxTextSize = textSize;
		if (textSize == 0) {
			maxTextSize = floor(lineHeight / 8.0);
		}

		// Get the longest line by character count
		B4RString* longest = line1;
		if (line2->getLength() > longest->getLength()) longest = line2;
		if (line3->getLength() > longest->getLength()) longest = line3;

		// Ensure text fits within the available width
		double maxWidthTextSize = maxTextSize;
		while ((longest->getLength() * (6 * maxWidthTextSize)) > availableWidth) {
			maxWidthTextSize -= 0.1;  // Reduce until it fits
			if (maxWidthTextSize < 1.0) {
				maxWidthTextSize = 1.0;
				break;
			}
		}

		// Use the smaller of height-based and width-based sizes
		maxTextSize = min(maxTextSize, maxWidthTextSize);

		// Ensure minimum text size of 1
		if (maxTextSize < 1.0) maxTextSize = 1.0;
		
		// Set text size
		gfx->setTextSize(maxTextSize);
		gfx->setTextDatum(MC_DATUM);  // Center text alignment

		// Calculate Y positions
		double centerX = x + (w / 2);
		double middleY = y + (h / 2);                          // Middle line
		double topY = middleY - (lineHeight + margin);         // First line (above middle)
		double bottomY = middleY + (lineHeight + margin);      // Third line (below middle)
		
		// Draw each line
		gfx->drawString(line1->data, centerX, topY);
		gfx->drawString(line2->data, centerX, middleY);
		gfx->drawString(line3->data, centerX, bottomY);
	}

	//TODO
	bool B4RLOVYANGFXEX::DrawImage(B4R::ArrayByte* data, ULong len, Long x, Long y, Long maxWidth, Long maxHeight, Long offX, Long offY, double scale_x, double scale_y, Byte datum)
	{
		// bool DrawImg(B4R::ArrayByte* data, uint32_t len, int32_t x=0, int32_t y=0, int32_t maxWidth=0, int32_t maxHeight=0, int32_t offX=0, int32_t offY=0, float scale_x = 1.0f, float scale_y = 0.0f, datum_t datum = datum_t::top_left)
		// gfx->draw_png(data->data, (uint32_t)len, (int32_t)x, (int32_t)y, (int32_t)maxWidth, (int32_t)maxHeight, (int32_t)offX, (int32_t)offY, scale_x, scale_y, datum);
	}

	/**
	* TOUCH
	*/

    void B4RLOVYANGFXEX::Looper(void* b) {
		// Touch sensivity delay in ms. Change if required.
		ULong TOUCH_DELAY = 150;
		
        B4RLOVYANGFXEX* me = (B4RLOVYANGFXEX*)b;
        
		uint16_t tX = 0, tY = 0;

		// Get the display touch height and width range 0 - NNN
		ULong touchHeight = me->Height() - 1;
		ULong touchWidth = me->Width() - 1;
		
		// If panel touched, 1 is returned
		if (me->gfx->getTouch(&tX, &tY) == 1) {
			
			// Set tX and tY by checking in range touchHeight, touchWidth
			if (tX < 1 || tX > touchWidth * 2) tX = 0;
			if (tX > touchWidth && tX < touchHeight * 2) tX = touchHeight;

			if (tY < 1 || tY > touchHeight * 2) tY = 0;
			if (tY > touchHeight && tY < touchHeight * 2) tY = touchHeight;
			
			// Call the touch handler in the B4R code
			me->TouchSub(tX, tY);
			
			// Short delay
			delay(TOUCH_DELAY);
		}
    }

	/**
	* RGBLED
	*/
	void B4RLOVYANGFXEX::SetRGBLEDColor(int redValue, int greenValue,  int blueValue)
	{
		// Important to take invert logic into account: 255 = OFF, 0 = ON	
		analogWrite(redPin,		255 - redValue);
		analogWrite(greenPin,	255 - greenValue);
		analogWrite(bluePin,	255 - blueValue);
	}

	void B4RLOVYANGFXEX::SetRGBLEDColorBrightness(int redValue, int greenValue, int blueValue, int brightnessValue)
	{
		double f = 0;
		if (brightnessValue > 0) { 
			// Cast the int brightnessvalue to a double else divide is rounded which is wrong
			f = (double)brightnessValue / 100;
		}
		// Important to take invert logic into account: 255 = OFF, 0 = ON	
		analogWrite(redPin,		255 - (redValue * f) );
		analogWrite(greenPin,	255 - (greenValue * f) );
		analogWrite(bluePin,	255 - (blueValue * f) );
	}
	
	void B4RLOVYANGFXEX::SetRGBLEDOff(void)
	{
		B4RLOVYANGFXEX::SetRGBLEDColor(0, 0, 0);
	}

	void B4RLOVYANGFXEX::setRGBLEDRed(int value)
	{
		B4RLOVYANGFXEX::SetRGBLEDColor(value, 0, 0);
	}
	int B4RLOVYANGFXEX::getRGBLEDRed(void)
	{
		return analogRead(redPin);
	}

	void B4RLOVYANGFXEX::setRGBLEDGreen(int value)
	{
		B4RLOVYANGFXEX::SetRGBLEDColor(0, value, 0);
	}
	int B4RLOVYANGFXEX::getRGBLEDGreen(void)
	{
		return analogRead(greenPin);
	}

	void B4RLOVYANGFXEX::setRGBLEDBlue(int value)
	{
		B4RLOVYANGFXEX::SetRGBLEDColor(0, 0, value);
	}
	int B4RLOVYANGFXEX::getRGBLEDBlue(void)
	{
		return analogRead(bluePin);
	}

	/**
	* BITMAP
	*/

	void B4RLOVYANGFXEX::DrawBitmap(int x, int y, int width, int height, ArrayByte* bitmap, ULong color, ULong backgroundColor)
	{
		uint8_t* data = (Byte*)bitmap->data;  // Get the pointer to the byte array

		gfx->startWrite();

		gfx->drawBitmap((int32_t)x, (int32_t)y, data, (int32_t)width, (int32_t)height, (uint32_t)color, (uint32_t)backgroundColor);

		gfx->endWrite();
	}

	void B4RLOVYANGFXEX::DrawIcon(int x, int y, int numRows, int numCols, Byte size, ArrayByte* bitmap, ULong color, ULong backgroundColor)
	{
		uint8_t* data = (uint8_t*)bitmap->data;  // Pointer to the byte array

		for (int row = 0; row < numRows; row++) {
			for (int col = 0; col < numCols; col++) {
				uint8_t byte = data[row];  // Get the byte representing the current row
				bool isPixelSet = byte & (0x80 >> col);  // Check if the bit is set for the column

				// Draw the pixel block based on the bit value (either the color or the background)
				DrawPixelSize(x + col * size, y + row * size, size, isPixelSet ? color : backgroundColor);
			}
		}
	}

	/**
	* BUTTON
	*/

	void B4RLOVYANGFXEX::DrawButton(int id, int x, int y, uint w, uint h, ULong fillcolor, ULong textcolor, B4RString* label, float textsize_x, float textsize_y, bool inverted)
	{
		auto style = gfx->getTextStyle();

		// Adjust textsize to fit button size. If too wide then textsize_x is set from textsize_y.
		textsize_x = textsize_x <= std::numeric_limits<float>::epsilon() ? textsize_x : textsize_y;
		textsize_y = textsize_y <= std::numeric_limits<float>::epsilon() ? textsize_x : textsize_y;
	
		gfx->setTextSize(textsize_x, textsize_y);
		gfx->setTextDatum(MC_DATUM);
		gfx->setTextPadding(0);

		auto fill = inverted ? (uint32_t)textcolor : (uint32_t)fillcolor;
		auto text = inverted ? (uint32_t)fillcolor : (uint32_t)textcolor;
		gfx->setTextColor(text, fill);

		// Corner radius
		uint_fast8_t r = (w < h ? w : h) >> 2;

		gfx->startWrite();
		gfx->fillRoundRect(x, y, w, h, r, fill);
		gfx->drawString(label->data, x + (w/2), y + (h/2));
		gfx->endWrite();

		gfx->setTextStyle(style);
	}

	/**
	* HEADER
	*/
	void B4RLOVYANGFXEX::DrawHeader(B4RString* text, Byte font, Byte textalign, Byte textsize, ULong textcolor, ULong backgroundColor, ULong linecolor)
	{
		B4RLOVYANGFXEX::setFont(font);

		int h = B4RLOVYANGFXEX::FontHeight() * textsize;
		int w = B4RLOVYANGFXEX::Width();
		int x = 0;
		int y = 0;
		int offset = 2;

		gfx->fillRect(0, 0, w, h, backgroundColor);

		Byte textdatum;
		if (textalign == TEXT_ALIGN_LEFT){
			textdatum = TEXT_ALIGN_MIDDLE_LEFT;
			x = offset;
		}
		else if (textalign == TEXT_ALIGN_CENTER){
			textdatum = TEXT_ALIGN_MIDDLE_CENTER;
			x = w / 2;		
		}
		else if (textalign == TEXT_ALIGN_RIGHT){
			textdatum = TEXT_ALIGN_MIDDLE_RIGHT;
			x = w - offset;
		}
		else {
			textdatum = TEXT_ALIGN_MIDDLE_CENTER;
			x = w / 2;			
		}

		B4RLOVYANGFXEX::DrawText(x, y + (h/2), text, textdatum, textsize, textcolor, backgroundColor);

		// Draw red line below the header (optional)
		if (linecolor != COLOR_NONE) { B4RLOVYANGFXEX::DrawLine(0, y + h, w, y + h, linecolor); }
	}

	/**
	* FOOTER
	*/
	void B4RLOVYANGFXEX::DrawFooter(B4RString* text, Byte font, Byte textalign, Byte textsize, ULong textcolor, ULong backgroundColor, ULong linecolor)
	{
		B4RLOVYANGFXEX::setFont(font);

		int h = B4RLOVYANGFXEX::FontHeight() * textsize;
		int w = B4RLOVYANGFXEX::Width();
		int x = 0;
		int y = B4RLOVYANGFXEX::Height();
		int offset = 2;

		gfx->fillRect(0, y - h, w, h, backgroundColor);

		Byte textdatum;
		if (textalign == TEXT_ALIGN_LEFT){
			textdatum = TEXT_ALIGN_MIDDLE_LEFT;
			x = offset;
		}
		else if (textalign == TEXT_ALIGN_CENTER){
			textdatum = TEXT_ALIGN_MIDDLE_CENTER;
			x = w / 2;		
		}
		else if (textalign == TEXT_ALIGN_RIGHT){
			textdatum = TEXT_ALIGN_MIDDLE_RIGHT;
			x = w - offset;
		}
		else {
			textdatum = TEXT_ALIGN_MIDDLE_CENTER;
			x = w / 2;			
		}

		B4RLOVYANGFXEX::DrawText(x, y - (h / 2), text, textdatum, textsize, textcolor, backgroundColor);
		
		// Draw red line above the footer (optional)
		if (linecolor != COLOR_NONE) { B4RLOVYANGFXEX::DrawLine(0, y - h, w, y - h, linecolor); }
	}

}
