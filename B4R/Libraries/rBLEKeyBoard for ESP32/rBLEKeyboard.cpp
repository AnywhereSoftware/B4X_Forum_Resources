#include "B4RDefines.h"
namespace B4R {
	void B4RBLEKEY::Initialize(ArrayByte* s) {
		blekey = new (sizeblekey) BleKeyboard();
		blekey->deviceName = (char*)s->data;
		blekey->begin();
	}
	// void B4RBLEKEY::End(void) {
        // blekey->end();
    // }
	bool B4RBLEKEY::isConnected(void) {
        return blekey->isConnected();
    }
	void B4RBLEKEY::BatteryLevelSet(byte level) {
        blekey->setBatteryLevel(level);
    }
	byte B4RBLEKEY::BatteryLevelGet(void) {
        return blekey->batteryLevel;
    }
	byte B4RBLEKEY::Press(byte k) {
        return blekey->press(k);
    }
	byte B4RBLEKEY::Release(byte k) {
        return blekey->release(k);
    }
	void B4RBLEKEY::ReleaseAll(void) {
        blekey->releaseAll();
    }
	byte B4RBLEKEY::Write(byte c) {
        return blekey->write(c);
    }
	UInt B4RBLEKEY::WriteStr(ArrayByte* s, UInt size) {
        return blekey->write((byte*)s->data,size);
    }
	byte B4RBLEKEY::WriteMedia(MediaKeyReport mk) {
        return blekey->write(mk);
    }
}