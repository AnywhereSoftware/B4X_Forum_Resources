#pragma once
#include "B4RDefines.h"
#include "SRF05.h"

    //~Version: 1.0 
    //~Author - 
    //~Libray from https://github.com/RobTillaart/SRF05

namespace B4R {
    //~shortname:SRF05
    class B4RSRF05
    {
        private:
            uint8_t backend[sizeof(SRF05)];
            SRF05* rcs;
        public: 
              //  constructor to set the trigger and echo pin. OUT pin is not used yet.
            void Initialize(byte trigger,byte echo,byte out);
              //  adjust the speed of sound. See table in https:/ /github.com/RobTillaart/SRF05 page
            void setSpeedOfSound(double sos);                                   //#Meth
              //  return set value
            double getSpeedOfSound();                                           //#Meth
              //  adjust the timing by a few percentage e.g. to adjust clocks.
              // Typical values are between 0.95 and 1.05 to correct up to 5%.
              // Should not be used to correct the speed of sound.
              // Returns false if factor less or = 0.
            bool setCorrectionFactor(double factor);                            //#Meth
             //  returns the current correction factor
            double getCorrectionFactor();                                       //#Meth
              //  read a single time.
              // This is the default and typical the fastest.
            void setModeSingle();                                               //#Meth
              //  read count times and take the average. 
              //  Note: between the reads there is a delay of 1 millisecond.
            void setModeAverage(byte count);                                    //#Meth
              // read count times and take the median.
              // count must between 3 and 15 otherwise it is clipped.
              // Note: between the reads there is a delay of 1 millisecond 
            void setModeMedian(byte count);                                     //#Meth
              //  use a running average algorithm with a weight alpha.
              // Value for alpha depends on your application.
            void setModeRunningAverage(double alpha);                           //#Meth
              //  returns the operational mode 0..3. See table in https:/ /github.com/RobTillaart/SRF05 page
            byte getOperationalMode();                                          //#Meth
              //  returns distance in microseconds
            uint32_t getTime();                                                 //#Meth
              //  returns distance in millimetre
            uint32_t getMillimeter();                                           //#Meth
              //  returns distance in centimetre
            double getCentimeter();                                             //#Meth
              //  returns distance in meter
            double getMeter();                                                  //#Meth
              //  returns distance in inches. (1 inch = 2.54 cm)
            double getInch();                                                   //#Meth
              //  returns distance in feet. (1 feet = 12 inch)
            double getFeet();                                                   //#Meth
              //  Experimental
              //  distance is between sensor and the wall - not forth and back. The distance is averaged over 16 measurements.
              //  Function can be used to compensate for temperature and humidity
            double determineSpeedOfSound(uint16_t count);
              //  Experimental
              //  The idea is that shorter triggers can be used with harder surfaces or short distances. Longer trigger for longer distances
              //  Experimental - adjust trigger length 
              //  - gain is a few microseconds at best.
              //  - 10 microseconds is advised minimum
              //  - to be investigated.
            void setTriggerLength(byte length);
              //  The idea is that shorter triggers can be used with harder surfaces or short distances. Longer trigger for longer distances.                                 //#Meth
              //  Experimental - adjust trigger length 
              //  - gain is a few microseconds at best.
              //  - 10 microseconds is advised minimum
              //  - to be investigated.
            byte getTriggerLength();                                            //#Meth
              //  TIMING
            uint32_t lastTime();
    };
}
