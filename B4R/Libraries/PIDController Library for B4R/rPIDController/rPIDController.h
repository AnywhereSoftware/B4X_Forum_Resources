#pragma once
#include "B4RDefines.h"
#include "PIDController.hpp"

    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino: https://github.com/luisllamasbinaburo/Arduino-PIDController-Library

namespace B4R {
//***********************
//PIDParameters
//***********************
    //~shortname:PIDParameters
    class B4RPIDParameters
    {
        private:
            uint8_t backend1[sizeof(PID::PIDParameters<float>)];
            PID::PIDParameters<float>* pidpara;
        public:
            ULong Initialize(Double kp,Double ki,Double kd);
            ULong InitializeNull();   
            ArrayDouble* Get();
            bool HasNegatives();
            void Set1(ULong pid_parametersID );
            void Set(Double kp, Double ki, Double kd);
            void Invert();
            uint32_t Linear(ULong fromID, ULong toID, Double t);
    };


//***********************
//PIDParametersAdaptative
//***********************
    //~shortname:PIDParametersAdaptative
    class B4RPIDParametersAdaptative
    {
        private:
            uint8_t backend2[sizeof(PID::PIDParametersAdaptative<float>)];
            PID::PIDParametersAdaptative<float>*  pidpada;
        public:
            ULong Initialize(Double near_distance, ULong near_parameterID, Double far_distance, ULong far_parameterID);
            ULong GetAt(Double distance);
    };  
          
//***********************
//PIDController
//***********************
    //~shortname:PIDController
    class B4RPIDController
    {
        private:
            uint8_t backend3[sizeof( PID::PIDController<float>)];
            PID::PIDController<float>* pidco;
        public:
            void Initialize(ULong pid_parametersID, Byte direction);
            void SetProportionalOn(Byte proportional_on);
            void SetOutputLimits(Double output_min, Double output_max);
            void SetOutputLimits1(Double output_min, Double output_max, Double windup_guard_min, Double windup_guard_max);
            void SetTunings( ULong pid_parametersID);
            void SetDirection(Byte direction);
            void SetSampleTime(ULong sample_time);
            void TurnOn(bool reset);
            void TurnOff();
            void Toggle();
            Double GetError();
            Double GetKp();
            Double GetKi();
            Double GetKd();
            Double GetCorrectedKp();
            Double GetCorrectedKi();
            Double GetCorrectedKd();
            Double GetTermP();
            Double GetTermI();
            Double GetTermD();
            Double GetOutputMin();
            Double GetOutputMax();
            Double GetWindupGuardMin();
            Double GetWindupGuardMax();
            Byte GetDirection();
            Byte GetProportionalOn();
            bool IsTurnedOn();
            bool Update();
            bool Update1(Double input);
            void ForceUpdate();
            void ForceUpdate1(Double input);
            void setInput(Double value);   
            Double getOutput();         
            void setSetpoint(Double value);  

//	enum MODE { MANUAL, AUTOMATIC };
        #define /*Byte MODE_MANUAL;*/               B4R_MODE_MANUAL                 PID::MODE::MANUAL
        #define /*Byte MODE_AUTOMATIC;*/            B4R_MODE_AUTOMATIC              PID::MODE::AUTOMATIC
    
//	enum DIRECTION { DIRECT, REVERSE };    
        #define /*Byte DIRECTION_DIRECT;*/          B4R_DIRECTION_DIRECT            PID::DIRECTION::DIRECT
        #define /*Byte DIRECTION_REVERSE;*/         B4R_DIRECTION_REVERSE           PID::DIRECTION::REVERSE
    
//	enum PROPORTIONAL_ON { MEASURE, ERROR };
        #define /*Byte PROPORTIONAL_ON_MEASURE;*/   B4R_PROPORTIONAL_ON_MEASURE     PID::PROPORTIONAL_ON::MEASURE
        #define /*Byte PROPORTIONAL_ON_ERROR;*/     B4R_PROPORTIONAL_ON_ERROR       PID::PROPORTIONAL_ON::ERROR
    
//	enum RESOLUTION { MILLIS, MICROS };    
        #define /*Byte RESOLUTION_MILLIS;*/         B4R_RESOLUTION_MILLIS           PID::RESOLUTION::MILLIS
        #define /*Byte RESOLUTION_MICROS;*/         B4R_RESOLUTION_MICROS           PID::RESOLUTION::MICROS    
    };
}
