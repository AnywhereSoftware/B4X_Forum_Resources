#include "B4RDefines.h"
#include "Controllino.h"
#include "SPI.h"

#define clear_port_bit(reg, bitmask) *reg &= ~bitmask;
#define set_port_bit(reg, bitmask) *reg |= bitmask;
#define pulse_high(reg, bitmask) clear_port_bit(reg, bitmask); set_port_bit(reg, bitmask);
#define pulse_low(reg, bitmask) set_port_bit(reg, bitmask); clear_port_bit(reg, bitmask);
#define clear_port(port, data) port &= data;
#define set_port(port, data) port |= data;

namespace B4R {

	Byte B4RCONTROLLINO::Init() {
		Controllino_RTC_init();
	}	
		
	Byte B4RCONTROLLINO::SetTimeDate(Byte aDay, Byte aWeekDay, Byte aMonth, Byte aYear, Byte aHour, Byte aMinute, Byte aSecond) {
		Controllino_SetTimeDate(aDay, aWeekDay, aMonth, aYear, aHour, aMinute, aSecond);
	}	
	
	Byte B4RCONTROLLINO::SetTimeDateStrings(ArrayByte* aDate, ArrayByte* aTime) {
		Controllino_SetTimeDateStrings((Byte*) aDate->data, (Byte*) aTime->data);
	}	

	Byte B4RCONTROLLINO::GetDay() {
		return Controllino_GetDay();
	}	
		
	Byte B4RCONTROLLINO::GetWeekDay() {
		return Controllino_GetWeekDay();
	}		
		
	Byte B4RCONTROLLINO::GetMonth() {
		return Controllino_GetMonth();
	}		
	
	Byte B4RCONTROLLINO::GetYear() {
		return Controllino_GetYear();
	}	
	
	Byte B4RCONTROLLINO::GetHour() {
		return Controllino_GetHour();
	}		

	Byte B4RCONTROLLINO::GetMinute() {
		return Controllino_GetMinute();
	}	

	Byte B4RCONTROLLINO::GetSecond() {
		return Controllino_GetSecond();
	}		
	
	Byte B4RCONTROLLINO::RTC_SPI_SLAVE_PIN_INIT() {
		return Controllino_RTCSSInit();
	}	
	
	Byte B4RCONTROLLINO::RTC_SPI_SLAVE_PIN_CONTROL(Byte mode) {
		return Controllino_SetRTCSS(mode);
	}		
	
	Byte B4RCONTROLLINO::RS485Init() {
		return Controllino_RS485Init();
	}	

	Byte B4RCONTROLLINO::RS485Init_with_BaudRate(long aBaudrate) {
		Controllino_RS485Init(aBaudrate);
	}	

	void B4RCONTROLLINO::RS485TxEnable() {
		Controllino_RS485TxEnable();
	}	
	
	void B4RCONTROLLINO::RS485RxEnable() {
		Controllino_RS485RxEnable();
	}	
	
	Byte B4RCONTROLLINO::SwitchRS485RE(Byte mode) {
		return Controllino_SwitchRS485RE(mode);
	}		
	
	Byte B4RCONTROLLINO::SwitchRS485DE(Byte mode) {
		return Controllino_SwitchRS485DE(mode);
	}		
	
	Byte B4RCONTROLLINO::PrintTimeAndDate() {
		return Controllino_PrintTimeAndDate();
	}		
	
	Byte B4RCONTROLLINO::ClearRTCAlarm() {
		Controllino_ClearAlarm();
	}	
	
	Byte B4RCONTROLLINO::SetRTCAlarm(Byte hour, Byte minute) {
		Controllino_SetAlarm(hour, minute);
	}	
	
	
	
	void B4RCONTROLLINO::initDDRA (B4R::Object* o) {
		 DDRA |= o->toULong();
	}

	void B4RCONTROLLINO::initDDRB (B4R::Object* o) {
		 DDRB |= o->toULong();
	}

	void B4RCONTROLLINO::initDDRC (B4R::Object* o) {
		 DDRC |= o->toULong();
	}

