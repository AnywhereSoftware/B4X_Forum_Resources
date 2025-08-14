### esp32 PSRAM by peacemaker
### 08/11/2025
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/168191/)

I was tried to think how to correctly use PSRAM of the esp32-S3 MCU - and prepared these functions, but … actually i do not understand how to use it correctly in B4R that to make internal main SRAM more free.  
Help to understand me, please, if you are interested.  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 3000  
#End Region  
Sub Process_Globals  
    ' These variables are accessible across all modules  
    Public Serial1 As Serial  
    Private Timer1 As Timer  
    Private TestIndex As Int = 0  
    Private MaxTests As Int = 1000 ' Number of test entries  
    Private bc As ByteConverter  
    Private TotalSavedBytes As ULong  
   
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Delay(3000)  
    Log("AppStart")  
   
    If esp_psram.Initialize Then  
        Log("PSRAM initialized. Free: ", esp_psram.GetFreePSRAM, " bytes")  
        Log("Total PSRAM: ", esp_psram.GetTotalPSRAM, " bytes")  
       
        ' Start test with delay to avoid interfering logs  
        Timer1.Initialize("Timer1_Tick", 2) '2 ms  
        Timer1.Enabled = True  
       
    Else  
        Log("PSRAM initialization failed or PSRAM not available")  
        Return  
    End If  
   
End Sub  
  
Sub Timer1_Tick  
    Timer1.Enabled = False  
   
    If TestIndex = 0 Then  
        Log("=== Starting test: writing ", MaxTests, " strings to PSRAM ===")  
        TotalSavedBytes = 0  
    End If  
   
    ' Create a large string (~200 bytes)  
    Dim Key As String = JoinStrings(Array As String("key_", TestIndex))  
    Dim Value As String = getRNDValue  
   
   
    ' Write to PSRAM  
    If esp_psram.SaveStringToPSRAM(Key, Value) Then  
        ' Read back for verification (optional, can be commented out for speed)  
        'Log("Wrote ", Key)  
  
        TotalSavedBytes = TotalSavedBytes + Value.Length + Key.Length  
        'Dim ReadBack As String = esp_psram.ReadStringFromPSRAM(Key)  
        'Log(ReadBack)  
        'If ReadBack <> Value Then Log("Read error for key: ", Key)  
    Else  
        Log("Write error for key: ", Key)  
       
    End If  
   
    TestIndex = TestIndex + 1  
   
    If TestIndex < MaxTests Then  
        ' Continue with next tick  
        Timer1.Enabled = True  
    Else  
        Log("Saved ", TotalSavedBytes, " bytes")  
        Log("=== Writing completed. Verification and deletion ===")  
        Log("Free after writing: ", esp_psram.GetFreePSRAM, " bytes")  
       
        ' Verification: read first, middle and last  
        Log("key_0: ", esp_psram.ReadStringFromPSRAM("key_0"))  
        'Log("key_99: ", esp_psram.ReadStringFromPSRAM("key_99"))  
        Log("key_500: ", esp_psram.ReadStringFromPSRAM("key_500"))  
        Log("key_999: ", esp_psram.ReadStringFromPSRAM("key_999"))  
       
        ' Delete  
        Log("Next - deleting all…")  
        esp_psram.ClearAllStrings  
       
        Log("Free after deletion: ", esp_psram.GetFreePSRAM, " bytes")  
       
        ' Final check  
        Log("=== Test completed ===")  
        Delay(1000)  
        Log("Again")  
        TestIndex = 0  
        Timer1.Enabled = True  
    End If  
End Sub  
  
Sub getRNDValue As String  
    Return JoinStrings(Array As String("TestData_", TestIndex, "_", CreateRandomString(180)))  
End Sub  
  
Sub getKeyName(num As Int) As String  
    Return JoinStrings(Array As String("key_", num))  
End Sub  
  
' Helper function: generate random string  
Sub CreateRandomString(Length As Int) As String  
    Dim Chars As String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"  
    Dim CharsBytes() As Byte = Chars.GetBytes  
    Dim Result(Length) As Byte  
  
    For i = 0 To Length - 1  
        Dim SingleByte As Byte  
        SingleByte = CharsBytes(Rnd(0, CharsBytes.Length))  
        Result(i) = SingleByte  
    Next  
   
    Return bc.StringFromBytes(Result)  
End Sub
```

  
  
  

```B4X
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
        if (strcmp(stringTable.key, key) == 0) {  
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
        stringTable = stringTable;  
    }  
    stringTableSize–;  
  
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
        if (stringTable.ptr != NULL) {  
            heap_caps_free(stringTable.ptr);  
            stringTable.ptr = NULL;  
        }  
    }  
   
    stringTableSize = 0;  
    // stringTable is not cleared, add again later  
    return wrapBoolean(true);  
}  
  
#end if
```

  
  
> AppStart  
> PSRAM Available: 1  
> PSRAM Initialized. Free: 8386096 of 8388608  
> PSRAM initialized. Free: 8386096 bytes  
> Total PSRAM: 8388608 bytes  
> === Starting test: writing 1000 strings to PSRAM ===  
> Saved 199780 bytes  
> === Writing completed. Verification and deletion ===  
> Free after writing: 8132140 bytes  
> key\_0: TestData\_0\_vqna12cuFh…………..  
> key\_500: TestData\_500\_xauzUtiNqAs7Zh………  
> key\_999: TestData\_999\_5gDxpV3ATBmbD….  
> Next - deleting all…  
> Free after deletion: 8344108 bytes  
> === Test completed ===  
> Again  
> === Starting test: writing 1000 strings to PSRAM ===  
> Saved 199780 bytes  
> === Writing completed. Verification and deletion ===  
> Free after writing: 8132148 bytes  
> key\_0: TestData\_0\_vA3dIExB6s………..  
> key\_500: TestData\_500\_0mv5HUpsjAa2mkUbQw………..  
> key\_999: TestData\_999\_WmscRMYuJW…………  
> Next - deleting all…  
> Free after deletion: 8344108 bytes  
> === Test completed ===

  
If PSRAM is not enabled:  
  
> AppStart  
> PSRAM not supported on this board  
> PSRAM initialization failed or PSRAM not available