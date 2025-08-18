// Library rHCSR04
#include "B4RDefines.h"
namespace B4R
{
	void B4RHCSR04::Initialize(Byte TriggerPin, Byte EchoPin)
	{
		// Trigger Pin
		this->trig = TriggerPin;
		pinMode(this->trig, OUTPUT);
		digitalWrite(this->trig, HIGH);
		// Echo Pin
		this->echo = EchoPin;
		pinMode(this->echo, INPUT); 
		digitalWrite(this->echo, LOW);
	}

	void B4RHCSR04::Initialize2(SubVoidDouble DistanceChangedSub, double DistanceChangedBy, Byte TriggerPin, Byte EchoPin)
	{
		// Distancechanged sub and factor
		this->DistanceChangedSub = DistanceChangedSub;
		this->distancechangedby = DistanceChangedBy;
		// Trigger Pin
		this->trig = TriggerPin;
		pinMode(this->trig, OUTPUT);
		digitalWrite(this->trig, HIGH);
		// Echo Pin
		this->echo = EchoPin;
		pinMode(this->echo, INPUT); 
		digitalWrite(this->echo, LOW);
		this->distanceprev = -1;
		// Short delay to ensure sensor is initialized
		delayMicroseconds(2);
		// Add the looper to check the distance
		FunctionUnion fu;
		fu.PollerFunction = checkDistanceLooper;
		pollers.add(fu, this);
	}

	double B4RHCSR04::getDistance()
	{
		double duration;	//ms
		double distance;	//cm

		// Short 2ms LOW pulse to get a clean HIGH pulse.
		digitalWrite(this->trig, LOW);  
		delayMicroseconds(2); 
  
		// Trigger the sensor by a HIGH pulse of 10ms.
		digitalWrite(this->trig, HIGH);
		delayMicroseconds(10);   
		// Set the trigger back to LOW pulse.
		digitalWrite(this->trig, LOW);

		// Read the sensor signal.
		// HIGH pulse whose duration (ms) is the time from the sending
		// the ping to receiving the echo of an object.
		noInterrupts();
		duration = pulseIn(this->echo, HIGH);
		interrupts();
		
		// Calculate the distance in cm
		// distance = (duration / 2) x speed of sound
		// Speed of sound: 343m/s = 0.0343 cm/uS = 1/29.1 cm/uS
		distance = -1;
		if (duration > 0){
			// Divide duration by 2: sent wave > hit object > returned to sensor.
			distance = (duration / 2) / 29.1;
		}
		// Return the result. If error, -1 is returned
		return distance;
	}

	double B4RHCSR04::getDistanceInch()
	{
		double distance = getDistance();
		return distance * 0.393701;
	}

	// Update DistanceChangedSub (see Initialize2)
	void B4RHCSR04::checkDistanceLooper(void* b) {
		B4RHCSR04* me = (B4RHCSR04*)b;
		double distancecur = me->getDistance();
		double distancechanged = distancecur - me->distanceprev;
		if (distancechanged < 0){ distancechanged = distancechanged * -1; }
		if (distancechanged >= me->distancechangedby){
			me->DistanceChangedSub(distancecur);
			me->distanceprev = distancecur;
		}
	}

}
