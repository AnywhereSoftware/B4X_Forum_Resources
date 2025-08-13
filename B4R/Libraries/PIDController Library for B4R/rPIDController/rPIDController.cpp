#include "B4RDefines.h"

namespace B4R
{
//***********************
//PIDParameters
//***********************
    ULong B4RPIDParameters::Initialize(Double kp,Double ki,Double kd)
    {
       pidpara = new (backend1) PID::PIDParameters<float>(kp, ki, kd);
       return (uint32_t) pidpara;
    };
    
    ULong B4RPIDParameters::InitializeNull()
    {
       pidpara = new (backend1) PID::PIDParameters<float>();
       return (uint32_t) pidpara;
   };      

    ArrayDouble* B4RPIDParameters::Get()
    {
       ArrayDouble* arr = CreateStackMemoryObject(ArrayDouble);
       float raw[3];raw[0]=pidpara->Kp;raw[1]=pidpara->Ki;raw[2]=pidpara->Kd;
       arr->data=raw;
       arr->length=3;
       return arr;
    };           

    bool B4RPIDParameters::HasNegatives()
    {
       return pidpara->HasNegatives();
    };

    void B4RPIDParameters::Set1(ULong pid_parametersID )
    {  
       PID::PIDParameters<float>* tmp =  (PID::PIDParameters<float>*) pid_parametersID ;
       pidpara->Set(tmp->Kp, tmp->Ki, tmp->Kd);
    };

    void B4RPIDParameters::Set(Double kp, Double ki, Double kd)
    {
       pidpara->Set(kp, ki, kd);
    };

    void B4RPIDParameters::Invert()
    {
       pidpara->Invert();
    };

    ULong B4RPIDParameters::Linear(ULong fromID, ULong toID, Double t)
    {
       PID::PIDParameters<float>* tmp1 =  (PID::PIDParameters<float>*) fromID; ; PID::PIDParameters<float>* tmp2 =  (PID::PIDParameters<float>*) toID ;
       PID::PIDParameters<float> from_parameter(tmp1->Kp, tmp1->Ki, tmp1->Kd); 
       PID::PIDParameters<float> to_parameter(tmp2->Kp, tmp2->Ki, tmp2->Kd);  
       static PID::PIDParameters<float> tmpy = pidpara->Linear(from_parameter, to_parameter, t);
       return (uint32_t) &tmpy;
    }

//***********************
//PIDParametersAdaptative
//***********************
    ULong B4RPIDParametersAdaptative::Initialize(Double near_distance, ULong near_parameterID, Double far_distance, ULong far_parameterID)
    {
       PID::PIDParameters<float>* tmp1 =  (PID::PIDParameters<float>*) near_parameterID;  PID::PIDParameters<float>* tmp2 =  (PID::PIDParameters<float>*) far_parameterID ;
       PID::PIDParameters<float> near_parameter(tmp1->Kp, tmp1->Ki, tmp1->Kd);
       PID::PIDParameters<float> far_parameter(tmp2->Kp, tmp2->Ki, tmp2->Kd); 
       pidpada = new (backend2) PID::PIDParametersAdaptative<float>( near_distance, near_parameter, far_distance, far_parameter);
       return (uint32_t) pidpada;
    };
//??         PIDParameters<T> NearParameter
//??         T NearDistance
//??         PIDParameters<T> FarParameter
//??         T FarDistance

    ULong B4RPIDParametersAdaptative::GetAt(Double distance)
    {
       static PID::PIDParameters<float> tmpx = pidpada->GetAt(distance);
       return (uint32_t) &tmpx;
    };    

//***********************
//PIDController
//***********************
    void B4RPIDController::Initialize(ULong pid_parametersID, Byte direction)
    {
       PID::PIDParameters<float>* tmp1 =  (PID::PIDParameters<float>*) pid_parametersID;
       PID::PIDParameters<float> pid_parameters(tmp1->Kp, tmp1->Ki, tmp1->Kd);
       pidco = new (backend3) PID::PIDController<float>( pid_parameters,(PID::DIRECTION) direction);
    };

    void B4RPIDController::SetProportionalOn(Byte proportional_on)
    {
       pidco->SetProportionalOn( (PID::PROPORTIONAL_ON) proportional_on);
    };

    void B4RPIDController::SetOutputLimits(Double output_min, Double output_max)
    {
       pidco->SetOutputLimits(output_min, output_max);
    };

    void B4RPIDController::SetOutputLimits1(Double output_min, Double output_max, Double windup_guard_min, Double windup_guard_max)
    {
       pidco->SetOutputLimits( output_min, output_max, windup_guard_min, windup_guard_max);
    };

