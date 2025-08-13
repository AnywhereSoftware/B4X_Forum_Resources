B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Public Text2Draw(100) As Byte
	Public TextPos_X,TextPos_Y, FontNumber As Int
	Public topx, topy, heightx,heighty As Int
	Public drawcolour As Int
	Public bc As ByteConverter
End Sub

Sub DrawTextAt(Text As String, FontNum As Int,posx As Int, posy As Int)
	'Clear Textbuffer
	For i=0 To Text2Draw.Length-1
		Text2Draw(i)=0
	Next
	TextPos_X=posx
	TextPos_Y=posy
	FontNumber=FontNum
	bc.ArrayCopy2(Text,0,Text2Draw,0,Text.Length)
	RunNative("DrawText", Null)
End Sub

Sub DrawRectangle(tx As Int,ty As Int,bx As Int,by As Int,colour As Int)
	topx=tx
	topy=ty
	heightx=bx
	heighty=by
	drawcolour=colour
	
	RunNative("DrawRectangle", Null)
	
End Sub

Sub ClearScreen
	RunNative("ClearScreen", Null)
End Sub

Sub Init_Display
	RunNative("InitDisplay", Null)
End Sub


#If C

#include <SPI.h>
#include <TFT_eSPI.h>
TFT_eSPI tft = TFT_eSPI();

void InitDisplay (B4R::Object* o) {

  tft.init();
  //tft.invertDisplay(1); //If you have a CYD2USB - https://github.com/witnessmenow/ESP32-Cheap-Yellow-Display/blob/main/cyd.md#my-cyd-has-two-usb-ports
  tft.setRotation(0); //This is the display in portrait
  
  // Clear the screen before writing to it
  tft.fillScreen(TFT_BLACK);
  
    uint16_t calData[5] = { 18, 507, 1, 1, 0 };
	  tft.setTouch(calData);

}

void DrawText (B4R::Object* o) {

  char *text2draw = (char*)b4r_display::_text2draw->data;
  tft.setTextColor(TFT_WHITE, TFT_BLACK); 
  tft.drawString(text2draw, b4r_display::_textpos_x, b4r_display::_textpos_y, b4r_display::_fontnumber); // Left Aligned
}

void ClearScreen (B4R::Object* o) {

tft.fillScreen(TFT_BLACK);
}

void DrawRectangle (B4R::Object* o) {

 
  tft.fillRect(b4r_display::_topx, b4r_display::_topy, b4r_display::_heightx, b4r_display::_heighty,b4r_display::_drawcolour);
 }


#End If





