#pragma once
#include "B4RDefines.h"
#include "FastPID.h"



namespace B4R {
	
//~Version: 1.00
//~shortname: FastPid
//
	class B4RFastPid {
		private:
			uint8_t backend[sizeof(FastPID)];
		public:
		//~ hide
		FastPID* fpid;
		//Initializes the PID. Returns True if successful.
		void Initialize(float kp, float ki, float kd, float hz, Int bits=16, bool sign=false);
		void clear();
		bool setCoefficients(float kp, float ki, float kd, float hz);
		bool setOutputConfig(Int bits, bool sign);
		bool setOutputRange(Int min, Int max);
		Int step(Int sp, Int fb);
		bool configure(float kp, float ki, float kd, float hz);
		bool err();
		
	};
}
