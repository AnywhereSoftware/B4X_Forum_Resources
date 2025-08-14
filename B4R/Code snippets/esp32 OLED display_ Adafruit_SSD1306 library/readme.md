### esp32 OLED display: Adafruit_SSD1306 library by peacemaker
### 08/04/2025
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/168085/)

Basing on <https://github.com/adafruit/Adafruit_SSD1306>  
  

```B4X
'module name: esp_oled  
'I2C device found at address: 0x3C (60)   
'https://github.com/adafruit/Adafruit_SSD1306  
'v.0.16  
Sub Process_Globals  
    'Setup I2C pins   
    Dim pinSDAnumber As Byte = 5   'ignore GPIO5 (SDA), for ex.  
    Dim pinSCLnumber As Byte = 6   'ignore GPIO6 (SCL), for ex.  
    Dim Line_OffsetX As Byte = 30            'default text line X position, pixels  
    Dim Line_OffsetY As Byte = 25            'default text line Y position, pixels  
    Dim Line_FontSize As Byte = 1    'default font height size1 is minimal = 8 pixels, size2 = 16 px…  
    Dim Ready_flag As Boolean 'ignore  
    Dim Busy_flag As Boolean 'ignore  
End Sub  
  
Sub SSD1306_Start  
    Log("Initializing SSD1306…")  
    Dim SCL, SDA As Pin  
    SDA.Initialize(pinSDAnumber, SCL.MODE_INPUT_PULLUP)  
    SCL.Initialize(pinSCLnumber, SCL.MODE_INPUT_PULLUP)  
    ' Initialize I2C communication  
    RunNative("setupI2C", Null)  
      
    ' Try to initialize the display  
    If RunNative("setup_SSD1306", Null).As(Byte) = 0 Then  
        Ready_flag = False  
        Log("Error: Display not found!")  
        Return  
    End If  
    Display_ON  
    ' Clear display  
    RunNative("SSD1306_cleardisplay", Null)  
    Ready_flag = True  
    Busy_flag = False  
End Sub  
  
Sub Show_Number(num As Byte, Overlap As Boolean)  
    If Busy_flag Then Return  
    Busy_flag = True  
    If Not(Overlap) Then RunNative("SSD1306_cleardisplay", Null)  
    RunNative("SSD1306_title", num.As(String))  
    RunNative("SSD1306_updatedisplay", Null)  
    Busy_flag = False  
End Sub  
  
Sub Show_Float(num As Float, Overlap As Boolean)  
    If Busy_flag Then Return  
    Busy_flag = True  
    If Not(Overlap) Then RunNative("SSD1306_cleardisplay", Null)  
    RunNative("SSD1306_small_text", others.Numb2(num))  
    RunNative("SSD1306_updatedisplay", Null)  
    Busy_flag = False  
End Sub  
  
Sub Show_Line(txt As String, Overlap As Boolean)  
    If Busy_flag Then Return  
    Busy_flag = True  
    If Not(Overlap) Then RunNative("SSD1306_cleardisplay", Null)  
    RunNative("SSD1306_show_line", txt)  
    RunNative("SSD1306_updatedisplay", Null)  
    Busy_flag = False  
End Sub  
  
Sub Display_OFF  
    RunNative("PowerOff_OLED", Null)  
End Sub  
  
Sub Display_ON  
    RunNative("PowerOn_OLED", Null)  
End Sub  
  
Sub Show_5_Lines(Overlap As Boolean)  
    If Busy_flag Then Return  
    Busy_flag = True  
    'text with CRLF between lines  
    Line_FontSize = 1  
    Dim multiLine As String  = JoinStrings(Array As String("Hours=", esprtc_livecounter.Hours, CRLF, "ChrgA=", others.Numb3(Main.Icharge), _   
    CRLF, "Led,A=", others.Numb3(Main.Idischarge), CRLF, "BatAh=", others.Numb3(esprtc_livecounter.BatCapacity), CRLF, "Bat,V=", others.Numb3(esp_ina3221.Voltage1)))  
    If Not(Overlap) Then RunNative("SSD1306_cleardisplay", Null)  
    RunNative("SSD1306_5_small_lines", multiLine)  
    Busy_flag = False  
End Sub  
  
#if C  
#include <Wire.h>  
#include <Adafruit_SSD1306.h>  
#include <Adafruit_GFX.h>  
  
// Display dimensions  
#define SCREEN_WIDTH 128  
#define SCREEN_HEIGHT 64  
#define I2C_ADDRESS  0x3C   
  
// Display object initialization (-1 means no reset pin)  
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);  
B4R::Object returnvalue_esp_oled;  
  
// Initialize I2C with custom pins  
void setupI2C(B4R::Object* unused) {  
    Wire.begin(b4r_esp_oled::_pinsdanumber, b4r_esp_oled::_pinsclnumber);  // SDA, SCL  
}  
  
// Display initialization  
B4R::Object* setup_SSD1306(B4R::Object* unused) {  
    // Address 0x3C for most OLED displays  
    if (!display.begin(SSD1306_SWITCHCAPVCC, I2C_ADDRESS)) {  
        return returnvalue_esp_oled.wrapNumber((Byte)0);  
    }  
    display.display();  // Show initial buffer  
    delay(100);  
    return returnvalue_esp_oled.wrapNumber((Byte)1);  
}  
  
// Clear display buffer  
void SSD1306_cleardisplay(B4R::Object* unused) {  
    display.clearDisplay();  
}  
  
// Display title text  
void SSD1306_title(B4R::Object* String) {  
    const char* Text = (const char*)String->data.PointerField;  
    display.setTextSize(3);              // Set text size  
    display.setTextColor(SSD1306_WHITE); // White text  
    display.setCursor(35, 35);             // Top-left position  
    display.println(Text);               // Print text  
}  
  
// Display small text  
void SSD1306_small_text(B4R::Object* String) {  
    const char* Text = (const char*)String->data.PointerField;  
    display.setTextSize(2);              // Set text size  
    display.setTextColor(SSD1306_WHITE); // White text  
    display.setCursor(35, 35);             // Top-left position  
    display.println(Text);               // Print text  
}  
  
// Display 5 lines  
void SSD1306_5_small_lines(B4R::Object* String) {  
    const char* Text = (const char*)String->data.PointerField;  
    int qty = 5;  
      
    // Split the input text by CRLF ("\r\n")  
    char* lines[qty] = {NULL, NULL, NULL, NULL, NULL};  
    char* textCopy = strdup(Text); // Create a copy to tokenize  
    char* token = strtok(textCopy, "\r\n");  
      
    for (int i = 0; i < qty && token != NULL; i++) {  
        lines = token;  
        token = strtok(NULL, "\r\n");  
    }  
      
    display.setTextSize(1);              // Set text size to 1 (smallest)  
    display.setTextColor(SSD1306_WHITE); // White text  
      
    // Starting position  
    int startX = b4r_esp_oled::_line_offsetx;  
    int startY = b4r_esp_oled::_line_offsety;  
    int lineHeight = 8 * b4r_esp_oled::_line_fontsize; // font size1 = 8 pixels  
      
    // Display each line with vertical spacing  
    for (int i = 0; i < qty; i++) {  
        if (lines != NULL) {  
            display.setCursor(startX, startY + (i * lineHeight));  
            display.println(lines);  
        }  
    }  
      
    free(textCopy); // Free the copied string  
    display.display(); // Update the display  
}  
  
// Display text line  
void SSD1306_show_line(B4R::Object* String) {  
    const char* Text = (const char*)String->data.PointerField;  
    display.setTextSize(b4r_esp_oled::_line_fontsize);              // Set text size  
    display.setTextColor(SSD1306_WHITE); // White text  
    display.setCursor(b4r_esp_oled::_line_offsetx, b4r_esp_oled::_line_offsety);             // Top-left position  
    display.println(Text);               // Print text  
}  
  
// Update display to show buffer contents  
void SSD1306_updatedisplay(B4R::Object* unused) {  
    display.display();  
}  
  
void PowerOff_OLED(B4R::Object* unused) {  
    display.ssd1306_command(SSD1306_DISPLAYOFF);  
}  
  
void PowerOn_OLED(B4R::Object* unused) {  
    display.ssd1306_command(SSD1306_DISPLAYON);  
}  
#End If
```

  
  
![](https://www.b4x.com/android/forum/attachments/165797)