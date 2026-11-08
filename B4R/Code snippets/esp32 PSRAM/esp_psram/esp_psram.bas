B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'module name: esp_psram
'PSRAM Storage Module for ESP32/ESP32-S3
'v.0.207
'Activate PSRAM in the configuration

Sub Process_Globals
	Private bc As ByteConverter
	Public Const PSRAM_PAGE_SIZE As Int = 256
	Public PSRAM_Available As Boolean = False
	Public StringFromPSRAM(PSRAM_PAGE_SIZE) As Byte    'ignore
	Private Const MAX_KEY_LENGTH As Int = 31
    
	'Define a type for key-value pairs
	Type KeyValueType(key() As Byte, value() As Byte)
End Sub

'Checks if board has PSRAM hardware
Public Sub IsPSRAMSupported As Boolean
	Return RunNative("isPsramSupported", Null)
End Sub

'Initializes PSRAM subsystem
Public Sub Initialize As Boolean
	If Not(IsPSRAMSupported) Then
		Log("PSRAM not supported on this board")
		Return False
	End If
    
	PSRAM_Available = RunNative("psramFound", Null)
	Log("PSRAM Available: ", PSRAM_Available)
    
	If PSRAM_Available Then
		RunNative("psram_internal_initialize", Null)
		Log("PSRAM Initialized. Free: ", GetFreePSRAM, " of ", GetTotalPSRAM)
	End If
	Return PSRAM_Available
End Sub

'Saves string to PSRAM using KeyValueType structure
Public Sub SaveStringToPSRAM(Key As String, Value As String) As Boolean
	If Not(PSRAM_Available) Then Return False
	If Key.Length > MAX_KEY_LENGTH Then
		Log("Key too long (max ", MAX_KEY_LENGTH, " chars)")
		Return False
	End If
    
	Dim kv As KeyValueType
	kv.key = Key.GetBytes
	kv.value = Value.GetBytes
    
	Return RunNative("psramSaveString", kv)
End Sub

'Reads string from PSRAM
Public Sub ReadStringFromPSRAM(Key As String) As String
	If Not(PSRAM_Available) Then Return ""
	For i = 0 To PSRAM_PAGE_SIZE - 1
		StringFromPSRAM(i) = 0
	Next
	RunNative("psramReadString", Key.GetBytes)
	Return bc.StringFromBytes(StringFromPSRAM)
End Sub

'Deletes string from PSRAM
Public Sub DeleteStringFromPSRAM(Key As String) As Boolean
	If Not(PSRAM_Available) Then Return False
	Return RunNative("psramDeleteString", Key.GetBytes).As(Boolean)
End Sub

'Gets free PSRAM in bytes
Public Sub GetFreePSRAM() As ULong
	If Not(PSRAM_Available) Then Return 0
	Return RunNative("esp_get_free_psram_size", Null)
End Sub

'Gets total PSRAM in bytes
Public Sub GetTotalPSRAM() As ULong
	If Not(PSRAM_Available) Then Return 0
	Return RunNative("esp_get_psram_size", Null)
End Sub

'Очищает ВСЕ сохранённые строки в PSRAM
Public Sub ClearAllStrings As Boolean
	If Not(PSRAM_Available) Then Return False
	Return RunNative("psramClearAll", Null).As(Boolean)
End Sub

#if C
#include <string.h>
#include <stdlib.h>
#include <Arduino.h>
#include <esp_heap_caps.h>
#include "rCore.h"

typedef struct {
    char key[32];
    size_t length;
    void* ptr;
} PSRAM_StringEntry;

static PSRAM_StringEntry* stringTable = NULL;
static uint16_t stringTableSize = 0;
static uint16_t stringTableCapacity = 0;

static int findStringIndex(const char* key) {
    for (int i = 0; i < stringTableSize; i++) {
        if (strcmp(stringTable[i].key, key) == 0) {
            return i;
        }
    }
    return -1;
}

// Helper: wrap result into B4R::Object*
B4R::Object* wrapBoolean(bool value) {
    return (new B4R::Object())->wrapNumber((byte)value);
}

B4R::Object* wrapULong(ULong value) {
    return (new B4R::Object())->wrapNumber(value);
}

B4R::Object* isPsramSupported(B4R::Object* arg) {
#ifdef BOARD_HAS_PSRAM
    return wrapBoolean(true);
#endif
    return wrapBoolean(false);

}

B4R::Object* psramFound(B4R::Object* arg) {
#ifdef BOARD_HAS_PSRAM
    return wrapBoolean(ESP.getPsramSize() > 0);
#endif
    return wrapBoolean(false);

}

B4R::Object* psram_internal_initialize(B4R::Object* arg) {
    stringTableCapacity = 16;
    stringTable = (PSRAM_StringEntry*)malloc(stringTableCapacity * sizeof(PSRAM_StringEntry));
    if (stringTable == NULL) return wrapBoolean(false);
    memset(stringTable, 0, stringTableCapacity * sizeof(PSRAM_StringEntry));
    stringTableSize = 0;
    return wrapBoolean(true);
}

