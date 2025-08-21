#include "B4RDefines.h"
namespace B4R {
	
	int x,y,z; 
	void B4RADXL345::InitializeI2C() {
		bn = new (be) ADXL345();
	}
	
	void B4RADXL345::InitializeSPI(int CS) {
		bn = new (be) ADXL345(CS);
	}	
	
 	void B4RADXL345::powerOn() {
		bn->powerOn();
	}	
	
	void B4RADXL345::setRangeSetting(int val) { 
	    bn->setRangeSetting(val);
    }
	
	void B4RADXL345::readAccel() {   
	    bn->readAccel(&x, &y, &z);	
    }	
	
	Int B4RADXL345::getX_Accel() {
		return x;
	}
	
	Int B4RADXL345::getY_Accel() {
		return y;
	}
	
	Int B4RADXL345::getZ_Accel() {
		return z;
	}
	
	void B4RADXL345::setSpiBit(bool spiBit) {
		bn->setSpiBit(spiBit);
	}	
	
	void B4RADXL345::setActivityXYZ(bool stateX, bool stateY, bool stateZ) {
		bn->setActivityXYZ(stateX, stateY, stateZ);
	}
	
	void B4RADXL345::setActivityThreshold(int activityThreshold) {
		bn->setActivityThreshold(activityThreshold);
	}
	
	void B4RADXL345::InactivityINT(bool status){
		bn->InactivityINT(status);
	}
	
	void B4RADXL345::ActivityINT(bool status) {
		bn->ActivityINT(status);
	}
	
	void B4RADXL345::FreeFallINT(bool status) {
		bn->FreeFallINT(status);
	}
	
	void B4RADXL345::doubleTapINT(bool status) {
		bn->doubleTapINT(status);
	}
	
	void B4RADXL345::singleTapINT(bool status) {
		bn->singleTapINT(status);
	}
	
	byte B4RADXL345::getInterruptSource() {
		return bn->getInterruptSource();
	}
	
	bool B4RADXL345::triggered(byte interrupts, int mask) {
		return bn->triggered(interrupts, mask);
	}
	
	void B4RADXL345::setInactivityXYZ(bool stateX, bool stateY, bool stateZ) {
		bn->setInactivityXYZ(stateX, stateY, stateZ);
	}
	
	void B4RADXL345::setInactivityThreshold(int inactivityThreshold) {
		bn->setInactivityThreshold(inactivityThreshold);
	}
	
	void B4RADXL345::setTimeInactivity(int timeInactivity) {
		bn->setTimeInactivity(timeInactivity);
	}
	
	void B4RADXL345::setTapDetectionOnXYZ(bool stateX, bool stateY, bool stateZ) {
		bn->setTapDetectionOnXYZ(stateX, stateY, stateZ);
	}
	
	void B4RADXL345::setTapThreshold(int tapThreshold) {
		bn->setTapThreshold(tapThreshold);
	}
	
	void B4RADXL345::setTapDuration(int tapDuration) {
		bn->setTapDuration(tapDuration);
	}
	
	void B4RADXL345::setDoubleTapLatency(int doubleTapLatency) {
		bn->setDoubleTapLatency(doubleTapLatency);
	}
	
	void B4RADXL345::setDoubleTapWindow(int doubleTapWindow) {
		bn->setDoubleTapWindow(doubleTapWindow);
	}
	
	void B4RADXL345::setFreeFallThreshold(int freeFallthreshold) {
		bn->setFreeFallThreshold(freeFallthreshold);
	}
	
	void B4RADXL345::setFreeFallDuration(int freeFallDuration) {
		bn->setFreeFallDuration(freeFallDuration);
	}
	
	void B4RADXL345::printAllRegister() {
		bn->printAllRegister();
	}
	
	bool B4RADXL345::isActivityXEnabled(){
		return bn->isActivityXEnabled();
	}
	
	bool B4RADXL345::isActivityYEnabled(){
		return bn->isActivityYEnabled();
	}	

	bool B4RADXL345::isActivityZEnabled(){
		return bn->isActivityZEnabled();
	}		
	
	bool B4RADXL345::isInactivityXEnabled(){
		return bn->isInactivityXEnabled();
	}		
	
	bool B4RADXL345::isInactivityYEnabled(){
		return bn->isInactivityYEnabled();
	}		
	
	bool B4RADXL345::isInactivityZEnabled(){
		return bn->isInactivityZEnabled();
	}	
	
	bool B4RADXL345::isActivitySourceOnX(){
		return bn->isActivitySourceOnX();
	}		
	
	bool B4RADXL345::isActivitySourceOnY(){
		return bn->isActivitySourceOnY();
	}	

	bool B4RADXL345::isActivitySourceOnZ(){
		return bn->isActivitySourceOnZ();
	}	

	bool B4RADXL345::isTapSourceOnX(){
		return bn->isTapSourceOnX();
	}		
	
	bool B4RADXL345::isTapSourceOnY(){
		return bn->isTapSourceOnY();
	}		

	bool B4RADXL345::isTapSourceOnZ(){
		return bn->isTapSourceOnZ();
	}			
	
	bool B4RADXL345::isAsleep(){
		return bn->isAsleep();
	}			

	bool B4RADXL345::isLowPower(){
		return bn->isLowPower();
	}	
	
	void B4RADXL345::setLowPower(bool state) {
		bn->setLowPower(state);
	}

		
}
