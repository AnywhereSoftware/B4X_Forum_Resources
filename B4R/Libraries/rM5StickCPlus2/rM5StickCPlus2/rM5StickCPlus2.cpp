/**
 * rM5StickCPlus2.cpp
 * Source of the B4R library rM5StickCPlus2.
 */

#include "B4RDefines.h"

// Additional fonts
// #include <FreeSevenSegment24pt7b.h>

namespace B4R {

	// =========================================================
	// Initialize
	// =========================================================

	void B4RM5StickCPlus2::Initialize() {

		// Initialize M5 device
		// // M5 core including M5.Rtc.begin (resets the RTC)
		M5.begin();						
		// M5 power module
		M5.Power.begin();
		// Initial screen is black
		M5.Lcd.fillScreen(TFT_BLACK);
		// Set the default font and update the font metrics
		SetFontDefault();
		
		// DEBUG
		// The boards are defined in M5GFX-master\src\lgfx\boards.hpp (M5StickCPlus2=5).
		// ::Serial.print("[B4RM5StickCPlus2::Initialize][I] board=");
		// ::Serial.println(M5.getBoard());
		::Serial.println("[B4RM5StickCPlus2::Initialize][I] OK");
	}

	void B4RM5StickCPlus2::InitializeWithButtonEvent(SubVoidByte KeyPressedSub) {

		// Initialize M5 device
		M5.begin();						
		M5.Power.begin();				
		M5.Lcd.fillScreen(TFT_BLACK);
		SetFontDefault();
		
		// Only register poller if event sub is provided
		this->KeyPressedSub = KeyPressedSub;
		if (KeyPressedSub != NULL) {
			FunctionUnion fu;
			fu.PollerFunction = looper;
			pnode.functionUnion = fu;
			pnode.tag = this;
			if (pnode.next == NULL) {
				pollers.add(&pnode);
			}
			::Serial.println("[B4RM5StickCPlus2::InitializeWithButtonEvent][I] Initialized with button polling (event mode)");
		} else {
			::Serial.println("[B4RM5StickCPlus2::InitializeWithButtonEvent][I] Initialized (no event polling)");
		}
	}

	bool B4RM5StickCPlus2::InitializeWithRTC(B4RString* timezone) {
			
		// -------------------------------------------------------------
		// Set the class vars with date & time from NTP
		// THIS MUST DONE PRIOR M5.begin
		// -------------------------------------------------------------
		//::Serial.println("[B4RM5StickCPlus2::InitializeWithRTC][I] Syncing time from NTP before RTC start...");
		if (!RTC_SetDateTimeFromNTP(timezone)) {
			::Serial.println("[B4RM5StickCPlus2::InitializeWithRTC][E] NTP sync failed!");
			return false;
		}

		// -------------------------------------------------------------
		// Initialize the M5 core (this resets RTC)
		// -------------------------------------------------------------
		M5.begin();
		M5.Power.begin();
		M5.Lcd.fillScreen(TFT_BLACK);
		// Set the default font and update the font metrics
		SetFontDefault();

		// -------------------------------------------------------------
		// Re-apply the previously obtained NTP time to M5 RTC
		// -------------------------------------------------------------
		M5.Rtc.setDateTime({
			{ rtcYear, rtcMonth, rtcDate },
			{ rtcHours, rtcMinutes, rtcSeconds }
		});

		// ::Serial.printf("[B4RM5StickCPlus2::InitializeWithRTC][I] RTC restored to NTP time: %04d-%02d-%02d %02d:%02d:%02d\n",
		// 	rtcYear, rtcMonth, rtcDate, rtcHours, rtcMinutes, rtcSeconds);
		// ::Serial.println("[B4RM5StickCPlus2::InitializeWithRTC][I] OK");
		return true;
	}

	// =========================================================
	// --- Button Event ---
	// =========================================================

	// static
    void B4RM5StickCPlus2::looper(void* b) {
        B4RM5StickCPlus2* me = (B4RM5StickCPlus2*)b;

		// If no callback sub was assigned, do nothing
		if (me->KeyPressedSub == NULL)
			return;

		// Update the device
        M5.update();

		// Check the button and raise the callback
		// 0=BtnA,1=BtnB,2=BtnPWR
		if (M5.BtnA.wasPressed()) 
			me->KeyPressedSub(M5_BUTTON_A);	  
		if (M5.BtnB.wasPressed()) 
			me->KeyPressedSub(M5_BUTTON_B);	  
		if (M5.BtnPWR.wasPressed()) 
			me->KeyPressedSub(M5_BUTTON_PWR);	  
    }

	// =========================================================
	// --- Display ---
	// =========================================================

	void B4RM5StickCPlus2::Clear() {
		// current background color
		uint16_t bg = M5.Lcd.getBaseColor();
		M5.Lcd.fillScreen(bg);
	}

