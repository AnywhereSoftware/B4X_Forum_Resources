### Open Street Map viewer - GPS by spsp
### 03/17/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/127827/)

Hi,  
  
This b4Xlib contains a custom view (cvMap) which can display Open Street Map.  
  
  
![](https://www.b4x.com/android/forum/attachments/109092)![](https://www.b4x.com/android/forum/attachments/109081)  
  
  
  
The tiles are retrieved from the internet and cached in a database. You can add shapes and images on the map.  
  
UI :  
- Lat/lng Center of the map  
- Zoom Level  
- Compass Direction with rotation  
- Scale  
- Button Menu  
- Grid  
- Center  
- GPS position and bearing  
  
Event :  
- ready  
- Lat/lng changed  
- Zoom Level Changed  
- Compass Direction Changed  
- Shape Clicked  
- Map Clicked  
- Center Lat/lng clicked  
- Button Menu clicked  
- Scale clicked  
- Compass Clicked  
- GPS Clicked  
  
Tile Server  
2 new properties :  

- tileServer : Choose your tile server (see <https://wiki.openstreetmap.org/wiki/Tile_servers>), default : <https://a.tile.openstreetmap.org/>
- userAgent : request to the tile server requires a user agent in the header. You can now set your own user Agent : default : Mozilla/5.0 (Windows NT 6.1; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0

This 2 properties are available in the designer or with setter/getter from the cvmap : userAgent, tileServer  
  
Dependencies :  
- Core  
- SQL  
- OKHttpUtils2  
- XUI  
- XUI views  
  
Other files in the b4xlib :  
- coMapUtilities : code module with Types, functions, helpers  
- clTileManager : standard class module to load tile from database and/or internet and save them into the database  
- clMapShapeCirgle : standard class to draw circle on the map  
- clMapShapeLine : standard class to draw line on the map  
- clMapShapePolygon : standard class to draw polygon on the map  
- clMapShapeImage : standard class to draw image on the map  
- layout cvmap.bal and cvmap.bjl  
- images for the compass and gps  
  
  
  
How to use it :  
- Just add the cvMap custom view with the designer  
- create sub to handle events if necessary  
- set options (lat/lng, zoom…..)  
  
B4A example and B4J example included  
  
  
  
spsp