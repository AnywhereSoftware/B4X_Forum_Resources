### [ESP32] flash partitions by peacemaker
### 07/28/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/149281/)

Maybe can be useful to work with the partition, result of NVS partition is correct - corresponding to "partitions.csv":  
# Name, Type, SubType, Offset, Size  
nvs, data, nvs, 0x9000, 0x5000  
  
  

```B4X
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Private nvsaddress, nvssize As ULong    'ignore  
End Sub  
  
Sub Init  
    Get_NVS_Start_address  
End Sub  
  
Private Sub Get_NVS_Start_address  
    RunNative("nvsaddress", Null)  
    Log("NVS : address = ", nvsaddress, "; size = ", nvssize)  
End Sub  
  
  
#if C  
void nvsaddress(B4R::Object* u) {  
const esp_partition_t *nvs_partition = esp_partition_find_first(ESP_PARTITION_TYPE_DATA, ESP_PARTITION_SUBTYPE_DATA_NVS, NULL);  
b4r_espnvs::_nvsaddress = nvs_partition->address;  
b4r_espnvs::_nvssize = nvs_partition->size;  
}  
  
#end if
```

  
  
Docs: <https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-guides/partition-tables.html>  
  
[SPOILER="but EEPROM lib do not help"]  

```B4X
'write data into NVS memory  
Sub WriteNVS(src() As Byte, offset As UInt)  
    Dim a As UInt = nvsaddress + offset  
    eeprom.WriteBytes(src, a)  
End Sub  
  
'write data into NVS memory  
Sub ReadNVS(position As UInt, count As UInt) As Byte ()  
    Dim a As UInt = nvsaddress + position  
    Return eeprom.ReadBytes(a, count)  
End Sub  
  
Sub TestW  
    Dim t(3) As Byte  
    t(0) = 5  
    t(1) = 6  
    t(2) = 7  
    WriteNVS(t, 0)  
End Sub  
  
Sub TestR  
    Dim t(3) As Byte = ReadNVS(0, 3)  
    Log(Main.bc.HexFromBytes(t))  
End Sub
```

  
[/SPOILER]