	void B4RM5StickCPlus2::ClearColor(int bgColor) {
		M5.Lcd.fillScreen((uint16_t)bgColor);
	}

	void B4RM5StickCPlus2::ClearArea(int x, int y, int w, int h) {
		// current background color
		uint16_t bg = M5.Lcd.getBaseColor();
		M5.Lcd.fillRect(x, y, w, h, bg);
	}

	// Clears only the area occupied by a text string
	void B4RM5StickCPlus2::ClearTextArea(int x, int y, B4RString* text, int textSize) {
		SetTextSize(textSize); 					// ensure we know the font size first!
		int w = GetTextLengthInPixel(text);		// width of string in pixels
		int h = GetFontHeight();              	// height of the font

		uint16_t bg = M5.Lcd.getBaseColor(); 
		M5.Lcd.fillRect(x, y, w, h, bg);
	}

	void B4RM5StickCPlus2::SetBrightness(Byte brightness) {
		if (brightness < 0) brightness = 0;
		if (brightness > 255) brightness = 255;		
		M5.Lcd.setBrightness(brightness);
	}

	void B4RM5StickCPlus2::setRotation(Byte rotation) {
		currentRotation = rotation; 
		M5.Lcd.setRotation(currentRotation);
	}

	Byte B4RM5StickCPlus2::getRotation(void) {
		return currentRotation; 
	}
	
	void B4RM5StickCPlus2::SetCursor(int x, int y) {
		M5.Lcd.setCursor(x, y);
	}

	void B4RM5StickCPlus2::SetTextSize(float size) {
		if (size < UI_TEXTSIZE_MIN) size = UI_TEXTSIZE_MIN;
		if (size > UI_TEXTSIZE_MAX) size = UI_TEXTSIZE_MAX;
		M5.Lcd.setTextSize((float)size);
	}

	void B4RM5StickCPlus2::SetTextColor(int color) {
		M5.Lcd.setTextColor((uint16_t)color);
	}

	void B4RM5StickCPlus2::SetTextAt(int x, int y, B4RString* text, int textSize, int textColor) {
		if (textSize >= 0) SetTextSize(textSize);
		SetTextColor(textColor);
		M5.Lcd.setCursor(x, y);
		M5.Lcd.print((const char*)text->data);
	}

	void B4RM5StickCPlus2::Print(B4RString* text) {
		M5.Lcd.print((const char*)text->data);
	}

	void B4RM5StickCPlus2::PrintCentered(int xCenter, int y, B4RString* text, int textSize, int textColor, int bgColor) {
		if (textSize >= 0) {
			SetTextSize(textSize);
		}

		int w = GetTextLengthInPixel(text);
		int h = GetFontHeight() * textSize;

		// Clear the text area
		M5.Lcd.fillRect(xCenter - (w/2), y, w, h, (uint16_t)bgColor);

		M5.Lcd.setCursor(xCenter - (w/2), y);
		SetTextColor(textColor);
		M5.Lcd.print((const char*)text->data);
	}

	void B4RM5StickCPlus2::PrintNum(float value) {
		M5.Lcd.print(value);
	}

	void B4RM5StickCPlus2::PrintNumDecimals(float value, Byte decimals) {
		M5.Lcd.print(value, decimals);
	}

	int B4RM5StickCPlus2::GetTextLengthInPixel(B4RString* text) {
		if (text == nullptr || text->getLength() == 0)
			return 0;

		// Try to get fixed width from current font
		int fw = M5.Lcd.fontWidth();
		if (fw > 0) {
			return fw * text->getLength();
		}

		// If width = 0 (e.g., FreeFont or unsupported), use textWidth()
		// textWidth() calculates pixel width of the whole string accurately
		return M5.Lcd.textWidth((const char*)text->data);
	}

	void B4RM5StickCPlus2::SetHeader(B4RString* text, int textSize, int alignment, int fgColor, int bgColor, bool clear) {

		M5.Lcd.setTextSize(textSize);
		int textHeight = 8 * textSize + 4;	// Add small padding
		int y = 0;

		// Optional background clearing
		if (clear)
			M5.Lcd.fillRect(0, y, M5.Lcd.width(), textHeight, (uint16_t)bgColor);

		int16_t textWidth = M5.Lcd.textWidth(text->data);
		int x;
		switch (alignment) {
			case 1: x = (M5.Lcd.width() - textWidth) / 2; break;
			case 2: x = M5.Lcd.width() - textWidth; break;
			default: x = 0; break;
		}

		M5.Lcd.setCursor(x, y + 2);
		M5.Lcd.setTextColor((uint16_t)fgColor);
		M5.Lcd.print(text->data);
	}

