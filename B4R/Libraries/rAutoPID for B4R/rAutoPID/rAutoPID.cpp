#include "B4RDefines.h"

namespace B4R
{

//class AutoPID
    void B4RAutoPID::Initialize(ArrayDouble* input,ArrayDouble* setpoint,ArrayDouble* output,float outputMin,float outputMax,float Kp,float Ki,float Kd)
    {     
       rcr = new (backend) AutoPID( (float*)input->data, (float*)setpoint->data, (float*)output->data, outputMin, outputMax, Kp, Ki, Kd);      
    };

    void B4RAutoPID::setGains(float Kp, float Ki, float Kd)
    {
       rcr->setGains(Kp, Ki, Kd);
    };

    void B4RAutoPID::setBangBang(float bangOn, float bangOff)
    {
       rcr->setBangBang(bangOn, bangOff);
    };

    void B4RAutoPID::setBangBang1(float bangRange)
    {
       rcr->setBangBang(bangRange);
    };

    void B4RAutoPID::setOutputRange(float outputMin, float outputMax)
    {
       rcr->setOutputRange(outputMin, outputMax);
    };

    void B4RAutoPID::setTimeStep(uint32_t timeStep)
    {
       rcr->setTimeStep(timeStep);
    };

    bool B4RAutoPID::atSetPoint(float threshold)
    {
       return rcr->atSetPoint(threshold);
    };

    void B4RAutoPID::run()
    {
       rcr->run();
    };

    void B4RAutoPID::stop()
    {
       rcr->stop();
    };

    void B4RAutoPID::reset()
    {
       rcr->reset();
    };

    bool B4RAutoPID::isStopped()
    {
       return rcr->isStopped();
    };

    float B4RAutoPID::getIntegral()
    {
       return rcr->getIntegral();
    };

    void B4RAutoPID::setIntegral(float integral)
    {
       rcr->setIntegral(integral);
    };


//class AutoPIDRelay
    void B4RAutoPIDRelay::Initialize(ArrayDouble* input,ArrayDouble* setpoint,ArrayByte* relayState,float pulseWidth,float Kp,float Ki,float Kd)
    {
       rcs = new (backend) AutoPIDRelay((float*)input->data, (float*)setpoint->data, (byte*)relayState->data, pulseWidth, Kp, Ki, Kd);
    };

    void B4RAutoPIDRelay::run()                                      
    {
       rcs->run();
    };

    float B4RAutoPIDRelay::getPulseValue()
    {
       return rcs->getPulseValue();
    };

//from AutoPID
    void B4RAutoPIDRelay::setGains(float Kp, float Ki, float Kd)
    {
       rcs->setGains(Kp, Ki, Kd);
    };

    void B4RAutoPIDRelay::setBangBang(float bangOn, float bangOff)
    {
       rcs->setBangBang(bangOn, bangOff);
    };

    void B4RAutoPIDRelay::setBangBang1(float bangRange)
    {
       rcs->setBangBang(bangRange);
    };

    void B4RAutoPIDRelay::setOutputRange(float outputMin, float outputMax)
    {
       rcs->setOutputRange(outputMin, outputMax);
    };

    void B4RAutoPIDRelay::setTimeStep(uint32_t timeStep)
    {
       rcs->setTimeStep(timeStep);
    };

    bool B4RAutoPIDRelay::atSetPoint(float threshold)
    {
       return rcs->atSetPoint(threshold);
    };

//    void run()
    void B4RAutoPIDRelay::stop()
    {
       rcs->stop();
    };

    void B4RAutoPIDRelay::reset()
    {
       rcs->reset();
    };

    bool B4RAutoPIDRelay::isStopped()
    {
       return rcs->isStopped();
    };

    float B4RAutoPIDRelay::getIntegral()
    {
       return rcs->getIntegral();
    };

    void B4RAutoPIDRelay::setIntegral(float integral)
    {
       rcs->setIntegral(integral);
    };


}
