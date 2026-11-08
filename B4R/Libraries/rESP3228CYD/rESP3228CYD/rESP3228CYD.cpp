#include "B4RDefines.h"

namespace B4R
{
	void B4RESP3228CYD::Initialize(SubVoidTouch TouchSub)
	{
		gfx = new (be) LGFX;

		gfx->init();
		
		// Short delay to let init complete
		delay(100);  
				
		// Set to 24 bits for RGB888.
		// Actual number of colors displayed may be 18 bits (RGB666) depending display hardware.
		gfx->setColorDepth(24);		

		// Set the default font
		selectedFont = FONT_DEFAULT;

		// Init the RGB LED
		pinMode(this->redPin, OUTPUT);              
		pinMode(this->greenPin, OUTPUT);
		pinMode(this->bluePin, OUTPUT);

		// Check if touch event is set
		if (TouchSub != NULL) {
			::Serial.println("Touch enabled");
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

	ULong B4RESP3228CYD::Height()
	{
		return (uint32_t)gfx->height();
	}

	ULong B4RESP3228CYD::Width()
	{
		return (uint32_t)gfx->width();
	}

	void B4RESP3228CYD::Clear()
	{
		gfx->clear();
	}

	void B4RESP3228CYD::ClearSetColor(ULong color)
	{
		gfx->clear((uint32_t) color);
	}

	void B4RESP3228CYD::ClearArea(Long x, Long y, Long w, Long h, ULong color)
	{
		gfx->fillRect(x, y, w, h, color);
	}
	
	void B4RESP3228CYD::setDisplayRotation(Byte direction)
	{
		gfx->setRotation( (int_fast8_t) direction);
	}

	Byte B4RESP3228CYD::getDisplayRotation()
	{
		return (Byte) gfx->getRotation();
	}

	void B4RESP3228CYD::SetColorDepth(int bits)
	{
		if (bits != 16 || bits != 24) { bits = 16; }
		gfx->setColorDepth(bits);
	}

	void B4RESP3228CYD::SetBrightness(Byte brightness)
	{
		gfx->setBrightness( (uint8_t) brightness);
	}
		
	void B4RESP3228CYD::FillScreen(ULong color)
	{
		gfx->fillScreen((uint32_t)color);
		backgroundColor = color;
	}

	void B4RESP3228CYD::setBackgroundColor(ULong color)
	{
		gfx->fillScreen((uint32_t)color);
		backgroundColor = color;
	}
	ULong B4RESP3228CYD::getBackgroundColor()
	{
		return backgroundColor;
	}
	
	void B4RESP3228CYD::SetTextColor(ULong color)
	{
		gfx->setTextColor( (uint32_t)color);
	}
	
	void B4RESP3228CYD::SetTextSize(Double size)
	{
		gfx->setTextSize(size);
	}
	
	void B4RESP3228CYD::SetTextDatum(Byte datum)
	{
		gfx->setTextDatum(datum);
	}
	
	void B4RESP3228CYD::SetCursor(ULong x, ULong y)
	{
		gfx->setCursor( (int32_t) x, (int32_t) y);
	}
		
	void B4RESP3228CYD::Print(B4RString* text)
	{
		gfx->print(text->data);
	}

	void B4RESP3228CYD::Println(B4RString* text)
	{
		gfx->println(text->data);
	}

	void B4RESP3228CYD::DrawText(ULong x, ULong y, B4RString* text, Byte textAlignment, double textSize, ULong textColor, ULong backgroundColor)
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
	
	UInt B4RESP3228CYD::TextLength(B4RString* text)
	{
		// Get the text length by character count
		UInt textlen = text->getLength();

		// This is another option
		// char* c = (char*)text->data;
		// int textlen = strlen(c);
		return textlen;
	}

	UInt B4RESP3228CYD::TextWidth(B4RString* text)
	{
		return (UInt) gfx->textWidth(text->data);
	}

	UInt B4RESP3228CYD::TextWidthDefault(B4RString* text, double textSize)
	{
		UInt textlen = text->getLength();
		return textlen * textSize * FONT_HEIGHT_DEFAULT;
	}

	UInt B4RESP3228CYD::TextHeight(double textSize)
	{
		return textSize * FONT_HEIGHT_DEFAULT;
	}

	ULong B4RESP3228CYD::FontHeight(Byte font)
	{
		return gfx->fontHeight(font);
	}

	ULong B4RESP3228CYD::FontWidth(Byte font)
	{
		return gfx->fontWidth(font);
	}

	/**
	* FONT
	*/

	void B4RESP3228CYD::setFont(Byte font)
	{
		switch (font) {
			
			selectedFont = font;
			
			case FONT_DEFAULT:
				gfx->setFont(&Font0);
				break;
			case FONT_FONT0:
				gfx->setFont(&Font0);
				break;
			case FONT_FONT2:
				gfx->setFont(&Font2);
				break;
			case FONT_FONT4:
				gfx->setFont(&Font4);
				break;
			case FONT_FONT6:
				gfx->setFont(&Font6);
				break;
			case FONT_FONT7:
				gfx->setFont(&Font7);
				break;
			case FONT_FONT8:
				gfx->setFont(&Font8);
				break;
			case FONT_FREEMONO_9:
				gfx->setFont(&FreeMono9pt7b);
				break;
			case FONT_FREEMONOBOLD_9:
				gfx->setFont(&FreeMonoBold9pt7b);
				break;
			case FONT_FREEMONO_12:
				gfx->setFont(&FreeMono12pt7b);
				break;
			case FONT_FREEMONOBOLD_12:
				gfx->setFont(&FreeMonoBold12pt7b);
				break;
			case FONT_FREESANS_9:
				gfx->setFont(&FreeSans9pt7b);
				break;
			case FONT_FREESANSBOLD_9:
				gfx->setFont(&FreeSansBold9pt7b);
				break;
			case FONT_FREESANS_12:
				gfx->setFont(&FreeSans12pt7b);
				break;
			case FONT_FREESANSBOLD_12:
				gfx->setFont(&FreeSansBold12pt7b);
				break;
			case FONT_TOMTHUMB_1:
				gfx->setFont(&TomThumb);
				break;
			case FONT_FREESERIF_12:
				gfx->setFont(&FreeSerif12pt7b);
				break;
			case FONT_FREESERIFBOLD_12:
				gfx->setFont(&FreeSerifBold12pt7b);
				break;
			case FONT_FREESERIFBOLD_24:
				gfx->setFont(&FreeSerifBold24pt7b);
				break;
			case FONT_ORBITRON_LIGHT_24:
				gfx->setFont(&Orbitron_Light_24);
				break;
			case FONT_ORBITRON_LIGHT_32:
				gfx->setFont(&Orbitron_Light_32);
				break;
			case FONT_ROBOTO_THIN_24:
				gfx->setFont(&Roboto_Thin_24);
				break;
			default:
				gfx->setFont(&Font0);
				break; 
		}	
	}

	Byte B4RESP3228CYD::getFont(void)
	{
		return selectedFont;
	}

	/*
	NOT WORKING
	void B4RESP3228CYD::SetFont(IFont* font)
	{
		gfx->setFont(font);
	}
	*/

	/**
	* COLOR
	*/
	
	void B4RESP3228CYD::SetColor(ULong color)
	{
		gfx->setColor( (int32_t)color);
	}
	
	void B4RESP3228CYD::SetColorRGB(Byte r, Byte g, Byte b)
	{
		gfx->setColor( (uint8_t)r, (uint8_t)g, (uint8_t)b);
	}
	
	Byte B4RESP3228CYD::Color332(Byte r, Byte g, Byte b)
	{
		return gfx->color332((uint8_t)r,(uint8_t)g,(uint8_t)b);
	}

	UInt B4RESP3228CYD::Color565(Byte r, Byte g, Byte b)
	{
		return gfx->color565((uint8_t)r,(uint8_t)g,(uint8_t)b);
	}

	ULong B4RESP3228CYD::Color888(Byte r, Byte g, Byte b)
	{
		ULong c = gfx->color888((uint8_t)r,(uint8_t)g,(uint8_t)b);
		return gfx->color888((uint8_t)r,(uint8_t)g,(uint8_t)b);
	}

	ULong B4RESP3228CYD::ColorRGB(Byte r, Byte g, Byte b)
	{
		ULong c = gfx->color888((uint8_t)r,(uint8_t)g,(uint8_t)b);
		return gfx->color888((uint8_t)r,(uint8_t)g,(uint8_t)b);
	}

	ULong B4RESP3228CYD::Color16to24(ULong rgb565)
	{
		return gfx->color16to24( (uint32_t) rgb565);
	}
	
	/**
	* SPI bus
	*/

	/**
	* Secure SPI bus.
	*/
	void B4RESP3228CYD::BeginTransaction(void)
	{
		gfx->beginTransaction();
	}

	/**
	* Release SPI bus.
	*/
	void B4RESP3228CYD::EndTransaction(void)
	{
		gfx->endTransaction();
	}

	/**
	* Drawing Functions
	*/

	void B4RESP3228CYD::StartWrite(bool transaction)
	{
		gfx->startWrite(transaction);
	}

	void B4RESP3228CYD::EndWrite(void)
	{
		gfx->endWrite();
	}

	void B4RESP3228CYD::DrawPixel( Long x, Long y, ULong color)
	{
		gfx->drawPixel( (int32_t) x, (int32_t) y, (uint32_t) color);
	}

	void B4RESP3228CYD::DrawPixelSize( Long x, Long y, UInt size, ULong color)
	{
		for (int i = 1; i <= size; i++) {
			for (int j = 1; j <= size; j++) {
				gfx->drawPixel( (int32_t) x + i, (int32_t) y + j, (uint32_t) color);
			}
		}
	}

	void B4RESP3228CYD::DrawPixel4( Long x, Long y, ULong color)
	{
		B4RESP3228CYD::DrawPixelSize( x, y, 4, color);
	}

	void B4RESP3228CYD::DrawPixel8( Long x, Long y, ULong color)
	{
		B4RESP3228CYD::DrawPixelSize( x, y, 8, color);
	}

	void B4RESP3228CYD::DrawPixel16( Long x, Long y, ULong color)
	{
		B4RESP3228CYD::DrawPixelSize( x, y, 16, color);
	}

	void B4RESP3228CYD::DrawFastVLine ( Long x, Long y, Long h, ULong color)
	{
		gfx->drawFastVLine ( (int32_t) x, (int32_t) y, (int32_t) h, (uint32_t) color);
	}

	void B4RESP3228CYD::DrawFastHLine ( Long x, Long y, Long w, ULong color)
	{
		gfx->drawFastHLine ( (int32_t) x, (int32_t) y, (int32_t) w, (uint32_t) color);
	}

	void B4RESP3228CYD::DrawRect  ( Long x, Long y, Long w, Long h, ULong color)
	{
		gfx->drawRect  ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (uint32_t) color);
	}

	void B4RESP3228CYD::FillRect  ( Long x, Long y, Long w, Long h, ULong color)
	{
		gfx->fillRect  ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (uint32_t) color);
	}

