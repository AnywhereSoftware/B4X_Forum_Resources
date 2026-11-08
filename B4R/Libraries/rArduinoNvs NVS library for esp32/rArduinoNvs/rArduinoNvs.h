#pragma once
#include "B4RDefines.h"
#include "ArduinoNvs.h"

    //~Event: 
    //~Version: 1.0 
    //~Author - 
    //~Libray from Arduino

namespace B4R {
    //~shortname:ArduinoNvs
    class B4RArduinoNvs
    {
        private:
            uint8_t backend[sizeof(ArduinoNvs)];
            ArduinoNvs* rcs;
        public: 
            void Initialize();
            bool begin(B4RString* namespaceNvs);
            void close();
            bool eraseAll(bool forceCommit);
            bool erase(B4RString* key, bool forceCommit);
            bool setByte(B4RString* key, byte value, bool forceCommit);
            bool setInt(B4RString* key, int16_t value, bool forceCommit);
            bool setUInt(B4RString* key, uint16_t value, bool forceCommit);
            bool setLong(B4RString* key, int32_t value, bool forceCommit);
            bool setULong(B4RString* key, uint32_t value, bool forceCommit);
            bool setDouble(B4RString* key, double value, bool forceCommit);
            bool setString(B4RString* key, B4RString* value, bool forceCommit);
            byte getByte(B4RString* key, byte default_value);
            int16_t getInt(B4RString* key, int16_t default_value);
            uint16_t getUInt(B4RString* key, uint16_t default_value);
            int32_t getLong(B4RString* key, int32_t default_value);
            uint32_t getULong(B4RString* key, uint32_t default_value);
            double getDouble(B4RString* key, double default_value);
            bool getString(B4RString* key, ArrayByte* buff, ArrayByte* len);
            B4RString* getString1(B4RString* key);
            bool setBlobArray(B4RString* key, ArrayByte* blob, uint16_t length, bool forceCommit);
            bool getBlobArray(B4RString* key, ArrayByte* blob, uint16_t length);
            uint16_t getBlobSize(B4RString* key);
            bool commit();
    };
}