B4R::Object* psramSaveString(B4R::Object* o) {
    static unsigned long lastSaveTime = 0;
    const unsigned long minSaveInterval = 5;
	
    _keyvaluetype* kv = (_keyvaluetype*)B4R::Object::toPointer(o);
    //if (!kv || !psramFound(NULL)->toBoolean()) return wrapBoolean(false);
	if (!kv) return wrapBoolean(false);

    B4R::Array* keyArr = kv->key;
    B4R::Array* valueArr = kv->value;
    if (!keyArr || !valueArr) return wrapBoolean(false);

    char* key = (char*)keyArr->data;
    char* value = (char*)valueArr->data;
    size_t valueLen = strlen(value) + 1;
	
	unsigned long currentTime = millis();
    if (currentTime - lastSaveTime < minSaveInterval) {
        return wrapBoolean(false); // too often
    }

    if (heap_caps_get_free_size(MALLOC_CAP_SPIRAM) < valueLen) return wrapBoolean(false);

    int index = findStringIndex(key);
    if (index >= 0) {
        heap_caps_free(stringTable[index].ptr);
    } else {
        if (stringTableSize >= stringTableCapacity) {
            uint16_t newCapacity = stringTableCapacity * 2;
            PSRAM_StringEntry* newTable = (PSRAM_StringEntry*)realloc(stringTable,
                                newCapacity * sizeof(PSRAM_StringEntry));
            if (newTable == NULL) return wrapBoolean(false);
            stringTable = newTable;
            stringTableCapacity = newCapacity;
        }
        index = stringTableSize++;
    }

    void* ptr = heap_caps_malloc(valueLen, MALLOC_CAP_SPIRAM);
    if (ptr == NULL) return wrapBoolean(false);
    memcpy(ptr, value, valueLen);
    strncpy(stringTable[index].key, key, 31);
    stringTable[index].key[31] = '\0';
    stringTable[index].length = valueLen;
    stringTable[index].ptr = ptr;

	lastSaveTime = currentTime;
    return wrapBoolean(true);
}

void psramReadString(B4R::Object* o) {
    B4R::Array* b = (B4R::Array*)B4R::Object::toPointer(o);
    const char* key = (const char*)b->data;
    int index = findStringIndex(key);

    // Вalways zeroing
    if (b4r_esp_psram::_stringfrompsram && b4r_esp_psram::_stringfrompsram->data) {
        memset(b4r_esp_psram::_stringfrompsram->data, 0, b4r_esp_psram::_stringfrompsram->length);
    }

    if (index < 0) return;

    // !!!
    if (stringTable[index].ptr == NULL) return;

    char* valuePtr = (char*)stringTable[index].ptr;
    size_t length = stringTable[index].length;
    size_t copyLength = length < b4r_esp_psram::_stringfrompsram->length ? length : b4r_esp_psram::_stringfrompsram->length;
    memcpy(b4r_esp_psram::_stringfrompsram->data, valuePtr, copyLength);
    if (copyLength < b4r_esp_psram::_stringfrompsram->length)
        ((uint8_t*)b4r_esp_psram::_stringfrompsram->data)[copyLength] = 0;
}

B4R::Object* psramDeleteString(B4R::Object* o) {
    B4R::Array* b = (B4R::Array*)B4R::Object::toPointer(o);
    const char* key = (const char*)b->data;
    if (!key) return wrapBoolean(false);

    int index = findStringIndex(key);
    if (index < 0) return wrapBoolean(false);

    // Free and zeroing
    if (stringTable[index].ptr != NULL) {
        heap_caps_free(stringTable[index].ptr);
        stringTable[index].ptr = NULL; 
    }

    for (int i = index; i < stringTableSize - 1; i++) {
        stringTable[i] = stringTable[i + 1];
    }
    stringTableSize--;

    return wrapBoolean(true);
}

B4R::Object* esp_get_free_psram_size(B4R::Object* arg) {
#ifdef BOARD_HAS_PSRAM
    return wrapULong(heap_caps_get_free_size(MALLOC_CAP_SPIRAM));
#endif
    return wrapULong(0);

}

B4R::Object* esp_get_psram_size(B4R::Object* arg) {
#ifdef BOARD_HAS_PSRAM
    return wrapULong(ESP.getPsramSize());
#endif
    return wrapULong(0);

}

B4R::Object* psramClearAll(B4R::Object* arg) {
    // Free all memory
    for (int i = 0; i < stringTableSize; i++) {
        if (stringTable[i].ptr != NULL) {
            heap_caps_free(stringTable[i].ptr);
            stringTable[i].ptr = NULL;
        }
    }
   
    stringTableSize = 0;
    // stringTable is not cleared, add again later
    return wrapBoolean(true);
}

#end if