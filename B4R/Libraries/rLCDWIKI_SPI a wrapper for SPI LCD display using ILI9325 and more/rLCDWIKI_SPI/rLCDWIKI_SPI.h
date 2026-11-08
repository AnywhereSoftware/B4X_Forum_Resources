    //#MethOn
#pragma once
#include "B4RDefines.h"
#include "LCDWIKI_SPI.h"

    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino https://github.com/gitcnd/LCDWIKI_SPI

namespace B4R {
    //~shortname:LCDWIKI_SPI
    class B4RLCDWIKI_SPI
    {
        private:
            uint8_t backend[sizeof(LCDWIKI_SPI)];
            LCDWIKI_SPI* rcs;
        public:
        // Constructor for software spi.
        // if modules is unreadable or you don't know the width and height of modules,you can use this constructor.      
            void Initialize(uint16_t model, byte cs, byte cd, byte miso, byte mosi, byte reset, byte clk, byte led);
        // Constructor for hardware spi.
        // if modules is unreadable or you don't know the width and height of modules,you can use this constructor.           
            void Initialize1(uint16_t model, byte cs, byte cd, byte reset, byte led);
        // Constructor for software spi.
        // if modules is readable or you know the width and height of modules,you can use this constructor.          
            void Initialize2(int16_t wid, int16_t heg, byte cs, byte cd, byte miso, byte mosi, byte reset, byte clk, byte led);
        // Constructor for hardware spi.
        // if modules is readable or you know the width and height of modules,you can use this constructor.          
            void Initialize3(int16_t wid, int16_t heg, byte cs, byte cd, byte reset, byte led);
        // Initialization lcd modules
            void Init_LCD();
        // Initialization common to both shield & breakout configs      
            void reset();
            
            void start(uint16_t ID);
        //set x,y  coordinate and color to draw a pixel point       
            void Draw_Pixe(int16_t x, int16_t y, uint16_t color);
        //spi write for hardware and software      
            void Spi_Write(byte data);
        //spi read for hardware and software     
            byte Spi_Read();
                       
            void Write_Cmd(uint16_t cmd);
            
            void Write_Data(uint16_t data);
            
            void Write_Cmd_Data(uint16_t cmd, uint16_t data);
            
            void init_table8(ArrayByte* table);
            
            void init_table16(ArrayUInt* table);
        //Write a command and N datas        
            void Push_Command(byte cmd, ArrayByte* block, byte N);
        //Pass 8-bit (each) R,G,B, get back 16-bit packed color      
            uint16_t Color_To_565(byte r, byte g, byte b);
        //read LCD controller chip ID     
            uint16_t Read_ID();
        //fill area from x to x+w,y to y+h       
            void Fill_Rect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color);
        //set clockwise rotation    
            void Set_Rotation(byte r);
        //get current rotation
        //0  :  0 degree 
        //1  :  90 degree
        //2  :  180 degree
        //3  :  270 degree       
            byte Get_Rotation();
        //Anti color display      
            void Invert_Display(bool i);
        //read value from lcd register       
            uint16_t Read_Reg(uint16_t reg, byte index);
        //read graph RAM data      
            int16_t Read_GRAM(int16_t x, int16_t y, ArrayUInt* block, int16_t w, int16_t h);
        // Sets the LCD address window      
            void Set_Addr_Window(int16_t x1, int16_t y1, int16_t x2, int16_t y2);
        //push color table for 16bits      
            void Push_Any_Color(ArrayUInt* block, int16_t n, bool first, byte flags);
        //push color table for 8bits    
            void Push_Any_Color1(ArrayByte* block, int16_t n, bool first, byte flags);
        //Scroll display      
            void Vert_Scroll(int16_t top, int16_t scrollines, int16_t offset);
        //get lcd height    
            int16_t Get_Height();
        //get lcd width    
            int16_t Get_Width();
        // Unlike the 932X drivers that set the address window to the full screen
        // by default (using the address counter for drawPixel operations), the
        // 7575 needs the address window set on all graphics operations.  In order
        // to save a few register writes on each pixel drawn, the lower-right
        // corner of the address window is reset after most fill operations, so
        // that drawPixel only needs to change the upper left each time.            
            void Set_LR();
            
            void Led_control(bool i);
// class LCDWIKI_GUI 