	void B4RM5StickCPlus2::SetFooter(B4RString* text, int textSize, int alignment, int fgColor, int bgColor, bool clear) {
		M5.Lcd.setTextSize(textSize);
		int textHeight = 8 * textSize + 4;
		int y = M5.Lcd.height() - textHeight;

		// Optional background clearing
		if (clear)
			M5.Lcd.fillRect(0, y, M5.Lcd.width(), textHeight, (uint16_t)bgColor);

		int16_t textWidth = M5.Lcd.textWidth(text->data);
		int x;
		switch (alignment) {
			case 1: x = (M5.Lcd.width() - textWidth) / 2; break;
			case 2: x = M5.Lcd.width() - textWidth; break;
			default: x = 0; break;
		}

		M5.Lcd.setCursor(x, y + 2);
		M5.Lcd.setTextColor((uint16_t)fgColor);
		M5.Lcd.print(text->data);
	}

	void B4RM5StickCPlus2::SetHorLine(int y, int color, int thickness) {
		M5.Lcd.fillRect(0, y, M5.Lcd.width(), (uint16_t)thickness, (uint16_t)color);
	}

	// =========================================================
	// --- Characters ---
	// =========================================================

	void B4RM5StickCPlus2::SetFreeFont(int fontId) {
		switch (fontId) {
			case UI_FREEFONT_SANS9:   M5.Lcd.setFreeFont(&FreeSans9pt7b); break;
			case UI_FREEFONT_SANS12:  M5.Lcd.setFreeFont(&FreeSans12pt7b); break;
			case UI_FREEFONT_SANS18:  M5.Lcd.setFreeFont(&FreeSansBold18pt7b); break;
			case UI_FREEFONT_SANS24:  M5.Lcd.setFreeFont(&FreeSansBold24pt7b); break;
			case UI_FREEFONT_MONO9:   M5.Lcd.setFreeFont(&FreeMono9pt7b); break;
			case UI_FREEFONT_MONO12:  M5.Lcd.setFreeFont(&FreeMono12pt7b); break;
			case UI_FREEFONT_MONO18:  M5.Lcd.setFreeFont(&FreeMono18pt7b); break;
			case UI_FREEFONT_SERIF12: M5.Lcd.setFreeFont(&FreeSerif12pt7b); break;
			case UI_FREEFONT_SERIF18: M5.Lcd.setFreeFont(&FreeSerif18pt7b); break;
			case UI_FREEFONT_DEFAULT:
			default:
				M5.Lcd.setFreeFont(nullptr);  // fallback to built-in font
				M5.Lcd.setTextFont(UI_TEXTFONT_DEFAULT);
				M5.Lcd.setTextSize(UI_TEXTSIZE_DEFAULT);
				break;
		}
	}

	void B4RM5StickCPlus2::SetTextFont(int fontId, float textSize) {
		if (fontId < UI_TEXTFONT_1) fontId = UI_TEXTFONT_1;
		if (fontId > UI_TEXTFONT_4) fontId = UI_TEXTFONT_4;

		// Clamp textSize
		if (textSize < UI_TEXTSIZE_MIN) textSize = UI_TEXTSIZE_MIN;
		if (textSize > UI_TEXTSIZE_MAX) textSize = UI_TEXTSIZE_MAX;

		M5.Lcd.setFreeFont(nullptr);	// disable any FreeFont
		M5.Lcd.setTextFont(fontId);		// built-in font 1–4
		M5.Lcd.setTextSize(textSize);	// apply scaling

		UpdateFontMetrics();			// automatically refresh metrics
	}

	void B4RM5StickCPlus2::SetDigitFont(int fontId, float textSize) {
		if (fontId < UI_TEXTFONT_6) fontId = UI_TEXTFONT_6;
		if (fontId > UI_TEXTFONT_8) fontId = UI_TEXTFONT_8;

		if (textSize < 1) textSize = 1;

		M5.Lcd.setFreeFont(nullptr);
		M5.Lcd.setTextFont(fontId);
		M5.Lcd.setTextSize(textSize);

		UpdateFontMetrics();
	}

	void B4RM5StickCPlus2::SetFontDefault() {
		// make sure FreeFont is disabled
		M5.Lcd.setFreeFont(nullptr);
		// Reset to default built-in font
		M5.Lcd.setTextFont(UI_TEXTFONT_DEFAULT); // FONT 1
		M5.Lcd.setTextSize(UI_TEXTSIZE_DEFAULT);
		UpdateFontMetrics();
	}
	 
	void B4RM5StickCPlus2::UpdateFontMetrics() {
		currentFontWidth = M5.Lcd.fontWidth();
		currentFontHeight = M5.Lcd.fontHeight();

		// Fallbacks for proportional or digit fonts
		// i.e. fonts that don't report correct metrics
		if (currentFontWidth == 0) {
			// Approx width of one digit
			currentFontWidth = M5.Lcd.textWidth("0");
		}

		if (currentFontHeight == 0) {
			// Safe default height for small fonts
			currentFontHeight = 8;  
		}
	}

