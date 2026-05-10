### B4XLib (B4A only) json viewer by spsp
### 05/06/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170954/)

Hi,  
  
![](https://www.b4x.com/android/forum/attachments/171402)  
  
A small B4XLib library that contains a custom view 'spjson' to display json data.  
You need the [GestureDetector](https://www.b4x.com/android/forum/threads/lib-gesture-detector.21502/) from [Informatix](https://www.b4x.com/android/forum/members/informatix.22203/)  
  
1 method :  

- load(ajson as string) : pass a json string as parameter

1 property :  

- itemHeight : get/set item height, all texts, symbols…. are resized according to the itemHeight

2 events :   

- click(anode as spJsonNode) to handle a click on the name/value of a node
- longclick(anode as spJsonNode) to handle a longclick on the name/value of a node

The class spJsonNode has getter to retrieve some informations like 'path', 'type', 'name'….  
  
It uses a B4XCanvas to draw the json tree.  
  
you can download dummy json file [here](https://sample.json-format.com/) to test the library.  
The library can handle large file, the only limit is the memory.  
  
attached the B4XLib and an sample project (jsonviewer.zip)  
  
Spsp