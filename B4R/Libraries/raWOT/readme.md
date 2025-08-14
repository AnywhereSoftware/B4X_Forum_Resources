### raWOT by candide
### 07/29/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/135993/)

i was looking for a web server working with B4R and i found a good candidate with aWOT library for arduino.  
  
result: raWOT is a wrapper for aWOT library from Lasse Lukkari  
 full library with examples : <https://github.com/lasselukkari/aWOT>  
 full documentation : <https://awot.net/>  
  
with aWOT we can create a web server working on Wifi or Ehternet, and on a large panel of boards.  
aWOT is able manage GET, HEAD, POST, PUT, DELETE, PATCH, OPTIONS, ALL, USE  
Under Arduino aWOT can support multiple clients, but i was not able to make it working with B4R.  
  
  
  
raWOT handle 99% of aWOT library functions  
  
tests were done on esp8266 and esp32 with Firefox/Edge navigators on a PC and with B4R project "testaWOT" in esp (added at Zip)  
summary of tests done:  
 - redirection page to page  
 - get  
 - post  
 - upload of file from PC to eeprom esp  
 - download of file from eeprom esp to Firefox on PC  
  
  
i think we can do a lot more with this library, but i am not expert of html/javascript.  
  
i hope this wrapper can help the community and at last, it was a very good exercise for me  
  
21/11/27 new version with option to send html code to library in string or in arraybyte  
 included 2 test codes with direct string and also with strings stored with PROGMEM  
 in both cases, it don't take more than 200bytes for stack  
  
  
 with current library,  
 1) each connection client <=> is closed at end of actions planed in webserver and an other client can be connected  
 => we can manage several clients in parallel  
 2) client IP is provider to B4R interface  
 => answer of webserver can be depending of client IP  
 3) a parameter <head><meta http-equiv='refresh' content='60' can be added in html page and client will reload the page every 60sec  
 => websever can know clients connected to server  
 => with the 3 inputs, we can make basic multi-client in webserver side  
  
  
01/07/2025 new version of this library with some improvements to simplify B4R project  
examples :  
 aWOT.app\_get("/", "handleRoot")   
 aWOT.app\_get("/readADC", "handleADC")  
  
now files (htm, jpg, png, css, js) for webserver can be in inline C, or in index file or index.hm.gz in lfs  
  
a few examples are added :  
 - a test with ajax to update variables in webserver without reload of the page  
 - creation of a lfs webserver with ajax and in different configurations ( index.htm can be in inline C or in a lfs file or in a a gz file in lfs)  
 - a webserver with a memu  
 - a config manager with a save in eeprom  
 - a webserver with a gauge  
 - an webserver with an other gauge  
 - a webserver to show png files and jpg files stored in lfs  
 - a weather station example  
 -