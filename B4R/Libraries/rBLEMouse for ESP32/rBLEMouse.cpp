#include "B4RDefines.h"
namespace B4R {
	void B4RBLEMOUSE::Initialize(ArrayByte* s) {
		blemouse = new (sizeblekey) BleMouse();
		blemouse->deviceName = (char*)s->data;
		blemouse->begin();
	}
	// void B4RBLEMOUSE::End(void) {
        // blemouse->end();
    // }
	bool B4RBLEMOUSE::isConnected(void) {
        return blemouse->isConnected();
    }
	void B4RBLEMOUSE::BatteryLevelSet(byte level) {
        blemouse->setBatteryLevel(level);
    }
	byte B4RBLEMOUSE::BatteryLevelGet(void) {
        return blemouse->batteryLevel;
    }
	void B4RBLEMOUSE::Click(byte b) {
        blemouse->click(b);
    }
	void B4RBLEMOUSE::Press(byte b) {
        blemouse->press(b);
    }
	void B4RBLEMOUSE::Release(byte b) {
        blemouse->release(b);
    }
	bool B4RBLEMOUSE::isPressed(byte b) {
        return blemouse->isPressed(b);
    }
	void B4RBLEMOUSE::Move(int x, int y, int vwheel, int hwheel) {
		//limit x
		if (x > 127) {
			x=127;
		}
		if (x < -127) {
			x=-127;
		}
		//limit y
		if (y > 127) {
			y=127;
		}
		if (y < -127) {
			y=-127;
		}
		//limit vwheel
		if (vwheel > 127) {
			vwheel=127;
		}
		if (vwheel < -127) {
			vwheel=-127;
		}
		//limit hwheel
		if (hwheel > 127) {
			hwheel=127;
		}
		if (hwheel < -127) {
			hwheel=-127;
		}
        blemouse->move(x,y,vwheel,hwheel);
    }
}