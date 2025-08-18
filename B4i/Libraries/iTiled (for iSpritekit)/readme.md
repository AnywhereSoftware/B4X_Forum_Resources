### iTiled (for iSpritekit) by ilan
### 11/20/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/84797/)

hi,  
  
with iTiled you will be able to import Tiled .tmx files to your B4i (iSpritekit) project.  
it is much more simpler to create games with Tiled.  
  
you can even create menu scenes or shop scenes and not only the game scene itself.  
  
what is possible with iTiled:  
  
- create single/multiple Tile Layers.  
- create single/multiple Tilesets with same or different tile size.  
- create single/multiple Object layers.  
- All 4 Objects types are supported (rect, ellipse, polygon, polyline)  
- polygon and polyline will return a List with all vertices.  
- you can uncheck layers to exclude them from importing  
- very good performance!  
- use custom object properties and import them to your project.  
  
object list returns a type object:  
  

```B4X
    Type TileObj(objtype As String, name As String, id As Int, x As Float, y As Float, width As Float, height As Float, rotation As Float, vertices As List, myproperties As Map)
```

  
  
using iTiled is very simple.  
you create a Sknode that will hold all tiles on it and will draw everything you created in tiled.  
then you get a list with all objects and create of them you sknodes with physicbodies (like you do in android)  
  
first, you need to initialize the sknode that will hold all tiled nodes:  
  

```B4X
    'Initialize Skspritenode  
    myTileNode.Initialize("myTileNode")  
    myTileNode.Position = Functions.CreatePoint(0,0)
```

  
  
then you initiaize iTiled with the sknode:  
  

```B4X
    'SetUp TileMap (TILED)  
    iTiled.initialize("level1.tmx",myTileNode)
```

  
  
after that if your tmx file contains Objects you can import them by going in a loop through the public object list:  
  

```B4X
For i = 0 To iTiled.ObjectList.Size -1  
'….  
Next
```

  
  
**VERY IMPORTANT:**  
  
- .tmx file AND png tileset image need to be in your Files/ Folder (not in Special Folder!)  
- use only CSV tile layer format  
- use only "Based on Tileset image" (and not collection of images)  
- draw only what you have to draw. it is better to draw the backround without Tiled!  
  
this is a beta version so if you have any issues please report them and i will try to fix everything.  
if you like iTiled then please consider a **[donation](https://www.paypal.com/us/cgi-bin/webscr?cmd=_flow&SESSION=4YBYv66onmpaDwIkSCV0Ry6TJ9vjERHYc_JfjH3tUDtiDitka2bXf6FbpVa&dispatch=5885d80a13c0db1f8e263663d3faee8d795bb2096d7a7643a72ab88842aa1f54&rapidsState=Donation__DonationFlow___StateDonationBilling&rapidsStateSignature=c9b9b6ed5e764e650abc0fc2f82c94af078b026e)**but this is not necessary so iTiled is free to use :)  
  
if you have a local mac then you need to copy the .a and .h files to your local mac. the .xml file needs to be copied to your windows library folder.  
  
if you are using a hosted mac you need to copy only the .xml file to your windows library folder and wait until [USER=1]@Erel[/USER] will upload the .a and .h files to the hosted builder.  
  
thank you, ilan  
  
EDIT: 04/02/2018, i have updated iTiled and fixed a lot of bugs. i have also included an example that loads correctly the created objects from your tiled.tmx file. you can easily create physics bodies from those objects by using their vertices (path), width, height, x, y,…  
  
[MEDIA=youtube]jgA\_1L9ZNDA[/MEDIA]