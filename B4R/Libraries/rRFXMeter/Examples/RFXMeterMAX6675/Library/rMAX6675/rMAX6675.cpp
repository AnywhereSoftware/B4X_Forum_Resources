#include "B4RDefines.h"
namespace B4R {

	void B4RMAX6675::Initialize(Byte SCK, Byte CS, Byte SO){
		max = new (beMAX6675) MAX6675(SCK, CS, SO);
		// Wait for the MAX6675 chip to stabilize after initialization
		delay(500); 
	}

	double B4RMAX6675::ReadCelsius(void){
		return max->readCelsius();
	}

	double B4RMAX6675::ReadFahrenheit(void){
		return max->readFahrenheit();
	}
	
}