    void B4RPIDController::SetTunings( ULong pid_parametersID)
    {
       PID::PIDParameters<float>* tmp1 =  (PID::PIDParameters<float>*) pid_parametersID;
       PID::PIDParameters<float> pid_parameters(tmp1->Kp, tmp1->Ki, tmp1->Kd);
       pidco->SetTunings( pid_parameters);
    };

    void B4RPIDController::SetDirection(Byte direction)
    {
       pidco->SetDirection( (PID::DIRECTION) direction);
    };
                                                                                          
    void B4RPIDController::SetSampleTime(ULong sample_time)
    {
       pidco->SetSampleTime(sample_time);
    };

    void B4RPIDController::TurnOn(bool reset)
    {
       pidco->TurnOn(reset);
    };

    void B4RPIDController::TurnOff()
    {
       pidco->TurnOff();
    };

    void B4RPIDController::Toggle()
    {
       pidco->Toggle();
    };

    Double B4RPIDController::GetError()
    {
       return (Double) pidco->GetError(); 
    };

    Double B4RPIDController::GetKp()
    {
       return (Double)pidco->GetKp(); 
    };

    Double B4RPIDController::GetKi()
    {
       return (Double) pidco->GetKi();
    };

    Double B4RPIDController::GetKd()
    { 
        return (Double) pidco->GetKd(); 
    };

    Double B4RPIDController::GetCorrectedKp()
    {
        return (Double) pidco->GetCorrectedKp(); 
    };

    Double B4RPIDController::GetCorrectedKi()
    {
        return (Double) pidco->GetCorrectedKi(); 
    };

    Double B4RPIDController::GetCorrectedKd()
    {
        return (Double) pidco->GetCorrectedKd(); 
    };

    Double B4RPIDController::GetTermP()
    {
        return (Double) pidco->GetTermP(); 
    };

    Double B4RPIDController::GetTermI()
    {
        return (Double) pidco->GetTermI(); 
    };

    Double B4RPIDController::GetTermD()
    {
        return (Double) pidco->GetTermD(); 
    };

    Double B4RPIDController::GetOutputMin()
    {
        return (Double) pidco->GetOutputMin(); 
    };

    Double B4RPIDController::GetOutputMax()
    {
        return (Double) pidco->GetOutputMax(); 
    };

    Double B4RPIDController::GetWindupGuardMin()
    {
        return (Double) pidco->GetWindupGuardMin(); 
    };

    Double B4RPIDController::GetWindupGuardMax()
    {
        return (Double) pidco->GetWindupGuardMax(); 
    };

    Byte B4RPIDController::GetDirection()
    {
        return (Byte) pidco->GetDirection(); 
    };

    Byte B4RPIDController::GetProportionalOn()
    {
        return (Byte) GetProportionalOn(); 
    };
    
    bool B4RPIDController::IsTurnedOn()
    {
       return pidco->IsTurnedOn();
    };

    bool B4RPIDController::Update()
    {
       return pidco->Update();
    };

    bool B4RPIDController::Update1(Double input)
    {
       return pidco->Update( input);
    };

    void B4RPIDController::ForceUpdate()
    {
       pidco->ForceUpdate();
    };

    void B4RPIDController::ForceUpdate1(Double input)
    {
       pidco->ForceUpdate( input);
    };

    void B4RPIDController::setInput(Double value)  
    {  
         pidco->Input = value;
    };   
    Double B4RPIDController::getOutput()  
    {  
         return pidco->Output;
    };        
    void B4RPIDController::setSetpoint(Double value)  
    {  
         pidco->Setpoint = value;
    }; 

    
//	enum MODE { MANUAL, AUTOMATIC };
//    #define /*byte MODE_MANUAL;*/               B4R_MODE_MANUAL                 0
//    #define /*byte MODE_AUTOMATIC;*/            B4R_MODE_AUTOMATIC              1
    
//	enum DIRECTION { DIRECT, REVERSE };    
//    #define /*byte DIRECTION_DIRECT;*/          B4R_DIRECTION_DIRECT            0
//    #define /*byte DIRECTION_REVERSE;*/         B4R_MODE_REVERSE                1
    
//	enum PROPORTIONAL_ON { MEASURE, ERROR };
//    #define /*byte PROPORTIONAL_ON_MEASURE;*/   B4R_PROPORTIONAL_ON_MEASURE     0
//    #define /*byte PROPORTIONAL_ON_ERROR;*/     B4R_PROPORTIONAL_ON_ERROR       1
    
//	enum RESOLUTION { MILLIS, MICROS };    
//    #define /*byte RESOLUTION_MILLIS;*/         B4R_RESOLUTION_MILLIS           0
//    #define /*byte RESOLUTION_MICROS;*/         B4R_RESOLUTION_MICROS           1    

}