	int B4RM5StickCPlus2::GetFontWidth() {
		return currentFontWidth;
		/* NOT USED as replaced by UpdateFontMetrics
		int w = M5.Lcd.fontWidth();
		if (w == 0) {
			// Fallback: approximate from a single character
			w = M5.Lcd.textWidth("0"); // digit gives good average
		}
		return w;
		*/
	}
	
	int B4RM5StickCPlus2::GetFontHeight() { 
		return currentFontHeight;
		/* NOT USED as replaced by UpdateFontMetrics
		return M5.Lcd.fontHeight(); 
		*/
	}

	// =========================================================
	// --- LCD Draw ---
	// =========================================================

	void B4RM5StickCPlus2::DrawRect  ( int x, int y, int w, int h, int color)
	{
		M5.Lcd.drawRect  ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (uint16_t) color);
	}

	void B4RM5StickCPlus2::FillRect  ( int x, int y, int w, int h, int color)
	{
		M5.Lcd.fillRect  ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (uint16_t) color);
	}

	void B4RM5StickCPlus2::DrawRoundRect ( int x, int y, int w, int h, int r, int color)
	{
		M5.Lcd.drawRoundRect ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (int32_t) r, (uint16_t) color);
	}

	void B4RM5StickCPlus2::FillRoundRect ( int x, int y, int w, int h, int r, int color)
	{
		M5.Lcd.fillRoundRect ( (int32_t) x, (int32_t) y, (int32_t) w, (int32_t) h, (int32_t) r, (uint16_t) color);
	}

	void B4RM5StickCPlus2::DrawCircle( int x, int y, int r, int color)
	{
		M5.Lcd.drawCircle( (int32_t) x, (int32_t) y, (int32_t) r, (uint16_t) color);
	}

	void B4RM5StickCPlus2::FillCircle( int x, int y, int r, int color)
	{
		M5.Lcd.fillCircle( (int32_t) x, (int32_t) y, (int32_t) r, (uint16_t) color);
	}

	void B4RM5StickCPlus2::DrawLine  ( int x0, int y0, int x1, int y1, int color)
	{
		M5.Lcd.drawLine( (int32_t) x0, (int32_t) y0, (int32_t) x1, (int32_t) y1, (uint16_t) color);
	}

	// =========================================================
	// --- LCD Display ---
	// =========================================================

	void B4RM5StickCPlus2::StartWrite() {
		M5.Lcd.startWrite();
	}

	void B4RM5StickCPlus2::EndWrite() {
		M5.Lcd.endWrite();
	}
	
	int B4RM5StickCPlus2::GetWidth() {
		return M5.Lcd.width();
	}

	int B4RM5StickCPlus2::GetHeight() {
		return M5.Lcd.height();
	}

	int B4RM5StickCPlus2::GetCenterX() {	
		return (int)(M5.Lcd.width() / 2);
	}
	
	int B4RM5StickCPlus2::GetCenterY() {	
		return (int)(M5.Lcd.height() / 2);
	}

	bool B4RM5StickCPlus2::IsPortrait() { 
		return (currentRotation == M5_ROTATION_PORTRAIT || currentRotation == M5_ROTATION_PORTRAIT_INV); 
	}

	// =========================================================
	// --- Buttons ---
	// =========================================================

	bool B4RM5StickCPlus2::ButtonA_Pressed() {
		M5.update();
		return M5.BtnA.isPressed();
	}

	bool B4RM5StickCPlus2::ButtonB_Pressed() {
		M5.update();
		return M5.BtnB.isPressed();
	}

	// =========================================================
	// --- Power / Battery ---
	// =========================================================

	int B4RM5StickCPlus2::BatteryLevel() {
		return M5.Power.getBatteryLevel();
	}
	
	float B4RM5StickCPlus2::BatteryVoltage() {
		return M5.Power.getBatteryVoltage();		// mV
	}

	bool B4RM5StickCPlus2::IsBatteryLow() {
		return (BatteryVoltage() <= M5_BATTERY_LOW);
	}

	bool B4RM5StickCPlus2::IsBatteryCritical() { 
		return (BatteryVoltage() <= M5_BATTERY_CRITICAL); 
	}

	bool B4RM5StickCPlus2::BatteryCheck(float thresholdMv, Long delayMs) {
		// --- Read current battery voltage (mV) ---
		float voltage = BatteryVoltage();

		//::Serial.print("[B4RM5StickCPlus2::BatteryCheck][I]");
		//::Serial.print(voltage);
		//::Serial.print("/");
		//::Serial.println(thresholdMv);

		// --- Compare to threshold ---
		if (voltage <= thresholdMv) {
			::Serial.println("[B4RM5StickCPlus2::BatteryCheck][W] Voltage critical > Shutting down");

			// --- Display low battery warning ---
			M5.Lcd.fillScreen(TFT_BLACK);
			M5.Lcd.setTextColor(TFT_RED, TFT_BLACK);
			M5.Lcd.setTextSize(2);
			M5.Lcd.setCursor(10, 40);
			M5.Lcd.printf("LOW BATTERY!\n%.2f V\nShutting down...", voltage / 1000.0f);

			// --- Wait a moment so user can see message ---
			delay(delayMs);

			// --- Perform safe power off ---
			M5.Power.powerOff();
			return true;
		}

		return false; // Battery OK
	}
	
	void B4RM5StickCPlus2::DrawBattery(int voltage, bool showPercent) {
		if (showPercent) {
			DrawBatteryIconPercentageAuto(voltage);
		}
		else {
			DrawBatteryIconAuto(voltage);			
		}
	}
	
	// --- Battery Drawing Helpers ---

	void B4RM5StickCPlus2::DrawBatteryIcon(int startX, int startY, float voltage) {
		// --- Determine orientation ---
		bool portrait = IsPortrait();

		// --- Icon geometry ---
		const int w = 26;
		const int h = 12;
		const int cap = 3;
		const int innerW = w - cap - 2;
		const int innerH = h - 4;
		const int fillX = startX + 2;
		const int fillY = startY + 2;

		// --- Adjust area cleanup depending on orientation ---
		int clearW = portrait ? h + 4 : w + 4;
		int clearH = portrait ? w + 4 : h + 4;
		M5.Lcd.fillRect(startX - 2, startY - 2, clearW, clearH, TFT_BLACK);

		// --- Compute battery level (0–1) ---
		float level = (voltage - M5_BATTERY_LOW) / (M5_BATTERY_FULL - M5_BATTERY_LOW);
		if (level < 0) level = 0;
		if (level > 1) level = 1;

		// --- Outline color ---
		uint16_t outlineColor = (voltage <= M5_BATTERY_LOW) ? TFT_RED : TFT_WHITE;

		if (!portrait) {
			// ---- Landscape (horizontal battery) ----
			M5.Lcd.drawRect(startX, startY, w - cap, h, outlineColor);
			M5.Lcd.fillRect(startX + w - cap, startY + h / 3, cap, h / 3, outlineColor);

			// Fill
			uint16_t fillColor = (voltage <= M5_BATTERY_LOW) ? TFT_RED :
								 (voltage < M5_BATTERY_MID ? TFT_YELLOW : TFT_GREEN);
			int fillWidth = (int)(innerW * level);
			if (voltage <= M5_BATTERY_LOW && fillWidth == 0) fillWidth = 2;
			M5.Lcd.fillRect(fillX, fillY, fillWidth, innerH, fillColor);
		}
		else {
			// ---- Portrait (vertical battery) ----
			M5.Lcd.drawRect(startX, startY, h, w - cap, outlineColor);
			M5.Lcd.fillRect(startX + h / 3, startY, h / 3, cap, outlineColor);

			// Fill (vertical)
			uint16_t fillColor = (voltage <= M5_BATTERY_LOW) ? TFT_RED :
								 (voltage < M5_BATTERY_MID ? TFT_YELLOW : TFT_GREEN);
			int fillHeight = (int)((innerW - 2) * level);
			if (voltage <= M5_BATTERY_LOW && fillHeight == 0) fillHeight = 2;
			M5.Lcd.fillRect(startX + 2, startY + (w - cap - fillHeight), innerH, fillHeight, fillColor);
		}
	}

	// Draw battery icon + percentage at given coordinates
	void B4RM5StickCPlus2::DrawBatteryIconPercentage(int startX, int startY, float voltage) {
		bool portrait = IsPortrait();

		// --- Compute battery percentage ---
		float level = (voltage - M5_BATTERY_LOW) / (M5_BATTERY_FULL - M5_BATTERY_LOW);
		if (level < 0) level = 0;
		if (level > 1) level = 1;
		int percent = (int)(level * 100);

		// --- Colors ---
		uint16_t textColor = (voltage <= M5_BATTERY_LOW) ? TFT_RED : TFT_WHITE;
		M5.Lcd.setTextSize(1);
		M5.Lcd.setTextColor(textColor, TFT_BLACK);

		// --- Clear and draw ---
		if (portrait) {
			// Text above, icon below
			M5.Lcd.fillRect(startX - 5, startY - 20, 45, 35, TFT_BLACK);
			M5.Lcd.setCursor(startX, startY - 15);
			M5.Lcd.printf("%3d%%", percent);
			DrawBatteryIcon(startX, startY, voltage);
		}
		else {
			// Text left, icon right
			M5.Lcd.fillRect(startX - 30, startY - 2, 65, 16, TFT_BLACK);
			M5.Lcd.setCursor(startX - 25, startY);
			M5.Lcd.printf("%3d%%", percent);
			DrawBatteryIcon(startX, startY, voltage);
		}
	}

	// --- Auto placement battery functions ---

	// Draw only the battery icon automatically at the top-right corner
	void B4RM5StickCPlus2::DrawBatteryIconAuto(float voltage) {
		int x, y;

		if (IsPortrait()) {
			// Portrait: top-right area (slightly inset)
			x = GetWidth() - 30;
			y = 5;
		} else {
			// Landscape: top-right area
			x = GetWidth() - 30;
			y = 5;
		}

		DrawBatteryIcon(x, y, voltage);
	}

	// Draw battery icon + percentage automatically at the top-right corner
	void B4RM5StickCPlus2::DrawBatteryIconPercentageAuto(float voltage) {
		int x, y;

		if (IsPortrait()) {
			// Portrait: place text above icon
			x = GetWidth() - 30;
			y = 20;
		} else {
			// Landscape: same height, right-aligned
			x = GetWidth() - 30;
			y = 5;
		}

		DrawBatteryIconPercentage(x, y, voltage);
	}

	// =========================================================
	// --- Power ---
	// =========================================================
		
	void B4RM5StickCPlus2::PowerOff() {
		M5.Power.powerOff();
	}

	void B4RM5StickCPlus2::SetLed(bool state) {
		if (state) {
			M5.Power.setLed(1);
		}
		else {
			M5.Power.setLed(0);			
		}
	}

	// =========================================================
	// --- RTC ---
	// =========================================================

	bool B4RM5StickCPlus2::RTC_IsEnabled() {
		return M5.Rtc.isEnabled();
    }

	void B4RM5StickCPlus2::RTC_UpdateDateTime(void) {
		// Read current date/time from driver
		auto dt = M5.Rtc.getDateTime();
		delay(10);

		// Update the class private vars
		rtcYear   		= dt.date.year;	
		rtcMonth  		= dt.date.month;  
		rtcDate   		= dt.date.date; 
		rtcDayOfWeek	= dt.date.weekDay;
		rtcHours   		= dt.time.hours;
		rtcMinutes 		= dt.time.minutes;
		rtcSeconds 		= dt.time.seconds;

		// Optional debug
		/*
		::Serial.print("[RTC_UpdateDateTime]");
		::Serial.print(rtcYear);
		::Serial.print("-");
		::Serial.print(rtcMonth);
		::Serial.print("-");
		::Serial.print(rtcDate);
		::Serial.print(" (");
		::Serial.print(rtcDayOfWeek);
		::Serial.print(")");
		::Serial.print(" ");
		::Serial.print(rtcHours);
		::Serial.print(":");
		::Serial.print(rtcMinutes);
		::Serial.print(":");
		::Serial.println(rtcSeconds);
		*/
	}

	// Set full date (year is full 4-digit year (expected by M5Unified), month 1..12, day 1..31)
	void B4RM5StickCPlus2::RTC_SetDateTime(int year, Byte month, Byte day, Byte hours, Byte minutes, Byte seconds) {

		// Clamp
		if (month < 1) month = 1;
		if (month > 12) month = 12;
		if (day < 1) day = 1;
		if (day > 31) day = 31;
		if (hours > 23) hours = hours % 24;
		if (minutes > 59) minutes = minutes % 60;
		if (seconds > 59) seconds = seconds % 60;

		// Use direct struct initializer to avoid nested date/time confusion
		M5.Rtc.setDateTime({ { year, month, day }, { hours, minutes, seconds } });
		delay(10);
		RTC_UpdateDateTime();		
	}

	// Set full date (year is full 4-digit year, month 1..12, day 1..31)
	void B4RM5StickCPlus2::RTC_SetDate(int year, Byte month, Byte day) {
		// Clamp
		if (month < 1) month = 1;
		if (month > 12) month = 12;
		if (day < 1) day = 1;
		if (day > 31) day = 31;
		
		auto dt = M5.Rtc.getDateTime();
		dt.date.year = rtcYear;
		dt.date.month = rtcMonth;
		dt.date.date = rtcDate;
		M5.Rtc.setDateTime(dt);
		RTC_UpdateDateTime();		
	}

	// Set time (hour 0..23, minute 0..59, second 0..59)
	void B4RM5StickCPlus2::RTC_SetTime(Byte hours, Byte minutes, Byte seconds) {
		// Clamp
		if (hours > 23) hours = hours % 24;
		if (minutes > 59) minutes = minutes % 60;
		if (seconds > 59) seconds = seconds % 60;

		auto dt = M5.Rtc.getDateTime();
		dt.time.hours   = hours;
		dt.time.minutes = minutes;
		dt.time.seconds = seconds;
		M5.Rtc.setDateTime(dt);
		RTC_UpdateDateTime();
	}

	// Getters for the RTC date & time
	Byte B4RM5StickCPlus2::RTC_Hour(void)   	{ return rtcHours; }
	Byte B4RM5StickCPlus2::RTC_Minute(void) 	{ return rtcMinutes; }
	Byte B4RM5StickCPlus2::RTC_Second(void) 	{ return rtcSeconds; }
	Byte B4RM5StickCPlus2::RTC_Date(void)   	{ return rtcDate; }
	Byte B4RM5StickCPlus2::RTC_DayOfWeek(void)	{ return rtcDayOfWeek; }
	Byte B4RM5StickCPlus2::RTC_Month(void)  	{ return rtcMonth; }
	int  B4RM5StickCPlus2::RTC_Year(void)   	{ return rtcYear; }

	B4RString* B4RM5StickCPlus2::RTC_GetTimeString(void) {
		// Ensure updated time
		RTC_UpdateDateTime();

		// Buffer for HH:MM:SS
		static char buf[9]; // 8 chars + null
		snprintf(buf, sizeof(buf), "%02d:%02d:%02d", rtcHours, rtcMinutes, rtcSeconds);

		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(buf);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}

	B4RString* B4RM5StickCPlus2::RTC_GetDateString(void) {
		// Ensure updated date
		RTC_UpdateDateTime();

		// Buffer for DD/MM/YYYY
		static char buf[11]; // 10 chars + null
		snprintf(buf, sizeof(buf), "%02d/%02d/%04d", rtcDate, rtcMonth, rtcYear);

		// Wrap in B4RString
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(buf);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}

	bool B4RM5StickCPlus2::RTC_SetDateTimeFromNTP(B4RString* timezone) {
		const char* ntpServer = "pool.ntp.org";
		const char* tz = timezone->data;
		// "CET-1CEST,M3.5.0,M10.5.0/3";  // Germany/Europe DST rules

		// ::Serial.println("[B4RM5StickCPlus2::RTC_SetDateTimeFromNTP][I] Starting NTP sync...");

		struct tm timeinfo;
		
		// -------------------------------------------------------------
		// 1. Start NTP sync in UTC (no timezone yet!)
		// -------------------------------------------------------------
		configTime(0, 0, ntpServer);
		
		// 2. Wait until we actually get time from NTP
		int attempts = 0;
		while (!getLocalTime(&timeinfo) && attempts < 50) {
			delay(200);
			attempts++;
		}
		if (attempts >= 50) {
			::Serial.println("[B4RM5StickCPlus2::RTC_SetDateTimeFromNTP][E] Failed to obtain NTP time!");
			return false;
		}
		// ::Serial.println("[B4RM5StickCPlus2::RTC_SetDateTimeFromNTP][I] Got time from NTP (UTC).");

		// -------------------------------------------------------------
		// 3. Apply local timezone
		// -------------------------------------------------------------
		// ::Serial.printf("[B4RM5StickCPlus2::RTC_SetDateTimeFromNTP][I] Applying timezone: %s\n", tz);
		setenv("TZ", tz, 1);
		tzset();

		// -------------------------------------------------------------
		// 4. Re-fetch time after timezone applied
		// -------------------------------------------------------------
		if (!getLocalTime(&timeinfo)) {
			::Serial.println("[B4RM5StickCPlus2::RTC_SetDateTimeFromNTP][E] Failed to obtain localized time!");
			return false;
		}

		// -------------------------------------------------------------
		// 5. Extract values, update class vars and print
		// -------------------------------------------------------------
		rtcYear    = timeinfo.tm_year + 1900;
		rtcMonth   = timeinfo.tm_mon + 1;
		rtcDate    = timeinfo.tm_mday;
		rtcHours   = timeinfo.tm_hour;
		rtcMinutes = timeinfo.tm_min;
		rtcSeconds = timeinfo.tm_sec;

		// ::Serial.println(&timeinfo, "[B4RM5StickCPlus2::RTC_SetDateTimeFromNTP][I] %A, %B %d %Y %H:%M:%S zone %Z %z");
		return true;
	}

	// =========================================================
	// ICON DRAWER TEMPLATE FOR M5StickC PLUS
	// =========================================================

	/**
	 * Draw a battery icon with level indicator
	 * @param startX, startY: top-left corner of the icon
	 * @param voltage: battery voltage
	 */
	void B4RM5StickCPlus2::DrawIconBattery(int startX, int startY, float voltage) {
		bool portrait = IsPortrait();
		const int w = 26, h = 12, cap = 3;
		const int innerW = w - cap - 2;
		const int innerH = h - 4;
		const int fillX = startX + 2;
		const int fillY = startY + 2;
		uint16_t bg = M5.Lcd.getBaseColor();

		// Clear icon area
		int clearW = portrait ? h + 4 : w + 4;
		int clearH = portrait ? w + 4 : h + 4;
		M5.Lcd.fillRect(startX - 2, startY - 2, clearW, clearH, bg);

		// Battery level 0–1
		float level = (voltage - M5_BATTERY_LOW) / (M5_BATTERY_FULL - M5_BATTERY_LOW);
		if (level < 0) level = 0;
		if (level > 1) level = 1;

		uint16_t outlineColor = (voltage <= M5_BATTERY_LOW) ? TFT_RED : TFT_WHITE;
		uint16_t fillColor = (voltage <= M5_BATTERY_LOW) ? TFT_RED :
							 (voltage < M5_BATTERY_MID ? TFT_YELLOW : TFT_GREEN);

		if (!portrait) {
			M5.Lcd.drawRect(startX, startY, w - cap, h, outlineColor);
			M5.Lcd.fillRect(startX + w - cap, startY + h / 3, cap, h / 3, outlineColor);
			int fillWidth = (int)(innerW * level);
			if (voltage <= M5_BATTERY_LOW && fillWidth == 0) fillWidth = 2;
			M5.Lcd.fillRect(fillX, fillY, fillWidth, innerH, fillColor);
		} else {
			M5.Lcd.drawRect(startX, startY, h, w - cap, outlineColor);
			M5.Lcd.fillRect(startX + h / 3, startY, h / 3, cap, outlineColor);
			int fillHeight = (int)((innerW - 2) * level);
			if (voltage <= M5_BATTERY_LOW && fillHeight == 0) fillHeight = 2;
			M5.Lcd.fillRect(startX + 2, startY + (w - cap - fillHeight), innerH, fillHeight, fillColor);
		}
	}

	/**
	 * Draw a Wi-Fi signal icon
	 * @param strength: 0–3 bars
	 */
	void B4RM5StickCPlus2::DrawIconWiFi(int startX, int startY, int strength) {
		bool portrait = IsPortrait();
		int size = 16;
		uint16_t bg = M5.Lcd.getBaseColor();
		M5.Lcd.fillRect(startX-2, startY-2, size, size, bg);

		if (strength > 3) {
			strength = 3;
		}

		for(int i = 0; i < strength; i++){
			int barSize = (i + 1) * 3;
			int x = portrait ? startX + (size - barSize) / 2 : startX + i * 4;
			int y = portrait ? startY + size - (i+1)*4 : startY + size - barSize;
			int w = portrait ? 4 : 3;
			int h = portrait ? barSize : barSize;
			M5.Lcd.fillRect(x, y, w, h, TFT_WHITE);
		}
	}

	/**
	 * Draw a simple solar icon
	 * @param level: 0–100%
	 */
	void B4RM5StickCPlus2::DrawIconSolar(int startX, int startY, float level) {
		bool portrait = IsPortrait();
		int size = 16;
		uint16_t bg = M5.Lcd.getBaseColor();
		M5.Lcd.fillRect(startX-2, startY-2, size, size, bg);

		uint16_t fillColor = (level < 20) ? TFT_RED : TFT_YELLOW;
		M5.Lcd.drawCircle(startX + size/2, startY + size/2, size/2, TFT_WHITE);
		M5.Lcd.fillCircle(startX + size/2, startY + size/2, (int)(size/2 * (level/100.0)), fillColor);
	}

	/**
	 * Draw a grid (power) icon
	 * @param active: true = red, false = white
	 */
	void B4RM5StickCPlus2::DrawIconGrid(int startX, int startY, bool active) {
		int size = 16;
		uint16_t bg = M5.Lcd.getBaseColor();
		M5.Lcd.fillRect(startX-2, startY-2, size, size, bg);
		uint16_t color = active ? TFT_RED : TFT_WHITE;
		M5.Lcd.drawRect(startX, startY, size, size, color);
		M5.Lcd.drawLine(startX, startY + size/2, startX + size, startY + size/2, color);
		M5.Lcd.drawLine(startX + size/2, startY, startX + size/2, startY + size, color);
	}

	/**
	 * Draw a temperature icon
	 * @param tempCelsius: temperature in °C
	 */
	void B4RM5StickCPlus2::DrawIconTemp(int startX, int startY, float tempCelsius) {
		int size = 16;
		uint16_t bg = M5.Lcd.getBaseColor();
		M5.Lcd.fillRect(startX-2, startY-2, size, size, bg);

		uint16_t color = (tempCelsius > 60) ? TFT_RED : TFT_WHITE;
		M5.Lcd.drawCircle(startX + size/2, startY + size/2, size/2, color);
		M5.Lcd.fillRect(startX + size/2 - 2, startY + size/2 - 2, 4, 4, color);
	}

}
