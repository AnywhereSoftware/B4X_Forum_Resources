#pragma once
#include "B4RDefines.h"
#include "AutoPID.h"

    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino : https://github.com/r-downing/AutoPID

namespace B4R {
//class AutoPID
    //~shortname:AutoPID
    
    //A simple PID library featuring time scaling, bang-bang control, and PWM relay control.
    class B4RAutoPID
    {
        private:
            uint8_t backend[sizeof(AutoPID)];
            AutoPID* rcr;
        public: 
            // Constructor - takes pointer inputs for control variales, so they are updated automatically
            void Initialize(ArrayDouble* input,ArrayDouble* setpoint,ArrayDouble* output,float outputMin,float outputMax,float Kp,float Ki,float Kd);
            // This function allows for manual tuning of the PID controller gains. By adjusting the proportional,
            // integral, and derivative gains, the behavior of the PID controller can be modified to better
            // suit the specific control requirements.  
            void setGains(float Kp, float Ki, float Kd);
            // This function sets the thresholds for bang-bang control, which is a simple on/off control mechanism.
            // When the input is below `(setpoint - bangOn)`, the PID will set `output` to `outputMax`. When the input
            // is above `(setpoint + bangOff)`, the PID will set `output` to `outputMin`. 
            void setBangBang(float bangOn, float bangOff);
            // This function sets the threshold for bang-bang control with a single range value. When the input
            // is below `(setpoint - bangRange)`, the PID will set `output` to `outputMax`. When the input is above
            // (setpoint + bangRange)`, the PID will set `output` to `outputMin`.    
            void setBangBang1(float bangRange);
            // This function allows for manual adjustment of the output range. The `outputMin` and `outputMax` values
            // define the allowable range for the output variable.
            void setOutputRange(float outputMin, float outputMax);
            // This function sets the time interval (in milliseconds) at which the PID calculations are allowed to run.
            // By default, this interval is set to 1000 milliseconds.
            void setTimeStep(uint32_t timeStep);
            // This function checks whether the input value is within a specified threshold of the setpoint.
            // It returns `true` if the input is within  (threshold) of the setpoint.
            bool atSetPoint(float threshold);
            // This function should be called repeatedly from the main loop. It will only perform PID calculations
            // when the specified time interval has passed. The function reads the input and setpoint values, updates
            // the output, and performs necessary calculations.
            void run();
            // This function stops the PID calculations and resets the internal values used in the calculations,
            // such as the integral and derivative terms. The PID controller can be resumed by calling the `run()` function. 
            void stop();
            // This function resets the internal values used in PID calculations, such as the integral and derivative terms.
            // It only clears the current calculations and does not stop the PID controller from running.              
            void reset();
            // This function checks whether the PID calculations have been stopped.
            // @return true if the PID calculations have been stopped, otherwise false.            
            bool isStopped();
            // This function returns the current value of the error integral. It is useful for storing the state
            // of the PID controller after a power cycle.
            // @return The current value of the error integral.          
            float getIntegral();
            // This function allows for overriding the current value of the error integral. It is useful for resuming
            // the state of the PID controller after a power cycle. This function should be called after `run()` is called
            // for the first time, otherwise the value will be reset.            
            void setIntegral(float integral);
    };
//class AutoPIDRelay
    //~shortname:AutoPIDRelay
    class B4RAutoPIDRelay
    {
        private:
            uint8_t backend[sizeof(AutoPIDRelay)];
            AutoPIDRelay* rcs;
        public: 
            // This constructor initializes a new AutoPIDRelay object with the provided parameters. The PID controller will
            // use the pointers to the input, setpoint, and relayState variables to update the PID calculations dynamically.
            void Initialize(ArrayDouble* input,ArrayDouble* setpoint,ArrayByte* relayState,float pulseWidth,float Kp,float Ki,float Kd);
            // This function should be called repeatedly from the main loop. It will only perform PID calculations
            // when the specified time interval has passed. The function reads the input and setpoint values, updates
            // the output, and performs necessary calculations.  
            void run();
            // This function allows for overriding the current value of the error integral. It is useful for resuming
            // the state of the PID controller after a power cycle. This function should be called after `run()` is called
            // for the first time, otherwise the value will be reset.
            // @param[in] integral The value of the error integral to be used.              
            float getPulseValue();
//from AutoPID

            // This function allows for manual tuning of the PID controller gains. By adjusting the proportional,
            // integral, and derivative gains, the behavior of the PID controller can be modified to better
            // suit the specific control requirements.  
            void setGains(float Kp, float Ki, float Kd);
            // This function sets the thresholds for bang-bang control, which is a simple on/off control mechanism.
            // When the input is below `(setpoint - bangOn)`, the PID will set `output` to `outputMax`. When the input
            // is above `(setpoint + bangOff)`, the PID will set `output` to `outputMin`.  
            void setBangBang(float bangOn, float bangOff);
            // This function sets the threshold for bang-bang control with a single range value. When the input
            // is below `(setpoint - bangRange)`, the PID will set `output` to `outputMax`. When the input is above
            // (setpoint + bangRange)`, the PID will set `output` to `outputMin`.  
            void setBangBang1(float bangRange);
            // Allows manual readjustment of output range
            void setOutputRange(float outputMin, float outputMax);
            // This function sets the time interval (in milliseconds) at which the PID calculations are allowed to run.
            // By default, this interval is set to 1000 milliseconds.
            void setTimeStep(uint32_t timeStep);
            // This function checks whether the input value is within a specified threshold of the setpoint.
            // It returns `true` if the input is within  (threshold) of the setpoint.
            bool atSetPoint(float threshold);           
            // This function stops the PID calculations and resets the internal values used in the calculations,
            // such as the integral and derivative terms. The PID controller can be resumed by calling the `run()` function. 
            void stop();
            // This function resets the internal values used in PID calculations, such as the integral and derivative terms.
            // It only clears the current calculations and does not stop the PID controller from running.           
            void reset();
            // This function checks whether the PID calculations have been stopped.
            // @return true if the PID calculations have been stopped, otherwise false.             
            bool isStopped();
            // This function returns the current value of the error integral. It is useful for storing the state
            // of the PID controller after a power cycle.
            // @return The current value of the error integral.              
            float getIntegral();
            // This function allows for overriding the current value of the error integral. It is useful for resuming
            // the state of the PID controller after a power cycle. This function should be called after `run()` is called
            // for the first time, otherwise the value will be reset.
            // @param[in] integral The value of the error integral to be used.            
            void setIntegral(float integral);
    };
}
