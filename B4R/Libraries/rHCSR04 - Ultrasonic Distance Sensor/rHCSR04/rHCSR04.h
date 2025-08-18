// Library rHCSR04 for the Ultrasonic Sensor HC-SR04.
// The sensor uses sonar to determine the distance to an object in the range between 2 to 400 cm (accuracy 0.3 cm).
// Additional Libraries required:
// None
// Additional Classes required (which are included in the wrapped library folder):
// None
// v1.3 (Build 20210728) rwbl
#pragma once
#include "B4RDefines.h"
//~author: Robert W.B. Linn
//~version: 1.3
//~event: DistanceChanged(Distance As Double)
namespace B4R
{
	//~shortname: HCSR04
	//Declare type used for the event
	typedef void (*SubVoidDouble)(Double d);
	class B4RHCSR04
	{
		private:
			SubVoidDouble DistanceChangedSub;
			static void checkDistanceLooper(void* b);
			Byte trig;	// Trigger pin
			Byte echo;	// Echo pin
			double distanceprev;
			double distancechangedby;

		public:
			/**
			* Init the object. The sensor reads from 2cm to 400cm (accuracy 0.3cm).
			* TriggerPin - Pin number of the trigger.
			* EchoPin - Pin number of the echo received.
			* Return
			* None
			* Example:<code>
			* Private DistanceSensor As HCSR04
			* Private TriggerPinNr As Byte = 13
			* Private EchoPinNr As Byte  = 12
			* DistanceSensor.Initialize(TriggerPinNr, EchoPinNr)
			* </code>
			*/
			void Initialize(Byte TriggerPin, Byte EchoPin);

			/**
			* Init the object with callback event. The sensor reads from 2 to 400cm (accuracy 0.3cm).
			* DistanceChangedSub - Sub to handle distance changes.
			* DistanceChangedBy - Min Distance changed absolute value to set callback value in distancechangedsub.
			* TriggerPin - Pin number of the trigger.
			* EchoPin - Pin number of the echo.
			* Return
			* None
			* Example:<code>
			* Private DistanceSensor As HCSR04
			* Private TriggerPinNr As Byte = 13
			* Private EchoPinNr As Byte  = 12
			* DistanceSensor.Initialize2("DistanceChanged", 1.0, TriggerPinNr, EchoPinNr)
			*
			* ' Handle distance changes >= DISTANCECHANGEDBY value
			* Private Sub DistanceChanged(Distance As Double)
			*	Log("DistanceChanged Data: ", Distance)
			* End Sub
			* </code>
			*/
			void Initialize2(SubVoidDouble DistanceChangedSub, double DistanceChangedBy, Byte TriggerPin, Byte EchoPin);
			
			/**
			* Get the distance in cm.
			* Return
			* Distance or -1 if error.
			* Example:<code>
			* ' Get the distance (in cm) from the sensor
			* Distance = DistanceSensor.Distance
			* ' Log the distance without handling innaccurate values
			* Log("Distance (cm):",Distance)
			* </code>
			*/
			double getDistance();

			/**
			* Get the distance in inch.
			* Return
			* Distance or -1 if error.
			* Example:<code>
			* ' Get the distance from the sensor
			* Distance = DistanceSensor.DistanceInch
			* ' Log the distance without handling innaccurate values
			* Log("Distance (Inch):",Distance)
			* </code>
			*/
			double getDistanceInch();
	};
	//End class definition
}