        //set 16bits draw color   
            void Set_Draw_color(uint16_t color);
        //set 8bits r,g,b color     
            void Set_Draw_color1(byte r, byte g, byte b);
        //get draw color    
            uint16_t Get_Draw_color();
        //draw a pixel point    
            void Draw_Pixel(int16_t x, int16_t y);
        //read color data for point(x,y)    
            uint16_t Read_Pixel(int16_t x, int16_t y);
        //draw a vertical line    
            void Draw_Fast_VLine(int16_t x, int16_t y, int16_t h);
        //draw a horizontal line    
            void Draw_Fast_HLine(int16_t x, int16_t y, int16_t w);
        //Fill the full screen with color    
            void Fill_Screen(uint16_t color);
        //Fill the full screen with r,g,b     
            void Fill_Screen1(byte r, byte g, byte b);
        //draw an arbitrary line from (x1,y1) to (x2,y2)    
            void Draw_Line(int16_t x1, int16_t y1, int16_t x2, int16_t y2);
        //draw a rectangle    
            void Draw_Rectangle(int16_t x1, int16_t y1, int16_t x2, int16_t y2);
        //fill a round rectangle    
            void Fill_Rectangle(int16_t x1, int16_t y1, int16_t x2, int16_t y2);
        //draw a round rectangle    
            void Draw_Round_Rectangle(int16_t x1, int16_t y1, int16_t x2, int16_t y2, byte radius);
        //fill a round rectangle    
            void Fill_Round_Rectangle(int16_t x1, int16_t y1, int16_t x2, int16_t y2, int16_t radius);
        //draw a circle    
            void Draw_Circle(int16_t x, int16_t y, int16_t radius);
        //draw a circular bead    
            void Draw_Circle_Helper(int16_t x0, int16_t y0, int16_t radius, byte cornername);
        //fill a circle     
            void Fill_Circle(int16_t x, int16_t y, int16_t radius);
        //fill a semi-circle    
            void Fill_Circle_Helper(int16_t x0, int16_t y0, int16_t r, byte cornername, int16_t delta);
        //draw a triangle    
            void Draw_Triangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2);
        //fill a triangle    
            void Fill_Triangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2);
        //draw a bit map    
            void Draw_Bit_Map(int16_t x, int16_t y, int16_t sx, int16_t sy, ArrayUInt* data, int16_t scale);
        //set text coordinate    
            void Set_Text_Cousur(int16_t x, int16_t y);
        //get text x coordinate    
            int16_t Get_Text_X_Cousur();
        //get text y coordinate    
            int16_t Get_Text_Y_Cousur();
        //set text colour with 16bit color    
            void Set_Text_colour(uint16_t color);
        //set text colour with 8bits r,g,b    
            void Set_Text_colour1(byte r, byte g, byte b);
        //get text colour    
            uint16_t Get_Text_colour();
        //set text background colour with 16bits color   
            void Set_Text_Back_colour(uint16_t color);
        //set text background colour with 8bits r,g,b    
            void Set_Text_Back_colour1(byte r, byte g, byte b);
        //get text background colour    
            uint16_t Get_Text_Back_colour();
        //set text size   
            void Set_Text_Size(byte s);
        //get text size    
            byte Get_Text_Size();
        //set text mode    
            void Set_Text_Mode(bool mode);
        //get text mode   
            bool Get_Text_Mode();
        //print string    
            uint16_t Print(ArrayByte* st, int16_t x, int16_t y);
        //print string    
            void Print_String(ArrayByte* st, int16_t x, int16_t y);
        //print string    
            void Print_String1(ArrayByte* st, int16_t x, int16_t y);
        //print string    
            void Print_String2(B4RString* st, int16_t x, int16_t y);
        //print int number    
            void Print_Number_Int(int32_t num, int16_t x, int16_t y, int16_t length, byte filler, int16_t system);
        //print float number    
            void Print_Number_Float(double num, byte dec, int16_t x, int16_t y, byte divider, int16_t length, byte filler);
        //draw a char   
            void Draw_Char(int16_t x, int16_t y, byte c, uint16_t color, uint16_t bg, byte size, bool mode);
        //write a char    
            uint16_t write(byte c);
        //get lcd width    
            int16_t Get_Display_Width();
        //get lcd height     
            int16_t Get_Display_Height();
            
        //LCD controller chip mode identifiers
            #define /*UInt ILI9325;*/            B4RILI9325                     ILI9325
            #define /*UInt ILI9328;*/            B4RILI9328                     ILI9328
            #define /*UInt ILI9341;*/            B4RILI9341                     ILI9341
            #define /*UInt HX8357D;*/            B4RHX8357D                     HX8357D
            #define /*UInt HX8347G;*/            B4RHX8347G                     HX8347G
            #define /*UInt HX8347I;*/            B4RHX8347I                     HX8347I
            #define /*UInt ILI9486;*/            B4RILI9486                     ILI9486 
            #define /*UInt ST7735S;*/            B4RST7735S                     ST7735S
            #define /*UInt SSD1283A;*/           B4RSSD1283A                    SSD1283A
            
            #define /*Int BLACK;*/               B4RBLACK                       0x0000
            #define /*Int BLUE;*/                B4RBLUE                        0x001F
            #define /*Int RED;*/                 B4RRED                         0xF800
            #define /*Int GREEN;*/               B4RGREEN                       0x07E0
            #define /*Int CYAN;*/                B4RCYAN                        0x07FF
            #define /*Int MAGENTA;*/             B4RMAGENTA                     0xF81F
            #define /*Int YELLOW;*/              B4RYELLOW                      0xFFE0
            #define /*Int WHITE;*/               B4RWHITE                       0xFFFF
            
    };
}
