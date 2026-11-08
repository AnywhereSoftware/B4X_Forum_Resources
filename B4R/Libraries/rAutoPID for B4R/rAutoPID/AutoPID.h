#ifndef AUTOPID_H
#define AUTOPID_H
#include <Arduino.h>

class AutoPID {

  public:
    // Constructor - takes pointer inputs for control variales, so they are updated automatically
    AutoPID(float *input, float *setpoint, float *output, float outputMin, float outputMax,
            float Kp, float Ki, float Kd);
    // Allows manual adjustment of gains
    void setGains(float Kp, float Ki, float Kd);
    // Sets bang-bang control ranges, separate upper and lower offsets, zero for off
    void setBangBang(float bangOn, float bangOff);
    // Sets bang-bang control range +-single offset
    void setBangBang(float bangRange);
    // Allows manual readjustment of output range
    void setOutputRange(float outputMin, float outputMax);
    // Allows manual adjustment of time step (default 1000ms)
    void setTimeStep(unsigned long timeStep);
    // Returns true when at set point (+-threshold)
    bool atSetPoint(float threshold);
    // Runs PID calculations when needed. Should be called repeatedly in loop.
    // Automatically reads input and sets output via pointers
    void run();
    // Stops PID functionality, output sets to 
    void stop();
    void reset();
    bool isStopped();

    float getIntegral();
    void setIntegral(float integral);

  private:
    float _Kp, _Ki, _Kd;
    float _integral, _previousError;
    float _bangOn, _bangOff;
    float *_input, *_setpoint, *_output;
    float _outputMin, _outputMax;
    unsigned long _timeStep, _lastStep;
    bool _stopped;

};//class AutoPID

class AutoPIDRelay : public AutoPID {
  public:

    AutoPIDRelay(float *input, float *setpoint, byte *relayState, float pulseWidth, float Kp, float Ki, float Kd)
      : AutoPID(input, setpoint, &_pulseValue, 0, 1.0, Kp, Ki, Kd) {
      _relayState = relayState;
      _pulseWidth = pulseWidth;
    };

    void run();

    float getPulseValue();

  private:
    byte * _relayState;
    unsigned long _pulseWidth, _lastPulseTime;
    float _pulseValue;
};//class AutoPIDRelay

#endif