	void B4RCONTROLLINO::initDDRD (B4R::Object* o) {
		 DDRD |= o->toULong();
	}

	void B4RCONTROLLINO::initDDRE (B4R::Object* o) {
		 DDRE |= o->toULong();
	}

	void B4RCONTROLLINO::initDDRF (B4R::Object* o) {
		 DDRF |= o->toULong();
	}

	void B4RCONTROLLINO::initDDRG (B4R::Object* o) {
		 DDRG |= o->toULong();
	}

	void B4RCONTROLLINO::initDDRH (B4R::Object* o) {
		 DDRH |= o->toULong();
	}

	void B4RCONTROLLINO::initDDRJ (B4R::Object* o) {
		 DDRJ |= o->toULong();
	}

	void B4RCONTROLLINO::initDDRK (B4R::Object* o) {
		 DDRK |= o->toULong();
	}

	void B4RCONTROLLINO::initDDRL (B4R::Object* o) {
		 DDRL |= o->toULong();
	}	
	
	
	
	
	void B4RCONTROLLINO::ClearPortA (B4R::Object* o) {
	  clear_port(PORTA, o->toULong());
	}
	void B4RCONTROLLINO::SetPortA (B4R::Object* o) {
	  set_port(PORTA, o->toULong());
	}

	void B4RCONTROLLINO::ClearPortB (B4R::Object* o) {
	  clear_port(PORTB, o->toULong());
	}
	void B4RCONTROLLINO::SetPortB (B4R::Object* o) {
	  set_port(PORTB, o->toULong());
	}

	void B4RCONTROLLINO::ClearPortC (B4R::Object* o) {
	  clear_port(PORTC, o->toULong());
	}
	void B4RCONTROLLINO::SetPortC (B4R::Object* o) {
	  set_port(PORTC, o->toULong());
	}

	void B4RCONTROLLINO::ClearPortD (B4R::Object* o) {
	  clear_port(PORTD, o->toULong());
	}
	void B4RCONTROLLINO::SetPortD (B4R::Object* o) {
	  set_port(PORTD, o->toULong());
	}

	void B4RCONTROLLINO::ClearPortE (B4R::Object* o) {
	  clear_port(PORTE, o->toULong());
	}
	void B4RCONTROLLINO::SetPortE (B4R::Object* o) {
	  set_port(PORTE, o->toULong());
	}

	void B4RCONTROLLINO::ClearPortF (B4R::Object* o) {
	  clear_port(PORTF, o->toULong());
	}
	void B4RCONTROLLINO::SetPortF (B4R::Object* o) {
	  set_port(PORTF, o->toULong());
	}

	void B4RCONTROLLINO::ClearPortG (B4R::Object* o) {
	  clear_port(PORTG, o->toULong());
	}
	void B4RCONTROLLINO::SetPortG (B4R::Object* o) {
	  set_port(PORTG, o->toULong());
	}

	void B4RCONTROLLINO::ClearPortH (B4R::Object* o) {
	  clear_port(PORTH, o->toULong());
	}
	void B4RCONTROLLINO::SetPortH (B4R::Object* o) {
	  set_port(PORTH, o->toULong());
	}

	void B4RCONTROLLINO::ClearPortJ (B4R::Object* o) {
	  clear_port(PORTJ, o->toULong());
	}
	void B4RCONTROLLINO::SetPortJ (B4R::Object* o) {
	  set_port(PORTJ, o->toULong());
	}

	void B4RCONTROLLINO::ClearPortK (B4R::Object* o) {
	  clear_port(PORTK, o->toULong());
	}
	void B4RCONTROLLINO::SetPortK (B4R::Object* o) {
	  set_port(PORTK, o->toULong());
	}

	void B4RCONTROLLINO::ClearPortL (B4R::Object* o) {
	  clear_port(PORTL, o->toULong());
	}
	void B4RCONTROLLINO::SetPortL (B4R::Object* o) {
	  set_port(PORTL, o->toULong());
	}
	
	
}