	void B4RESP3228CYD::DrawRoundRect ( Long x, Long y, Long w, Long h, Long r, ULong color)
	{
		gfx->drawRoundRect ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (int32_t) r, (uint32_t) color);
	}

	void B4RESP3228CYD::FillRoundRect ( Long x, Long y, Long w, Long h, Long r, ULong color)
	{
		gfx->fillRoundRect ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (int32_t) r, (uint32_t) color);
	}

	void B4RESP3228CYD::DrawCircle( Long x, Long y, Long r, ULong color)
	{
		gfx->drawCircle( (int32_t) x, (int32_t) y, (int32_t) r, (uint32_t) color);
	}

	void B4RESP3228CYD::FillCircle( Long x, Long y, Long r, ULong color)
	{
		gfx->fillCircle( (int32_t) x, (int32_t) y, (int32_t) r, (uint32_t) color);
	}

	void B4RESP3228CYD::DrawEllipse( Long x, Long y, Long rx, Long ry , ULong color)
	{
		gfx->drawEllipse( (int32_t) x, (int32_t) y, (int32_t) rx, (int32_t) ry, (uint32_t) color);
	}

	void B4RESP3228CYD::FillEllipse( Long x, Long y, Long rx, Long ry, ULong color)
	{
		gfx->fillEllipse( (int32_t) x, (int32_t) y, (int32_t) rx, (int32_t) ry, (uint32_t) color);
	}

	void B4RESP3228CYD::DrawLine  ( Long x0, Long y0, Long x1, Long y1, ULong color)
	{
		gfx->drawLine( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (uint32_t) color);
	}
	
	void B4RESP3228CYD::DrawGradientLine ( Long x0, Long y0, Long x1, Long y1, ULong colorstart, ULong colorend)
	{
		gfx->drawGradientLine( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (uint32_t) colorstart, (uint32_t) colorend);
	}

	void B4RESP3228CYD::DrawWideLine ( Long x0, Long y0, Long x1, Long y1, double r, ULong color)
	{
		gfx->drawWideLine( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (float) r, (uint32_t) color);
	}
		
	void B4RESP3228CYD::DrawTriangle  ( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, ULong color)
	{
		gfx->drawTriangle( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (int32_t) x2, (int32_t) y2, (uint32_t) color);
	}

	void B4RESP3228CYD::FillTriangle  ( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, ULong color)
	{
		gfx->fillTriangle( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (int32_t) x2, (int32_t) y2, (uint32_t) color);
	}

	void B4RESP3228CYD::DrawBezier3( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, ULong color)
	{
		gfx->drawBezier( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (int32_t) x2, (int32_t) y2, (uint32_t) color);
	}

	void B4RESP3228CYD::DrawBezier4( Long x0, Long y0, Long x1, Long y1, Long x2, Long y2, Long x3, Long y3, ULong color)
	{
		gfx->drawBezier( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (int32_t) x2, (int32_t) y2, (int32_t) x3, (int32_t) y3, (uint32_t) color);
	}

	void B4RESP3228CYD::DrawArc( Long x, Long y, Long r0, Long r1, Long angle0, Long angle1, ULong color)
	{
		gfx->drawArc( (int32_t) x, (int32_t) y, (int32_t) r0, (int32_t) r1, (int32_t) angle0, (int32_t) angle1, (uint32_t) color);
	}

	void B4RESP3228CYD::FillArc( Long x, Long y, Long r0, Long r1, Long angle0, Long angle1, ULong color)
	{
		gfx->fillArc( (int32_t) x, (int32_t) y, (int32_t) r0, (int32_t) r1, (int32_t) angle0, (int32_t) angle1, (uint32_t) color);
	}

	/**
	* TEXTBOX
	*/

	void B4RESP3228CYD::DrawTextBox(int x, int y, int w, int h, B4RString* text, ULong textColor, double textSize, ULong fillColor, ULong borderColor, int borderSize) {

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

	void B4RESP3228CYD::DrawTextBoxMultiLine(int x, int y, int w, int h, B4RString* line1, B4RString* line2, B4RString* line3, 
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

	/**
	* GAUGE
	*/
	void B4RESP3228CYD::DrawGauge(int x, int y, int radius, double minValue, double maxValue, double currentValue, 
								  B4RString* title,
								  ULong scaleColor, ULong borderColor, ULong needleColor, 
								  int needleThickness, double textSize, ULong innerColor) {

		double scaleTextSize = 1;

		// Draw filled inner circle
		gfx->fillCircle(x, y, radius - 2, (uint32_t) innerColor);

		// Draw gauge border
		gfx->drawCircle(x, y, radius, borderColor);

		// Define total angle range and offset
		double angleRange = 240.0;  // Scale covers 240 degrees
		double angleOffset = 30.0;  // 2000 (08:00) starts at 30° 

		// Draw scale (ticks)
		int majorTicks = 0;
		int numberOfTicks = 20; 
		for (int i = 0; i <= numberOfTicks; i++) {
			// Calculate tick value
			double tickValue = minValue + i * (maxValue - minValue) / numberOfTicks;

			// Reverse direction of calculation: calculate the tick angle from the max value 
			double tickAngle = angleOffset + (tickValue - maxValue) * angleRange / (maxValue - minValue); 

			// Convert tick angle to radians
			double rad = tickAngle * DEG_TO_RAD;

			int r1 = radius - 2; 
			int tickLength = (i % 5 == 0) ? 10 : 5; 
			int x1 = x + cos(rad) * (r1 - tickLength);  
			int y1 = y + sin(rad) * (r1 - tickLength);
			int x2 = x + cos(rad) * r1;                 
			int y2 = y + sin(rad) * r1;
			gfx->drawLine(x1, y1, x2, y2, scaleColor);

			// Show scale values at major ticks
			if (i % 5 == 0) {
				majorTicks++;
				String tickValueString = String(int(tickValue));

				int textX = x + cos(rad) * (r1 - tickLength - 15); 
				int textY = y + sin(rad) * (r1 - tickLength - 15);
				int align = MC_DATUM;

				if (majorTicks < 3) { 
					textX -= FONT_HEIGHT_DEFAULT; 
					align = ML_DATUM; 
				}
				if (majorTicks == 3) { 
					textX -= (FONT_HEIGHT_DEFAULT / 2); 
					align = MC_DATUM; 
				}
				if (majorTicks > 3) { 
					textX += FONT_HEIGHT_DEFAULT; 
					align = MR_DATUM; 
				}

				gfx->setTextSize(scaleTextSize);
				gfx->setTextColor(scaleColor);
				gfx->setTextDatum(align);
				gfx->drawString(tickValueString, textX, textY);
			}
		}

		// Needle direction (clockwise)
		double valueAngle = angleOffset + (currentValue - maxValue) * angleRange / (maxValue - minValue); 
		double radNeedle = valueAngle * DEG_TO_RAD;

		int needleX = x + cos(radNeedle) * (radius * 0.7);    
		int needleY = y + sin(radNeedle) * (radius * 0.7);
		
		// Draw the needle line with needle base (filled rect)
		gfx->fillRect(x - needleThickness / 2, y - needleThickness / 2, needleThickness, needleThickness, needleColor);
		gfx->drawLine(x, y, needleX, needleY, needleColor);

		// Display the title below the needle
		gfx->setTextSize(textSize);
		gfx->setTextColor(needleColor);
		gfx->setTextDatum(MC_DATUM);
		gfx->drawString(title->data, x, y + radius * 0.6);
	}

	//TODO: CreatePNG
	B4R::ArrayByte* B4RESP3228CYD::CreatePNG( Long x, Long y, Long width, Long height)
	{
		::Serial.print("[CreatePNG]");
		::Serial.print("x=");
		::Serial.print(x);
		::Serial.print("y=");
		::Serial.print(y);
		::Serial.print("w=");
		::Serial.print(width);
		::Serial.print("h=");
		::Serial.print(height);
		::Serial.println();
		ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
		size_t dlen;

		uint8_t* png = (uint8_t*)gfx->createPng(&dlen, x, y, width, height);
		::Serial.println((char *)png);
		
		if (!png)
		{
			::Serial.print("[CreatePNG][ERROR]");
		}
		else
		{
			::Serial.print("[CreatePNG][OK]");
			arr->data = png;
			arr->length = dlen;
		}
		return arr;
	}

	/**
	* TOUCH
	*/

    void B4RESP3228CYD::Looper(void* b) {
		// Touch sensivity delay in ms. Change if required.
		ULong TOUCH_DELAY = 100;
		
        B4RESP3228CYD* me = (B4RESP3228CYD*)b;
        
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
	void B4RESP3228CYD::SetRGBLEDColor(int redValue, int greenValue,  int blueValue) {
		// Important to ake invert logic into account: 255 = OFF, 0 = ON
		
		analogWrite(redPin, 255 - redValue);
		analogWrite(greenPin, 255 - greenValue);
		analogWrite(bluePin, 255 - blueValue);
	}
	
	void B4RESP3228CYD::SetRGBLEDOff(void)
	{
		B4RESP3228CYD::SetRGBLEDColor(0, 0, 0);
	}

	void B4RESP3228CYD::setRGBLEDRed(int value)
	{
		B4RESP3228CYD::SetRGBLEDColor(value, 0, 0);
	}
	int B4RESP3228CYD::getRGBLEDRed(void)
	{
		return analogRead(redPin);
	}

	void B4RESP3228CYD::setRGBLEDGreen(int value)
	{
		B4RESP3228CYD::SetRGBLEDColor(0, value, 0);
	}
	int B4RESP3228CYD::getRGBLEDGreen(void)
	{
		return analogRead(greenPin);
	}

	void B4RESP3228CYD::setRGBLEDBlue(int value)
	{
		B4RESP3228CYD::SetRGBLEDColor(0, 0, value);
	}
	int B4RESP3228CYD::getRGBLEDBlue(void)
	{
		return analogRead(bluePin);
	}

	/**
	* BITMAP
	*/

	void B4RESP3228CYD::DrawBitmap(int x, int y, int width, int height, ArrayByte* bitmap, ULong color, ULong bgColor)
	{
		uint8_t* data = (Byte*)bitmap->data;  // Get the pointer to the byte array

		gfx->startWrite();

		// Draw the bitmap using LovyanGFX's drawBitmap function
		gfx->drawBitmap((int32_t)x, (int32_t)y, data, (int32_t)width, (int32_t)height, (uint32_t)color, (uint32_t)bgColor);

		gfx->endWrite();
	}

	void B4RESP3228CYD::DrawIcon(int x, int y, int numRows, int numCols, Byte size, ArrayByte* bitmap, ULong color, ULong bgColor)
	{
		uint8_t* data = (uint8_t*)bitmap->data;  // Pointer to the byte array

		for (int row = 0; row < numRows; row++) {
			for (int col = 0; col < numCols; col++) {
				uint8_t byte = data[row];  // Get the byte representing the current row
				bool isPixelSet = byte & (0x80 >> col);  // Check if the bit is set for the column

				// Draw the pixel block based on the bit value (either the color or the background)
				DrawPixelSize(x + col * size, y + row * size, size, isPixelSet ? color : bgColor);
			}
		}
	}

}
