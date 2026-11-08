
#include "B4RDefines.h"

namespace B4R
{

    void B4RLCDWIKI_SPI::Initialize(uint16_t model,byte cs, byte cd, byte miso, byte mosi, byte reset, byte clk, byte led)
    {
       rcs = new (backend) LCDWIKI_SPI( model, cs, cd, miso, mosi, reset, clk, led);
    };
    void B4RLCDWIKI_SPI::Initialize1(uint16_t model,byte cs, byte cd, byte reset,byte led)
    {
       rcs = new (backend) LCDWIKI_SPI( model, cs, cd, reset, led);
    };
    void B4RLCDWIKI_SPI::Initialize2(int16_t wid,int16_t heg,byte cs, byte cd, byte miso, byte mosi, byte reset, byte clk,byte led)
    {
       rcs = new (backend) LCDWIKI_SPI( wid, heg, cs, cd, miso, mosi, reset, clk, led);
    };
    void B4RLCDWIKI_SPI::Initialize3(int16_t wid,int16_t heg,byte cs,byte cd,byte reset,byte led)
    {
       rcs = new (backend) LCDWIKI_SPI(wid, heg, cs, cd, reset, led);
    };            

    void B4RLCDWIKI_SPI::Init_LCD()
    {
       rcs->Init_LCD();
    };

    void B4RLCDWIKI_SPI::reset()
    {
       rcs->reset();
    };

    void B4RLCDWIKI_SPI::start(uint16_t ID)
    {
       rcs->start(ID);
    };

    void B4RLCDWIKI_SPI::Draw_Pixe(int16_t x, int16_t y, uint16_t color)
    {
       rcs->Draw_Pixe(x, y, color);
    };

    void B4RLCDWIKI_SPI::Spi_Write(byte data)
    {
       rcs->Spi_Write(data);
    };

    byte B4RLCDWIKI_SPI::Spi_Read()
    {
       return rcs->Spi_Read();
    };

    void B4RLCDWIKI_SPI::Write_Cmd(uint16_t cmd)
    {
       rcs->Write_Cmd(cmd);
    };

    void B4RLCDWIKI_SPI::Write_Data(uint16_t data)
    {
       rcs->Write_Data(data);
    };

    void B4RLCDWIKI_SPI::Write_Cmd_Data(uint16_t cmd, uint16_t data)
    {
       rcs->Write_Cmd_Data(cmd, data);
    };

    void B4RLCDWIKI_SPI::init_table8(ArrayByte* table)
    {
       rcs->init_table8((byte*)table->data, table->length);
    };

    void B4RLCDWIKI_SPI::init_table16(ArrayUInt* table)
    {
       rcs->init_table16((uint16_t*)table->data, table->length);
    };

    void B4RLCDWIKI_SPI::Push_Command(byte cmd, ArrayByte* block, byte N)
    {
       rcs->Push_Command(cmd, (byte*)block->data, N);
    };

    uint16_t B4RLCDWIKI_SPI::Color_To_565(byte r, byte g, byte b)
    {
       return rcs->Color_To_565(r, g, b);
    };

    uint16_t B4RLCDWIKI_SPI::Read_ID()
    {
       return rcs->Read_ID();
    };

    void B4RLCDWIKI_SPI::Fill_Rect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color)
    {
       rcs->Fill_Rect(x, y, w, h, color);
    };

    void B4RLCDWIKI_SPI::Set_Rotation(byte r)
    {
       rcs->Set_Rotation(r);
    };

    byte B4RLCDWIKI_SPI::Get_Rotation()
    {
       return rcs->Get_Rotation();
    };

    void B4RLCDWIKI_SPI::Invert_Display(bool i)
    {
       rcs->Invert_Display(i);
    };

    uint16_t B4RLCDWIKI_SPI::Read_Reg(uint16_t reg, byte index)
    {
       return rcs->Read_Reg(reg, index);
    };

    int16_t B4RLCDWIKI_SPI::Read_GRAM(int16_t x, int16_t y, ArrayUInt* block, int16_t w, int16_t h)
    {
       return rcs->Read_GRAM(x, y, (uint16_t*)block->data, w, h);
    };

    void B4RLCDWIKI_SPI::Set_Addr_Window(int16_t x1, int16_t y1, int16_t x2, int16_t y2)
    {
       rcs->Set_Addr_Window(x1, y1, x2, y2);
    };

    void B4RLCDWIKI_SPI::Push_Any_Color(ArrayUInt* block, int16_t n, bool first, byte flags)
    {
       rcs->Push_Any_Color((uint16_t*)block->data, n, first, flags);
    };

    void B4RLCDWIKI_SPI::Push_Any_Color1(ArrayByte* block, int16_t n, bool first, byte flags)
    {
       rcs->Push_Any_Color((byte*)block->data, n, first, flags);
    };

    void B4RLCDWIKI_SPI::Vert_Scroll(int16_t top, int16_t scrollines, int16_t offset)
    {
       rcs->Vert_Scroll(top, scrollines, offset);
    };

    int16_t B4RLCDWIKI_SPI::Get_Height()
    {
       return rcs->Get_Height();
    };

    int16_t B4RLCDWIKI_SPI::Get_Width()
    {
       return rcs->Get_Width();
    };

    void B4RLCDWIKI_SPI::Set_LR()
    {
       rcs->Set_LR();
    };

    void B4RLCDWIKI_SPI::Led_control(bool i)
    {
       rcs->Led_control(i);
    };

