#include "AutoPID.h"


AutoPID::AutoPID(float *input, float *setpoint, float *output, float outputMin, float outputMax,
                 float Kp, float Ki, float Kd) {
  _input = input;
  _setpoint = setpoint;
  _output = output;
  _outputMin = outputMin;
  _outputMax = outputMax;
  setGains(Kp, Ki, Kd);
  _timeStep = 1000;
}//AutoPID::AutoPID

void AutoPID::setGains(float Kp, float Ki, float Kd) {
  _Kp = Kp;
  _Ki = Ki;
  _Kd = Kd;
}//AutoPID::setControllerParams

void AutoPID::setBangBang(float bangOn, float bangOff) {
  _bangOn = bangOn;
  _bangOff = bangOff;
}//void AutoPID::setBangBang

void AutoPID::setBangBang(float bangRange) {
  setBangBang(bangRange, bangRange);
}//void AutoPID::setBangBang

void AutoPID::setOutputRange(float outputMin, float outputMax) {
  _outputMin = outputMin;
  _outputMax = outputMax;
}//void AutoPID::setOutputRange

void AutoPID::setTimeStep(unsigned long timeStep){
  _timeStep = timeStep;
}


bool AutoPID::atSetPoint(float threshold) {
  return abs(*_setpoint - *_input) <= threshold;
}//bool AutoPID::atSetPoint

void AutoPID::run() {
  if (_stopped) {
    _stopped = false;
    reset();
  }
  //if bang thresholds are defined and we're outside of them, use bang-bang control
  if (_bangOn && ((*_setpoint - *_input) > _bangOn)) {
    *_output = _outputMax;
    _lastStep = millis();
  } else if (_bangOff && ((*_input - *_setpoint) > _bangOff)) {
    *_output = _outputMin;
    _lastStep = millis();
  } else {                                    //otherwise use PID control
    unsigned long _dT = millis() - _lastStep;   //calculate time since last update
    if (_dT >= _timeStep) {                     //if long enough, do PID calculations
      _lastStep = millis();
      float _error = *_setpoint - *_input;
      _integral += (_error + _previousError) / 2 * _dT / 1000.0;   //Riemann sum integral
      //_integral = constrain(_integral, _outputMin/_Ki, _outputMax/_Ki);
      float _dError = (_error - _previousError) / _dT / 1000.0;   //derivative
      _previousError = _error;
      float PID = (_Kp * _error) + (_Ki * _integral) + (_Kd * _dError);
      //*_output = _outputMin + (constrain(PID, 0, 1) * (_outputMax - _outputMin));
      *_output = constrain(PID, _outputMin, _outputMax);
    }
  }       
}//void AutoPID::run         

void AutoPID::stop() {
  _stopped = true;
  reset();
}
void AutoPID::reset() {
  _lastStep = millis();
  _integral = 0;
  _previousError = 0;
}

bool AutoPID::isStopped(){
  return _stopped;
}

float AutoPID::getIntegral(){
  return _integral;
}

void AutoPID::setIntegral(float integral){
  _integral = integral;
}

void AutoPIDRelay::run() {
  AutoPID::run();
  while ((millis() - _lastPulseTime) > _pulseWidth) _lastPulseTime += _pulseWidth;
  *_relayState = (byte) ((millis() - _lastPulseTime) < (_pulseValue * _pulseWidth));
}


float AutoPIDRelay::getPulseValue(){
  return (isStopped()?0:_pulseValue);
}


