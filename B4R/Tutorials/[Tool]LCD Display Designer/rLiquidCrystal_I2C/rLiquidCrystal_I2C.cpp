#include "B4RDefines.h"
namespace B4R {
	void B4RLiquidCrystal_I2C::Initialize(Byte Address, Byte Columns, Byte Rows) {
		lcd = new (beLcd) LiquidCrystal_I2C(Address, Columns, Rows);
		lcd->init();
		ColumnSize = Columns;
		RowSize = Rows;
	}

	void B4RLiquidCrystal_I2C::Write(Object* Message) {
		B4RStream::Print(lcd, Message);
	}

	void B4RLiquidCrystal_I2C::WriteAt(Byte Column, Byte Row, Object* Message) {
		lcd->setCursor(Column, Row);
		B4RStream::Print(lcd, Message);
	}

	void B4RLiquidCrystal_I2C::SetCursor(Byte Column, Byte Row) {
		lcd->setCursor(Column, Row);
	}

	void B4RLiquidCrystal_I2C::Clear() {
		lcd->clear();
	}

	void B4RLiquidCrystal_I2C::ClearRow(Byte Row) {
		lcd->setCursor(0, Row);
		for(int i = 0; i < ColumnSize; i++){ 
			lcd->write(0x20);
		}
	}

	void B4RLiquidCrystal_I2C::setBlink(bool State) {
		if (State)
			lcd->blink();
		else
			lcd->noBlink();
	}

	void B4RLiquidCrystal_I2C::setCursorOn(bool State) {
		if (State)
			lcd->cursor();
		else
			lcd->noCursor();
	}

	void B4RLiquidCrystal_I2C::setBacklight(bool State) {
		if (State)
			lcd->backlight();
		else
			lcd->noBacklight();
	}

	void B4RLiquidCrystal_I2C::CreateChar(Byte Location, ArrayByte* Charmap) {
		lcd->createChar(Location, (Byte*)Charmap->data);		
	}

	void B4RLiquidCrystal_I2C::WriteChar(Byte Location){
		lcd->write(Location);
	}

	void B4RLiquidCrystal_I2C::WriteCharAt(Byte Column, Byte Row, Byte Location) {
		lcd->setCursor(Column, Row);
		lcd->write(Location);		
	}



}