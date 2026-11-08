#include "B4RDefines.h"

namespace B4R {
	void B4RFastPid::Initialize(float kp, float ki, float kd, float hz, Int bits, bool sign) {
		fpid =  new (backend) FastPID(kp, ki, kd, hz, bits, sign);
//		return fpid-> err(); 		

	} // End Intialize

	void B4RFastPid::clear() {
	}
	bool B4RFastPid::setCoefficients(float kp, float ki, float kd, float hz) {
	return fpid -> err();
	}
	bool B4RFastPid::setOutputConfig(int bits, bool sign) {
	return fpid -> err();
	}
	bool B4RFastPid::setOutputRange(Int min, Int max) {
	return fpid -> err();
	}

	Int B4RFastPid::step(Int sp, Int fb) {
	return fpid -> step(sp, fb);  //******* rval ??????
	}
	
	bool B4RFastPid::configure(float kp, float ki, float kd, float hz) {
		int bits = 16;
		bool sign = false;
	return fpid -> configure(kp, ki, kd, hz, bits, sign);
	}
	
	bool B4RFastPid::err() {
	return fpid -> err();
	}
	
	
	
	
	
	
} // End Name Space B4R
	