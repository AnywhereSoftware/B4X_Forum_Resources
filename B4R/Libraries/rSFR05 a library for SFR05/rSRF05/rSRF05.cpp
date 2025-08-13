#include "B4RDefines.h"

namespace B4R
{

    void B4RSRF05::Initialize(byte trigger,byte echo,byte out)
    {
       rcs = new (backend) SRF05(trigger, echo, out);
    };

    void B4RSRF05::setSpeedOfSound(double sos)
    {
       rcs->setSpeedOfSound(sos);
    };

    double B4RSRF05::getSpeedOfSound()
    {
       return rcs->getSpeedOfSound();
    };

    bool B4RSRF05::setCorrectionFactor(double factor)
    {
       return rcs->setCorrectionFactor(factor);
    };

    double B4RSRF05::getCorrectionFactor()
    {
       return rcs->getCorrectionFactor();
    };

    void B4RSRF05::setModeSingle()
    {
       rcs->setModeSingle();
    };

    void B4RSRF05::setModeAverage(byte count)
    {
       rcs->setModeAverage(count);
    };

    void B4RSRF05::setModeMedian(byte count)
    {
       rcs->setModeMedian(count);
    };

    void B4RSRF05::setModeRunningAverage(double alpha)
    {
       rcs->setModeRunningAverage(alpha);
    };

    byte B4RSRF05::getOperationalMode()
    {
       return rcs->getOperationalMode();
    };

    uint32_t B4RSRF05::getTime()
    {
       return rcs->getTime();
    };

    uint32_t B4RSRF05::getMillimeter()
    {
       return rcs->getMillimeter();
    };

    double B4RSRF05::getCentimeter()
    {
       return rcs->getCentimeter();
    };

    double B4RSRF05::getMeter()
    {
       return rcs->getMeter();
    };

    double B4RSRF05::getInch()
    {
       return rcs->getInch();
    };

    double B4RSRF05::getFeet()
    {
       return rcs->getFeet();
    };

    double B4RSRF05::determineSpeedOfSound(uint16_t count)
    {
       return rcs->determineSpeedOfSound(count);
    };

    void B4RSRF05::setTriggerLength(byte length)
    {
       rcs->setTriggerLength(length);
    };

    byte B4RSRF05::getTriggerLength()
    {
       return rcs->getTriggerLength();
    };

    uint32_t B4RSRF05::lastTime()
    {
       return rcs->lastTime();
    };

}