// class LCDWIKI_GUI

    void B4RLCDWIKI_SPI::Set_Draw_color(uint16_t color)
    {
       rcs->Set_Draw_color(color);
    };

    void B4RLCDWIKI_SPI::Set_Draw_color1(byte r, byte g, byte b)
    {
       rcs->Set_Draw_color(r, g, b);
    };

    uint16_t B4RLCDWIKI_SPI::Get_Draw_color()
    {
       return rcs->Get_Draw_color();
    };

    void B4RLCDWIKI_SPI::Draw_Pixel(int16_t x, int16_t y)
    {
       rcs->Draw_Pixel(x, y);
    };

    uint16_t B4RLCDWIKI_SPI::Read_Pixel(int16_t x, int16_t y)
    {
       return rcs->Read_Pixel(x, y);
    };

    void B4RLCDWIKI_SPI::Draw_Fast_VLine(int16_t x, int16_t y, int16_t h)
    {
       rcs->Draw_Fast_VLine(x, y, h);
    };

    void B4RLCDWIKI_SPI::Draw_Fast_HLine(int16_t x, int16_t y, int16_t w)
    {
       rcs->Draw_Fast_HLine(x, y, w);
    };

    void B4RLCDWIKI_SPI::Fill_Screen(uint16_t color)
    {
       rcs->Fill_Screen(color);
    };

    void B4RLCDWIKI_SPI::Fill_Screen1(byte r, byte g, byte b)
    {
       rcs->Fill_Screen(r, g, b);
    };

    void B4RLCDWIKI_SPI::Draw_Line(int16_t x1, int16_t y1, int16_t x2, int16_t y2)
    {
       rcs->Draw_Line(x1, y1, x2, y2);
    };

    void B4RLCDWIKI_SPI::Draw_Rectangle(int16_t x1, int16_t y1, int16_t x2, int16_t y2)
    {
       rcs->Draw_Rectangle(x1, y1, x2, y2);
    };

    void B4RLCDWIKI_SPI::Fill_Rectangle(int16_t x1, int16_t y1, int16_t x2, int16_t y2)
    {
       rcs->Fill_Rectangle(x1, y1, x2, y2);
    };

    void B4RLCDWIKI_SPI::Draw_Round_Rectangle(int16_t x1, int16_t y1, int16_t x2, int16_t y2, byte radius)
    {
       rcs->Draw_Round_Rectangle(x1, y1, x2, y2, radius);
    };

    void B4RLCDWIKI_SPI::Fill_Round_Rectangle(int16_t x1, int16_t y1, int16_t x2, int16_t y2, int16_t radius)
    {
       rcs->Fill_Round_Rectangle(x1, y1, x2, y2, radius);
    };

    void B4RLCDWIKI_SPI::Draw_Circle(int16_t x, int16_t y, int16_t radius)
    {
       rcs->Draw_Circle(x, y, radius);
    };

    void B4RLCDWIKI_SPI::Draw_Circle_Helper(int16_t x0, int16_t y0, int16_t radius, byte cornername)
    {
       rcs->Draw_Circle_Helper(x0, y0, radius, cornername);
    };

    void B4RLCDWIKI_SPI::Fill_Circle(int16_t x, int16_t y, int16_t radius)
    {
       rcs->Fill_Circle(x, y, radius);
    };

    void B4RLCDWIKI_SPI::Fill_Circle_Helper(int16_t x0, int16_t y0, int16_t r, byte cornername, int16_t delta)
    {
       rcs->Fill_Circle_Helper(x0, y0, r, cornername, delta);
    };

    void B4RLCDWIKI_SPI::Draw_Triangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2)
    {
       rcs->Draw_Triangle(x0, y0, x1, y1, x2, y2);
    };

    void B4RLCDWIKI_SPI::Fill_Triangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2)
    {
       rcs->Fill_Triangle(x0, y0, x1, y1, x2, y2);
    };

    void B4RLCDWIKI_SPI::Draw_Bit_Map(int16_t x, int16_t y, int16_t sx, int16_t sy, ArrayUInt* data, int16_t scale)
    {
       rcs->Draw_Bit_Map(x, y, sx, sy, (uint16_t*)data->data, scale);
    };

    void B4RLCDWIKI_SPI::Set_Text_Cousur(int16_t x, int16_t y)
    {
       rcs->Set_Text_Cousur(x, y);
    };

    int16_t B4RLCDWIKI_SPI::Get_Text_X_Cousur()
    {
       return rcs->Get_Text_X_Cousur();
    };

    int16_t B4RLCDWIKI_SPI::Get_Text_Y_Cousur()
    {
       return rcs->Get_Text_Y_Cousur();
    };

    void B4RLCDWIKI_SPI::Set_Text_colour(uint16_t color)
    {
       rcs->Set_Text_colour(color);
    };

    void B4RLCDWIKI_SPI::Set_Text_colour1(byte r, byte g, byte b)
    {
       rcs->Set_Text_colour(r, g, b);
    };

    uint16_t B4RLCDWIKI_SPI::Get_Text_colour()
    {
       return rcs->Get_Text_colour();
    };

    void B4RLCDWIKI_SPI::Set_Text_Back_colour(uint16_t color)
    {
       rcs->Set_Text_Back_colour(color);
    };

    void B4RLCDWIKI_SPI::Set_Text_Back_colour1(byte r, byte g, byte b)
    {
       rcs->Set_Text_Back_colour(r, g, b);
    };

    uint16_t B4RLCDWIKI_SPI::Get_Text_Back_colour()
    {
       return rcs->Get_Text_Back_colour();
    };

    void B4RLCDWIKI_SPI::Set_Text_Size(byte s)
    {
       rcs->Set_Text_Size(s);
    };

    byte B4RLCDWIKI_SPI::Get_Text_Size()
    {
       return rcs->Get_Text_Size();
    };

    void B4RLCDWIKI_SPI::Set_Text_Mode(bool mode)
    {
       rcs->Set_Text_Mode(mode);
    };

    bool B4RLCDWIKI_SPI::Get_Text_Mode()
    {
       return rcs->Get_Text_Mode();
    };

    uint16_t B4RLCDWIKI_SPI::Print(ArrayByte* st, int16_t x, int16_t y)
    {
       return rcs->Print((byte*)st->data, x, y);
    };

    void B4RLCDWIKI_SPI::Print_String(ArrayByte* st, int16_t x, int16_t y)
    {
       rcs->Print_String((byte*)st->data, x, y);
    };

    void B4RLCDWIKI_SPI::Print_String1(ArrayByte* st, int16_t x, int16_t y)
    {
       rcs->Print_String((byte*)st->data, x, y);
    };

    void B4RLCDWIKI_SPI::Print_String2(B4RString* st, int16_t x, int16_t y)
    {
       rcs->Print_String(st->data, x, y);
    };

    void B4RLCDWIKI_SPI::Print_Number_Int(int32_t num, int16_t x, int16_t y, int16_t length, byte filler, int16_t system)
    {
       rcs->Print_Number_Int(num, x, y, length, filler, system);
    };

    void B4RLCDWIKI_SPI::Print_Number_Float(double num, byte dec, int16_t x, int16_t y, byte divider, int16_t length, byte filler)
    {
       rcs->Print_Number_Float(num, dec, x, y, divider, length, filler);
    };

    void B4RLCDWIKI_SPI::Draw_Char(int16_t x, int16_t y, byte c, uint16_t color, uint16_t bg, byte size, bool mode)
    {
       rcs->Draw_Char(x, y, c, color, bg, size, mode);
    };

    uint16_t B4RLCDWIKI_SPI::write(byte c)
    {
       return rcs->write(c);
    };

    int16_t B4RLCDWIKI_SPI::Get_Display_Width()
    {
       return rcs->Get_Display_Width();
    };

    int16_t B4RLCDWIKI_SPI::Get_Display_Height()
    {
       return rcs->Get_Display_Height();
    };


}
