### SD-card: save log into a limited (looped) log file by peacemaker
### 08/25/2024
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/162729/)

Right logging system must not be overloaded by the log files amount.  
So, if the storage is limited - any logging must be looped.  
  
The system log file name is hardcoded, the max file size also.  
  
Actual Arduino's SD-card class can open file only for READ, WRITE or APPEND. No TRUNCATE is possible (i do not prefer to make a custom class from the standard one), so the looping is made by the file deleting and re-creation - please, help to update for better way in the Inline-C code (sub "write\_sys\_log"): new line is added to the end of text, oldest first file part - is truncated.  
  

```B4X
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Type KeyValueType(key() As Byte, value() As Byte)  
    Dim Ready_flag As Boolean  
  
    Public HOUR As Byte, DATE As Byte, MONTH As Byte, YEAR As Byte  
End Sub  
  
Sub Start_SD(tag As Byte)  
    If tag = 0 Then  
        Log("Start SD…")  
    Else  
        Log("Try to re-start SD…")  
    End If  
    Dim res As Byte = RunNative("setup_sd", Null)  
    If res = 0 Then  
        Log("SD card - setup error.")  
        Ready_flag = False  
        Return  
    Else  
        Ready_flag = True  
    End If  
   
End Sub  
  
  
  
Sub Add_Looped_Log(line() As Byte) As Boolean  
    Return RunNative("looped_log", line)  
End Sub  
  
  
  
#if C  
#include "FS.h"  
#include "SD.h"  
#include "SPI.h"  
  
B4R::Object returnvalue_esp_sp;  
  
bool appendFile(fs::FS &fs, const char *path, const char *message) {  
  //Serial.printf("Appending to file: %s\n", path);  
    bool res;  
  File file = fs.open(path, FILE_APPEND);  
  if (!file) {  
    Serial.println("Failed to open file for appending");  
    return false;  
  }  
  res = file.print(message);  
  if (res) {  
    //Serial.println("Message appended");  
  } else {  
    Serial.println("Append failed");  
  }  
  file.flush();  
  file.close();  
  return res;  
}  
  
B4R::Object* setup_sd(B4R::Object* o){  
    bool begun = SD.begin();  
    if (!begun) {  
        //Serial.println("Card Mount Failed");  
        return returnvalue_esp_sp.wrapNumber((byte)0);  
    }else{  
        return returnvalue_esp_sp.wrapNumber((byte)1);  
    }  
}  
  
B4R::Object* save_csv_line(B4R::Object* passedvar){  
    _keyvaluetype* tmp = (_keyvaluetype*)B4R::Object::toPointer(passedvar); //structure from B4R  
   
    B4R::Array* b = tmp->key;  
    char* c = (char*)b->data; //file name, do not forget slash "/file.txt"  
    //String key = (String)c;  
   
    B4R::Array* b2 = tmp->value;  
    char* c2 = (char*)b2->data; //test line for saving to file  
    //String value = (String)c2;  
  
    bool res = appendFile(SD, c, c2);  
    return returnvalue_esp_sp.wrapNumber((byte)res);  
}  
  
B4R::Object* freespace_sd(B4R::Object* o){  
    float result;  
    uint64_t total = SD.totalBytes() / (1024 * 1024);  
    //Serial.printf("totalBytes: %llu MB\n", total);  
    uint64_t used = SD.usedBytes() / (1024 * 1024);  
    //Serial.printf("usedBytes: %llu MB\n", used);  
    result = ((float)total - (float)used) / (float)total * 100;  
    //Serial.print("Free %: ");  
    //Serial.print(used);  
   
       return returnvalue_esp_sp.wrapNumber((float)result);  
}  
  
B4R::Object* find_file(B4R::Object* o){  
    B4R::Array* b = (B4R::Array*)B4R::Object::toPointer(o);  
    char* fname = (char*)b->data;  
  
    if (!SD.exists(fname))  
        return returnvalue_esp_sp.wrapNumber((byte)0); //non-existent  
    else  
        return returnvalue_esp_sp.wrapNumber((byte)1);  
}  
  
B4R::Object* create_dir(B4R::Object* o){  
    B4R::Array* b = (B4R::Array*)B4R::Object::toPointer(o);  
    char* fname = (char*)b->data;  
  
    if (!SD.mkdir(fname))  
        return returnvalue_esp_sp.wrapNumber((byte)0); //failed  
    else  
        return returnvalue_esp_sp.wrapNumber((byte)1);  
}  
bool deleteFile(fs::FS &fs, const char *path) {  
  //Serial.printf("Deleting file: %s\n", path);  
  bool res = fs.remove(path);  
  return res;  
}  
  
bool write_sys_log(fs::FS &fs, const char *path, const char *newline) {  
  String data;  
  File file = fs.open(path);  
  if (file) {  
    data = file.readString();  
    file.close();  
  }  
   
  int limit = 10000; //max file size  
  data = data + (String)newline;  
  
  if (data.length() > limit) data = data.substring(data.length() - limit);  
  deleteFile(SD, path);  
  return appendFile(SD, path, data.c_str());  
}  
  
B4R::Object* looped_log(B4R::Object* o){  
    B4R::Array* b = (B4R::Array*)B4R::Object::toPointer(o);  
    char* addline = (char*)b->data;  
  
    if (!write_sys_log(SD, "/syslog.txt", addline))  
        return returnvalue_esp_sp.wrapNumber((byte)0);  
    else  
        return returnvalue_esp_sp.wrapNumber((byte)1);  
}  
#End If
```

  
  

```B4X
2024-08-25 16:52:06: bme280 sensor: unstable data (corrupted I2C_DATA line);  
2024-08-25 16:52:09: No reply: ds1307 clock !;  
2024-08-25 16:52:09: No reply: ds1307 clock !; bme280 sensor: unstable data (corrupted I2C_DATA line);  
2024-08-25 16:52:09: No reply: ds1307 clock !; No reply: bme280 sensor;  
2000-01-01 00:00:80: No reply: ds1307 clock !; bme280 sensor: unstable data (corrupted I2C_DATA line);  
2000-01-01 00:00:80: No reply: ds1307 clock !; bme280 sensor: unstable data (corrupted I2C_DATA line);
```